Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254993161A3;
	Thu,  9 Jul 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596558; cv=none; b=bE9OOXbe7JvASWmvMCAWx8oEVu8mVEozOC3bUkm/Z9J+pW4B1Ok9toNkiLTbZw1F2zIwvTj/qeOjCEfS4ryYQgaRzfdOLab/IeEcKTMGdcU0oHqjp5NKtrK4YW9ySGMOp3zDmvfa0l0fEVT59LA8yZpyoTQWbwf+AUw3j14kroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596558; c=relaxed/simple;
	bh=Jy7jJNK3v/SUlfeTmhEC+Xqc1aZuKwsi6ON7HO9cDoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnqAdNKXKhmQDGACM9LAyc5PwFihX9HSA7zOyBPwvqGruA6+uEteQGdgtYK7/fWT2vMycQkS2ARdsRRLOYAXpmPD1Tqe4L39pBWn6X/IePv0dlKN4QtCb0xnT85N6jSAaBuuN1QAZ2kGUs3txINB0d7YUr5eh9pnfos5ca+AYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=E3/7oeAM; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="E3/7oeAM"
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:494f:0:640:ed81:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id BBEFCC1F26;
	Thu, 09 Jul 2026 14:29:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp) with ESMTPSA id eSI9Ue8f8qM0-mcSpXkng;
	Thu, 09 Jul 2026 14:29:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783596551; bh=Q7tT8J42CoYO2uJ3oGsfu4z5NpqrMLW6Jo0gnDOw0q0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=E3/7oeAMBpKeD//WLixRrsMZjJvjlz6pHufS0fZTLdoaUlqWBbCNdSNI0xbSBxKQx
	 mFROXodS95MX/x0qZtrcUoquMEYALMDY7t3usTTmkq8RnxjZ9+CCD9kPTTTtW8D2MT
	 Be2NmggJN4xksa2pcbwyfTXxxA9pN+xcajFUNoNo=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jack.Xiao@amd.com,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()
Date: Thu,  9 Jul 2026 14:28:24 +0300
Message-ID: <20260709112825.40016-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with scnprintf() to prevent a potential buffer overflow
when writing to ring->name. The buffer size is 16 bytes. For compute rings,
the string format "compute_%d.%d.%d" can exceed this limit when the total
number of digits in the three numbers is greater than 5 (e.g., pasid=1234,
gang_id=0, queue_id=0). This can lead to memory corruption.

Using scnprintf() guarantees that the buffer is not overflowed, even if the
string is truncated. This is a minimal fix for the issue; the BUG() for
unknown queue types is left unchanged to avoid additional risk.

This code is only present in LTS kernels v6.12, v6.6, and v6.1, as it was
completely refactored in upstream. Therefore, this patch is specifically
intended for stable trees.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue submission")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 3feb792c210d..6208967f0e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1057,13 +1057,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	ring->doorbell_index = qprops.doorbell_off;
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX)
-		sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "gfx_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
-		sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
-			queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "compute_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
-		sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
-			queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "sdma_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else
 		BUG();
 
-- 
2.43.0

