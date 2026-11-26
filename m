Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674984;
	b=DsTbVOb3MxVEsUxy4GIV/V+eQy6N9wIAk9Efic/NPbtZVimlUcct+EZ2EioZy8t/fg2s
	 R0wakyZ7qOMj3Z6+zRRBoHPuZ/jN3WAfcSlSZ7ORRUE3mleETPqYNB4zIXWNYSgp7/lyQ
	 RJTlRLy1mr9D9+BY15gVJRLaHXd4pSXpfBC9TTsE4iYMytB8BXKhFf5cWo4SHtIIMPStU
	 z/ZjxUiEv9UKIBSLv6PxgWs1VzOADU5EHPDZdGmqygT6czj2WG2fHELgw6KXYPx86haFo
	 Dy8d9uzwDKjl5yE7+bk50AyOagDobavikp5Y/EmFpc/uTiZ56GrqMr4Imu3a8CtIaVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674984;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=DWuwUKI1KjglEIgUnlvZmDvmS8Vv5b3sQc4h/adEugg=;
	b=m9cJ4TC7JFAJ+ky3YALNQhpsPUhc8kRP0W1vCcGU2q1JPGgFkjOBP+06R5haZZ7X6dDF
	 qsGClA25TFCZv/4lG1r3dcPvSqjUkUgCcIwKqqxaDcni9YyamwCeHFVKluYCUZ36c/aEm
	 tiQ7oOfvkZymSQeDn8fGW+fw5vaC+PJQJQW8bdQcHzx4aalu0PZ2CJsd3PTNsye7gpzMg
	 +EHXn2rCUrWdCSFiPg9GXofCI6WwdrxtwredZon+JqU8VekeCsuv3XXPi1b67quDgQnqK
	 kuxmS9pwZhzazcADDczbFs6L353SUqhqJRaiAJGoCmuprcOdZj8s40mAv/moI+YCGfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=defPRjLI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FA606A32E;
	Thu, 26 Nov 2026 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=defPRjLI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674983;
	b=tuzTbSGv0LTjiZY7GSiJCV9rs6i7vjJSHKcHiW+MxpUIzDA3zKt9zvjqvJp/zd9Nu3YS
	 HvUAFDPl9cPigQCQ0wWuy65gmGsyMwTOXV6N73ltRn/fba7oUamySHEt7WbEeDUuMd3Q3
	 JoDGakfabeYl0I0CNvGBifpzC1c0Sa0xfrF6pOuYq7rqMMRs/3OvRdbTYIBQ3aMptG+/p
	 Hm4bFhWVLO0wA+Z0w97JFb1y3BKszDZ7aNVxJAJX7Tn7cXROGgLCdysgks7x6/8tvVDfk
	 /snjXvAgjWIJZzDwtIUySuaVmA/rqarq1wHq14ELhpOgPsNKJDo98dozdkVjdVkM98g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674983;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=DWuwUKI1KjglEIgUnlvZmDvmS8Vv5b3sQc4h/adEugg=;
	b=1wGLmNo3SzTS84TEI89j1S/XENUvvfU9XNmk9KpfjvvBmlwVeeqc6d9aG88oHMm+dTim
	 N1OSBevNRZQdV/3VCyyXRougw8jXKzpazFIKM49THIgEsGMhp46+1IK/e9f4ZCHQP6wVP
	 ojqmjQRa2k1qIqQ0DBXgWrXNrLuzvsZO2D59iTKVp8EUkAp1ClBYahE5pjhcY53mMFlM9
	 mFidjqL4mnEX8tZa+m/LdxPImdBY4OavlWPCluOy5WU4T96XpGNSaSnWh0fSMAdwJ4CjQ
	 kSyzKrWkkfs1+e+YiXwJ55n2bosyK2qs0Wt+rvqSHsyAaI8Z0RdM2w6kHiJPSzS8Tlg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 20B521F000C4;
	Thu, 26 Nov 2026 06:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674983;
	bh=DWuwUKI1KjglEIgUnlvZmDvmS8Vv5b3sQc4h/adEugg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=defPRjLIYsZkDz7g4x20+tehigHmtgE8Ey6Axmvdn04CMsijPoSmy4hmpajatOiXc
	 cxAy+GtERkTo1B51ykLhBYxT+5Lw17rh+B8tjP5Vdsyw23L8bHhpzLYYkCEkp3QZMr
	 lZzdfL9Gj+grb8Ovx+UPk0ED6YUlxoaEOJeQ9/3YaPAJF12SQdbVPOPVau1rKkhqpQ
	 HgDbgNbnYuYu2dXJtICDx1ldiAOOEhEkvUnunx6iAFrtm98BRMtZAEslisyB1Q483z
	 wADTu+0CdI+JKgsiU8+946Db8k4zq56P2RuLll9WbRbv0lQQnE0f39S9QfSLrDJ5Is
	 7+FLyCQSYDoRw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CB1A24D285;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 06:18:41 +0000
