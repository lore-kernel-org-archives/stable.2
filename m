Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795811435;
	b=aFm0pZW74KlGBZAKcLWmzO3un4oULl/+TDZQuyzYh+qmO5x6ydHvTGHAMWtwtlhGGfVX
	 fILjwVlzEzFU6QlKpSU1JHvhVhepansHzzjlu7LGRjqIntMcgmesbzexe7+iujXSXmyVT
	 qwRU9YmdFS2dcPoECjHig1eE7hh6g+pTu//kKlDVdmfm/X00gHpl40VbsovtOyEQXuPfW
	 0jAZkA9NiBGKjKquE60NhJYqeweCOJ66CLZ9NqBx6c/IPusX9SrKL8SNcn5YXimYjOnOl
	 Snd21BS9Ysca1ibxvegYSqPzagPSObayfu6l5D9JSWwIe/VqQi1HZUdSllYbKHCOQ3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811435;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kTk8LQEMS4R5shZWeKU76miL+YW4AUSX5jvGj7Ee8CU=;
	b=fBQxLX82K5CKK8qXOBNKOJRTMz1DQZoHBrIMTniAIE8sDQGxp2dWVzLIiPJBH6dKrayK
	 jNxyBkcdzAN/j6zJWMrl+oTwa3qL6KDbuxiiq1HCbqOEDjSzkletZ8yCbrsf82Y908iNZ
	 1csgmb8BYOmP2HFzTnFfq5a4zk5QUTKGzf15X5PP6+/yzU5JfCMfnqS6dxsCDrBvBy7Kg
	 4H+sc7jtIeYgBgnt2EQLWDfRKKz3j7ezXYI9nEx5OoD84M+IgVnm3E5B4yZw+7/2d86Ox
	 tZpabc3Dyj7fH7+6kYVZdfPAE7YpajGZYMZQe84Hr38olpp8e24lNNz5Qj3nxf8M40w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REZxj8I3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956E606A321;
	Fri, 27 Nov 2026 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REZxj8I3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795811435;
	b=ASk1Ti2eVGQws25hRt2kZob05wxM50/lBJ+L5Hh7nwe4UxfltRyvBUtNK6yIDib9i8Rn
	 l4a38S0v1epRrtKvd4vRGMOhGpiYlRX+V7C8I7MS6qW+bT+tcb9vE7mM8BMoZWW9MQeIf
	 6t239iCVosgwFT17lqvIensab4iUdNZfXRFgoUtuHJlhNzzh3Kiy1RDgsQK111+gmmO23
	 dzniJAx4D/r5RI5OrvYuG2CZ7gYN862kZJiTtqX1Phd6Zsx55DzB7ME2vKTbzSuO4A5IF
	 a1oerFDbmvHqP/lTpEaOt/YMIrhj9jQA3cuGpEHeKoXLpnG1+Npt0cB9FBhLNF1Z1Vg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795811435;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kTk8LQEMS4R5shZWeKU76miL+YW4AUSX5jvGj7Ee8CU=;
	b=CpPeM+3MnvgAqmrP5jqnxjsjIeNPDrmcCtpJSewCD0GSPbSslyHUjFG6WX19HVah11kn
	 nY0N+vcahEMwA3TzLxKiC8RBDn6NA5m4luuvMloT1RkJE6yfdeqfUGYOHiyGlFpPGqGec
	 oot5ZF1gdmzILZVe2QUSOQ4cyNqHSES+U5xTGCAVnPrh9XiMnuzcFPwAcuD0VrmhPNivy
	 8vbtl49laj+zdtMih5AwzskYwOkzWYiaIddARJCCmnXL9cMCQEGuFsGn7ABV9IfkjQIe6
	 +OMGvBGYw/O36coWa40vMUu7CHHt40O343xRhDQP8Bj59Ynu7ruihWw9IbBGUmpQIlQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DE0411F00897;
	Fri, 27 Nov 2026 20:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811435;
	bh=kTk8LQEMS4R5shZWeKU76miL+YW4AUSX5jvGj7Ee8CU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=REZxj8I3Vpd1FtDJgI+DEVNi8KTjoTYF1zYz0uJGIcCWq6hCEZHnZlt2Xfmgg2QNV
	 WyGDWac96hI5ED29msftAJr0FxyKXfhzh7agqk9cvZyIUdXwrb6QeoLozMithWiBha
	 lPCqi1E+dzuTAaOt5vRf9MriMzPyDjQKSWe9AlzUqiky7lzNbE7XWO2SXvIImozKFd
	 ta22sfRObHnPfGK1G9jbCMcErmro+OHZd4Qu/l1H9vApfMSYY96LEeGGLdU9vfr+k5
	 0H2ykUFwkQLeewIdKTGlJ1wSiCj/6TXN8+089aVwGi1lGX80hKWK432T4sLmZIJ9kh
	 JCCvvoZXAzUAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6B1A64DD8F;
	Fri, 27 Nov 2026 20:30:21 +0000 (UTC)
