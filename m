Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266841;
	b=YVUPJ0nOk3yQwPgFnB7C4Lx2mSUcSkLrsEufcDeM9GWYyk9WQg544QSZXfnuqhscmYtv
	 nPU8EqdB9/BnMNyviP1bD38BdRVa2GHzlogzZTwO131JqnkS1gUxC6F8QZSGWkXv5fb5B
	 1GcZmE3Tph/lkpVibgJP17htvUbuV0VllIxL9L7eIfL33cmggY5XAUUuU6yudPJcbFb8z
	 agEVh5hY8JuS9mh027tByShUBQkvKXfIXxL18CyZPogXBvRtCouXg+Hf3SonvHSc9AfCA
	 yAgwHrtCGx/KtvInr0Y7xouFo3fc8CZ2O+eGed8RA0okfTbOdNnrhWvE41saUZwoKHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3uk1V2g2BrgRRimIAVfUYX/6Cv+bp9NcizxCwFi/VHA=;
	b=0XcZ1nZnf1eswWSECDeZBSNbl06wGugUpEM36QA7Nr3SQAbANF2YlWSCoQKobk11rC0i
	 99IaEgQTI5iq53PqTBizhUMlL1AQCrwuo/59HeiWLcz62CeHi+YHjMvlYGmmBS8JhbYfq
	 wCy4PkT8vdhs3gqJ7eLVX/djtiOS7KOk9RXFzK1GXYIlALnwicUQ7ORDeSmyQrKwqiPUN
	 CsQuVtOtGNSB78+44z7mHJbxfi4iqyXZa63ltHvSTlnmZr7BNRZLSgFFDenLZMZbO9OCE
	 O16aKweXrnHift6KIdIyv9iWBiBIh6MZvRk9soiBElpCCPH+CblczHIj/zUyKM1xHUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MB7L0WjR;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D6606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1D6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MB7L0WjR
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eadef147ffso1465463e0c.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795266840; x=1795871640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3uk1V2g2BrgRRimIAVfUYX/6Cv+bp9NcizxCwFi/VHA=;
        b=MB7L0WjRuxNm2sDbU53jnYFLwRyTA18s2ge80AXr79j5l+UllV+6IQBAfdXVuwCYnn
         nAhqlqG5Ke4YnpNKYl1nv7xPjY4MUtHiESzbDffGoSSJVA1VC4f2T8x5plegXTg2gyUP
         GcLEXIQKTPOkZ6djyA23AlKEygitFg9S5y4V8kCulbw91NUjI3weV5biL/6rLowx7Jnc
         +LeqroPNE8litre6N/7LPYo7UbBCZ9MZEaxwkv980WhEThRe+x6ukRteraFveS1XMmVy
         dUxsE4abhlrIOaNKb+myoVNndM/KoJj5tlRjHKmJytgq+qhh9Xi7CuUnvt11iLE9zMp/
         SaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795266840; x=1795871640;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3uk1V2g2BrgRRimIAVfUYX/6Cv+bp9NcizxCwFi/VHA=;
        b=LT097SxLEVaMOd9jrEAu3jGjLr1/iTesqwHTSArCA2EK07LuG2BqiigqRXuP37v3Uo
         noe4u89KpyLoTrB5DUWgANUCyCLp7vU+LfA0vcJt8X9YoNQra4lOBTNMe67dFqED/xJA
         umXCCQmdRTGEAkj6pL6ZFqFWiKibYykHNUBvCReHKlGMVMu8oIUT9r1eE8b8wrQ6lhew
         eR/hS9vQV8gkaaQZtrv69kN5SzbzXatGmYKg4wVI/2xM6QGImYHL74+s9835SwEeX+h7
         DHa8cS+dbHXOksQpupcorTudnJ2NKI8yLM2NBe7jM68vfpSm6DRsSgmvBFVRWvQRxMP0
         CwKw==
X-Forwarded-Encrypted: i=1; AL+hErEFGPldtu+QRTysf2QQkbu7r2sJo/N8dY8ao37qu1Bc97MhN340jCf/n+bX8plI1Hzqv1Gz6aQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gcLtmHZVqk4xbNBuNSZLahTD3oRbVwj23jwhaUm6rKSdSpTLH
	rKh9qF/67zLeEO12ab2YlUMO4x+rBBu8Wyfg4ZSVy0RJ3f5ePbIqgJa8cy8NQ9T9GlU=
X-Gm-Gg: AZFdTZerD8wCtSUHO/KAyYAxGGXVUNEhLjRuJCLeie349tF+oi5wrcYLmAcVm69iWg9
	HQOK+bgGERfFb8VrDniSGepG6qWaZI5ly3ncciPpRcV3MArcPXZPBrS11YqQsKcW9dP9+oHTnkq
	53PQ22sF+LqM8LVsXYR77t2VDBclXzTYv3Bu+v0QEniAituoQL7hHkjglm0kr5Fq9CPLv8MDjF7
	ok5NT8RkgUBvQPpn7jsl2JVzoqnmMT7PWm0eleIR+Afi/J+JOu+86w4TPhz/oROShXrYVupVzP4
	BbhAN3AMCuEqPcE/VYT6ncs5LktpbkJdiEWIMJ7Alxggc8PdQd0nbf8dO8REbrPOJCwgWupdz/O
	amoxUCqdzA69gDuiOGzJs3JDNEbWSAcNR1VtNG/VF36wRdxg864ohj2DBvZaNx/Awx22ni2Z4+8
	ZRx25T0xxu5ufkoUp/if7+RNS542TX0HRFNtTAG3xAJLflAhHBg/Wkc3xQbXA0Rs1HeomJbpXYM
	0YIv3XDzYkrOOvxGenpE62tC88irP9F5soICUAbTRzpqzVzxb5jsPNmd/t5lKdRgMUXfID4UP0g
	xqe4WGlEKRNBi1nUu4O8h/GJcNtNSFp7y6NbL8UEAEbPKbY=
