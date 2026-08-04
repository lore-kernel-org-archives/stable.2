Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD54330B0B
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821791; cv=none; b=Doc/3obWklEEG422Qa2iI5+rfkziL58UONJ05zHIre8RzXf6cbm0bhRFWGhNj5R35XQznsPrC7txqLSqCmSSPY1gHIawgarDHHjafwOYTh+TIXCKKaLg5J4WpHX5IAfuDWuiRJ3r5ioxv7zuTmV6CTiV5VchS4KwVsbO+16bpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821791; c=relaxed/simple;
	bh=KBTQ416VplzK1ci7gRZLPJUuHq/1W9Ezo8dr/IDuAEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qicVKjOivE0La8aSjI3ctVFUoFR55fTBO1gWxg/TvZFqiEq+7cJ3hiiYcA42AeEmAKyQ9MsW5z7FyaFZsCPM9BsWvrfLltO93o2vmy+lujOXjlhwLTp1tJaNWB5XAzQlEkeBeOFDQ165dpAzqCNmJEsz3DCrEOEvjgBsDBfZkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqDAc35g; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqDAc35g"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c96c92c0980so2499846a12.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785821789; x=1786426589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hkRY/ltFYYzhEs+YCfW2ElzdqnJr+KjWc3ylW6/ZoA=;
        b=TqDAc35gz0K40bPKogEbyBs+gO/vknRQmdozHTUOwoBPhxBEkV2yeYbQrd3v+xWEdo
         QHuba3T0VLVVdNQBMaKp0aS6LteQphRz2g5tNISLwNUm6qpMBTBIBSHklwMSV6ynnlbY
         coUjoUEA1c8lDRkSFkEg67OeDCrHLZrkkutINIdDg/WrpuOuYXU4hw2bwm0ZIpk/vSP6
         OMZL+nLkd3iA5ZTj1IXU8f5pzyF6Clc9Aeb71zp6BysjLp0YYE6iDRYq5cVko3t+7xC+
         Sl98Bz1vF7iJGLM/yLxWGS4hZbyGUajdIjXT9k6mhq9BG8HLr9fQ0nkybQPg0zCJwURK
         MSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821789; x=1786426589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+hkRY/ltFYYzhEs+YCfW2ElzdqnJr+KjWc3ylW6/ZoA=;
        b=isYLvCXe7JvhWYVHvBypCbr4sSp3uCUx2z2ZWVVj7r6iDOwxeWb9vsGopuiX/+Vjl5
         BHv4cV4k++S9OzdDWgqp3XKjHTCSAMOseumFdkEeUsgPl1v7OU7DzEcCxAma0DoELXtV
         zraUa0iJeWVbwUFB3PtUTD+Gbohg7EL7j53MAY0+wZVJ6BFhSfvcYWZwIVm4MxyOFVEf
         yT8isEpqL8qpCJrDOhDipbxXpQTOx4/W7gTh9LnqtIoV8eiGEPoS87+kZnCD4r2wTLxu
         GQ6JqKtJxHmWa2yDD7TroCVEIrtUqF8WpG4Zfn3MbMyJyGqMPMUjTztI831aWxxoigQ/
         vsEw==
X-Forwarded-Encrypted: i=1; AHgh+RoqCgvBicxpi3PLvZ77ebOViJQFkdsY3kx9Vyu0BhYbXhi/zNphpIPwvho2W+62N74RzfPPmyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd122Y7FTFcPematSlxDZG8XTJZptjMsfJfX1acrO9UqXeIx/B
	UmzH6bNvIWwUh3xKopjScrxkjjYy1938JYyUz/RFlZZQjxVZdy0VYOQ=
