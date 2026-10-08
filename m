Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52C3EC6B2
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452580; cv=none; b=s12A2uHP8bsEGgnGXpoODF14/cyN67EmSwOZ+uRkAwn0Ia0AXKFO4zuk/j1XFyxQf/FZ+i4AI+C/sZl+7SIpdhw5zsuGBQnojKo53Lm8dK4fD8Q3TcxZKlkJxmKOHFfeOFb1bLc+d6zvlLQeXJrJw85k+69zFyqkMHQozdFjyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452580; c=relaxed/simple;
	bh=h0yoA9WpDZlYZlj4yRkwxpntMollTZRU8GnNa75CX58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+llJglLaiailU6r7YQga5bv7aSJ4HQcxtWNMZIU6YvdU6iUTNrP/L5mfbLjl6Ly+24OLU1sCOnbLEQmRR7oyel0Hvx0x5o2JEYdhqtc0cyUdeL41PphqgSfZ8sSek811qk8FlQ48jWoZcFCLxFgR6DopNR0PIytWxr/gTTlGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=UiZWOd5M; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="UiZWOd5M"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1210073b3a.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791452576; x=1792057376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PNARdq7cJoEo1sJkc3fA00mNIi6bXCz2q0z3p/1RfxQ=;
        b=UiZWOd5MDCWYQ+InLoPdKexNyQh6TUFE5dCvud+/EMYP5F8AXQMlncBCNv6HkGkelu
         I1kywiCXb5TCGYZDF3sl+/vRbScKN08LXKEBT1m/4/TmluBGb5fcpBwulfsPg3FRIw2k
         FD6D8ApUNNGpZPnPQI7/+a6x16m+Tjo9J12vvG4MGzhLTeSpjNeFHAjDF9RtbgG8hYOD
         KB6i1u4ccXyMSUUea3IDvIoeBZoVYnL0ONULarVRLG/itHyx541Qd2OCantWncGt1jTB
         2bCgLu5Q3SwqGmOqeEChNqErqSspF9n1bUVXT8MuRjqWXRXnxzHH66itRkGsCs6uDdE3
         N/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452576; x=1792057376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PNARdq7cJoEo1sJkc3fA00mNIi6bXCz2q0z3p/1RfxQ=;
        b=lgP9NWCxHc2hBjV3takZNLn6cT8T0wsr/+wPoZDLyyEH4i7iHO/ERx1tGhNKw7EuIE
         CcQmuluoyzUrMqEcrgevN8DSKpTDPRW8yc3CfPVArdDiGB40AI+6cggZMCuUhverFdhx
         yF5QloXMnWjWSoFQltj2mcbsJOUi0vCXEvB+Lq6AUmhFhhs9ncH4YShQG6jSKjnpSM3p
         CuJOKpVDA8yKDzUlrdDdRsI22s2gjnBnq1wTEVi0jxtpqEFIFR74NoW5sat6tZTNmtcw
         kIaTSn5tWBVuOlWSymvWrEnXBAD6fY7o9h5oWttgZHod+YhLls4k7giyoJBy78mwjiUR
         aUmw==
X-Forwarded-Encrypted: i=1; AKwUvBwgCYUd15CG2WiSZJVRjAZSL/LvFVvjqLFv4Ukh9kDg4CUSQLJL/5t5b0LypnOaCfnXEqSjncc=@vger.kernel.org
X-Gm-Message-State: AFuF++kOs6r93ylb8FOWZOiySUG+wNxSWDE1XPZyXBDdGT0zLlMkZj+0
	gcjVPgu3Q/T4FESGPKUN1jWc37sRP4ANFu1bKwqMSONoCilwi2kiFi7SfH6p8c6jdUI=
