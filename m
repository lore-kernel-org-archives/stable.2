Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121432;
	b=o8IMUc0igKvDY7G4qDiPcgJGqvDA94snNCeXktg1FFzv8E1F2590PnO/H5PBd6dJLMvm
	 8QehIni+hwfg9E60kSDFKOxkS7rUtYg7oKuZNNl11QyQsLo1asgbcfrd7o0JX0W5HbXah
	 S4idjX4tUKVVeRK2udWossNm7T4BBAXx38ETsAOgGXPzr/C1DyQWa+ZQZLy5Zy0Zanxwq
	 NSQ4EbrQlVT2mGvjdhq5m3k3CqCwsC2QGCfXuXbXZ3BVDP7yVqlRBO3CgSuU2Cv0tdN5k
	 f0JiY86FseSpDYtSLfQxluSxmisO2h1SHfISvEKNqm8Mjym4+pV+bB9OPOhwbTEu+ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/nxwbLVlzw8b/oIml8BsGvUkwKG9+QxjgDCbUHFmmjI=;
	b=h6GJL3u5n4r5qjbKN3eHYJeIUWK5FzFCH2gVvse3mdiZgBeESoDRJGQb35iJSSDR6Zv8
	 29N/q0wli8axwCDoX31Ry8tTKGdTLIJI8nCkOOhlKt0tNmYW5Qed5P4pX6KKZEuZEFDdq
	 fxTNS0jHVmQzOKoy7ZzjCuvUOSYRNTKvYQ/uIDE70bRH2HNH44fLpXM92IX6ChYDx9qCI
	 C8EraQiaBq5pSNLEqcKImkhRQmj5vFyZloSoEXrsMmuXlOtCZyD89N9lJPdgbCXduLuVp
	 kSgWg7p39GqTifw3VziTXoZtTjgkZOxRckrEud4mWp28lJRPTZMuo3lUqzTqt8N39EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QARB3Y4j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0E606A337;
	Thu, 19 Nov 2026 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QARB3Y4j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C521F000CA;
	Thu, 19 Nov 2026 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121432;
	bh=/nxwbLVlzw8b/oIml8BsGvUkwKG9+QxjgDCbUHFmmjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QARB3Y4j9Q7Bdl+OONOWr+6OZSuKVIPU3QC/yxZg1thIOPdQ4Ni+m7XMz8M4PIrtH
	 sBZBaTwO95czJNYeOBfXqeNsn5iKGTTvRvelE6IZ8+MawntnntZDWzPmEe+IPzTbxG
	 C3hM4HchQjh8yjwezWXNVbERFHa5Nvz5mexV20RWDC7/o+HoMB5KZy6Jhg64JVg2Zo
	 bd4Wqgd3dCAYoFJU7eYrQZbWde+nny+PnTgYNcFY6rdJ04DCzhDDGSYXpxXuYGbqoz
	 RL3JaSbRA914jBFe9W+az/lecbLyMsknWPbR2lADj6xeCO3evY7773dvmVTl+07oAD
	 7dt19MkGdZrUQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 02/12] pinctrl: nuvoton: ma35: Prevent out-of-bounds write in ma35_pinctrl_get_soc_data()
Date: Thu, 19 Nov 2026 20:48:58 +0000
Message-ID: <20261119205013.2563811-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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

v1 => v2: No changes

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index bfa743db8b13..aff2212c6278 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -622,6 +622,12 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
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
2.56.1.750.gf70dc682cf-goog

