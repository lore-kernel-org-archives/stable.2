Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817846;
	b=oUGQs/AO1QQBXUpY23+k0IcLGWFpezlzFdqiiaoleuGD+2+hXEA++fqqRn10nJPoT+l/
	 uEaVBhY1nF4n8nZNAGNKissDu3v38QtPp6T31AzLhMpMFZ1f7EkjeaYK0KznNFPN2plKb
	 +P7lRTcVVOBPYgbtX6qmo6zu3i8KAe11am2APh3bMPBZ+1cAzGl0s3LlZ7LzYu2pRRGox
	 cMh13HNGRx5Ry1RpqMR4bMjHJxyeNBR2Al0j5f1L9cu0mjnn91OCyzrkjl0wzcJ1OR2dz
	 hTh8UV6kYSnmiWmdOtr+vqYtIBzlLK0MN+RUcFqkmRf/MG+MfXmJ+BpRaizQQfTUZbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BrZU+RcPkwW02N/LjfZFHHBcEcuKXqXoi25KpDPShzQ=;
	b=yB0hLH6l0WAxxtasSNPEDRMqE+KC7xPmQ5slCOZV/ElwkFoXx1Lklvyl91TztQ9PLGLF
	 pgwL0myG70eEuKXryjWnLcK4Eone5M7SEgsNGn/Ozq6U60VYXuRCl2Mh4lyUc/+pQwQ9I
	 PAFgcjCbLdWzTftVHYvA4GRCUOJGVbTos0LAAk4guBIVJmtRlmP0Soo/Xrk/b9dzLurf6
	 GK/S7qQxi1CyTNh0DOuMggx8B1ion5z9Cq1yscpE6hIduwtv4Iuz+ntZxDWdzdBdJwlO0
	 eu80cgfX/m8ZhdJXU7cNc7kd53sRzpRM67YyLks4wVOl/2qs08QF5l14lHiZSPm0J7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l8V42o4X;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB5606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AACB5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l8V42o4X
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8446af403b5so651246a34.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817845; x=1794422645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BrZU+RcPkwW02N/LjfZFHHBcEcuKXqXoi25KpDPShzQ=;
        b=l8V42o4X2Kly4lLNr2ygD8643gTVHt7mUwUvinAZkYbpU+JsML70Bgz5MBY9EM3qXS
         gF0WXXKXAf3S5Ercc8rfYHeqVpvgQuETftoTJFFly+/FZdJPxAs1pK5BlA0WYu4FEt0O
         qumAgqDpBdU3pnN90k+1oIJZ9szidQRM+C1C9o3xVE1w2S2NiEyyarJqSK/vv8T3P2ct
         7tbfJ3D5VBITA7eGknQeF99Yo6Wr9E6vhR1sAqmimx2JjHRAijkqQsvXm1VFdr+C4Hbv
         306nkbGHT5X5Cb1teNBrDDI+6dKg7smXw3nX8ybaExwkCrNHB+m/xKcE9wgSzUfwtNfu
         IRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817845; x=1794422645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BrZU+RcPkwW02N/LjfZFHHBcEcuKXqXoi25KpDPShzQ=;
        b=Rq+eUAQHYdXvSxgAR1SNbjtmkkK6rXwtyjFcFa/zZAr+Cv4jTkfqiqtJMkfFI6P+L7
         0RJGeal6I4xEBMXe+4lOEurFi9E7IZdQWKdR9YlyYCojz6wMGWPevGyDKoCgcNlOGopN
         qqptc5iwqm3av9SQqEerKxA6QkvNcF1hBoFjQ44S4S4YMN43XgcA/Z36GmzWSgkk55ig
         nzQJQXDOdy6oDWSONEpP+MoQi6uD7DxLiqEnT3A+BhwHBMLCo2AZ2JpgfGMRKU8EO/H9
         yaJwx+bpTxuULj9JMwJwMjWtM1fVVvAEZwW3qm4q31aWAxxV0x0T6W0iG9v5jI5f+LDs
         BmwQ==
