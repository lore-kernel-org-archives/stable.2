Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046656;
	b=rKh2U36Y7g3Bwe/Fpnke/Ij/RcA0ziEuSW/lVee5Uc2pSSpskn75Wwrm0sZp2LP4vyVB
	 wJWhI+fVJftaFpICxidExinAlt3EwjYesLmBC/KUU2L+W7ZXyiy++Ojr0bog7t24ScpEH
	 Qz+/R1VheuwPLoR0zJUSDeeZnv8ILx/lYU1j98lXoSVRIkSMt1TI3J4SA9XNykxECYx5n
	 9sK5W0P9OyJdJKYLu3uyLFtJ1LTkzgjgKC6Hy9Ios3+RcgLeAu8Of5m3ApHJzUccyagrO
	 oeawH89bN7ql1SOKILfFXyiSXUX8u6OgIdWkbK3QYDVo4qa/hgCZ4ln7Ntn1DCl/1hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Frr5efz50GPMMeqqrUtg64OTe9g30emJ8SGaYJ2FeCI=;
	b=fwdQ7T29qbhSTsz1H8fgGNoPF91vXL+gwk3SK10jRHmxC9FRg2TtAkjMVr1Nx5c8ATpW
	 wt7qTMtsB2ndL74xJgLUxKizG6IEU4ti6p1b2iIaJD2bjwD9E3CXwy+daQatasznA4Xeu
	 bfw4fhMIKlVGD/ScSeGB8YEiS1mrR5AYgkX0tk6Diw3T5ndje7jJts1qN1mZHJiYYoYgj
	 2A24fP13Tpy0oiYkKUCLZQpRAhLTpkLCRs9Mu9RHLqpiq1kLfNlHLuuWg5XrNfPJd2aBE
	 ugAjj8B0IWVcyJTeBBseRRA/TBvVedFmpPnVFrStFlgNxt01GwF8g5YZCuzwmw7kipw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JX7quBZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43C606A8F0
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JX7quBZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3168D1F0089F;
	Sat,  7 Nov 2026 10:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046655;
	bh=Frr5efz50GPMMeqqrUtg64OTe9g30emJ8SGaYJ2FeCI=;
	h=From:To:Cc:Subject:Date;
	b=JX7quBZlkyaNnLKNTdtwhWx6F3F8fwYJfZv9suf6cN91Iqm3mywOBk1yl0b2uVQLe
	 G4s1Ew8bhYTpUEdpnMwHkQDI5IQ3R5pOwCS1fpcmtd/Avn5N3WkgFDLfLKt+XotHnV
	 8bpDUVqXTe2MX2YNtXcsWiEQeLiaRFj3optTpbLQPLEIP6blr+tHk1QdmskcfUtQ8X
	 dNUNCecEp3Z/9Dn5wwaKywSKL9LFt3N6a/DxsuTLMBviemLXZpHXtslKffLYoeVtji
	 gnFY/cffbdjMEi0gMhZMhhOUNNfmDsdmD5pOq5gn3r6SQ3oMD4o688dCXQuOByqec9
	 QpydcREp05jzw==
From: Sasha Levin <sashal@kernel.org>
To: jm@ti.com,
	m-shah@ti.com,
	nm@ti.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:34 -0500
Message-ID: <20261107051734-failed-6.12-8ef8a0e38d13@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8ef8a0e38d1377c6d51c06f95c64d87641b2c717
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051734-failed-6.12-8ef8a0e38d13@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8ef8a0e38d1377c6d51c06f95c64d87641b2c717 Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Wed, 9 Sep 2026 16:47:38 -0500
Subject: [PATCH] arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as
 OUTPUT

MMC clock pins must be configured as OUTPUT-only per TRM [0] with
receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
PIN_INPUT to PIN_OUTPUT to match documentation.

[0] https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals

Fixes: d19a66ae488a ("arm64: dts: ti: k3-am625-sk: Enable on board peripherals")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260909214743.899477-11-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
index a5922bd746d86..8e07d2c2e62fd 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
@@ -98,7 +98,7 @@ main_mmc0_pins_default: main-mmc0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x218, PIN_OUTPUT, 0) /* (AB1) MMC0_CLK */
 			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
 			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
 			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
-- 
2.53.0