X-Gm-Gg: AR+sD12lTObpYZOnd7J5HH+3hfYwams0Foj58SE4pyWb/SiAlGLamq58Bs6N4XHkde+
	FvOv3NJaH6YaO2lejinAMiUTQeymNlrNp0M8Q+4aMqyVWZi12/+vCP2PQO0vjdwQCmr6kYZ/1Mk
	8Xn4DGkYacRgqQ0xROuS6LZ5g88erfHM8UgO9+qtssailKCk4xXlcqrmEicSJ4RRDIsfG/UaGkn
	0Y/VNWFFVjYl+w96/ptChu2RGiNAjFLiBlEEO0LTOm0xDVebnN5bFrLKLUl/SddPO8TUH2qDnSo
	WqGunWiQgL/7AXyfhHMwNrB5FPTXu51rtrON6lzn7PRhJd8r4hJFlpk90WxMBJ9ad103nNo99lY
	ob/qbH+cKIPerxE/YdXNTyX1cVvk3Uw10OGOx1iIXNWZ+3/vHxSDd8NGIwjj49zq1ynfuI6LIKJ
	Ozfl018OPr9EFHr7q3kOjxaKkeB88JqJHZTmjwn9hQ99VJNLpJesFpAKI0e6iDwNW6wMxfTAbXJ
	EacMTkl32XMr7WAex8d3P/99I+0A2My8R4vMloI
X-Received: by 2002:a05:6a21:a8f:b0:3bd:4698:e7c4 with SMTP id adf61e73a8af0-3c92a9c08a5mr12412321637.42.1785821788716;
        Mon, 03 Aug 2026 22:36:28 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([58.146.106.116])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04491dsm59639975eec.16.2026.08.03.22.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:36:28 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v5] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Tue,  4 Aug 2026 11:06:00 +0530
Message-ID: <20260804053601.58437-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506180636.23771-1-adhikari.resume@gmail.com>
References: <20260506180636.23771-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xe_vm_bind_ioctl function accepts user-controlled num_binds without
any bounds checking. This follows the same pattern that was fixed for
num_syncs in commit 8e461304009d ("drm/xe: Limit num_syncs to prevent
huge allocations").

While the main allocations (bind_ops, bos, ops arrays) use __GFP_ACCOUNT,
vm_bind_ioctl_ops_create makes additional allocations in a loop that don't:
  - drm_gpuva_ops (16 bytes) at drm_gpuvm.c:2949
  - xe_vma_op (144 bytes) at xe_vm.c:1318

Both use kzalloc_obj() which defaults to GFP_KERNEL without __GFP_ACCOUNT.

For 268M binds, the loop runs 268M times, allocating 160 bytes per iteration.
That's about 43 GB allocated without cgroup accounting before the code even
hits the main allocation (which will fail due to the 4MB kmalloc limit).

Add DRM_XE_MAX_BINDS (65536) limit, checked before any allocations happen.
At 65536 binds, we're allocating ~10MB in the loop, which is reasonable and
won't force unnecessary fallbacks in userspace.

Return -ENOBUFS instead of -EINVAL so Mesa can retry with smaller batches
if needed.

Note on v3/v4: I sent v3 twice (2026-05-07, 2026-05-08) and v4
(2026-05-09) addressing the feedback below, but none of them appear to
have reached the list or Patchwork - likely a subscription/moderation
issue on my end that should now be resolved. Resending the same content
as v5 in case v3/v4 never arrived:

  v4: 20260509172309.58377-1-adhikari.resume@gmail.com (2026-05-09)
  v3: 20260508064510.158728-1-adhikari.resume@gmail.com (2026-05-08)
  v3: (resend, 2026-05-07, same content)

v4: Increased limit to 65536 (64k) per maintainer feedback, changed error
    to -ENOBUFS for graceful retry
v3: Changed to -ENOBUFS, moved check earlier, added allocation analysis
v2: Increased limit from 1024 to 2048 after Mesa source analysis

Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 7 +++++++
 include/uapi/drm/xe_drm.h  | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index a717a2b8dea..1ab020cbdc1 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3840,7 +3840,14 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
     if (XE_IOCTL_DBG(xe, !vm))
         return -EINVAL;

+    /* Prevent unbounded allocations in vm_bind_ioctl_ops_create loop */
+    if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS)) {
+        err = -ENOBUFS;
+        goto put_vm;
+    }
+
     err = vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
+
     if (err)
         goto put_vm;

diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index ae2fda23ce7..33f23f6638e 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1606,6 +1606,7 @@ struct drm_xe_exec {
     __u32 exec_queue_id;

 #define DRM_XE_MAX_SYNCS 1024
+#define DRM_XE_MAX_BINDS 65536
     /** @num_syncs: Amount of struct drm_xe_sync in array. */
     __u32 num_syncs;

--
2.43.0
