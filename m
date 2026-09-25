Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142614FC8C1;
	Fri, 25 Sep 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371343; cv=none; b=lfUWc/ZLlD1SvMzNDCNiKTCfHmaBcSy6NRZVyjFAZBQ6RFFShVCyo3XjjzLTLUxSwW6e/QNkhDgIxVL+fyk+vNoR+u8EJYGNYLi7Q6ZgwO/FJKyyTbxAxQdTompoOtI019wR0o28CDV9uX/aWeIkw6T0ZcgDo0k0eUzEizaZCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371343; c=relaxed/simple;
	bh=a+KdKsTZhfa/DABR8dxHk8cRR3qLZ2vqAHQD6gthLAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7PswW1BELzhJrKUHEfA+bW+liRHzxgKew6TEKFUWJdDfYjdPu0Xwuu6SoT2+6LhiPft9twM03CGBHdROELFz7GNbSQb+biQtpI6c0Ggi0CbgWoHO2uN7kgvo8cRvS2QqAPozK+KZNFrHhPuMciKWzykGi55RBj/OtF7AbxNFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3DEYKOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3DEYKOd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99D3AC2BCF4;
	Fri, 25 Sep 2026 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790371342;
	bh=a+KdKsTZhfa/DABR8dxHk8cRR3qLZ2vqAHQD6gthLAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b3DEYKOdu/lnm0xbFmJ64UsluczJG5AT/xvnJNvJAlAivK03MuNcfG5mZGznHvoGe
	 bzAu+Ylk67t8RsP8mxa3nV347UboSzkebBPbSrGsQjBYWQZibX2x9Db/6S4MzlFkS7
	 0en5sZl03uwnnq5M9snePER0qD0adoNVyIqoUtpcNRuwMub3yh0rGfqsTuQZKw/b0C
	 8/Qzco8dObIIpiEQUxKJuj3AhNfmUn8+ybok+d0PJSKk6CxcsvZn5c90rmt96UJtiA
	 COLwuw79hbMyOMZWRgAsOvd+wErYAXkRK/t6/7k/6c6xUNyqcx78xIJx6mNhAyK5NN
	 SgiEKKPD9WtUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A5C98326;
	Fri, 25 Sep 2026 21:22:22 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 25 Sep 2026 23:22:19 +0200
Subject: [PATCH v8 1/5] Input: stmfts - wait for controller ready after
 reset
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-stmfts5-v8-1-0fcf49e2c85f@ixit.cz>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
In-Reply-To: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4929; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=eDTdFrg/SW6FiqwVfkrIiMqi05Gtrp3Ip5N2yAkOtDM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqtuYMVR8nrgjUXsVjL86TgRoFvvNYq6ifK59IW
 5gCwJLISBGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarbmDAAKCRBgAj/E00kg
 cgVHD/0R++6Q9P5r44FhEmGEmOc7TvbHDtU0dAQQkxVnqvaEuC3n7VPdmnvwk5yItwwr/ohG7pw
 AZrIsPsrUY5u4zwLm0E5zE2eaDojGHNWKTCuHIJEeiwrsUic+OllOQJk6YkNzN81A6oLE9nHvBp
 KQNaR04ChyRBNdL7WN0THb0BysdPLewZ30RaZFtAxgY4OLsAx6K0rqLK1s2G6MHiVrwXi5nQhX2
 MAYuRDn88BbjRufeo7GqKVNPg3ACGADSBFDmxG5j75HYSJP4Ab8hZlmrmRh/pOPpeM8hVjTnoea
 eWUWAflYaz6hVHuBL5IJtWJ5UMi1swReO72MkZqhp+YMM5EIrlz5hy4vrCb/tV0NZR6mvXKnJfh
 LNM2wjoZramlSopy1p94cX/HkUovJEJEiFbgLlMnV8rjL78Pz5DUHKNo+3yh12wTbaEiMW9k7h7
 XUs7jPD1edQYQKeSiUVs6JFRO2slnrM6N6L6VLDUuco/COgU/h2xCHsyl+ByFZBipxIMoLfxXCI
 xVf5hrT93MDdPm9Etkg3b0+gJHNsm0SQ38tXF6VDLPlHQMmk9IZrEVVHB+VCLDqv3GtX83Le65v
 3cy/Kga65M7QhyVMfRBe0XJYpim/IGj7QjF+R28+cmXF202t29zd+UIdcxqkQT6uwI33mgxy3Ya
 OgUydjXIO4Zsy+g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

After releasing the reset line stmfts_reset() sleeps a fixed 50 ms and
stmfts_power_on() another 50 ms before the first I2C access.  That is
enough for a warm reset, but when both supplies were really cut during
system suspend the controller boots from cold and can need longer.  If
it does, the first read fails, stmfts_resume() returns an error and the
touchscreen is left powered off with its interrupt disabled.

