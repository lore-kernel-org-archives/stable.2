Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754852;
	b=P5DTAUpCkDqZYw395Pz7v/IhkCjLbUM09sJEvep3ZUns6wCcfAgX9DIPZ9KsFBqGc/9V
	 fSOc6SFk3GrWjIKG2ROiAOHDGLJwk3XDePnARAYzd+NLasKjLMn8+tdMLN8ZE7SFPuNB0
	 ZLTTyF3TPWwR+Y0jBsq6BtD+4uh2uoBpSTfkonQQDp2poZV+HrvRLQ7Z3iV0pOY/1x01Q
	 PYLsaS5Ra/WE5bFiDEZTgQGtoMIznSpmaAa7aTjOhC13mImXtreVoPUR2Mr33sADlfy/K
	 Rxl01KrcmgcpzT994Ruy3/GGDXdI9AuT+QK+tmoLOQlTNY2Zr2YByIdaS7J/lXKYyDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rXyJvAkypDoHjlaEtA65cirM0oXb7Dh89hlzN8jZ+Vs=;
	b=YdSSNf00ws+npFvDUXpQ9FOltpXqJwfsoBf1PHCFmFk+VH1FJB7QzrXMQJd41B6rJTcX
	 ZGgnKsTG+QRbPx2NxdcGtFkeeLEuV3x/XyaoDnE8F5bx/FMbOWoms6LKJcaaxCEj1pC3r
	 q15aBHIKEv5irFEQTVqSQbU5ukcsS+WvKNs6P2iHXxBLjXq3K/oN8NuNvcIarvajvsw03
	 sZ8ArEgBDn1v5pCSTWaq+kqDSby8L7+vl3/fAfywWheSJGbdOwpKUMuWAoE1h/s4hzK99
	 +RoFtdzXzhCsW9xK4wQfjKR6YTsbTRSS8vvU3WlExmM8qt4M4JrZALVWJp2YH8FjdzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ol94ZQlx;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F2606A33C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C5F2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ol94ZQlx
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-380c28f9e35so8586557eec.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795754851; x=1796359651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXyJvAkypDoHjlaEtA65cirM0oXb7Dh89hlzN8jZ+Vs=;
        b=Ol94ZQlxOoTaBFfHL0ERXTVVQTimop0+0lnXX1HmTO0ROCsV69CcS/y2RK4v9juJ0r
         d+y3QpFVJ4IHlP11MNIXe2MhH0HJuWzO8X/JcMjXF7AB7Kxfs9Q3+NvuToBHmPCtWzE+
         /ypA1pzmTot/+RNUhaGiO5aPhQ3Zf3TWhaFi5AWJVdvQGGyo48HiAybttIZFQFWwuiij
         TxIw8pcxRtxo/JRnHR3GtYYedeZ6XD8EPvDESt/+OpT6p4tjhLwAXBY/xY4qKuIc9+9m
         9X3Kdr7cBG0YWpoDfJ01tzg2MvJAFhW5iNOFN0bE5Jr30cr3/ilPCNdwroK8n8PT0N+i
         77lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795754851; x=1796359651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rXyJvAkypDoHjlaEtA65cirM0oXb7Dh89hlzN8jZ+Vs=;
        b=SFTiAxkPcqsqzCy7hp8zWFtwA7fkGSGNHnMO6+qRWvb2WGweqkY8XMwP1bUZLgpQ9d
         maT6s+UBPNWqu3DsyPvsypJCMixM11W6GwFA0FtpU7DU1OHLyjpoxQ/1YFFxgts5PamU
         Svkm2lptgkA6WfbBoQAiWtNjWy3uGyDgT52AHr4vTm5Sm5Gg6SKs8tF1mzwAwpRYHLCD
         ifkmncdO9A7h6CEEtS16vAFGkIsaMizP17F/YaqL9h/Mk6LtcZslN8Ks9o4kfL3mV9rl
         y6OVjvM0UcIOmHvHJy582OpjWkA+JIahrhzBCZFun0qD6bRwlfOfIwDpKjhwkjZa8t4I
         ocJA==
