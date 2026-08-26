Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6B396D1C
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768767; cv=none; b=D/WTbygs5pMbPy7wa6tGxNq4EWVUQCc3BGAdfOi4InGmz2cRJwDoXeIu9Yt8o9t+keP2HZZ3hfgkPnhIuxVg5HZe4q1mJuVeOaMyoGADleC1rAUuPEU382eYswrFAlYZ2ZaQW3WOqfC0hbiJ3JFCNOhdyUncb2+MKTwn6L/W5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768767; c=relaxed/simple;
	bh=Nc1rNU2E7DHLdveCumxpbnt9mfl76U9FIsZQStRq2/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbbax+PC67RVkCGZH0ZOIIzrusCuwx1BNlxTW1xTICdypqYD/vAcWQoQpkEzDxvdD9i573exId9VGS67W0qm+iBVHSEzYTIs9OiG36sfrzcETPwhdx5VEvCPkpU5OUV3NaWboOWvsk2J7ZqHqpbdNPTFh/VGgcZmCpQz1DB4yYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jtjw68om; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtjw68om"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c252ff776efso38716466b.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787768754; x=1788373554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2AANzETdmnhX2GAGuIhUsamI5Im+2Kfn2eShC6d5HLA=;
        b=Jtjw68omAmsPWFkAz+W7nIDSn9rw5RVVfw0Bfmx2Xuyoh8ku//cnaVf2o6uXA3jVyz
         QIhp83hFE9ZHBNVt6CWFrmZGFegCD7Niu/ArvQRJxjzyKYYGc8bBdJNU+Q9/ocYqf2dP
         NDI7uencRd7Ht5bHY35MmnX1JAz6Qc/+xj2fDQdOCUakenI+9s/CS/UwN8BxGvC05tRT
         hxg5Tw1y3X+qQnDzFbeXtWnmblv2nusXiuUownTeqSY88bMFKAj3D0tm17Z78zffjIVJ
         kW2fjXAjtmo80wPQ8HBSLLCvmvj/+n1n5X2fTfecvUdoWXFPaX35Ks4mrK2F57rSYEXz
         Ezeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787768754; x=1788373554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AANzETdmnhX2GAGuIhUsamI5Im+2Kfn2eShC6d5HLA=;
        b=d3XsR7T2VXW85CwNTPsiZoWv1ILE0yP3zDOPXSOIlPBvCUo54eH7s/YsY6pYc5ZnVx
         V+0kHCRL3voAnJxEDQUtRRPw36U2UroN9uIPAUORn25tXq9xIYeSMm2yZft1ggGFaeqM
         N5vBqMk0HyuAPNkxW+tU+yc2esTi94+yuZQamZHGipaf67PaS/pv0ENNDelKUdzMcjzI
         ZGYjTQsxNc54NJY8Og01hA3tJ4ZEBrGIDxCWfPGOrGtvQ0apwUPKAG6mH73HTk0E6stq
         pImi5h3b0y2o5fw3r67UjlMfgpaP+/pQjx0ZYINK9qR+HSi908sbivA+oBkjTGDxyEJS
         Yhvg==
X-Forwarded-Encrypted: i=1; AHgh+Rqn1/bxXmcl02Fn0rs7ulfvjfgbMorxkigd1PmtrG5mg8Pf4Krl9ZD4Yr1Ix+MJzYFJ5P0VWxk=@vger.kernel.org
X-Gm-Message-State: AFuF++mPfVmktsgz2g9f9OZWsdjeYmN3J//Nvmrh5/eChSN21pjKnMTh
	MiP/8oGad32GGePZxsABbe3LCtlrB8HGI0U8MXGeAV6YbWvXyQ3eNUEC
X-Gm-Gg: AR+sD110UvvHM86GwEukMMN0t6W0bF943DZKd217YA039L2OmO0iX7pVCRXu5y09P6w
	5ey6JVU3zoEwvKtQTPiFmeT8rGSWPK76XA531xhJRNkQv4a7wDDGMs2Eq1llEdqIbMVJikIjRk6
	Vwwmk1a3RRr6sg5JmTjQO3zfzKWY1U7tWhNlHacrEgC/L4FvqEsLSxk0VS1OvklZBQ9mmdBMuMZ
	v9tQM6uaTQ1qSE8QTtpebWjKczaciXTxNzgG2Hpv/AU0ud0U7pUj/Ny++Nain8h0aeFFl0HVsuJ
	nUuogwHCUlxvcMOf+jORgAbSYFgkWuZPovLEn26lKD2cKAZo2GpTQoxyGDzylukmiR8KP8+6v+W
	LpUGiZEAtmf3a6VAYtsoQSmLYl3Zi/5Mmg6uWQiN6mjqAGQlVnuOlHu7UTwrBmvtxZCMb7RLJxX
	/7vDkMTKT3xvzJrkqUvH31hEMDalTSD/v/gwcsAc3FY6AWnoXZ3NCL5XYLnEcrO86souA=
X-Received: by 2002:a17:906:4784:b0:c1c:49d9:4c34 with SMTP id a640c23a62f3a-c25360ae6f6mr120564366b.11.1787768753983;
        Wed, 26 Aug 2026 11:25:53 -0700 (PDT)
Received: from fedora ([2404:3100:1006:efb1:8177:ae9d:629e:eab1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b43absm612769666b.51.2026.08.26.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:25:53 -0700 (PDT)
From: Saim Shujah <saimzst@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Saim Shujah <saimzst@gmail.com>
Subject: [PATCH] drm/msm/dpu: clear pending flush state before physical cleanup
Date: Wed, 26 Aug 2026 23:24:59 +0500
Message-ID: <20260826182459.1506522-1-saimzst@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware can consume an active-frame CTL flush while the cached software
pending-flush mask retains the submitted bits. Video-mode disable stops the
timing engine before physical cleanup, which then adds teardown bits to the
stale cached mask.

The teardown trigger can replay source-pipe bits after timing
stops, leaving one pending and preventing the first commit after re-enable.

Clear the cached pending-flush bookkeeping before constructing the teardown
state. clear_pending_flush() updates software bookkeeping only; it does not
write the hardware CTL_FLUSH register.

Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
Cc: stable@vger.kernel.org
Signed-off-by: Saim Shujah <saimzst@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 778e231..f3b1fdc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2264,6 +2264,7 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 
 	dpu_enc = to_dpu_encoder_virt(phys_enc->parent);
 
+	ctl->ops.clear_pending_flush(ctl);
 	ctl->ops.reset(ctl);
 
 	dpu_encoder_helper_reset_mixers(phys_enc);
-- 
2.55.0

