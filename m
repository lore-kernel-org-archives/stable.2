Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63A4D0CC5;
	Wed, 23 Sep 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170034; cv=none; b=DOWhzu7D5r28wefLmJmv04ww9prM83P1iwMsdnzi3WxJtrh69SU41m7RBow8E24dom9imIwKybI74FO1qEQlwH1YraS4g9gD4eRfGaUZi9SQMeMcwC2Og8zwMTC0Ut5V2dZqChLaPkVVbMdWQCcV4x1xk5InANeZGwgOZS8PXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170034; c=relaxed/simple;
	bh=meZnHWE/QGGm9bz8zvbWkbtvbXXuQS3tM18f+1xcjr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sqGtgM8Ut9+Pe8ZFiC6k9AEQlsY2ffh9/aJCbkSRfETSJrdjrD3UnPasz8Mu3/oALmB0nHs7NCJllpN2NYpxQ69lfy60fcSOEUQwp4cs3BfKaAbRF43dcWAjzW9M1XTf3rKrTCbGUfxD0UX/aFKFYZ4MtEp+95TC48hnBZQdMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEKCg3An; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEKCg3An"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D718AC2BCB8;
	Wed, 23 Sep 2026 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790170033;
	bh=meZnHWE/QGGm9bz8zvbWkbtvbXXuQS3tM18f+1xcjr0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IEKCg3AniuO3VNlUVCvrLoKH2FEW9oDCO6ceRlc+ovcuO1A7kysPJ/URg3U4ULGFN
	 iLe4pfLzmluTsqMW5H2rBJqjoELSSYNFZ8MgiUnX8vdGCidvSTrqVu19zGc6vUA9Im
	 P4J+Ph2gHIqbZxUwkqAjZY8cXBj0Xnvk0IlzxRJ1TRUZ5OztUXrSCZmPnp1GnlXphy
	 Za+BtxKhpR2BkAKXbbrh1qy3+jRUoxzP5U2c8nrAUzDn+us6R/zEPzuq2Cz0LN61LT
	 iHaAQitR4infwMdtT899ENAOm60jvTW6ifTO4th3tkX7JbNszGTKUcePOm3ufC4BN+
	 IPV6tt2owm+5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3491C9830D;
	Wed, 23 Sep 2026 13:27:13 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 23 Sep 2026 15:27:06 +0200
Subject: [PATCH] Input: s6sy761 - fix resume ordering and restore sensing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-s6sy761-suspend-v1-1-6fff96e71cb0@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz7UUAiRtr4IYEjDUHVIUE9QKc
 XdSGN/w/wZCkUngWWwQaWXhT8gobwX0LxcmQh6yQStt1ENXKEZ+1pQoSWYKA+ra2Nqre2O9g1z
 NkUb+nse2uyzJv6lf/hvY9wO+yPrUcwAAAA==
X-Change-ID: 20260923-s6sy761-suspend-24674b0857ba
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andi Shyti <andi@etezian.org>, Rob Herring <robh@kernel.org>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=2egtGbKgJE5/CltCrUVj0shGecXcgN246NO7tAqGS1k=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqs9Ow6ZfUciwK2ClUZoSOMbs50o34eBjqLyVD7
 WuYjzDPwGiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarPTsAAKCRBgAj/E00kg
 cjhpEADH0aV6ANCnG1fYUyzT3YX4F719uv6Tvu5H7tMkmRZH/LKsGd+UJSCT0L/PacXI8spI2Hd
 cSC42TiaY+zI+Moe59onVyFQdLX3B644Kaa7AEGcVdPJXxTeW38Gj4vpMEW+7+frU945hy4F026
 TwzuCAzTPaqEho9df7Ujzm6hU01b2r5Jw1FghGVMI7YgOzs/Tf7xzVxQI2kHINS6uZr9hZQKl25
 /wONlvTHeKyLHX/t1mB5GNylYGBouHnF0OxjnAsvTwWhYLwM+QQmX5P/MBzBeLIPWt72TpX7qJB
 R+3oYYUT+rPXgYG+MaIYcA3wqkFZ2Ni+VVzAN9brsQvJJWvUffwstKHhExHGf7qg6hgIMi3uyn6
 MKhOONSxcv1Zp/BBKITmwdn5tEEfe7wbsFIpgqssDeAf3Fzi/mgu/DXbMUQDf+uvdgQjthEV1To
 AR6XbmtikA5xaoRjkhZb8SB5FOwA+5DbD531FePRV8tHeItUlsKq3naOqZqLDA6+3l6LFCd7QvE
 u0z3NT1Zy5t9N9dZzDYFHLMsOeNvAZIoGKQZ1zzEWs8jtpZGu8619nt2Ukre2iYqkz9yzpXNJpv
 /3FhSMlJEqCqA+KVHrKjkXgqujLf4P6e9dvGbwhkxiwEfRCHGSJi9lRlXF5DewDINWk34Pzx2os
 a29tmGOUrQexMxg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

System suspend powers the controller off and resume powers it back on,
but the resume path enables the interrupt before s6sy761_power_on()
checks the boot. The firmware raises its boot-complete event on the
interrupt line, the threaded handler consumes it, s6sy761_power_on()
then reads an empty event and resume fails with -ENODEV, skipping the
touch function setup:

  s6sy761 2-0048: PM: dpm_run_callback(): s6sy761_resume [s6sy761] returns -19

Power the chip on first and only then unmask the interrupt. Once resume
completes the boot handshake the chip comes back with sensing off, as
at probe where input_open() turns it on, so the touchscreen stays dead
after resume. Send SENSE_ON again when the input device is open.

Tested on a Pixel 3 XL over several s2idle cycles: resume succeeds and
the touch function and sense status match the pre-suspend state.

Assisted-by: LLM
Cc: stable@vger.kernel.org
Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/touchscreen/s6sy761.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 0f24a9b730635..c52c45a7d1029 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -495,20 +495,29 @@ static int s6sy761_suspend(struct device *dev)
 	s6sy761_power_off(sdata);
 
 	return 0;
 }
 
 static int s6sy761_resume(struct device *dev)
 {
 	struct s6sy761_data *sdata = dev_get_drvdata(dev);
+	int err;
 
+	err = s6sy761_power_on(sdata);
 	enable_irq(sdata->client->irq);
+	if (err)
+		return err;
 
-	return s6sy761_power_on(sdata);
+	guard(mutex)(&sdata->input->mutex);
+
+	if (!input_device_enabled(sdata->input))
+		return 0;
+
+	return i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
 }
 
 static const struct dev_pm_ops s6sy761_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(s6sy761_suspend, s6sy761_resume)
 	RUNTIME_PM_OPS(s6sy761_runtime_suspend, s6sy761_runtime_resume, NULL)
 };
 
 #ifdef CONFIG_OF

---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260923-s6sy761-suspend-24674b0857ba

Best regards,
--  
David Heidelberg <david@ixit.cz>


