Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA533F5B1
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882469; cv=none; b=HV5z04CkXD2kn+emxaDkoZN7ATEBFnIrf7gtkDkTRw6cNvUTByvGJHBRhrOOgL0zJGRW/7V4dAhMpyI4bGTlK18ZDnJj674xnUZLwkVbOir/3ZOG53I7DIFAoihZ+AaaWfUQjhK4j5jbMavbU79BcEKi0Rgc1pt7uOe8MXBnmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882469; c=relaxed/simple;
	bh=ScMUaMd0TbrobyvI6139tHt8pPlNlKUDJn7Hfs6XxQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIFya5MdW67O4Vk/nKnhgOiF6VVhMe/4ok+15o+LmFlY/p0MS1pNLSNR/3KaCDLaChbXW+SHGVnJsuJ/XQG/1jqFP6+8WOwAo2kChw2pJhuY8Ioq4tN9cBJrPSYbtaiPyotv63DAvWFVj3wb5JkLDtKb7qsW10wyeD5je3IDWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lue4XX4U; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lue4XX4U"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fde295992so327918f8f.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787882467; x=1788487267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KOcOnSph4R/SK6vbv+B+XNx7SuiY0RM+MECJyRf8erk=;
        b=lue4XX4Uwd9cOGuyIqgtgV8c591aLJ5u9me8I+ssjSxU6VyzJhtWAlKgGhPh1KBCWT
         zL2CKUo2aPVq5wzXaq+tJvM5d8pa9e/u2R3iCRmJLi7bjkRrWsSYXUA8f/op0fQ8njsM
         oWobanOGObEhSQ+rkq4TrZrOEFCHUDbxe1+WONb0z1/05e5kkdXMJ1DEkY/cdlVjsHom
         +DKs0xJlXSj54vd/LbFBJe+1vbPQHXitTUmhdn9gfLxaC2L+KanZJ767Fwt/2ra+yi+L
         hvjr69NmJEv+Ao9yECt6ceuiSaEkZFccPfI1jN6wWYcdrTRpxl9ZXPaB/TzSzV7WCebj
         bfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787882467; x=1788487267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KOcOnSph4R/SK6vbv+B+XNx7SuiY0RM+MECJyRf8erk=;
        b=CQZd0u1GGrPZTE+6OTri6AlHb68aoIMwAWLGY27evITw6MW8v21Bgx3jsno2nbYG5g
         yFe+iglNz1+m5M+hoXCxbah6Ctk3VDKuke5AEphS2I4oblaxFh7G0/zJcVJny4r1gQEe
         2GmOPitdQbnOB1ML0AkpxSYoRFOA1U7ZoqQG58qPs1c704zd8kzrE38/9m2R7YjFjj4T
         FRW8F+snaiac0juiENtJu7d/fHTVordz0f4o8aTVQeEjrv0FcT200k9dMixAkb/nP4qf
         oDpET3X0rW2XG1i4k4IE4M+zISuIdQipK4AqUe8O4DZE2xX4AFd4PK+1dOHfaPlhrgfu
         oB+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr8P6kRgsxnB5fVaWKvi/MshfFs/tZHbFxerORyRjFPRLbLD53aiApfYSgBMdVS7IcF6rNNbxc=@vger.kernel.org
X-Gm-Message-State: AFuF++mFNu+HngEpyyoC2W5FQMS2gKH9qMjtaBfAWN6VV03LIGQ2ffCY
	QBdetXenUa7h7dmE/5tUZ737BI1B0GiQtltY+vCb/gQXSUV517gHTe41
X-Gm-Gg: AR+sD11sDaTggVoCxK4Gim9TlgS/SkVxyhwbQ2dcCVhgtZxo9XQ2DXRyZbvPB1tleos
	ENgJYxmhRGDnD/dDmK5LlcvitMahKvnYmf/PxWOpO7TSYW6VY3pcoUgOwlxY+ebd6bArGEe2c9R
	/Wo6iQGTOFJfY/eyQXWBupa4fujeXSBU+FOGK3cEF2Zz6Wn4/GI0CTIjHrLp2Wc1eo0co6CpZHX
	nKiqJ4yfQ81yhgVO0v1OgorDpoMgsiuqaPodz6U1BlioNK+mWZoIz3v40HJORjpT/iCP6wubXhV
	BFL3p7XVb7+704FIFpLnzNA/MQnRDPAe0Ii7x8CGCvMO9Jfq8GOtXCS3dCgRThf8HnAyPJrblmp
	aiCeTASG4pPltRQgAAXiXiawcf+X6SpTl7eD0ZkqTRe9bo+qmCcVFj6wKmMWl3Bm5+xoEy5TNPm
	dXn+B5at8jaMRkleSfBBMO9qJXTBK5DT5P1rJ5ygrfLNENK4hkUj+NcMS+Mg==
X-Received: by 2002:a05:6000:2608:b0:482:b823:cc3a with SMTP id ffacd0b85a97d-482eaba7efamr16934016f8f.12.1787882466615;
        Thu, 27 Aug 2026 19:01:06 -0700 (PDT)
Received: from 192.168.10.52 ([39.41.155.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20122sm362758f8f.20.2026.08.27.19.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:01:05 -0700 (PDT)
From: Saim Shujah <saimzst@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Paloma Arellano <quic_parellan@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Saim Shujah <saimzst@gmail.com>
Subject: [PATCH] drm/msm/dpu: clear pending peripheral flush state
Date: Fri, 28 Aug 2026 11:54:40 +0500
Message-ID: <20260828065440.140410-1-saimzst@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpu_hw_ctl_clear_pending_flush() resets the cached per-block state after a
flush transaction, but misses pending_periph_flush_mask.

The peripheral flush updater accumulates interface bits in this mask. A
later transaction which sets the top-level peripheral flush bit can write
stale interface bits to CTL_PERIPH_FLUSH together with the current state.

Peripheral flush support was added after the helper started clearing every
individual pending flush mask. Clear the peripheral mask together with the
other cached child masks.

Fixes: 64f7b81f0358 ("drm/msm/dpu: add support of new peripheral flush mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Saim Shujah <saimzst@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 36a497f1d6c1..e8729fe1cfef 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -118,6 +118,7 @@ static inline void dpu_hw_ctl_clear_pending_flush(struct dpu_hw_ctl *ctx)
 	ctx->pending_intf_flush_mask = 0;
 	ctx->pending_wb_flush_mask = 0;
 	ctx->pending_cwb_flush_mask = 0;
+	ctx->pending_periph_flush_mask = 0;
 	ctx->pending_merge_3d_flush_mask = 0;
 	ctx->pending_dsc_flush_mask = 0;
 	ctx->pending_cdm_flush_mask = 0;
-- 
2.55.0

