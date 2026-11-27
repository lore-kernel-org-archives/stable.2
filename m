Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788382;
	b=EAXNVLyxrA6RuuV2hbYZO2xhCqovqUcc+VU4fXlvBakWFiKzzzyPVK5nUY6aulc+1tYj
	 a/ZTiXh3fH383quXnDuaZm3rnMDsRLV9ld1bkwJX963YcSo1zqRKeAPqaJqhVAFLBBjy1
	 4om0k4Ti8a86iFJfUUNwNcVNI+OYZMeGbBLUJpM5ev4XtA6puECH+jO3roLVpYH07qaN8
	 VeM7giiulmyj2Oqzgn9XoEeEp28FYibO179dkb5tykJJRqDCZBVXHZg2tV3WWbUNZijrU
	 O/UXEP83FN2/s08nYXFvXTD6SuIG0EoHaMOdzgIIpIurIeyi6XR3ZJuMw7t0/jmMiow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oWPaAbrk1SEcMLu1P1StU6pA1o5GcIUF8D/f2zRIa00=;
	b=hHA2lYPJpmHCxZvEIfzk/zh+t9p/azeoNbq/u093zLCl8zQUVkkeblunOLcwtzFp9YIj
	 7s0cXKY76HiEN3o0b4hCIZaYQvNGsg9UUdmPWaco5slYm1jI7kUEZqQ/c5m0bbkcZ0iVS
	 x0XqqFaPk1Jtgy2TpsuZNhW3Nuq6Aj6s2JZWsG4CN1zQMbrEq8WpTs1T5CLZKlCXWixs7
	 QZxtieSWdaq3rSsvs9braSzOZck+8tHQIKJS9cTSKFg/zOHssF7Hu56aI61CLAoiS2pyw
	 lFZj7zsLbAMr71BdPsGsxb0RSlFtt93pGzNnJvYSOH4IeS9ZdZtN4ljNKaoEJsNXVXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9E90ItZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CE606A334;
	Fri, 27 Nov 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9E90ItZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6F51F000C1;
	Fri, 27 Nov 2026 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788382;
	bh=oWPaAbrk1SEcMLu1P1StU6pA1o5GcIUF8D/f2zRIa00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9E90ItZmIGiWx19nsuvsJNsoVKuLZXeqDT8FdFLzIUeZU4095IWwoNcB1R1xZ51B
	 FPOQAxzwwA0AznuNuRY0BeYH2bWQ+EAgcWngwIqTMkvnovQIStGh/TrcP0GMnFSDfC
	 ildnlU2pOgeOElXR72AOiq9KGbeKCJQ8j8qg/tYf92X49W6V0nYDp9y7NvdX69EiWn
	 lCY8YECsly+vlYjFUDSyYULQPKGV90A8tO5yGoXXeCSgQHzjWpZdzftdLWLERlyDxg
	 XudKQg3Xa6jaE+0wre0YvjaJTJyudHB32eCbOu+rc7b0tbWENOPCeXAhv+V9YLVD+I
	 CSkKKKwcDA3Vg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 02/12] pinctrl: nuvoton: ma35: Prevent out-of-bounds write in ma35_pinctrl_get_soc_data()
Date: Fri, 27 Nov 2026 14:04:50 +0000
Message-ID: <20261127140602.2790001-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

ma35_pinctrl_get_soc_data() allocates ctrl->pin_banks with
ctrl->nr_banks (MA35_GPIO_BANK_MAX) entries and populates them while
iterating over child GPIO controller nodes with
for_each_gpiochip_node().  If the Device Tree contains more than
MA35_GPIO_BANK_MAX GPIO controller child nodes, id exceeds
ctrl->nr_banks and writes past the end of ctrl->pin_banks.

Check that id is within ctrl->nr_banks before indexing ctrl->pin_banks.

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-7f04e7c5-6691-4586-b0f9-392f1285514c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 872769db244b..ddd3f4329f67 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -623,6 +623,12 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
 	}
 
 	for_each_gpiochip_node(&pdev->dev, child) {
+		if (id >= ctrl->nr_banks) {
+			dev_err(&pdev->dev, "Exceeded max GPIO banks (%u)\n",
+				ctrl->nr_banks);
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
 		bank = &ctrl->pin_banks[id];
 		bank->fwnode = child;
 		bank->regmap = pctl->regmap;
-- 
2.56.1.839.g22a8290db9-goog

