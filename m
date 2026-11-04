Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817815;
	b=PR/MgXmz92B7f8eZkYjj7R3cljx90RIUd6SyaR3qbtOzbfrT3iIcMuvFcC/prT1JEYnF
	 18IQwhc1gDWCPl1xC0jtN/vxV0wnfq+Q/RP3ORYu8dDnnzlKMN+ht7mCQK/cEQqABsBHC
	 0So99NrPDMWuUtIgog1wjMe7rRsJYqXAthWs6rBZZTbVZAUrQAqmMCuWi+T0AL/Gq8JwL
	 9754HP/MCgC1DmT+0coqkAOHtBNM5xDi1umfnaWoN4Uk6mmA5/LCWLse/N5TE+Xuev/sA
	 7pnVLqXJOvIssv2xbaansolWv7zeiCeFtGCDWHBs0K0gxy9PVytqq8NoOE9s/n4W4tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/NCC4TGuyuEAGEC6mAICmjnkTF1YikNhB1HuA1+vfW4=;
	b=I6mMDTMuMjLffvt3nijxo1LP6bAeyOCGcZMHpTVBmApyqjT54om6+YdQEXmPXHGYijzF
	 4r21AGt9R2oSEr3vTEZGIVoBopwm/9sXOGy/ng91IBqlslLgwAfKXwsBq4J7G7jhhGEck
	 aA+4/Guq9oaRYT4b4qgf27KR/PEiqQXVvP2X6N4k1vRXfiBOqW5Nw+iyKF60fy9526J4M
	 55qIStGHVRwOAfoQteYoZKonPyZJQtQYDku3nMbKDZCNMxriHjbzwS49DaFrNH2X6lon6
	 pH4ig2UCnbeqRUa8OFMrwF0eZcrnz5xetlN+uXl2/7SEKhPdaThC5FLG/BAnPboFrGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rgvd5ZyK;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305E606A335
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2305E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rgvd5ZyK
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-845f3fa7f38so435352a34.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817814; x=1794422614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/NCC4TGuyuEAGEC6mAICmjnkTF1YikNhB1HuA1+vfW4=;
        b=Rgvd5ZyK9ER5RdsFYSgtck8DkyUsJh++jsIz8BRWWS3TrrxLwUR7LLz33A/4C6tFBn
         f5KOodfnlyGnc1sa+dl351vGsL9wUmoc2zhC51OyhBCmH2q7ZofukkOOauFl/Qrf7JKu
         MJyH68LWgthd1ezB47uPzsYBZAtRR9IVSiT6Gy9QtdoZBhkGu9xXrLDhBshHxqrQpnRj
         46AcZ69ubJij4guhD+wVTkY2LJEC96gpL27uSyExmZN/EjE4IKQvmJ5iyz4q4fgwYbc1
         H7wuYcfD/XjD0aF7u+hniSppGMdlrVUzpW56th0rVw7vg9Xphez1hTFX40TNLKxsCBnZ
         Csqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817814; x=1794422614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/NCC4TGuyuEAGEC6mAICmjnkTF1YikNhB1HuA1+vfW4=;
        b=bI+/z8oAT8fk1KUh7c8BrYMO46OMxiSQ3lxbYI+HjdTumWYeTWRIuTeQ0Ue22d6YWM
         fIQz2Go14Ww7EQbFZs1KOlBIBtScjynwLIZYwnL7kpoFViKSj+X2Bw5BO9Lrwwq0oCAp
         BrqPdyPMVuDC5hRgL8+AvRBiO6WLDRKm38EOnL6XZKS/Ms74aeOZ3ihdc2oQKvoUSC21
         Bu8r/JzX+s8xFM8mENRAwgTIDtSMIRr0ydxeFc8EkfSyrcywi8xYedkupr1z5cy6YmxJ
         CPwocX1DepvqFmv2M1/JUi0Kut9YCfEVFev36x8VQkXRYeDhN5ZrUbDOtIaPfwwo5eWH
         6RIA==
