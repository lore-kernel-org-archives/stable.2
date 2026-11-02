Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600392;
	b=gVCmc2R7VutqlziWixaCqAYqCL6DOBWm2EV20scvPrDWYH/rvrCYp0O9EsPWmay/Melc
	 p1kRUQnc0xfo6onXG9sH7c5kGGy+0asQAOOzLpXPB7K93rieJAbTygngK9jPn8tkbVobG
	 yFfX3c899VZaPGQsajXh5514sgUEHX0V/a+jE5P6uRdCrf339K7MG/XV0gHDta6Nh9uKX
	 jqaEpito2b1p3yHkxFZQALYIVKO5NgWFs9P88zthixiDiVxU2KauwgQMmkT8xQ6wDw1zF
	 CWeZlUM7TgXEzFW5kgrDvaKYWtERfCbIvSZrNQr9ncQneWZfizOOGHVvPh7yXwYTHQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mElJe/DzwSK4Juni12Wq7XJkw3SOr9Pu1K+PozWddZs=;
	b=PoO+E0qaGoyTQ2W0IyNWMQo0jdWYDLmkCRe0u3rZ1o28NBvCfrqBj1zh5HVVEW+G0xMq
	 p8A3UQaEfPBWECYhiTLmjHBXhU6vaHg/mJYi0Ro2A+kxeugMVZhr3imorRLAeZufh4aoG
	 3r5w/jTYlO821puUdXZgYDWiNk53UuDOXK2NfHX6cNthdqHQBTPQU6A2BfgBU2QpC7U7o
	 Kjnd6GkJh7Kw/VE7s2xK55YFM2O9Utan3rHbzZMENGsSgVoDS4Sxq3NPqsBPiHmJFklLC
	 /rK3BP2vxunwy3SG2f1rojMvTMkTDE9zAIU+boVb1HzbjaXStLXx0XoTcp5ft+6ftUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iLdkvdVl;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E308606A338
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 06:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E308606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iLdkvdVl
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so1175592a91.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 22:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793600392; x=1794205192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mElJe/DzwSK4Juni12Wq7XJkw3SOr9Pu1K+PozWddZs=;
        b=iLdkvdVlivdnBEwdF4/PbU7RuQHrRTPKAvS/0RZAfYJPkd4Zz/n+kjh0RLKW7xXrdM
         /u1zi6YdXw0bUzOysZtLRTWe9+s7SWC/Jc0C7xwjMN4EzX9WL8D8CimQ4mNj79qUXTbA
         4NruuwiNtW0Ya+rA+sSvLHvG64WEUk9/pmglxT8AK1uqvt+kMgm8/mkiACHHb+bjjh8P
         8lE5PT3x8iXeDh+n/XIe/VgXPJ6yDygrbo1M2s7KwOdxRezkKhC0ey85XLThyFb+Kdk4
         zF1MrHXbSBkWCwSJsOoqrUNXvoJQPf+L4bhLLLvJmv2R5jmABe2+ug3X/OPAb8ia8BxF
         VSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600392; x=1794205192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mElJe/DzwSK4Juni12Wq7XJkw3SOr9Pu1K+PozWddZs=;
        b=qgptTG+/2rxhAGeTsuDfEmSCnLm/9x+vuYrDCY6VsiL8jN9t5WUAla+HdZutT3jTS2
         xOBVRiIDzKF8RHfGt61xw3UXIG2hmJBYCkeGaqUBjKvvuqo9pTXn4E56nw27CSylvWSD
         O0HFZFvXZISg0viyK05Sg/zmQa7FgUzFMMPMcHH1I2QyeP0f4hx231SNsZlZh/wXUO+r
         aUTuY0FnWD7iB37OpGEdzPT0KTg905b/t3xOIDegZJPO3r+bq0SzzNWQQWDbCNr3bwDL
         UPzuDNATa+RzkP5knFYArQEInAApC7AgEx7Xw6Dc2rMHabjGUaJmw9npat/Dv6PrcawN
         uSlg==
X-Forwarded-Encrypted: i=1; AKwUvBzxBIBjpkzgQEcV0skO9ZKmXgAMVe8qO6OdBtUB3/6QHEnjx+9FgTRlwtjKxCkN4y8rB3SvdLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hb/TQRlB1cBrXqFJdcz4iG8vlFlSs4w6Az4+/nhMGB3PH/R2x
	+ILXKi/QEz/iGRqqrJjPETuzafLnGcK8DrkxoX6s7IIz8npnHxm7VIAi5lkpbNVd4wU=
X-Gm-Gg: AYBFou1e6XG/Lxaq66l1tdrdfPDXOiWkzO8HCd548DefrEWt0HA32LVjQqegqw39Apy
	tYWf+QNwrwfKQFfMhqMZQXlUmk4DlE4AWWHUeD/HlpTXob9MaEUa74IZlCCwZtvZevP/Ou7HUgZ
	OIWhdj1l/SgjJIyoLd3c5dg5x6o/afp+YJUgKEkLE+tUMCFitiVmmAmg5Ivzb1pCWTqCHFQCHWP
	Y/zcczRVMgtIz3d5HbRxF4DZt6vHDEl5SpF2p3CbV1s2eOwBX1Oru5eLgX94hhL7+k9Jg/4hc6f
	51JDODJmEWGC9TABWXqSC76m3Ca9LeqdQWF6Vc9R2hyD1XEnfJ9k+CPwIfZPcUUrHKqRnna6/Jv
	cvQe0lOAw4/75NCxK0Xa/cyIQbqutWbVNfGCHN7SKevWjLlEgdmOUcaWxuxzaYT0BrwTg9QW2Zx
	x7agBPd1DEhpgBuzyg1fuFtkkb21BpGqKaI8s9ohm0MhtLvTB/DQtJsK0z/JDs3zWCpPcTtgWSF
	j1padWj+RrLLchJylSwIz7FBSWHg37qM7hvWluj6DWVw9IrURaYsGYWmhg9tOcb5CGRoruP3s+V
	yekwhcfvNPWCmZhqU4v3Q/VFE0BCaV623EhxduZdNkXsUk20xZMnmtNf9HVdhbSyrfygDjd1oMQ
	HW6iSZY6QiZAqsRacAnlrJ5iUEzs4ZtMizO5a0Q==
X-Received: by 2002:a17:90b:1e42:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3ae897ce417mr7276437a91.32.1793600391928;
        Sun, 01 Nov 2026 22:19:51 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:d115:e4f4:23fd:61df])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a5ecsm12927752a91.2.2026.11.01.22.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:19:51 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 2/2] RDMA/srp: do not DMA-sync a receive IU past its mapped length
Date: Mon,  2 Nov 2026 15:19:38 +0900
Message-ID: <20261102061938.617371-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102061938.617371-1-yhlee@isslab.korea.ac.kr>
References: <20261102061938.617371-1-yhlee@isslab.korea.ac.kr>
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
index a85d28b95306a5..159d6b6aa93e3a 100644
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
-- 
2.43.0

