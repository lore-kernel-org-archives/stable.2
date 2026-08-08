Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E023B2AA
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191111; cv=none; b=Gca7bwoT30onXSIyZMz/el+W0PgLSSyEgSeuxx4JAzDXp45nul6DwOsJJaXfUP680D1c1g2EJy6ic5mbIwofg/wylioLLrk3LZqRrjBLuaspua/jpHttaD4dE+pqOCcJYxtyJxYXCxWrOiuYqVwP2l8ZgjrQIitYgU5/wvldY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191111; c=relaxed/simple;
	bh=9wZYwXRVe2G/vTq2B8Znoy+bMm9uJkSKcgJbIjP/slI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCI7gbgUmsMQCQlqixkGgnDZHzCqr+/N123Zwh0S6xmp4LXj4GL3I8A6ttiHAxLQZitAhVjRo6WfLLlLUNtnv9P2/hQzCHKnYv2w+LJWH1zgniVRB4sOGiitf2aIY3Ws/f6P/T9EoA797BKi0GhCYIZNiLSRusGcSAFPvfefXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5Bnauo8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5Bnauo8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce7d2adef4so6266135ad.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786191109; x=1786795909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qqtodrANULHy2HebqvyH0gpSUnDrF1cP92+56xd0b6c=;
        b=S5Bnauo8jx+b1bt++IOJt5EktqgoJQMmvFP7FW3MEIbbNfTm4ae1yc5I13D5ytmfuQ
         2kgw5cMLbyKnzTf5kYgDCai8DzwHdUknP+6FzY/ZPvPO5V2Pb5b5ysBhVWwfk09n4D/N
         IYnan3bPA1ujc26N0w0KlotBUYME4HHMVUfqrAcS8ARsmVtUpZst3fIZKiCSuZL074g6
         sTmyz1jDE1N6GypMCopKVo3HrnVHURp+fWJxlc6E2eg7O7JVFNaCDDTLzZzsBl/0Gf7h
         OaMPmrGKatjS7tltqUo7iOIpSQ4C4uIqGn4UMdripnyKs5nRGfZPBw9hMDNGNDk18ls9
         6JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786191109; x=1786795909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqtodrANULHy2HebqvyH0gpSUnDrF1cP92+56xd0b6c=;
        b=WdYvQiNxTx98SB3aUwb+19FZzJHgL3dk+CP3Jdp4HvkcmBzps4HC+YiAUK4ydXl7PE
         I49p/wnwzhCQJ02BfFNWxMozeuW75C9oYIP8SWx2/EMSlyF0AvwhnOXoQgWCFm28uG8z
         nmCYbi1J7vHLgnEP763I2392e5YMBXp6xLr8NgTrWjTfAIVNBJ85Hpt6ZpsMc9Rv841P
         Danl30mffP1BUERiWK4/CL43sZl1gwxUI54g6gP4I3gfZaKSUW3KcusDXyj8tMHU2BMS
         C650iLUlTCdKuBI9txtcTFrP9nxfe1IAWtmjvzwGJxRfv3vsyK+UymP1XKEMI8V2TT3w
         ZMcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGjhsKhP5cv3Iook8SD/FAFnYrUZEWnBxKd6sXRmpqdP3+rUZvDok4vk89Tad4cnkRTfVtljk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtv1wXIekH/GFo/72NIVJFO2BJZ5GbTtuo41r4uYq1vUyrH9E
	zFtxdxvmwNGhethUV/pOzYxRBv20qzuJB9EVCwwom6ZWpcZWI+RfPDNZ
X-Gm-Gg: AR+sD11thTso5WrlgRdnBZbXlx5BKVTht4ari8NbBHVThGpzM6wkT83uIlHeGB44Nzu
	nyivhCW7hJiTb87XTjz6cIbJ+UYC+JJ0Rcfn4ZqPzAHoC/G6/psJMvT7rgvFSx+mA+SYW6cP/jD
	ZBb7ywEG1V97yuu7BOs9KVhSKwvGD1sKKWqXoJYd2iaKIs47VsD+eRJzwzewjfBDCDPcXnr5QPn
	OJjyuf+BoPR9u69i63AhS5U4B4DJShKemcL+mTDGbep7Hv8dU5FWYlUB5M9z5eBnnbTM/QTUPuN
	0LBYCD0HC1dK9nE95EK5pS+XpAhSDv5UF34UeBQZ2Z5xBwNxqUZBM9Y40yQLmmLJMX1BUJs0dc2
	qkWb1M4V+Ei43RGi+r8cvbss3wDZliwAHSzWc2t9Lwbj4wNcQL5I768elsfqMdHZAhQMkimrGdM
	QJLgAyuLDWTaSL1npbGbxGe53ERRbnIswrvMmiI9j7hyI=
X-Received: by 2002:a17:903:2383:b0:2cf:4544:104b with SMTP id d9443c01a7336-2d294b29144mr139478015ad.5.1786191109424;
        Sat, 08 Aug 2026 05:11:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbedec6sm18151975ad.44.2026.08.08.05.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 05:11:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	"Jesse.Zhang" <Jesse.Zhang@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
Date: Sat,  8 Aug 2026 20:09:34 +0800
Message-ID: <20260808120934.2813010-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
amdgpu_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1aed121f4ddb..e814701bc8fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	amdgpu_driver_unload_kms(dev);
-- 
2.43.0

