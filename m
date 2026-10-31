Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442111;
	b=W96qXkriOk3UupbAkjaLMP6HCFlFIxzGkvXPnu0sU7p7aGvvbPXP4JHzZAf2Vz23Plwa
	 VUSY+RkRDe6iEbj/SFF/c9qxpWdVluD7/0J9IbMEIDhqoJvkqLFzPPeEHe1d7U5rS5TeN
	 3DvUSMCC51xlY31HMWi1eqIh0wIc9DakK1sEns3l5SnQE2J/DwLMfjFzjvx1pSaWQ4Xog
	 Q2MIu5KYZvfpcFPDg97wq4wEBTKS2gzbTRZkMKVPJLTAN74bkAjCBFbopDoiLzFdlT91O
	 ZiygXb7n/rD7bCbiUwd5PHnhfvGN4D2N3x02bkB1Xiiw11KeEf47uaof6EDntUgmxvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H2n5rvEmZawleJvXW2iwJ/2FM80C7pwmFa2gEkkaLOQ=;
	b=NwmzYP/AJUKag+wNuHrSZurg6txIk6zI1wGDxD+InWA8h2hhtseTQRkjR8BlqOFg/mwV
	 evlOlDEFOwyAcXBRiagy008i/x/jkbmiGLV5tpU2Ewp8topkfjFQouMlSqd9hBUoF8OkB
	 xf45RKttLDpr3fHZHSDjRvJeK3/2CEHu8AAMKPO0uYLTdg6B59mDiV1Ifw2zvvChOYbIR
	 xeKHnwdbVo1n7hesTi3O1LrSIa5mWvZrHYbcURjSpdflpDVOt9G9HfbUa83naC5rWeMdH
	 +JM7NVFED+e/1B1oeoV9Ktj5fIAhh1NfipPSXTle8yzHxfclMUiZROwDU6qTZFJCwjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHCOAozE;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFD606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 10:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEFFD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHCOAozE
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so13957995e9.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442109; x=1794046909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2n5rvEmZawleJvXW2iwJ/2FM80C7pwmFa2gEkkaLOQ=;
        b=aHCOAozEayO/tn/0TW0arhTa5D7UGVboOJkhGa0sRb3GIpYYiHFVGlKSaWSg+LkZRG
         whKqQ+BmwPd0Rz86HU6PuFwNvPDFBcIU/c7aVNVmokCaDm00RZokt6NNSyJz/12Qi04U
         08r7r3yZs+gsu8z0/AOOy1vO2ViZXsrbw54hHCKBtjBeka+XAeYTJ49NYM0CU2maykdJ
         Kexc+WL0XAVfVKtuB+5NB17l1gD191egPnSa1AHzCwU38IOJCMtoSu7Ywp1EkgfJXeHW
         iecdqubAs/ghMtah/Z7BffR5N6ZK1XHTlou19m+xDzqg8ZTCkCd2anWqycIGhQqHq73M
         edXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442109; x=1794046909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2n5rvEmZawleJvXW2iwJ/2FM80C7pwmFa2gEkkaLOQ=;
        b=pephk4+If+HC6y+zVRQPWYOKLgyCZBO/73lbniDZ3jeGtiYu5Ci13ZkPC7OmZhhc6O
         5/gThcRKz/qOiUMPx0MkhXfLwYkq34gFZmIWH+UCAZCbCDZL7hfokAyJ8h/bN9tYNBnc
         IiEopV958eZ618bt61LXJl7rATqWfidQY5kZt0EISXCly/a/siMdNWpqQTyIQWtXJ5f4
         yYZ23t6P2Ldp7Et+WzMOO5YHnHYPUM0cmB9ol1mGnNJnfiHAaH95Y2KfuLIR2SZkpILp
         wO/ZvcF5+boxmrQ0QRssqyh3HhbvhFWmkjT77y1WidCkekVoa4uJqPuHicNCrH4YBPpV
         YilA==
X-Forwarded-Encrypted: i=1; AKwUvBzQ8e/3d3s8U9/bbdqEk+DL3Bdcxeeq9qFIKMCi2ZheWUKHxp0BaI3KMvdFbO2SmIFTCKF90Ms=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe8HJ5qVGGGK4zUm6y1JnJw4PbQt9Fnbe/Gcm8vGv9xcPUhK6t
	+ZcEHfxC2h2Vw0M/Op5nvJPilmLCfvh8aWCOnceshEih6HG0xWzc3w9d
X-Gm-Gg: AYBFou1SBxHYyKoMTIyyuo/KHPSKlb6CXHdTxvbH2V01cfSeIPQA88nyUFP5KMtdCRJ
	GnNANkFNhigUaOtaMy7Bsi/FYiQxCABMltVzriGMufScjHjnmgmJl11RKkEpekSbsZUlmySWpjp
	dMl5J3cqEcLY1ziZ0ij+aorQice6ioBrzNdhlkDjI9wxiTVDrWL/B1fb/SkArMC+uQRGYUdaC8A
	tk+4A1dWUIa3hZeR4JtTEJGGyi/75DYt/JvyB9+oM7Ipd0vvSZYah0kkmiOzNOb/WxzxkuLFNUI
	gRot6j+iEs7miYrWs3TiuZGgZLhXwdCSDSJWBnnuY05NASg9/rooprigKoEbT+evwGLxI/kQ+gG
	k2kGKBVnYbSYgZrumI4igjzmhbJ39FfZXctRnTyU3Hf2jwLEwpwxu2eKwIE70Kxf0uo3nJdTm9c
	MXqe3frbnhHLX/XPb8eLN2UTPfZPcXU7St4BQuRdYEB6DAqQlh5y1GBMm8Dhr+gM0H4krlb9JBy
	5a5hS9F8DecovBumYga2xTG33vSYSxE4VmmzEzFj4Z8W10GpU3vR4AzSCGz8qoE+repKziwQn/v
	6t5IC//inkETvih1anvuXwpH4cupCKBVXkEtmvHfWOTImUFrbGfPcrol2bYGET6Ygpw=
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4ac1913ef8fmr107844405e9.27.1793442109074;
        Sat, 31 Oct 2026 03:21:49 -0700 (PDT)
Received: from OmniBook3.station ([2a02:b023:13:69f1:e78:b69f:1c29:ec5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abea72254csm65226785e9.1.2026.10.31.03.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:21:48 -0700 (PDT)
From: Gianluca Balboni <gianluca.balboni06@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gianluca Balboni <gianluca.balboni06@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx
Date: Sat, 31 Oct 2026 11:21:36 +0100
Message-ID: <20261031102136.24600-1-gianluca.balboni06@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP OmniBook 3 Laptop 16-by0xxx (board ID 8EE3) has an internal DMIC
connected to the AMD ACP6x audio coprocessor. The BIOS does not set the
AcpDmicConnected _DSD property or the _WOV method, and the board is missing
from yc_acp_quirk_table[], so acp6x_probe() returns -ENODEV and no DMIC
capture device is registered.

Add a DMI quirk entry for this model to enable ACP DMIC support.

Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Balboni <gianluca.balboni06@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a7fa0e8c460d..7a629b35e076 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -762,6 +762,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EE3"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
 			DMI_MATCH(DMI_BOARD_NAME, "8EE4"),
 		}
-- 
2.56.0
