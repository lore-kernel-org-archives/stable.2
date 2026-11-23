Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443957;
	b=Vol3iNe6G1xq/cSQuMMnjkT8WjAXM9oc8k5ODQ+jVSLCAY+bC5OmDwROyqBVvixoYr00
	 ml10M3f4OpLcDmHt3su0c7Jf7bdv/S4Ba2LXcr4gHsua/VarngIUon+qdL8jR92STcU8q
	 By18V45t8Pere0H5h2IvT4i7azfOh/zBT3VQQp/7AoltqabwRK05/ROKFWis8RbAw8ImY
	 y6PSSMd04/DfOyGu+pOxgpq1PasKtz8IXxcmvlodD5UfLa4RfMJ2My2VzRj5+QpSh1o4N
	 oCAzvP7FNGNRajrVdVaTPlYp4zQMnBkQhmGgMQb5AohhQ5Eb77KWghii/1QgclNAFpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Cj3zguVu7lWCJCgLfs0Mb2vwVUbkkSnlbqSfbG7RdEA=;
	b=wYEex8xFi7kLUSaz5mHINJ/AwdMCN41ZAfiUlaKT5hobMLbklEew5nswtzBcV6mbciG0
	 UebO0w/OZ1Uyc/Mnxfu6BA6pVR3l6MP6kVfjxiWr05+bc8gwzRUb0B/5b7VmdYz4CRd7T
	 3corYaaVvmtHpLCtGg8rFn/C0Yc19h834fhL+5gNX6pbTS6dvtn17XbwS+BzoNtOtN0Ud
	 5D8DhYHB016HTbhrSaHvMiTxW6NkeLxOHLwbUvshZeA03OItEhxF8uCuOttVf38deuJYn
	 +YwP2UaDbHLYBHLsLYL6skPGIX2wMEDIIS2RIND6k2XAd4L0go0sjvMmb+asWiXtCRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N6nuidiG;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8D606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B8D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N6nuidiG
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c515319dd89so376154566b.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795443955; x=1796048755; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cj3zguVu7lWCJCgLfs0Mb2vwVUbkkSnlbqSfbG7RdEA=;
        b=N6nuidiG+5vQf5rbJG0/ZZfSA2H5qTBRj5x8gfftXQ+FifN68FFoSAnREczQihSB7I
         4mEqGLi6FyO4HCGknJJSPwjJRDTQJ8GaV2bR81cyt8zHv3IpKBWavSMuZ7fMwq9EXvR/
         THT/7p8jzu3qblI/XshVDHBwxvpZwFmLKLUodS+41Jlm1SWbV7aN1/mCpBsKhiSJx4KT
         vfuCrR8nXJU4P0mWCN65wRo4pOgpiL4yZo9JrXTmtQOJxH8HExQyZoeeHRO/q6wla2/5
         okCOZz+c1/7NbQug6TuG9/kNcQw0TqxzyUot8l0W1FCELUJjZWC5VHm4xLwiFMV4/WZo
         QHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443955; x=1796048755;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cj3zguVu7lWCJCgLfs0Mb2vwVUbkkSnlbqSfbG7RdEA=;
        b=NE+ePUFzleNIGvDdmuQmjy9VPNhaVz8sn/ibM22vknCxKJN5zk5/3i4WQQtN5+qwCj
         be6jXNTuYPW98aQyqB8PUvj7ldCYkGbhaaIfwAd5gewl5jLS1NAFel2Kkkfy/MaIAvxa
         6AY2RBnqV3viC7G0jNFYtQreQqG2hclN49BO4lsKkvz4t6/2x/6Al8gZSFvUqZ4UwlJP
         faCCSVQRmqteY7TT7wTL/osc+B5srQCEN1bw4a1sa4SSHAQL7mcEvYodWUUYArIDgRuh
         c+1tjnmPl1gHMOXq+4C+/74dARk6KHSWLJHPGyEBcCzTHa94+kXl8a9rby4M7BY4LxCw
         e8Dw==
X-Forwarded-Encrypted: i=1; AL+hErFKB6GT4JVNzTvYeuo4JOxotNBVlSsl+5/dQ5c1TXI0blFKYznZRTTrCNf68vK3e79rPhb46Pk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/runJw8/33NnP9TBI0+ZfWDYleqerVEKvlHdItwXadRgNqLLOf
	K7sUVb1yyhXVI+2wjzcq8DgXBBDfEz0SWO4DUscIZCJC/AxT3bRw++yvlyn3nySC9tA=
