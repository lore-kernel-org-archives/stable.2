Received: from mail-ed2-f4.google.com (mail-ed2-f4.google.com [74.125.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4C371D10
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562981; cv=none; b=M14Wp1f1E8MfwAoiEgkInfy5toVmJzjHBKdl+XfszAB8lNllpjhvYOELpHtz3DrK+Fk3Ru+HT5+yGqhAJrZqIVC49iAEc0QeqRSB9UwsvCq2crq7gnk9TLmo3qoB5uoPr0Wcddba7gi8pHEbcjEMjo9gNnywG0xRM/2smnAZICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562981; c=relaxed/simple;
	bh=Su6EP/pVvp4qgnM58XIUzGL5lDoF5GVPnlio4fEg5hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IVMwCmutbqR0wltOp+OpIAERiMoC9+NUD7GdoZ0STRpzafj2DlQAp8SNhlMUrWM8XMRb2T4RdOYYX/qOX5Y3e1gzqNHt90Sn69Jn+jRN9gwX/F/txcBPh7Uu+6p8WMUPcP7r0kO3ATpaOqscliSGNa+EibIfQvnsScvA4HGrlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSAymgsy; arc=none smtp.client-ip=74.125.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSAymgsy"
Received: by mail-ed2-f4.google.com with SMTP id 4fb4d7f45d1cf-6a9988c6449so2756073a12.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789562978; x=1790167778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IP+zMj/7tZqqAbs+ICnN9SjIasciypQH4dlBRvF1XM4=;
        b=SSAymgsyh2HbSISyHnGy/1Eg7uaqkpe2PbIGVbGXls9rD8Q8l+hDZIGVXC90bbIUHI
         PiR3Bq4MvkuUZO7ZiSWiAwPf70UJWFUW+AprAriBMpAUHGzj4dujYCdZjzvUSDSxtDWG
         YwXbpz77BPnKk5/bZkZprrJwf8WYJUQueH0D49QhuG3QtnlKW/4F3NKv/7ZFHmFS+zze
         BqnO4hZhlI1HH39CBIyqqrV0NY4WkJER4xBDKI6EfHE3gDLMMvyk2SnaEOdBXC3wQHHd
         V4xo64arXZV+m2UGlRjux/S6oJLe9fs+/zDFEWiF/7zy7fMajeKyGlDQSI7mdSmxVTCl
         HX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562978; x=1790167778;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IP+zMj/7tZqqAbs+ICnN9SjIasciypQH4dlBRvF1XM4=;
        b=HhrLoCya/QaBfXxnwX10+S4MfqK4H9Lne3z/DpYJ/fVf+ocQGm7SOxdh0Orph/jj9O
         25+T6q4BF+c4sOqDRLwfyRw9hkCU+Zj7chlaxJLt93XoIuJqY9wnojwzdohdBS6PgEdH
         vtZhjx3uodGhawQN13YCUuGFExrKZMDEdWcwSTUxGIgosBfq4RDxrNtOgkff/a0YkfIy
         XLlINBmmiPp/OV215E2/J8SIixv3tkm/mBKnG2028Eufw5NotoX2u4IyMJq/xrE0cXYX
         XtPL8EkfgaiVaiKrBy/Q2JfpDx+bwdJMeQDU9YIryfcJKpGlFTbg+QbXP+eCZCidCksv
         3V8g==
X-Gm-Message-State: AFuF++lCMgrT8nvCHmnHfbFJWEeRxgnfwuTFxsKlgxfCYUMCIVbg+h9O
	bQj+BqkKbuR7PLw5nldk+59lUF0GqpM20QuPOheBxT3WC/wK4TFEEi5Pz2sOKDHhCYA=
X-Gm-Gg: AYBFou10WCaSHw9iN0GF2F01UsAAFMyfmvQOXtn9iTHaHXN8nTN5Nug9DsI1JNOA5aY
	kivdDqt5uHv1aiXoB1vzh/I0U1vTBTbwHxjhLC89sFw4MkWa94JIttHu0u/2a63+nARbN0//2CE
	W7Si05LTEAyjLlIXZSGSbTthUPhgj/QFtZ/vuKK0AsGi20w2Huym3d98kC8OZuloUMuBWFuqOMK
	3m4KjsnJfSVYnxWecmOz1XP9XP/FaYq1CezPcPudqNI/j8zEPP2eG0NjesuuEHpScMYw/ZZ2pOX
	rNwGBazV/V2cPwADRrp3duTYDe9jgpt67F+Xl20k1wfMI2P9Wrur72+xNvGA66SJiezClXbW1W9
	fntfOZ57ipQn407Wy4JKU9UgnzOvmi1LNKZ/LhIsnDSdm8HQ+dx8OmDvQvVv6TNdTTKJUUP4T2a
	KLyzNWlRMkcrCKfuIBhae8qlzRNEbsFnIBnf6st8IHoH7hqdX/T9SqajQjH3Fk83PBcQvuJ8zAb
	By6wGSfGGIyCCR7
X-Received: by 2002:a05:6402:21cf:b0:6a9:b523:375b with SMTP id 4fb4d7f45d1cf-6aa22358ffamr3948276a12.6.1789562978036;
        Wed, 16 Sep 2026 05:49:38 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d27ad36sm1543017a12.21.2026.09.16.05.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:49:37 -0700 (PDT)
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
Subject: [PATCH 5.10/5.15 v2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Date: Wed, 16 Sep 2026 15:49:19 +0300
Message-ID: <20260916124922.189809-1-roman.demidov.nn@gmail.com>
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
Backport fix for CVE-2023-53707
v2: Include version 5.15 in the patch.

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

