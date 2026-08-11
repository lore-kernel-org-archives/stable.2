Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610624334C3;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491013; cv=none; b=tXQozspsTQwQE/4KSngTz1jXqntMwlt3Xf3Tp9blgbJdayIbvkAF4/qyEet/M8gFLj7+geDMNgdpTKV1yDSPJecYB2k+qas9XHNJJBQic87AqRavPrHrjNcBiK6lqI3UXxjhrrj5JI0g2ltyNlAbrXSEeJ0AKjoJOkJUV90YIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491013; c=relaxed/simple;
	bh=qv1nbnQj5yoUuqvBAtie8PCjm4uOhcMDB/ozlhiCEnI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cspQ6zt33XlzE7Fi8Y9itl+oyQE0oxs9U5FOS78weQ9kgYir1MLLOxP9Ofxy7d/GKEEDW5J5jp5pUugNZYyhZ383YyF140pfP+capxvuQCCKSP0dv6hi/OKSproXBmXiwU7H+KTk2g49BxbjDw2Gmm2YgZ4L6OY74F/BdPBq4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA+fLs79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA+fLs79"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A36C2BCC7;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786491013;
	bh=qv1nbnQj5yoUuqvBAtie8PCjm4uOhcMDB/ozlhiCEnI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LA+fLs79sMwO3/BfSIEypVA4EWzEoJVef6ynFAK9DEY/3UEZeQRoTVJ+5N9nJ1BHp
	 OaA32QMf7YNB0SjAOfADHpFjla38tdXYfVoTSHTGdZPiarmmC5/P1I8lFY3vqJ1Zhh
	 TQMi1OvDMW57dWv/3W1aI/bj+0pkReJib0UNa930qhhPpkjuZwpSNxlnvbH2We/Vvz
	 IyszL2iFUmtRPRJuhh8yAIiKoqdcF7HmdkmrVgs4CMFAyM9loL5JBDlLzhWkXO1kS8
	 Gfrq/qR+Xiumr8b1FhIPM7scZfl9ua/fF7vqAsKnxwwqyiOInOSfib+Qx840JS33+L
	 VxF7Odb9qPCzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E463DC5B56A;
	Tue, 11 Aug 2026 23:30:12 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Subject: [PATCH 0/5] power: supply: qcom_smbx: fix watchdog and battery
 properties
Date: Wed, 12 Aug 2026 01:29:57 +0200
Message-Id: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LMQqAMAxA0atIZgO2iqhXEQeNUTO01QZEKN7d4
 vj4/ATKUVhhKBJEvkUl+AxTFkDH7HdGWbPBVratOmPxouBQ3fLgJg8rNmTnxbQ1UU+QrzPyH/I
 0Tu/7AamrjhxhAAAA
X-Change-ID: 20260812-qcom-smbx-fixes-4c2ab163cc9c
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786491008; l=2069;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=qv1nbnQj5yoUuqvBAtie8PCjm4uOhcMDB/ozlhiCEnI=;
 b=GxwMvT7WZEjD0iuci8XI4SkTBX064+9afDqfQqrUj0PKAY84eYnyrbGM/7ekyZ8uDD+h8h2mQ
 LL/Klww2FVoApy8bGPGhz17PqYWs3Ef0qQlsbISz+i0AVuZBLhhjNET
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

Fix five bugs in the existing Qualcomm SMB2 charger driver.

The watchdog bark handler omits the charger peripheral base and can write
an unrelated SPMI register. Battery health handling compares the complete
status register instead of testing its independent fault bits. The
float-voltage calculation is one selector step too high, and its battery
target is neither selected nor validated safely. Finally, the
battery-overvoltage IRQ ignores read errors and only publishes assertion,
leaving health and status stale after the falling-edge recovery interrupt.

The float-voltage validation patch prefers the constant-charge target,
falls back to the design voltage, and preserves the firmware setting when
both optional properties are absent. It also restores the pre-probe
charging-enable state if hardware initialization or any later probe step
fails, preventing probe failure from changing that state.

All five issues were introduced with the driver. The patches carry the
same Fixes tag and are marked for stable.

This series is also the declared prerequisite for the SMB5 v2 series,
whose driver refactoring overlaps the health, overvoltage and
float-voltage code.

The driver builds with LLVM W=1 and passes sparse without driver
warnings. All five patches pass checkpatch --strict.

Based on linux-next 20260811 (5e6de6a2b522).

Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
Robin Snyders (5):
      power: supply: qcom_smbx: include base when petting watchdog
      power: supply: qcom_smbx: test battery health status bits
      power: supply: qcom_smbx: fix float voltage selector
      power: supply: qcom_smbx: validate battery float voltage
      power: supply: qcom_smbx: notify battery overvoltage recovery

 drivers/power/supply/qcom_smbx.c | 98 ++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 20 deletions(-)
---
base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
change-id: 20260812-qcom-smbx-fixes-4c2ab163cc9c

Best regards,
-- 
Robin Snyders <robin@snyders.xyz>