From: Paul Sajna via B4 Relay <devnull+sajattack.postmarketos.org@kernel.org>
Date: Fri, 27 Nov 2026 13:30:17 -0700
Subject: [PATCH] arm64: dts: qcom: sdm845-lg-judyln: Set
 regulator-always-on for ibb
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
Message-Id: <20261127-judyln-ibb-always-on-v1-1-9e687e625afd@postmarketos.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJrfwYr2JctJ0Bh5BiOiIQw
 t2tuvwW7+2gnIQVrsUOid+iMsUMcyogPFzsGYWywZa2Mca2OMy0jRHFe3Tj4jbFKSK1oaJwqc5
 U15DTZ+JO1t/2dv9bZz9weH1fcBwf8lCF1HgAAAA=
X-Change-ID: 20261127-judyln-ibb-always-on-d7c4dc843d55
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 stable@vger.kernel.org, Paul Sajna <sajattack@postmarketos.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795811420; l=1748;
 i=sajattack@postmarketos.org; s=20250413; h=from:subject:message-id;
 bh=+pKkKHybW1iJ5KMQ7H1eBl6Hh5TX6R/S9mAl8MBd+AI=;
 b=R6MUGlBNXM9ybJeDKoWVCg7V9gzifYsRpCk6S/JdVlEeqn1bDMSytJ4hft/H4CqyzVFbVPQn/
 AlXOFCzYmiQAy+iJEpJmwiIT1s96rVTdTgST52bCX5R4aOhMuE2iwEv
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=ZFE/UBqiz9Wr8b+zBL27opOjw5x5ket5JFqks/VQGeM=
X-Endpoint-Received: by B4 Relay for sajattack@postmarketos.org/20250413
 with auth_id=1505
X-Original-From: Paul Sajna <sajattack@postmarketos.org>
Reply-To: sajattack@postmarketos.org
Content-Transfer-Encoding: 7bit

From: Paul Sajna <sajattack@postmarketos.org>

After resuming from long periods with the screen powered off,
the display develops hazy shadowy patterns at the edges, that may
even persist full reboots. It seems the current setup is temporarily
damaging the display.

This fix was previously proposed in [1], but rejected due to
battery/power concerns.

Since then, I have determined it matches the behaviour of the vendor
kernel. See downstream Lineage kernel [2].

I confirmed the linked line 816 that skips panel power-off is run
via adb logcat.

```
[Display][lge-dsi-panel:dsi_panel_power_off:816] [Display] Do not control LCD powers for LPWG mode
```
was logged.

[1]: https://lore.kernel.org/linux-arm-msm/20250916-judyln-dts-v2-13-5e16e60263af@postmarketos.org/#t
[2]: https://github.com/LineageOS/android_kernel_lge_sdm845/blob/16c83a1f965b45dc6707a5d5afdb0904b419aff2/drivers/gpu/drm/msm/lge/lge_dsi_panel.c#L816

Fixes: 2e7cdd400b6a ("arm64: dts: qcom: sdm845-lg-judyln: Add lab/ibb")

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
index 349faa123ff1..008c34fb1644 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
@@ -120,6 +120,7 @@ &ibb {
 	regulator-over-current-protection;
 	regulator-pull-down;
 	regulator-soft-start;
+	regulator-always-on;
 	qcom,discharge-resistor-kohms = <300>;
 };
 

---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261127-judyln-ibb-always-on-d7c4dc843d55

Best regards,
--  
Paul Sajna <sajattack@postmarketos.org>


