Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794845044;
	b=bkDb8skKDwW8VgRyQphV7a8k+Y9Ud37zA1KauZnZq3nahiUNW2kW85YgR1kLqnRyyfwW
	 iTQsa4xBYXmRduSfL2M36kFHm1DT2JuqvLY4jCLTdaPngoMVchsfyyttUbBn0RJmq3c+7
	 hCGsYY+pvHR5L67Y9KPwdroSFLr6xN88VMd+5LIE8NNXqnCLtLnA0c1pKvZs+7MZDufOP
	 GZLLPzfmltT5k/HVbntSbzuiRGCd1CIhIwc5HubBRekHG47wTyJedd7GekGzjoLJU3W1B
	 JO4wDGgTgl4GbxvMsrIruKUDwLbsAaJlMj8QLHEhMI2Z/qLQxCxH9BCgdSO5Bx8EdAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845044;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7LubAO8uiRdXrnLYnyMzXSYGmolxSLKZkKWuECnjhRI=;
	b=NIwqHWoFT2lZFhPiWUjKfzR3jidD30a/Cm5mskNf555bCEK3bMMx4EqsZrV6g7vmhtwn
	 a7bORBz6xbEvh4tqX60+q7JSKL846Dagqd/RSnN8UAzfnqG05g1t5J9UdTl6FPu63tvbl
	 jsCQGuIwrARmIifQLhef2FMreEp6kRLzJTkTf8b74x7x+isF7q6tBkEet3MJs0xAOJk98
	 imYUjoCZgjmQlkZUkN74TOChaW015DgYXUT64H48TsjSjRX6qDIx2zJLUk+rq7JlNySgB
	 D7FfGfVZlkrAizcUVBp9i9f16aqaCItUom0uo80uIKeCNV2cS+xQQykzxgCtbxo4ihw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksCKvZM0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E99A606A337;
	Mon, 16 Nov 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksCKvZM0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794845043;
	b=CdNT22w2ue+mqW058LR/RTmJsqLJaG5WKcndVKTydn7XJVOS/YqslHyIuqk9JoP40XO+
	 op/VIGe3nWNIH2Irl2u6SBrG0lAL2syQ4ZcEdXRgwjtr5oH9Sr4AkFuphsL6VrIOEt8mH
	 qnH6FjVOKwmq1B62UMedvbi1cg8bms64NMzmvN82eCFvf2sQiM/Dy6sAiZ6+42itxUnWB
	 cycuEvTet7bcCdhxBysA+ndbFNLJ2LMcl//lz5aw3KnXwItVTqVuVSmFTshjLYXhc1NxP
	 vowOncpjZRv8UqlqBk8sxmH9VXiqHTjF8lWCiLK8xsvvzkyH4NDr7cFWGjIn1z9n+Iw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845043;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7LubAO8uiRdXrnLYnyMzXSYGmolxSLKZkKWuECnjhRI=;
	b=jgGDP8HZ5kYMyORsoTxHraHUnWtzd+cmbBJzL4oj0e63ib/NX1V3+lkFdzFiRznGwZ8k
	 BG7a0kGpIsnw9jx+FOVkZr2UvNyrqq5lNUW/K6KkBJAkIgoHyi88jsLx0m9kk40b6/AS9
	 bwoITEAQTI6lUiWKpXJV4hqVupVKxp+PL7no9YyjCfK7g2BH0NDgSHkJN5NjSZ7U7J5EF
	 7thCbTRgNn1nlRfp+wkbLvytkm3xqEXs6rOIq1WoUQRvcJV8jmV1MMw7vOY7I0i3epQKf
	 DK1Z6WKCmt9ua/6oM6E/dAr2gxjSvLif9aKgxUXQnUukaQ9+RvSkZXfFS8nJPmFE7TQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 950E21F000C4;
	Mon, 16 Nov 2026 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845043;
	bh=7LubAO8uiRdXrnLYnyMzXSYGmolxSLKZkKWuECnjhRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ksCKvZM0EYRAEBRh6dDSapEXSvnNonbgBxjxZQABrgRo7intTqDRLIOvMuSkk9vCD
	 G57golgk32/jE9i31pnYhPJDJpcySVHQ7chHVvcqiDtUbfxnxe/H5CT7jWks69f+Wc
	 ycMn6lLlqs96g+9L4A4i7O9fWJ1Ac2CsB5ygFqlHWdSXAIIdvWF8fzn8n1Wb5lCLoq
	 fsV16gg83l0sLW/hypbo7f0ytsPYpLbrUTF23azmhNDtDUhwqfwwpffnOpcGG4nFe7
	 jbOpt6jjv8xp2CZM+uO6gHkZE99X+AxC6E5S8jXoFcUrq/G3xZuFBpJckp9Uocj5Rl
	 effBNUaR/z1vg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0FF9E4A504;
	Mon, 16 Nov 2026 16:04:02 +0000 (UTC)
