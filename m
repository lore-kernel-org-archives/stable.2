Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A4749BB6D
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327688; cv=none; b=gon91Jjzy7i7TABKs3USog8A0kPwrQXGbJe3bX0qU+q3bBReNaH/fPyHsV9BOuulJ7gzxe1b30OVgfVg6wuqoDOFAzTSbiZT+GqppvVtm7N3sFycGUpiZvd9heeU0nHI1IxT+43Qy/BAvwfPJSoVfudMCar5+rf1Fn/LYeshDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327688; c=relaxed/simple;
	bh=KWNhaqXlqeub4WAFjIf/rh7HaSpvWJdsUc+sIUUddi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl1/4b2TcMKBobj//i9/T2yxexepsIxlFgrs0qNfAmZa9JXlstayRsoTRXJycH3mqiBiSAkLCoa/QbHbVHUSKLEsXldgvStaAiSQmOPpSsEu8SQxmolxdU8pQnKQH2/2J9vSB8JiCmcJz0M3OuNAYqPXFxNSW91oxL0ibWK9xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA3VLeO0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA3VLeO0"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so384212a12.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327685; x=1792932485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVc6a37ymo5cyc7MbRfnER++to5FQn61dzC2ih17HV0=;
        b=FA3VLeO0zyonyrkLCQBzgJQLz74AnMhfFSTEQGcAwvzfYkvewVSZsfkN4n0bIchavK
         RwoptaEeP8yURaejEMd3OUZUjZYcYt/9RTaznIhArxQsSOW6bLMlAyxfJmr06cjQAfas
         vxcFBgrBF2kRKd7unkEU3hR5KfGrtgM306HGtzDw2JPu4iy+M9Cd4pZ0OqhZBMgosidV
         Tf44W+aHUx5QvZt3ANpqjhDSYDU+ccX8rMv/MZllCIi5vth8ndEN40t90lZ5D0QLVzg0
         D41Dou+LmeEx6sIoleVl4vbjDUqXGb6Y8b6Tz64DmtIZpVuY2HXo3O81uXd9ytuWUMd0
         I2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327685; x=1792932485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZVc6a37ymo5cyc7MbRfnER++to5FQn61dzC2ih17HV0=;
        b=aKoKwN4wMb/4Qn7JQWU/k+VV8glpHc/B/Pn6Kt3Z2RZF/7MqCDiQwmTJhY3TfqjXeb
         c94p7iL/Rb3Fz6IgUIGw7SMh5R9rXyqXzqiAtaW2U4Mcpadb0N0+Ry+7SQP1a7+GO4HV
         PTJ0LldcHVIK9VnuliEgQs3uzmz/a4/bpJDqb0IFu01pWfG5ajLAYquuo8zupj4qtgAw
         r0Gx6DTVS3GGvpX3wXV+8oqY4dYvNMGIlmz9WOe0+oW7+rb449i3WHP2Y0GHxYJskIb8
         osuIAJn6LHZetZRSJVhSSC1uotaNq6q31JEeFwUxIQubUsH/j1Bb1J9O+PgswGkAdv36
         Hc8g==
X-Forwarded-Encrypted: i=1; AKwUvBztedvYxprlPim+r/mARmw+J1c4yH58ZSTxvhFrd0ckNkn54VGNG1kMMy6ogJ3jm1Ar6Lgu/Cw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2pQedTjGp3lj/f6johd5zNC6kiyDs6pUXDEIo7NNDFTetqTz5
	1K82CIH/rgL0gWbr+vvXxdnrETstY+l62Z4AYhN+VgfZy4bS4/U6BYLN
X-Gm-Gg: AYBFou2LLfzQXdymhapwnE+xk0wcG9TY7ybqeRDGjUpSsrj9oaGbbTXF8nt2PcoQlQJ
	Hp1O9PlEQ8WJaP9jicDJakBgVkQv3E+nITAR3mV/3+E1mIgDAr4WUtwvOeio+5sBANwq9spvpI8
	H9u9Hg9wn3s9o8c/JL5fE/9q2AFT2ZFeSMEWdyjia992+KqG1YkIgpzVjFSJBhSBMmcme+EJyHS
	XBWTtbAa7tiBi4PFezSHjIe5sZAyJfpwCcw2AUjmqSyEULr1rjDognF6gWzuBaNAMuC3TO30K1j
	OX+4x3Ywfm5C8npEwe0ZYIICA/rxcHjLb16UywC1eiEwLGCi5ynVNQuYuv4rK/BP57m5JdTBpr4
	fDra05Re6Mjx339WUl61gXmTF1vf77JmYjNppuELBQkJ7BxrTAuco1H88Bx062rHULJlUEaTnca
	9DPqugo1F/W8bKojIBn104mjqVtCXN0/fJBMskTYZ7N8WJVAn88uFlNMGM8TOUvOVpSpmPMqVlI
	eOCQVjxyDT+zbhmizxOxRg=
X-Received: by 2002:a17:90b:3b82:b0:3a7:cffb:8b96 with SMTP id 98e67ed59e1d1-3aceefb00fcmr4343511a91.18.1792327684749;
        Sun, 18 Oct 2026 05:48:04 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:02 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v3 1/6] HID: wacom: check the input device in the shared report helpers
Date: Sun, 18 Oct 2026 21:47:50 +0900
Message-ID: <20261018124755.850888-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_report_numbered_buttons() and wacom_wac_finger_count_touches() are
reached from several report handlers and use the input device they are
given without checking it.

Both can see a NULL input device on a fully successful probe. The report
handler is selected by features.type from the id table, while the three
input devices are allocated from what the report descriptor declares.
When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
wacom_setup_inputs() frees that input device, sets the pointer to NULL
and still returns 0 - the "no pen in use on this interface" case.
wacom_wac_irq() then still routes reports to a handler that passes the
NULL pointer down.

Reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write:

  BUG: KASAN: null-ptr-deref in range [0x290-0x297]
  RIP: 0010:wacom_report_numbered_buttons+0x37/0x210
   wacom_intuos_irq+0x29e/0x3300
   wacom_wac_irq+0x1b59/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

Check the pointer in both helpers, following the convention the driver
already uses in wacom_tpc_irq() and wacom_wac_pad_event(). Log a
warning on the first occurrence so the condition is not silently
swallowed.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..567b01882eb1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,12 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (!touch_max)
 		return 0;
 
@@ -4226,9 +4232,16 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask)
 {
-	struct wacom *wacom = input_get_drvdata(input_dev);
+	struct wacom *wacom;
 	int i;
 
+	if (!input_dev) {
+		pr_warn_once("%s: input_dev is NULL\n", __func__);
+		return;
+	}
+
+	wacom = input_get_drvdata(input_dev);
+
 	for (i = 0; i < wacom->led.count; i++)
 		wacom_update_led(wacom,  button_count, mask, i);
 
-- 
2.53.0

