Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047396;
	b=US12P/otCZ2fomPsA5uStbTTKhziOrMqn+QofbUKoxhmrKkdFlKV3S8VC+X36ZhdZ4wP
	 xnveNl7u/eQhllO0UD7BohWn51uZuVamO1WZcRQCp7DVD7M8D6uRV95t+oZX1HHp2XLmY
	 TsaUgsPLgne4qHWEmJ509CoCTaBLYgOoykMNPnzy/s0KegdWWdg7ofAgy+LZgPL0yvguv
	 sKWtoRnPf35zM00YQyQpET35+DDx7knGt/BsxclYjdyGkj1tncTA0cyja2y1sdgKnn8EB
	 GK0FMFx6QkcTZvuD779VoEkDWnf4AKsxyUL8iSX6ID8NqKkhGtmocFNTmHPsXK2WNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047396;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MX8NxUgeE0PbFMr22k69Oal/DCyEXHp/Q6mHv3u5jrM=;
	b=mWt2XjCfdVSHnrNe7S//IO9kU8HRRwX7OTvl6jP65v8iGdB4INO753XMv5MM4ZJoa/cJ
	 S33wF3XPwkilUfeFokXMBfYk4FdeRMkuCjVCiqBtkovRdxgmTcGowIBGr2LMj1l8jD+b6
	 LJJmdk9uXBoK/E5Ta3UxEAFMCzYi0ayR0hY4+XD0v+43IaOAo4eqkVnVTTRsqtqy0qUzG
	 lpUSxsuw8+tm/7tptLqgFBf0ma522x+Nj94A/9iB7KX2Moc4R1Nq7tdvcLs65a8CFZCDN
	 0z5Oy1uOdCQH7yjVMaSfpnKtgGeuUEsvvKZzeFRDRwbgTSv5/+C3Ua0/Bd0OmIYShKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/36vClz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334EF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/36vClz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917681F008A1;
	Sat,  7 Nov 2026 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047396;
	bh=MX8NxUgeE0PbFMr22k69Oal/DCyEXHp/Q6mHv3u5jrM=;
	h=From:To:Cc:Subject:Date;
	b=m/36vClziAXJpTlDc10+gFyKCdJKD8wjXe7vzr3hFE5gox9n7mJmrA2ILGVsXHGfG
	 sFv8e2AsoSEwahSEIdOJC/DPj/T/NiVQV8D2TWp3QwqKqLsYKG38E+gciedpx2veyf
	 JdvRZrhYLGtu7Z6aX00DyUNrdm5cBBs0wgeo6BRucH6rzLCX2Kw9+U/VmtVAo0En79
	 QvJTK3NHBJLK1NHrc8JMWTU1tSf5SvkH/1UhGkft/GDtJR9qpJ31w10cUH/Igcx3be
	 f3wl7AQWnEvP0FwndIg9BESTrQOlqwTn8tbja0bmDbaetTFfAwaNTRlwS6jq5jRVhC
	 r+VU6XeppSb4A==
From: Sasha Levin <sashal@kernel.org>
To: jm@ti.com,
	m-shah@ti.com,
	nm@ti.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am62-lp-sk: Set eMMC clock pins as OUTPUT" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:54 -0500
Message-ID: <20261107052954-failed-6.6-156f4c2208c8@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 156f4c2208c8e5e04002402494de28c21c0afcbc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052954-failed-6.6-156f4c2208c8@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 156f4c2208c8e5e04002402494de28c21c0afcbc Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Wed, 9 Sep 2026 16:47:34 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62-lp-sk: Set eMMC clock pins as OUTPUT

MMC clock pins must be configured as OUTPUT-only per TRM [0] with
receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
PIN_INPUT to PIN_OUTPUT to match documentation.

[0] https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals

Fixes: e6a51ffabfc1 ("arm64: ti: dts: Add support for AM62x LP SK")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260909214743.899477-7-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index dfd65c00f5b95..7fd508f4eddf1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -86,7 +86,7 @@ main_mmc0_pins_default: main-mmc0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (V3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (Y1) MMC0_CLK */
+			AM62X_IOPAD(0x218, PIN_OUTPUT, 0) /* (Y1) MMC0_CLK */
 			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (V2) MMC0_DAT0 */
 			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (V1) MMC0_DAT1 */
 			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (W2) MMC0_DAT2 */
-- 
2.53.0