X-Gm-Message-State: APuU4Z/C8ntyiwWi8QO1X+DLTob0HKF9SJ0W5Xc6XHbx9YqVdc4yTBQR
	0Sjww+zcNGQzgmK1kH0lH/PbEN+roOcB3IMRa2BSUdqfdHeMkD5heSWqn/Q5OvskxqEHuiByfoC
	6wvSGPEU=
X-Gm-Gg: AYBFou2Zcqim+26zih2XjsXDbJlH3EiH4ovAdUFl3DkDF3AyEUzhZ2wKt2oa/u55xLW
	O6+zLFVyE3kxKFCiQAhxh/Y+TxXWxm5FSkFuJR7hZ7NMBiaVJ65WvnyTcYCq+EbAYYJSUMQtURv
	jDEwFXy2XSs+WEn5Cm7HUNA90J0TbaQX4JOeqQp5QtzQJU9RZl4BvUnmEYWsqSdCZsyr7S74yD/
	8fCENdhqyZqbNgfApQ+3MTwf+GMNpOCTHDBpBw7zK+T/9ZUSMfqXlVPAYvYbhBZPk1PBdxsqozE
	lAhtt3qfLjQeotaFCFU1LiMPgW1DOT51Hsq/7pkJEPl2bMFq1l3lYpIf5XaZsIkrzpPaIB9Y6h3
	MIAQ+UPW9XIo+Ztus+CF3dkhvpphFk8wKekkKX0gB7dMPR6GJQWEStFo9VIacEOM/bomTRlpJNM
	frubTL3Y7kjjhEGZWO8cVrnBeNuFFBNY0TSIlv9Ym2xaW8w6xmpKPg1tmE2guFr82W+Yqb6bXNp
	MIo7GJO0bcJyBjMnTIkea7oRXJGEcsette6cRUWFdk9voI2sgdi7vNoAN37mrQPSGWBpsTrTXOQ
	41n6lcs/MJWphSgsupfnfRwk0pLbywNq4xGdSyQjfLEI7cTpZR/3sXukC0PWpKnK8m1YNkjQBw=
	=
X-Received: by 2002:a05:6808:1a08:b0:53a:8c5:d7d6 with SMTP id 5614622812f47-5640d91b2f6mr12025743b6e.6.1793817844622;
        Wed, 04 Nov 2026 10:44:04 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.44.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 5/9] io_uring/rsrc: charge buffer arrays and nodes to memcg
Date: Wed,  4 Nov 2026 11:43:49 -0700
Message-ID: <20261104184353.516403-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184353.516403-1-axboe@kernel.dk>
References: <20261104184353.516403-1-axboe@kernel.dk>
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
[axboe: 6.12 predates the rsrc node rework, charge the imu kvmalloc()
and the node kzalloc() instead]
---
 io_uring/rsrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1687e35e21c9..ad7ad35545d6 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -183,7 +183,7 @@ struct io_rsrc_node *io_rsrc_node_alloc(struct io_ring_ctx *ctx)
 
 	ref_node = io_alloc_cache_get(&ctx->rsrc_node_cache);
 	if (!ref_node) {
-		ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL);
+		ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL_ACCOUNT);
 		if (!ref_node)
 			return NULL;
 	}
@@ -982,7 +982,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
 	/* If it's huge page(s), try to coalesce them into fewer bvec entries */
 	coalesced = io_try_coalesce_buffer(&pages, &nr_pages, &data);
 
-	imu = kvmalloc(struct_size(imu, bvec, nr_pages), GFP_KERNEL);
+	imu = kvmalloc(struct_size(imu, bvec, nr_pages), GFP_KERNEL_ACCOUNT);
 	if (!imu)
 		goto done;
 
-- 
2.56.0

