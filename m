Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E51F09A8
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782022058; cv=none; b=a+fWtGDl3pb3qp+jlIMkxvD+XwDdojHK1YZLu5oQ6NSzxlOrePNn2fYXLr1AjGVlhMsr2Tl/vBaW9eyMZp89hSPrr6pynR18i11SQ9aIPDgs0aMVV0Ap0NnjblsqEyBPAPDL2ueO31i1AA2gA3AtMcHIxP0cCGSlafFS63HMpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782022058; c=relaxed/simple;
	bh=wgl87edwgI8AlgxS9mEVK8AftyYr5Z4dXGC/oo8DfYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXYx8E2AWnirqbBAmOwJOuHp/GbqBu7hJtpEm1nQxCcBkar5jpMdJJHshEWnqpMCTan8KX8bpXDG7Jf6kCyki0KmXojcI9zJpAdlZwikxAe8j5fyvtZtw+hjiPmzmUWnwyf2zge9pMa6fA1sNMU6qA39d47aOxQsZkgsrkU5aEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ijv4ieai; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijv4ieai"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6ab886da6so19867315ad.0
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782022056; x=1782626856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTEWs9Ifv38deSq90LJ7l6ArZp1UX383BprXX7Gzyqk=;
        b=Ijv4ieaiqqXZTcV+2BG0ROpGjO2POFumz7VEuD8g4tTycwPzKXaLhZyngXA4pTGFiE
         oswpj+x0ztRB0wthQvUEVetgcj9KJrzK5BXp0uYqoEWYfWBGDx91eIVi0naZl3vCwi5G
         LdKiuVcF1OEdzv6SB5seOwBZb2j2xFbmQMvg6icBV4ctRHu1Fv/SmiatY0PWSx9avAE6
         sP1b1fkL2xoMk1oGRW6K6iNlKeFcHyKgBIj74EJh0BmBKNXUPmhq+QiN4MlmczaYONyB
         s/U6iK2tgQDa02Hrc9rg09f2YyPTTyFIQPF8cJIaAdqEWS7GiWWK1pOZFA/L0w2FAXr+
         1W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782022056; x=1782626856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTEWs9Ifv38deSq90LJ7l6ArZp1UX383BprXX7Gzyqk=;
        b=QV/Fxiz+rsLwGeXNTdnNbNJfYoJuCpUPe8hDCZJVCPqd69t020EWX41fPQpdsrX4Xz
         Vdk3sWQ+E94EarhnwqoqKrNdN1AvqaIjjNVPmgYGmangmVOoSSv5moAjac0yII6Mb5YJ
         xEwXINQV5LP8rmN5o+3gLxedkoNhi6s16EkSpQQR1eK1/d3p4tpKmegBvqlo+37MyDCp
         WdTkTytpKW9EZJG3sARWM5XuMxM125UD6U9z0ko3j/32eC+Z855Fm62a0mCOyHiYvlx7
         6ULksF54flC+SlOz4Iw9RgAqXNzGTBYjFheroeoIdOX4S7XYM0E7U5ZzPKbNW01iEK5j
         a/Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rot5Ip11CI5qrugdpPUT/8asL3kpy89xNBWYq8TOOZXufqyDou080c+IlYeuOi+S0FYWgftjJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOn6j8HxS0YucYMTQSFvK1k1+XVh6VhZWpoegakBfyo2e0meYr
	jfsy7RA9OOSLbCa6Zx7+akoSz9oatn+teyHn/YZ+Rb1PSuuMZa/4qjIj
X-Gm-Gg: AfdE7cn0BRZbTAer3XFq5R2FGgeuN7Cycy1grK72EDzV94pLlD6aLvBQ9WmUChtpcnQ
	Sr6fTYypItMIpCjM5JIpKQ2H3BhEKpv5lgSbrxn2BsV+Qnv3hr0xASFO+7TAZaGMICHta0cfgeM
	kjjYu4qCizy5tKCO0lEQmNZU4LaRUGikG9UWKzoK6fo3L/RgUXRjXCSmrUTJae08zgUQcmBmdxE
	CAgEh6t5h0zSw+WfmdQQzHf+q3cCUcfsElVw7a4t2ZFEn9Oks7wLShD2VZcHoxPgjy+4QXc/JgJ
	h2l8/mxBT8JQ390wFYVnrxGjJ9HkL2Kiq8cNaYI4eokQtuOtM/iOho8L3e3TOyIaShempUo4Yr8
	HPUW8RNnrl7yq4Ejq5yyM/wgGqPEW00dGB2PvGrVs3d21skm/TuT8cLUc45As5OYuMzfExNlzZG
	JPNduQCFLWDKnISE5L9befyggW0vUeP5kkJvZzkT+Qng==
X-Received: by 2002:a17:902:ea01:b0:2c0:a9b3:bdc6 with SMTP id d9443c01a7336-2c718f65036mr104593205ad.30.1782022056278;
        Sat, 20 Jun 2026 23:07:36 -0700 (PDT)
Received: from localhost.localdomain ([49.207.234.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444a9c4fsm38668765ad.75.2026.06.20.23.07.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Jun 2026 23:07:35 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org (open list:RDACM21 Camera Sensor),
	linux-kernel@vger.kernel.org (open list)
Cc: Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: i2c: rdacm21: Fix missing media_entity_cleanup()
Date: Sun, 21 Jun 2026 11:37:06 +0530
Message-ID: <20260621060709.54396-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after media_entity_pads_init() is called, the media
entity is left uncleaned, potentially leaking resources or leaving it
in an invalid state. Similarly, the remove path misses the cleanup.

Add media_entity_cleanup() to both the error path in rdacm21_probe()
and the rdacm21_remove() function to ensure proper resource release.

Fixes: a59f853b3b4b ("media: i2c: Add driver for RDACM21 camera module")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/media/i2c/rdacm21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index bcab462708c7..41d4242a9b58 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -594,6 +594,7 @@ static int rdacm21_probe(struct i2c_client *client)
 
 error_free_ctrls:
 	v4l2_ctrl_handler_free(&dev->ctrls);
+	media_entity_cleanup(&dev->sd.entity);
 error:
 	i2c_unregister_device(dev->isp);
 
@@ -606,6 +607,7 @@ static void rdacm21_remove(struct i2c_client *client)
 
 	v4l2_async_unregister_subdev(&dev->sd);
 	v4l2_ctrl_handler_free(&dev->ctrls);
+	media_entity_cleanup(&dev->sd.entity);
 	i2c_unregister_device(dev->isp);
 }
 
-- 
2.50.1 (Apple Git-155)

