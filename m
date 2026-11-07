Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049170;
	b=4fJH+Ky4XbOCWvOpXyMAdsm93hEid+oLfdB4brhuHVfK06115wVChrnXEEOU91j30o95
	 Aa3fkfHzstyt67RzP2jszivkNIhnxMK15xlaKb/Q5NJMEL+mriA2IVGvOGwLMONmj0IAx
	 z7LzRdexRZKIO+GJk9WSkt9jp7m20lTB+tMM0vCjFeGf77xLv7UIpLZAxYoHzlMEUDCHO
	 CXtDYQJWZoXxhuR5iSwslzMQ5Z2BFiJ0tk+t4wHVZ3QoO8TfHbl+85rdvbmFfM93OTaCO
	 qq46ANyTEE/dNMWaUo26gXoupv3O9ucUDzwQ9ZtMtVkKQRzTyfX3U4gjnqDciKCKP+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZtSSU0gmVHHHWi1mACgBsSiH8aimXzeTnKB3bHc82wc=;
	b=itQdKriw3RwKzCKLokPpUU35A8TZmLvG90NPRORh4T9RUO/SG2NWdqQa4HWAcZDUW/Qe
	 cC6v3cqmmT8i09bQEnBI8yuM8ZHYTPoSd4LFO/fVDssTeL1350BLWUKaf2CC0dSkm4HGh
	 nLb61ds++0oq7zoFwhfZL9jl++0cUOHFB1GlZPQYO+2H2gfp80mP9Y8gaWUg7PsnSrkno
	 5kQQciY8Q/OpUZfsxCDv80tPss0K9ICRcjg3lv1WhESyGLk4bTxDLtuSo095kMFe33W63
	 QqV/hnmsqD7eqCxNfk6IJmludKhn/Q5wICIzkWItefEwKO13ND4Ss+f18zYab7ig7nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arj9zJwb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arj9zJwb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D131F008A1;
	Sat,  7 Nov 2026 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049169;
	bh=ZtSSU0gmVHHHWi1mACgBsSiH8aimXzeTnKB3bHc82wc=;
	h=From:To:Cc:Subject:Date;
	b=arj9zJwbYmKxGnh+ZBABhkkdotGxb+2wiCNhGdGsB2je21uSCXL2Tjkv59ISJfdf4
	 ah3G1V216dy1tQwbt+zERBmbZnA2g8f0AhKcqTMNILE8p1WXx15QMVSCHen46WjiDE
	 YrMW9YsQRMVprAEvWjwIQDKfdW04JuFTKAHwsTNmDjyFd8lnGGKjCgbvk9paF+q9zk
	 gLWUkpieIix9J21mqBUrbWK+4kX9voG84T3a/ZgPXYInCpKgX+8eRwlVgdaEVoYvoN
	 WZhu9xriSYovTq8xEYGrUSMuEOlTnR+BDP8khUQZC4i+wy4zNGDY6pHuAmW60nUKoP
	 P7fqupBKgH1og==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] leds: ktd2692: Pass context to regulator cleanup" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:27 -0500
Message-ID: <20261107055927-failed-5.15-c73e9f04445f@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c73e9f04445f361d5f19ca2edfde742ce18348ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055927-failed-5.15-c73e9f04445f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c73e9f04445f361d5f19ca2edfde742ce18348ef Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 10 Sep 2026 15:45:25 -0400
Subject: [PATCH] leds: ktd2692: Pass context to regulator cleanup

regulator_disable_action() retrieves the driver context from device
driver data.  However, ktd2692_parse_dt() registers the action before
ktd2692_probe() stores the context with platform_set_drvdata().

If devm_add_action_or_reset() cannot allocate the action, it invokes the
callback immediately.  A later probe failure also invokes it during
managed-resource unwinding.  Both paths dereference a NULL context.

Pass the already allocated context directly to the action and retain the
device pointer in it for error reporting.  The context is allocated before
the action is registered, so reverse-order devres unwinding keeps it alive
through the callback.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: ee78b9360e14 ("leds: ktd2692: Fix an error handling path")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260910194525.99654-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/flash/leds-ktd2692.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index 22fbfccd48735..43d4d55503ab5 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -69,6 +69,8 @@ static const struct expresswire_timing ktd2692_timing = {
 };
 
 struct ktd2692_context {
+	struct device *dev;
+
 	/* Common ExpressWire properties (ctrl GPIO and timing) */
 	struct expresswire_common_props props;
 
@@ -196,13 +198,12 @@ static void ktd2692_setup(struct ktd2692_context *led)
 
 static void regulator_disable_action(void *_data)
 {
-	struct device *dev = _data;
-	struct ktd2692_context *led = dev_get_drvdata(dev);
+	struct ktd2692_context *led = _data;
 	int ret;
 
 	ret = regulator_disable(led->regulator);
 	if (ret)
-		dev_err(dev, "Failed to disable supply: %d\n", ret);
+		dev_err(led->dev, "Failed to disable supply: %d\n", ret);
 }
 
 static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
@@ -233,7 +234,7 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 			dev_err(dev, "Failed to enable supply: %d\n", ret);
 		} else {
 			ret = devm_add_action_or_reset(dev,
-						regulator_disable_action, dev);
+						regulator_disable_action, led);
 			if (ret)
 				return ret;
 		}
@@ -290,6 +291,7 @@ static int ktd2692_probe(struct platform_device *pdev)
 	if (!led)
 		return -ENOMEM;
 
+	led->dev = &pdev->dev;
 	fled_cdev = &led->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
 	led->props.timing = ktd2692_timing;
-- 
2.53.0




