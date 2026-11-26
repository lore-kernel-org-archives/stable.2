Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661112;
	b=0C/OG1WBbTbQ9eUTvqcczlGU3vWhPg+WqZ1q0peGf+mhqCxQRQlCI+U62ZIvc8nNIOAm
	 vOC3DWu3vnlqMNLEzbfCxcNRER5YwIYnjeXwkwf4RHk/YxyKSw/KBt5lth/qzlOwLGUAR
	 PPZ1nEC2E0CKMiAgexIGHosW7FEOE0Ea/HlqBLMMlnRPWX/1IEzTR8wpQYDPBDE6jA17q
	 vOBWjSG8s9Jw1Zxk+YW2PqNmT3ToLn0KlDcF9ablvossPDkKROjCfwCHL2vWXIoSkbXIq
	 rQG8nC+X2Ov6UhZ+s5npc3JOQlTcK6V6wp+BO51ldOPQJf/pXbOhuxfS1JkH3PaO46g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
	b=C7yKtYhHpIpr7BlmIYKEuUFMSzvOJBc2Q6Uxljxvmizzs7vdaFl1pkV55UAgv93XozZx
	 UYl3treS4zVmEeGnQa9Hy8I+tl/qm/vFIRJuGOKyMTGE8L7qvlkIdrakga3pnkR6obnun
	 O7ij6+Bcl8EbuzHDLEZbSgzjnV0N6rAlDgOdm7Hd4vUz3/DoW+76HK66IWGNyl+EfLs6u
	 oIcxWJERmjo/njpGW43Y6A1M41O9Jwa2cXMFzz68+l2RWDlFtWwIBdxQsLfNYnA2vhp+/
	 5kfS3grdLFq8nj+/r3L2Kr21bZiIrdIYMaDQpxJ5St3RGLeq1d3w6tFnP9e7FujpYmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=RBsZVA5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF36606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF36606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=RBsZVA5o
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67db3a48dc6so7837250d50.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661111; cv=none;
        d=google.com; s=arc-20260327;
        b=GGeQfUd0TQpPnhDnIlKsZYrrDq76qPUe1i8Ha5MNZJw/iQ3gj0XPzI7643kBRcH1/O
         BW0Rl7oVqNxB43+R20I45Yuz5PUo76I3IEZ8lf2qBs+A9CUPZ3Tfy3bxYSHKe2j2yoHF
         R7cr4lF1rVfAx/lzixW6ls56DD/znez17tAMmgH5NmAt+bt6ZIbTbw6RIAyaGP7lpv2D
         d4ZkxxFeRkksv2o5ZUhtSXEEVkVPbJwtak7j3n0J/YqPtZuw89bpgTxX6TTtXZ6tXxZy
         WRB2emb2MelHGmarJJ70HsOmpkBEoJ8Ahv/B4g7hrWsj2RjLrRI/L7S5MfNYy12ode2y
         BQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
        fh=Cl8p86fIxraTdAPl9TMEjG1uOAHTz1nspTZpzog1E7w=;
        b=fSgw8lL9/KbvmfCbsHp9CKLdmdZRyv3elFmT0dv/uD0lDV5t6HDx64XSwTcJhLZ6nu
         n1sIVyR1hOASyx3ar1AjSiFJ/1vzXNNMTceNNBAJgbD4gO4CeSuvYvKc8ClPLH9Lyr+Q
         iXh1j2mUS2mLJiLuEHXSrp6wYSkywJIeE99U4sSIJHsGOhdX2UR3ZVJ88L4r/ySVJezz
         rBDSzMv1Pz26+QZN0ls6cYTtBaDjsmSTgZhuLPVqPqkL39l6cPwou9gL0Q29MXy1e1RO
         +24LIblXa6trm8aDVoKXt+/rQPpIdvxCvUnYLD0Cy2ns55PodmmbhPY6tmTZ4cMbtntk
         TgcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661111; x=1796265911; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
        b=RBsZVA5orsQExKBILjXa5AaUf5t4r7IUt4uZeuF8guecWX8UvcZEcL3Tee+Fg+ZNf0
         Urd1AJwKnb7/5cDUDbYFNmXDrkNTn9DpSRLt5rovMk48z5DXJ+A1Ex/MYoVLQt9b6lVs
         hg8KvqUfc4Bf0Ta7ePW/uxoj7Jl7ObLDtMAy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661111; x=1796265911;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
        b=r+QoQUgau/ueZcxFVrPIUMHNB7c0J36Q69BvuwFShVInAtLsw5vpZI/AuBO7i/SBFY
         8zwYsbqxJxxQaymd/dezjvrXtJ81DYgFqO/zJBciO5MwFr4fe2kScEuknJcAtZ+qnAuF
         RERo/BROPCeD2bY9wZokDiuVb6XznC6byGR260nc9/ppLlZGGj86z15qpyDY5FyFVEzm
         hOARAdBk4UBkXQrC6tadpQeCUew6gsbCQ2DgynoyZAQdDI+RD0NlaVE0Y+gwd3AEqwiB
         nZitORLo3tkAGz1CcEm7vMeACeweS88X7ZtexPo6FKM8VE5zYUWid5L4+Hcjla86nBFw
         ilVw==
X-Gm-Message-State: APuU4Z9e1D3+LqXNatKINKlH59SB+z2YaMN3ZFhcCZ6UU9BcmKIF/P1G
	NTVCL5WWK0ovHE6WtVN47IISqwPp/eC9JUC+rPD30w1rwACVUfaXeL7LrWsOsNsBjLgNh+yaGdy
	XXmt8f7Sg1EF4nhmM7ldCwar/QQTfCLLRwYryDva++kIfkulyO+3beZw=
