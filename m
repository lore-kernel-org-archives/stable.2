Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795805110;
	b=ZyULacn/b8182hSiY9ZUgJQxCetXY7UhZRNsQnUR85Lsn+LcJTaCUPrN9tacA8h9HjT0
	 Ia48QeCX7YDGVjeS9BOap3TXoQpyH+V56EGkAzY68+TJKy9erkPZPmpt5V5tOdMi0LKHV
	 Owd5uxSn/7Kc40jUnI8Zw19vBIeoW1YC7HbC7s9PyDAMR0zoHab7Z5aGOBLmXbpc0Rb66
	 igDQxjfhZ8NWLmjU2AbaQWJw/XKR91fDPoxLCl8qQiWqc2m1Nf+VQWxlD8YV3VP9tgWZL
	 GVCk962y8DEynnSQ+IclIIHXq1OjLWfZ5ixyfew4DbH5q+10TUiFe8pAmdWYaNXJVHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805110;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=huhmOlxWlD3WMRu1+5OLCMARKhMIhEX4gkYE9EN0cdo=;
	b=sgFMxEz3jrGXVbRB+oFmcu3oR8rzvQWwc1EuAo4lOUx90GpE7Hbn343T6S/eI8RzjlbU
	 YNV7apH9P2M3kqoYUlTKrVCU0x/rSy/pWUDGV637pktt8FX8Em0ghHnVmT7W8ozfKrWhQ
	 q1/AqmFnwDKWYHX5Mp8pbw7aE89aL4a87LpwjuFGMywYAErlcA1JtlRjDtDDHkK3Vcvmv
	 F1vnYxOMhtmBtHEL3NzB49hpuWY3XZcDmXU8yx+eKK0KUaZwh6BFypv/vi//z7bNd0EKH
	 50D4UR0xYKrLSjN00fIC3oYsx06Liyy/hRC/tsxND+yhnTXjtbT2tsojefu3+sXFoMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXHfCypr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB59606A329;
	Fri, 27 Nov 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXHfCypr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795805109;
	b=tsdKegBtNJV9UgginNd/Fr/mXmJ/8N0cCgKII3pv6elzeEnl8xkBdu1POX8iKUp90Kb3
	 9o8epqV5BnolvlQsscWxtHxoyukcp5OEQPy8gCk3usuKOX+lrftvtgumk4Rx4gWSm6D2l
	 36rs0jwoWRtnz32NGgswuw9CFZVvt2hh9mUuSrVE74jSiBaOGr5blkvU6R1Rv8+fAx1u2
	 EmQg69LZ8+55RdEoGa1MML6I3Hgf3xtNVU8Gl9+06ucPMN4lJ9+Z5RtLm4vZBVAQef/YW
	 QZDFQr0Z0M6gk5MHZBcX1nN69yh30XM96ciM0yS2ndMAStT6JOjegH4shKEY0IGed5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795805109;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=huhmOlxWlD3WMRu1+5OLCMARKhMIhEX4gkYE9EN0cdo=;
	b=dn8/ZQ8GtUMT39v+iHjLyGhK80h77ZnIj5RZlol0Ahmiz3I0S4/kZFEItspUwohePvH2
	 NKpaRvyrsAWA6qq8YJuJ+JtSP9CZLYrKYW5MaV1uBrRu3PhWqTKvfqcMDbQjBXs+5xqYW
	 gHufoh0K3taY0P/y3BiFmnE9iZ9ttqXvSCpzR/uXEsV4LGOaX9Y29oE+gN4r+bNh8O9vt
	 vDNISUFbnnWCaWWwKf0xjvJ00+eSmHPLdP7FFSpM2D9kQ002/xTelMQMIQrQ8YyWXWorM
	 FTwPzIG0IHAdAkEIYJQqW79BMeEgYW5GzGe7L8ZQQwkoBZnjWCGfH/zaV716KX3EKLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8FFCE1F00899;
	Fri, 27 Nov 2026 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805109;
	bh=huhmOlxWlD3WMRu1+5OLCMARKhMIhEX4gkYE9EN0cdo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZXHfCyprePOKaT7K5v36JMG3I9B/dNvQ9jY9leZiS+7CcajerIg6kQzo5UNNv1LLu
	 sKzyC9bcwslq7QV6Ia2H6pQuiX/Cq2J6DhxUaWnbZpsC2dGcASAcvsOICcO5hhu9/a
	 H1h4YURC+DQzq3W/aPaZSjq2G+fxgjVTeQHWEWra74t8HheNOub4vb5Yvl2hesZTou
	 Zk9vVAFXtHgKprc5NaxfbtyPCr5/KGzQ5DNHIcEUwKe2n73k4gw3C7Zhd+fxkpXIbU
	 8GOxXND4J+K1nIQEfUc2GwIcFA+lDrBGdjWthUhJZjff+gbUpM2GI0a1Gw4ig8myOp
	 /wvC/Rv2dqbVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0DAD94DD2E;
	Fri, 27 Nov 2026 18:44:58 +0000 (UTC)
