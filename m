Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246C63CB;
	Sat, 26 Sep 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454410; cv=none; b=G4vr4gGkBUMlZQSCAjnrbMzjCvJNtn5rvIr7z9jb1lukcFbJa70CJTtk2BtsCMew9NdPUEy9YMI1XkXmG0OMapg52hjBy6g/WP2RSWwlcMtq9Znqj1DQQDxeRBy4Wf41+ANTC/UdPukNzNHHSOn2MNOQOphWVJEeQTNKmETRkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454410; c=relaxed/simple;
	bh=cS0QdhLNkY9KqLzjGfE/25az1mVmYzQU0keGJqcZq38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VHRkHqsqB3yfBd1yhr2+zKDT4Z6G4vx6lySIzQ3CqM2Zd9R8gp1w+tTX4VBLcxz+wstRcxH5CW1u4xd+FOUfMh5VVX5rg1RQFMzPwPVb63Xz/Q2bC9oND7kUfk6Vt3gY7x50F88ewK+pKeZlFaiSghn882w/Lw12BaPfcE+et6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYqAIkE9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYqAIkE9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 958FAC2BCB8;
	Sat, 26 Sep 2026 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790454409;
	bh=cS0QdhLNkY9KqLzjGfE/25az1mVmYzQU0keGJqcZq38=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FYqAIkE9EqpXw7t5fJC0GVr6ENvaI8xJfZLAgqkLsJcctHDdBDZbM2atOsH7Q1I27
	 mKrzlnFFo909c1Zv7vRpQB28WxlB8ETyMJN8OWiLb+alDP7NrD62m/12WoaIzOM7Sh
	 57QFSYzP2RFzYGufXyr8GPSIFouaDYdhewtFZdhGUIREF25BK//6nM0/fWq6pybdJ1
	 Stj5EfRWR8pgeLcV/waJlK9glvndM2eqakA5VtL6a5CTOmJy1cI83BwmsqgIWvwHHw
	 G4p2VYCg5ndR61qr8Y/XRbOS1hjS0nfpoD3K2WfLHS8xfTg4JYWRz9rWb3YH18lzdn
	 LXyAn5nn+m/qA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAD3C9832A;
	Sat, 26 Sep 2026 20:26:49 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 26 Sep 2026 22:26:47 +0200
Subject: [PATCH v2] Input: s6sy761 - fix resume ordering and restore
 sensing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0JmbU1bsRVX3sOwoGUq4wJIpxCQc
 HcB1y5f8v77CzBGQoZ7tkDEkZi6dgN9ysA3VftCQfXGoKU2stAXwYZna5TggXtsa6FzY3Mnb1f
 rKthWfcRA01F8lj/mwb3Rpz2zGw1x6uJ8XI5q9/7XRyWUMCGEwqBV3skHTZTO/gPluq5fbIySR
 74AAAA=
X-Change-ID: 20260923-s6sy761-suspend-24674b0857ba
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andi Shyti <andi@etezian.org>, Rob Herring <robh@kernel.org>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2550; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=zam6eeZKJN3iy7FLZYqEzX+RoG2h8gfBIV6S+jPTMYo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBquCqItB6OXXeLTO07zF/aNObgie6pXfvp/zXcC
 zuQCrStHxWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCargqiAAKCRBgAj/E00kg
 cqI3D/wKUm1IG782wR+Rk+uc2OaP3CIfhd1+ZBDvW0FB5RqTvXHF+TquSmHjSF57RxvHre05s73
 +gRed7O8MXuFKQ8mHiBghTNJQTlxgha2mPm65bIpVERb05naperVRvgdXszbkei0AAZPdWyb8x7
 WfFaXEt7vDoK0TdpYmoPADBk029kj5sIwSoIf2C9dywTp2127bAjgDG/rBBiL6ayAY5SKTBHsS8
 Vo2giTI2IMUmb8QkCvy5yy2ALez1TmCVwngHWKlnRtRR4k8zPGmckUtqR4aC23iJ/jKJ6eIuH2G
 eTc4ZKAJDgI+KuufStFcNtfPueBsjXxzngZj6Zj6VEN4nFu/WGBjo1AWbdxdPNMmXsMl8L5VsTS
 Ys1A6FmRkUDBH4mFbpiHBE1wTBiS4m48xhyfYPy7Bbl1BGK1RrZV/Yo1yAZ1Kcu5tkt0qqFZb/P
 NZMk5GL7c+y6A0ztmVoHIEBdIz1hZ9SW1aKQZxHnmfOjgfzOCgXui1kK9fYGLjzdrCQVlc18Y/8
 KvwzxPpnKfuC9OL4leGUQS+pH0mrK+FOldq1v5SSJdopODAY2obzKk+HckeKhPwFY/xyaeyvfPx
 nlD6AS8pPHw+EB1U4mMPIWFFAzBlwi509DheTMtkmqgX3cXudm6B1Jf2g25164nnZVHEeP9xZQ3
 gfnKKYF9czjMEfA==
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
Changes in v2:
- Explicit return err in _resume. (Dmitry)
- Do not enable interrupt when power on fails. (Dmitry)
- Link to v1: https://patch.msgid.link/20260923-s6sy761-suspend-v1-1-6fff96e71cb0@ixit.cz
---
 drivers/input/touchscreen/s6sy761.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 0f24a9b730635..899c179fb2d31 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -495,20 +495,32 @@ static int s6sy761_suspend(struct device *dev)
 	s6sy761_power_off(sdata);
 
 	return 0;
 }
 
 static int s6sy761_resume(struct device *dev)
 {
 	struct s6sy761_data *sdata = dev_get_drvdata(dev);
+	int err;
+
+	err = s6sy761_power_on(sdata);
+	if (err)
+		return err;
 
 	enable_irq(sdata->client->irq);
 
-	return s6sy761_power_on(sdata);
+	guard(mutex)(&sdata->input->mutex);
+
+	if (!input_device_enabled(sdata->input))
+		return 0;
+
+	err = i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
+
+	return err;
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


