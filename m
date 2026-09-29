Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43923B0AF0
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669944; cv=none; b=J1yIKNHt93CAqHZpg5EEgA352En2ATcvB00r4cPZNac8dLdnxTN52fAsv71fzMjNCV6QhngrSAkgi6+v/SZ7kFcpDaOjPm6ZTOrawJK4WBCrHN30C/1eg6GtEZF0jw2SJEyZ4Mr2EuQaUppv9Oiqv3ZrqI3sQf2+FraJpcejcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669944; c=relaxed/simple;
	bh=n/Jm4ZGMxhbWhnGBApFYUacHk1vyC69Wbvnz0bnLyyU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=joB6o6WZczkSLd9+ypM2Xp50SFZcSxBZigFl6uwBcPoH8m2TNdxF3boWbbCJt09PWih6D1ZrEVDFPPvWE/RKSbkEsGzZp8PXy7qTD7qMpbOxPPt0Fq60aI6NQMLcuT8hnTy1kmoxvvhP0XqFtSC6fZbz4FAw+U6HHbloo9bwiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2algxLvR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2algxLvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63B31F000FF;
	Tue, 29 Sep 2026 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790669942;
	bh=MQhSk10VBET8X1CC54C4yazYC6BljV/YwRS8i/TdEQ4=;
	h=Subject:To:Cc:From:Date;
	b=2algxLvRwfb2Hp19aIrf83F0FpJNLlzv9L1lhc4UN6UjYpFFSHqDESiUn0OpzZuda
	 +MbbXdyNOeJkvg528gTWXqCYctdn87LF9CE4Hwm/mKHLriH62jOWvISFnPI7XH8X0t
	 IMjCTgH0BuW/GjjLSqvtBD7pGQQPkzXu7kpBKLDM=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix acpi device leak in" failed to apply to 6.18-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:18:56 +0200
Message-ID: <2026092956-elite-error-10d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a997baa61179b450bd55c4810c7ccfed3b753a54
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092956-elite-error-10d8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a997baa61179b450bd55c4810c7ccfed3b753a54 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 09:54:32 +0000
Subject: [PATCH] drm/amdgpu: Fix acpi device leak in
 amdgpu_acpi_enumerate_xcc()

amdgpu_acpi_enumerate_xcc() looks up each XCC ACPI device with
acpi_dev_get_first_match_dev(), which takes a reference to the device.
The reference is dropped with acpi_dev_put() after the XCC info is
initialized, but if the kzalloc_obj() allocation of the XCC info fails
the function returns -ENOMEM without releasing the reference, leaking
the last reference to the ACPI device.

Drop the ACPI device reference on the allocation failure path before
returning.

Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9211ef48b31ec66999cf55e04d0cbc60cd855fd5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7f5abb03be1b..8b8acf98fdfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1167,8 +1167,10 @@ int amdgpu_acpi_enumerate_xcc(void)
 		}
 
 		xcc_info = kzalloc_obj(struct amdgpu_acpi_xcc_info);
-		if (!xcc_info)
+		if (!xcc_info) {
+			acpi_dev_put(acpi_dev);
 			return -ENOMEM;
+		}
 
 		INIT_LIST_HEAD(&xcc_info->list);
 		xcc_info->handle = acpi_device_handle(acpi_dev);

