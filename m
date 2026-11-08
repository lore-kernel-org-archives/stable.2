Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176144;
	b=yoSuIOgh9bPDVuPrRIbXWhv9lKez2WbN8Kr5qpCSeVZM4oFFBPq683oM08VK0Czu2ctv
	 VRCCCXGflPuHRfQp0r+qim81JzlxdNkL0jS8PiGLprZ+HK72+6grCP6N7knflMd39WRWi
	 J2Yv9HLHwzv7ruiMYDczNk4vfYCt3E26fWbl9MixeBxjU3mts9H/BKjWAyNtHIn2lV+l1
	 VPkSYKKGL5t0DSFYHOc0EE4Npw9SezM5P3UyjzfxMPKhljCNhmZtq+aYavHGz4JaFR+2/
	 bBlK3GbNrGT6jIDlhZAcUAWpdJXHlhRfB149/AzPEf/+9G34rl1i/tafjz3F4SSPgjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Uvr+F/2JK1AaGLCznMP5hvSKtAyjP1MI/tlzlJAmTmQ=;
	b=kJghj3PFZoEGfxxQP1NcA7kBGrfXniN93asg8UlQ6O8orXNEcwlHTLrz2C4JFptvI7AU
	 F3CdlAaNcCPKUe/9uCCOdrqBwH25R2WSuJ2pONdXN7cOT2s5C9YvJHMZ8XWb44ahEjlHa
	 5wWc/9nAbK9Zy5vh2b22rRy0idehByDL8aNIcgysudFZecP+oqGWmvQJ/++J/LFkHzml6
	 MuR9+vkfmlRuVYC+bXK+uXWdCYMyY1wbILCgmCQtOkFG9B+j/+MGUovG2Insnu5ze/rLq
	 ifREWUJ1bq5KXuCg15H6vFJDq1RcxgV0Fm4i85+0fShJUuu3SEWLvA7Usx2Xiz4R6ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jahs.net;
	spf=pass smtp.mailfrom=jahs.net;
	dkim=pass header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AGCI9h3L;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F94606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jahs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jahs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AGCI9h3L
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a208d93758so2752235e9.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jahs-net.20260707.gappssmtp.com; s=20260707; t=1794176142; x=1794780942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uvr+F/2JK1AaGLCznMP5hvSKtAyjP1MI/tlzlJAmTmQ=;
        b=AGCI9h3LqFo/LTv7FSC7qIhFizMYFvrWo4Q28P7cagweU/yIHSP1hF4RZH0mMHNI0s
         l3/7cj30FwDvYGAgAyV7hOMA/I/DARh48a5+puSUEWF02JMUi+g7ugf3pmEXn2OSLysj
         8ixnhAeOiijBeV6/vGJzbydEgg36w9HoCnz/ApkVsLPgzdxiNq+vuT7Lc2kxI9wp0PVw
         Z++z249mvd0vNWcZKPNCxdsQVMt3CbdnSswbf+/6NRj2K++KrDHSmYRvvAiQfrBAHasf
         WH5EITQ/JZzLPNCCjm/6ckUpS/z/jLD1FTu5wZrPQsKtCcuCqyPuYgvSWbrnkKH8ktla
         e5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794176142; x=1794780942;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uvr+F/2JK1AaGLCznMP5hvSKtAyjP1MI/tlzlJAmTmQ=;
        b=A/OUwCzIl78dllsaHTxY1+1RZN5N+59ItOcbBDql/4vvT9eUCd8nfjSLDxO9cp2GuG
         v91HB1L6WcShZsbIkloXe8H+N9FMRjlwuVGDrVVKAqnfTDcHD0i3liLEafsdsWuMhVDo
         f95ZgO9uyrkft8Zxvx8qlRTblJ9xCuXoV8p2E6yXfyNbzl/5svO2kCw6dXOJdGrzS3k3
         dp3MdayadqaDZFXH7gZXSgUt3EACxbcxXxFontz55hmeAYJ2hbBk5Tdy5+6mhCLHEG3l
         BZjaK9j/uFK3Dj1oiqos7H2wMbv+N7OfImTBpsnyRHRiIX7WUvNK7+RiWrHUo6EtRSPx
         zerA==
X-Forwarded-Encrypted: i=1; AL+hErGj9q+zJ7SHv02xlAUqAfdpUZGnbcFM+n6tgLNIJmll45mry29shhitAFCmKdCkR+qWt0ZgwTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tDErmpmGEQB6CXMxvKw2d5NBNm4FokGQQkLGgMxEuDqfKDmGw
	4INqgk3EO+EID3v2dhnXj+FbGJvgGsXwnIy4tev7b+BIWUIo3EwSD5bci9sko6bu8g==
