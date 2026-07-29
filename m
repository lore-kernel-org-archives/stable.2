Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1438DC6E;
	Wed, 29 Jul 2026 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337683; cv=none; b=dCUWIHJElEGoIRdVdKFub5IfdojbIJeToS+QyzDzqof2ZrrfzIy+9tsKrmk6/RvHlxo7MmwV3mdQuzZol3U1yfp8PHvF/Mbl4+1samkqjeYXzCBCVRcHpLvvtNicbTI7cNn9gFmjt4MROqyy6bhx/wMHOWfYVHfspfklOpKThq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337683; c=relaxed/simple;
	bh=TRu5LBC9IX2RNboyK4GHkffEZ9Z5hCIQI7yrSyvCfns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu8qTbYKNapKpqEPF6Wn1b8EN0fHchztTVuA07z9oB2ebPCJC1TOSKwPfxoAxOFyeYey7oBhqOE+8Q81LblUSYoNZzzf2kyI1+yp4L96MPkTyVh72fAmkkRUNOfUupGkuKUTms+/2Y0uhctrmoNc0gbX2IWzDQj7w2S+2Wddl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=bRZ/f3du; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="bRZ/f3du"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=9GCHA7xIhaJsYc9K/gElGpvzs0h61VGIvTXBIIzT2QY=; b=bRZ/f3dulCdpILjEGzoCG4+VTe
	/Em5J0+JlBtudmbldAHNgxiIEPvUu10pIbGwkAaNea6V4ZmN36zoE9Gi+9OmUCMy+jVtpOXh/1ZnB
	gdhwj5tslbjsk82fRYaoZ1nvfolc1PieR8mlb84xaSkq5bZ0+kkWcWekGeC9oa5RK1SAFOZvNvySO
	8EhPLcVuvX72VepmP193BjG6bEwHyTSRQpZi/XCD8EF6vu0o4GaUuICkDrKJgmfZMF5meH2Dpyoeh
	XhH3ErAZJO+b9+tCOefK6fOeF2Gk/VBbPZILawjVF0EbwVt+5XlSjaXO5IlHUGEQaXUDt9WIp4iay
	xl6GjJQQ==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wp5su-00000002eC4-1KJw;
	Wed, 29 Jul 2026 17:07:52 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Han Gao <gaohan@iscas.ac.cn>,
	Chukun Pan <amadeus@jmu.edu.cn>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH 3/6] riscv: dts: spacemit: k1-orangepi-rv2: fix maximum CPU core voltage
Date: Wed, 29 Jul 2026 17:02:20 +0200
Message-ID: <20260729150722.1598630-4-aurelien@aurel32.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729150722.1598630-1-aurelien@aurel32.net>
References: <20260729150722.1598630-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the OrangePi RV2 board, the buck1 and buck2 voltage regulators, which
supply the CPU core voltage, are configured with a maximum output
voltage of 3.45V, while the highest operating point requires only
1.050V. This means that a kernel bug, OPP misconfiguration, or
privileged userspace could request a voltage above the safe operating
limit, causing possible permanent CPU damage.

Set the maximum regulator voltage to 1.050V instead.

Fixes: c02c047b925c ("riscv: dts: spacemit: Define the P1 PMIC regulators for OrangePi RV2")
Link: https://sashiko.dev/#/message/20260728211020.1248676-2-aurelien%40aurel32.net
Cc: stable@vger.kernel.org
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 7c49bce427f30..b907a1396b21f 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -164,14 +164,14 @@ pmic@41 {
 		regulators {
 			buck1 {
 				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
+				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <5000>;
 				regulator-always-on;
 			};
 
 			buck2 {
 				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
+				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <5000>;
 				regulator-always-on;
 			};
-- 
2.53.0

