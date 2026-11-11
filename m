Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433998;
	b=gOmhY9zAbWQXtMRA5/MxQNoi/ei2pq93Y9+RA6aJtCU2/nYMLjSH3kLtnMFMbKULFcL/
	 Eneqk9dw/sVxreIKr1ZrpI2jc5iVG3Ixs+wudnzb00Op7iOkHJWagwWuafpkMd16doLSV
	 P/dvQHNTGv1IzbJY93auc5Fw0J0MjvluM+nOeOc0Rms74tvdCNyuUqGgfB17ZIOGZphpw
	 SPMSW1pWDyGzeihGF6e3xGQnuDOccbNuflwvUrwQ5BFggkuXEl2F227nol3emcNxq8WSP
	 VAslETWdvS29tGsK149OUAa794Bl4R5jf7/exDV5uSMdRnRWDPmxNHWVgIs144OxKNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OgsIQxLzQY9h7mZX3W9Y2wTavESqyHYyf1dp59qEWJg=;
	b=TQkJxK6xmeZNvpokVX0taELwpOwmFMLWFsJI4liTz6jMs9DfC+jng3tcuzOUrzJ9biOE
	 6tpyy4F10zBgI7gc0m1y8D36AxZn1kcO0KNmYq1r8BI7ExCcKaJiQFpZRnXnTlwKJfAsJ
	 0JivYfeCELV3LLeMucrbTuq8UT6pEvOy/7QiJtCaNdWoX6JOeAQRu/GXyxCDK+BwquznS
	 n9hHx9yB+t7LQvU2Gsq+KBySgY8RRCdQ8gUuCoDXWYB3H4/FDeIoF/wXnAT+91fxeGu66
	 1oluWpJVLYTF6JAG0olcm5q42QxPLV4Opw4eBH7PGIAPIcHAbD7lcKUmo5pVyS6Nm7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5NbCA6l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB1606A331;
	Wed, 11 Nov 2026 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5NbCA6l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A91F00A05;
	Wed, 11 Nov 2026 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794433997;
	bh=OgsIQxLzQY9h7mZX3W9Y2wTavESqyHYyf1dp59qEWJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5NbCA6lXzqX3mfJcCZr7BG0oiK6pRM3UzqESzQRIQH83Zl0Pf+RCmsZsGtJTRJ+0
	 Xiv6kaRgz8dLWDXtzzO185kcSpb/i0OWzfJ7oSgEnp4PogfG+uLdhlD68ufa1nEqK+
	 XmxG7uHXVTi7sx606OFUxYu6NPrarwuFQJl9NLAHcApDdpKjJizw7tPGaC2qQ/qr7O
	 /cXKFu18JdxyWjnQB6Rj8eZWEgkkXCqytSfTlI7RdzZnDDx5kLMgBe9KPE1M4SwiU8
	 9La0f6m5Vi/NBPlp6/wei6olLiTsZ4UCZ5si1Fw0LsW2GbAHUkDaSTK9xSxTMJM3ok
	 2cxpLKB9CxVSA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] pinctrl: nuvoton: ma35: Prevent out-of-bounds write in ma35_pinctrl_get_soc_data()
Date: Wed, 11 Nov 2026 21:51:47 +0000
Message-ID: <20261111215256.1982044-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 408927ab19da..04528e734bc9 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -621,6 +621,12 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
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
2.56.0.567.gdb80ae8cd5-goog

