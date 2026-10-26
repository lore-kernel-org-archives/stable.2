Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021423;
	b=lGzua7JRia+WT1XBGmtQPUcW3brOtdoPoM6x1KrB/IjEkiPRLCYNwJMCrpy/KZjlwbDA
	 jWYP1naQTut2nii3AeMtCxa76Iopl650ql1Gyp+5sYF3YkigFgbhQ6EqmBNUq3DWHe5KA
	 N+ZUMmbmKEb+te7q1CUfLGMFF5UITeTmo92a5bx7kws+DULaEe0F5dVS/QmlUozVBzjVY
	 K27qjTMTx4Ke+/mf8spbtJoxCy7C4HbmPbn/p+6fc9uuwhnOIvblnVRlISns3qb1oI+ve
	 KIrV6RUwx6qjn8Z3Y9QetkTgJHjNO206/RQsbM87bx9yo9kzgEZ6HjPH2AWkx9xVCKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021423;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
	b=o+WrXCzohm73PdNybHseGuCw+YDfG+OvzUqRqyj/7yXaCE+Y24aqT3LhgU9znBc/o82c
	 McPs95WHG5/Cxx/poNbTziFZrSgRc76k5eauhbBNxPq5UCtB5guTt6E3Q8T6bEA5IITsY
	 IMjJPxHEK/WrvHGhQSPDhLeMsG7aG+J7YpQcBsSuRp7TvMHbcOmC22mmZXtHsre7Y7ZTI
	 +7fANUXpgDy2EJownppTGZvXVGBBu3VyxZZGobPeBiWuaOxGWuYzUAxe7H9OVxcPaGtOM
	 wq95a/6/Q5MQrP9sU3CLXNKIWezeMqmV/1ZpGyts/YjMP0hLoYts36FhATtOJfPMVhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzwtWeRa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC9606A321;
	Mon, 26 Oct 2026 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzwtWeRa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793021423;
	b=OX6+fGx5vbo2yu//1D/rwmYrvRYG8phmJHmI3OPViwEzj/++AaUBj0D/+0jUPbR5puIL
	 SVkaBM6nG/ZMpc3+XmSZGMGGaS8CB/e6d7HbHwWjeqgPt1trgkTuYez2RigqrB80lwIEK
	 6mTM0Xd7FafP/iYBjHwK+jI0jz/bjcMUJ4+zv8nQabToCQLr6noE8f0+05NZu/ddfyQeS
	 sDfY7yR0vPVWAG5ihFTCmOkjHnkmIbgy2Hgs7ki8tqaR6fZckNQxX39+5Z1hNmVxpLxg2
	 /4VLwI6Q9QX04jJFfmAJbXI8K6PO1l67/0QijnGS622+sIbmNIP6R1UNKJX3BgOjzag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793021423;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
	b=K7WgO9uOSVsjNAaUPhlbHZUnDCZctDxSP8TGfZNoYoe/mKZgPNvlBoKw4YfgV9zXvQQ+
	 EmGTW9OwA5MM1ZLAVBq2v1ps9/FhrDYGdwF3DncfJnJiVfKmhUV/Jgu4vtyINxG/RLbbH
	 5BfYKK4MjqENhsPa1vP03uXVfF36c0hDYLqQ6myfPQfzf2zYQ+ZkJvspihKcRxtaJK4T4
	 2SyxW7DZfr7Xs/oftyYrZ8UDbd9cr1zcY9p8kZKWXF8blFhXAgJrIkZuEsS4Wu4dLCofJ
	 1EDBfXwWm+dBSbrK0+jhjXVJ/IGSBaKdpj68zoJssgnz0KVV5FDa/cBk4uG6s5yojuw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 72BE41F01825;
	Mon, 26 Oct 2026 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021423;
	bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lzwtWeRaMrmft/zLO/PTQb7aek4d3nHTw6AFajjHJtgPj8eoTf1PTz63CSu+P2XXy
	 N6Znt8WzPsXjyVhWC4ykfDAXUsuf5G+VMQl53TfbyQl0eR2Vt6iAZuezF9huAWDYHq
	 2vd+2XrxmQfeBA4SaPA5RGpzVb3zG+Bs3urrH/dBBg/J6oWN83S8KvS/etSQop+r3t
	 rIrre4S1Ayt9Y5b/rUdKFeSz8X+PuUlu86cD2jmTOTJ96U3++21uNiF+JlFDX6dPVP
	 C6cbFhm7HYyUub5K4fz6Ef5EIVOgw8VdFfGxDqGNwzd8Qo7uYnCviE8ErkECc/SlTH
	 aTEO3HJ6DSCVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0362444D1A;
	Mon, 26 Oct 2026 13:30:22 +0000 (UTC)
