Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444411;
	b=KsO5WhL66B60m+DOSx9cF7EMKzbzE52HoulPbvlb75kFGntzzArshp07zoUgY91lfinm
	 ep9mLnHJI5FLZrDsdJ8lm9LNBkKl7Y8gCDOmqrH7KZMda5LakgXRbf6LeIRX0snMAtXac
	 O2+ELSJ3qF36q7wyEdw+GPmLLaYtIKvgW29ji1I7aiECC2qYUPW8njU3I6sUnbQNoXGoW
	 6vDWISJPqGqUV/gfcVoEOUMeRIUeV/7AznEYCBv7DIzf2dezF1EiAodxrjhNWjcBVR30Z
	 55NfxioXV+0alar001NBV4xVPMS9vEC8lvtn3NcM/cGlnOixH1U0V0pm9btxPuODv6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444411;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OCPSiHkYqSNvnClc+FUc66tTva53YlW4lXZmEaSjud0=;
	b=Vnjvlu9yDbUSJHCqyo0t5+LKaBTl0ZdNZrERAajs236gDK4l7N3DlB9VWrsXUr7z6P0P
	 AM+WEniYpCAlsQjI3o/0lYGOtpZLu/tjJqSjJHL5SOKKBE8rPgheH+9oAZC1vj0BPTzyP
	 eHSs3p6YU9NbNUzaZ54XbUxS3yqqBEdFXRyIPqPWRNlchRnCOf1jirj1Ei683e6m65JWw
	 gl+2o7mMJZGr48e3SxrUIZcM/Y+9zrfkrbg5QGoMD3GODgo0su+o1oQACpUQ5WwoVV2kd
	 LhyYWggly/mIiPJ9A/KuP5Irerw+iQUT/4lkl+PbkQWlqWaI7PP/MWD6BQx1eHUtrxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=RkycBL4G;
	arc=none smtp.remote-ip=115.124.28.1
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF03606A31A;
	Mon, 23 Nov 2026 14:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF03606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=RkycBL4G
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795444400; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OCPSiHkYqSNvnClc+FUc66tTva53YlW4lXZmEaSjud0=;
	b=RkycBL4GD2EXhFYzp0KJkFi4j9vZnxYhH3VRJI9Qdrhr8JAxOmt0E2PeSnBtmCG4fwM84QAhno1JafzbyNRDPCfZXll792hP5JfMxnBhTZ+ZSI+PkBSVe+mZJalXkxYLLJb2a78JPVkFjnCVhiajTRR0vvnLNALV3DTcbtO5ChY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04439905|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00493033-8.00282e-06-0.995062;FP=6621435113100027107|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.k8K2y1G_1795444398;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k8K2y1G_1795444398 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 22:33:20 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xie Yongji <xieyongji@bytedance.com>,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()
Date: Mon, 23 Nov 2026 22:33:18 +0800
Message-ID: <20261123143318.73514-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

find_vma() returns the first VMA with vm_end > uaddr; when uaddr lies
in an unmapped gap, vma->vm_start > uaddr and the offset arithmetic

	offset = (vma->vm_pgoff << PAGE_SHIFT) + uaddr - vma->vm_start;

produces an incorrect file offset, potentially wrapping in u64
arithmetic.

The incorrect offset is stored in map_file->offset and passed to
the mapping backend. Meanwhile, map_size includes the gap, causing
the corresponding IOVA range to be mapped without valid backing.

Skip the gap: stop if the whole remaining request is gap, otherwise
shrink size, pin uaddr to vm_start and advance map_iova by the gap.
The gap is left unmapped without error.

Testing:
- make W=1 drivers/vhost/vdpa.o
- QEMU/KVM v7.4-rc1 with a probe vDPA parent; tested partial
  gap, whole-gap and contiguous IOTLB updates.

Fixes: d8945ec41120 ("vdpa: Support transferring virtual addressing during DMA mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/vhost/vdpa.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

Reproducer: userspace model of va_map() with a mock find_vma(); shared
file-backed VMA [0x2000,0x3000) at file offset 0, unmapped gap
[0x1000,0x2000).

  UPDATE iova=0x100000 uaddr=0x1000 size=0x2000 (partial gap):
    without fix: ret=0, one map over the gap,
                 file_offset=0xfffffffffffff000
    with fix:    ret=0, map at iova=0x101000 uaddr=0x2000
                 size=0x1000 file_offset=0x0
  UPDATE uaddr=0x1000 size=0x1000 (whole request in gap):
    without fix: ret=0, bogus map with underflowed offset
    with fix:    ret=0, no mapping created

Build: make W=1 drivers/vhost/vdpa.o completed without warnings on
v7.4-rc1 (defconfig + VHOST/VDPA/VHOST_VDPA).

Runtime: On v7.4-rc1 under QEMU/KVM, a userspace test client sent
VHOST_IOTLB_UPDATE messages through the /dev/vhost-vdpa chardev to a
probe vDPA parent with use_va enabled and dma_map logging.  Without
the fix the parent receives offset=0xfffffffffffff000 for gap
requests; with the fix the gap is skipped (map_iova advanced,
offset=0), an all-gap request creates no mapping, and contiguous
requests are unchanged.
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ff7d907..4a6a946 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1109,6 +1109,20 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
 			ret = -EINVAL;
 			break;
 		}
+		/*
+		 * uaddr may lie in an unmapped gap before vma->vm_start; skip
+		 * the gap so the offset calculation below uses an address in the VMA.
+		 */
+		if (uaddr < vma->vm_start) {
+			u64 gap = vma->vm_start - uaddr;
+
+			if (gap >= size)
+				break;
+			size -= gap;
+			uaddr = vma->vm_start;
+			map_iova += gap;
+			continue;
+		}
 		map_size = min(size, vma->vm_end - uaddr);
 		if (!(vma->vm_file && (vma->vm_flags & VM_SHARED) &&
 			!(vma->vm_flags & (VM_IO | VM_PFNMAP))))
-- 
2.50.1

