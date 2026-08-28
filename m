Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BD3D4119;
	Fri, 28 Aug 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899994; cv=none; b=MVqDA9/aGfqzPMrwbbCOtRREqw1I3jrE6U1f8pTE58mGA3ytaDAhVpFc+RO3IblLQ4s2/tTmfRr4vWuBLwLIQ6NYhjGR74WkL5GJ2yT68u6eOw3IWP2rk1qLd+6y3MIHGPmxyXmD7799UKr+1x5zyLWqXc5Ej3EM132F7dbJWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899994; c=relaxed/simple;
	bh=wtKVJC4Unc97CEohmGNB8ztybcB+BsLp7Wtz9ep9fq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6Ui9J8nvmTwbdkXpS6VHNmmdgpQ/aPZzFWbcHyUXF7qPsrM7UUXa9koqfstlavb/R02q2E+DyCLgqZsAjxcg8G2LMMlmgXqI/9ZIJOu2gy42odFcAtAmygXoAg7PF37oEbBKw25KTbR6NAG61b+Jqhgh/UuoQD3oKkizFF4Z3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y0eGbW9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0eGbW9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DE51F000E9;
	Fri, 28 Aug 2026 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787899993;
	bh=9+S4bc4iVGK4FXCDTtB1q32fAl3V1ONUWSDGoisHMIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0eGbW9FOet+dioiMnm2G5bs2AMB0FBFUBzspwsI4k/KBQ0gjhZs8lOjpPqbaAOnm
	 8Y8AMnzMedVFJhHg1oI4E7erequUGXPEcoAlCs0rAE0bRxKX0kF6QgwLcX3+hoYe+P
	 9/0zjwopHIt6Kawacxe+SLsyCJJv5lGVL4EGwR3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.219
Date: Fri, 28 Aug 2026 08:49:27 +0200
Message-ID: <2026082827-laborer-relish-a0f6@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082827-mankind-mandate-ca8f@gregkh>
References: <2026082827-mankind-mandate-ca8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 9d11ba195a16..d74985973e40 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 218
+SUBLEVEL = 219
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 7922b10f360e..6e6b46ebfc40 100644
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
