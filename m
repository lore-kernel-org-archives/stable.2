Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E993DA7E2;
	Fri, 28 Aug 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900006; cv=none; b=WU5GJ4+6ARJNAgIhren4qE1ocdS8F4g1LTnf6B2SVSlPQqViGDjhA1gG0tnt2JbwT64Ap4Oz4aNcKJO8BSjxQDZnayek2XlCKyJ5ir9Rf6I4Q/Mr1atWKYKpq9xaHcdBO9rTrQuIrzFGC3+avgUYhkUwJPNukhiC7GwRpOKbRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900006; c=relaxed/simple;
	bh=1XAg1UNAuM5J1lTXA78Sr9AdToxmTa0HuktmGi0WZAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STK6OdRsXZbVL9mGa4P96gc4ULxwuGFSDmbqA7coaklfUd1mIZWboVeTMoUQgMDqg5julDZXuZ0ebVxQm2oJ3tUxXiyv2GQE/w7O0wjDdrUlXCuqzm/dg5UkEPnh6sXYpFwi3/AmG3nFKuNF5WxeJVevGNX4A+yePROntZNZW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TRhcNpWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TRhcNpWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCA71F00A3A;
	Fri, 28 Aug 2026 06:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900005;
	bh=NzYFRTNbBony9kPQEtor4tbAUZ8d9vZGk9phY2tTykw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TRhcNpWWsDrw2hwOv35lek7QcGUcBeNEH72vERJ7t8EfgSVf+sGbLM5c7gMxBqyq4
	 VU019SOZ2c0+fXA2w1HJ5hVF/NtJ9hsnRPxHNNHH+6l83SW4Iq1fEu9+0M4tXgP0EG
	 CxKN15ai2Kq+fU3kSSL9/cq1BWDPrRWxtxmtdXCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.155
Date: Fri, 28 Aug 2026 08:49:41 +0200
Message-ID: <2026082841-cramp-lark-5e0f@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082841-endnote-stoke-44df@gregkh>
References: <2026082841-endnote-stoke-44df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index f196561476c3..17803a7f6f30 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 154
+SUBLEVEL = 155
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 1299413bc980..3b47126d606e 100644
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
