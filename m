Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86A38DC6E;
	Wed, 29 Jul 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337676; cv=none; b=rFIsX6iQatX0mJZSFbcz8U2G6TiRnoSiEyNTQubm+5d2gz12UeHdhkLA38V0zwd1FQaffdII+vCDdbVZ/JXrwrl5F3TXHKqbCMtVSp7onaOVqrYgIBeVdZrvY/Z7uWWEkrLHpz8C/g4v6A2fFm+fCDgwbyy5tR/VqeaAOgm1h1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337676; c=relaxed/simple;
	bh=i3ZwOtiG0DJRMxuUSa/p4d8MmTTdtm5iN7FMXYe+4EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKni2JyQ2L7T1v7MCsQzCpGi8upq2B/50Lp55J96W9JtjPY9dFVUxoIiUo4qdWb/5gWZ+6N4Pp4mkUWf5JbDEpwSk3zUAKHrMl59fadef2uaSj5XqY+TB8E8tt/BunUYj6TwicAePv234C1ADKkFan9Pvk8rSHbc8qiOrwovWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=RRH9y1FK; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="RRH9y1FK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=VombVeVEGFL3LwEWi5uWJnDV/Y88u6pNgKzx+naWxCk=; b=RRH9y1FKHlID37WPVQWnY49VZy
	Ox8LFsOz0/7ex0L43EOH3FZOOK8UjJx6n/kV+yqPx6BQIIgIvjfrpl8CNU3pg8WJ8ugNPL9RzPM39
	8U46L8zIHcEmVrDZ5hHBTGlAMBMhieTc2HBT7ZUsmMZv1ivBh6yhLGldFUAFshRFVlI3xRd3XoOzg
	DZoAd+AvVOV6ZL/jprFX/8aUy2rb4LPHao9oeVcCBmVl8h1ZyD8lLNxd10u9z9KCBtV3ZXDaoj8nu
	Ac6uNvveSJeHiJda+SX2yP5fApcuVM7EN6mqTGtFADJyXQhWfH0m5s2aqRy+hPLA3hY9h1GQs+A1J
	A8NvgSlg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wp5su-00000002eC8-1HXQ;
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
	Andre Heider <a.heider@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH 4/6] riscv: dts: spacemit: k1-musepi-pro: fix maximum CPU core voltage
Date: Wed, 29 Jul 2026 17:02:21 +0200
Message-ID: <20260729150722.1598630-5-aurelien@aurel32.net>
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

On the MusePi Pro board, the buck1 and buck2 voltage regulators, which
supply the CPU core voltage, are configured with a maximum output
voltage of 3.45V, while the highest operating point requires only
1.050V. This means that a kernel bug, OPP misconfiguration, or
privileged userspace could request a voltage above the safe operating
limit, causing possible permanent CPU damage.

Set the maximum regulator voltage to 1.050V instead.

Fixes: e2dac7c7a3a8 ("riscv: dts: spacemit: k1-musepi-pro: add PMIC and power infrastructure")
Link: https://sashiko.dev/#/message/20260728211020.1248676-2-aurelien%40aurel32.net
Cc: stable@vger.kernel.org
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index 3078ffb5cb878..246f8f2ab62b9 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -180,14 +180,14 @@ pmic@41 {
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