X-Gm-Gg: AYBFou1LnygrmAV6aJdsmAH9O5hVNjc0CL/Yf8Id78sITWB/I2zGnAij3O53IdFGE0M
	gYrpT0rtCSkKE57MDUNySdqXSdVnhlyWkoIxilHpig+qr+VXsi+LJ9/LjQNbJMx1t8R6kiUK83b
	nK+TaxxpiFZmTEwcUoAcRMtvkylU6XP/KqH3rZhGgFJXjijZIETdGv79l+JGCUEBanAyYTQX+Ye
	ccs3so3bEC6sJ0BTbZ2csVJ0+ABn+S9Yp9i8acypAN0D012nbSIYl3/Ql+D6pNTj0kVlGTVh/BH
	oSVO6REcwy33HeTKqlaIXVTztNeG8I3I9dwxGV72kVk5JWVnMF90PECvyLoSkcceBFHzEIVQkGs
	BXNLD0e2wf0uDWzIZ1sJHci+QDC90WpUHL27kkheEonV8ODLpxVZTPtFpXDbgGvIHdMELTLNck5
	7frY43SR49DGe5yW+y4enmBDradrkBL3mA8YaN/8rUAhQrzc8ZBYBxLnurUskAdAjek6YeiwmIO
	VDcO8h3hlREa8DZ
X-Received: by 2002:a05:6a20:b787:b0:3dd:a196:30a7 with SMTP id adf61e73a8af0-3e134180c1cmr3895479637.87.1791452576425;
        Thu, 08 Oct 2026 02:42:56 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a5822bd2sm2808017a12.3.2026.10.08.02.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:42:56 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jpb@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	eric.auger@redhat.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/virtio: bound the probe-property walk to the probe buffer
Date: Thu,  8 Oct 2026 18:42:40 +0900
Message-ID: <20261008094240.1082031-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_probe_endpoint() walks the properties the device returns in the
PROBE request, advancing a cursor by each property's device-provided
length.  The loop only checks that the start of a property header lies
within probe_size, but viommu_add_resv_mem() then dereferences a full
struct virtio_iommu_probe_resv_mem, reading mem->start and mem->end,
before its own length check runs.  A property placed near the end of the
buffer, or a probe_size smaller than the property, makes that read run
past the end of the probe allocation.

