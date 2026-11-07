Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045930;
	b=t1CQq3xWR/GxQVbPuJDJiGNYPYc4+o3pb9QUVi5zs8BSOsPUZ34LG+V1m23ru6vIeFHA
	 tR0YHCCD8fAqKVuyVghxRz8Me7KOSn5IgVEwlTJayM0UaGc67CeVTGILHyLxeBFuLa3WW
	 KgKcwE+Un70b+OEZjsfLhapyXJRbvPGGmPc41izNHvdY3t5SadQcvVk1jP9WZy1DBz9x9
	 gBfvVvakrsJuQJn8qNfWqyvFPQc66fKY1frGHWI7ivTgDGZjWv58SH5kJmRy7uvGbkwk4
	 uMxAL8A27MLM5ovfS6REJwMGVmU7j2/cQTjzemYpo/azR2RImGGcXS26dBBdsN7uNcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045930;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R9+MwXUZo08T9D2A9wc06YMglJD8/4tDLoRHWCVK1i0=;
	b=3HCeprJviddoyevV3bo3kYx8UukCO3IIKN37ij/XF1AbdTjX90a+BtXtClscd6Me0+xk
	 OeIv9fKJE4vyrk2fsGX8295DML8Z7A/tnnMAebXHiJbV9CIk5prO79e7DLxdXma3a5eH2
	 JFdyQz0Ni2gMZkITGuFdpcEjwwjuyCa9uM2HaBWYIyeoEYw9WFvbH5Bz3l++CpbiGf6mi
	 ayLEXG9JrGMaYp8P6hxux+ulU/iX3nbkMbEJBuOBhBTve2TvsmAcRDSrRDklOPa8+wBLU
	 8hMgf903RipAs4xq43Y1AAp5D7O7qx54rMIPWoCMyiLf4adkxEarSTZ1UhUk1Th5S2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoZQQIJR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoZQQIJR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED961F0089F;
	Sat,  7 Nov 2026 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045930;
	bh=R9+MwXUZo08T9D2A9wc06YMglJD8/4tDLoRHWCVK1i0=;
	h=From:To:Cc:Subject:Date;
	b=RoZQQIJRvRmeUjHzho+wZ4Qun7xD2+WqYQjACkK3AwkM0rhHjQbAs2uTn1NXkcfBg
	 A3fRZfDeY4jz+c87lYH2wmftYqaPtyWi8NOXO7da2qmJxMHb6LrT2dxj6rdH4Wm5v6
	 RjEh8UJJ6e/feyN+9TINM2zACLFcAu940dtUl+/tvNF5Puw+sC/6aunADmp3myHrlR
	 rbhQ57jBFwakjdijmYTgXaUob7ivs2y+K9vfpEQEJK1xfrRmB8OeATJ395h3l62uKw
	 IvpOjZ8VWrwyad5EoXcsP/a/8iWiBjgE5tylFzHqLtsUZGIoobCvgqZJIzXy5S9SS2
	 8Xnv+B0gk4Wqg==
From: Sasha Levin <sashal@kernel.org>
To: aliamemis@disroot.org,
	c.stratakis@proton.me,
	johannes.goede@oss.qualcomm.com,
	i@rong.moe,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] thermal: intel: int340x: Evaluate _TMP exclusively" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:28 -0500
Message-ID: <20261107050528-failed-7.3-c4aae727beb2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x c4aae727beb23a736c15b8d53e219da29d791065
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050528-failed-7.3-c4aae727beb2@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c4aae727beb23a736c15b8d53e219da29d791065 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
Date: Sun, 18 Oct 2026 15:22:19 +0300
Subject: [PATCH] thermal: intel: int340x: Evaluate _TMP exclusively
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
without taking the mutex the battery methods use, so it must not run
interleaved with them.

Evaluate _TMP with acpi_evaluate_integer_exclusive(), also where int3403
and processor_thermal probe for it.

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: All applicable <stable@vger.kernel.org> # 80892972ff23 ACPI: utils: Add exclusive AML evaluation helpers
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20261018122220.678822-4-aliamemis@disroot.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c     | 3 +--
 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 +++++-
 .../intel/int340x_thermal/processor_thermal_device.c        | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index 264c9bc8e6454..2262de1e14d95 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -217,8 +217,7 @@ static int int3403_add(struct platform_device *pdev)
 	}
 
 
-	status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
-				       NULL, &tmp);
+	status = acpi_evaluate_integer_exclusive(priv->adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
 				       NULL, &priv->type);
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 965700ee69626..9451fea1f65c7 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -18,7 +18,11 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	unsigned long long tmp;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
+	/*
+	 * On some ThinkPads _TMP switches the EC page selector without
+	 * taking the mutex the battery methods use.
+	 */
+	status = acpi_evaluate_integer_exclusive(d->adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 850bfe7c1ede0..cef1d34f3f538 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -287,7 +287,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
 	if (ret)
 		return ret;
 
-	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
+	status = acpi_evaluate_integer_exclusive(adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		/* there is no _TMP method, add local method */
 		if (intel_tcc_get_tjmax(-1) > 0)
-- 
2.53.0




