Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472219;
	b=vBAGVYaMqHSUgmezJHfyPOv47K8f6hOItuVqWtl9qb7W/fzUtKGITu2zTO6W2UoQ4cu+
	 NuB9eL6Xu8rmIgU+oRvFA5WHDk1F42BWLoWpLBY4J6B3GMv71CyUVcmfZ6vLYRKZGw1L+
	 +TvZi4IF9E1tdJ7WAonUDUwjthRbvoaXJ6XaapJfPNIw4XPtW9q4z7qQ4kUWybYUM9oRb
	 YXotf2elUYXd4+3Zi+aCOQnEplgsvB2vXxfYT7MRKKHeWSUCAZ3o6xyFYaB86GQa+rY81
	 gJqM/u6hXQ+nV/EPh9feTM6EGv9Mzw19PIBXudQEzFOroj/Sz8MXvYSPjB5YXMp1IOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WfvHy+o5/cL560b8wOB/IeOv0uNPKDE7wddyFz1YBvY=;
	b=CzrdZfZMnaYAPMw+W12HHVacWXSs9nn8u3OAOPCp9OB2QLZrONx4YhUOJVlINHsJSoqF
	 D54tzs5j/7EnQ4dqXLDBEOc3Zd1/gjtQ/gO4AA5mEKhWOGJQSFkLMqTg7FegJ7FcOlwLc
	 egYFuQfIFNxymxZdErETRJbSTKDZpDbrTv91QhBj/+QT+O85hUBlVP0L1SEzCTlGBXj69
	 VcYFuhUxJ/DTajr5NzOpbB3OhrHD91LFzcBT8E7kQ1MZH1MRBCp0SLaUUfaaozLraWUy4
	 tOyMb94LoGic8XN6rwexhr1u3HpEKsJD4yd5geJ/bh24laFDj0QK2KC6TNXno1vUOLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dTzLx3t5;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27F606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F27F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dTzLx3t5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1f80b7bf6so1532055e9.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472217; x=1795077017; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WfvHy+o5/cL560b8wOB/IeOv0uNPKDE7wddyFz1YBvY=;
        b=dTzLx3t5ETAVqTU8cI6hKPwpwoVMB1LhL7ul4vKrYgZnwM5GSD47LzA0OyoyXp3L0A
         rjHlkCHrw2JtaA5GCGp7XP7L7gpuCtBf6E4LVYtvVpqiMjPC6KjTL8UX7ieWiz18G6+9
         v19Hm8eCT/IW4d41cvy6qVZ7WJvXm+p8CY4Jec5AUQZiP4GVO4qjn0g0NDFcrG8m3C1l
         M6mL17U7IaplqyLJMKfZz0Ozk1tKMjVtrppliYIE9ibc5VnUnbkBohNSLLF5yJZs159L
         QMs6g9Wox3lDg9dDoG4dEGQMa4lRyzLAUN4N1j9udP0dSn30cFcdUEUvaRKNS3goKygT
         uwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472217; x=1795077017;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WfvHy+o5/cL560b8wOB/IeOv0uNPKDE7wddyFz1YBvY=;
        b=Mkpl07XAvsGOtHmGmw5fYruVKo/7JsFcufuddO14DhYZFYW7BDEeNAGyEPuxYG6f1n
         82SgS/6z7lnalpyoKev3c95eJdFqQ5zIjhiOxA1lTHUZxe1nno0AR0vFWlnXzXunkxoC
         IzPVNecS2KeSZ2SKqFzK1ZbHsEtAS8Y5fOCmovQhkb5vRcVmoTigm4WEqe6/dX2K8OFt
         uPFkeVfF6XJiBHqolhXujMvwJ66V6uK3GMaY0snxfncgZLaadBWAOPoJ/RsB4VxNLx9n
         xwsezBFIh7GyvtAA7ZXZMJiumEs6GRi7Bdj2i4tUUxzZ0JXqNr5Udi4q0m8TimSl7pBT
         QjLg==
X-Gm-Message-State: APuU4Z8HLPJkvzHFrRT+yA8pFrj1ON0m7TDupjQQVN5f6foGOQwldw0q
	Irv5TJWWE9+EjVwfKKjWcD1fg6GTRCtVBvB0//46eoi1GnFGbsg6mrtbD2GIXg==