From: Willie Wiholm via B4 Relay <devnull+willie.wiholm.tritechsolutions.se@kernel.org>
Subject: [PATCH RFC net 0/2] net: phy: dp83867: fix Wake-on-LAN without a
 PHY IRQ
Date: Fri, 27 Nov 2026 19:44:55 +0100
Message-Id: <20261127-wol-net-v1-0-769a2aff91df@tritechsolutions.se>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfPCWsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNz3fL8HN281BJdQ4O01BRjS2NLU5NEJaDqgqLUtMwKsEnRSkFuziA
 xoDql2NpaAO5RlSZlAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Thomas Haemmerle <thomas.haemmerle@wolfvision.net>
Cc: netdev@vger.kernel.org, 
 Willie Wiholm <willie.wiholm@tritechsolutions.se>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795805097; l=1805;
 i=willie.wiholm@tritechsolutions.se; s=20261127;
 h=from:subject:message-id;
 bh=zddDQvfZ9dxo0LCn2owtXLM1iCgLlXakX558pOBrSeM=;
 b=vZVKp/CppB+qxIrBmL+iU53YfoBeLS7NQwGSdbJfzPJZ9xcANDTOtDPdY0Ey2oUkZmCps1EA3
 OMMqeezq3GKD4nv8lM+GvslrBXQ+ilbp2t6JdO73c6dFySjbCqM3zo/
X-Developer-Key: i=willie.wiholm@tritechsolutions.se; a=ed25519;
 pk=+cNLoL8211zFctWUX7P+l/TZm0pSVfYhLugt3NOecW8=
X-Endpoint-Received: by B4 Relay for
 willie.wiholm@tritechsolutions.se/20261127 with auth_id=1669
X-Original-From: Willie Wiholm <willie.wiholm@tritechsolutions.se>
Reply-To: willie.wiholm@tritechsolutions.se

On an Intel Elkhart Lake board (congatec conga-SA7, dwmac-intel with a
DP83867 over RGMII) Wake-on-LAN from S3 does not work on the first
suspend after boot or after a link down/up.

Patch 1 sets CFG3.INT_OE when WoL is enabled. Without a PHY IRQ the
driver never sets it, so the pin stays a power-down input. The firmware
sets it, but the soft reset on attach clears it, so the first suspend
after boot does not wake up.

Patch 2 reads ISR before suspend. Nothing reads it when the PHY is
polled, so a magic packet received while the system is running leaves
the WoL interrupt latched, and the next suspend does not wake up.

Tested on the board with net (28a371228d4e): the first suspend after
boot, after link down/up and after a magic packet received while
running all wake up on a unicast magic packet.

Questions:
1. Patch 1 makes the pin an output when WoL is enabled. Would you
   rather preserve the firmware setting across the soft reset, as
   043777e94880 does for the LED registers?
2. Patch 2 uses PHY_ALWAYS_CALL_SUSPEND to get a hook before suspend,
   like bcm54xx. Is that acceptable?

I used an AI coding assistant (Claude) for parts of the analysis, the
test automation and for drafting the cover letter. I have
reviewed the changes and tested them on the hardware.

Signed-off-by: Willie Wiholm <willie.wiholm@tritechsolutions.se>
---
Willie Wiholm (2):
      net: phy: dp83867: set INT_OE when enabling Wake-on-LAN
      net: phy: dp83867: clear latched WoL interrupt before suspend

 drivers/net/phy/dp83867.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
---
base-commit: 28a371228d4eb4857cc31eeb1a0d7d01e9c3ea2f
change-id: 20261127-wol-net-10fed393954a

Best regards,
-- 
Willie Wiholm <willie.wiholm@tritechsolutions.se>


