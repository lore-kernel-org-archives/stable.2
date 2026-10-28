Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205979;
	b=lLCzqNzw1/j2AZ9nIIE1y0a5XPa1Wp4r1VxgpRCdPrHF4t5YUeCK/tGdUsssQ7JUvqld
	 Zg7VyWtku2Nei3Mi7jOFnsbV8H4gvC01x8RlwpebUAhOqlA8EUOS2emBlP7kVKmQswLgv
	 C4o/KMOyK4KDEC3/b4TmHgZj8Tx1RmHOfzeR4b1+oolWeUoAdTbH8m3LL8Lqf04/bzaOd
	 9+9yS91N3B+6FOBFkd+rvtrc+Qybt+vzZxmN7X0IfQ3Hk1JvPV3aBoUnNNxN/g9AsPuP/
	 8SFTBYF5u9gHRtv4Q7nl+K1ZVWMloYcWY8zcwn5snSXM6/t89MofpxIEi1YYA39FkTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y1bk3hauGmSlVbbzTKUs6ZWOzx+ReD4F+CcFEDKQX6A=;
	b=bGrKItLZrbgGC+IAhek5wBZ0kMZOoDo/bDAFa7pbo1aA+x2E+sDlR9A0vpZc552OWk8y
	 27qVMeRRokGSyDS5FwV4XTKCyPZGX+LLaahu8B0yLinSXZAuaKioW3KWfrBroKcFerUL3
	 3G6AEB6G3PBnClOv5kMdkx5K3hC0aRIZxyxXpQiPKDk0M3lDJ1nWBqqDa4azflCAx+e6o
	 niK2ZIrvKmU6rO54QtwCgLdIPsMK7Lq5Fi/AwjSsnVRAosx/BQ2pQ/n6snDlA7so3dgnc
	 oLnzYZR4HecLhRMjoC5TkLA5/ODRHI5e5d+ofhQXLASbpds66VG98rfOs4zutSwTCeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kXJQWLIF;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305460A2613
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B305460A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kXJQWLIF
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-85c1135c286so72775a34.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205978; x=1793810778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1bk3hauGmSlVbbzTKUs6ZWOzx+ReD4F+CcFEDKQX6A=;
        b=kXJQWLIFpD5Nsx6x4rXVEufZJ7Bgw4knS+PMYq9J/5rvTETexWthvhedXPaDLDOEED
         kv/TKmPmcDme9DbpHUJzPRfzqFFutX9hFF1t9dUyuFoOpYKf+wFj+K4BCAs8tcymXOP8
         sOORwoP0Qes551mtwxH5cr0VLbhXRkw7/KsjEBAN9PSarhVh90xbLUwzzv0siAAzzXwK
         zh/inoy3DsRnoHryAEtj93QYEraJ9AmZu29dUh4Md2MIbA1lI7E0ij1lmwpSD2RISDgP
         Oe2y9w2hGK+9RWBLeKtIH0GNQsT3xzS6zVT3tU6UgEupL0kGqafv2F1p/bgVZOXqSecn
         Zgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205978; x=1793810778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y1bk3hauGmSlVbbzTKUs6ZWOzx+ReD4F+CcFEDKQX6A=;
        b=mPleFCBwQEeUTPlfsfKnR0GH0BXJaCKS1FRJg1z6HLETKBCTZG5Z4cLvL0G2MbHAZ2
         32i03xriyMjByaBHUR8GoMrwkz+Edl6yPUHvXqHpfnMZj6reII1pCigaiUMt2MX3y6AW
         kkVYLDOyHqTDIDvoDtPyYyqZdk0VrXAb5A0ehVknjI3DUwxsYlNGkLOda9yrD+XW/H7M
         IAs39oHeSoz9EiiT0H2Hmy3PtKbdz+/QW3+4X/0sRxarvaIsGN+UtRGaOW1EpK5pWmQY
         FavAE12cm+rQYYvpLSJTYo9luNaFUjb4ueu9Q3CL7iNdZS3rfig3hBfE2TZJTK+GwT2t
         EYlw==