X-Gm-Gg: AYBFou248NhsiWY6uORhEdYtZwnHa5pFez2FCDAPZ3lY0o69knBJDWYftJZPqBM0QbU
	rw4w2IEDM1He5d9vcZrPLrm+TKExFd4Nx+8DrdLRutXfq0SVMAvIapL0HvY/mTVOToBLF+6xzw2
	MCD1o/h9uwBTSBM9QS1pfKQqPBXKi7+XBdvnffYK3UDh+NyjHM6io0BCLZI0Htwj84Hx1tuSqbD
	lreE1u1JrMsNwFBC4/fJVuFKINXzDngl5QGt2NHRZSBVq0loLVhOCBST1UQXh+KwYWbXY4XZBAo
	et9aa5kgJ2GoSKlUKh+HCqr0h1dLzis7XocOyFI/5f+h0WDqKWTcAqs/IjgDDOD102ypnH59jrk
	LJSZ8vjpKH8THyRZqGmzyF2GaBhjxFRJR9cTwKqUyJjHvF+C2l9Rsg3eTW+vBu44quMsrH86MFM
	MhRej4wNS6mzuqCvkLenXMxSgQvtjSC7+bqPtuduDcelJASyVB3zmVy6m4kgvn65y7TrjcT2I68
	EZcsexncRQbUGIT3S1wicopP0+YmDj3w0dI5A9NJmSUKgvi2SnGQ+p87TAgizK3M89k1Tc3mJi5
	7LoKTSpcBWQtsyA2nEiheRiWtWxm8UgCkDf/n9eNmMAk+pHC8ReKqw2hzy9oAGqsZYyG+HlaEtZ
	xeCokkQ==
X-Received: by 2002:a05:600c:a113:b0:4a0:13d8:cd0c with SMTP id 5b1f17b1804b1-4ba0936c91cmr68065155e9.2.1794472217233;
        Thu, 12 Nov 2026 00:30:17 -0800 (PST)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0950f3casm74154915e9.3.2026.11.12.00.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:30:16 -0800 (PST)
From: Marek Czernohous <mczernohous@gmail.com>
To: stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH 5.10.y] drm/nouveau/pci: use config-space MSI rearm on
 MCP79/MCP7A (NVAC)
Date: Thu, 12 Nov 2026 09:30:02 +0100
Message-ID: <179447220252.849346.14683922850046432312@gmail.com>
In-Reply-To: <20261107061405-failed-5.10-354d47fb3f35@kernel.org>
References: <20261107061405-failed-5.10-354d47fb3f35@kernel.org>
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
[ Backport note: linux-5.10.y predates commit 2f89bb3264af
  ("drm/nouveau/pci: add PRI address of config space mirror to
  nvkm_pci_func"), so struct nvkm_pci_func has no .cfg member here.
  mcp79_pci_func uses the nv40 .rd32/.wr08/.wr32 accessors instead,
  exactly as g94_pci_func does in this tree, and still differs from
  g94_pci_func only in .msi_rearm.  This tree also still uses the
  older (device, index) subdev constructor form, so mcp79_pci_new(),
  its declaration and the nvac_chipset entry follow g94_pci_new()
  there. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
Sorry for the late reply.

Compile- and link-tested on 5.10.274 (nouveau.o, W=1): no warnings in
the touched files, no unresolved nouveau-internal symbols. Not runtime
tested here. nvaa_chipset has the same context lines as nvac_chipset in
base.c, so I checked that the switch lands in nvac_chipset.

 .../gpu/drm/nouveau/include/nvkm/subdev/pci.h |  1 +
 .../gpu/drm/nouveau/nvkm/engine/device/base.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild    |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c   | 35 +++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
index 4803a4fad4..d1e080b6ac 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
@@ -46,6 +46,7 @@ int nv4c_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 int g84_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 int g92_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 int g94_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
+int mcp79_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 int gf100_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 int gf106_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 int gk104_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index 7851bec5f0..a8f325bae1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -1286,7 +1286,7 @@ nvac_chipset = {
 	.mc = g98_mc_new,
 	.mmu = mcp77_mmu_new,
 	.mxm = nv50_mxm_new,
-	.pci = g94_pci_new,
+	.pci = mcp79_pci_new,
 	.therm = g84_therm_new,
 	.timer = nv41_timer_new,
 	.volt = nv40_volt_new,
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
index 0000000000..5c831bcaa3
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
@@ -0,0 +1,35 @@
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
+mcp79_pci_new(struct nvkm_device *device, int index, struct nvkm_pci **ppci)
+{
+	return nvkm_pci_new_(&mcp79_pci_func, device, index, ppci);
+}
-- 
2.56.1