Subject: [PATCH 6.12.y v2 1/4] virtgpu: don't reset on shutdown
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-virtio-final-v2-1-4cfd5590e924@certik.com>
References: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
In-Reply-To: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
 Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673921; l=8215;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=4xAxWTSuZqbMWX5IyUhmanX2InaxqlkwCQNhyBUjFSE=;
 b=qNfBRKcLDpsUPzvVKb8uQUgT45aFSakmzpDPQXX8YG8CYNV6G448H0F0X3QUp38MBNHiPiPoe
 uvxoWi3FEPnAvfoY1KlTRMfybPNBwMFg/A72SJK8Rkwfuj7iHG9BsZA
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: "Michael S. Tsirkin" <mst@redhat.com>

commit 183a08715af1491d381b4e22efd61578fbe05fa5 upstream.

It looks like GPUs are used after shutdown is invoked.
Thus, breaking virtio gpu in the shutdown callback is not a good idea -
guest hangs attempting to finish console drawing, with these warnings:

[   20.504464] WARNING: CPU: 0 PID: 568 at drivers/gpu/drm/virtio/virtgpu_vq.c:358 virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.505685] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency_common nfit libnvdimm kvm_intel kvm rapl iTCO_wdt iTCO_vendor_support virtio_gpu virtio_dma_buf pcspkr drm_shmem_helper i2c_i801 drm_kms_helper lpc_ich i2c_smbus virtio_balloon joydev drm fuse xfs libcrc32c ahci libahci crct10dif_pclmul crc32_pclmul crc32c_intel libata virtio_net ghash_clmulni_intel net_failover virtio_blk failover serio_raw dm_mirror dm_region_hash dm_log dm_mod
[   20.511847] CPU: 0 PID: 568 Comm: kworker/0:3 Kdump: loaded Tainted: G        W         -------  ---  5.14.0-578.6675_1757216455.el9.x86_64 #1
[   20.513157] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-3.el9 11/17/2024
[   20.513918] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
[   20.514626] RIP: 0010:virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.515332] Code: 00 00 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 51 50 00 00 65 ff 0d 42 e3 74 3f 0f 85 69 ff ff ff 0f 1f 44 00 00 e9 5f ff ff ff <0f> 0b e9 3f ff ff ff 48 83 3c 24 00 74 0e 49 8b 7f 40 48 85 ff 74
[   20.517272] RSP: 0018:ff34f0a8c0787ad8 EFLAGS: 00010282
[   20.517820] RAX: 00000000fffffffb RBX: 0000000000000000 RCX: 0000000000000820
[   20.518565] RDX: 0000000000000000 RSI: ff34f0a8c0787be0 RDI: ff218bef03a26300
[   20.519308] RBP: ff218bef03a26300 R08: 0000000000000001 R09: ff218bef07224360
[   20.520059] R10: 0000000000008dc0 R11: 0000000000000002 R12: ff218bef02630028
[   20.520806] R13: ff218bef0263fb48 R14: ff218bef00cb8000 R15: ff218bef07224360
[   20.521555] FS:  0000000000000000(0000) GS:ff218bef7ba00000(0000) knlGS:0000000000000000
[   20.522397] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.522996] CR2: 000055ac4f7871c0 CR3: 000000010b9f2002 CR4: 0000000000771ef0
[   20.523740] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.524477] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   20.525223] PKRU: 55555554
[   20.525515] Call Trace:
[   20.525777]  <TASK>
[   20.526003]  ? show_trace_log_lvl+0x1c4/0x2df
[   20.526464]  ? show_trace_log_lvl+0x1c4/0x2df
[   20.526925]  ? virtio_gpu_queue_fenced_ctrl_buffer+0x82/0x2c0 [virtio_gpu]
[   20.527643]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.528282]  ? __warn+0x7e/0xd0
[   20.528621]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.529256]  ? report_bug+0x100/0x140
[   20.529643]  ? handle_bug+0x3c/0x70
[   20.530010]  ? exc_invalid_op+0x14/0x70
[   20.530421]  ? asm_exc_invalid_op+0x16/0x20
[   20.530862]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.531506]  ? virtio_gpu_queue_ctrl_sgs+0x174/0x290 [virtio_gpu]
[   20.532148]  virtio_gpu_queue_fenced_ctrl_buffer+0x82/0x2c0 [virtio_gpu]
[   20.532843]  virtio_gpu_primary_plane_update+0x3e2/0x460 [virtio_gpu]
[   20.533520]  drm_atomic_helper_commit_planes+0x108/0x320 [drm_kms_helper]
[   20.534233]  drm_atomic_helper_commit_tail+0x45/0x80 [drm_kms_helper]
[   20.534914]  commit_tail+0xd2/0x130 [drm_kms_helper]
[   20.535446]  drm_atomic_helper_commit+0x11b/0x140 [drm_kms_helper]
[   20.536097]  drm_atomic_commit+0xa4/0xe0 [drm]
[   20.536588]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
[   20.537162]  drm_atomic_helper_dirtyfb+0x192/0x270 [drm_kms_helper]
[   20.537823]  drm_fbdev_shmem_helper_fb_dirty+0x43/0xa0 [drm_shmem_helper]
[   20.538536]  drm_fb_helper_damage_work+0x87/0x160 [drm_kms_helper]
[   20.539188]  process_one_work+0x194/0x380
[   20.539612]  worker_thread+0x2fe/0x410
[   20.540007]  ? __pfx_worker_thread+0x10/0x10
[   20.540456]  kthread+0xdd/0x100
[   20.540791]  ? __pfx_kthread+0x10/0x10
[   20.541190]  ret_from_fork+0x29/0x50
[   20.541566]  </TASK>
[   20.541802] ---[ end trace 0000000000000000 ]---

