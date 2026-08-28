Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012003E1CE1;
	Fri, 28 Aug 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900027; cv=none; b=qpKwSGMRQcqTXUXhClfVyl5fK1B6e227YFRVHkLVSnWI4Cpa4m4AdCV5cEjKKgSTZwaFj9Qev4s1w6cXZ1C12BlAHa7KPhl++e/F4TiLkGpRVOU8mSrp7yjUAaCV2ZOh6O3Kx3+G4Pvwo3I1fPKrCmUlNAQ9oqylQ3ZqinNHEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900027; c=relaxed/simple;
	bh=lI99QbMP0bYjSpL4EoedwZ9m5GGExcfFcwCbwE9xAYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie5bQtWj3WWut+AqdguBAa4FQrTucE0iIistQ6k0UobGq1vS9vExqhVd6PjCAkhSONwfhrbjFZN1j+BAI8Ut/m9v8Obt2xPoI25EFRE6Rnb5Av4RBgvPyyIwDe0VkllcccJQKC2xjvKjV9Cojjs0eLI46eFbGek9J1NUS8O5n9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bt56W4kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bt56W4kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF981F00A3A;
	Fri, 28 Aug 2026 06:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787900024;
	bh=xoItmbxkzYd7lOUAj3Jgrn5ccCrdTpSl2cP/nAwczlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bt56W4kjkWkG/qAIW/rr4exgwroMApKJuEpaXsyx6XJnNvhJa4aJM65YcCxCPMGW5
	 B0YSapHOEnQEF1Sg3GhM3cvnqd60j6/+NsDkMOnrGcrpauVjkl+UMeIgBff8hLXjl4
	 DvFjupSuwvzx2+o105ksHAyrKz2MvlVxCJnWBZes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.2.2
Date: Fri, 28 Aug 2026 08:50:18 +0200
Message-ID: <2026082818-quarters-ultimatum-5d12@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082818-celery-dizziness-dd1a@gregkh>
References: <2026082818-celery-dizziness-dd1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index b36422350995..ee964fb0c056 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 2
-SUBLEVEL = 1
+SUBLEVEL = 2
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index fc0cb993959f..c17e57ec7d5c 100644
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