X-Gm-Gg: AYBFou3ePy98ydcQrRIdqc+nZgW3ZAmNbqNFIPOcj4ZCM6M9VijK4XtwgliO8seHl+a
	x4KdX/EG9o14u18WOgN+sgao1prnNxVd4tud1gEqpT7qsak5BRN3b6SkbPMl4ux9WCJiCZ+YgA/
	1DCOv/4qebBv8HVMJ36bSXvv65hCdnoz9fybS+N2Mt7eTxux+G9gdxWfbRlA0EQL3RKCNohFi+/
	rEBxOumBaoIrE7A30tE4Uviw9JW01Z0mtkKih/If7/n0WFhZxz13xPw+P8x+/D7vr2wzu9qt84P
	gujHsJGXgCyRsmTfqTogPd2WvRQaH+nq6sYyTbAfsurFl7Mcp/GA1HMV7rYLBFEKU6xqeszy4WZ
	g17TpTVnVeeUpcGIA6W4/5sDxjNdVFzLZqzpnQfcbXfLRjR9lB98+pYalqB6kDwCcMFShC6x9zC
	bCs7d7E4OpWIlCeCzi4ueq4Tn+br8BlhCI2Yfx5lX9mlE50lBXAtrxjxWlhruvFTi1/BerPS6oR
	GfP/zeki88NmWMJiz/0iEK+2oEiMX8Em4at+jizEy4KmvIgjx3o/3J0BMEvmt5GJHPDZLkx24yf
	7MoxXFoHDatESgaE9hBAu/39xXO5Gd2rX9y4XEFW
X-Received: by 2002:a05:600c:4e87:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4b963c8e6e7mr40922425e9.22.1794176141294;
        Sun, 08 Nov 2026 14:15:41 -0800 (PST)
Received: from mbp2019.tail53dac2.ts.net ([2a00:23cc:b5dc:701:a5b4:75a8:ede:9f7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7bb101537sm76735525e9.0.2026.11.08.14.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:15:40 -0800 (PST)
From: James Skillen <jahs@jahs.net>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the MacBookPro16,1
Date: Sun,  8 Nov 2026 22:15:38 +0000
Message-ID: <20261108221538.32132-1-jahs@jahs.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
References: <20261024162109.307247-1-dev@deq.rocks> <20261102232450.61301-1-jahs@jahs.net> <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
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

Hi Alex,

On Tue, 3 Nov 2026 09:35:29 -0500, Alex Deucher wrote:
> Can you try this patch instead:
> https://patchwork.freedesktop.org/patch/765668/?series=174386&rev=2

Many thanks for following this up, and for checking with the Windows
team.

I tested v5 ("drm/amd/pm: defer UCLK DPM on selected Apple Navi
GPUs") on the same MacBookPro16,1 (Pro 5300M, 1002:7340 rev 0x43,
106b:0210, VBIOS 113-D32207P1-019). Kernel 7.3.3 plus the t2linux
patches, v5 applied unmodified. Its navi10_ppt.c differs from
amd-staging-drm-next 178d00b only in the error returns of
navi10_force_clk_levels ("return 0" vs "return ret"); none of these
tests took an error path there. Panel on the Radeon, dcdebugmask=0x1
as before, and SMU messages logged with
amdgpu.dyndbg="file smu_cmn.c +p".

v5 works as described: UCLK is left out of the allowed mask at init
(SetAllowedFeaturesMaskLow 0xa7dfbfb3, stock 0xa7dfbfbb) and enabled
with EnableSmuFeaturesLow(0x8) about 1.2 s after DC init. It boots
cleanly, as stock does on this board. It does not change the UCLK
levels, and the hang is in level 2:

                     UCLK levels       UCLK level 2 pinned at idle,
                     (MHz)             ~5 min after boot
  stock 7.3.3        95/496/736/750    SMU no response after 3.4 s,
                                       GPU reset fails, machine hangs
  v5                 95/496/736/750    SMU no response after 3.5 s,
                                       same
  v5 + trained       95/496/598/736    ok, also under load (below)
  levels

"Machine hangs": a heartbeat sent over the network every 5 s stopped
within ~10 s of the failed GPU reset in both runs, so it was the whole
machine, not only the display.

v5, SMU messages around the pin:

  [311.750451] smu send message: SetSoftMaxByFreq(27), resp: 0x00000001
               in params:000202e0
  [311.750635] smu send message: SetSoftMinByFreq(26), resp: 0x00000001
               in params:000202e0
  [315.231058] SMU: No response msg_reg: 12 resp_reg: 0

For the last row the levels came from a pp_table upload with the
umc_info training points, the values Andre's patch sets in the
driver. v5's late enable ran again after the SMU restart. Forced
switches through every level transition at idle, level 2 pinned under
llama.cpp and memtest_vulkan, memtest_vulkan with forced switches
every 3 s, and a load run at DPM auto all passed, with no SMU or ring
errors. So on this board v5 and the corrected levels work together.

The root cause is in the board's VBIOS: its pptable UCLK levels
(736/750 MHz) don't match the umc_info training points (598/736 MHz).
A corrected VBIOS would be the clean fix; failing that, a driver check
that uses umc_info when the two disagree (a no-op on a correct VBIOS)
seems the practical one.

The testing above and this reply were prepared with help from
claude-opus-5-5; I have checked the results and the text.

Kind regards,
James