It looks like the shutdown is called in the middle of console drawing, so
we should either wait for it to finish, or let drm handle the shutdown.

This patch implements this second option:

Add an option for drivers to bypass the common break+reset handling.
As DRM is careful to flush/synchronize outstanding buffers, it looks like
GPU can just have a NOP there.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Cc: Eric Auger <eauger@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
[ adapted to 6.12: no reset_prepare/reset_done in struct virtio_driver, add only .shutdown ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c |    9 +++++++++
 drivers/virtio/virtio.c              |    6 ++++++
 include/linux/virtio.h               |    3 +++
 3 files changed, 18 insertions(+)

Changes in v2
v2: resent through a whitespace-safe path; v1 <CAFaZ9eqZCgDaXJ=2QSBmHVz9WEL4cpthQX02xVesUB5G3NRQWg@mail.gmail.com> was damaged by my mail client and does not apply.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 44d99e89bb9b..92332f9d1796 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -126,6 +126,14 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 	drm_dev_put(dev);
 }
 
+static void virtio_gpu_shutdown(struct virtio_device *vdev)
+{
+	/*
+	 * drm does its own synchronization on shutdown.
+	 * Do nothing here, opt out of device reset.
+	 */
+}
+
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
@@ -160,6 +168,7 @@ static struct virtio_driver virtio_gpu_driver = {
 	.id_table = id_table,
 	.probe = virtio_gpu_probe,
 	.remove = virtio_gpu_remove,
+	.shutdown = virtio_gpu_shutdown,
 	.config_changed = virtio_gpu_config_changed
 };
 
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 078e5483b22f..8241024f0890 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -391,6 +391,12 @@ static void virtio_dev_shutdown(struct device *_d)
 	if (!drv)
 		return;
 
+	/* If the driver has its own shutdown method, use that. */
+	if (drv->shutdown) {
+		drv->shutdown(dev);
+		return;
+	}
+
 	/*
 	 * Some devices get wedged if you kick them after they are
 	 * reset. Mark all vqs as broken to make sure we don't.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3ad94d939d28..2759e2c24d6e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -204,6 +204,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  *    changes; may be called in interrupt context.
  * @freeze: optional function to call during suspend/hibernation.
  * @restore: optional function to call on resume.
+ * @shutdown: synchronize with the device on shutdown. If provided, replaces
+ *    the virtio core implementation.
  */
 struct virtio_driver {
 	struct device_driver driver;
@@ -219,6 +221,7 @@ struct virtio_driver {
 	void (*config_changed)(struct virtio_device *dev);
 	int (*freeze)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
+	void (*shutdown)(struct virtio_device *dev);
 };
 
 #define drv_to_virtio(__drv)	container_of_const(__drv, struct virtio_driver, driver)


