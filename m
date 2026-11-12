Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472210;
	b=X0Kh350oEYcAv0iYEjcGgxItgqRwP+w3a2ZwV/GJb3PAChLIyGnohRODMLdXISg2LvVo
	 cyM52CHhfGkNhwvXBRdLCU5XrVGr3V8S/9FfOklqKG0X2/sLWbc5MCdTac/SHrwErwFp9
	 T9kqRwVYNE6LtZTFc+ubPnQ6LJ0bSEVzEVGa88yw2UAaQJ4JzWnU+8TYAF7yBE9wxd8R6
	 i5VD586HbcjT3mjnAw7CmNahsO6+UAB//xaaRlq6AypPiYyDDBOdn2Yi+j/2PyjVuRpHr
	 uWxKSbrzJ0ana8atH5uR3uNgsHk2NMM5hkt4FkedswXiEi+3DLZIyHafH75Se7l+gzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lPMgg8I8cmd3dnPUVJPo7xSLVrsMdfnnBOxd7ysMh8g=;
	b=tDDraRKusjc+jV3tVfoefNFI1uTDQuev9VUO/dxgMYLOiSzSZidJfZGGzdChK9qr9Tw0
	 rS1X2g3wMLYQP1+IJRhjbJEBHCz62v2ekISgcKl4jR5SctJpUAbPh6ZGAfV9hhwviioJ6
	 h1y/9nQejAn9BuUT9A5xfhAoRoCpqwR/eUFEvdtNIKXSTqMvjOFg0Wdf6UoNHdwNrNyS0
	 alDxNN/eLgL/sQ7B7X+OE+kdJJRSfARv4zAQweKO+aAU/bhH7KUw2SZ4V2Awd6uOmtv1b
	 +JfLLgi0yFg0OQt5T4waIdQfwbchkmrDGY84P5bD9sX3p4Yq1wgUVhVG3uaOCC1TNdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3TLUd1u;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB5F606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB5F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3TLUd1u
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a59ffacb51so2128985e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472208; x=1795077008; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lPMgg8I8cmd3dnPUVJPo7xSLVrsMdfnnBOxd7ysMh8g=;
        b=A3TLUd1uyhQTbC03FUC+2N+jMkGrX1VLmQanTa8mZfCCjZ1bV/iKJHa88AC21H8fLA
         fTJPfyOjWSh2LBljZT2bv/bvGOBwCKfhXteL63lePF35mirncIbBMyV5f1Ub+15ar1yZ
         U0418Waxj+fhtDYZAxULMgnMW2vXBlfsUIAWjf6VMhOQIz3snrkYDp5YHf6urzjbSywI
         biSeO5lcgr+Mb2cZO2AvvSMHt57GazH9MGHsBRUaIk/TKlPWXzeLCj/0ntFcLwIri/E2
         ntGfbaJMUVno9VG27BxM5oQfPgbSGX9JkhkYVwa+211R2X3fo34aWHFzXCWtrd3lpqgl
         imeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472208; x=1795077008;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPMgg8I8cmd3dnPUVJPo7xSLVrsMdfnnBOxd7ysMh8g=;
        b=B1uyeWic0uhsaoGVr6gqgq5TlmKKH5ONbNaMXNw5CcVwkuKhIqLoUWAs/LTWZA9vyl
         VYlIvGW+Mb3OODnMcuOf1GtjE7D2DBVE5IkCjLydhEp+kojO7wsp6rGyrn7p/U22V0Jx
         tUTOtakj5wMdxx3VAQoVfnNbLLMMFjJ/Q+4NurNOalZkM+QHP3Zn9peKMDKZAcmsf0da
         OoHddZkVYZJ7FVX5OPOtfs9CuNxTi3iFhGi7cR8bUZZuCSdww31Y5sApN7gBGuS0omO3
         MrUSwzWmKzlYxawEgEMus1FPQPaezs8MhhUZKVfQFl70rMB1QLvi43xRYNBu2Naywslt
         FCsA==
X-Gm-Message-State: APuU4Z9PBIKuqJdO3NZBI+cGi0MUe74E/+eqkhWzhZwS/ExOUIGocjm2
	mx83kR/MEqKBYYnX0nyK7FUGNPenOitFKhvchqOtpV5UdxnmEn2jG+Dy1ucL5g==
