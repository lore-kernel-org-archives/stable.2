Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198230;
	b=q/IroS2vpINhpnCx3d5U/e3n3GYgeVWNrvLEjLddnoKjcFLkADsIMkz1BQvH/eB0DH5R
	 eAgavpOGtvr0RXYvwT1Qz7/cdXis45WKY+afL2RrjYHFoscjQmjU214/LmeLkEvH2yC8V
	 niEv6cmCaIJMfuOP+NkQuOqZqXW6g1qhQAXauFVPLJspbCtQrr2ZiWL+I44e/2RLlGG9S
	 /1n+xvWLM7GEH5NSI1nJSjovK4cm5PzNAlGD7fs40+R92Ulai5/IuyZFdE/i9b5J9NaIf
	 O2qGUyaZdRxata0Nx8bqPu+qkIoJHXwHghDVx/IHNADeo8dQSxtVz/7f/Zcx0WApraA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=1U0puyPddAK/k0CBoSD8bUy1ngE3FQLTiHGb9GIY5PM=;
	b=1H8yhH2LcnAlDcSYMMr5X7Nf1Jl6o+vOYQn8tzJrvnJH4vo0I8qRIK6snFRLGHt2ZjkX
	 8WQ4c0MQwdOxd1wmZPXGCa3K/bujHv7wp2n+FLVyx6pp70gO1uOGwtsTvRpXEvPHTxUKN
	 1f7A2liJbr9PTON/q8qlLicZggOjJz6+TdKey+Gl3xFODvL8zhTTa/RG8Vwb7+t+1RPWW
	 SGZRks5tzCYjjkomok+xhFWlql4T2xPKtgNIr9oaHBIxF+Pwk3r89dCYQT0vsY6dhqS1A
	 wpkGyLKPy9oGEd6vUSUXFFm3JAGCowaLiVbWq7rDR8i1s9lA9UJpoAqP6NsdbG9sU4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgTUh3EU;
	arc=none smtp.remote-ip=209.85.167.196
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9060A3819
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB9060A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgTUh3EU
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-4b28d9537bcso780665b6e.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198224; x=1795803024; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1U0puyPddAK/k0CBoSD8bUy1ngE3FQLTiHGb9GIY5PM=;
        b=VgTUh3EUycmSbgOjP7Z0o8iKhKfaz/s16qBa2dIHG+6WIx00GZ7LlTEaQ0jHpVVmNi
         xNMv5Z+G410uoEoP4Sd2c1vBLgFGdX6q4vUWQGyIc5qLNe0c9RBtNtlcZPYVqwT5wngD
         NGm1zb38bpHlBGss6pFmB6LPxTg207bS6cbkL+oR68GGuMIhm46aSlWTlB6smlLBsJXY
         iUlOioaWJoxWh8d1x5DSI5tCsBbH/b3njKIY0bisxGMV+c0bsDGIROlQjIq5OJk394J9
         JwT8C95sYrnpmMnuhVtZQRVoDlACjp2zARu0qyY4unz8yQUVKwYNnjnYOskNbLxe+el2
         mOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198224; x=1795803024;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1U0puyPddAK/k0CBoSD8bUy1ngE3FQLTiHGb9GIY5PM=;
        b=mQYbD6lvoihsFVmp69n8cGfCZpyLHCacZExinzg2wvGt4bQC8UAsLiIEbbosI5EzXY
         32hbRANIBcl4zypTqCNU4GV5t/OJzRyl54TFBnctCDH2/220OROhpFM9o3rzRN0Di14e
         4RMsvnyNwr6Hm494am7XqLdxIjWVnClp/6y+YPFI3cD23bhNCknw145iKr/DvE8JRbpn
         802SK6ftM2n/M0e6kkkI61p4Lb8gARfgckKL27zAF/MhUSELWezojzvnMVh/EW46MtyC
         bT3F+O9qqvGpIVsgDdu+FfheQ0F3Lu59WRsoCUXiNxaXOyHNiT0nRRK8EY4WiHMMYkZd
         C1vg==
X-Forwarded-Encrypted: i=1; AL+hErEp0oL+eNq9laRNLHqUNKQEg/Yw1ZRTF0CStAHvUFpLQ2c7FSvhBftrlujgXCbohExSq8Zh4Fg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NmB8s46zISCF6UQq4/fPAouz5FpS3zHblTn/A3kIys46no8Dk
	Fb7ebEqFrDhfHCLdqe+PvYSpJOmVNKOBwLSiTcNBgjMt6a1kgCAj/qQa
