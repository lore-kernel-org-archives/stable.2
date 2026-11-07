Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048162;
	b=mIe4wvL0nDz69kXFMwXj1LXQ6BFrzF49nybiR/Bdf5p/LOQ7hS+vovASy120y36Ffc+x
	 Oz908XU+A3sqpXmpQmyq2AXuQZI3Lf14HVBfnMvH2Pzllqi9fDCxKnXw74UhgUa7ymDaL
	 5sp5t+vtMQXIHsUsYg2s8hHz+ps+cHzYQLCO/zhC1LMWO72YQokyOgup+jPUR4a89Pr07
	 NErnsQFNho6pYzkFjrC+qhASx2nwGun2PmIlxol6VYaO0trEw4NWXgIdRxbViEwR0adQW
	 wnHatNcSgMtvgzt5C+682NCrGIhJxblxYGTHTlSdC3i9YOhTUoMWMhI2o7hzQFUzi1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048162;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MO4KvV6mFuD1xEnABqf5XKNbY1tYZcgG64kCYn7uCX4=;
	b=zlqJyvy/mpy7+Hx4Wg//TIsqvUslQwlCrGUlPKkWniO3EMOtuQqJThkM9l8ZL88hgW6C
	 6Kcs5xfDvCOgBXM/EJz2/q8r7aLFExZhVeQEzzMRUjlYg6P1ox9EBPeqLzaHnPMP/D7nt
	 nkplmc/ZuW4Gem2ij76PLdaAG//Ykg4FntAXHNzkIssw30piK3z7QDTgO+WhTW2Op0fSt
	 NvhBsE/Gt1I/qp7dNvyS22D+qL40gaPXeExOZkugLbXJ2FrCO5VBpQe5FEBqqTULiJxy+
	 kDgn+eOJoZV05Ja2ChKru6lyMxsEszQJr9vPFoDYoOF9L/HAasJb9mxp+O9NfhLzP8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh6EbdnF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh6EbdnF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B42B1F0089F;
	Sat,  7 Nov 2026 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048161;
	bh=MO4KvV6mFuD1xEnABqf5XKNbY1tYZcgG64kCYn7uCX4=;
	h=From:To:Cc:Subject:Date;
	b=Wh6EbdnFwp0rDV0PO0ha8MHbXzgFPZam0uvCjtEoH2rFujxN3NWifdcfeUR87ZExz
	 e+8y1yKnHAgc6ZRhsHU0KS59DTf1lfqlS/1DRbsmEke6kR8bQepMOKyf5wSsLdLY+k
	 tlDVsAV7qTRPFJLFsIbIV5hWaz6t8NaNpsYTB2jiNS7MBw0ZIFU1JfnX2BYGY3GS3J
	 ME8+TbZYLwdhH00tj3trHSMaE/Diz63Ui8DwFUyMt3qNNZkA4PVa67utXLeZFch269
	 tzGJl45XDTbG3+qEDkaOqHTTjL39jOqaoplaiyRupYEYX92PTv22Tdchn2uSfHi1Eo
	 CAOQro6ykXvGw==
From: Sasha Levin <sashal@kernel.org>
To: jm@ti.com,
	m-shah@ti.com,
	nm@ti.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am62x-sk-common: Set SD clock pin as OUTPUT" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:40 -0500
Message-ID: <20261107054240-failed-6.1-1e2e5016bda9@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1e2e5016bda94b2bcd86258b5eb77fe3006639a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054240-failed-6.1-1e2e5016bda9@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1e2e5016bda94b2bcd86258b5eb77fe3006639a0 Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Wed, 9 Sep 2026 16:47:37 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Set SD clock pin as
 OUTPUT

MMC clock pins must be configured as OUTPUT-only per TRM [0] with
receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
PIN_INPUT to PIN_OUTPUT to match documentation.

[0] https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals

Fixes: d19a66ae488a ("arm64: dts: ti: k3-am625-sk: Enable on board peripherals")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260909214743.899477-10-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index ab9e58c2d225e..d2f41e2ed6239 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -194,7 +194,7 @@ main_mmc1_pins_default: main-mmc1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21/C18) MMC1_CMD */
-			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22/A20) MMC1_CLK */
+			AM62X_IOPAD(0x234, PIN_OUTPUT, 0) /* (B22/A20) MMC1_CLK */
 			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22/A19) MMC1_DAT0 */
 			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21/B19) MMC1_DAT1 */
 			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21/B20) MMC1_DAT2 */
-- 
2.53.0




