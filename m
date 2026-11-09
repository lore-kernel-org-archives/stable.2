Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.33.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235851;
	b=ArCuArotAkNzWMSuixNn9LNdQPetfg7I8dHBWcgY9HamJHRikPIZuVQKmaunWu96VFw5
	 Tp7lSHzsVxzzF1aFq1E4ejbarggybSm+v01yXy5hHWX6I9LaVfrY9ut5T+H46y+nq5r1j
	 PPtJcijmXgKbAqLZb7qgtvG34Xbgbkt9iXuTaYBDA+ev6k5amKAroi5wIX2gWviQcvWuI
	 ik4hJhiziqZg/QnIWUWi0402V+ClwTk+qB1pHJjb1nEFSxujptUCvvI4qsiaT/BMnUCZL
	 Iy6tJeXmYlp0r8/wbMXgcyra8Cukc75H81q3DzaO7xF9VzGJuMCSDCHibnHL/iL37Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235851;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cXbJk2INOtDbIQpp5ZPiMsPF5rN/iKWVctoi+2geGYo=;
	b=Qo3KoC5JKxUY1mjmmftGY7ow5NS/c9872EUvkYond1KsRERR6Lt2zKYMPWDjiNsxJxCd
	 dOQJzHuC53tojqELZPAqHEhO7UHKpYkq8hQD94Gj50bXe9kftXRytlIneJ1OK+911gm+X
	 fyCi222mR8AYH9wUnI6pL1zv9OSSmbQ4QAgXbPhve1PSVvsFuU6SZcm5oCKIMmT25F14r
	 2BI25NjQAvMILm5rjxtm3198lEQMKdf5BVOrkrHlrTtpdZkd+GuD3CCFe3Nb3GHZmjsAv
	 E/FsyjJf8hwqVN69pivxYjhLx13MU+ngpPly1QV4R9KngzZnBJM9zf3eG/yg4aBY38Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=picomail.one;
	spf=pass smtp.mailfrom=picomail.one;
	dkim=pass header.d=picomail.one header.i=@picomail.one header.a=rsa-sha256 header.s=mail header.b=gHpbuhBN;
	arc=none smtp.remote-ip=193.33.167.51
Received: from mail.picomail.one (mail.picomail.one [193.33.167.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F244606A31C;
	Mon,  9 Nov 2026 14:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F244606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picomail.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picomail.one
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=picomail.one header.i=@picomail.one header.a=rsa-sha256 header.s=mail header.b=gHpbuhBN
From: Jonathan Schmid <kernel@picomail.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=picomail.one;
	s=mail; t=1794235843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cXbJk2INOtDbIQpp5ZPiMsPF5rN/iKWVctoi+2geGYo=;
	b=gHpbuhBNgY/RTmYVoFBqFHZ+iIeeulOWb/8hr/zhuVyid+3RigOTD/xGsnBu6M+YXy3+8y
	4U+YjLn5S2JxWWrHuPDZFD5+YuxQL+5nNLaUWm7mv2Ao2jDlPcGGzdL1uGkZRCaMlmMz8M
	D5XZm7Y6lMnTc/vs4CjR8r0KGdhNP9TsAdErFZWcR/rttC4VtdAPN1/Rdhyuz9UWdqhMkP
	SvLihVgkBvwRpgsZHJBPUFIK0aZCdt8EDshpPOJMtPrhCYewJFIMXn3bzgbS2zazTJa7Bf
	vBoZT0ZHYXyZJHqQKkZe28SEd4SiMLQ1p13r9M9P/5/eALWbKJ/pEiq8z4uE/w==
To: Heiko Stuebner <heiko@sntech.de>
Cc: Detlev Casanova <detlev.casanova@collabora.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Schmid <kernel@picomail.one>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Pull down the eMMC data strobe on RK3576
Date: Mon,  9 Nov 2026 15:50:22 +0100
Message-ID: <20261109145022.75261-1-kernel@picomail.one>
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

The eMMC data strobe (DS) is only driven by the card while it sends data
or the CRC status token; in between, the card releases the line. RK3576
configures emmc_strb with pcfg_pull_none, so DS floats between
transfers.

In HS400 the host samples the CRC status token that follows each written
block with DS. With the floating line it misreads the token now and
then: the write ends with a data CRC error and is retried. Nothing is
logged and the data ends up intact, but the errors show up in the
controller's err_stats in debugfs, and write throughput drops.

On a board with RK3576S and a 64 GB eMMC 5.1 in HS400 enhanced strobe
mode at 200 MHz, mainline shows about one data CRC error per 16 MiB
written (1123 over 18 GiB) and writes at about 50 MB/s. Changing only
the strobe pin from pull-none to pull-down at runtime gives 0 errors
over 15 GiB written and about 176 MB/s; the drive strength and the pull
of the clock pin made no difference.

Pull-down is the reset value of the pad, which the vendor kernel keeps
(its eMMC node has no pinctrl), and RK3588 already uses pcfg_pull_down
for its eMMC data strobe.

Fixes: 57b1ce903966 ("arm64: dts: rockchip: Add rk3576 SoC base DT")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Schmid <kernel@picomail.one>
---
 arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
index 98c9f8013..2ce5e1bfd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
@@ -613,7 +613,7 @@ emmc_cmd: emmc-cmd {
 		emmc_strb: emmc-strb {
 			rockchip,pins =
 				/* emmc_strb */
-				<1 RK_PB2 1 &pcfg_pull_none>;
+				<1 RK_PB2 1 &pcfg_pull_down>;
 		};
 	};
 
-- 
2.55.0

