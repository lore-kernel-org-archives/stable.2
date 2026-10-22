Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679997;
	b=sNdA94npIcJ8p6+sNv2i/q0coqexIQMLFJjGkhmAuqsKOt6puGN688hIR+ZvuuBSJogu
	 9AirVneMN5V5H82ADdub7bii7sJslqwauY3Mx99rAehymYKihek25VuEn0VoreB0++4+R
	 AfAKiKPAD8/CVIjV9clF6BYrC2tg2+f5gPGNzPfg/WxnE4JiqP/1zrGBFrl3a0SxIoD7O
	 hOcJxi5O8W5L7d/xJPq5erUmHNNrX+vHduD7fVwr4V8azRDwRE9/lAPZntN7dN086+GPC
	 EhwLV5ANThNh2nZzlmKSLtxWjJGYIfRJf8cgll2izM4XjLoY+hyyBBKtFRHBE3MKN3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TsVtZqyGS71E5D3pQPE0mMNVJWhaOlaJlReFBXIDzUM=;
	b=j+LQRN4YTpEaBU062VRdgoUkgsFgcZuJAVIQye1Oe4D2AT90WAM79CMVSc0wHv7BPQn5
	 rNb601l49wyTE6FuM8iVFoaFeC+KHmik/KTTKLfZj4IPnUt+Y0E57nEf76QxPTI9qHDRN
	 qFc7958px4dvHlbNP5zAOtlqdwaCDs9rQBBUXnoifzxV3NkS20kSpVUhvdG8GiPMcPPAM
	 uKGM/mWNIsGrkEgneUMVT5+sIWscrUqmYH2fSHC6F4AKalGsFPrfybzCV/D85esqDcOKm
	 /PJkVjgzNSTz/an+L/IMg/MDYaiZp8axD2xckdm7TBjFkvdrUQlaIb0KPdCtWMcKtEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tNSU7zVm;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7C606A328
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E7C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tNSU7zVm
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1552599a91.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792679996; x=1793284796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsVtZqyGS71E5D3pQPE0mMNVJWhaOlaJlReFBXIDzUM=;
        b=tNSU7zVmKU/HHHTlxBVkbJL4t8ldBOPRMROq9Oi04M97HxCp0LXAHBz+iPTY4dLD/L
         fNstykDXUyb73Jig3KTA5TbQMFxbXDAYVuYy0F3RX4oUovYfvaFwnEE5R9q3ob4MvzVI
         Et70Qab4D2y4GSVsjXl7H8uqI6uYZ3LlFZODL/K+Cq1xAx4uJsgs/pbHCjwCF79rTENX
         8Ma22JDiGppuqf9QItmr5u5nNEebkn5hZv9dBv0mZb962UZLm9RDEUTfAz+wcuRn4u/b
         jyQk1ZodhTD6z+ekWV5+5lKhGJ/1Fxfgq0GJ/eR86E7HDJjVyu1sQjVCqlCHY0tf+P2t
         XrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679996; x=1793284796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TsVtZqyGS71E5D3pQPE0mMNVJWhaOlaJlReFBXIDzUM=;
        b=WTLze6IsHL8C/eLfKXymLNVQY9I6BAt2F2JPOKjDfs5W8EyVW14o6kubMOZO46loc7
         0G6S5rvAsI/r+q/1h1fdZsSrazJEaRBIaW7JUWZ24hPBqLymo8BGUrxihRKuUCYw5XsE
         TJlgGKr6pa/7yCy21MYjG4PlmKSAGZoZ5kQ0Ni2eT+u0bZsxQEV2SWjEmhCmkwbnj1Oi
         2OWtWlYhqHoLpL+hVcOAli02x22+20BOPwYLqTBY94NYb7d+96j6+6Xg5awoxywz9zd4
         vS6Ni7PJmeoD8bjAEgYNVCEj3c3i2Uf7UX2jsE85NH5r39YepYOC+gV//h/y/wVALxUG
         /Wfg==
X-Forwarded-Encrypted: i=1; AKwUvByYKrr/XCc86IRd6hM3AyxDXf0qvomUxMmsf2s+AiJ6RN4wrjrIhkt7Kh8YnEazseJQmozvVdg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq7QpQvYAyzWwMOcP696oNj9c26cvWDMOahO//7PJPtnDZ5fhC
	LwFxNcbbFAGWm8ECeHX2W/I/HzfywnJQDthod63h6NbS79oWQpld6WgG7AHoxwbfCcs=
