Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496331;
	b=p2WStUw3ZlniFxLYt0U3QLyxFdn6fJwLpU9K6RLoFSVRTZyu3oEDCs7l2czv/XwDDq9A
	 wPH+YK+x02DZ3xSZEJ70ZRFdetzM6JK8O8cUXBt4WLNP/92ibXXdk/S0INjmagcnDx/Cs
	 SJpLrCk9uJlA19DEbI0Ms/m1V4/LPb7FsxNkWVKPDUpYiX/eLMPbP6YCHKMX/pxv5Vw2V
	 UTMaNCLpleXUWrqm/rOuGOGGDGl39F8xiGxxN7QhD4RRbyafMDX40YsKQMQHC4gaH9Ru5
	 bJrQe8EAZNstFEMjalL3HCqzonkEmTvFFFIajlIFYsXihWYKXq5q0vvjFquC56oUcIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U5YuqJ1RNYNIpnrJqD32N6NRCNjg2qumNEcRV0y+9+A=;
	b=WYszKba3LFIaafaLqx8A9KAFb6XwKGx3sAcEjxWBMqrZ+sXOPibbyggl3yZLHWFx1Yrt
	 f/D4vE7O3KSN6N3Fr7al1qypfKOAfRKo/hBlw9xKGPsWa60OasaRurOFTH0gngt94/yTb
	 WHZJYdUhwdttMPyzGV+TZO6H96M1xVVIDY9l1zvAcDlM1WcvTeH8wCYe5ESXpyxX4rtd9
	 MBSrPFn2r11fHygeZDMhW+m9ju0RcimE4ohawCFJBe20OJGq9FPnSZx0MHibCXFPIPZmL
	 It8rwRroRDYHHx20+1udFFQcxKzN3ovgU6iz9Ee1BA3fxlTZ61iPfBWQKlkLfUIu9kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzqmsNhJ;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51E606A31A
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 01:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA51E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzqmsNhJ
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93efc0452b5so124636885a.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793496330; x=1794101130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U5YuqJ1RNYNIpnrJqD32N6NRCNjg2qumNEcRV0y+9+A=;
        b=zzqmsNhJEDMfPIIaAUYX/v6Fsch4Y8lYJ6s+0OBgZ+huSDth5hcGBiCf15DYpEXHsg
         IbTfx8bbGq26DkTqtABxRXxXj77WOvUGw8HdvBpUI/6rIhDnE1CZLEzFQr1V4kFDN5U/
         XVlnccDeWIW3pd2Zc8+rzNroxTgI6GQl8EsV1hS1u9S2lowukjlLaCqfNvD/sqsenqlj
         QY75ozAVw/4pN6uimjn7NoZUR2rqO6E2py9zo6vYlGCS/N3ulpxIq9lZDttem6amnspu
         9ya5W0x4GkM707xUs0MGf0GtNSyGXnNpgYBFZxQdqYGDNNobZh37Ez90AvV11gNz6AGi
         tKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496330; x=1794101130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U5YuqJ1RNYNIpnrJqD32N6NRCNjg2qumNEcRV0y+9+A=;
        b=0dWmK15VS4bT+9/woYpDSRFlU6tB4NWlxZyFQHa2izGe5rsw44zHfYrSdWoiCFsLsx
         JzXquLnL9RuZb2/a7jV0BjBsZAdf2w6AGEn+2xwwqpH6+KE+elowkNDgE6nWn/vQLx2u
         ug8FoXGS381JcADQ8dTtLDwGnDiFIZ1ERxbv54ThMXSziJvCkP3Jdk+paBbg3DXnorgl
         rEwqz7Y82trRPReZlD/IdhCdQeVTwS/oH4D5D4zRVpxd9HO//CHxRJvlGSsjyGNlgOlj
         rEk0WbKqrqXOh+UqNArSCMTmEb9lmoQY+GP7ijh9Ofa4APweEbw2Gci178BU0Cdo7Ntr
         nYmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxegQK1QQkN8Q2rXDGZ1rVkpr5W5IZF1+VsWqtw4uXq4hHrbAG6SV5pmPNsvpWa0lnnLzvbBVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0i+pYqbZ41XIiPL4HBnTMF/+wjbdjhvWJ/aJ45uwwYXh5rTo6
	fc+9oSKct3FKjaWYDKF68kk9+u6asAvDce9pkChROYPUx65jeJ2JVY2B
X-Gm-Gg: AYBFou1YO/NSJoWystnJyc5u9pHJPG2T1tikN33rUBmQtULYK8J1+n99FBXsKKVXZGu
	fVEU4ykm6xScfW2vChH5LD1DE6fh5BRYZjFO8lj+6ZExctIb9MSxTwq03eLAIXpDXdLPATSAtYj
	hdoyc9xRlu9SbIEP/BsYRijJk6V0fToNKNKAhnsfjlh56nv5o4gPv0wanfPC00XwkO/6PU5hMfl
	cl2OtRPCwrJQIZyHxCy5hW+k60zZMOZ9TU/joDzvQe4KLxh7wSIYNOuQIjMyzE0IjcnVDDIKXR+
	du+lMapHk4r35siNTrwHkR/gRyjg2GquBo0pz328O8Lf0tTYkyBNaZQTisaWXYFtdIfu5O8xN1M
	35VfShnWcHMgf75RL6Kvo3CZGHokl5IrAty31CE0/PvcxNcoJZfr3hPaytobgPrrIfQkZCAkzzP
	GKjF7rtsxcaSJVycEmqNA/wrYTd1bLDAs9tFiI4AlLhIHLEr+hf9tRQaOeNQMn5u3AxKMWUFy1p
	XdVHMuPH+z/aBFRVVcE/FnQymZWtdnE9o3oj1d5KCqVSDneglQjJdwRt+H30QeerQ78seoNNDrR
	cDGuXoe9867wI6sirXudr2KX4mWS43o7ltWyuSu2xki+scRdQIUhitqUMCAGWKOBLyFhnKAjhOw
	m22H1o+rcPb2BP7TujLlKOq/mAzaHT/AIURa2
