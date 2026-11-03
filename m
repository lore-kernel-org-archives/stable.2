Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793722252;
	b=jl1zf+MZ1ngzxUPMtHdwozFeedvMup2QdclcqUSxYp9XhG0//rzQnRGCzgecLYZV1jil
	 QV6pBglroc6TIjKz8VME4fv5kwtQnsoOhYM8k4RUoDoPvMZ+fJYdsftsVfVGZmK7xJf1y
	 fqs677kt4HhvmrvA9Mf2OaluHzwcfYeqfxYrUQ+EJRH0EEZBh3QgUkAjTzhyz1z/U/Wxm
	 N5nSLIrkaQCM9DTzerbXrac71yy9f7y3AMoUwtwZX1l77JySPjFyz7QqOcea3H3d9jq0m
	 OnGr12rKsDB4aIsMwkccR5q1KbRy6B/P7CP1U8fKe7PVF1Q05Lc4Lq5xW4VOBL9st4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722252;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tDWQdG1/PeshgynnY7/fc6dyAjeAqXG7SdxmhNCMlss=;
	b=4b2BNPBiKcDxg4xRwkYyXyB4QWN+fqdSq+qEOi9+9okN/oDWhsEjEvtQQOD30lSrPPqC
	 mt4uHWAIDkrCUlKvBKoG4sjAb28oQHhHImZgWFBi+H2C/4wZ25ZbyJpvBSPTdnNKbSihg
	 thkIcIIlO/HweKfhU+3+GZQtYrT+fTEV122/s4TC5klW5MBFdVm9+l0SxeNj6SMHdHxKP
	 5qIW236d59pxV9fJx8BEdsh05jtc+voNLKutu2j1ztFFwqN26JfERZREXAZuZ7r8OrJTQ
	 KvBcTyqW0zWwpdQTyyo7e+Nf8N1Xk48TKKdO9PVE8hNMSRbuCSBZfzuHRIUr89ZPdoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIYeWLmt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC687606A333;
	Tue,  3 Nov 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIYeWLmt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793722251;
	b=M8B3vYBIQp/c7LAtI3Ti80o8Yjs1cqSPZxkWyhjSNsxIGfF3JTWwQOITxtaRkY7SOouw
	 b+bOt5L2jsNaqMlFm0uVgKhrlhGMoC4gVYsDVxi1Pl6ZgU/fMenxEBVxHnrHHGZhgGPJM
	 F/qI4yk2zpvaGCjevnWfMZ59oVIP41uxd5u3bHFcR5eQWl11i6zy3dgp1g/GUeETDzQut
	 vUV4b8bzqwqTopP9v9bqCYxs/HYtanHtxq2YUGKayxaCOS+e0sxnxJX2C8CnBX/hM0O4K
	 YN/GHPxIok14f+uIcQhz1Ps9D99SIkAlmTuiy/RUwdyHJ5Gi4ha3DAcaO2X9mrBzjUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722251;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tDWQdG1/PeshgynnY7/fc6dyAjeAqXG7SdxmhNCMlss=;
	b=gR/z1oWxgaRzEK3jjFhghwYuO+wAZBNjjVcxkqc+FRcoNwSyBIt6BUyvLQg8b456zE8C
	 AsVcRABBLVChvJrTFQHFsFInbXZ39WpGbbfuA7hCuJNiUeTVVSrXPebcYgJz3sDY1wElQ
	 JNngi8Svw6eoueEJ1vsZ4N1oslY34LvFwBx9NA7Ue6qjFD95R+m5zeMDe6H+QpvmyPoZo
	 4ljj2Sj53pWfaTMPWeOp0teIPGsoBDZloqr7IbGMDq/ojPeHj8nrg0yYypk1azV8r4aXq
	 DD1tQZnHyqH9tQvS1x2O3ENSdi4M5tkrHHbjOTEaCE44e0snwgsvGAkiC924mXBd83Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0C7351F0093A;
	Tue,  3 Nov 2026 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722251;
	bh=tDWQdG1/PeshgynnY7/fc6dyAjeAqXG7SdxmhNCMlss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nIYeWLmtqHm91VXmn2DzFTQg9yVCIGQWnZ9p8jg5nLqMQZyL+vQPTTRpCBvbiNbzH
	 EVRO5BQqzlfKkaxzDbPsaqOg1UgWpS9joYZNkAHLQ22TpCkktDimh6Q352RayH2lvZ
	 SUBEzI8uqjv7MPKxE5me7ZESsGNTjpacIcWTuI4v5KDqX7jHL+NyaSrZconaYMk21m
	 knxymJE4/yVi2/Wh/bhOBckwGcz8Kr+Jz1QQb5LScKqZSpTUbs3WmJetFjyA0WIjr2
	 n1mg4kgQMHzN4DUI6QjDhV4JB3ER4XI2iPlcc4EWEDPjS6reLjCeOBuqw/Myk18t04
	 /0TsgqsytmIDw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F80F469EA;
	Tue,  3 Nov 2026 16:10:50 +0000 (UTC)
