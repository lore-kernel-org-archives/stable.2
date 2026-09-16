Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2B418347
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588872; cv=none; b=sOYK3sgkKOU32iMJYTQhL7RwsRCLjb0635FA0gyi/JhEhXuymyN/G0yzDlLnWge5fCE5khTcMcU4U298ge2G7F02wEQYHgpxO8hnCr4R5n9HCR/hc+HhYFFVmH8JhbsHyCA4ZxnJDLVgAy15ukZggGXsN4+YZ4DdI6zP6vancXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588872; c=relaxed/simple;
	bh=F5GK0iZE/5SK78Pn7B7F4LhzfxEK/6v587aaUrtaCy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqcEA6zq9/FQTChV8YxfiWoZ8LavgmuoEz8IYD1KBV5K+G4Ndbd9NS2EJoDznwIPOirFpZjSjwvgrTeZOsVq0fYjxc+08s/Yju3/1FVZaT0igySB7kKCPPw2GeNqn68Y8FMCYQcI9+KglfmEDFIj09Egxy5vjyDs3bNTnKWmOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASdAeqoY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASdAeqoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615551F00898;
	Wed, 16 Sep 2026 20:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588840;
	bh=U+Y3Edo2YXPlJKLZkOQ8FwgwKKd9bEjK4La4yYExhTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASdAeqoYNEwahH6nIdlUIZh/4H77DWZInzbEY9swEEkx2Y80Is9MGdF9LU51Bgn/6
	 w4A6hwmpask/jFlSRLX1ZNREExBn7v9e/K4d8MREIrCVNPt88pDdpnHAi97Df8IIrr
	 CqRtuVqjKiWKQJlM+xxCUVioCHaF/nBJjn9Ultn4R6Niz5CyvqzjKKZlOwTJzG6ip5
	 Th2Sl+60BB/CPh1+s7cVHVVjx6h1ADmy76YoFPrrWlm6cwl4UT9Dz8hnHVXw75wUXu
	 oCAFr4xo3jI/+B8Z42GLFJyJTv2MKp2l3JHxunb0IlhfXwRjnX1zlNUmsjiEZxG7x2
	 /B6hlxRC0oxOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] accel/ivpu: Reset fw log on cold boot
Date: Wed, 16 Sep 2026 16:00:36 -0400
Message-ID: <20260916200038.2459399-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916200038.2459399-1-sashal@kernel.org>
References: <2026091615-moisten-showy-63d8@gregkh>
 <20260916200038.2459399-1-sashal@kernel.org>
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
Stable-dep-of: 95bf070f3225 ("accel/ivpu: Limit firmware log name prints to field size")
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

