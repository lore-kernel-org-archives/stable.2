Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311362;
	b=rjGW9xiYupnZNs6ycrSD0JRKolqi+kQHwD4w9mHL4C3TkfH2v+3IMdqM5RL0ahJjEmDm
	 827camCnmUnRFAIZwiGQH4Vof2QDkXqcKjqPO60BpjwD7I1tz6nBbmLWPLm+ACnK3cVMd
	 JGWNxENy9NsJsE7ha0R74o0bkl7+wCbshvILmd5Bivxx0XUutGRy8BQBInVlvkIzgH8+E
	 9lYUO7I5EVX2YJ2QLHxPZNaQQsPn8sABUifgxo5KowpqkmBhg5hG8OITj+ydT3OV5CQQC
	 UjgQElGOkyozRjlNQ2szcQki5SMATul3u7BplFdSUuYzC/fbW4k2hOxoxT12bI3V1BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5haJ5/4S92KyFwUjS0+km4PJryl2u4aBmk9VaVaPOkg=;
	b=ZUTfKskPw1FjnU2Kbu2UM7WqP1vuiE5kaE8wr6UnhASrm1ULndG1iUJYPChxp0sbzEQi
	 j8fWraTZAUUbIQexFJVaGzfg9EnBz5ziK5RW79eoAf85V/DhBDDTkLbpNmQS0up+St+7N
	 8kf9gUoqSq6pA0tuS05Ymaz9jH/UibdWyd5BUyDVcCZyDa86cEo1QdGuxTJL2ETn+LP9Y
	 AZ0fvi91eTcVt53eke+UGfUYTZ1IorponZp2lTVjSjA+CKoDS4pS5iNY2HJ86wORzulxe
	 Vo9iuV6QGM1SEjTQoQ7y033WWwo7Ozl5tSER5fwLD/jIG9ANaC/74v3YkDS+tSbdchA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtDZVtrg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D8606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtDZVtrg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC061F0089F;
	Tue, 10 Nov 2026 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311362;
	bh=5haJ5/4S92KyFwUjS0+km4PJryl2u4aBmk9VaVaPOkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtDZVtrgOKnnvfBebmQNeVmBFu4RjMUU/9oP370hNKc7SsKYy8rFfIq7/7IvwrAog
	 l59Cw3VgWeNFPm4QMIctvr1l94tzlFQtm4g6S1WE/CPRU7dNzw8y6pUKSZncFZZjJQ
	 X5D/3n0EbZaWn/A4x9u3geSgkDr7YTB6Ic4I6L4H+B2qzh5p3epnW+cMeP4mVMIYAj
	 UiYTq1//ggFv8reXfOSC/6QWs32bqTH+iWirebkHwSDgJau5JNJ4LmI6nzXvfWI1qC
	 hEjKBHItVJDj7dDLhMOzu5IoxZtgaKp8UrBbOy9v0dbPJ42Y/HVdCmRq5q9ZHqBHvi
	 XKjF25VVkBH4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Moteen Shah <m-shah@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: dts: ti: k3-am62x-sk-common: Set SD clock pin as OUTPUT
Date: Tue, 10 Nov 2026 06:49:20 -0500
Message-ID: <20261110114907.605693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054240-failed-6.1-1e2e5016bda9@kernel.org>
References: <20261107054240-failed-6.1-1e2e5016bda9@kernel.org>
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

From: Judith Mendez <jm@ti.com>

[ Upstream commit 1e2e5016bda94b2bcd86258b5eb77fe3006639a0 ]

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
[ sashal: applied the change to the existing MMC1 pin group in the board device tree because the shared include is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 93a5f0817efc4..4754314bc7211 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -192,7 +192,7 @@ AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
 	main_mmc1_pins_default: main-mmc1-pins-default {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
-			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22) MMC1_CLK */
+			AM62X_IOPAD(0x234, PIN_OUTPUT, 0) /* (B22) MMC1_CLK */
 			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22) MMC1_DAT0 */
 			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21) MMC1_DAT1 */
 			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21) MMC1_DAT2 */
-- 
2.53.0