X-Received: by 2002:a05:6122:4201:b0:5ee:a81:e77 with SMTP id 71dfb90a1353d-5ee8af0e023mr2950746e0c.6.1795266840149;
        Sat, 21 Nov 2026 05:14:00 -0800 (PST)
Received: from localhost ([2804:14d:5cd5:542e::1a7f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dfc0b22sm5702260241.6.2026.11.21.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 05:13:59 -0800 (PST)
From: "R. V. Lobato" <vieira.lobato@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, Ilia Mirkin <imirkin@alum.mit.edu>, stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] nouveau: GM108 hangs at boot since "drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts" (6.18.64)
Date: Sat, 21 Nov 2026 10:13:50 -0300
Message-ID: <20261121101350.bab69dff11a2@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The 6.18.64 backport 15465d681517 ("drm/nouveau/devinit/gf100-: try
to avoid double-running vbios scripts", upstream 2139cb633d48, review
patch 426/686 <20261113153835.372076643@linuxfoundation.org>) breaks
nouveau on my GM108 laptop GPU. The machine hangs during boot.
6.18.63 works. Reverting only the gf100.c hunk of this commit on top
of 6.18.64 fixes it.

Hardware: HP Spectre x360 15-bl0XX, BIOS F.04, Intel HD 620 (i915,
drives the panel) + NVIDIA GM108M [GeForce 940MX] [10de:134d], no
display engine, runtime PM enabled.

On 6.18.64 the VRAM size is garbage and the boot stops shortly after:

  nouveau 0000:01:00.0: NVIDIA GM108 (1180d0a2)
  nouveau 0000:01:00.0: bios: version 82.08.62.00.15
  nouveau 0000:01:00.0: fb: -1159778304 MiB GDDR5
  nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 6013d4 [ PRIVRING ]
  nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 10f65c [ PRIVRING ]
  nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 17e280 [ PRIVRING ]
  (no "drm: VRAM", no "Initialized nouveau"; the system hangs)

On 6.18.63 the same machine prints "fb: 2048 MiB GDDR5" and nouveau
initializes normally.

My reading of the cause: the new code in gf100_devinit_preinit() runs
the VGA CRTC check only when

  !(nvkm_devinit_disable(base) & (1ULL << NVKM_ENGINE_DISP))

The guard expects nvkm_devinit_disable() to return a mask of disabled
engines. In 6.18.64 it calls the void ->disable() hook, which disables
subdevs with nvkm_subdev_disable(), and then always returns 0. So the
guard is always true, also on boards without a display engine. On
GM108 the VGA CRTC reads hit the PRIVRING fault at 0x6013d4 and, I
infer, return a nonzero value (I did not log it), so post is set to
false, the VBIOS init scripts never run, and the memory controller is
left uninitialized.

nouveau.config=NvForcePost=1 lets the machine boot, but only fixes the
first init, because force_post is cleared after the first preinit.
On every runtime resume of the GPU the check skips devinit again:

  [   35.770421] nouveau 0000:01:00.0: Enabling HDA controller
  [   35.805652] nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 0000000000120000 engine 05 [BAR2] client 08 [HUB/HOST_CPU_NB] reason 02 [PTE] on channel -1 [007fd38000 unknown]
  [   35.806084] nouveau 0000:01:00.0: fifo: SCHED_ERROR 20 []
  ...
  [   75.453651] WARNING: CPU: 0 PID: 1081 at nvkm_runl_cgrp_get_cgid+0x79/0x110 [nouveau]

Counts per boot:

  kernel                        runtime resumes  fifo faults  SCHED_ERROR  WARNINGs
  6.18.63 (two boots)           25 / 30          0            0            0
  6.18.64 + NvForcePost=1       2                31           103381       39
  6.18.64 + gf100.c hunk revert 3                0            0            0

The revert I use (restores 6.18.63's gf100.c exactly):

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
@@ -27,7 +27,6 @@
 #include <subdev/bios/init.h>
 #include <subdev/bios/pll.h>
 #include <subdev/clk/pll.h>
-#include <subdev/vga.h>
 
 int
 gf100_devinit_pll_set(struct nvkm_devinit *init, u32 type, u32 freq)
@@ -100,25 +99,6 @@
 	 * can use it as a reliable way to know whether we should run devinit.
 	 */
 	base->post = ((nvkm_rd32(device, 0x2240c) & BIT(1)) == 0);
-
-	/*
-	 * However some VBIOS init sequences miss this bit. So fall back to
-	 * the nv50 method of checking if the bit is not set. Running the
-	 * VBIOS multiple times may have detrimental effects.
-	 */
-	if (base->post) {
-		u64 disable = nvkm_devinit_disable(base);
-		/* magic to detect whether or not x86 vbios code has
-		 * executed the devinit scripts to initialise the
-		 * board. only works if there's a display engine.
-		 */
-		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
-			if (nvkm_rdvgac(device, 0, 0x00) ||
-			    nvkm_rdvgac(device, 0, 0x1a)) {
-				base->post = false;
-			}
-		}
-	}
 }
 
 static const struct nvkm_devinit_func

A proper fix probably needs the guard to test whether the display
engine actually exists (for example nvkm_device_engine(device,
NVKM_ENGINE_DISP, 0) after ->disable() has run) instead of the return
value of nvkm_devinit_disable(). I have not tested that. I have only
tested 6.18.y; I can test patches on this machine.

#regzbot introduced: v6.18.63..v6.18.64

Thanks,
R. V. Lobato
