Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823093D668E;
	Fri, 28 Aug 2026 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900014; cv=none; b=R6QnqkhUhOfmjSCtB5FV2wIy05VhkW+MQmoBI8PS8vqZe/OBcklhw52k8tkmcnDmkxdTnHGmyQQ9tW/0Cb24vw3QHvIkY7GXZM2+dSDd+fQDN7hMJNM7781fT8eIcGLoiLmoc70VE53EiS6MmUBxTxacuD+MSy4RJsKvUw6EY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900014; c=relaxed/simple;
	bh=0t/6RujQl7pKW2vfqLUtqrB3bLqQAY/xJbFZgbmKq98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMhnY4TfzHdOnxBl/UKo4jhwuqoqaId1R8EHkJCzrQWustcDqKvSeSGZpYWbHdZn2R++VJDxYtG68bBWENMRw46yazKibRTE0UK/2POgbmGbEtTtzyTaAnj/v6ZnzCueVffu3bSu0S1gkwBaPVbQC78h8YM6YKy5BH5u+enxKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0zOyXwuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0zOyXwuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9E11F000E9;
	Fri, 28 Aug 2026 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900013;
	bh=Nj0pipNvV9lb4EzESIdp3uIkaAvjUHUZoZF21yeqrK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0zOyXwuXr+8If2OdiAYUR8SBgnPO3b/6+at+TtZ8vdZIsVnn2FYa6hnerVOHrP1hP
	 MmrjYOlB+hzzOwftz03B8gCvgamrAr0XNKtx7qMBVh5dZ7aepk3N2QeESFjEBJeX9y
	 1AdI/MXIZzjGF8QqfbDQSKo7s7JUTGagoc411CRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.18.48
Date: Fri, 28 Aug 2026 08:50:05 +0200
Message-ID: <2026082805-creed-decathlon-f49a@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082805-detoxify-lantern-c996@gregkh>
References: <2026082805-detoxify-lantern-c996@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 81053b878665..f40baa6f6c23 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 47
+SUBLEVEL = 48
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 6eeb47f6dbdd..9672d80488d1 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -437,6 +437,13 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
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
