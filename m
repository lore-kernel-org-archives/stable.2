Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E93D3D00;
	Fri, 28 Aug 2026 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899989; cv=none; b=KmsVd4FSvib7HfZuLZlcep8tRrIzaMSFFGNFjKoDsl51ta8+V4mfVvsvygrUpsSzYdaHL/2hsUtEby8Zoap0MkkN6ieWMCp8ejXvCaxTvBkwQsC9/GQ1x+IXTni5SOusj6nbk90p91TbjZlsqqLgOe0m63KNc44djv1EnmAehqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899989; c=relaxed/simple;
	bh=5VWixd1GC5aGL/nKnZLSSqcvTRRR5NNsqyqfym6g0gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKIdK64Pq4XzHwdmSqEAEcnwWnC8piVndmQCzBNcBdEA+JlJHmZ61eyUbRJJKYGuzVFAVXvGXWgiceq1223OC2f1CfwfU71ZuhhoJsJBn4Com8fYUTcweOZ4NQx/QXB8gxCocQNGOzkE1VL9Vrc26Pk7sc/Tk78hDkYvlwiUwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bnIJHvfd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bnIJHvfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DCE1F00A3E;
	Fri, 28 Aug 2026 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787899985;
	bh=JobmnFMuJZKLxmIn5h6StP7Ke2boBLRKDaHfOTmKDR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnIJHvfdaLDskvLbmR86qCgR34AQ/LFY/H9oMwDfqF0pYXJk/Jt6b/x5FDuB40XGJ
	 xvxfoU/i7otMWcygAXYTBdqJq5Mj55V2EzkLjnUW+lJaT8LVmr6GEDZLA8HgzUkXdY
	 Tp9p7ndheNZFZUuISs2CDJbVWqvDdLkWQDGWMvvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.268
Date: Fri, 28 Aug 2026 08:49:20 +0200
Message-ID: <2026082819-underdone-snooper-ee9f@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082819-mummify-reconfirm-f189@gregkh>
References: <2026082819-mummify-reconfirm-f189@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 3e1b204d5291..0aadd120b6f6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 267
+SUBLEVEL = 268
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 016b224a17e5..18217537cb29 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -353,6 +353,13 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
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
