Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609031;
	b=UvwdnCH49+jHgNeoo19QLrNHgaEPN+1Ux1pJOXg5oxuYaqaVfWcFA20CfFgwaaFAhln5
	 6bkliplWfSfemTlUYuvkp994cMGoj0dZT3MvSmkyUKwHvndhUnvuRk+RfVgJ78RoJ1MsN
	 FlYO1WOgl2NXWID8fbQhuEFvuS4Tq7ZurzqCHVA2U7Q5eO5kjG6eIA01UHaEJ7thEKxi2
	 jz/TVo32myVWrCkH8LrB+LSnBVc95zwT3zvV1udjCq1IJOjZowZ/37mrw0yTuPz25R9Hs
	 EpXzDMdqbqagcPeCA8FDJA4NVyWfN2MHKdiKb/Xj6ONRzdi7LcXg6lLb2YXlLxI0Nkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ANnF4gP22dTclfpg2OY2BM2KOhGsixC07z+vMijIrP0=;
	b=FgoeBxo4DVSOOdrLAlnRLB+wrx/KUeFzDOtaD3UYZJUv1tK/VDHAKsGMrwKdcqzuXl+V
	 0IGrWdUfoRHc7QGLIvhZBxt1Xrdf0psus8B/eL1l1mVAbtVblyp6nOVOe9cj99JwdQbPu
	 6Lscztptpl16Y7peY3+tGkCXcW2NuJ+p8GeksPWAi65goC3EG+HgcGYBrzURx4CXvbcbt
	 v3th0NvN0HiEiNlvX9ZtHKvXK/HzlIAQpyoCoNQ+WAvGMEdIsHln0kEiXkNK9rAYa8TLl
	 InP+ORwQK/6qVQTgKWemmlPUi+Zb4p97Q+XQH0d6Xh7EkWLB3E9iy2Zco35O1fnOHtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DUnj++9s;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35364606A33E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35364606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DUnj++9s
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so1051156066b.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609030; x=1796213830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANnF4gP22dTclfpg2OY2BM2KOhGsixC07z+vMijIrP0=;
        b=DUnj++9s5XG2hscZEnhIQe5wBPFC/lhit/pJtQMaaR/NbGITGGbmFb/JlVpMcv2cyi
         /NFfzBXdGbCpLZViRyxBo/NzYka8FVYon4Jptzfr6l8nZcci6ZJKnoTzu6sMEM+goBhV
         cYWkO1+jNiKkTjjYNYa59a553sAn+4Gwdz8QxzcHRmMU5Bqz1P7NrH8thmndrOu+drhL
         MG0ByFDLBgmRYXMixOnWj9KyopQJdW+DH9axs+P64O3pFR4yYKxUf6PgHa1dhxqSyPXn
         T+qGnKeNFiLh3J6ucdD5d/xEATG1CsMCZItSIES6cpBzgoZ5SksqnVEag4vksPFd+kSe
         CDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609030; x=1796213830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANnF4gP22dTclfpg2OY2BM2KOhGsixC07z+vMijIrP0=;
        b=p7EQelobixg4ZzIifFyFSg6S4HmPDsPylfYsHhrTT/64ydwOGsDu/OK+NRPwkI+zML
         MdypUPGtt86Ggxe4c2Jfor8ttklk5KU6OrAAk6sUDcEN2IPEsZDCIUwF5pdWSlPDYU7h
         NZ6noCajrNWy6yVVTJimLnsFHp2BypXBH+eR2hMJqnqYj55LPHlNB/VELvIUYi1cAgAW
         Nx2AH4MCHKKN+iVXjlxRcd2+M8yahc6ZZtR3TazC/+7aiu3165n8CT3TevrZJjK+QE5S
         TmO/b4BHTvtOw/IUOrtxXbgIvfl450Y5CJEOI1ZPEhk5EuEP/DEF29vUof73R7l4Vqdy
         l/pA==
X-Forwarded-Encrypted: i=1; AL+hErHueq3r8FvIT/bgm2Jgodt13XmzSbkNo+0NiMmBIaSxO9OI/Rd9WR1wJRLWvsW9fSWnMJ+pq4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TUe0cG8DERoo6Lgaa7yvWz3LCJH1L4qamCZi/OHdffahdb8Vq
	7atM52IWPdP5y1f1Qtt00dz36HyGl+4p/t+Zy/GvCwQEYyxOzZhqYQe8UvQknUTSkPE=
