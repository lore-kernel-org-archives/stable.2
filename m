Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA59F3EC812;
	Wed, 29 Jul 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337659; cv=none; b=RfOkTTZ88ZQsJzBrn3XrO9AnzjYWji92Jok1/8813RvXbiHTxIpxE1BCzViTAvhuqFrsgVuqrDcF06m+b+eTwS2sQ0negY2bO71wPUAZYK+51YyBwR9/EyGM0iou9N2+qi8qq7PmtSSRpZNwe6v3yE+PjW9mLWQA0wHr1n74rGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337659; c=relaxed/simple;
	bh=uLF4/5M8BK//0PaR3lWeHDFhujQu4e0vEvyedKKMMbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9ya/okGF340stFe5aZQJme5KHpygJ3y7lRcyFyu7ILqYLcDDBjtVwRR5oWqWndt9kDXtCyV4lomn1ZmwN12YeSvBLUQChBRuSXtX5XlFaOri142asn3zPUuyroYtQLkHSmmEdQtK29Yl3xnhG10IfCHElQ5/WvidbL4Y28W6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=EoQk1r90; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="EoQk1r90"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=aAP1gRw0f/juH/GrkAVHhQx3XXlaFij+1lKD3oiCoMI=; b=EoQk1r90j4GLpmmKJJHFhrbjuE
	hNuQIAd6+6oY4LzLf0RmTnBqra6Q9hf0KYz8T/qxcYkbw9C2JYRsmG5kX1vo3DSaOQCu/QCib0q9c
	m4zu9Y1POB2RfcBJkBbivjh3j4jt0Qsg3+Efsl2S5dfkxLqOYRsBRXpf/+V9CiLh1l+ZA/EvdqLhx
	JGQ90KJM3AQyQeASVBZYvd88xdpjJIymwKbH1hbdY20w/sR/znC9JPsBBrYj7nf/iycvoWuK+OOIA
	wXcxcLzRB2wIf5thx0c/rDxdF4DQswXfv2uYvrGBpwtROyWu2vHRtrrickslw9Mo3xwVWiHQiG4Vi
	Hei3VhYg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wp5sd-00000002eB5-1JeV;
	Wed, 29 Jul 2026 17:07:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH 1/6] riscv: dts: spacemit: k1-bananapi-f3: fix maximum CPU core voltage
Date: Wed, 29 Jul 2026 17:02:18 +0200
Message-ID: <20260729150722.1598630-2-aurelien@aurel32.net>
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

On the Banana Pi BPI-F3 board, the buck1 and buck2 voltage regulators,
which supply the CPU core voltage, are configured with a maximum output
voltage of 3.45V, while the highest operating point requires only
1.050V. This means that a kernel bug, OPP misconfiguration, or
privileged userspace could request a voltage above the safe operating
limit, causing possible permanent CPU damage.

Set the maximum regulator voltage to 1.050V instead.

Fixes: 09a412d39748 ("riscv: dts: spacemit: define regulator constraints")
Link: https://sashiko.dev/#/message/20260728211020.1248676-2-aurelien%40aurel32.net
Cc: stable@vger.kernel.org
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index e2961b7e0a3eb..58035d886bf67 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -237,14 +237,14 @@ pmic@41 {
 		regulators {
 			buck1_0v9: buck1 {
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

