Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162944;
	b=D8vpZQYwE/tn1mU2MEkz7+TF0r0vgLTDqhID+WZgNAvefHNLCRZZugkHRnupIUdufCT8
	 MervqJWGQEYobsn5kF/1eHe+vbPi7Lmp+ExAVy3Ye7pj+doyyr8XkVRwjhoNZah5cdXHZ
	 tb1ECE5ZtSGEy9R08nmXoRzAynLfr31kJFF04U6EE7T23c13yiF9oW47jW+8lp01SBfy6
	 Mi7ho/l8Uu113Wy/X/inHKuHMnfi9JZIssqpjN0DYwS6OQjlNbqaqxANA5wKlssCMKEZv
	 RIeD8+HBXdYEtDMl/MGiM1bkVsYecdYubWrm+rhoP6xoaO+f94cYgWsuEYPM03y9mXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162944;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lAppreIDaRBwp2bJc0C8P4KcAycTbVej2XgNIS+hMVU=;
	b=AKiGmMEtLsbnPEVhwRv9970RXrG9+s4bQ1PDdholMLNFfTDycPs25zN79KgKUkWnvfje
	 7YuItO1qeRiSCuZSo6q2Xjtf7mKbLP51WTAAeGB2lCmC5GRx4k0q41W3bKLytR+Mpbr1Y
	 6RziBqHK5jUaVizQjCXq0p1yNLF5ExzbsgjJuXfXkwtsU7J3feckzorebdG+tgGnRNubc
	 LyKP+TQLIGEa98930cux3Nhle0eEP/6BoUW9tLsBEKvfNcX/FLSB2rAnmTWeUOAOkm4o2
	 gre/J0YltDbm8dPwAKC57B/q/n1oBcqWfjD7KAkK2ysO0EfIVn3SMjs5xSPylLyQ06g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WjKtksBM;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FA606A31F;
	Wed, 28 Oct 2026 04:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 005FA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WjKtksBM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lA
	ppreIDaRBwp2bJc0C8P4KcAycTbVej2XgNIS+hMVU=; b=WjKtksBMImFt1+BQzo
	4Ck2tsm/b7AYROXtZP42ZTKA3mlCVH1sE/EslO0Ge10WpHXLe6obKRkd390jiW5k
	HwF2A7u/AoJ5x8jj2YOKlRjEsHZfAoGiz5hLwLyLA6yiq1iAjLKjTr8zVZVVM7Ef
	Udbn4J0rfv/v2aHjanF5+Jva8=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S4;
	Wed, 28 Oct 2026 12:48:33 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/6] bus: fsl-mc: initialize UAPI state before device registration
Date: Wed, 28 Oct 2026 12:48:22 +0800
Message-Id: <20261028044828.96177-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028044828.96177-1-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy3trW7GFykGF4UGr1rJFb_yoW8JFyUpF
	srX348Cryjvw47Jr4DXF4Uua15Wa4xXayUAFyIka4rCa15CrZ0vF1UG34Y9F18JrWru3WY
	vF4Dur15W34vyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3UUUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AHaFWrhfqETDgAA33

misc_register() exposes the fsl-mc UAPI device before its mutex and
static portal pointer are initialized. A userspace open racing device
creation can consequently lock an uninitialized mutex or observe
incomplete state.

Initialize the UAPI state before registering the misc device.

Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/bus/fsl-mc/fsl-mc-uapi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
index aaa14f17aef4..2c586dd787f3 100644
--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -586,15 +586,13 @@ int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus)
 	mc_uapi->misc.minor = MISC_DYNAMIC_MINOR;
 	mc_uapi->misc.name = dev_name(&mc_dev->dev);
 	mc_uapi->misc.fops = &fsl_mc_uapi_dev_fops;
+	mc_uapi->static_mc_io = mc_bus->mc_dev.mc_io;
+	mutex_init(&mc_uapi->mutex);
 
 	error = misc_register(&mc_uapi->misc);
 	if (error)
 		return error;
 
-	mc_uapi->static_mc_io = mc_bus->mc_dev.mc_io;
-
-	mutex_init(&mc_uapi->mutex);
-
 	return 0;
 }
 
-- 
2.34.1