X-Gm-Gg: AYBFou2cJK5Ybs6kobCW5Z6OwtZyi4U8T2BFLg3y8TZrcg7P8jBRh/3d2TpUAdy7Qk0
	fYCC4TbhWB8ct3z+xHuXMUfxxd03SioauWeCgCSs3qogxTcmjU7lcptdx4MNFFxAOAB3XjsNkvL
	ibyCGdD9XXdYG6AKE33ftvb4taFY9b3hWqYjBe5J9YXxRiqKtQPOdq7+QjV+88CJFQ8kQVkp4R2
	kOUydHTIt8kU9ROi9P2xpylHvEtmSx4SUey1c/bSZC5USIIl+LiESztTqdoew0awXP6J9VZw/Hn
	omhtC9VKC/j3u7XNO15WDZYDa3nPlWsCca6CK1uo6sb23iS13Q+TiKCST2tDhwHogb1RwxBmUnb
	Y2ozfufT2QNIrw0GSyIGFNFWjKLfr0kzKm6lDy4i1Y9VIgDJ6Bv4yzihqrBtpsnUNc07uREP54h
	2JcYwooQjzNZVA+BMuLEEG/gt2qPxC/NzrYlLelJIyEhBSGfhr5J3X+eOT27AqCQwDOjt/Iv3na
	qqT7ZEpg8bLHzGcXWU6b3XgRvB2rb3nyRuJJOdi33vdg66waXULWb9f52HhzuimbIuxCQGcImvb
	mpw=
X-Received: by 2002:a17:90b:5908:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3ad86f44c42mr4641606a91.10.1792679996527;
        Thu, 22 Oct 2026 07:39:56 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:13e0:b266:5a7d:e119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm4719043a91.2.2026.10.22.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:39:56 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 2/2] RDMA/srpt: widen the indirect RDMA context counters
Date: Thu, 22 Oct 2026 23:39:01 +0900
Message-ID: <20261022143901.2991062-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022143901.2991062-1-yhlee@isslab.korea.ac.kr>
References: <20261022143901.2991062-1-yhlee@isslab.korea.ac.kr>
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

srpt_send_ioctx::n_rdma and ::n_rw_ctx are u8, and neither of the values
stored in them is bounded by 255.

n_rw_ctx counts the INDIRECT descriptors a command carries, and the count
guard in srpt_get_desc_tbl() admits data_out_desc_cnt plus
data_in_desc_cnt, so up to 510. At 256 descriptors n_rw_ctx wraps to
zero, and srpt_release_cmd() frees the contexts only when it is non-zero,
so every scatterlist and RDMA context the command allocated leaks.

n_rdma is not a descriptor count at all. It is the sum of the
rdma_rw_ctx_init() return values, which is the number of work requests
each context needs, accumulated by ioctx->n_rdma += ret. A handful of
descriptors for large transfers can pass 255 on their own, with no
unusual descriptor count involved. A wrapped n_rdma is then handed to
atomic_sub_return(ioctx->n_rdma, &ch->sq_wr_avail) and tested by
WARN_ON(ioctx->n_rdma <= 0), so the send queue work request accounting
drifts too.

Make both counters int, the type the values they accumulate already have.

Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 97758082f71d2..bdea47316539f 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -959,7 +959,7 @@ static int srpt_alloc_rw_ctxs(struct srpt_send_ioctx *ioctx,
 	struct srpt_rdma_ch *ch = ioctx->ch;
 	struct scatterlist *prev = NULL;
 	unsigned prev_nents;
-	u8 n_rdma, n_rw_ctx;
+	int n_rdma, n_rw_ctx;
 	int ret, i;
 
 	if (nbufs == 1) {
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 4c46b301eea18..1dce9bcb490f0 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -223,8 +223,8 @@ struct srpt_send_ioctx {
 	struct ib_cqe		rdma_cqe;
 	enum srpt_command_state	state;
 	struct se_cmd		cmd;
-	u8			n_rdma;
-	u8			n_rw_ctx;
+	int			n_rdma;
+	int			n_rw_ctx;
 	bool			queue_status_only;
 	u8			sense_data[TRANSPORT_SENSE_BUFFER];
 };
-- 
2.43.0

