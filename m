Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876853C1F41;
	Mon, 31 Aug 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173494; cv=none; b=sQP/WN0shAwDiEpGy+L9otvWyBtf9Uhm9LYLaoK8fC2yiHMXRoW0dlUacU9IHUtET9kzmv81epP2NdupIFut3HtTICCUzatMjPWkmkarsgOarBM0i6+p6VBEF4ru3UdAHlbQvrdmPp++5HDo8OvovPOm0F2ytpia981HafS2ZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173494; c=relaxed/simple;
	bh=5KgSygfc60Vc+faLJo1AGvihW9k7uqGpPOlyPBVQiQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqQtO66ST2nBPVd7tDP1nra6emAx6A6DYAOsNdpR5GPflsTbCSu48zo4rxlRrEQJHGdOEGutCZmYF3+X7Nt2CCAPtBmlx23UtObo/J4+g6shqFXpgiv3apsVYjrCMxIzzk4gsLA62fAC6j73ZhIwRkgrGAFxxg/J1vGTEz8vM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbJy2JmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbJy2JmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D851F000E9;
	Mon, 31 Aug 2026 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173492;
	bh=/83joiCqy3bsVNmIOD4slIc2iG9I+Ggc1WrYrebcBzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbJy2JmTMoekm2chm/lqgQMBIX0OUqgcusqVxPZlbfPU12hTQaZNB8OtIV6Eb5UUK
	 M6Ckd6IOGgMLCIqF3h7mVtIvns2sFN0pNStQaKuKi0ehLjgGwO1mCpYEPWwp869hUF
	 IHUjmPPG8D8k32DR0rzimyflarjOTt4iiyEi2njGtkSDSzGAhcJ35CxNzXKfOlLe4T
	 T6tE98wN/wRDqwOeUaeBd9zqqj0GcEZehKPlMLHuJ0ay/KPUTYrrusXXv6QkQ+JZSl
	 s1gFwAAD6esAjztlZtQYQ1FxLpclZiQ152KHPwlF+EMobBr3n5Ec6FqcX5RPTQin62
	 EdfntawphHOMA==
From: Conor Dooley <conor@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH v1 2/3] pinctrl: mpfs-mssio: fix width of unused bank voltage setting
Date: Mon, 31 Aug 2026 11:50:58 +0100
Message-ID: <20260831105056.756259-7-conor@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831105056.756259-5-conor@kernel.org>
References: <20260831105056.756259-5-conor@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=conor.dooley@microchip.com; h=from:subject; bh=ef5QyPGGJU2n0wuvE12uE0SJbu4v0TW83f9BsxA1PHM=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDFlTY1bM/5H9KvvpciHjyzcyD2zaF6WycTKHYWyN37HLU svfBhTM7ShlYRDjYpAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEThQyMpw13dK4m2dap+WD 7m+Ch9YfaXex198kqH/8Z3deisf0yFuMDMvvaJ/6JTtvuvoSe1cN/3N981xO7rLZw63CExty7NS qAH4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The bank voltages are only 4 bits wide, so when a pin was unused the
driver was not correctly interpreting it as being at zero volts, because
the driver's value for unused had two extra set bits.

CC: stable@vger.kernel.org
Fixes: 488d704ed7b7 ("pinctrl: add polarfire soc mssio pinctrl driver")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c b/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c
index 502624221aca..9e6d233804cb 100644
--- a/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c
+++ b/drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c
@@ -86,7 +86,7 @@ static struct mpfs_pinctrl_bank_voltage mpfs_pinctrl_bank_voltages[8] = {
 	{ .uv = 1800000, .val = 4 },
 	{ .uv = 2500000, .val = 6 },
 	{ .uv = 3300000, .val = 8 },
-	{ .uv = 0, .val = 0x3f }, // pin unused
+	{ .uv = 0, .val = 0xf }, // pin unused
 };
 
 static int mpfs_pinctrl_get_drive_strength_ma(u32 drive_strength)
-- 
2.53.0

