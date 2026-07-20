Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5A27874F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560861; cv=none; b=DUEyP+CehPP4FgY6rMixl2UmZ3oQfDM1MWphDiT/DzNr+BuWyxRcO4OOEavklhzIkbp8oO9FgmtZHA2f0zZI+4hF14h3pV6nEY1KX8Olq8KxOKvtpETDebiuhCLuY5ysveU3qfikx0n+TvW1BrtpCf6SUzLMy0A0vaWWx5dwrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560861; c=relaxed/simple;
	bh=u1DBWYYT3Vx9zdCd7hKrqRunqeHkKror4gotFViHj/w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N8sUwMFobXZvGZFIz/l7LY4XrqmfI49PVkCtr8pljHACD+sAHo81y/xU6SNU/nPPlXe8KdzEtBsHvd4JiHARgDW0zhov1F0pNeK9C4+RWeydEcyepnrYvvZFGPJc82zK9JK6psULj0anO6WVLgIjHtrRVPIHFcf8qzhvA5lk0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ad2FZBtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ad2FZBtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EFF1F000E9;
	Mon, 20 Jul 2026 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560859;
	bh=kvmMzFyVQbn4YJ/eQL8rGWPkm3rDG5QooakrSYw+mBg=;
	h=Subject:To:Cc:From:Date;
	b=ad2FZBtqlcolIXIvLlgMnvJEDNacfVus4phwW2DD5liiitwyoAqwuSNisX50fwMrU
	 teGKS19quL0Rj5jH4k7AI/HUqaEbxOFA2Di4ddokExyUXL5qPC5MCzIlLcfTAEzR6j
	 r2zFCWwus3Z+kWwm3lJSKoE7Qgw4f7nYR8EhBGJ8=
Subject: FAILED: patch "[PATCH] accel/ivpu: Reject firmware log with size smaller than header" failed to apply to 6.6-stable tree
To: raushan.jhon@gmail.com,karol.wachowski@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:20:50 +0200
Message-ID: <2026072050-fragment-movie-d688@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ddb44baed257560f192b145ed36cf8c0a412de47
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072050-fragment-movie-d688@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ddb44baed257560f192b145ed36cf8c0a412de47 Mon Sep 17 00:00:00 2001
From: Jhonraushan <raushan.jhon@gmail.com>
Date: Wed, 15 Jul 2026 13:12:06 +0530
Subject: [PATCH] accel/ivpu: Reject firmware log with size smaller than header

fw_log_from_bo() validates the tracing buffer header_size and that the
log fits within the BO, but never checks that log->size is at least
log->header_size. fw_log_print_buffer() then computes:

  u32 data_size = log->size - log->header_size;

which underflows to a near-U32_MAX value when firmware reports a log whose
size is smaller than its header. That huge data_size defeats the
log_start/log_end bounds clamps added by commit dd1311bcf0e6 ("accel/ivpu:
Add bounds checks for firmware log indices"), so fw_log_print_lines() reads
far past the small real data region of the BO. A size of 0 also makes
fw_log_from_bo() advance the offset by 0, causing the callers to loop
forever on the same header.

Reject logs whose size is smaller than the header (which also rejects
size == 0).

Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
Cc: stable@vger.kernel.org
Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260715074206.867712-1-raushan.jhon@gmail.com

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 275baf844b56..716467aa3156 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -43,6 +43,10 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
 		ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", log->header_size);
 		return -EINVAL;
 	}
+	if (log->size < log->header_size) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
+		return -EINVAL;
+	}
 	if ((char *)log + log->size > (char *)ivpu_bo_vaddr(bo) + ivpu_bo_size(bo)) {
 		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
 		return -EINVAL;

