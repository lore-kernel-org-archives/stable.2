Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A453DC878;
	Fri, 28 Aug 2026 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900009; cv=none; b=cjgfnobJNsf6rjnGE9bgnuRnUIp6CSh6IaO3kIGGu3j/xRfp3WkyUG68P59MBeqsWx7ki7lKH8M5zZIwDWkQUb+LkmTzcglTLW9Wrksh4jjcewvhFXusCwTa1JQO92TM02DMleDzZdiPd0vtc05+ByiVg0+BWfm+zaNFvn4COfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900009; c=relaxed/simple;
	bh=dfUItArVWGO/brTsVUN8c0acKmUyhhL77mGvIdJFRFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tixRERwy7XBQZOPSsZkCaRSIzGYHlmvbnmXnAlH+15b16zMBKip/UAi3I9RO5s8ov5X0eVCr7Mdy9HHXzTGqnL54x2innoB6oyDFCoyhOoJGcGb2hQE4HLW5CJyaos66t31bjIX1dXgh39l6jL/bPWaQ0l/93fAGUjx9Qk7GAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsihsEc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsihsEc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED031F00A3A;
	Fri, 28 Aug 2026 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900007;
	bh=sqPglnPd/ozaFVSE4GLYgyBCrX0bJJb7Hc6mdtmt0Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsihsEc1MAPhcPaOnVUVeEa97YXCdegfamqB2kUsjd3EvD9LxrcloIXTnfRqDDjpz
	 7vgTov27EniwZTxBRkkr9Qvzd2k/OjX8HkZZ/uB33ONC8L/1cDrj3eqPyWriERIuOa
	 AQEKVej36pRCSXVnY9VMF4btvFMVZLXsKneiWpsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.107
Date: Fri, 28 Aug 2026 08:50:00 +0200
Message-ID: <2026082859-dividing-steerable-7ac0@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082859-lake-stuck-2d9c@gregkh>
References: <2026082859-lake-stuck-2d9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 957003198a2b..18d3abab7dcb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 106
+SUBLEVEL = 107
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index ea3f15f59c72..09d208cf8b1b 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -435,6 +435,13 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 {
 	struct sk_buff *last = q->fragments_tail;
 
+	/* An IP fragment is never a GSO packet, but an untrusted source
+	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
+	 * that reach the reassembled skb, whose head keeps the first
+	 * fragment's shinfo and whose frag_list is not GRO-shaped.
+	 */
+	skb_gso_reset(skb);
+
 	/* RFC5722, Section 4, amended by Errata ID : 3089
 	 *                          When reassembling an IPv6 datagram, if
 	 *   one or more its constituent fragments is determined to be an
