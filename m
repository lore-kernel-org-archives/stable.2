Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689586;
	b=mLO6axtl64WUIult9Z6iVOS0F0NtMCsShsffs1tzPyNOPiAs4kxmkGtGyM1o6/p7mlk3
	 DVeu6Xz3c5cBut1d4vO4iCLdIWI7zTMrTTBVSQhXCylEpXL9fyOwY3sxAOzw5A8PFhuQY
	 QD/FdIiJnsoBASp7K3TEdujILaugbSg+fj4a1L8fDHV5ari0ECpQEWhwozs6PzUcTjgow
	 lKaxYfkq+oCVKHhe/G6t/xb3DU2vbbEjccYhx/nhUmINMqYuF5KEvy7/hW8oGFvgEa590
	 Z6MmDdpJnZCIhtt1UWXw6moJsSJogI6j2zCX4MTb65dMDHGF72pntQPSMGHgv8oPMeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689586;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=lzx1z1WsCZ9bJXMmnAsRLv8NJqpQ4NgCzrf2v7mt/sg=;
	b=GhPQ2Ty9NTbcf8v49awaKJA52RfpYO7JnZ85/RnrrqDBlF2/UKU9ZhV905gVf5EDvN01
	 OYE8ndIppG9d1DDIDqdf37U5pN4ilo4ZUPT3TUUyYo8WJRnz44I6A4v6YNEi3UjsQqtnw
	 +SJ+mccYFfu1CfpKyrNPM/Fe4AxLkLaGR3zPUZWnPlf7uNhV8k1XD4u2MAGVsnefW6m7e
	 fzvL0bZodrzC0dD2DWJQ972EYO6Ec3PzuQm2ySgpjOsH0HEhQ3byWCZZkjuzyGNzq/jhf
	 ytseYscBq6oU/jjTV2tEKFUyx7fKWt5Fram0O5QNYEHs33pQ6P5+knvEsxhIQ1gbHKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6024606A329;
	Tue,  3 Nov 2026 07:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6024606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3hpfsh+lq8Kw5AA--.4349S2;
	Tue, 03 Nov 2026 15:06:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/jpeg: Unwind late software init failures in v2-v4
Date: Tue,  3 Nov 2026 07:06:29 +0000
Message-Id: <20261103070629.1083890-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAB3hpfsh+lq8Kw5AA--.4349S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW3tr48Ar47CF4xAr4fZrb_yoWrGw17pa
	yfZF90vr18ArsrtryDX3WUZF4Fgw13XayrWrWUCwnaq3W3Ar95trn7AFWUJ34kGFZ2krs3
	Jr1DJ3y7uFsFvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUO2
	NtDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQAA2rpWfWRkAAEs0

The JPEG 2.0, 3.0 and 4.0 software initialization callbacks create their
rings before allocating register dump storage and creating the reset
mask sysfs file. If either of the latter steps fails, the callbacks
return without releasing the initialized JPEG resources, including the
ring buffers and vmid_wait fence reference. The IP block's status.sw flag
has not been set, so the common error cleanup skips its sw_fini callback.

Suspend the JPEG work and release the JPEG software resources on these
late failures. amdgpu_jpeg_sw_fini() also releases the register dump
storage if it was successfully allocated before sysfs creation failed.

Fixes: 63d5f8db5313 ("drm/amdgpu: Enable devcoredump for JPEG2_0_0")
Fixes: d949e91b42f2 ("drm/amdgpu: Enable devcoredump for JPEG3_0_0")
Fixes: c3dddd602967 ("drm/amdgpu: Enable devcoredump for JPEG4_0_0")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 72069b77f6f1..0707e065160a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -115,14 +115,21 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_2_0, ARRAY_SIZE(jpeg_reg_list_2_0));
 	if (r)
-		return r;
+		goto err_jpeg;
 
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
 	if (!amdgpu_sriov_vf(adev))
 		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		goto err_jpeg;
+
+	return 0;
 
+err_jpeg:
+	amdgpu_jpeg_suspend(adev);
+	amdgpu_jpeg_sw_fini(adev);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 564e40899df2..f88200bcb2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -130,14 +130,21 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_3_0, ARRAY_SIZE(jpeg_reg_list_3_0));
 	if (r)
-		return r;
+		goto err_jpeg;
 
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
 	if (!amdgpu_sriov_vf(adev))
 		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		goto err_jpeg;
+
+	return 0;
 
+err_jpeg:
+	amdgpu_jpeg_suspend(adev);
+	amdgpu_jpeg_sw_fini(adev);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b29ca3a49939..454f16f24d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -141,14 +141,21 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0, ARRAY_SIZE(jpeg_reg_list_4_0));
 	if (r)
-		return r;
+		goto err_jpeg;
 
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
 	if (!amdgpu_sriov_vf(adev))
 		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		goto err_jpeg;
+
+	return 0;
 
+err_jpeg:
+	amdgpu_jpeg_suspend(adev);
+	amdgpu_jpeg_sw_fini(adev);
 	return r;
 }
 
-- 
2.34.1

