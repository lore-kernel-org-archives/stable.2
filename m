Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656F3CA499;
	Fri,  9 Oct 2026 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585557; cv=none; b=nBUMaCPn8kloctQhpFXNVrZAxQUSzZbBtmBNLVjkwLB3BSCJvINVNDpYD8slMF6dXz0OlQb2vFPi5NCUFOqC0TxP0Wlcccm/JnzJAAObaQJkc15QMdEtFjVFpNB641ZLgyUjIe2/XEAb6GL07i3P4NEnNQZlXhtdTcTTZDmPBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585557; c=relaxed/simple;
	bh=KWpQFquq7avx1bUklcWT3BnzeA5u9h49N5vuVBzTD3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tsRzWw47Z01jG6J8qvQaTG72IVq39BGr+VSFED5Nb88YKadumJRLqOEqWrB5HQshkhVhVibyFCFU6jrYw8vg1+OQa3XpL7nmxZVdn0hOG+ayyOu6lQj8bFWj2ZmbDyaz7GFXug+wZLEOi2BMGY7IaBvh9Ln83ZYVuTACDlnBMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUeJCHz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUeJCHz8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B41E5C2BCF4;
	Fri,  9 Oct 2026 22:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791585556;
	bh=KWpQFquq7avx1bUklcWT3BnzeA5u9h49N5vuVBzTD3k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GUeJCHz8iwxZtfLlgszI6BlYxL/MqgIC/DQ098sJ5RC1afr9zUMkk1uD1OMLuduzp
	 UJCmdnbgRY7rfo76x3fha8xm4hJzz4T4RQx9+g9ObSTmeq9xkunStQHUUjq7Q7B5+t
	 swFfi3Cni8TDsaOdpA7nTIvjmsgpVdLGp9CErnPCgLU+9wAoIxSp0pPELUCwzYEESO
	 EViwsk9ssccI33MhB3+exEx8lM8M2ugCSmFnOeyxrxB3wUcOD3YPtzLX3qaQmNhjMn
	 7qE3m1kzpjhsj4XPBLP0iGfYGVJhiZ9YrtpF7fChBgOyChmL3eW4McsdxwZjByrBwp
	 UqmeHld5Pw3Sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E54ECA601E;
	Fri,  9 Oct 2026 22:39:16 +0000 (UTC)
From: Kim Wooseok via B4 Relay <devnull+5mghybrid.khu.ac.kr@kernel.org>
Subject: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
Date: Sat, 10 Oct 2026 07:39:15 +0900
Message-Id: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2MwQ7CIBBEf6XZs5tAQ1r1V4wHoFuLUTS7oCRN/
 13QxOPMvHkrCHEggWO3AtMrSHjEGvSuA7/YeCEMU83Qq37QSivkdNuXUjJmcTjdLfqDmc04kFZ
 mhHp7Ms2hfJUn4PTGSCXB+bdIdlfyqRkb66wQOrbRL63609v2AbDrgCuZAAAA
X-Change-ID: 20261010-rtl8xxxu-usb-dma-c94f476e1047
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, 
 Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kim Wooseok <5mghybrid@khu.ac.kr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791585555; l=1272;
 i=5mghybrid@khu.ac.kr; s=kernel-20260913; h=from:subject:message-id;
 bh=KWpQFquq7avx1bUklcWT3BnzeA5u9h49N5vuVBzTD3k=;
 b=YCKDuTM5arzlyP5KChB/r3Xqskn7TypP3HRG1TFZaZUbljeb1n2LZ79C27gogbLTxln71VstU
 HvTbYg4enNeDdWP8kN2+SqY1cfmMUtdjCJgpRfVMTA0NcnizT/goeO1
X-Developer-Key: i=5mghybrid@khu.ac.kr; a=ed25519;
 pk=1az/6lC8Tmd6BcvyarPc8FWoSxsV/WRr5NLs1v+kjlE=
X-Endpoint-Received: by B4 Relay for 5mghybrid@khu.ac.kr/kernel-20260913
 with auth_id=1028
X-Original-From: Kim Wooseok <5mghybrid@khu.ac.kr>
Reply-To: 5mghybrid@khu.ac.kr

I encountered reconnect failures on four Raspberry Pis in my project.
While investigating the failure on a Raspberry Pi 5 after an AP power
cycle, I found that RF_MODE had been corrupted. Restoring its initialized
value restored reception without reloading the driver.

The USB register buffer shared a cache line with CPU-written mutex state.
This patch allocates the buffer separately while keeping the existing
register access and locking.

I tested the separate-buffer approach on the Pi's Linux 6.18.34 kernel.
During repeated scan requests, wireless ping traffic kept receiving
replies and the RF_MODE and HSSI values stayed stable. I also built the
submission's rtl8xxxu driver for ARM64 with W=1; sparse reported no
diagnostics in core.c.

Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>

---
Kim Wooseok (1):
      wifi: rtl8xxxu: isolate the USB register buffer from CPU state

 drivers/net/wireless/realtek/rtl8xxxu/core.c     | 35 ++++++++++++++++--------
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h |  2 +-
 2 files changed, 24 insertions(+), 13 deletions(-)
---
base-commit: 83de3a16c7b37064a59305040ba9b0f93b832794
change-id: 20261010-rtl8xxxu-usb-dma-c94f476e1047

Best regards,
--  
Kim Wooseok <5mghybrid@khu.ac.kr>