X-Received: by 2002:a05:620a:3188:b0:943:ff70:dc00 with SMTP id af79cd13be357-9442174fc9emr1039734385a.56.1793496329626;
        Sat, 31 Oct 2026 18:25:29 -0700 (PDT)
Received: from olive.mynetworksettings.com ([2600:4040:b076:8700:60ba:f09c:358e:e7a7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ac5322sm493379285a.39.2026.10.31.18.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 18:25:29 -0700 (PDT)
From: Matthew Krebs <matthewkrebs8@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthew Krebs <matthewkrebs8@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Only take the VRAM path for KFD device pages in svm_range_dma_map_dev
Date: Sat, 31 Oct 2026 21:25:00 -0400
Message-ID: <20261101012500.7048-1-matthewkrebs8@gmail.com>
X-Mailer: git-send-email 2.43.0
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

svm_range_dma_map_dev() treats every ZONE_DEVICE page returned by
hmm_range_fault() as VRAM of the range's SVM BO. KFD's own VRAM pages
are MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_COHERENT, but fsdax
(MEMORY_DEVICE_FS_DAX) and device-dax (MEMORY_DEVICE_GENERIC) pages are
ZONE_DEVICE too. They are system memory.

When a process maps a file on a filesystem mounted with -o dax and lets
the GPU access it (for example hipMemcpy() from the mapping, which
registers the range through the SVM ioctl), the range is in system
memory and prange->svm_bo is NULL, so the VRAM branch dereferences it:

  BUG: kernel NULL pointer dereference, address: 0000000000000078
  RIP: 0010:svm_range_dma_map_dev+0x13b/0x300 [amdgpu]
  Call Trace:
   svm_range_validate_and_map+0x600/0xa70 [amdgpu]
   svm_range_set_attr+0x450/0x8c0 [amdgpu]
   svm_ioctl+0x62/0x80 [amdgpu]
   kfd_ioctl_svm+0x5e/0xe0 [amdgpu]
   kfd_ioctl+0x532/0x680 [amdgpu]

The process is then left unkillable and later KFD calls in other
processes can block, until a reboot.

Even with an SVM BO the computed address would be wrong for such a
page. Take the VRAM path only for device private and device coherent
pages and DMA map every other page, as for normal system memory.

Fixes: 1d5dbfe6c06a ("drm/amdkfd: classify and map mixed svm range pages in GPU")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matthew Krebs <matthewkrebs8@gmail.com>
---

Notes:
    Reproducer (needs a filesystem mounted with -o dax; an emulated pmem
    from memmap=4G!12G and "ndctl create-namespace -m fsdax" works too):
    
      fd = open("/mnt/pmem/file", O_RDONLY);          /* >= 64 MiB, on DAX */
      src = mmap(NULL, 64 << 20, PROT_READ, MAP_SHARED, fd, 0);
      hipMalloc(&dst, 64 << 20);
      hipMemcpy(dst, src, 64 << 20, hipMemcpyHostToDevice);
    
    An application doing this (hipMemcpy from an mmap of a file on the DAX
    mount) oopsed as in the commit message. The minimal program above was
    written afterwards and has only been run on the patched kernel.
    
    Tested on Ubuntu 7.0.0-38-generic (based on v7.0.14) with this patch
    applied to that tree (it applies cleanly), 2x Radeon Pro V620 (Navi 21,
    gfx1030), ROCm 7.14, Intel Optane in fsdax mode, XFS mounted dax=always:
    
    - Before: the application oopsed in svm_range_dma_map_dev on every
      start (3 of 3, on GPU 0 and on GPU 1); the task was left unkillable
      and a later hipHostRegister in another process blocked in
      __synchronize_srcu until a reboot.
    - After: hipMemcpy and hipHostRegister + copy from the DAX mapping,
      64 MiB and 1 GiB, on both GPUs, data read back equal; the same on a
      non-DAX file; the application (an LLM server mapping a 111 GB model
      file from the DAX mount) starts and answers requests. No oops.
    - With dynamic debug on svm_range_dma_map_dev, the pages DMA mapped
      during the copy have pfns inside the pmem region, and KFD's own VRAM
      pages in the same call still take the VRAM branch.
    
    Not tested: MEMORY_DEVICE_COHERENT systems (the GPU memory registered
    as coherent), device-dax (/dev/daxX.Y) mappings, other ASICs.
    
    A stricter test would be "the page belongs to a KFD pgmap", e.g.
    page_pgmap(page)->ops == &svm_migrate_pgmap_ops, which also rules out
    another driver's device-coherent pages. I used the type test because it
    needs no new helper; happy to switch if you prefer that.

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e33188..354184829 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -180,7 +180,12 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
-		if (is_zone_device_page(page)) {
+		/*
+		 * Only KFD's own VRAM pages (device private or device coherent)
+		 * take the VRAM path. Other ZONE_DEVICE pages, such as fsdax or
+		 * device-dax memory, are system memory and are DMA mapped below.
+		 */
+		if (is_device_private_page(page) || is_device_coherent_page(page)) {
 			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
-- 
2.43.0

