Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3243D5643;
	Mon, 31 Aug 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217866; cv=none; b=ixgkmIxGXweUyJC1PBsdbxxTm6GMb+Ff+l99iH6jaJjG45S8eqZN0NLHBn05T6+2v7ys2HZFqMra9/gw25Ud0hsdvXwVHahfsMacvZWjOdv+yY8q9pVbUI/GINI/fG7WG6cbwdjl39BzWjsXGj7ZvSToDjF88fXbOZv9jXtZNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217866; c=relaxed/simple;
	bh=Cgi+PuH8fpF/E86LURJkIWcj+xAi33bOqdSOZNwctBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2K8nUplpe2GFqGXIdLJ//1/v9CJtlQpVI5F8YSDK6g4zNzQFUazpXmVs8FEaBeAAKGXKcN6QE0EcAeCgPeqCUqokskOeZVCusvlC+whH9z4BQyX0r3bJDbFy5fdWcEr4ClRyE66NQv09zpGw9b9758oWFHpHb9MjSAlJP56TmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiT6zwvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiT6zwvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA811F000E9;
	Mon, 31 Aug 2026 23:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217864;
	bh=BxHBa71pQu6m1KdWl061ysdWcdXi2KJYuPj2/dIm3CQ=;
	h=From:To:Cc:Subject:Date;
	b=BiT6zwvKLdxnJzvjg8cRgAATaWr2NJCwz5iTmtHF0iWVrtUYYMc9h3HHFKEaHX4G9
	 KHvFHvFY67r3Px+huf48bUXuWcYP5GIxxSuX5eNTiNMpA015N1T96W/xDLYXcSjOXX
	 9kwHVRVV82sjRYiCSFfCyxWsiMe7JcG1c7G0A+L8mH1NkAZVasUP4/jo/m/Psu1tYO
	 WD4aQ7HY5HQhUFNQOQeJsG3qg1P9+uVjuspZKgLE5uWuPRTp3mw9qktblJoWLJ8GZ5
	 yc2NDDWyz3XhCZ30hfXLt7gcYPLSsgCsEEH7ys9ktmyV7/Kk9ZPRBcLSnIE4CbHUmD
	 v22PIqNygCyow==
From: Dinh Nguyen <dinguyen@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dinguyen@kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: socfpga: change access permission from 755 to 644
Date: Mon, 31 Aug 2026 18:10:49 -0500
Message-ID: <20260831231049.395283-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These files have an incorrect access permission of 755 instead of 644.
Change them to the correct access permission of 644.

Fixes: 4bc04eb90b7c ("arm64: dts: socfpga: stratix10: Add emmc support")
Cc: <stable@vger.kernel.org> # v7.1+
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtsi     | 0
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtsi
 mode change 100755 => 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtsi
old mode 100755
new mode 100644
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_emmc.dts
old mode 100755
new mode 100644
-- 
2.42.0.411.g813d9a9188