X-Gm-Gg: AZFdTZdWp3DUsEo7QfWNcy6WjYbnLM2aAeS89EO9Vy5bAXpNz3RR+j0Rf3YiomM2/QH
	PZfxI80zrKKJiM8zX3d1rcrujNWML/tYqecRfHWRxiRUEf9Yi00rIP26Jo1+gDnEC1dj5KpSBeb
	7Y5yB7miyGnoRLWykM6j9owIzZJFpWxL5DRrWqG+tvj3OOqCB/KeKKbFQdryyogWvKSHlMRWC44
	NNO8jFni6PUmdcm9oOCSoL7lVS8knU5np3iXkh282kkhrnJl1Glpo3lO5KtFlrzCLDrqBcVgQ2p
	CvKQm9UH5uiFxoWPJHLooarpVDtdqnEOvFigSIv/l3xmSrMR9Sqk0kzyF+eQs/sgcRoaxsycVGb
	Loa/tWAKTV5aSA2MDrUBbXlhPy5TyaB6wr/h1441oBGJ4CAVD2Mizfc6Ijh7EaxyVpVqF7s7SdK
	gYKGV+aNDLcwqBTQggjervkU+qIiXUvpQSG3frNsMIVkjwCigyddJCGaC/oWqtJGLyAyLyH3ps+
	iVu8jM5cEffoVvWGZkCGenIFZaap3RbFhzR5xGnDhhOb5OW6qyAgr3mO8Wjh0HJCx+5DeaX/UuN
	Dkla8SLgFxCGKRxMOPmdFQZvAr36HEB+HDuhBNQIC0m6H/QzYB3cc8gwllyFzAM66zwgrWBobbJ
	HNKEnpEkoYA6CCiZxyg==
X-Received: by 2002:a17:906:f8cf:b0:c50:bf14:8ec1 with SMTP id a640c23a62f3a-c513ab4d93emr1021800466b.33.1795609029664;
        Wed, 25 Nov 2026 04:17:09 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:09 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 25 Nov 2026 12:16:57 +0000
Subject: [PATCH v2 3/4] usb: typec: tcpm/tcpci_maxim: fix vbus regulator
 UAF on unbind
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-max77759-wait-v2-3-9914b985c00b@linaro.org>
References: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
In-Reply-To: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Unbinding the tcpci_maxim driver triggers a use-after-free in
regulator_disable() if the driver has acquired the vbus regulator:

    Unable to handle kernel paging request at virtual address
    006b6b6b6b6b6bb7
    pc : regulator_lock_recursive+0x20/0x218
    lr : regulator_lock_dependent+0x198/0x2c0
    Call trace:
     regulator_lock_recursive+0x20/0x218 (P)
     regulator_lock_dependent+0x198/0x2c0
     regulator_disable+0x4c/0x100
     max_tcpci_set_vbus+0x70/0x108 [tcpci_maxim]
     tcpci_set_vbus+0x44/0x100 [tcpci]
     tcpm_reset_port+0x13c/0x288 [tcpm]
     tcpm_unregister_port+0x70/0x120 [tcpm]
     tcpci_unregister_port+0x24/0x68 [tcpci]
     max_tcpci_unregister_tcpci_port+0x18/0x30 [tcpci_maxim]
     devm_action_release+0x1c/0x30

max_tcpci_set_vbus() obtains chip->vbus_reg lazily via
devm_regulator_get_exclusive(). When the regulator is acquired after
max_tcpci_probe() has queued max_tcpci_unregister_tcpci_port() with
devm_add_action_or_reset(), devres releases resources in reverse order
and frees the regulator handle before max_tcpci_unregister_tcpci_port()
unregisters the port and max_tcpci_set_vbus() accesses chip->vbus_reg.

Switch to regulator_get_exclusive() and register a devres cleanup action
for regulator_put() before tcpci_register_port(), so the port is
unregistered and tcpm_reset_port() disables VBUS before the regulator
handle is released.

Fixes: 0c8935642cb0 ("usb: typec: tcpm/tcpci_maxim: deprecate WAR for setting charger mode")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 2bb306b6b1f9..2e6a8906fb32 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -209,8 +209,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
 {
 	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
-		chip->vbus_reg = devm_regulator_get_exclusive(chip->dev,
-							      "vbus");
+		chip->vbus_reg = regulator_get_exclusive(chip->dev, "vbus");
 		if (IS_ERR_OR_NULL(chip->vbus_reg)) {
 			dev_err(chip->dev,
 				"Failed to get vbus regulator handle\n");
@@ -221,6 +220,14 @@ static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
 	return 0;
 }
 
+static void max_tcpci_put_vbus_regulator(void *data)
+{
+	struct max_tcpci_chip *chip = data;
+
+	if (!IS_ERR_OR_NULL(chip->vbus_reg))
+		regulator_put(chip->vbus_reg);
+}
+
 static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, bool source, bool sink)
 {
 	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
@@ -514,6 +521,11 @@ static int max_tcpci_probe(struct i2c_client *client)
 	chip->data.cable_comm_capable = true;
 	chip->data.attempt_vconn_swap_discovery = max_tcpci_attempt_vconn_swap_discovery;
 
+	ret = devm_add_action_or_reset(&client->dev,
+				       max_tcpci_put_vbus_regulator, chip);
+	if (ret)
+		return ret;
+
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR(chip->tcpci))

-- 
2.56.1.831.g720f3f5937-goog

