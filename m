Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9F49A3C4
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584963; cv=none; b=ejvDrJaYjLiCzTeLp7/UWvR0krUlb19lxX/8KxT3AYytXFXLE9Rhekg3c8os/HKgfZf9C5IlscZ0FJbcuFJRf909ry4Rgp3hSqkfxGNcu9tiVinNNLz8unqst0q6VrldM8rdJ4NJSwlu1aF7K2L3DMQXqq5xpCc2NjjlSOjVvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584963; c=relaxed/simple;
	bh=ec26kiKkszeyrT5DDYY9Qed4TsJbf6P9hkRp94HymEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP8VcvwuRnF1OZf7u4sSNoCwlkkK5j4EQwQTIWpAaTyZavG4eG1m61BX7+nnTup9z0EHPOBev5otO8nEG/s4p7XVCh5DlCyDM7Dh5CnfPZ7envBKBSaVUG5FryUfhaf8Zn3M0Bwqgez2AI8shvyo/NZLNmMMxS1uk31k4E9GjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBFHc3BW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBFHc3BW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EA21F00899;
	Wed, 16 Sep 2026 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584945;
	bh=I7JViVbZLYy9wkbH326meBIV+p6/YjymzojIf0Dok4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBFHc3BWyl3SthKz7Pyhz93YNgLhq+HlBJ1XDDVwDz5zPywiC9HE0f0tv20UWx5BA
	 zZQfIgCzbLp4ymoSvOt6sD2cvgK0/nZyec6L2PPVsTvAEQeihTBosL8h/hmdER/eLL
	 cNTbuPQwAcZNcruQUOCb+fXxous91ShBLahFfCPtfHYWmERKlbrNFb+cbh2pgCEUKQ
	 eZMWSfaeJh+ZmawoiWy/Xr5/aPQsIJ48m7VQLvGfQOWYTFrVNnNpwlU6R/+Nm2xE4k
	 Zr+FE1SIMW0a6VD7VW6gCUxumS3HIEVKNPdgNa7pEeZRZrECFmXWoW/kjRgZpOFKqn
	 ORxdersbtvoNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] accel/ivpu: Reset fw log on cold boot
Date: Wed, 16 Sep 2026 14:55:39 -0400
Message-ID: <20260916185541.1885084-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916185541.1885084-1-sashal@kernel.org>
References: <2026091601-reply-pointy-7e61@gregkh>
 <20260916185541.1885084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

[ Upstream commit 4b4d9e394b6f45ac26ac6144b31604c76b7e3705 ]

Add ivpu_fw_log_reset() that resets the read_index of all FW logs
on cold boot so logs are properly read.

Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930195322.461209-4-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Stable-dep-of: 0724afc55c77 ("accel/ivpu: Validate firmware log buffer metadata")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 14 ++++++++++++++
 drivers/accel/ivpu/ivpu_fw_log.h |  1 +
 drivers/accel/ivpu/ivpu_pm.c     |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index ccad9aa99e5d6..0ed29e5ac8e52 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -144,3 +144,17 @@ void ivpu_fw_log_clear(struct ivpu_device *vdev)
 	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
 		log_header->read_index = log_header->write_index;
 }
+
+void ivpu_fw_log_reset(struct ivpu_device *vdev)
+{
+	struct vpu_tracing_buffer_header *log_header;
+	u32 next;
+
+	next = 0;
+	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
+		log_header->read_index = 0;
+
+	next = 0;
+	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
+		log_header->read_index = 0;
+}
diff --git a/drivers/accel/ivpu/ivpu_fw_log.h b/drivers/accel/ivpu/ivpu_fw_log.h
index 0b2573f6f3151..692ee0f266a31 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.h
+++ b/drivers/accel/ivpu/ivpu_fw_log.h
@@ -27,6 +27,7 @@ extern unsigned int ivpu_log_level;
 
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p);
 void ivpu_fw_log_clear(struct ivpu_device *vdev);
+void ivpu_fw_log_reset(struct ivpu_device *vdev);
 
 static inline void ivpu_fw_log_dump(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index ffff2496e8e8e..e17e4e6b037ee 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -30,6 +30,7 @@ static void ivpu_pm_prepare_cold_boot(struct ivpu_device *vdev)
 
 	ivpu_cmdq_reset_all_contexts(vdev);
 	ivpu_ipc_reset(vdev);
+	ivpu_fw_log_reset(vdev);
 	ivpu_fw_load(vdev);
 	fw->entry_point = fw->cold_boot_entry_point;
 }
-- 
2.53.0

