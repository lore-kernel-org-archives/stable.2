Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321F3C0A14
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152596; cv=none; b=VcMjtMMdy8SGcFD9XTj37nTYvlmFIRexZrb1YduICGVMKBL4CKKdY3Dt/1JynmqY96FzkZqWcxfI0Sh6U//M9IBdOKQ8WijwVlf0+QjbGccbuvIz/npZtBvIptIutqLSLbKz6bsMgqdOTsmZoA2vo5k/aERPZPLC9Pks7a/Cx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152596; c=relaxed/simple;
	bh=1qLtqv/HQP/ho7fTNQ1guG8sR7HixupGcypPBGfeEXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iozvcdd3Lb3BoXS7Lr+tUDeQlfm8k9IdybgbphGLqpUsCvAfo3p8o5Ucnme8q8sgJhpaUQZrSxDlC8UOH48TAQeZnGPAMkJd/WhEeUg56bbnhCqwG/9vsLi42/eENHSwKeaRHswlpCn+xNA38akeoFlhu1Y4zIoltxWRgOyTKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stephanie.is; spf=pass smtp.mailfrom=stephanie.is; dkim=pass (2048-bit key) header.d=stephanie.is header.i=@stephanie.is header.b=TRjVAoRR; arc=none smtp.client-ip=95.215.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stephanie.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stephanie.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stephanie.is header.i=@stephanie.is header.b="TRjVAoRR"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1qLtqv/HQP/ho7fTNQ1guG8sR7HixupGcypPBGfeEXU=;
 c=simple/simple; d=stephanie.is;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787152591; v=1; x=1787757391;
 b=TRjVAoRRvedekhyfuketwIweJcfDBKkkN2PouqF+5XbTmUSRSZ78n3lvjs3v4mJK1/OhBQQT
 zXFNTVYa/cmW9Hf75zKho0RNsKrAKpuW9zOSja+qYUYH/Q0ydbvHdZhwR4PuWkR0AZ0c7q+tu4O
 aD82zNSYcJ2P6Vfmqkpmq66944aMGm4SjoaEm5ubHpbsNRTV8f9fJcWYIR3v23iyRfDT1rgISTO
 F2su02ktVSNusLpSr1jtofN553OkSLNB43RrRwDXOlIyp7FRA08aPH1/x7j95nk6dm0F4csDo4v
 s0bFfNmPiW9zGyw61K6vms8opgCRzimcUzUMx4yN/jxxA==
X-Envelope-To: stable@vger.kernel.org
Received: from arisa.iscute.moe (2a11:f2c0:acac:10:1a1d:eaff:fe51:9041)
	by smtp.migadu.com with ESMTPS id 60e1cc53a49542b8;
	Wed, 19 Aug 2026 15:16:20 +0000
X-Mizu-Trace-ID: 60e1cc53a49542b8
X-Migadu-Flow: FLOW_OUT
From: Stephanie Wilde-Hobbs <git@stephanie.is>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	stable@vger.kernel.org,
	Stephanie Wilde-Hobbs <git@stephanie.is>
Subject: [PATCH] HID: lenovo: Re-apply Fn-lock state on reset_resume
Date: Wed, 19 Aug 2026 17:16:09 +0200
Message-ID: <20260819151609.68209-1-git@stephanie.is>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a ThinkPad 10 Ultrabook or X1 Tablet keyboard is reset during
suspend/resume because the USB power session was lost, the keyboard
firmware reverts to its power-on Fn-lock state while the driver keeps
the value which was in effect before suspend. The fn_lock sysfs
attribute then disagrees with the actual key behaviour, and the Fn-lock
LED no longer reflects the state.

Re-apply the cached Fn-lock value in reset_resume, the same way the
compact keyboards already resend their configuration. This only runs
when the device was actually reset during resume, so a warm resume
which preserves the keyboard state is unaffected.

Tested on a ThinkPad X1 Tablet Gen 3 keyboard.

Fixes: c87de33ed43a ("HID: lenovo: Add ThinkPad 10 Ultrabook Keyboard fn_lock support")
Assisted-by: ClaudeCode:deepseek-v4-flash-0731
Signed-off-by: Stephanie Wilde-Hobbs <git@stephanie.is>
---
 drivers/hid/hid-lenovo.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 3976d7b53b14..1ca58610e425 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -1432,6 +1432,8 @@ static int lenovo_probe(struct hid_device *hdev,
 
 static int lenovo_reset_resume(struct hid_device *hdev)
 {
+	struct lenovo_drvdata *data;
+
 	switch (hdev->product) {
 	case USB_DEVICE_ID_LENOVO_CUSBKBD:
 	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
@@ -1439,6 +1441,25 @@ static int lenovo_reset_resume(struct hid_device *hdev)
 			lenovo_features_set_cptkbd(hdev);
 
 		break;
+	case USB_DEVICE_ID_LENOVO_X12_TAB:
+	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
+	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
+	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
+	case USB_DEVICE_ID_LENOVO_X1_TAB3:
+		/*
+		 * The keyboard reverts to its power-on Fn-lock default when
+		 * it is reset during resume, while we retain the state which
+		 * was in effect before suspend. Re-apply our cached value so
+		 * the Fn-lock behaviour and indicator stay in sync with the
+		 * sysfs interface.
+		 */
+		data = hid_get_drvdata(hdev);
+		if (data)
+			lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED,
+						 data->fn_lock);
+		break;
 	default:
 		break;
 	}
-- 
2.55.0

