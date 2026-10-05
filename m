Received: from mail.haxxors.com (mail.haxxors.com [85.14.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F848989D;
	Mon,  5 Oct 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.14.200.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206981; cv=none; b=ZFyTm9ST9um4y8XH64WBvrGpabOFO6v/M28GS8ncx2Fu5Bqz8eLtw0XTWkE003Q0/IU6o8nbcp0WuY4IKzM6+EsLZRO0bdZSpK5Rh6JOUf0S2OzqTh9xvd1jGTDufHhOkbSiAslOIoFLVmfoWi41UFvGzk4Q7mq9BgQrxhIi0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206981; c=relaxed/simple;
	bh=cUk6hleFdTXonVJwfenNDEbW9WoUZ0doBHdHP/ROhaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQacii2/uzdRFGmcgw0Id/bilU1FJtqtm/4b+0jsrQWv+Sn2WhcgLlaz0KkZhWY4sbWZkCTy3OW3Q7gvtxBT0RvUpH8LsY+1dEbgfPJnVq/e/DHpOzYgqTw0eITkiDuCcW0snMMhFUTZC6RYoprMZb+YYK6CARKdUHKc5/zxq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me; spf=pass smtp.mailfrom=buechner.me; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=bLS5NlJ/; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=dnxVhqSi; arc=none smtp.client-ip=85.14.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buechner.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="bLS5NlJ/";
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="dnxVhqSi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791206367; bh=cUk6hleFdTXonVJwfenNDEbW9WoUZ0doBHdHP/ROhaY=;
	h=From:To:Cc:Subject:Date:From;
	b=bLS5NlJ/bi+nBz0Mv1zcrkBKhij34z6FyPnn3o66uBgwOTuacYzijng67QjPCd47t
	 vBTffegyWKV+f5QOLBSJagL4JnX9SkCVrxZkcPxRkLHGQ4MKSZLapC07mMG0EpZ5c3
	 sKbgPQBM6dP+w0TdZZAv3+KETUYBmqrySc3XtthA=
Received: from localhost (localhost [127.0.0.1])
	by mail.haxxors.com (Postfix) with ESMTP id 71647515F0;
	Mon, 05 Oct 2026 15:19:27 +0200 (CEST)
X-Virus-Scanned: Debian amavis at mail.haxxors.com
Received: from mail.haxxors.com ([127.0.0.1])
 by localhost (mail.haxxors.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_R2qTLR8hRm; Mon,  5 Oct 2026 15:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791206365; bh=cUk6hleFdTXonVJwfenNDEbW9WoUZ0doBHdHP/ROhaY=;
	h=From:To:Cc:Subject:Date:From;
	b=dnxVhqSidQ3/E788YaD5mDIaQPJcROYgs7/t9niKEEiPSWZ3kt5pPZ2V3V7leoC9H
	 q5IQJBx5zSoJVApF9A6oA8g2Aea/PqTFqcv4WISFCz6dkBhaEhuvUM0Guj/UfV7nx8
	 06rraQQkPrXU9RsOpYwTz91J8wblqvKRLS4+vHXY=
Received: from esports.myloc.de (p200300ee8f09a300264bfefffe4ffb4b.dip0.t-ipconnect.de [IPv6:2003:ee:8f09:a300:264b:feff:fe4f:fb4b])
	(Authenticated sender: nils@buechner.me)
	by mail.haxxors.com (Postfix) with ESMTPSA id 8178A51670;
	Mon, 05 Oct 2026 15:19:25 +0200 (CEST)
From: =?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
To: Ulf Hansson <ulfh@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>,
	stable@vger.kernel.org
Subject: [PATCH] pmdomain: mediatek: mt8183: Fix silent audio from premature sync_state
Date: Mon,  5 Oct 2026 15:19:23 +0200
Message-ID: <20261005131923.291619-1-nils@buechner.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until
sync_state") made genpd trust that a power domain already on at probe
time is correctly, fully initialized, and stopped forcing a real
power-off/power-on cycle for it until the devicetree provider's
sync_state() callback fires.

On the Juniper board (Acer Chromebook Spin 311, MT8183), the firmware
leaves the audio power domain in exactly this misleading state: genpd
reports it as on, so this new behavior never runs the real hardware
sequencing in scpsys_power_on() that clears the domain's AXI bus
protection. Register access to the AFE block over APB keeps working
normally, giving no obvious sign anything is wrong, but the memif DMA
engine's own bus transactions silently never complete: its current-
position register stays frozen at the value it was reset to, the
period-elapsed interrupt is never raised, and ALSA playback fails with
-EIO. The net effect is silent internal speakers on every boot.

This is the same class of problem already fixed for the MFG/GPU
domains in commit 818d56ac1d ("pmdomain: mediatek: Fix mt8183 hang on
boot"), which does not cover the audio domain. Apply the identical,
already-reviewed fix here: MTK_SCPD_KEEP_DEFAULT_OFF makes genpd start
the domain in GENPD_STATE_OFF instead of trusting the bootloader's
"on" state, so the AFE driver's own first pm_runtime resume triggers a
genuine power-on transition and actually runs the bus-protection
clear.

Root-caused with a git bisect across released kernel versions on real
Juniper hardware (audio works on v6.6, fails from v6.16 onward),
narrowing the regression down to this exact commit, and confirmed
fixed with speaker-test playback after applying this change.

Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Cc: stable@vger.kernel.org
Signed-off-by: Nils Büchner <nils@buechner.me>
---
 drivers/pmdomain/mediatek/mt8183-pm-domains.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
index 5e33b8628..8e29e5117 100644
--- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
@@ -22,6 +22,15 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
+		/*
+		 * Depending on firmware, the audio domain may be left
+		 * partially on at boot, with genpd detecting it as on when
+		 * it isn't fully initialized. Force a real off/on cycle
+		 * instead of trusting that state, same as the MFG domains
+		 * in commit 818d56ac1d ("pmdomain: mediatek: Fix mt8183
+		 * hang on boot").
+		 */
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8183_POWER_DOMAIN_CONN] = {
 		.name = "conn",
-- 
2.53.0

