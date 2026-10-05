Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E1348465
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234778; cv=none; b=etiBztdWlcKf70nGpR0sjpXujY79WffXqV7EMykRJhB2eAAIzr1XvZCFmgpd1bfieJg9WA0o83EHANNHIIdKdsyUEQNK0/gGyF3FqwJFfYMPegQSSuNcIL1Y3yrGBDh39mVNNo+nQ0NZ+QIBioW6fYFiMRI3M7jxUJU+G2P0iPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234778; c=relaxed/simple;
	bh=MzB6KXp/Aw13njo8dBlKWh6U+TjEs+4KOxc5DCiLkEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+tVba9jDNQqHnarvp65RoIo0p5hDMP+hkRj6nJu4EqfnAH3AmMin+8jr7NJ0osGZflq0iIuPah76EAerLVAunAR6ARcC0CPwV6wzjVWAB+MOLFaAZ9jCyl90rXFPWU10VNJWOT+wwjDMdriBY7QvAGSpcA0I8ZTMvMQzEphSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZhVGvm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZhVGvm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276271F000FF;
	Mon,  5 Oct 2026 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234777;
	bh=sAp/YzoX2xB5O9uNV2Tapl8UidRrS4DluUjeKDuiCVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZhVGvm09v7EQp89g/ypcLalTeCCkycUQajKzyWja3+47TFOyWtc8gO4UzxTt3pFK
	 IuOCWPhiDZCPaAIDTeYY8AgewMBWSU3jbpyDdeE3Uo/mFklXe7h8Hpd+xsXlnxKlt5
	 5cYpSMwsrFfEBoSEjbTqyhpAL7xwXq10S5S0TBMTHfNettwRN5BPS0aX6tyaVsWreq
	 xqzqidXZtNkj2VS45vSNGsABhXWsW6uAnztv4TYXdQsYZJKE+Y782VUM6CR2CwOyPO
	 f6KlQxiZdl7TccgFoYC/kFhff7RIm/gbo12xPENfLPIERMMftESmZNexGYs+U73pJt
	 3EIKjEzLUP6TQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Input: s6sy761 - fix resume ordering and restore sensing
Date: Mon,  5 Oct 2026 17:12:53 -0400
Message-ID: <20261005211142.3350481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100514-edgy-zoning-a6a4@gregkh>
References: <2026100514-edgy-zoning-a6a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Heidelberg <david@ixit.cz>

[ Upstream commit a215720959c5450b3699e243904b39c3f8f68888 ]

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
Link: https://patch.msgid.link/20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ sashal: Replaced the guarded input_device_enabled() check with sdata->input->users under explicit mutex locking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/s6sy761.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 85a1f465c097e..459513b5da61b 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -510,10 +510,22 @@ static int __maybe_unused s6sy761_suspend(struct device *dev)
 static int __maybe_unused s6sy761_resume(struct device *dev)
 {
 	struct s6sy761_data *sdata = dev_get_drvdata(dev);
+	int err;
+
+	err = s6sy761_power_on(sdata);
+	if (err)
+		return err;
 
 	enable_irq(sdata->client->irq);
 
-	return s6sy761_power_on(sdata);
+	mutex_lock(&sdata->input->mutex);
+
+	if (sdata->input->users)
+		err = i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
+
+	mutex_unlock(&sdata->input->mutex);
+
+	return err;
 }
 
 static const struct dev_pm_ops s6sy761_pm_ops = {
-- 
2.53.0

