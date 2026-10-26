Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992047;
	b=H9c7jh8lS7/z6rRbsw5unAWMvGRpLTp60MSRbRPDILNv3FyKsO9mOfQg19yZPnDbWEpD
	 Edw8O2IIZr1lOb+MSCBl7gE62NSTs3lgwtceWetkRXYaT1VuWJEkyEAgd71uQyeN+H2dq
	 xaVHE/aYVPndpSLTULsVShKN3hJ9T3t11e7B8hysj+5DAsqzrPIAuJxj8Zme2CUuuTNQi
	 WpqWKEgU+w6QJnPTkoH4Gdv2SZ/jIdoZYyOQeHBdmxyD/doAGL0QLsDZvnAxSNMw3s5N5
	 Et4WMhBzt39KD4OWAOTyPlTsd0lNPR1jgqka5Dz2oSFrec3B2bKhgB6SvrPZye85hRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q9T0zMsyFxP6+f5YwGyxdVkCFKS+Sl9bRWYPaN9yuOM=;
	b=TwYA++zQVwx7pBsZg2rt5w07ohnZS9wm6lYT3XQBWSdwjx1stZZSUpGfHmXiDTY7W44T
	 ZNen7Vo+9k+kUHdXklsw9aLXrEI6xp75UNEqNuLS/wqr715gs4JY3rpGE9FNGHqB2Mdl6
	 DZBjH2Gc6Htz8/wU2vLcTcjiYN99BEbVPi1t26ebDDCB2ThrzhOJ/XKxnOiGnFCLaZXNQ
	 zMukx6c3HgbiW+aMPAGXIY8XEJGij5COBt7HOzZCu05ye+D32i39PgKYWFPlaQQsc5OzK
	 jZuWhwCT9c78n/aRX9POa2KlLGOxuILm4JQMvoVNAq6Kfws/zLVyGhRbPba7qICYsjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Q10QsAWm;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF5606A325
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46AF5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Q10QsAWm
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-19305bcb72cso1652410c88.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792992046; x=1793596846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9T0zMsyFxP6+f5YwGyxdVkCFKS+Sl9bRWYPaN9yuOM=;
        b=Q10QsAWm0srF5Q4r1QBLb0Bzd9FxZQkHstgbsLD66/+S7a9K/1k3l2feX6J9KttYE6
         b/yBLxELzCRKYUCnTvkotE9pJZ5EVhOjCETTqV0lObDHdupmFFayQ2Fydwqyb6NOneAD
         pVhMjOA5TrCF8R301PrTqCX7XJfEWYD6C0+GHsMYbNGQpuzKHszwgyp4D/Qup5sGq+zB
         Q+gsVBy4iGqvF86HoaXLm5r2LTlWqZUNhB2JJFP8uF2gWHYkc5GT05A0f7v9WI9dQnsu
         UZwiW6dNfPlt12iTHYCiIWLxiPXm5sU1UywuzNhYyAEm4BiR0AmUxlZ3xQVqLaKqD9a+
         wcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992046; x=1793596846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9T0zMsyFxP6+f5YwGyxdVkCFKS+Sl9bRWYPaN9yuOM=;
        b=YKnZ1X1kbVYMEajLyOlArQZ8cT6VcljcRIMke0ZukNrRnG8L1awv09KW56r5lNlI9c
         +0RVwKs31DpFNET2AMpe9aFPZYNlRSv6aeKJDTsbJGSF1KIxn9b67WRWOwkz02fiOdVd
         L+Sad+xWf/jMLpVibpYUkvfBmCw7BjOrM7Nu1EY+J8wwfKz2jVNQW3urIfzT3zpm6FON
         V00myuf1BsGNnQNLbs4Nus3NcT6Ww7nMJj0DUhC0JrMe4LKtnc9diQn9b3qFdonoh6Fn
         /RjdO0LwI+PHizpVc1KZkRZTfS3mxDtBSZsq/N5yoKbbAO6320OtqElwgbTBZkkCmy0A
         h9rw==