From: =?utf-8?q?Stanis=C5=82aw_Titenko_via_B4_Relay?= <devnull+kernel.resetko.pl@kernel.org>
Date: Tue, 03 Nov 2026 17:10:20 +0100
Subject: [PATCH v2 1/2] usb: typec: ucsi: acpi: Rename the Acer zero
 version quirk
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
Message-Id: <20261103-ucsi-lenovo-t14g2a-v2-1-e85c659b56a2@resetko.pl>
References: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
In-Reply-To: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793722249; l=1953;
 i=kernel@resetko.pl; s=20261031; h=from:subject:message-id;
 bh=hms0PyZfM1RQtj2hb1BMKNKwDG72eddmepQmTG3Iwkk=;
 b=SXh+GYE6jmmiLlCwzeK7yARMsPdhKVRsKaLPWKFCOm6u8piuqXcSsDvLfWtoUHPvIZWNacrZ9
 zcEXgJRCq3fCqXSNSXzgWQ+vzMac+5kVXovEqBQoRNWSWT3AMAFNLjz
X-Developer-Key: i=kernel@resetko.pl; a=ed25519;
 pk=xMhqzbyPNWfeOgdmzSHsSlr5qjH779F5SD6BBHXixlY=
X-Endpoint-Received: by B4 Relay for kernel@resetko.pl/20261031 with
 auth_id=1372
X-Original-From: =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>
Reply-To: kernel@resetko.pl
Content-Transfer-Encoding: 8bit

From: Stanisław Titenko <kernel@resetko.pl>

The quirk added for the Acer Nitro ANV15-41 is not specific to that
machine: it substitutes UCSI 1.2 when the firmware reports a zero
version, which other platforms with the same firmware bug need too.

Rename ucsi_acer_read_version() and ucsi_acer_ops to
ucsi_zero_version_read_version() and ucsi_zero_version_ops, so that
they can be shared with other machines.

No functional change.

Cc: stable@vger.kernel.org # needed by the next patch
Assisted-by: pi:claude-opus-5-5
Signed-off-by: Stanisław Titenko <kernel@resetko.pl>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 5697ccc24ec3..47ba0e15b8ba 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -121,7 +121,7 @@ static const struct ucsi_operations ucsi_acpi_ops = {
 	.async_control = ucsi_acpi_async_control
 };
 
-static int ucsi_acer_read_version(struct ucsi *ucsi, u16 *version)
+static int ucsi_zero_version_read_version(struct ucsi *ucsi, u16 *version)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
@@ -138,8 +138,8 @@ static int ucsi_acer_read_version(struct ucsi *ucsi, u16 *version)
 	return 0;
 }
 
-static const struct ucsi_operations ucsi_acer_ops = {
-	.read_version = ucsi_acer_read_version,
+static const struct ucsi_operations ucsi_zero_version_ops = {
+	.read_version = ucsi_zero_version_read_version,
 	.read_cci = ucsi_acpi_read_cci,
 	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_acpi_read_message_in,
@@ -194,7 +194,7 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
 		},
-		.driver_data = (void *)&ucsi_acer_ops,
+		.driver_data = (void *)&ucsi_zero_version_ops,
 	},
 	{
 		.matches = {

-- 
2.56.0


