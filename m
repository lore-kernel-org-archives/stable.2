Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701980;
	b=w/V4H8DXtDf41+oVyKW67UyQA5hqfwBQFvjhlGWWquo96qLDjAUluBHbwZd9fXhJR5/c
	 UItYAa8vZQiOyeYouUwJLb08dtPLEIshmfU31R3+QAoI8blSnmNLICFeQRtduJ8AZxpmx
	 LAm8UQ3b7uy7TKF/s8YNYzgsn9atA/IknEFcRo2ciQreLOrnD7J96lPadc3WiWNagF297
	 5YWgZtnRFoPTfInGrWNl8owo/9gRT+ch2P6+QBfcPWcJkreEIK6SAarqtWXhFY1ifBsdT
	 CKfPYFFFixDMXl4OG34vtihEuxmsdn382Q0BuNpYb4DlcX3rCOw2rC1qezASA68mbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=z6yDRTcU4R01ur/fecdkMQS1c66OkwJs8if54klUoSA=;
	b=fZTyN9x5f8X6Y1R24M0ns14UuevsQKBtLkOftTgdLPepGFFRYZtuNT+eGuwDo2BvmYTC
	 3V9hYcEAPh8KOL7Ajgp2QuDgIlH88L3jzBuvubtYvt7jkXYjBv5d8eMFKk+5XxAs3RX+o
	 AIg6JfVJftw9i1qJQW926uGATvA8Vut+jrVGbG006HsAEQPesu6C/Jj7D8NRwAMnSkW6o
	 isW3BM/RLfwE9xQ0Me2cS5tFSGxJrpExg/n0/hj8oZYvy3Q4ocnlb0TnlTe2yitgZNl8U
	 H/GOOGLN1xHDknolKuIURxRcmcGhre3aUlhaBqzpAg88G08kps3yxjOA5JIyGkDLVEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=eYRlpmqy;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F40606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F40606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=eYRlpmqy
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D0B113F750
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795701971;
	bh=z6yDRTcU4R01ur/fecdkMQS1c66OkwJs8if54klUoSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=eYRlpmqyFdkfgRN1H20kNSqt4kLbXbp+n2xAz/f/dR+6pBDoe1UY0QwUc9EBXFaeE
	 log8CucK7AoHw1d0HPtCUO4flMPMNRiBIbOF2xiL2+GFoCEXQdt/n9/XLo3pHvqjBD
	 zi//xTS/I32yiqRGd0k7kiYBYK16E+1PGKgTJBOakLa4mnODmnxcQ+9j+uVSnCUTzu
	 8UGye3q8GyFS6amxQY79hKtPMhKhnxechG03p6d+Jj/fxLiUze0R+C1YpZkECLcns5
	 EfhEQ3QFgW+GCOkRkoBmNFF901k8ZQ785ArGzVcl3lN58OAfSv+OT7Sk5ZdAtyFSbD
	 D/gSdnedIe49FoWMRI0rFaGe7L5ljOI1m1A24g7FaFdgP3UQwV/vPCOyDlqcnhr+z4
	 O5Ovmux46kgAXKKdigvO5ejM1UovtYZxZHYBJJTzv4XAXr2rUn0WMQqdT1ttg/OM5X
	 YZiUx+WE2qlgBC2X4Ak9un6XG7O/xFrU8Wn4ZI0G9m0ZoSoFVDqs2FNlahn4RPlTEE
	 aNozElS0vciMwFu3TrWiMwt7Op6Gj5UiaS7AgTI/tfiN3Jja4kSK5DjU5C66JSrO0o
	 gTXfjeg++wTu4bbh1DKUAXGAf2pU4KBcsIdPP5vNy6geDGYgpBAYl4bqJ9ELJ7yIaC
	 vHA1/OslLE8eqviEI0AJ6ILc=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b3f3e256e8so6744085a91.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701970; x=1796306770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6yDRTcU4R01ur/fecdkMQS1c66OkwJs8if54klUoSA=;
        b=sC58F/ddk5HZQLKdgFk90m/ZWrZOF8w2zwGf1cvmoTnWLXYyhvvV9fn9+BUMK5afTe
         9eT8PEHL3BndLwYqUBSGge2zdIEuueoj+ScK2uil2HCc49BxZkBQSABHqnFG+tH2FsEI
         l1znW2eBEZJArmM4OAKnEmrzR1MPJtpDjLgcZf7NZGm2ugCt0ch1CuxKLuXN2rmiFG6p
         CDiJqlU1d3Kfc6fZqbNLzRFKJGpjAiA/LWvCaYO2wcPsrklq7zHKT2ZQMIQm26JVcSg6
         oVyoaRxQnGtDPYKZSyIM50ZSl/zRPEDGQKjdLszBwvTYuNOhs+aBeQkMkmRIHPsDwf6/
         J6/A==