From: Babis Danias via B4 Relay <devnull+b.danias.tutamail.com@kernel.org>
Date: Mon, 16 Nov 2026 18:03:59 +0200
Subject: [PATCH v2 1/2] media: i2c: ov8856: Don't power off a suspended
 sensor in remove()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-ov8856-pm-fixes-v2-1-7e41763164f2@tutamail.com>
References: <20261116-ov8856-pm-fixes-v2-0-7e41763164f2@tutamail.com>
In-Reply-To: <20261116-ov8856-pm-fixes-v2-0-7e41763164f2@tutamail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Hidenori Kobayashi <hidenorik@chromium.org>, Ben Kao <ben.kao@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Serin Yeh <serin.yeh@intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Charles Drolet <linux@cdrolet.dev>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Babis Danias <b.danias@tutamail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794845041; l=2404;
 i=b.danias@tutamail.com; s=20261103; h=from:subject:message-id;
 bh=kY/oS73fWOVn0gVcpwf1WQqms7NAv+QiA3vCbvzTAX8=;
 b=x5cvKZ8YSwq8/LS7uqMl5UATkD0nbudDmwngEb6pJiKbzVPfXBdrE7xypZgJB5CiA5Uif4675
 uQCm/WxGDVxBrpjORjwWeA82YAdTFXZ4Lqeaf2sR+EO35cqhajIOIh/
X-Developer-Key: i=b.danias@tutamail.com; a=ed25519;
 pk=6DWeigdk0D3JwBjwvmxo9RW8cG8S1Eku42cb9PP+ghk=
X-Endpoint-Received: by B4 Relay for b.danias@tutamail.com/20261103 with
 auth_id=1406
X-Original-From: Babis Danias <b.danias@tutamail.com>
Reply-To: b.danias@tutamail.com
Content-Transfer-Encoding: 7bit

From: Babis Danias <b.danias@tutamail.com>

ov8856_remove() calls ov8856_power_off() unconditionally. The sensor is
normally runtime-suspended by then, so its regulators and clock get
disabled a second time. On every unbind, the regulator core refuses the
extra disable with an "unbalanced disables" warning, and the clock
framework warns that the clock is already disabled and unprepared.

For the clock this is more than a warning: the clock framework keeps
one enable count per clock, shared by all its consumers. Where sensors
share a clock, such as the TPS68470 clock that int3472 hands to every
sensor behind it, the extra disable can stop the clock under another
sensor that is streaming.

This has been the case on devicetree systems since commit 08304923d317
("media: ov8856: Add runtime PM callbacks") made runtime suspend power
the sensor off. Since commit 609a71568664 ("media: i2c: ov8856 : remove
ACPI node bypass mechanism"), it happens on ACPI systems too. Seen on a
Dell Latitude 7320 Detachable (rear OV8856 behind a TPS68470) when
unbinding the driver:

  [  220.072107] unbalanced disables for CORE
  [  220.072109] WARNING: drivers/regulator/core.c:3262 at _regulator_disable+0xc3/0x150, CPU#2: tee/8667
  [  220.072825] tps68470-clk already disabled
  [  220.072828] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x82/0x140, CPU#2: tee/8667
  [  220.073620] tps68470-clk already unprepared
  [  220.073623] WARNING: drivers/clk/clk.c:1047 at clk_core_unprepare+0x1cf/0x200, CPU#2: tee/8667

Power the sensor off, and mark it suspended, only if it isn't
runtime-suspended already.

Fixes: 08304923d317 ("media: ov8856: Add runtime PM callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Babis Danias <b.danias@tutamail.com>
---
 drivers/media/i2c/ov8856.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index 42c4b9c4e3..18bae9db64 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2367,7 +2367,10 @@ static void ov8856_remove(struct i2c_client *client)
 	pm_runtime_disable(ov8856->dev);
 	mutex_destroy(&ov8856->mutex);
 
-	ov8856_power_off(ov8856->dev);
+	if (!pm_runtime_status_suspended(ov8856->dev)) {
+		ov8856_power_off(ov8856->dev);
+		pm_runtime_set_suspended(ov8856->dev);
+	}
 }
 
 static int ov8856_probe(struct i2c_client *client)

-- 
2.56.0