X-Gm-Gg: AYBFou0OswumtXDonwMrn2PqHT1/HhWMTMsvO4z3e60ly8q8DL+Gc+KmNifh+jLxtiH
	5bCJuz7KY3ysiouMssudwRrEw8LIggItmwSj3rHdIl9zu/S25eFaVx5eRsXKRtkMRDLLrPGoC1a
	EzPNp1l4Je/qahkyaRBFYrgpAyTia4HzFGjFShluQJaO2lkZhQGxfgeBzLLcdp94HsmRvvhkfUg
	q3KBlSC6GtjzTUjs5+N2EIU13C9l0lfOxcb8Su2gfRSSfVs0jWuq5Apai4gdT4tDQzmUoKQVIuW
	cq72VmRHaPlHHNyB2X0ljgY/QRaW4FBni6he8zXf8nhmRMycF9611lZOQikGRScMwYahpAPPnDO
	EPmwQnTCzVF2wk64ZztNOvLkJRyPhkETh/uNULrniGycO5GvZJnOK2PvxzkSMgZUvhfuTpSM6Ei
	e7m6Gi3DR1emZO9I3d1QjZ6hEdFeY8cRMvYw27haFjaocwqnT1Xz+bJlikclQEKlfFFbB+03yI/
	ho1NGICmseLSVV03DGk78jCb+d0IghLlDYMdod6SFgrInw/GjuKV/O06D1AWGs7Zuj+uQW6gKCP
	sy4gbACb8LSUxoFYVHxcWAZmH7drLhdANpC/n3IsBMLr3MuveJcWDTaIyWPgcUyNlBJPzEM4mCv
	L7FlKTg==
X-Received: by 2002:a05:600c:a113:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ba09353f92mr67367785e9.1.1794472207617;
        Thu, 12 Nov 2026 00:30:07 -0800 (PST)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0950f3casm74154915e9.3.2026.11.12.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:30:06 -0800 (PST)
From: Marek Czernohous <mczernohous@gmail.com>
To: stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH 6.6.y] drm/nouveau/pci: use config-space MSI rearm on
 MCP79/MCP7A (NVAC)
Date: Thu, 12 Nov 2026 09:30:02 +0100
Message-ID: <179447220252.849346.7365249856440289467@gmail.com>
In-Reply-To: <20261107052812-failed-6.6-354d47fb3f35@kernel.org>
References: <20261107052812-failed-6.6-354d47fb3f35@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Marek Czernohous <marek@czernohous.de>

commit 354d47fb3f35461b7f942831c1b2a7105e92b57f upstream.

NVAC (MCP79/MCP7A) uses g94_pci_func, whose .msi_rearm is
nv40_pci_msi_rearm(): a re-arm write through the MMIO mirror of PCI
config space.  On this IGP that path is unreliable; when a re-arm is
missed the interrupt line stays dead, command submission times out and
the GPU appears hung until reboot.  On an Apple Mac mini (early 2009,
MCP79, boot0 0x0ac080b1) this showed as sporadic fifo timeouts and GPU
hangs under load unless MSI was disabled via config=NvMSI=0.

Give NVAC its own pci func that re-arms through real PCI config space
(nv46_pci_msi_rearm) instead.  This follows existing precedent: nv46.c
documents the MMIO-mirror re-arm as broken on several related parts,
and commit 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm") fixed g92
the same way while moving the remaining chipsets, NVAC included, into
the newly added shared g94 table, where NVAC stayed on the MMIO path.
This change completes that fix for NVAC.  The sibling IGP NVAA
(MCP77/MCP78) has MSI disabled entirely as "reported broken" in
nvkm_pci_new_(); NVAC works correctly once the re-arm goes through
config space, so disabling MSI is not necessary.

Only NVAC is switched: that is the hardware this has been validated
on.  The other users of g94_pci_func (G94/G96/G98/GT2xx and the
MCP77/MCP89 IGPs) keep their current behavior; MCP77 and MCP89
plausibly want the same treatment but were not tested.

