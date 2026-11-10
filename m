Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323021;
	b=no78+30vBtQNQL/4FnADzmJeR1t63LzDTQHierPPw/zt9lu9XrSmwh7pZoCX8PD8Vmw7
	 zeq1+ebApSP0EfSRwdCYAbUYBWGOf09XY27Yxah1iJZxqigRYTK0I8bBTDpu4CddWImDc
	 HYPNWjBbFY7dUisnwEBl0C4MNKEEi8mHDODFue5Xx/TuUhD/a+xKg4ohZ1GCBGUR274ei
	 YXgWdEcnDLE6doD46JylWxh1YjYOZQpE3BLVFFaOCmUvPu6dORCTKrJ4+u9dv6R0u83wA
	 4Eq5/TcVFtWCDNmCSIxGwK56y6t1f6GdhmqCSdXHvZVj9+AkbUXiMNLSU20z386K1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=HI3ODZEfxqyV3WqOMo8kXvUgM0sAej4sbQyygJrPN3w=;
	b=K0/m9FQy0IB/AREXADNlVbhjhofj6s22pt0SGFYc6rsaoV9B6Rffq7KASiS7HrlnEM/I
	 HSYiIhPg58H4ztKskQQxOOSTCysIam5utR4zjMcVhdXJ2Ibx7en9XZFztWAkpje1RvXWE
	 /bZNtWlCVR4iKZiGGQ78e/3OMECvPkui6sPcJDSpHq5murGf4D/TgBQMYclKBI0RywiNP
	 3nf5+XksjCUNtiil3XeVYJMsz7scRa0INTy3864gWebUFmgJ0xL6vZSLyNpG9wDymnXmp
	 vvk/OAXlNqLY0pj1PcWAzywa2Mf8fciQ2l5JYz2I/taoSRx8y+Hh+FpaKjQAdrbcOKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MsLsWS3C;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59060A262E;
	Tue, 10 Nov 2026 15:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA59060A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MsLsWS3C
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zv0nyhz8Xrr9;
	Tue, 10 Nov 2026 23:03:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794323019;
	bh=Vto36UR5PeGgWfEXmDgcAGesARJ0OUwKJ0q1TTRSQYw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=MsLsWS3CN3NQG7wR0V+7Ut1TqCrIJa6u1MrJUnLY6yIlmSfW02M7ENxbXJXwxuYo9
	 3G5zUEWaQICMSuhWt6wKJM01IIQwAbV/IitFEM2Bz4O8ki0e8jrShAul1P2O5l2z3C
	 vICNBhakNCfqNyg620k3sHz2pQcaPJo240+ds/t56dcAzOp7udwYGk0nL/B3TMLqks
	 wSRrG+oDGoRVrb6S9XFD+J0qXBhih/JK5AZmr5drfkFlJOjifnEyhQDGu8bZEL8Agi
	 grIa0w7wBx24XxsT4flQtsUjzZ++b43XHT27nFiRjC97352Ok0K3IwNgnyWfFcFqAv
	 kilN+Uqq6/b1w==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AAF3T5Y030926;
	Tue, 10 Nov 2026 23:03:29 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:32 +0800 (CST)
X-Zmail-TransId: 2afa6af3324434a-1d972
X-Mailer: Zmail v1.0
Message-ID: <20261110230332609vrNKZhiIS1EGJIhlnmX1-@zte.com.cn>
In-Reply-To: <20261110230327212pqd9rWq5IWa4wD-Ckj5C3@zte.com.cn>
References: 20261110230327212pqd9rWq5IWa4wD-Ckj5C3@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:32 +0800 (CST)
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
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <hansg@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvMl0gYXRhOiBsaWJhaGNpX3BsYXRmb3JtOiByZWplY3QgaW52YWxpZCBwb3J0IG51bWJlcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAF3T5Y030926
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3324B.000/4jP8zv0nyhz8Xrr9

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
nodes.  That loop has already reported the invalid port number, so do
not print a second warning.

Fixes: 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---
v2:
- Do not print a warning for the invalid port number: the resource loop
  has already reported it (Niklas Cassel).  The validity check itself
  is unchanged.
- Send as 1/2, with the ahci_dwc patch as 2/2.
- v1: https://lore.kernel.org/all/20261029190111138tS0yRo0lL1zJZ_IutobE1@zte.com.cn/
---
 drivers/ata/libahci_platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index ae342080556a..0ffa4486de77 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -434,6 +434,10 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
 
+		/* Already reported by ahci_platform_get_resources() */
+		if (port >= hpriv->nports)
+			continue;
+
 		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
 			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
 	}
-- 
2.27.0
