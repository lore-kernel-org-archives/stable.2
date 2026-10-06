Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77D22425B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272679; cv=none; b=VLK+dwmXkWW2Nl3Dz4pO8r9TiIiPfuIBBdPfksYm7vZ/sinpouyYf4eH0J3zd/f2U/acRVdM0y/qHPJduH8o2/deA+0RtTf0DbmEa/ChzSqmzXal91LpbeGOKEMYOWht/sLCxSYMmZ5ZOM6VicKmR5Houe8UuXkOmVb4GweQIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272679; c=relaxed/simple;
	bh=Uz8vMitTyYFFfPbNBIF3ko6RkFs0k4tblWV0Fbha9vk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LWTUQbwB4qv9bbYcZXT9Su8Kpb0Ygg+H0PypHUe2/Etvl6YWFRzLWRo3yEztyupncBLONYsEIF6QKlR4hgOBqDxZVI8emxqLAJzsO13CJvsZZo08NULiKOUg0rsMxIQeOt6gJY3HFzJow1zL2PIU6zF5Df7Kpp3YLAcWAV9HSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smxFVVgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smxFVVgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CEA1F000FF;
	Tue,  6 Oct 2026 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272678;
	bh=zIw9p2LjZ1axKp/IL/Ol7iI1iIIT7Im2vdHcsXLIe+Q=;
	h=Subject:To:Cc:From:Date;
	b=smxFVVgJ6TDIvXLt0/r7qQ8vzEs5hyrrOQbHNE0rqfwa7E5f5n97AMLpWM3ROEjeH
	 C2FxH5W0SGsz+hayxFLft9UewMSK+Hng9QQSfQR1+Lz7QQZ9ShFD1jNI6BY0JA3osk
	 IDTFhYASXZrzMYCK07jNfgmwv0/vX0BN5mlNezA0=
Subject: FAILED: patch "[PATCH] iio: adc: axp288: Add TS bias override for Haier HV103H" failed to apply to 5.15-stable tree
To: cactucatu4eckuu@gmail.com,johannes.goede@oss.qualcomm.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:44:13 +0200
Message-ID: <2026100613-smolder-outshine-756c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0f300db7b7315b2c7ea0e2d4437b88de162d191f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100613-smolder-outshine-756c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f300db7b7315b2c7ea0e2d4437b88de162d191f Mon Sep 17 00:00:00 2001
From: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>
Date: Fri, 4 Sep 2026 15:31:55 +0200
Subject: [PATCH] iio: adc: axp288: Add TS bias override for Haier HV103H

The Haier HV103H firmware configures the AXP288 TS pin bias
current to 60 uA. This causes the battery temperature reading to
cross the charging temperature threshold under load, incorrectly
stopping battery charging.

Setting the TS bias current to 80 uA fixes the temperature
measurement and prevents charging from being incorrectly disabled.

Add a DMI quirk to use the 80 uA TS bias current on the Haier
HV103H.

Fixes: 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling")
Fixes: 048058399f19 ("iio: adc: axp288: Override TS pin bias current for some models") # Add necessary infrastructure
Signed-off-by: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index c8283279c477..c98863d612ad 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -207,6 +207,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
 		},
 		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
 	},
+	{
+		/* Haier HV103H */
+		.matches = {
+		  DMI_MATCH(DMI_SYS_VENDOR, "Haier"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "HV103H"),
+		},
+		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
+	},
 	{ }
 };
 

