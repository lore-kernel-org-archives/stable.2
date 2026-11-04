Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793785379;
	b=dcpL3MWeuzOS8LZ1gDZVikwIXAcHofUtB++Bz/htDDs9cpz/PYKy/rnSVgwUa2D76IRS
	 nQRIluR66xZ+kAz15sQNx0jJBWNoCu3cBi+3FhN9EDFJsZBNEKRgFDyOKr/SUM6+EemSH
	 2alKq6SEqrDCIIQEV1u1hBsXaojI5CwxUAfkOd/IXS8yBvUp9ciuGhHAjTbfr5D0bwmi3
	 OH5u8/Oa0XOB0UvdXdssgFbjDU2Ot4E6GIVC2QWHgQQjLDMcHDMMGWtPjfpOyPWqkwPms
	 w0mTJYCjtw0r3uniFihVam/7QwD85bj4PWM8HJlAq06650u2KsLY27HcpfrRhgP93tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785379;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ezPYznbslsnAcqfprTwt3BpYe5eDIl6ErFqG/k3BNSs=;
	b=0TjnscymCigAWs2FrElIPtJqOrEeT8pKkOGBw0uY0KxZmM9W3X7iXIdswXVkfZ/Dn6cO
	 Qo4jinP9afu7abWtwK+LXniW3CtmJck07hOMsIQf4sztsAUmctUy18n9OHiPtJEY6hzaF
	 Oy4hWdpF8uXivcNRA/21ySOnk1gG7HOj17DFGDA5JY0EsgRNVg+3mFEneY9DIAqo7CSkc
	 VqjiQkBh6mna1v7Km/LQTN+K9MNTLpPGHacUg57m9AyxtLxYJ9gavJorT58lAd6PTafw/
	 MsAkSqS3fwBsdFHIy/cFVOsl8N90vAiJ74XKOd8FElKE8/BUeyHqb9x/TwVS5t4nRYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyOU2HOu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8F606A32D;
	Wed,  4 Nov 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyOU2HOu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793785378;
	b=0f/RMo1CuCXB0nldvUsfiJ2C39ZsLz8PyO0X21Ojh9GIgqbWSTdoRBPDSW+TdzjBJakp
	 bGhbcPJ2DrEGcKIzfq9t5vimmQi2eOg9FNaUar9Yrl3asj70G/nTyq9py9ADmrufHy6PG
	 gJlECU60cAEW81hSGxOYXI6n8sywHXnyRcA+HG/WxfYS1bVw90gWAGvv9xaKE3RXT4AMl
	 a4K3cOFsAQstKAP2UqOg9pWbzYIEcpikpDmycVnRjQrWCU7bl5UinO0gH+iTcVKHuVmra
	 zOL13sUOwmlnrMyu/gbbHD40Ek8XZAPTB8NoR3oDLXQCAvCyoZa8DSZsHqdytzPy48A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785378;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ezPYznbslsnAcqfprTwt3BpYe5eDIl6ErFqG/k3BNSs=;
	b=SSJ0lfMsgoNfkOv0sz8h3FXcb4NKpEWR7mq4oTsxNXAYWW5fRXameS+b8yUwK3s+MHvc
	 k0Gv1P9K0U2SjjeM12r2WCaLMH7yFVvnqPDF6bqCSKTRX+Ri7cMmLDn3prLCCxlcZY7Yr
	 RVuQrPt7WFAY7EbOio72TfxRqbXHYD00ynPdYrfWMg0Ra3WCq56brh2gdkYPHYVTeLsHW
	 cyShmZF/Evt+63uooOd2Ojfgc0EqKcBThdSGwgTDTZlO+vSjp33E4pinY24E7zBahOQSK
	 zojNopBNO5eMKpKFlcGWzp//YBcYHU/ESPwWLTGzzrgEKEGHj9npyn0Osm0aWqdfs9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7B6CE1F00A16;
	Wed,  4 Nov 2026 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785378;
	bh=ezPYznbslsnAcqfprTwt3BpYe5eDIl6ErFqG/k3BNSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YyOU2HOuWxksK/VM+JYCjj8GgC3NmpSgveHx8Z++PFBGD/Po7FJpIeCAxuda8Y8rR
	 35U3IuccZD0lKEi2qoJbyJm9GMhb1USbfYWosGBb8jiTT+LL7qgiEPN+3sXqnawKpP
	 xjb2qu2HRuaxityzZcwy/z7lX917C8tSLUEYxEJ0JOwpCH45QBdvcUvEqhWYpS1qiQ
	 fsh7wsPU0IWTNqm5vEuqhDDmtwWp9vY7LgaY5fJfqL3QM7TKE6SDdIy1+cG0J7OHt2
	 e2LHmifGNd6hrV9wOTx1Ti4vPC1zMybXgTOFmrax/yEl7/8HoYjmgLWoya00u8WuaR
	 E3JIn+uewxAdw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 03E9646D85;
	Wed,  4 Nov 2026 09:42:57 +0000 (UTC)
