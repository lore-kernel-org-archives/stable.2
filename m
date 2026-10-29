Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271683;
	b=C6xKF2wSa0phDAHARqpdHeQK+oAzXBa5zUZH5WRWKQCWnubggz8LrWGMYETjL3gwS61D
	 /P+crmZLHuf6KLfv+70PLfFiVQLDgrwaXxR1+tNJmbRhHKbTWKXI555QKyCRjmCjXoqir
	 MZ1zrIEC2kqPxbxZM8NG3wgiC7Rgwz8G3P+da6JKku5v9na5xt85dxAoGkrCEMqHXeodb
	 G5CrssNqm5Uv75720MNELUYSddFi+P84tQE0SrsHH/vSsesbJEfoltPbAh3QSFU4PJVYI
	 3WL1o4eb8SaAqdP7UlvGZnjYAKs514JfCylCmfFfX6jXCYRtK0loyXlY1gaFJD2FdXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271683;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=RZsGw/LCRpH/RPxirEbcHzQUjgbaZAdI2sY41posDLk=;
	b=jpkE+axF4pGRefZ+umJGZvqFXztm8ZqkIt9KWN1N5228dUjFRBHG4nV6kN6tqkzn1tjp
	 CnkVMtpgskCnxpYMX3zzutblVBA/JKUm/O+f1VXtcnWKnzy+ynbyWGRvotvubgNUdvi+T
	 Mbk+FXh0VB36Fe6T8dzotBcDIveoNXSPeQF1oX4ICeR2Jn/bhJEizpnm8+RLFC4O5PiH8
	 JtFdgJgKRtCdltCZcDXUxOFBe+Nnn0CB42SVHU699vIP0n0M36qghQGpOCFAqRb08sO/Z
	 /8P1mb7ZTdfoBqI4IeknCh3NDjrr02LGdkoWLE171vnkcCMBjKP8LUVj/VcIlD7oziA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BF606A31C;
	Thu, 29 Oct 2026 11:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFh9p1hWwz5BNS0;
	Thu, 29 Oct 2026 19:01:18 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 69TB18El056090;
	Thu, 29 Oct 2026 19:01:08 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 29 Oct 2026 19:01:11 +0800 (CST)
X-Zmail-TransId: 2af96ae32777b95-21d18
X-Mailer: Zmail v1.0
Message-ID: <20261029190111138tS0yRo0lL1zJZ_IutobE1@zte.com.cn>
Date: Thu, 29 Oct 2026 19:01:11 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <hansg@kernel.org>,
        <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBhdGE6IGxpYmFoY2lfcGxhdGZvcm06IHJlamVjdCBpbnZhbGlkIHBvcnQgbnVtYmVycw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69TB18El056090
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 19:01:18 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE3277E.000/4jFh9p1hWwz5BNS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ahci_platform_get_firmware() reads the "reg" property of every child
node of the AHCI controller and uses the value as an index into
hpriv->saved_port_cap[], which has AHCI_MAX_PORTS (32) entries, without
checking it first.

ahci_platform_get_resources() checks the same property against
hpriv->nports, but only in its own loop, and hpriv->nports is itself
clamped to AHCI_MAX_PORTS.  A device tree describing a port with a
"reg" value of 32 or more therefore reaches
ahci_platform_get_firmware(), where the "hba-port-cap" property is then
written past the end of the array.  Values just above the end corrupt
the following fields of struct ahci_host_priv, larger ones write outside
of the devres allocation.

Apply the same validity check as the resource loop and skip such child
nodes.

Fixes: 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index ae342080556a..d7106ab9ff3d 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -434,6 +434,11 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;

+		if (port >= hpriv->nports) {
+			dev_warn(dev, "invalid port number %d\n", port);
+			continue;
+		}
+
 		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
 			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
 	}
