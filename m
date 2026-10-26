Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994088;
	b=YJfz0ULrT0Fy1vnTsf2p2yDHpr6sx+qe7oIsuJjGVApgSEFqvT2nVuZKmLcmheKidoUg
	 RlUh3ptx7UaAXphqZ+HX/Mt3S8cKwnKrc696bd9YW4eZ2AMUYpiTriThlFRPX17YHpBI2
	 9OTZu5R64MZhAob5mz+msP06EYoqD7CNxxAjMMXo1nrfx6fWfd+I87QilzbMrXnj8B20A
	 3TQkZ0UnkhtBSkLajhG4fku5b2+HmlE9ZCPH4ZLvC8Xe6t0YboZlGiUhbEPzXgdZsUZh1
	 upWMB2fkZ5L3mm/nx9IZzXNnzEciHSVrCgKLL7MFW0Rk/XUqQMHSoj4FVO3elDdNEBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q9T0zMsyFxP6+f5YwGyxdVkCFKS+Sl9bRWYPaN9yuOM=;
	b=OpxHZma1STNHDOmLVVxzEjHyH/7K4QB6pcPAwjj0gSY+Yt1NVNxAObcxJBx19yAUTQei
	 w1zXIdmyNo78U9se6FMapZZAQD9jDtblUzo7XHM3angV6CeXHoG2EpMj5x2qy3DqO3na1
	 rIZrzXoom04F++6JIsJTFuiuhuwG9/brrgPpd5DblpKNcoOrHMM/lOrwrzuzMpr5WZtRP
	 B8ddgeMJ4gBYVSh2ICQ32IQr/z8BosRpLeAEyxN+oEtIegTV7Pe8DNp965wWBPa8h8SUj
	 iFOCvE2zsKXW1xs4qVyzrpilNOZncdfvaY20+G/F8UruqqQYtSmk9qMeKBH1LVp/utQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Az9xVXNs;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60B606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B60B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Az9xVXNs
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36681e85e87so699788eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792994087; x=1793598887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9T0zMsyFxP6+f5YwGyxdVkCFKS+Sl9bRWYPaN9yuOM=;
        b=Az9xVXNscG3Ck2w9ynNUu0tuCGQR/ioLw6wLRtkWnJEfRtSPq4Ywm/Ips1yXdNN0AI
         Xjj9khi9Cg3v44tlvQl6np9xYQJPO8G9yusr7MdnHgF3e0IdaEKYZaaRxUT/coaeloiy
         5s1hAVBSp2BVOJBNTH91zhkz6RVQGNWU22geHRs6MbrgwzkqzizIWwKLfycyxB1b+gWF
         buMSIpnizvyc4F/xb1+iIKSc2YoQhGVjHzhsuu9IWY7pn3dc7ElmuGhvoij+NyZesvtj
         gQGHfjCxfc98lu0hxwZH62DzogMvLSsa6Uxzv3pOzvSmdCvBznHL7qsrYNAaZo32PiEs
         lqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792994087; x=1793598887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9T0zMsyFxP6+f5YwGyxdVkCFKS+Sl9bRWYPaN9yuOM=;
        b=eFPX8hTJLRrP+R/xkvVqGhwcnJbG1sMDi7+4+whR8Xe+IduEFZmD8vztp7Tn30AHsL
         C365zc8YJoaH5c/qVa0hj/mXnUdQ+XTsp4knVtx94RtbYSDQpYNcx4MCO3Dr608FgPLw
         DYu9B9AeZ090s52+HHSthpKq+oZuYtoZ5kM30/Fb3/5e7XFVKMfpYyjwSBgR/+Gnd6xK
         9FbdgJybaicYGnJ00HWjWTzQlI7HzIgeWpRyqGmJicWxIfcDd1dxBHOCPBFZ5lyu7FMQ
         fdDzO/fRTFpfuy2bwAYvoY+0Bye/AMZKA5+yBGU7xUtZSURGLF2uJKahtwMnvniQul2o
         9evA==
X-Forwarded-Encrypted: i=1; AKwUvBwad/8vx/XQq1PUrqm6eT+9gufS6yS5UTbjnnXMr0gYN/livjmkV4b5V/Ofo1XoVBY2QJPfOxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMMaIwYUItnRAQ4PPRGk9uq9Xztm02LK4QYPt4daNqbgojfBxU
	NWxGB35CN/I7gKYUyOdDkDaUVtcmoenwlPwGOzDN24OcG5C5e4qrIw7zHo21Q/aKqbs=
X-Gm-Gg: AYBFou2eUW1FbGE3ZOG8PxCytqExhwien0EY0mbpn8Uei7LWtc+tuGN4RuSl2QjxCDa
	cA7HTRbsInrpkVcHkHXyD88iGhvncrIr/AoOEEICkyn5qYy+sp4rgk4xKZSmu4Z2VaoTVszCTSu
	KDyJX9HPTOv65xEgFXyTQXso3n713+K5c1IrXZXF2qw45MYiHnsp4u7GBbvJ6DS0klBNrMdMQm1
	VBgVsSSs1ClABiv3RL0QhHKE88TEEikhME0BdcdQHXRv6albkvyYNt/7u1tEp8fOj2DS2IH7pHa
	MQZAPsYQpnWes7HgSt6OUEW+k34WrVXmrGW765tAYZ1FYFQkIOxapQNqgCUYDcC4Y3QYNHmWx1E
	4TjIzrqDiLhWqUkrHiSALAaK/uSMYFe1pYKsnfYVvnfzVxY2Ivjhrp3DaMx7voONZ3AThs8jU0H
	nLgtjF2UJi7jJI1GXNZue4r3p6IZfU44kJGIXms19vmlEGlus9Yu8U43a8QCvAN/Tm5mFgxxDq3
	4e7U5lDwGM05Hb1u2M6ehYN9SePMMHrUwTf8wRTaCpSSQIoRtdnc9cxmnpKZn2YQzodEwCd492E
	19EUqVDMlgXSr+g6BuI0qGcaajSFuFT8T3/mGso2bLG92EAU
X-Received: by 2002:a05:7300:599d:b0:351:2958:1740 with SMTP id 5a478bee46e88-369e84e5603mr9189061eec.37.1792994087240;
        Sun, 25 Oct 2026 22:54:47 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d845ddsm22290613eec.11.2026.10.25.22.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:54:47 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 RESEND 2/2] RDMA/srp: do not DMA-sync a receive IU past its mapped length
Date: Mon, 26 Oct 2026 14:54:30 +0900
Message-ID: <20261026055430.406487-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026055430.406487-1-yhlee@isslab.korea.ac.kr>
References: <20261026055430.406487-1-yhlee@isslab.korea.ac.kr>
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