From: Babis Danias via B4 Relay <devnull+b.danias.tutamail.com@kernel.org>
Date: Wed, 04 Nov 2026 11:42:49 +0200
Subject: [PATCH 3/3] media: i2c: ov8856: Power off the sensor during system
 suspend
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
Message-Id: <20261104-ov8856-pm-fixes-v1-3-1958b730ce66@tutamail.com>
References: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
In-Reply-To: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Serin Yeh <serin.yeh@intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Babis Danias <b.danias@tutamail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793785376; l=2806;
 i=b.danias@tutamail.com; s=20261103; h=from:subject:message-id;
 bh=D6TzCaSHwO5sxfGpSVeAfyeQYpOZbznZnsTWQvfOylA=;
 b=RaX+DSEFW0zQSOLC+4Irzx1Rw9oIY89rIlVs810BM1jeOii2AqSXcbpcaJcKLy6AviB3b1Sd5
 ItiBQ2Jm82EA5myR/D/Lq7D0r/+A5uGsqms2TaXMz1eXkbmzvbn04JC
X-Developer-Key: i=b.danias@tutamail.com; a=ed25519;
 pk=6DWeigdk0D3JwBjwvmxo9RW8cG8S1Eku42cb9PP+ghk=
X-Endpoint-Received: by B4 Relay for b.danias@tutamail.com/20261103 with
 auth_id=1406
X-Original-From: Babis Danias <b.danias@tutamail.com>
Reply-To: b.danias@tutamail.com
Content-Transfer-Encoding: 7bit

From: Babis Danias <b.danias@tutamail.com>

On a Dell Latitude 7320 Detachable, the rear OV8856 stays powered for
the whole of s2idle once the dw9714 VCM driver is bound, even with the
camera idle. Tracing a 20 second suspend shows the sensor's clock and
regulators enabled about 0.5 s after "PM: suspend entry", and disabled
only just before "PM: suspend exit". Without the VCM driver bound, they
stay off.

ipu-bridge links the VCM to the sensor with a runtime PM device link,
which makes the sensor a supplier of the VCM. The dw9714 driver has
system sleep callbacks, so the VCM can't use direct-complete, and
dpm_clear_superiors_direct_complete() then clears direct_complete for
the sensor as well. The sensor goes through the full system suspend
path, where acpi_subsys_suspend() runtime-resumes it before calling the
driver's suspend callback. But ov8856 has had no system sleep callbacks
since commit 19ae6ba57f88 ("media: i2c: ov8856: Drop system suspend and
resume handlers"), so nothing powers the sensor off again.

This matters since commit 609a71568664 ("media: i2c: ov8856 : remove
ACPI node bypass mechanism") made the runtime PM callbacks control the
sensor's power on ACPI systems.

Use DEFINE_RUNTIME_DEV_PM_OPS(), so that pm_runtime_force_suspend()
powers the sensor off during system suspend, and
pm_runtime_force_resume() powers it on again only if it was in use. With
this, the sensor is off for the whole suspend. It is still powered up
for a few milliseconds at suspend entry, by acpi_subsys_suspend().

The problem was found, and this patch written, with the help of an AI
coding assistant (Claude Opus 5.5). See the cover letter for details.

Fixes: 609a71568664 ("media: i2c: ov8856 : remove ACPI node bypass mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Babis Danias <b.danias@tutamail.com>
---
 drivers/media/i2c/ov8856.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index f9bcdd412..848e981ff 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2462,9 +2462,8 @@ static int ov8856_probe(struct i2c_client *client)
 	return ret;
 }
 
-static const struct dev_pm_ops ov8856_pm_ops = {
-	SET_RUNTIME_PM_OPS(ov8856_power_off, ov8856_power_on, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ov8856_pm_ops, ov8856_power_off,
+				 ov8856_power_on, NULL);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id ov8856_acpi_ids[] = {
@@ -2484,7 +2483,7 @@ MODULE_DEVICE_TABLE(of, ov8856_of_match);
 static struct i2c_driver ov8856_i2c_driver = {
 	.driver = {
 		.name = "ov8856",
-		.pm = &ov8856_pm_ops,
+		.pm = pm_ptr(&ov8856_pm_ops),
 		.acpi_match_table = ACPI_PTR(ov8856_acpi_ids),
 		.of_match_table = ov8856_of_match,
 	},

-- 
2.56.0