X-Gm-Gg: AZFdTZdoTv6aAlGoqo7BqRpwnbKd1bEfTUjC9q2y9zzlIBzcCGY/I4lLvVrLl57Kroq
	MwfrYzDWdk7pBs2DQ7JkgW47j2/mWU0mH3qWsHUwVzl0b+kkeMm69ET5KsNVoEht4xn52WXOwr8
	MxrL3XtqLxriyfjXBIhH9oq7TroLD07GrNpKZp4JeHZllR7W4Rrmnhvznm4c0D9KBXMFqbNfKZ7
	3pqeT9+xIOr3ky8JbHaVWA5n5o0xihVJiR77Jd15HYacfLfd2erNXD2Klins0u8d0I1MzMbE9Lw
	j30AycllU79XuZ3vgjxGzOrOXJekHSfxEPgoqxP3xcw0PnQvxZP4f9gbtoe5PPJGXeKMubU4U07
	x+fZR9dxo0hsPgXZ7Ck5WVgF8CBpSokGJjUsxhB/Ls/rcDCnlvbQ+4BxOBiY3p2vAArsHvB7rkR
	NUr5XRgyby5FuigkQPU69zoY3TW4n7PY7Xw/2oii66Zk+EQjihKQRIkkPszqZ/kkKKQ0uznYGSf
	BUT0c3Oajs9/mSkUtgzSJwAyDeMGlJu4kntz0gZ9PBQGOWgVL430Mjt+Q==
X-Received: by 2002:a05:690e:b89:b0:67d:c37d:331c with SMTP id
 956f58d0204a3-67df44ddeb8mr8126491d50.159.1795661111365; Wed, 25 Nov 2026
 18:45:11 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:10 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:10 -0600
X-Gm-Features: Aa3M54oYYln_PYaeGvWJPmyHTFtgp5tbd4RkECzndSrc2_KWyM6QBHXs2A8H9Sw
Message-ID: <CAFaZ9eqZCgDaXJ=2QSBmHVz9WEL4cpthQX02xVesUB5G3NRQWg@mail.gmail.com>
Subject: [PATCH 6.12.y 1/4] virtgpu: don't reset on shutdown
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Michael S. Tsirkin" <mst@redhat.com>

commit 183a08715af1491d381b4e22efd61578fbe05fa5 upstream.

It looks like GPUs are used after shutdown is invoked.
Thus, breaking virtio gpu in the shutdown callback is not a good idea -
guest hangs attempting to finish console drawing, with these warnings:

[   20.504464] WARNING: CPU: 0 PID: 568 at
drivers/gpu/drm/virtio/virtgpu_vq.c:358
virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.505685] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink vfat fat
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common nfit
libnvdimm kvm_intel kvm rapl iTCO_wdt iTCO_vendor_support virtio_gpu
virtio_dma_buf pcspkr drm_shmem_helper i2c_i801 drm_kms_helper lpc_ich
i2c_smbus virtio_balloon joydev drm fuse xfs libcrc32c ahci libahci
crct10dif_pclmul crc32_pclmul crc32c_intel libata virtio_net
ghash_clmulni_intel net_failover virtio_blk failover serio_raw
dm_mirror dm_region_hash dm_log dm_mod
[   20.511847] CPU: 0 PID: 568 Comm: kworker/0:3 Kdump: loaded
Tainted: G        W         -------  ---
5.14.0-578.6675_1757216455.el9.x86_64 #1
[   20.513157] Hardware name: Red Hat KVM/RHEL, BIOS
edk2-20241117-3.el9 11/17/2024
[   20.513918] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
[   20.514626] RIP: 0010:virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.515332] Code: 00 00 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 51
50 00 00 65 ff 0d 42 e3 74 3f 0f 85 69 ff ff ff 0f 1f 44 00 00 e9 5f
ff ff ff <0f> 0b e9 3f ff ff ff 48 83 3c 24 00 74 0e 49 8b 7f 40 48 85
ff 74
[   20.517272] RSP: 0018:ff34f0a8c0787ad8 EFLAGS: 00010282
[   20.517820] RAX: 00000000fffffffb RBX: 0000000000000000 RCX: 0000000000000820
[   20.518565] RDX: 0000000000000000 RSI: ff34f0a8c0787be0 RDI: ff218bef03a26300
[   20.519308] RBP: ff218bef03a26300 R08: 0000000000000001 R09: ff218bef07224360
[   20.520059] R10: 0000000000008dc0 R11: 0000000000000002 R12: ff218bef02630028
[   20.520806] R13: ff218bef0263fb48 R14: ff218bef00cb8000 R15: ff218bef07224360
[   20.521555] FS:  0000000000000000(0000) GS:ff218bef7ba00000(0000)
knlGS:0000000000000000
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
Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()")
Cc: Eric Auger <eauger@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
[ adapted to 6.12: no reset_prepare/reset_done in struct
virtio_driver, add only .shutdown ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c
b/drivers/gpu/drm/virtio/virtgpu_drv.c
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
@@ -204,6 +204,8 @@ size_t virtio_max_dma_size(const struct
virtio_device *vdev);
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

 #define drv_to_virtio(__drv)	container_of_const(__drv, struct
virtio_driver, driver)
