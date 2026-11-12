Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472206;
	b=XGgpHoAzUibXUKvKIxKBfaruOvQZI6waZNQhAm2eJqIDusUKgsMNbveXpMWG5q7QJGfy
	 cygLZQ3t8BKEfOcrKVr7Ws2IkjZFAhS/SMvGpJpvC6Z7fE4fG9x6ImPiSL3nA7Vb6PV2T
	 d+HUJpZnakFM0VyCN1ZWYnTk7EIPIOrIPqEJmgrXeK5neGP96blhpWqjii6KSfmk/lvC9
	 8+1LTq7aVq57L+0N+YtDQ6ZtOg2pUBeGHrnEjUdtXyLtqeZxGJNImL0+0MybBBuDilkhr
	 B96Oq6nslAEgKj8Pu5LqVWLsGVSztk3ereb4fKWbcxe1u7tnguyjPux0rxZnzBExKQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=owIgQ/tRdvKdvmncVBsq5hC8UuMcF+wZI1/UpydASOk=;
	b=r+BX3Qn0B3Dmbq20B3FnkNvT/FWvoJC3XdewIyozyAg917c9GdG8jz4VJomh745gPEOH
	 MWxB17VFAV8408wv/INAb5aHfc0KJSfNMefZx2gJLEJOTaGsoEHVVoUpUPvUe3wd59Pdp
	 ATnA0ybvPnT7r2aqBjDkWgBt8EbtrwKm9EaLAwp+wpttjVgsIj/fuwZ19l4iG5aXivPit
	 lfWxIfnnHD7fENIh1FMVU+EA+YONbZyU5hsZiT9lh0OLHRIbJ/PJZaKIAZVYSZ1Yu0KVl
	 kul4OP/69eKf7uMdaQJvJtgHSLGQyCQD9dOZT66uZs/rvxZenxi2nu2lnBt6KkZ1pMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/Xr6Ba0";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C1606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 144C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/Xr6Ba0
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4af52002471so2239845e9.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472204; x=1795077004; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=owIgQ/tRdvKdvmncVBsq5hC8UuMcF+wZI1/UpydASOk=;
        b=g/Xr6Ba0LRccM3YzoISSkbYD/xD6Z0Lq84J71G0Wub/5dyx4F0bj3H6cjhjhP/hWLX
         HaHDUMlDRQ3yajcKJ4ZBa6U+PpkUMenUWcxxcfJA4H3I6c+CM+Fc1zOHEHEZuMKrwcpI
         +DXbaZkdiofYAaJSyYKNn/JYiD+5TeNzF2aj9ygv10jd5M72e26ssJ86sASB1fP8TT4W
         BrkEbYv9UtsVHz5E+3ZyBOdmUUIhvmASZaxXoeDTpfJ7x2erbijFgzUrXUtxz867g8XJ
         Jhxj5JlH7WdmayqGGPlBWT2dw/QjSs12SAFWmXviEBmOZAufpuCia8mjlhLTGHWn0/A+
         QeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472204; x=1795077004;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owIgQ/tRdvKdvmncVBsq5hC8UuMcF+wZI1/UpydASOk=;
        b=0E4f5MIJkyFyVPwVnLCqvwDP6L5+qsHQbvuzwCV00OGMqiprNuUFJ5reoxXe+u63OI
         rX1+AEmDuJxv6xkKZKaJPKmnukflMCG1DBgvBDZfp0joUyo4+h0TXL5GMwVdntH9Oo9Y
         DKzibr8o2U0MKVKG5RkvDBDBWnRkgu1WqpUaXJsi3wt3k4YhuOXruNc/uZZyA+S2/s7Y
         2bMXRvUiFLJxDB4SnEjLsOSoTfXYNEgHnfQhuNaMSYkbVgQz4tepWt074W0IV/2fTT8Z
         R7psYCSYd7JOX5UP1XP9JLwr3y+CWF5aU5XoM9tS8V8qnSvaTqSShfqxAtExRvr6+NgT
         YcHw==