X-Gm-Gg: AZFdTZcpeBkjAORtpGlRD3EkFsLwnM9hTIkxY2W2UNv3yGUpw0qcixjm6tyxuCt7qad
	17HL9mjcPWLyoEzyp/N4wU6hW+4bfnT6yUIOeYfEdQ1M5ycbwn9epIEb+Dq3vqUFJG93Ly3m/HY
	GzgGMe+2GJds7Un3snccaosptBAOp02Tv/gLvdtXIcJmYSQ6H450yX92s6Qgo79c+3iiDBqoeyZ
	tWHVBTAWp3gaFYTBfDKeswEkdpXjl/5ksH1xjgGmcOvo0f7euaC6hwWHFmBeGAUbW77Jiw62Trz
	r9daJCSWfsY8SyvcQufOUkqNr25RT5QCQOZnRPeUasQ64RkB7s5orKEcFLQNjfLK9hMedYIQ//k
	VGgyC++yJd58QwljP6Q32aP4Ht6nHKXtpkt4VmHEXY/TqTGYFTPPNMfnqK+5Io11feR1cYif2IY
	2yoxqUYfRZu0ovYVzYgA8N4wLVwemepEjjFK8ZHiZJO9g/et50H1OMp//koBWCVWbVNBAze/f7+
	4+H1a+zicegyLUqFgoQ6pZpkLREI+m+yR5EjF3iSfHpdw+/df59yNdMlXaSMDZIylGTgpvEOsag
	Zut3hvm7ALNd8t65xBEGiVpttDiQZgvKZNrVoI1QvLyvBEcDrzBtN5cj3uAz1Wx/1BAVJAONBug
	UmdVbgZlJw14bgoA2fQ==
X-Received: by 2002:a17:906:1c11:b0:c50:8d2b:4392 with SMTP id a640c23a62f3a-c513ab38967mr715904966b.49.1795443955446;
        Mon, 23 Nov 2026 06:25:55 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae67cbfsm428224366b.14.2026.11.23.06.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:25:55 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] phy: exynos5-usbdrd: gs101 PIPE3 init fixes
Date: Mon, 23 Nov 2026 14:25:53 +0000
Message-Id: <20261123-gs101-usb-phy-orientation-v2-0-3361fa5f7543@linaro.org>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPFMBGsC/42NQQrCMBBFr1Jm7UgmBqmuvEfpoolJOiBJSWqxl
 N7dsSdw8+F9eP9vUH1hX+HebFD8wpVzEtCnBtw4pOiRn8Kglb4S0Q1jJUX4rhanccUscpqHWSw
 0xrk2kAlKKxB/Kj7w59jueuGR65zLelwt9Gv/WV0ICW24OGMldesfL05DyedcIvT7vn8BPNREj
 sMAAAA=
X-Change-ID: 20261119-gs101-usb-phy-orientation-44cc8f14f020
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 RD Babiera <rdbabiera@google.com>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, phone-devel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Hi,

This series contains two fixes for the USB 3.1 PIPE3 PHY initialization
on Google Tensor gs101:

1. Re-initialize the PIPE3 PHY from the Type-C orientation switch
   callback when the orientation changes while the PHY is already
   initialized. When a cable is connected during boot, the PHY can be
   initialized before the TCPC reports the orientation, and DWC3 runtime
   PM is forbidden by default. Without re-initializing, the SuperSpeed
   lanes stay programmed for the wrong orientation and the link comes up
   in high-speed only.

2. Apply the existing gs101_tunes_pipe3_postlock[] table once the PLL
   and CDR have locked. It disables the high-speed RX squelch detector
   in P3 / U3 to save power while the link is suspended. The table was
   added in commit 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos
   USBDRD 3.1 combo phy (HS & SS)") but never applied.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- Add patch 2 to apply the existing gs101 postlock tuning table
  (PTS_PIPE3_POSTLOCK).
- Patch 1 is unchanged from v1.
- Link to v1: https://lore.kernel.org/r/20261119-gs101-usb-phy-orientation-v1-1-bf3c4bbf328e@linaro.org

---
André Draszik (2):
      phy: exynos5-usbdrd: gs101: re-init PIPE3 on orientation change
      phy: exynos5-usbdrd: apply gs101 postlock tuning

 drivers/phy/samsung/phy-exynos5-usbdrd.c | 63 ++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261119-gs101-usb-phy-orientation-44cc8f14f020

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

