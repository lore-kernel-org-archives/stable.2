Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14231F9B1
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230266; cv=none; b=Lsi4Im5EFlsEABPQb/sj40NKOcL87BtaKXcqC2eCUKecFJw01/zTZ/xBbp3SuAMdhDePLgN3pUhDlUNh/7mNg/snDngqGS9Rkt5ga53/bg+g6/hNu/eXKTTIZiVC6iWQ2Vq75hvw/VkdyrG0WhOopWS7CK7Earfpet3gIeObtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230266; c=relaxed/simple;
	bh=m768JVp1cTf7pCGcBCjMfVNoM9m+iIJdNzOjTxVllWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZHC5odNbmLE5duabuy1pEGmmR3bv+AHFyaer9TA7c+vHJcnUu11DnCTflMGia3Xir+x5jlK97y7vt/t59yrMT2kyo2E+6CGurfEAS/9jiONTzZ2WhrSb56qZUNVNwNU605I6Q77/BPd5dAR2i98w04DPAyNMRYtV/umoMct+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRdt3MKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRdt3MKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C971F00893;
	Sat, 12 Sep 2026 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230265;
	bh=lbxKCkQGg7MZTmWQC1k0z0x5Xb/lKXLuMd/AIkhYMrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRdt3MKsfPXkcvOZe5mXh6j6J/LzuIs1AMUJSQiBSCAYm/CXdueMbFj/137fdjth/
	 h27IyGnAJfMmp9qVQ9KzMeRmG4B/QRV2AVJkmrtNyrFdWCzXRtQM/lejjLswzhKHL5
	 G1ql0G1ZSUPFKE76264GkWVklHAQEZNYprEz9KT7NeToL8bHFc4Hdyg5x0klNR/WEt
	 iUC+ynbcviVozDAYw8gJX+lD0ak3HKG5FOfkqqAbSU9d5eDTkkL9I9uMmEbHQBd6ZN
	 8a82QwV6lQelOvEncQxDfmKlBA3FCKpHDb1xn7rvI3OzkZ4lAM37xKvKPg9W/sbDvF
	 xyiXve8XstEuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Evan Quan <evan.quan@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] drm/amdgpu: make audio dev's D-state transition PMFW-aware
Date: Sat, 12 Sep 2026 12:24:21 -0400
Message-ID: <20260912162423.3655323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-washstand-timothy-3b64@gregkh>
References: <2026090919-washstand-timothy-3b64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 415e51bdcfa0e724172f66ce12d8ef7819fdd1c7 ]

To correctly kick into BACO state, the audio dev's D-state
transition(D0->D3) needs to be PMFW-aware. So, if the audio
dev entered D3 state prior to our driver, we need to bring
it back to D0 state and make sure there will be a D-state
transition on runpm suspend.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: ef5fcf2a6c32 ("drm/amdgpu: fix autosuspend cleanup during removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 93a4b52f4a73b..aa887327aa726 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -122,6 +122,22 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_unlock(&mgpu_info.mutex);
 }
 
+static void amdgpu_get_audio_func(struct amdgpu_device *adev)
+{
+	struct pci_dev *p = NULL;
+
+	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (p) {
+		pm_runtime_get_sync(&p->dev);
+
+		pm_runtime_mark_last_busy(&p->dev);
+		pm_runtime_put_autosuspend(&p->dev);
+
+		pci_dev_put(p);
+	}
+}
+
 /**
  * amdgpu_driver_load_kms - Main load function for KMS.
  *
@@ -202,9 +218,35 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
+
 		pm_runtime_allow(dev->dev);
+
 		pm_runtime_mark_last_busy(dev->dev);
 		pm_runtime_put_autosuspend(dev->dev);
+
+		/*
+		 * For runpm implemented via BACO, PMFW will handle the
+		 * timing for BACO in and out:
+		 *   - put ASIC into BACO state only when both video and
+		 *     audio functions are in D3 state.
+		 *   - pull ASIC out of BACO state when either video or
+		 *     audio function is in D0 state.
+		 * Also, at startup, PMFW assumes both functions are in
+		 * D0 state.
+		 *
+		 * So if snd driver was loaded prior to amdgpu driver
+		 * and audio function was put into D3 state, there will
+		 * be no PMFW-aware D-state transition(D0->D3) on runpm
+		 * suspend. Thus the BACO will be not correctly kicked in.
+		 *
+		 * Via amdgpu_get_audio_func(), the audio dev is put
+		 * into D0 state. Then there will be a PMFW-aware D-state
+		 * transition(D0->D3) on runpm suspend.
+		 */
+		if (amdgpu_device_supports_baco(dev) &&
+		    !(adev->flags & AMD_IS_APU) &&
+		    (adev->asic_type >= CHIP_NAVI10))
+			amdgpu_get_audio_func(adev);
 	}
 
 out:
-- 
2.53.0

