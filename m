Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684963A4535;
	Wed, 10 Jun 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079265; cv=none; b=eQiI+r1zn4nWoQkh7XSCWs1pcvRortNq/xgCaxtb+cn0T77Bx/NjYe5CdbJBQqFU5hSFakEj+MABvpJVNyd3G5NWfglbZ2mLivOVEy4MT7zfQGew9WquzJ8Bn1XXR8rLIESuDC5lwmsEiUgoyZgIaZzE0uYcx4bXTEzN+yvsmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079265; c=relaxed/simple;
	bh=spRVBlGQqW9gPeAmUE2Yu2/R44YAQEpXfhl1wos4Kp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zug7aT+zmbIqcqcV973YBtP4CLy9nH6svAZD5kH6SEhwMTFjoO+74SLnkKp2cxRoTtfBfam2wPdfGISqQjq7U9JmVKZkMJ9Vuww9Nc92yLrZJyIezSE5lJS54ItkDY1wInyeUPwaMrGo0kBY2HwPekyD27ha2gOkGu0Ve01x+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=NqlJu1XQ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="NqlJu1XQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1781079261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4D3U0MJrq3HMALbVG4yy5LYGiwOLwK/bQQJ3BITNLwM=;
	b=NqlJu1XQMQhaZi7mQd/ZOpEchPr+6zrwj3xNiK+0D8Ko97FQl9fiDao64Tv2W03aTZOkM/
	PRrJn0gHWNAItsWzuKZ6Z88MV/dMcDUfjdsml+OG9OnOC0hA163TdPxEfxK8i7v0vT7ORH
	rhIxZWUJCEjFA4tMfM5bTE9k2BcE4C8UBVhmTXvMKA7aV6KOF8ugrlSkKr71PDTzwLwHDB
	5hOFtos5Ldd4PqC5j3DXZy0MiCwqIYWW/TJOu5H9kfLKIyrcT7QvRrIGH1Ee66OhZeDMSZ
	9YmnU7Wu8VSYL85dsLtmfDdpeSxSlGvcDaF/Rn17xBttHzxXNz/t+PpbOHW+7g==
From: Diederik de Haas <diederik@cknow-tech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
	Diederik de Haas <diederik@cknow-tech.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: Fix USB hub phy-supply config for NanoPC-T6 LTS
Date: Wed, 10 Jun 2026 10:04:06 +0200
Message-ID: <20260610081400.758687-3-diederik@cknow-tech.com>
In-Reply-To: <20260610081400.758687-1-diederik@cknow-tech.com>
References: <20260610081400.758687-1-diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The MTT USB 2.0 hub is connected to the SoC's USB20 HOST1, so the phy-supply
belongs to u2phy3_host, not u2phy2_host as that is for USB20 HOST0.

Fixes: db1dcbe5f752 ("arm64: dts: rockchip: add NanoPC-T6 LTS")
Cc: stable@vger.kernel.org
Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
index 0ee67ee24f3c..0e15a2e1f2ff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
@@ -38,6 +38,6 @@ usb20_host_pwren: usb20-host-pwren {
 	};
 };
 
-&u2phy2_host {
+&u2phy3_host {
 	phy-supply = <&vcc5v0_usb20_host>;
 };
-- 
2.53.0