The controller posts a controller ready event once it has booted, and
the event parser already completes cmd_done on it.  Enable the interrupt
right after releasing reset and wait for that event instead of sleeping,
giving the controller 300 ms, the total budget the vendor driver allows.
Boards without a reset line keep the old timing.

Usually phones such as Pixel 4a and Xiaomi Mi 8 needs longer delay, so
without this change touchscreen stops working.

Fixes: 8a1f9de80e45 ("Input: stmfts - add optional reset GPIO support")
Cc: stable@vger.kernel.org
Co-developed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/touchscreen/stmfts.c | 60 ++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 972687797f826..1720202d6186b 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -59,16 +59,18 @@
 #define STMFTS_MASK_X_MSB			0x0f
 #define STMFTS_MASK_Y_LSB			0xf0
 
 /* key related event masks */
 #define STMFTS_MASK_KEY_NO_TOUCH		0x00
 #define STMFTS_MASK_KEY_MENU			0x01
 #define STMFTS_MASK_KEY_BACK			0x02
 
+#define STMFTS_RESET_TIMEOUT_MS	300
+
 #define STMFTS_EVENT_SIZE	8
 #define STMFTS_STACK_DEPTH	32
 #define STMFTS_DATA_MAX_SIZE	(STMFTS_EVENT_SIZE * STMFTS_STACK_DEPTH)
 #define STMFTS_MAX_FINGERS	10
 #define STMFTS_DEV_NAME		"stmfts"
 
 static const struct regulator_bulk_data stmfts_supplies[] = {
 	{ .supply = "vdd" },
@@ -538,25 +540,16 @@ static int stmfts_read_system_info(struct stmfts_data *sdata)
 	sdata->chip_ver = reg[0];
 	sdata->fw_ver = be16_to_cpup((__be16 *)&reg[2]);
 	sdata->config_id = reg[4];
 	sdata->config_ver = reg[5];
 
 	return 0;
 }
 
-static void stmfts_reset(struct stmfts_data *sdata)
-{
-	gpiod_set_value_cansleep(sdata->reset_gpio, 1);
-	msleep(20);
-
-	gpiod_set_value_cansleep(sdata->reset_gpio, 0);
-	msleep(50);
-}
-
 static int stmfts_configure(struct stmfts_data *sdata)
 {
 	int err;
 
 	err = stmfts_command(sdata, STMFTS_SYSTEM_RESET);
 	if (err)
 		return err;
 
@@ -582,53 +575,76 @@ static int stmfts_configure(struct stmfts_data *sdata)
 
 	return 0;
 }
 
 static int stmfts_power_on(struct stmfts_data *sdata)
 {
 	int err;
 
+	if (sdata->reset_gpio) {
+		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
+		/* a short delay before powering up */
+		usleep_range(1000, 1500);
+	}
+
 	err = regulator_bulk_enable(ARRAY_SIZE(stmfts_supplies),
 				    sdata->supplies);
 	if (err)
 		return err;
 
-	/*
-	 * The datasheet does not specify the power on time, but considering
-	 * that the reset time is < 10ms, I sleep 20ms to be sure
-	 */
-	msleep(20);
+	if (sdata->reset_gpio) {
+		reinit_completion(&sdata->cmd_done);
 
-	if (sdata->reset_gpio)
-		stmfts_reset(sdata);
+		/*
+		 * The datasheet does not specify the power on time, but
+		 * considering that the reset time is < 10ms, sleep for 20ms
+		 * to be sure before releasing reset line.
+		 */
+		msleep(20);
+		gpiod_set_value_cansleep(sdata->reset_gpio, 0);
 
-	err = stmfts_read_system_info(sdata);
-	if (err)
-		goto err_disable_regulators;
+		enable_irq(sdata->client->irq);
 
-	enable_irq(sdata->client->irq);
+		if (!wait_for_completion_timeout(&sdata->cmd_done,
+						 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS))) {
+			dev_err(&sdata->client->dev, "controller not ready after reset");
+			err = -ETIMEDOUT;
+			goto err_disable_irq;
+		}
+	} else {
+		/*
+		 * We do not know the real controller state (was it powered
+		 * off or reset). Let's hope that this is enough time to
+		 * initialize.
+		 */
+		msleep(70);
+
+		enable_irq(sdata->client->irq);
+	}
 
-	msleep(50);
+	err = stmfts_read_system_info(sdata);
+	if (err)
+		goto err_disable_irq;
 
 	err = stmfts_configure(sdata);
 	if (err)
 		goto err_disable_irq;
 
 	/*
 	 * At this point no one is using the touchscreen
 	 * and I don't really care about the return value
 	 */
 	(void)i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
 
 	return 0;
 
 err_disable_irq:
 	disable_irq(sdata->client->irq);
-err_disable_regulators:
+
 	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies), sdata->supplies);
 	return err;
 }
 
 static void stmfts_power_off(void *data)
 {
 	struct stmfts_data *sdata = data;
 

-- 
2.55.0


