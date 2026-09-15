Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608532D7F8
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458450; cv=none; b=Duw/tNl3ErFD8/SkYEsq6QcsX2h+YNdLr4xCgDWDrkWpCProka1SefEMSwQV9HbOLCkp8xn/iAzE3po9XNB1LX55bOaOuc5CIL4SSoacuz3r21Djp77h8UL028V7uxDuDZOGSZH2u13e6uwUTiwFt+7Wv7+5ST28PO2NzIL6o1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458450; c=relaxed/simple;
	bh=3e5iNBzhY6srgLd7PlabQ3as+tJdr6LGFFaympW3GRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qcyj/AOZCdC9Y7ks3Am6xfqx0xmMftbwS49kqtvl1WD65UB3HCRt5u7tMhly1q0SMWVyXE9dy6PTlWwL7EJ3Z8yifCTd2vSMFW06BugDbXpzY6JAQ3Xk2pE5+CAOHe28LJaxGNdWwMi+ESKOY1xJbk9APCJSjrTMmHMhKD+VzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu1Ag0+T; arc=none smtp.client-ip=74.125.230.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu1Ag0+T"
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3a48db5ecfcso22892391fa.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789458446; x=1790063246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=reJctIGiQbHHtQqBXNj1e8Lzl4odeNP0FCDfrK7fh/A=;
        b=Vu1Ag0+TE8c3stibjW+DpfG2LNsNqBdp4DMsVmmmHjFrTlmJNvBCgrlzuMTExxMG3z
         gR2q76l83QJhp3PYaEQaqL5NSjdVhMWnbFXA0gLW9mqX5Jq6l99lrJur8xU4YMl7dVOG
         jalan6dniXojbse9jnA7Vm/Wb9Vg0VvvYhNRDZCdqusAwQZFEB69k1rtNnH1UmCYBJhL
         g2VKE2ORB/TTZFqrfxQtD2LHY2xcj6hpqAESpiwvXPZgFWeL3UnPeMQ8LpbenTqUjLo7
         +fa3XEN0b2GI9dUOsxJb0umlyxKg5yNu0LZV/hzr0DTzlQFxz8HDoNjVLLpJUEaMqjKN
         u6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789458446; x=1790063246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=reJctIGiQbHHtQqBXNj1e8Lzl4odeNP0FCDfrK7fh/A=;
        b=dxnPkjPwlG9b3cTZbeRS5Jj6WACLPUzBkvjRGY7E4S0mjv9Es7uj/F6B3e/Q/Unn7f
         MRsMtkAmRSRJitzcGjjqnFmS7P4jnKMj3GFXP4U73yjGTMWG+yAk6hOYhnoD5vu3mpNL
         Auv+hicUO+5vc7hObVrgq3nIsM7yUZYhFn04wAOsP8tjYhvOxduPi+awJIH0RQ2Awr/s
         TaafSLIr19qWokzx90sAhvVDyWP1MGocl4JtM+MAr6EGz24S6CbAFKvU9hLJpLp6dfHJ
         ujHaqzbF7ry89qOImjrpSNPeLWegMgmLpclGjN/KiClBizR+fLpof2UbchgB8FYwo438
         rI6Q==
X-Gm-Message-State: AFuF++lVjv7ucic+RwvIsX9+sc3mZJeA6N2Xsu2Q5CJpj7JW6hFOaiAx
	5UPBc9WVwXN8PL/YcnUFbd5HHamtGMVZVzG8f7RA7cyuT4jD44wT+/LMmPG18M3RcDA=
X-Gm-Gg: AYBFou0UDkCHwoYRV9+7Jmv9h2B+Ya9U5LE/ahjMdODkXwLtbHlYxJB1S3Gb2+zd8ou
	2wgKmH+ypCvRPuoBFthgAmn/ojcT3Q0sMUeZeSINGensKeVHqVYwBPvC8SNcPIFibPF1LBgHLsz
	6INf/lv3zjLfw2NU0aJi+vNZQkNXsc2+MxE1M+lH41KQvVdZjGFFcn8k3ZfPiuWQXV8hsY4H0cZ
	M3hOTDr6JHHo8wk0MjQgpxNRZsmL8os6PCc2ikW2LGjZbmfTqqtRFGwWIF+gf9z+kstbEkunOx+
	Vj4VscRrKPm1sOyjZjluyDvZyumkyAkifsIZoY3HXJuhKmkiCvA7SZaga9mmX9qerLHncyOg6Iz
	PyR6D5lhIkt8zGYYPCCcP+LGE0RGBRdhj3+4jJtunLNelDBBz8HXh/GNiSYQk+73JvHT7VJdPiQ
	RfXfYksX0AEk5GPHoiGNIT28m0s5OZlllT4zU1Wa+arWedw85+eAkdHpJfEPq48fE01crWrBm60
	yz1zLLV++ma4xqX
X-Received: by 2002:a05:6512:10cb:b0:5b4:ef51:8cfa with SMTP id 2adb3069b0e04-5b8ae68c142mr2989522e87.8.1789458446213;
        Tue, 15 Sep 2026 00:47:26 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0469a8esm3090013e87.50.2026.09.15.00.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:47:25 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>,
	Wayne Lin <Wayne.Lin@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Alex Hung <alex.hung@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
	Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	George Zhang <george.zhang@amd.com>
Subject: [PATCH 5.10/5.15/6.1 v2] drm/amd/display: set new_stream to NULL after release
Date: Tue, 15 Sep 2026 10:46:09 +0300
Message-ID: <20260915074611.9133-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: WenTao Liang <vulab@iscas.ac.cn>

commit 9fa26b9eed6195bf840f39ac183b9a6237548755 upstream.

In dm_update_crtc_state(), the skip_modeset path releases new_stream
via dc_stream_release() but does not set the pointer to NULL.

If a later error (e.g., color management failure) triggers the fail
label, the error path calls dc_stream_release() again on the same
dangling pointer, causing a double release and potential use-after-free.

Fix this by setting new_stream to NULL after the initial release.

Fixes: 9b690ef3c704 ("drm/amd/display: Avoid full modeset when not required")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-68236
v2: Include version 5.15 in the patch, as Sasha Levin <sashal@kernel.org>
suggested.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb5e3a6086f2..deaf98957cb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9293,6 +9293,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Release extra reference */
 	if (new_stream)
 		 dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.53.0