X-Forwarded-Encrypted: i=1; AKwUvBwELiUG5FfKJzJExUCMkwEahBO6RcV8b+0rwld3zT8WAsbvpQCt31sEtyvMdBJS5QDJzDv1qxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNZDPsp9zX0wGy/WQ4C2BJzgbhX3Rq8cCx6SIvCW369fJGiei8
	r94y/lU43dtswTOVCHV1YPZnReYUT6vqK/6sQBNCd8ew/T/AHLmfIc8IzjqwrSmuw57WTG9ZdHa
	L3rt//1c=
X-Gm-Gg: AYBFou1Z1ww9Yawy8k+8iOmaYLB1QYzI6KB3rN6SoPD/y+Q1Cctb0h3rkOm32OFLW6H
	Fjq4tXd8EnoTLl8OHj0jJ+88fvJF43MWhrFPy/6WwetdqYlzeOScBtgUaFvZ1kJ0c3phFXrBEk9
	Rq9NL5GltqGVu0PxLyPAc/0FiEGZmvJpkTkjqztRNA8/SWFYmxflm+MUQXPR8nhLxPo26p+pj9f
	9vjUVNvZGWx4GUDBqwP34HB4A/mqaIeI7ZOf2NLZ03z995+SbMm9V6SXUQBiywtMKSxJH9y6ZZR
	dTxxc28fYxsdqAEPXSa3go+0+R5WgbQCrlD/j9xyk1yLcUZFTLIRErFB0izAYIws+B3qul1AgPI
	Ym5GOdYDSn/G6joR9oWvlNkj4LTkc+I5+tGdZY+c9jQ5zUhwVi8iCb1s44r6fG+tfldGX/wP37B
	7D1jH1vOEWKyddzOdNtPPn1nI/qx0mViz2vkzwq4q3cD32GP8mq//TNn4I1MqFBiSgFOhMI30gz
	Owjf4PMZSm44gNLLZKMwLj9lc6p9KLG0LpitIbrQMvwhgoe59o3FUq5y3nOMNb0xOafZUbEgblg
	yuNnAwSxK2tbRLq/JLl+I3nwCXO1poAPWBkVb8RdD5JWodCTabID3uEfi9adHaYorGDwZQ74PA=
	=
X-Received: by 2002:a05:6830:2304:b0:80c:d30f:97a with SMTP id 46e09a7af769-85abe8bb687mr2574281a34.27.1793205977633;
        Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 93/98] nvmet-fc: only send read data for successful commands
Date: Wed, 28 Oct 2026 10:42:36 -0600
Message-ID: <20261028164415.1262013-94-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Andrea Parri <parri.andrea@gmail.com>

__nvmet_fc_fcp_nvme_cmd_done() pushes the whole data buffer of a read
to the host even when the command failed. The buffer comes from
sgl_alloc() without __GFP_ZERO, and a command rejected by
nvmet_check_transfer_len() never touches it, so the host receives stale
target memory, as much as it asked for.

The tcp and rdma targets only send data when cqe->status is zero. Do
the same for fc. The ERSP then reports fod->offset, which is 0, as the
transferred length, matching what the host checks.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
Cc: Paul Ely <paul.ely@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index eecdffefa24f..b95893adae36 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2487,11 +2487,11 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
 	} else {
 
 		/*
-		 * try to push the data even if the SQE status is non-zero.
-		 * There may be a status where data still was intended to
-		 * be moved
+		 * A failed command may not have filled its read buffer, so
+		 * only push data for success, as the tcp and rdma targets do.
 		 */
-		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
+		if (fod->io_dir == NVMET_FCP_READ && fod->data_sg_cnt &&
+		    !cqe->status) {
 			/* push the data over before sending rsp */
 			nvmet_fc_transfer_fcp_data(tgtport, fod,
 						NVMET_FCOP_READDATA);
-- 
2.56.0

