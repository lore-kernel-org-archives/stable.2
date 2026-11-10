Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289370;
	b=CilMOSWr3VAvRQe8GGfygbBJw4ztKytGxa7XFElwTBYegzLMqiB3QJtraG033ec88pbI
	 HVTiZxd5ku4m7kbThfDZaTAZwXCg+BSkM3ZkGx6no5b86n1hfR1193Um8spp29sQH1YR0
	 9mKPx88/naaMBjyXYOH92kg6KnISfbaal4ZqdApPp7BsFZxumY5n/1Z1Pcq0oS+LvqSgU
	 UpfVxGNU/DRIhtR0NBOo5coYwH/mbXEdha4dRE7vmhDVK1NUSCnfoWkvFH7CxX+mN2GTd
	 9JaiJ8OSuzo92v5fKKQLOuivrfs99Ni1YO9uE0R63AacrQtDnNy2yUkHz1XqDLFh/kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=25uRKq7Xukya53/sNDtQi7TrDyl3xvj1KNxFQHVGzZY=;
	b=a1YCewwZuhheErJ7X7ROrdqez+PTvAzDDAWP2xrVT846DIDpjGeijQw7i44DKBdtoT47
	 1BSqTHMYopm4BfwRoNBpHmI6CGrHIdSaL4JHx2w4CoKr8QMCXrlaaXkuABnchnGGeCBTn
	 mQxq8fH8JUa7XICGo30qWJ2B3tco4dmw0KlI7iIcbcZMPzRN4EdwNP5978BhG0b3rrQEI
	 AE5M5DAyXCf0bBTWWbMok590pPxzoFOsnBu743H4tjbEzr0EQ/BmU9Vy3gkWR6mdkBxKY
	 eiaWA7gGtOXe24RvwnkzyWIkN8elciUBnceWJtOvkYtLBrKesuqzHl+viXrskgy61oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C31n3yIF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C31n3yIF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB651F0089F;
	Tue, 10 Nov 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289370;
	bh=25uRKq7Xukya53/sNDtQi7TrDyl3xvj1KNxFQHVGzZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C31n3yIF57U2lX4YBZ2p8JSEV56qHh/YSolybSTGL1CTu+2MuIzrXY446+/ivGCuz
	 fNtHBD4oqXaPEUH49oQgHtILqYHLtHkqsKBBjzPx85bUm82G9cKmfI3xTBR4fmj/Ww
	 NYafobCJdUrgLWMLUYdZ00NXlrDc/wQIg9602qjdfHDg0+GI8DnX++NdSo29oC+lbG
	 BLeeijXjPLQGWFCB6VovzhPgAjjUBDsCE3+DzxuvfrF/Lv928FEJFCMwVvdxhgStl4
	 b4lZhqeiYjo64wsDhDguzignjAlb9nBZoPpusjcxE5FcLu6lwjQS0wPXf1nbEkJsYj
	 JVDL9hgE3chZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] arm64: dts: ti: k3-am625-sk: Remove M4 mailbox node redefinition
Date: Tue, 10 Nov 2026 00:42:46 -0500
Message-ID: <20261110054242.455209-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051734-failed-6.12-8ef8a0e38d13@kernel.org>
References: <20261107051734-failed-6.12-8ef8a0e38d13@kernel.org>
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

From: Andrew Davis <afd@ti.com>

[ Upstream commit 17d0723c6cf841ebaf510eaf9bb1ebf4991d6e9d ]

This node is already defined in the included k3-am62x-sk-common.dtsi.
Remove this redefinition.

Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20241203164031.20211-1-afd@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Stable-dep-of: 8ef8a0e38d13 ("arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 0fa11d3aa71e9..d240165bda9c5 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -243,13 +243,6 @@ cpsw3g_phy1: ethernet-phy@1 {
 	};
 };
 
-&mailbox0_cluster0 {
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
 &fss {
 	bootph-all;
 };
-- 
2.53.0

