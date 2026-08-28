Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201833E360;
	Fri, 28 Aug 2026 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900000; cv=none; b=rHjghUoMPM+Y8O/g571qM6VGjX91AXpDuhjAZicGj/G1Sz1Y6OwIHANvBurlzP0ccIArB7eNn5tsUtbmZ8JRgu16vAfkpUvIK809KWrhE7+Eqz8fl2xaCVy98I0Yl5fh4M4n9A2CjUIovT/5Mnx9fCtfWNMOvxPz4NDXE+mjboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900000; c=relaxed/simple;
	bh=O2YSVDaG6/IhIaWmBsKvQwpQJGBr00z8FlsljnMoIjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvP0H4pUgER9hZ0RrM4VCahcw632/ASuMg/W5goESkDaoOPh9zBHjQE9LO7K53C6n8pMIFAuM8VFm+3atmfGV9PPY2Tz+gnoZVphIKbpQYqR+X+2hceRp1FGbp2QzNoKSCD0KfxdbEjZXt/4F0RDxg5CELOa6X5uCYp2YdWwydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EY/SBZJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EY/SBZJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D2B1F000E9;
	Fri, 28 Aug 2026 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787899996;
	bh=a/oKmYcPetHn5PUKcxWyjsFT3dtBD+PsSwmrFvUuVP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EY/SBZJzCj/CLM7dJch4Z1nKTwy4sfkcK9r+MoTQ+vsvFrAq4JIJdD97bEdLMC7g3
	 xodJlRmzV7i/EZzuJtG8IwBkn8F9vALRjfwH06R/yBFvs4mcVfbuAmM8mV9Qc1QQrI
	 SXlTjNICMzAiv7OIX5RB7QdFKsXVjKqiRbYVuQws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.186
Date: Fri, 28 Aug 2026 08:49:33 +0200
Message-ID: <2026082833-blah-rimless-2750@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082833-disclose-numbing-29e5@gregkh>
References: <2026082833-disclose-numbing-29e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 6f596e155f7b..4d31942b6800 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 185
+SUBLEVEL = 186
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 0cfad7ab9f96..9586bbbe92f9 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -384,6 +384,13 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
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