A malicious or buggy device triggers this with a RESV_MEM property at the
tail of the buffer.  KASAN reports a slab-out-of-bounds read, and the
out-of-bounds bytes become the start and end of a reserved region that is
then exposed to userspace through
/sys/kernel/iommu_groups/*/reserved_regions:

[    0.894779] BUG: KASAN: slab-out-of-bounds in viommu_probe_device+0x8b4/0xb20
[    0.894788] Read of size 8 at addr ffff88800a2eba4c by task swapper/0/1
[    0.894791]
[    0.894794] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc6-00063-g0c2669a9f4a1 #1 PREEMPT(lazy)
[    0.894800] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    0.894802] Call Trace:
[    0.894805]  <TASK>
[    0.894807]  dump_stack_lvl+0x66/0xa0
[    0.894821]  print_report+0xd0/0x630
[    0.894827]  ? viommu_probe_device+0x8b4/0xb20
[    0.894831]  ? __virt_addr_valid+0x209/0x3f0
[    0.894837]  ? viommu_probe_device+0x8b4/0xb20
[    0.894840]  kasan_report+0xe4/0x120
[    0.894844]  ? viommu_probe_device+0x8b4/0xb20
[    0.894849]  viommu_probe_device+0x8b4/0xb20
[    0.894855]  __iommu_probe_device+0x298/0x12f0
[    0.894860]  ? __pfx___iommu_probe_device+0x10/0x10
[    0.894863]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
[    0.894869]  ? trace_hardirqs_on+0x18/0x160
[    0.894875]  ? __pfx_probe_iommu_group+0x10/0x10
[    0.894879]  probe_iommu_group+0x25/0x50
[    0.894882]  bus_for_each_dev+0x103/0x180
[    0.894887]  ? __pfx_bus_for_each_dev+0x10/0x10
[    0.894890]  ? iommu_device_register+0x195/0x680
[    0.894893]  ? lock_release+0xc6/0x280
[    0.894899]  iommu_device_register+0x1d7/0x680
[    0.894903]  ? __pfx_iommu_device_register+0x10/0x10
[    0.894907]  ? __asan_memset+0x23/0x50
[    0.894913]  viommu_probe+0x1001/0x1460
[    0.894919]  ? __pfx_viommu_probe+0x10/0x10
[    0.894924]  ? lock_acquire+0x18d/0x300
[    0.894929]  ? __pfx_viommu_event_handler+0x10/0x10
[    0.894933]  ? vp_modern_set_extended_features+0x85/0xb0
[    0.894938]  ? vp_set_status+0x20/0x70
[    0.894944]  virtio_dev_probe+0x569/0xbe0
[    0.894950]  ? kernfs_add_one+0xeb/0x7a0
[    0.894956]  ? __pfx_virtio_dev_probe+0x10/0x10
[    0.894961]  ? kernfs_create_link+0x169/0x230
[    0.894965]  ? kernfs_put+0x17/0x30
[    0.894970]  ? sysfs_do_create_link_sd+0x89/0x100
[    0.894976]  really_probe+0x1c3/0x6a0
[    0.894981]  __driver_probe_device+0x19e/0x3b0
[    0.894985]  ? trace_hardirqs_on+0x18/0x160
[    0.894990]  driver_probe_device+0x45/0xd0
[    0.894994]  __driver_attach+0x149/0x3e0
[    0.894998]  ? __pfx___driver_attach+0x10/0x10
[    0.895002]  bus_for_each_dev+0x103/0x180
[    0.895006]  ? __pfx_bus_for_each_dev+0x10/0x10
[    0.895008]  ? bus_add_driver+0x1d1/0x500
[    0.895012]  ? lock_release+0xc6/0x280
[    0.895018]  bus_add_driver+0x20b/0x500
[    0.895022]  driver_register+0x12f/0x450
[    0.895027]  ? __pfx_virtio_iommu_drv_init+0x10/0x10
[    0.895032]  do_one_initcall+0xc9/0x440
[    0.895037]  ? __pfx_do_one_initcall+0x10/0x10
[    0.895042]  ? __kmalloc_noprof+0x40d/0x680
[    0.895047]  ? kernel_init_freeable+0x385/0x8e0
[    0.895053]  kernel_init_freeable+0x4c3/0x8e0
[    0.895057]  ? __pfx_kernel_init+0x10/0x10
[    0.895063]  kernel_init+0x1f/0x1e0
[    0.895068]  ? _raw_spin_unlock_irq+0x23/0x40
[    0.895072]  ? __pfx_kernel_init+0x10/0x10
[    0.895077]  ret_from_fork+0x52e/0x780
[    0.895081]  ? __pfx_ret_from_fork+0x10/0x10
[    0.895085]  ? __switch_to+0x572/0xde0
[    0.895091]  ? __pfx_kernel_init+0x10/0x10
[    0.895096]  ret_from_fork_asm+0x1a/0x30
[    0.895103]  </TASK>
[    0.895104]
[    0.895105] Allocated by task 1:
[    0.895108]  kasan_save_stack+0x33/0x60
[    0.895111]  kasan_save_track+0x14/0x30
[    0.895114]  __kasan_kmalloc+0x8f/0xa0
[    0.895117]  __kmalloc_noprof+0x264/0x680
[    0.895120]  viommu_probe_device+0x2e3/0xb20
[    0.895123]  __iommu_probe_device+0x298/0x12f0
[    0.895126]  probe_iommu_group+0x25/0x50
[    0.895129]  bus_for_each_dev+0x103/0x180
[    0.895131]  iommu_device_register+0x1d7/0x680
[    0.895134]  viommu_probe+0x1001/0x1460
[    0.895137]  virtio_dev_probe+0x569/0xbe0
[    0.895141]  really_probe+0x1c3/0x6a0
[    0.895144]  __driver_probe_device+0x19e/0x3b0
[    0.895148]  driver_probe_device+0x45/0xd0
[    0.895151]  __driver_attach+0x149/0x3e0
[    0.895154]  bus_for_each_dev+0x103/0x180
[    0.895160]  bus_add_driver+0x20b/0x500
[    0.895163]  driver_register+0x12f/0x450
[    0.895166]  do_one_initcall+0xc9/0x440
[    0.895166]  kernel_init_freeable+0x4c3/0x8e0
[    0.895166]  kernel_init+0x1f/0x1e0
[    0.895166]  ret_from_fork+0x52e/0x780
[    0.895166]  ret_from_fork_asm+0x1a/0x30
[    0.895166]
[    0.895166] The buggy address belongs to the object at ffff88800a2eb800
[    0.895166]  which belongs to the cache kmalloc-1k of size 1024
[    0.895166] The buggy address is located 0 bytes to the right of
[    0.895166]  allocated 588-byte region [ffff88800a2eb800, ffff88800a2eba4c)
[    0.895166]
[    0.895166] The buggy address belongs to the physical page:
[    0.895166] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88800a2ee000 pfn:0xa2e8
[    0.895166] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    0.895166] flags: 0x100000000000240(workingset|head|node=0|zone=1)
[    0.895166] page_type: f5(slab)
[    0.895166] raw: 0100000000000240 ffff888008c41dc0 ffff888008c40888 ffff888008c40888
[    0.895166] raw: ffff88800a2ee000 000000000010000c 00000000f5000000 0000000000000000
[    0.895166] head: 0100000000000240 ffff888008c41dc0 ffff888008c40888 ffff888008c40888
[    0.895166] head: ffff88800a2ee000 000000000010000c 00000000f5000000 0000000000000000
[    0.895166] head: 0100000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
[    0.895166] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[    0.895166] page dumped because: kasan: bad access detected
[    0.895166]
[    0.895166] Memory state around the buggy address:
[    0.895166]  ffff88800a2eb900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.895166]  ffff88800a2eb980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.895166] >ffff88800a2eba00: 00 00 00 00 00 00 00 00 00 04 fc fc fc fc fc fc
[    0.895166]                                               ^
[    0.895166]  ffff88800a2eba80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    0.895166]  ffff88800a2ebb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    0.895166] ==================================================================

Bound the walk so a property cannot extend past probe_size, and move the
length check in viommu_add_resv_mem() ahead of the dereference.  The
property length is device-controlled, so widen it so the addition cannot
wrap.

Fixes: 2a5a314874450d ("iommu/virtio: Add probe request")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/iommu/virtio-iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12..dbc997a6e3568 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -489,6 +489,9 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	struct iommu_resv_region *region = NULL, *next;
 	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
+	if (len < sizeof(*mem))
+		return -EINVAL;
+
 	start = start64 = le64_to_cpu(mem->start);
 	end = end64 = le64_to_cpu(mem->end);
 	size = end64 - start64 + 1;
@@ -497,9 +500,6 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	if (start != start64 || end != end64 || size < end64 - start64)
 		return -EOVERFLOW;
 
-	if (len < sizeof(*mem))
-		return -EINVAL;
-
 	switch (mem->subtype) {
 	default:
 		dev_warn(vdev->dev, "unknown resv mem subtype 0x%x\n",
@@ -531,7 +531,8 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 {
 	int ret;
-	u16 type, len;
+	u16 type;
+	unsigned int len;
 	size_t cur = 0;
 	size_t probe_len;
 	struct virtio_iommu_req_probe *probe;
@@ -563,8 +564,10 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
 
 	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
-	       cur < viommu->probe_size) {
+	       cur + sizeof(*prop) <= viommu->probe_size) {
 		len = le16_to_cpu(prop->length) + sizeof(*prop);
+		if (len > viommu->probe_size - cur)
+			break;
 
 		switch (type) {
 		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
-- 
2.43.0