From: Vincent Choiniere via B4 Relay <devnull+choiniere.vincent.hydroquebec.com@kernel.org>
Date: Mon, 26 Oct 2026 09:30:22 -0400
Subject: [PATCH iwl-net] ice: fix NULL dereference after disabling RDMA
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
Message-Id: <20261026-ice-deinit-rdma-null-v1-1-7d2130d1809a@hydroquebec.com>
X-B4-Tracking: v=1; b=H4sIAO1V32oC/yWMwQrCMBAFf6Xs2YUmwQr+inhokxddiaskaRVK/
 92ox2GYWakgCwodu5UyFiny0AZm15G/jnoBS2hMtreD6e2exYMDRKVyDveRdU6JB+OimeBcPFh
 q6TMjyvu3PZG8Eisqnf+izNMNvn6ntG0fbZLQUIEAAAA=
X-Change-ID: 20261025-ice-deinit-rdma-null-613f1be33f72
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Vincent Choiniere <choiniere.vincent@hydroquebec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793021421; l=3312;
 i=choiniere.vincent@hydroquebec.com; s=20261016;
 h=from:subject:message-id;
 bh=k9KyR/hu9YHlPLJ6ekmbRPgwMefAd5BueodKK2/VMpU=;
 b=8bwOLo9nJW2N0lkprTPvo4m7YK3bCgAvaOdITw89TeFZE4NqbPiFYxMcXYABPUonNi9ZXkF/N
 SSg99Pxr0XBDc4xD+agc0rCZRcm5RqV9IGR1Q9in27Ko8MdWDYYRiTp
X-Developer-Key: i=choiniere.vincent@hydroquebec.com; a=ed25519;
 pk=MctQE067DucsZOaNqb+sjY7aQ+urhztuURanagEW3+8=
X-Endpoint-Received: by B4 Relay for
 choiniere.vincent@hydroquebec.com/20261016 with auth_id=1210
X-Original-From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
Reply-To: choiniere.vincent@hydroquebec.com
Content-Transfer-Encoding: 7bit

From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>

ice_deinit_rdma() checks ice_is_rdma_ena() before dereferencing
pf->cdev_info. While the enable_rdma devlink driverinit parameter is
registered, that helper returns the parameter value. Once the parameter
is unregistered, it falls back to ICE_FLAG_RDMA_ENA.

When enable_rdma is set to false and applied by a devlink reload,
ice_init_rdma() returns early, leaving pf->cdev_info NULL. During driver
removal, ice_remove() calls ice_deinit_devlink() before ice_unload().
The parameters are therefore unregistered before ice_deinit_rdma()
runs. On an RDMA-capable device, ice_is_rdma_ena() then returns true,
allowing ice_deinit_rdma() to dereference the NULL pointer.

This can cause a panic during reboot, module removal or PCI unbind.
Reproduced on an E810 PF with Ubuntu kernel 7.0.0-14 (PREEMPT_RT):

 devlink dev param set pci/0000:02:00.0 name enable_rdma value false \
         cmode driverinit
 devlink dev reload pci/0000:02:00.0 action driver_reinit
 systemctl reboot

 BUG: kernel NULL pointer dereference, address: 0000000000000018
 RIP: 0010:ice_deinit_rdma+0x30/0x60 [ice]
  ice_unload+0x3f/0x150 [ice]
  ice_remove+0xb5/0x1d0 [ice]
  ice_shutdown+0x1b/0x60 [ice]
  pci_device_shutdown
  device_shutdown
  kernel_restart
 Kernel panic - not syncing: Attempted to kill init!

Check pf->cdev_info before dereferencing it, as
ice_rdma_update_vsi_filter() already does. This preserves the existing
enable_rdma semantics without changing other ice_is_rdma_ena() callers.

Fixes: 87181cd6985f ("ice: enable_rdma devlink param")
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
---
Testing was performed on an E810 PF passed through to a KVM guest,
using Ubuntu kernel 7.0.0-38 (PREEMPT_RT). Two kernels differing only
by this patch were compared. Each test set enable_rdma=false and
applied it with devlink reload driver_reinit before the removal step.

  Removal path      Without patch           With patch
  reboot (x3)       NULL deref, panic (3/3) clean (3/3)
  rmmod ice         NULL deref              clean
  PCI unbind        NULL deref              clean

Additional checks on the patched kernel:
  - Reboot without a preceding devlink reload completed cleanly.
  - irdma devices returned after PCI unbind/bind.
  - irdma devices returned after an enable_rdma false -> true reload
    cycle.

No KASAN or kmemleak testing was performed.

The exact target tree (net, 7076f684d5132e6a) was not built or tested.
ice_deinit_rdma() and ice_is_rdma_ena() are unchanged there compared
with the tested code.
---
 drivers/net/ethernet/intel/ice/ice_idc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 102d63c30..09dfcffeb 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -454,7 +454,7 @@ int ice_init_rdma(struct ice_pf *pf)
  */
 void ice_deinit_rdma(struct ice_pf *pf)
 {
-	if (!ice_is_rdma_ena(pf))
+	if (!ice_is_rdma_ena(pf) || !pf->cdev_info)
 		return;
 
 	xa_erase(&ice_aux_id, pf->aux_idx);

---
base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
change-id: 20261025-ice-deinit-rdma-null-613f1be33f72


