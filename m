Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353060;
	b=4ouBudixX5J8QBliJPY0GA19Kvxt5/KhEMIr3L1YPsPPsuqCcbxUNv6ZjA27ULm9ZAg7
	 iFQ9b5KCZtUEXtQvPFm7WQ7Brv4bWMTM3XpwIeIXcSuObmlANd56IUeXt/m1/icQA6dq8
	 GhHlZzQbNhnYuuGOJL4yz9kDYaqht+IE+dvJG+07e6j7h4cA230EvR7lZzKqUeaDolCG7
	 TzmiL0W4PbQiSZ8pTY2L66wbmkW7J+GljIip6j5fpiP13F1LVjToEzr3/m95zB/BtJa+W
	 JkBS+qSzSscnF/KyzxY+gl+PmQ8qpqTpG0dtIbNrnr/Cb/mEkCfqkqZvWYhMeUI742g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lLah9lIcan4a0YdSn+hJTk0F9NMDKYN1xRjy6ZEVkNo=;
	b=HC8k9ItgoSZMSrSBS81xm7S4GIGCJ9JKGnXSOuwqSmBzygAkFXHTpkGw1xtIG7yhHmre
	 S+NHa4f2eVue6UvxCFbJILk5TbZ0VGRXt6PqGNpcw3wbsiPNyGttUeFL9B8DxXIND6pyK
	 LR5UlqqVdGvY7tgErSmhoVE2mka4hbLaK1ghmrAGOf05a/1cGOhZ26dTS7kAPHMMcq2NK
	 3X97UoiG5zrwusnEElYXzoa3n1TIs6qr+QmcJMr2FKgKHyCDa68MRIIHZoMId2rogTd7P
	 /hwKK8mIGmLVv6PAIQ+4blE+aokroBubUQ7H0k4W0dAaZHL1zXmwJ2u1NwBA+Np9qWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3xLN54v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF16606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3xLN54v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB961F0093C;
	Tue, 10 Nov 2026 23:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353060;
	bh=lLah9lIcan4a0YdSn+hJTk0F9NMDKYN1xRjy6ZEVkNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m3xLN54vmQaV/BFIeL24futcyT+oz3hfsQVEMMPdHPXLCavXEUgpA6HVXAQM/U1HN
	 Xtn9co7mj+k2XQeLl4JYuPMivGqom2HypGNLfbxv57XhGI1VgPf01sRicL+niqQ7lY
	 4y6p5ZlVGVDykU5mYu/7KB3qI13kJJLfWaqUmuDZ4o5e8boYkFRBspdpi8uY8Qg70n
	 WQzCEDf9WWEHssUDLrKlejewHOlEuWo+y/AbYrrFzjKuMatkIFgyGrC5aYYY3mij7g
	 4fu3FYj87pXg0P8ZcTLG2U1NtxZHe2lCN9jK1Tf59Z7JDUJEtwxZXGK9wJZtSGPrhE
	 5lmYX8rPzshpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] leds: ktd2692: Pass context to regulator cleanup
Date: Tue, 10 Nov 2026 18:24:18 -0500
Message-ID: <20261110232203.112261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061622-failed-5.10-c73e9f04445f@kernel.org>
References: <20261107061622-failed-5.10-c73e9f04445f@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit c73e9f04445f361d5f19ca2edfde742ce18348ef ]

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
[ sashal: adjusted context for the older ktd2692_context layout without ExpressWire fields ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-ktd2692.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/leds-ktd2692.c b/drivers/leds/leds-ktd2692.c
index f341da1503a49..5ef8b3c530084 100644
--- a/drivers/leds/leds-ktd2692.c
+++ b/drivers/leds/leds-ktd2692.c
@@ -72,6 +72,8 @@ struct ktd2692_led_config_data {
 };
 
 struct ktd2692_context {
+	struct device *dev;
+
 	/* Related LED Flash class device */
 	struct led_classdev_flash fled_cdev;
 
@@ -258,13 +260,12 @@ static void ktd2692_setup(struct ktd2692_context *led)
 
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
@@ -301,7 +302,7 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 			dev_err(dev, "Failed to enable supply: %d\n", ret);
 		} else {
 			ret = devm_add_action_or_reset(dev,
-						regulator_disable_action, dev);
+						regulator_disable_action, led);
 			if (ret)
 				return ret;
 		}
@@ -359,6 +360,7 @@ static int ktd2692_probe(struct platform_device *pdev)
 	if (!led)
 		return -ENOMEM;
 
+	led->dev = &pdev->dev;
 	fled_cdev = &led->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
 
-- 
2.53.0