X-Gm-Gg: AYBFou0rl9tzMJNpGIHnalOHvAfyvnzZXjGaaBuKzJC2Fmp3mENE/m+N8oqJNVFdQwa
	/ppaHd/HUmKJvS7RmQSIPdNV9StkJrPdIC+w5hPMu2hVEdDMoFc+MLG0/3Pmbg98J6rzn4AUxsm
	aC090FpQ8QoV/EAKse/Z2H/SPnf7B3unnThQy4qSTA0nriNhhVifpSmRXPxTGBhqziWZjSWxHTt
	es90LigJJeweXy/KqC3MoTwFWKbPSzdB/aHqDq5cSAN8k4VetRP18EG/LDgc1nDMqmGkIk5IfdQ
	J8Dzm7mFe5hj9325oLyrE+HzIrdtbDCmnC+6aYp97uh/NatFLZ1FOhdwVFXj2vjoMpq/m63oive
	x6jKmLnAZYdQCwcRPTtU5tQ2X7b7Ko4jkZDBBC3T1dJSWN7bIs1l21sIcXjICSHsI68owH8bFh2
	TxQnXeWxLOPart9Utg+OgL3hVPH1Kjvm9tPmZMm7IQTLcgyQSOwaJAx1qjW2lDaIA1V9hsqMHPO
	hRmrSFxfieBuWNQ+ltLnj0biHcPJLTFsY+cfm1yJCibdtGgqFXPVaet/vcnIFrt0JXggYnkvIVR
	OratkU63lkFtTNAUHOdYlNsSHn7+VdCOh5XbC3VkqzMlcZRehxNUjIRNVUVnR11VdPene0gvdnf
	heavJ5NJVB7ed4Vi7QRTU8WApoGb3h8RUOENvvTl0
X-Received: by 2002:a05:6808:e85:b0:4dd:f8bb:e1bd with SMTP id 5614622812f47-5797bb9f526mr4100230b6e.13.1795198223670;
        Fri, 20 Nov 2026 10:10:23 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc6108104esm3310383fac.14.2026.11.20.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:10:23 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Fri, 20 Nov 2026 12:10:21 -0600
Subject: [PATCH v2] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
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
Message-Id: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/5XNQQ6CMBBA0as0s2aMRUVg5T0Mi2kZoAnQZgqNS
 ri7kRu4/Yv/NogsjiPUagPh5KLzM9QqzxTYgeae0bVQK8jPeaG1LlGMrIxx5Q+GJGj9FNaF0Se
 WkQJ2I/V4KaqbZTIVmQIyBUG4c69DeTaZgsHFxcv7QJP+1f/+SaNG4tJcS9L3tjOPfiI3nqyfo
 Nn3/Qt2kCcm1gAAAA==
X-Change-ID: 20261118-rbrue-suez-pvr-compute-overlap-flag-3695ceab9ab6
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795198222; l=2520;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=hzVweLQWGGnWgZbDJhzZq3hPf28CyuB7MpyqTw8FFOg=;
 b=0o+bvH90wEF2XntpIVzQMXCFEt6HJ+4fJF6Ul3mujWKykchEVKx1X1zs7uHyExO8r+821BE2Z
 RFvPMyQygIKBfuQBY6OLYOPkMuwCJmkXWEPYn76OFTtv4nUtE7S/NLq
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The firmware takes "prevent all overlap" from bit 1 of a compute
command's flags; bit 2 is FORCE_TPU_CLK. The kernel has used bit 2 since
the FWIF headers were added, so the firmware has never seen
DRM_PVR_SUBMIT_JOB_COMPUTE_CMD_PREVENT_ALL_OVERLAP.

On a GX6250 (MT8173), a compute job overlapping fragment work from
another context hangs both data masters. With every compute job
submitted with bit 1 set, a test that hit the hang on every run no longer
does; with bit 2 set instead it still hangs.

Fixes: a26f067feac1 ("drm/imagination: Add FWIF headers")
Cc: stable@vger.kernel.org
Reviewed-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Found while chasing GPU hangs on an MT8173 tablet (GX6250, BVNC
4.40.2.51) under Mesa's PowerVR Vulkan driver: a compute job running
next to fragment work from another context hangs the GPU, and Mesa's
request to serialise compute never reached the firmware.

The value comes from Imagination's firmware interface as carried in
Mesa (src/imagination/vulkan/winsys/pvrsrvkm/fw-api/pvr_rogue_fwif.h:
PREVENT_ALL_OVERLAP 0x2, FORCE_TPU_CLK 0x4), and the board confirms it:
forcing bit 1 into every compute command stops the hangs, forcing bit 2
does not. The other compute, fragment and transfer flag values in
pvr_rogue_fwif_client.h match that header.

This patch was developed with the help of an LLM.
---
Changes in v2:
- Add r-b, and Cc stable (Brajesh)
- Link to v1: https://lore.kernel.org/r/20261118-rbrue-suez-pvr-compute-overlap-flag-v1-1-ae8b48a17dfb@gmail.com
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h
index 6e224400083a..967e903bdca6 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h
@@ -74,7 +74,7 @@
  * Flags supported by the compute DM command i.e. &struct rogue_fwif_cmd_compute.
  */
 
-#define ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP BIT_MASK(2)
+#define ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP BIT_MASK(1)
 /*!< Use single core in a multi core setup. */
 #define ROGUE_COMPUTE_FLAG_SINGLE_CORE BIT_MASK(5)
 

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-rbrue-suez-pvr-compute-overlap-flag-3695ceab9ab6

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