X-Gm-Message-State: APuU4Z+h6ewZxlwnyE9WixgiVT5WPQ7m8d1bm3boSaPsoiLyu7pYK6BZ
	gEMst2zAVQF8QG01b9/DnQnspyKJLjYQMDoWGmPdiXWnrhy0ySbHBF0zTb8WjZTNWvwBK3E3xNu
	qfuP0adU=
X-Gm-Gg: AYBFou0I+LAT9jk0taf+m9ybttPUp5U1zj/JpooYc1mT+rDrp4XkgM81YUEM9OI89E8
	/ToY/PUked9Aj2/0Osddpye8JLcxXq0k7qnGHqOrRQyCO9iD/cQYo6FxxJERznf4MA4QLqfhwnB
	U6c2Vg27KpYZKjSu2VO0t/gR0d506c3M864eSzDzPMyEDPTyy7QrKDMN64VnaUzFQoDgCP6vB1W
	pbA4RDXnv6bToHdV9OafOj+F7mxez5ahdOEQtuU9OZhx9AM9sY/sB7UwHDi/VHd6ZtAd2VgNULF
	SIS21VDhv+9NgkO6Iygavm2II7fWCDUYhTGrebFIFPXMrjOXzCJJy/E32jcBakyxaJJFfk68x5p
	smoZycoeKvB8AfiUlpgCXh82B1A0Aeveo4MLGb1swZ6RRpQFTjVUn8FtrYG0J5O9KiNp1jliH6t
	uzmplxPCbR6liifIsIssoKEiAKEAKl34H7Sv9AlGwbTG18P1VwsPkSOTN6KN+w23PSHZqCqb/0q
	BCC5j3V8WCsB+e0v7Tbi3xOZqmz9pBgGzYi+cvS1xCrDohhttkmXhb6yCL75jcrBvAIcOu7tL0+
	5/5V6NiDsEq8LbGC4omtPF9KcLJTWkB1857MIuw58nfGp+N6JTqQf8IYnp0QDl5YMu24eezMTQ=
	=
X-Received: by 2002:a05:6830:2308:b0:81b:864b:7f02 with SMTP id 46e09a7af769-85d362992d1mr13707496a34.2.1793817813790;
        Wed, 04 Nov 2026 10:43:33 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 4/8] io_uring/rsrc: charge buffer arrays and nodes to memcg
Date: Wed,  4 Nov 2026 11:43:24 -0700
Message-ID: <20261104184328.516206-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

Commit 075d5837bafc317e796548f721b8fbf7add6821d upstream.

The io_mapped_ubuf of a registered buffer has one bio_vec per page,
unless the pages coalesce into huge pages. Huge pages only count against
RLIMIT_MEMLOCK once per ring, so a buffer that maps the same 2MB folio
over and over in a way that defeats coalescing gets a full bvec array
per registration while only the one folio counts as locked. 1GB of that
registered in 100 slots took several times a 64MB memory.max, with 2.6MB
charged.

Allocate the io_mapped_ubuf and the io_rsrc_node with
GFP_KERNEL_ACCOUNT. An object reused from the ring caches stays charged
to whoever allocated it first, same as the io_kiocb cache.

Fixes: de2939388be5 ("io_uring: improve registered buffer accounting for huge pages")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 predates the rsrc node rework, charge the imu kvmalloc() and
the node kzalloc() instead]
---
 io_uring/rsrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1c5abe2dcd5e..6fd3dcaa3c42 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -250,7 +250,7 @@ static struct io_rsrc_node *io_rsrc_node_alloc(void)
 {
 	struct io_rsrc_node *ref_node;
 
-	ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL);
+	ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL_ACCOUNT);
 	if (!ref_node)
 		return NULL;
 
@@ -1068,7 +1068,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
 		goto done;
 	}
 
-	imu = kvmalloc(struct_size(imu, bvec, nr_pages), GFP_KERNEL);
+	imu = kvmalloc(struct_size(imu, bvec, nr_pages), GFP_KERNEL_ACCOUNT);
 	if (!imu)
 		goto done;
 
-- 
2.56.0

