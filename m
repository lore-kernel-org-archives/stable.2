Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677869;
	b=2bV4MIcuST7xHRrgoseeC9KhuLmSoHVwNb96oESwV9CVIY0IyrGqhKt3Mkcw0xNtUXfV
	 kFxL6yJXuRg3Jm/o2sq+p3wXo8Ga5L2PlPkZJziVRjeBg+Yx1/gMutI9iw7FV6RXVEZeK
	 NquAw0CWP8DqfyijXOOEGUEHwmzhX0+5Tsg3o49bgje0ADa6H7+FStIE1pIrILGMCzHrF
	 94CBisqWoMZbe5T24A77Jgt2Qv1rZNRgP7tQHazA9rFkz3aJx92MIraI4oQaSD9HVeb3F
	 GhXSTvcoIqvOF68cgwiaEIQpmecz1UmTGsLRsXZBLhp/yce64ME32TAZ2sgXASStUXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677869;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=clQ7a2lHAgYfKz5SkvqDRWEN/kW5veMqDifdXKTPsHc=;
	b=pmPwSKpMxIhNip0pwVtS3yx7yTFO+163uv912AuJ8xJVjB3i90BJQQvauOK9sq1caNxW
	 gPO9foD7k3QXRZQocWvQawxji/tK++ceoIcfMuKh2+k+6n1Hk7lm0YXfjfAjI3EU1yxgJ
	 nJLuVuiWgzrZbvvjGTMGVfktcCnuzKIS+ZRzO8rFNXt6gzUQwK3jYZU3lP2kUTEOS0ZU6
	 qK1eDSyY43Up3SKvlYObeOZBChF7qiSbwnIkNvot7HDp22AE2lG6tH+mNcX1R6p/Hie5C
	 7wftj3/kiDSzGjRAe5wkGIFvJUcpUN4n/DQtHuxkbNCzxe18KxuHJV1Lf3CRqqWa6nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=mSkSP4Gt;
	arc=none smtp.remote-ip=115.124.28.123
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E52606A31E;
	Thu, 26 Nov 2026 07:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E52606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=mSkSP4Gt
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795677856; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=clQ7a2lHAgYfKz5SkvqDRWEN/kW5veMqDifdXKTPsHc=;
	b=mSkSP4GtfWMH3eWHuSK/gEOsXnH/ceskBTe4et0vAcD3xnx52365LiQEBYLs74x25Vzk01IwL2mr6MI8dmmxn1K839FM43jQhxhE17cX5VnA0DOruLB3E+rN8emTqzz7MYAPyR6KDAR0l9VhLzpPHJ16eCULCJQV1/QCujwhLRU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04440256|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00525153-5.53735e-06-0.994743;FP=1379844234834617539|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.kAQZfYs_1795677854;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.kAQZfYs_1795677854 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 15:24:15 +0800
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
Subject: [PATCH v2] vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()
Date: Thu, 26 Nov 2026 15:24:14 +0800
Message-ID: <20261126072414.97199-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261123143318.73514-1-fangxy@xiaopeng.com>
References: <20261123143318.73514-1-fangxy@xiaopeng.com>
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
arithmetic, and map_size counts the gap as part of the mapping.

Seen at runtime on v7.4-rc1: a request whose uaddr lies 0x1000
below a shared file-backed VMA starting at file offset 0 reaches
the vDPA driver's dma_map() callback as offset=0xfffffffffffff000.
Since vhost_vdpa_map() adds the range to the vhost IOTLB before
calling the backend, a successful mapping keeps an entry covering
the gap, which has no valid backing.

Skip the gap: stop if the whole remaining request is inside the gap,
otherwise shrink size, set uaddr to vm_start and advance map_iova by
the gap.  Gaps before a later VMA are left unmapped without error;
when find_vma() returns NULL because no VMA follows uaddr, the
existing -EINVAL is kept.

Fixes: d8945ec41120 ("vdpa: Support transferring virtual addressing during DMA mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/vhost/vdpa.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

Changes since v1:
- drop the redundant "continue": the already-found VMA is processed
  directly instead of being looked up again; the mappings, the
  return value and the unmap span are unchanged.
- commit message only: quote the offset measured at runtime, note
  that a uaddr no VMA follows keeps -EINVAL, move test records here.

Testing: make W=1 drivers/vhost/vdpa.o completed without warnings on
v7.4-rc1 (defconfig + VHOST/VDPA/VHOST_VDPA).  Under QEMU/KVM a
userspace client sent VHOST_IOTLB_UPDATE through /dev/vhost-vdpa to
a probe vDPA parent with use_va and dma_map logging; its memory is
file-backed VMAs separated by a 0x1000 gap, the upper one at offset
0.  The dma_map log then reads:

  iova=0x100000 size=0x3000 uaddr=0x20001000 (request into the gap):
    unpatched: dma_map iova=0x100000 size=0x3000 offset=0xfffffffffffff000
    patched:   dma_map iova=0x101000 size=0x2000 offset=0x0
  iova=0x400000 size=0x4000 (spans the gap), second segment:
    unpatched: dma_map iova=0x401000 size=0x3000 offset=0xfffffffffffff000
    patched:   dma_map iova=0x402000 size=0x2000 offset=0x0
  iova=0x200000 size=0x1000 (whole request in the gap): no dma_map
    once patched, write() still succeeds
  iova=0x300000 size=0x1000 (contiguous): identical maps in both runs
  iova=0x600000 size=0x3000 (tail past the last VMA): dma_map and
    dma_unmap of the same 0x2000, write() = -1 EFAULT in both runs
  iova=0x500000 size=0x1000 (uaddr above every VMA): no dma_map,
    write() = -1 EFAULT in both runs

vhost_chr_write_iter() turns a non-zero handler return into EFAULT,
so the last two cases fail the same way with and without the patch.

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ff7d907..623c2da 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1109,6 +1109,19 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
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
+		}
 		map_size = min(size, vma->vm_end - uaddr);
 		if (!(vma->vm_file && (vma->vm_flags & VM_SHARED) &&
 			!(vma->vm_flags & (VM_IO | VM_PFNMAP))))
-- 
2.50.1