Tested on the Mac mini as a daily driver for two months with MSI
enabled and zero fifo timeouts.  Independently confirmed stable on an
iMac9,1 (MCP79) running 6.12.90 with the v1 form of this change (the
same one-line functional switch, applied to that kernel's g94
implementation).

Fixes: 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm")
Cc: <stable@vger.kernel.org> # v6.16+
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Marek Czernohous <marek@czernohous.de>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/178688574401.522643.12812428444459119913@gmail.com
[ Backport note: linux-6.6.y predates commit 2f89bb3264af
  ("drm/nouveau/pci: add PRI address of config space mirror to
  nvkm_pci_func"), so struct nvkm_pci_func has no .cfg member here.
  mcp79_pci_func uses the nv40 .rd32/.wr08/.wr32 accessors instead,
  exactly as g94_pci_func does in this tree, and still differs from
  g94_pci_func only in .msi_rearm. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
Sorry for the late reply.

Compile- and link-tested on 6.6.162 (nouveau.o, W=1): no warnings in the
touched files, no unresolved nouveau-internal symbols. Not runtime
tested here. nvaa_chipset has the same context lines as nvac_chipset in
base.c, so I checked that the switch lands in nvac_chipset.

 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  1 +
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild    |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c   | 36 +++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
index 3c103101d5..f21d6f1cf4 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
@@ -46,6 +46,7 @@ int nv4c_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct n
 int g84_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int g92_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int g94_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
+int mcp79_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int gf100_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int gf106_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
 int gk104_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int inst, struct nvkm_pci **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index 49b487a265..134c0b0824 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -1285,7 +1285,7 @@ nvac_chipset = {
 	.mc       = { 0x00000001, g98_mc_new },
 	.mmu      = { 0x00000001, mcp77_mmu_new },
 	.mxm      = { 0x00000001, nv50_mxm_new },
-	.pci      = { 0x00000001, g94_pci_new },
+	.pci      = { 0x00000001, mcp79_pci_new },
 	.therm    = { 0x00000001, g84_therm_new },
 	.timer    = { 0x00000001, nv41_timer_new },
 	.volt     = { 0x00000001, nv40_volt_new },
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
index 174bdf9952..c5911d7d08 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
@@ -9,6 +9,7 @@ nvkm-y += nvkm/subdev/pci/nv4c.o
 nvkm-y += nvkm/subdev/pci/g84.o
 nvkm-y += nvkm/subdev/pci/g92.o
 nvkm-y += nvkm/subdev/pci/g94.o
+nvkm-y += nvkm/subdev/pci/mcp79.o
 nvkm-y += nvkm/subdev/pci/gf100.o
 nvkm-y += nvkm/subdev/pci/gf106.o
 nvkm-y += nvkm/subdev/pci/gk104.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
new file mode 100644
index 0000000000..98d85a856b
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Marek Czernohous
+ *
+ * MCP79/MCP7A (NVAC): like g94, but MSI re-arm goes through real PCI
+ * config space.  The MMIO-mirror re-arm is unreliable on this IGP and a
+ * missed re-arm kills the interrupt line (see the nv46 comment; g92
+ * already re-arms through config space for the same reason).
+ */
+#include "priv.h"
+
+static const struct nvkm_pci_func
+mcp79_pci_func = {
+	.init = g84_pci_init,
+	.rd32 = nv40_pci_rd32,
+	.wr08 = nv40_pci_wr08,
+	.wr32 = nv40_pci_wr32,
+	.msi_rearm = nv46_pci_msi_rearm,
+
+	.pcie.init = g84_pcie_init,
+	.pcie.set_link = g84_pcie_set_link,
+
+	.pcie.max_speed = g84_pcie_max_speed,
+	.pcie.cur_speed = g84_pcie_cur_speed,
+
+	.pcie.set_version = g84_pcie_set_version,
+	.pcie.version = g84_pcie_version,
+	.pcie.version_supported = g92_pcie_version_supported,
+};
+
+int
+mcp79_pci_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
+	      struct nvkm_pci **ppci)
+{
+	return nvkm_pci_new_(&mcp79_pci_func, device, type, inst, ppci);
+}
-- 
2.56.1

