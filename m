Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795278028;
	b=d+wIHM6UxQgipKijoF7tZui9+mQwjZrC0+uGa4yeIH1lFSfbxznmkUfmX+xW3eawUtgX
	 uE/TcBN4u78TZFY0RhVkZdGqJxzrcGrcBSPJ8Tp3KuUP40KprMzNfaSiQytRg07DZqT96
	 H7wEHHA+3dvRm46zT6H4xoxO3KhNaclPpMcJq+kD8Kh0K1wyrI2HM2EGbbyhWrORmwguO
	 MzCnQzHlYYPimwPIkTVBLy3GobHhyfGi65uYDSJdtgQjFe8OqDvOu0S8yWiDZNbvwoK1R
	 0UDtcZPF0JZUmbHiTtJosHVmO3zVIwxDWJkjXIegvfUCOym0s1yTLOOjfZZIXDj5QBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278028;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P8b51MoAA5S/ewoDjPx3DscZG+txaLOnVX8+xCfFlZo=;
	b=UyWdZmnxU+l6Z0feHcn/I1EzLxbg0WGo6IfJfIZYXE6tXWrDLQgLrZ1N7r/NsMG3sNhr
	 IoBSOKmfPCHDGC9RqBTOQt6tOu9ITdquVwZPWml9HfTlvkZgO/38nZvVufkYBBmoi810Q
	 4rGX8NUzp+8EN1VmHDzmXAIDmNU8JFU83isl6lSMJtc6duLdiPXGD6QXemTNPxXenUSPJ
	 DL9v4Dap8WyhN7EYY+Ro03apllmM5mJ+vsiAhBFtDSnX6qTwDuLn2r1QlQj8wnpYcO7TO
	 6+QBGIuejqqbl/qejOBhD+CW01XLAXEHDt6sLX+vxKNxKRh734/uxDfOclo/6I53nCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJ1uGpPu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7326606A338;
	Sat, 21 Nov 2026 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJ1uGpPu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795278028;
	b=Sux70eqXfoxNm/NX/VMgzTiI7krD5bynkcg7JBK4oiM5vF1BH3taoERhMwbCh5ezZbRm
	 cq0KWN/ztVNNzN59WzgReBekW7ZjKTAhuKSWHr/EDL29bg7EU07oFdcBxp7c285uUUV59
	 SfkJvz/t3IvGM0GFQMDVZRSd2WTKMT1lsr6mnampYt0+u/jJaqz3glKpIzOLHRr0//gQd
	 YO1wqBVi/Sq/DTkwbbJFNRA67LtZIShJ/KjG7E6WwzX4sIvxheNyaTSMDkX0FCrW0asqQ
	 5Xa+yd0/lknn1fNcx/yOD7EoP14Kwar/t2yaAsxjTV0H+PldhMkD9D5vAmvXJXs1bug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795278028;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P8b51MoAA5S/ewoDjPx3DscZG+txaLOnVX8+xCfFlZo=;
	b=k0qk6zP2j5+pgE21CQM0uDnz6ZWcdBqpuG7HsekLc1XHqxzr02IvgcLSNFwi0ANBZ+Kt
	 qqPef/LVYvu5A8lsopK3Vr1X3XCUDMulElGFOyC3EfdR/QqCECZ2Mt1Q5+3Ii6s6JeDFu
	 7Gfpg9Bt6hx9YR9lZfaearECWJ65tPRfim2LurYcwB1glRdkboded1vts9Jrk1Ib9o/nN
	 jbnFOW2TqeyAhrU0jMYkexCNFhifFgN+9okGYcgCAwbBaNdylHj1ubAMKFM16+/PX8zwI
	 lGH6HjON1LE5BOfvVlG6bsLGXzFxJpobEz8TlpqIZYwoOM8PARxg0SvphTFvqTyolcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF46A1F000C0;
	Sat, 21 Nov 2026 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795278028;
	bh=P8b51MoAA5S/ewoDjPx3DscZG+txaLOnVX8+xCfFlZo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=kJ1uGpPuPIKLffZcvp6bqvi/zlTT21dA8IzZt5Un3Z8yAsmt4wVmwt+04TUAA+ngY
	 5mW1/onElvutu45MpzKppKLQ7upnhGNtoHO1WXIiJcwPLi04pg1By1xMWDEZyf3I3Z
	 Hng3lQQZGdwbrZURQoYlzuYZQaYHdggXA4vp+Jz+N1dwfdKbTObeSQ+T+eQ9iYc7uR
	 w99xMC3RpORZH5jB1HSL42r75uJBbMJVavTkgWj5gJTgLAObuZguJwZBY1WB6mr9z9
	 rEhC3vxo+r9iht04clfqhf1YJswMYnuuk414hlpfRAG9pvFLoParxYKYxSN/eIEa+S
	 3REk0aF9mSwnQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CEE34BCFB;
	Sat, 21 Nov 2026 16:20:27 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sat, 21 Nov 2026 18:20:20 +0200
