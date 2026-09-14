Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com [74.125.230.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943518A93F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373816; cv=none; b=hkJPUmmEMI+NSztdXW+zo+qmtxbNY3JxPXMsJ8SHNyrhTz63FeMjasrFu9pVGhjpbVff5KYwU3C/2od4zActqh1d7dHqr7rA2o83T172w7iK/Czsysij43WvhMMXUS7eFzsCTqDK2SOPYXKpYIZsOeKMyPjNtMZad5GZvHYnx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373816; c=relaxed/simple;
	bh=DKZ5vtkPHXpunfwC1+ArGnyFJmrNPzcNvOvYpvbQ5MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phxWD9Pl1mcVe4Mkfa9dPyK1kOvSFUJ6954TDnLATCTn5SN2jtMRfYc6D6ZQ9kFC+R2kBnBU1X0z6RjWN/ebJKCCDwmo6r++Ep5LZDLthHFFPjqG6p2r95e25JM8ZHolPpx0TqMrvrnDgCuju+J0eS2Dvb9/aKc/dznVGgvZpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IipA4YkY; arc=none smtp.client-ip=74.125.230.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IipA4YkY"
Received: by mail-lr2-f11.google.com with SMTP id 38308e7fff4ca-3a49e9e7cd8so18428311fa.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789373813; x=1789978613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUYPK83osLZqDNXLlGB7lbQYloWd+rguo+bEtxrEyi4=;
        b=IipA4YkYsG7UQGsFqzP1MdhFLRizwi1v+r0xMRgkFrvJeoNFiyziWAVJ4QJtvNg4u7
         bDi1XwsS8ErVudafjAWCdQZ/qpdZbAH2qBLiTib76wYf8TRnneWoWVHBIRU9Lnz6RIJy
         CF4UdaD7bY8E3s0VEGxXbqsJwajXZYHAubuZCANdpjRBFEtGahdXr1Bd9PdJnWef1YbA
         TEgBWKSX9PFPIp7Kf1h6gvcQfPX12+dL4K+Tg5E+SARvXh4f+dGiuOtnS2QavfuoLDDc
         B64zgZlyDr0Y4qA97xD2sqOTeASzY4M5nZfhSC89ieDLqgYhnUu7q5H5wXVeLVl7SUc/
         I4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373813; x=1789978613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUYPK83osLZqDNXLlGB7lbQYloWd+rguo+bEtxrEyi4=;
        b=KldVddab/frJlNhXrqvGExqZYzTV7F3RmFqAIUFDWTGE0RNOyr1c/0TWXDSGAF2t/i
         jTzAVFjuN5W9uoJK/8YbaB+R83fWi5rsJfeoFx0x2B4GrT0W3tgdTVUHXn6wWXLC5kNJ
         I1VEYNmB47y75AEH82wGSAlogo0jlqHFdROwZs93tqB1/8MQMB0tbAzppfkcm7VYbywF
         gJqUpBxiTyygk6JvyC9Sv5BmL/H9X0vClSKgkeu3zYdEsQFB2dOcX5PY6tU6xzX11Y/T
         HmWSHDZPDd/I3Y8xFx0eMhUsDW6P/K2BOrU7A/WoReXkmqRosy1k6LRUeXc6tx5STgg6
         hvtQ==
X-Gm-Message-State: AFuF++mwv5lj4EQefgs37R1GwNRQw/z2lHYDnEoa7W5pDvKirHpwfwpu
	RNadiX8S5S4Z95pJNWfErxV8MWrHX7Rc2T8+v1RpNNoEE3HIpNMtr1vAiKGsWiHdOSw=
X-Gm-Gg: AYBFou1AJXGKihy+QgWbDl27hDJqJWpMNvGSxhFevSLV1r5EIBXn5Y4//EfkaEAcLZe
	QJH8APtFtRSPxDPX2GGjgqq117Ilstr/9YRSVYsmyX0QdGVyHScUDlGh+LT0kdKIusdpwqcYJrR
	7uC+uC9rNQMyFtmzXCMwYuAUzFgwHn6R2BKJPCFIANrKoHcXXBPrJUreLC7egUmxdjYSsRy7E/k
	NoLjEhNxzyBoVZ19RtZKuVnsjQKcc+EIsRlYhXULmfvbmdY2tsFEImAXldMlzfi034P2Qw55ehd
	5Mfzdf6fz7nOS13Dxj/V4Y9Gyvu5dyE/o3MNEDb1nEbyCYYH9hAIp+uumlw09X3bgWHTR+2lMEH
	60UxKNq9xGjgxQ5GcoG0s3TnubRN29869cV4tN8t3F8eZxFmiM61KqvkfSksqFsFdaH58MLZDvw
	fPnNARbVGUgnX6XFL71aiVI2LJJtGPBT9PMzXD7tumSmcMsy5p4bpOeZ/lGFLvmczhLo7kHwtrJ
	EOLVJ6XdD0bU+mt/w==
X-Received: by 2002:a05:6512:3052:b0:5b6:1a7c:fd94 with SMTP id 2adb3069b0e04-5b8ae6a92b4mr321128e87.58.1789373813016;
        Mon, 14 Sep 2026 01:16:53 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a047ab97sm2326043e87.76.2026.09.14.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:16:52 -0700 (PDT)
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
Subject: [PATCH 5.10/6.1] drm/amd/display: set new_stream to NULL after release
Date: Mon, 14 Sep 2026 11:16:35 +0300
Message-ID: <20260914081639.12512-1-roman.demidov.nn@gmail.com>
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