X-Forwarded-Encrypted: i=1; AKwUvByD2z5DXrMCA+Uwf6UHudUirQuKnzgP9mW6io2g+go2uhAw+UVyj0KcSJcYQq5yVNh+iZqxvWI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvWEHpLQfcDJrDX4SDSVIO9i4nbcp60xzDykh2DQstdXcbZJ2S
	2NcREx5Np5atmtZlIR8AZM0kSUhDeesDobkXprDGhVllu7wi0M9SP4RoO/aNTGVwyZM=
X-Gm-Gg: AYBFou1mpk3U4ZTn8XKU5gAR0udmVB0ihmP+wG/cI2+GqW8nR1arqIQohCVshKDT7sU
	usqqBJ9MiMZ/Qv14yF0TLeb1U/4Qfbu1PHpJT2Yn5yZYQDohRk+NWCltm+LxN+4smVCzj3ux5Z3
	F8k5NbOYlvSpYC3t5Oj6Jt2DVo60/5N5t1y9bsYAYjJkrrLBM2igTzLU/3whZWXqTM2RpJUE/Zi
	96iC/4LTVnp3S7fA11srQoiUDulZa8pZpMLpIIuBRrMr6ds35BJQ6ENLDiVQK6dgOzAMijdx/cC
	rWPPS3WaDrZDoUx5Ldge7EwrUW49NujbjhPYd1/BkXDmyjr/20KnA36TFKmIFH6T+GqlZM0oUjQ
	rbjIgffPOmDxLoUFyoP1Lg+iIB6QigAvygonwaSU2xsk/57CXm5nWZuWagecJ432GUZ8okXOFjX
	NhHAuvAKzE0QBBthR9P2bgkHjCe05lV3AnXDVHCIOYsGBVXBFHQdudLwAGI2zYatdlMDOzi2lwb
	CtZhRUN/KmibYi+IASypJEMKP8750U+ml3TevzwVlEPNxvBjGMylsj0VOr8EgA/cFZ5ECfrlhHT
	1DSaJBvROfFXjHLcbUSaDtPo7aqPNByuDdkZngcrlQnrkblO
X-Received: by 2002:a05:7023:b83:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-19935905e61mr10191002c88.33.1792992046172;
        Sun, 25 Oct 2026 22:20:46 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f83cedsm26765774c88.13.2026.10.25.22.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:20:45 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 2/2] RDMA/srp: do not DMA-sync a receive IU past its mapped length
Date: Mon, 26 Oct 2026 14:20:29 +0900
Message-ID: <20261026052030.296361-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026052030.296361-1-yhlee@isslab.korea.ac.kr>
References: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
 <20261026052030.296361-1-yhlee@isslab.korea.ac.kr>
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

srp_recv_done() syncs the receive IU with ch->max_ti_iu_len, but the IU
was mapped with iu->size.  Those are the same value only until the first
reconnect.  srp_cm_rep_handler() takes ch->max_ti_iu_len from every
SRP_LOGIN_RSP while it allocates the receive ring only when there is none,
and srp_rport_reconnect() keeps the ring across a reconnect, so a target
that reports a larger max_ti_iu_len the second time around makes both
ib_dma_sync_single_for_cpu() and ib_dma_sync_single_for_device() run past
the end of the mapping, which breaks the DMA API rules.

The HCA itself cannot overrun the buffer, because srp_post_recv() posts
iu->size, so sync the length that was actually mapped.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Fixes: aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index a85d28b95306a..159d6b6aa93e3 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2111,7 +2111,7 @@ static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	ib_dma_sync_single_for_cpu(dev, iu->dma, ch->max_ti_iu_len,
+	ib_dma_sync_single_for_cpu(dev, iu->dma, iu->size,
 				   DMA_FROM_DEVICE);
 
 	opcode = *(u8 *) iu->buf;
@@ -2148,7 +2148,7 @@ static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		break;
 	}
 
-	ib_dma_sync_single_for_device(dev, iu->dma, ch->max_ti_iu_len,
+	ib_dma_sync_single_for_device(dev, iu->dma, iu->size,
 				      DMA_FROM_DEVICE);
 
 	res = srp_post_recv(ch, iu);