Subject: [PATCH] i2c: mediatek: fix probe when vbus supply exists in
 subnode
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
Message-Id: <20261121-6768-i2c-v1-1-98d51691fd8d@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWvSdjHKq4hFL4OxQFpEIt5ds
 fyS/5wLEkWmBE1xQaSDEy9zhioL8KOdBxIcskFLjUppJbBCI1h74WxNQZoejUXI+Rqp5/O7arv
 faXcT+e3dw30/VVDJVGwAAAA=
X-Change-ID: 20261121-6768-i2c-ba9ed08f68a6
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795278019; l=2465;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=YhzKgoIIxqqoXlohk7kgtxKoK2RDTSFs2xMuyiqhthw=;
 b=fHfVZgp/Esnl363UzJY2eHoY6j4V+b5/DJ2MTSVJbV40V9QK1dWxF5n4nr8xnbkMsti/UTtIr
 DINIFR8GHXTAmAX8PP2F2yTuL3XeyhLXtFNoFZJhsh2mLh5FPICt19y
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Commit 9029b9b2ae13 ("i2c: mediatek: mt65xx: add optional vbus-supply")
added an optional vbus-supply lookup in mtk_i2c_probe(). However, when
the i2c controller node itself doesn't define vbus-supply,
devm_regulator_get_optional() falls back to of_get_child_regulator(),
which recursively searches all children nodes for a matching vbus-supply
property.

If a device on the i2c bus (such as a USB-C connector) defines
vbus-supply, the i2c controller mistakenly binds to that regulator.
When that regulator is provided by another device on the same i2c bus,
probe fails permanently with a circular -EPROBE_DEFER dependency:

For example:
&i2c7 {
	charger@55 {
		smb1351_otg_vbus: usb-vbus { };
	};

	typec@60 {
		connector {
			vbus-supply = <&smb1351_otg_vbus>;
		};
	};
};

Ensure that i2c bus has its own regulator using of_property_present()
before calling devm_regulator_get_optional(). This resolves the issue
and makes both devices probe correctly.

Fixes: 9029b9b2ae13 ("i2c: mediatek: mt65xx: add optional vbus-supply")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 45d0d7156d6e..042244c7d89d 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1415,12 +1415,14 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	i2c->adap.quirks = i2c->dev_comp->quirks;
 	i2c->adap.timeout = 2 * HZ;
 	i2c->adap.retries = 1;
-	i2c->adap.bus_regulator = devm_regulator_get_optional(&pdev->dev, "vbus");
-	if (IS_ERR(i2c->adap.bus_regulator)) {
-		if (PTR_ERR(i2c->adap.bus_regulator) == -ENODEV)
-			i2c->adap.bus_regulator = NULL;
-		else
-			return PTR_ERR(i2c->adap.bus_regulator);
+	if (of_property_present(pdev->dev.of_node, "vbus-supply")) {
+		i2c->adap.bus_regulator = devm_regulator_get_optional(&pdev->dev, "vbus");
+		if (IS_ERR(i2c->adap.bus_regulator)) {
+			if (PTR_ERR(i2c->adap.bus_regulator) == -ENODEV)
+				i2c->adap.bus_regulator = NULL;
+			else
+				return PTR_ERR(i2c->adap.bus_regulator);
+		}
 	}
 
 	ret = mtk_i2c_parse_dt(pdev->dev.of_node, i2c);

---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20261121-6768-i2c-ba9ed08f68a6

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


