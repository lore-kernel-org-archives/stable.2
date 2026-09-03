Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE504C77D9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447965; cv=none; b=NfT1Yl3ve8KclGE4trh/sPH8VPkH9or2DYBq+PC56Hi+aqXPoQOTpR6yHEFf+qv7tDx5DhYIoGL38byMFGXRnJgOa46eFgxmBuPN/+zNVrApq6juKht7HKD4SJ6jVfodQ3mtmS2z7isv8L3r0/kJ+norxizvWFZU7NEdYwKMrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447965; c=relaxed/simple;
	bh=CyFyABs2Z448Vm0UpRIExJhGXCglmy5rV2XwKhwvpl8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qCbVlgrHAfqEbzad2Wg9DhfDr0oQbueC1t+WHZBTq2S4dfsTsLITEtT8qyy1rve+YBk9xYXYuUIyDcWxOTS2LdEYpYOdkZ3Uu+qA0SGi87sh2IZnpvXOE8utOCb64ZyP9+6ls8QXHzgKFgc8hpfwtJbI9BkuJBzI1jmJqHMs1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9MlFZ+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9MlFZ+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344651F000E9;
	Thu,  3 Sep 2026 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447963;
	bh=xMBiqxPwweM59U5q2y8Mk/5XG1cPGcSdQTG9rJw4GpM=;
	h=Subject:To:Cc:From:Date;
	b=V9MlFZ+dw0Q8U3+bcYBliWfvNamqv9QuATR2srdMMYlDuM1ANPjWpiVrchqJ872+T
	 vYQ4sjrmMllGAki/+I9ZqyhFhWk059oYgnMxs6PXo8AGGFVFHgH49ZLep4uVNjQrQu
	 vxPkO14FfDJkGISSJ9VDoXoqiSS7dfHH6Q76knhw=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Validate parameter for frequency and" failed to apply to 6.6-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:48:29 +0200
Message-ID: <2026090329-hypnotic-unaware-0736@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 574b59bb4b6bfcfd1f639d02f1041b314d43a2e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090329-hypnotic-unaware-0736@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 574b59bb4b6bfcfd1f639d02f1041b314d43a2e6 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 11 Aug 2026 15:15:12 -0700
Subject: [PATCH] platform/x86: ISST: Validate parameter for frequency and
 priority
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate range for frequency and proportional priority while setting
CLOS parameters.

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-5-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 8f63694da897..ee2e1ec1b103 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -658,6 +658,9 @@ static long isst_if_core_power_state(void __user *argp)
 
 #define SST_MAX_CLOS			3
 
+#define SST_MAX_FREQ			0xff
+#define SST_CLOS_MAX_PRIORITY		0x0f
+
 static long isst_if_clos_param(void __user *argp)
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
@@ -677,6 +680,15 @@ static long isst_if_clos_param(void __user *argp)
 		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
+		if (!in_range(clos_param.min_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
+			return -EINVAL;
+
+		if (!in_range(clos_param.max_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
+			return -EINVAL;
+
+		if (!in_range(clos_param.prop_prio, 0, SST_CLOS_MAX_PRIORITY + 1))
+			return -EINVAL;
+
 		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
 			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
 			       SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,