X-Forwarded-Encrypted: i=1; AL+hErEx1dmLqNOeqGMnNQL9DjiLjeYb2DxV1whLFmK8cSl3f3lou8Y33+4HqtM2tqp/08vssm35JAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gLmRaQQPF2Q4WaQNI7DMlLTA7Exh7J6a8SSqLdGM3NG66Evay
	6yXk4gHvpXbLyGgz7e8Ff57cr8bkSMgmXDF04F44g5HgHikIPArhUw7c
X-Gm-Gg: AZFdTZej2T3WdnX3nM2xWecG7B1Tqg3X7CAkKBqYhxa+GUvltduawp0nG8VZJ9H4BDS
	Fbcr3PGf/f4J+MnQxphd9TF/9c/S78vbzsipHeMuHavgDs6LSeHa60/KHNJHN4yOawR+ORpKX6p
	GpQiSg16XiAVVTIUIE53gWILjH/27J7dG5PVSTlrLNv2yCb/KYLVda5f1DceWJqgtTflQ/9Q2vp
	d3NXJVwHivIOMNtcV3ABzmh8e8YFemA4TZ7NT1gaa56HkX0im894qlZZogLhniOsX559pV0vhNN
	D/L0WZPUk1AqzKjPXq96RSRobl/FIxsTD5sJWG3cmlrP1CCZ4OIvuFnJwDzvoPAWa3nLHae/C6R
	ZOInvJ9dH5ww08q8oQNgZQxZmrWJ0535MKyvUnSDjvQSt66MdVpU6uhIRa7TX1vaT3DZ2SXWazg
	R8Vb5J216Hi0UAMRXo3U58VRsv4slCObsuiyUh7rIK0NkvGaeVEi7baIniQiZTd4XsdxIdpcnBe
	Jwt70e/gU7ikGvzHgcp9nDSYoAwiT9gEyA+8gOMBMGWTVasyZ4x/1z5Mb1NcAE89qVxTZJpkjAq
	jqU37rmvIwUDIVdUOOFQioIrhd6chvxE
X-Received: by 2002:a05:693c:880c:20b0:386:ab85:a011 with SMTP id 5a478bee46e88-386ab85a718mr15451088eec.27.1795754851116;
        Thu, 26 Nov 2026 20:47:31 -0800 (PST)
Received: from archlinux ([114.79.176.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm77084648eec.26.2026.11.26.20.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:47:30 -0800 (PST)
From: Gururaj Naik <gururajnaik166@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] HID: amd_sfh: Add DMI quirk for Dell Inspiron 7405 2-in-1
Date: Fri, 27 Nov 2026 10:17:17 +0530
Message-ID: <20261127044717.129941-3-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127044717.129941-1-gururajnaik166@gmail.com>
References: <20261127044717.129941-1-gururajnaik166@gmail.com>
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

On the Dell Inspiron 7405 2-in-1 (Ryzen 7 4700U, BIOS 1.20.0), the MP2
firmware does not respond to sensor enable commands when intr_disable
is true, causing sensor discovery to fail with:

  pcie_mp2_amd 0000:03:00.7: Failed to discover, sensors not enabled is 0

This matches the behavior seen on the HP ProBook x360 435 G7 and ASUS
VivoBook Flip 14 models in dmi_sfh_table[]. Add a DMI entry for the Dell
Inspiron 7405 2n1 calling mp2_disable_intr so interrupts remain enabled
for MP2 commands, enabling the accelerometer, gyroscope, magnetometer,
and operating-mode sensors.

Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
Cc: stable@vger.kernel.org
Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index fafba3ec9ced..aeeabc3be2b6 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -335,6 +335,13 @@ static const struct dmi_system_id dmi_sfh_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420IA"),
 		},
 	},
+	{
+		.callback = mp2_disable_intr,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7405 2n1"),
+		},
+	},
 	{}
 };
 
-- 
2.56.0

