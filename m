Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F93A75BB
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233682; cv=none; b=NLVBbehGrq/KQAFn1apWqOvbC1h3YXMFn9SS3xrPT6QS7sUwWsNnHEHsuGBH6HIBFLOC4zuyNl9QtVG4HzPMoceZMVlGQb8vgIwuEDonNXy7tQ3RU6kfrEKDmQsSrddD/aR1yenWC9jjiw/bUJYwF+XTobmsBRwaj7VcL/QWrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233682; c=relaxed/simple;
	bh=byHpXya8aQfHXqMN91G0i0/yPdfTQwemZO6BBbPwPuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psaOFc1Rjf7ZJRNJw1pmUdz7mmMqjhwCVQyzWhVvDuxq8X0uLcAdb2ZDZQAy0pLLEdFOir+vIlc7tYbZAQ3+f0Ez+7lI+K6JGIz96gDEXVB32AzYDp3EA0HXKj3m7CRBQQLtNeoh0wBOZGIq91Bdc8T7gTIF0ZkYH0h33YiGYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7WRwPXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7WRwPXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF11F000FF;
	Mon,  5 Oct 2026 20:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791233681;
	bh=WcPwtQOcGizEoZ0B3ghBbrETCSUaUihZXHMSOokE+OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7WRwPXDo7/hgUgj3G3YPLa4QZJqRa16CbwirQqz7qEubOBiz3BiNNYI+g0Wq+7k+
	 Qfqn9jjQ3k121xg4HZn2cEKZHH17HPba777k9o8XzzJWR0Xrvh3SpUUTxPssRPD4Xs
	 E35wvAzQ954IHW8KMvHDjiJHVxPYyqSY400wa0qj0vEwIGRAA/1dkhcYtLaIPor9qn
	 oVajejN1a7/c/vSR/A2Cq1Q/Ci9CoLOqUiVBVmQFP6ceU9CkFpazg0HdJ9i1y8kB+o
	 CSc+wYJlBZ2XeYhsBQYGoiw9f3mP+i9IusaLw4g82mmFCm/G4M6s0L3zmE6B9hcOn5
	 r9LRb+EGDyN2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: s6sy761 - fix resume ordering and restore sensing
Date: Mon,  5 Oct 2026 16:54:37 -0400
Message-ID: <20261005205258.3279498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100513-squatting-hankie-9c73@gregkh>
References: <2026100513-squatting-hankie-9c73@gregkh>
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
[ sashal: Replaced guard(mutex) with explicit mutex_lock()/mutex_unlock() calls for C90 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/s6sy761.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 85a1f465c097e..6f1827cfc720d 100644
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
+	if (input_device_enabled(sdata->input))
+		err = i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
+
+	mutex_unlock(&sdata->input->mutex);
+
+	return err;
 }
 
 static const struct dev_pm_ops s6sy761_pm_ops = {
-- 
2.53.0