X-Forwarded-Encrypted: i=1; AL+hErEF0+kMhc0qCB9V4L3S+rfFRiNBI+UFd2SwSVQzhey23b3KCiKVK1e8mAJBfopL4fPF9RHCSr8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ksZbFKCVmDXl0xtOuMgGx95uhNeytXonMG5PtFZZHGY1ZIDlJ
	rtKnOQ6kIEVWvC4CPW5m93L2yZ7PoQrar0W3hxdEkWSLniTiSSITU8iz90zCp67IztepdQ7I+WO
	f+BVETevUHiey8ZbAoAWawkH5YkSnty8CmZf1uwTp69ilswUVyAXNN15lwClRsSwDVrxgVWdDLw
	==
X-Gm-Gg: AZFdTZfbBulzm5w1npY0g5blWMeiHI14k5UL0SUwljf8OluuVoxRTddScxZwc9c7pvX
	NVIvamuiaXe5fTcQWWNuHewLR9jSZKfyc0L6j7FjtbcgyI3KB92fveGiUlT1jDrZcKjqi0CfFre
	hdG7WeDNezaO2/+FhKPMuYEMnpF9xY3ZDFabb8gQPpGkuLLWJ0Z8mGr5Y5yri6CwFS3xSfXFfSZ
	GhoCGSNQLjgxtdKB7bhdrBc/HGVhijlmJLXpe4E9yWyQCTPCDhPMl2ieVy1R/k08V/QwLzKEUrd
	qMrL9pROOTRjxf8LxyYXBbGvnbNC1JfR3JSDXtbFo+zt8Rpotk9p3qzPxOQ3josZSAQvYYmKj6C
	1VkgY7+6bvyzMK3BsIbwL/oEXfqtO7uSlGiUqLpMkE8TOyKAw3ICSK0cB
X-Received: by 2002:a17:90b:554d:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b41c9b361fmr20365717a91.65.1795701970088;
        Thu, 26 Nov 2026 06:06:10 -0800 (PST)
X-Received: by 2002:a17:90b:554d:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b41c9b361fmr20365663a91.65.1795701969667;
        Thu, 26 Nov 2026 06:06:09 -0800 (PST)
Received: from localhost ([2001:8003:ec27:e900:9eb2:9fad:60b1:766e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm11022054a12.8.2026.11.26.06.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:06:09 -0800 (PST)
From: Yufeng Gao <yufeng.gao@canonical.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yufeng Gao <yufeng.gao@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH] phy: microchip: build both SerDes drivers when they share a config value
Date: Fri, 27 Nov 2026 00:05:21 +1000
Message-ID: <20261126140521.237240-1-yufeng.gao@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The Makefile adds the two drivers with ":=" instead of "+=":

  obj-$(CONFIG_PHY_SPARX5_SERDES) := sparx5_serdes.o
  obj-$(CONFIG_PHY_LAN966X_SERDES) := lan966x_serdes.o

When PHY_SPARX5_SERDES and PHY_LAN966X_SERDES are both 'y' or 'm',
both lines assign the same variable and the second replaces the first:

  obj-y := sparx5_serdes.o
  obj-y := lan966x_serdes.o

In this case, sparx5_serdes is silently not built despite enabled. To
fix this, use "+=" (for both drivers).

Fixes: 305524902a00 ("phy: Add lan966x ethernet serdes PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yufeng Gao <yufeng.gao@canonical.com>
---
 drivers/phy/microchip/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/microchip/Makefile b/drivers/phy/microchip/Makefile
index fd73b87960a5..0ea4004abf75 100644
--- a/drivers/phy/microchip/Makefile
+++ b/drivers/phy/microchip/Makefile
@@ -3,5 +3,5 @@
 # Makefile for the Microchip phy drivers.
 #
 
-obj-$(CONFIG_PHY_SPARX5_SERDES) := sparx5_serdes.o
-obj-$(CONFIG_PHY_LAN966X_SERDES) := lan966x_serdes.o
+obj-$(CONFIG_PHY_SPARX5_SERDES) += sparx5_serdes.o
+obj-$(CONFIG_PHY_LAN966X_SERDES) += lan966x_serdes.o

base-commit: e7d2f93a4426ea6b33dbca1ce585a9876e3a7344
-- 
2.53.0