X-Gm-Message-State: APuU4Z9P/ODYggjzpSO7qHBZX+os20z9JKkffKwjf/zV4tLgu7RaHE8Z
	7iDGbmm8/EtsuETFsWixTPQlKyN0+axxLX1vOjqhqQfeetEP9k/nG4DpjEsX9A==
X-Gm-Gg: AYBFou0wsy1i9mEu/gNfENPcRsXk5prHi5sCMtXCwGZyUT9o/5LdS4pMK/EehiD3XtE
	WJZbNozrPncn0SfDSxbnI63nvTUZd5lBBuYf+QR02FImNMdpKpakpK3nmtTzZBniWQTYpu37pRt
	V/FVr/QSVCfC/eZobytqG+8d89LTR1fmKH+OzD1LJMTZEQnrSK8zvh7A6IbTXVQQor5LQiKLjmn
	7LFJf9YtJEKpwkdvy2FFBC1akzmLQL4hCQK/piLbYNbCTxWcbGzkyWP43yi7GUiXH1eEp/lkLip
	Rp6xgiCXIrvr+6S8seoQGHsBdP6bukaPBuz5M9QSXm++i3FhyBRJA7gcJv+W7EvVKcjmo2QrmkO
	2JAY4ZLrppOh1ZBa2JR6NWa3jWaz2apxdRV7HFWiKXvgfYffFvo9FQC48yknj6nSCczFGJhurgk
	rVIsInwCaPsf/W7AsGFy96OFwW9Mwg5mCYZ/Blrofalmy/MEjTfUi26Xt2cEe5YBH2wk9hnZRZ3
	/534YxvQJ+c4xzbliAziLrg5EdhKX+ULo2PkKhq/G4YNsdjJnBCUMyYyEEjtf+FXi8P2v1OISOI
	aQ9GY4zi30CUgQrnRYDvgArCDxOdObRyOpx/M1LFeg29H4/vail3AP5t2qK288OineFbOldIZml
	UtIZjNA==
X-Received: by 2002:a05:600c:4e56:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4ba09357427mr85388625e9.1.1794472203788;
        Thu, 12 Nov 2026 00:30:03 -0800 (PST)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0950f3casm74154915e9.3.2026.11.12.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:30:03 -0800 (PST)
From: Marek Czernohous <mczernohous@gmail.com>
To: stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH 6.12.y] drm/nouveau/pci: use config-space MSI rearm on
 MCP79/MCP7A (NVAC)
Date: Thu, 12 Nov 2026 09:30:02 +0100
Message-ID: <179447220251.849346.14034519032960424850@gmail.com>
In-Reply-To: <20261107051608-failed-6.12-354d47fb3f35@kernel.org>
References: <20261107051608-failed-6.12-354d47fb3f35@kernel.org>
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
[ Backport note: linux-6.12.y predates commit 2f89bb3264af
  ("drm/nouveau/pci: add PRI address of config space mirror to
  nvkm_pci_func"), so struct nvkm_pci_func has no .cfg member here.
  mcp79_pci_func uses the nv40 .rd32/.wr08/.wr32 accessors instead,
  exactly as g94_pci_func does in this tree, and still differs from
  g94_pci_func only in .msi_rearm. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
Sorry for the late reply.

Compile- and link-tested on 6.12.117 (nouveau.o, W=1): no warnings in
the touched files, no unresolved nouveau-internal symbols. Not runtime
tested here. nvaa_chipset has the same context lines as nvac_chipset in
base.c, so I checked that the switch lands in nvac_chipset.

Fab, you run 6.12 on MCP79: if you can give this exact patch a spin, a
Tested-by would help.

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
index 9093d89b16..6f13b8b0fc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -1237,7 +1237,7 @@ nvac_chipset = {
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

