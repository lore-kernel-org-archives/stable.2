Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4835C68D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371663; cv=none; b=JUKM9ccbSYJ2/Rn0Qo3/ifLhAMJWkVN52/MjGc/tyVdeWSWPS/jM5nzgqgckqtKmP4b8plIDkFb43BSwk9k516t+ymS9TZl9ZMWlQicTmzjrv5YUZzoYtmANgLTDFnnPWmIfgcr0+iW8Myo1cSmNMnvNZ5j7aD/pZJqhp12gXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371663; c=relaxed/simple;
	bh=zmkCEVRXJ2RjY1tfIyBwhvIpFzfLhR7uGNvI0kN6wAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c/bVqsx8xxwYEwk8h+mMOtSjKWP4g0i96WLq8seJeGOVVd8TNyNphsjj0WZ2BsKt5G3OAe1JjxJROZozMVY4GZlX+z9IGZ9h/sJy/2NHMSja1naPScpjYTX57Obfcw128Kij2XBCXAJczpn5Rf/5TJqO4y3mh/CJsgFO6QScaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1cu49bD; arc=none smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1cu49bD"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a4f7261b56so18862421fa.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789371660; x=1789976460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpZ8aiz1nJMHc4s8HTwIf+eLIqHawFVPZ8yiJXV3xqE=;
        b=T1cu49bDWfcU9imyd+QhW8vasAKjphh+CXjTvp48a1/dEziZ8wYXa99MezbQEdfWpt
         tgGn0rdu8NinwtH/dPvAgTBLXuS6KHr9jL1neogRyCQ/XQDS5FhC1iBAS5zEcpVWvLV4
         OV1dI3dvemxCoh8Cxv4LeAGOgRHofW6c8A6pyYEyKvLWzMheTheD9oZcXesYT3uZ2zMP
         I4yuWLLVLi8guyQXJ6Ot5PYrM4mFY0bsG1IIDOXXF5KbegGVZY8R3sFPlwtZhd7Hfnbg
         e+XCfeNmfDITzHm/VkoyIElhENy6MxTAbzSAfFkZ8/X5B9bwYJqtaC3bzHiG6ebQk2l2
         Wg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789371660; x=1789976460;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cpZ8aiz1nJMHc4s8HTwIf+eLIqHawFVPZ8yiJXV3xqE=;
        b=JOxWLsGSJCKODuvCtDTlUVTkW2t+As+lIrqkLtQZwJOj+wqCJJnnvPhRoFrSRMCzgU
         3C9O7mfjl6ljS3xflkxtG/EMlnxhLAH0v8gb0tDM9GXrjbavfPY2INx/V5Rov9ZjX4i1
         PSWKcoCmdkY9CjvvlxK+kvYIBCmX7HqAG2oBNRh14eJhdsNBDpc09M7cHgxrgCRcv0Td
         pUhjac37hBeWbf8GstTi9r2TIlvlo9oYZmZM9ZElPjCxQKSdzTKBo/Ke8qIomq83eBl1
         R5foJsfIbEtA/LbwQuWnXgr3cnZ+y/7zmZFx+XAd4Yp8iLS0rZxjS6OA/75ULqFwsnAM
         pCEQ==
X-Gm-Message-State: AFuF++kAqj25Z+28jCbySqJXLtmiaSdQ7xjJKpA/WecCm34DymABIaEw
	r21CPzW+fl9lFxOgy7gwAz26TXJefpdo97rHyETaQr3wibIZdGZadQeRcIG0yw8Pbuo=
X-Gm-Gg: AYBFou3bnNfl53jyriLQbSh7AcqF9hVJsY/RaPD3+iHltgPIE+PRti/JebOV9t+a+vo
	eFY7L8X7aRaaSjcQysmEi4jwvf7wZoREwPBh6wCLHmIttH3KjBqFKrRAn490IMHKFRMKUVKs6bt
	jUezhGIVoZbjbf+pgpWm588sV+w2U938AUtUU4rK2Gm/CZSbp+/ktiSb8WJQycBRoQ6xPBwsmcc
	8cr7F/28m/Vinc2loVwxzxcvyFu+tKDU0L13rbr45hNIvcsMqPBbYZkqxb2fcEKsKZXw+WxXqrv
	BejWqagGzU6lvQZdCyfDJUZcmq1j8C6Tpj5PIAmDHBHORVvdx9QI+mfIrhd4qWivNlEHpOP4saL
	QdFS1CrkxYgLSBmBof5HaBejg3dmESMckw6sTopZPdnhGFr1/4BtAS31EpcwQmWf3TZigXmdThR
	gGfbGBsl2CyzwWXliOK5ia4uwlCwSs3Z0wF3WIa4IK/yBtsqGvFb+2D8jul5CDb+s20EwGITEH/
	tHpKfBUV71/AyMU
X-Received: by 2002:a05:6512:1053:b0:5b8:ab9a:1e97 with SMTP id 2adb3069b0e04-5b8ae6b660dmr352514e87.57.1789371659553;
        Mon, 14 Sep 2026 00:40:59 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a045726fsm2241169e87.20.2026.09.14.00.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:40:59 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Yunxiang Li <Yunxiang.Li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Candice Li <candice.li@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH 5.10] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Date: Mon, 14 Sep 2026 10:40:47 +0300
Message-ID: <20260914074050.10384-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: hackyzh002 <hackyzh002@gmail.com>

commit 87c2213e85bd81e4a9a4d0880c256568794ae388 upstream.

The type of size is unsigned int, if size is 0x40000000, there will
be an integer overflow, size will be zero after size *= sizeof(uint32_t),
will cause uninitialized memory to be referenced later.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for BDU:2026-01386

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index addeda42339f..4e20daa34305 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -100,7 +100,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	struct amdgpu_vm *vm = &fpriv->vm;
 	uint64_t *chunk_array_user;
 	uint64_t *chunk_array;
-	unsigned size, num_ibs = 0;
+	size_t size;
+	unsigned int num_ibs = 0;
 	uint32_t uf_offset = 0;
 	int i;
 	int ret;
-- 
2.53.0

