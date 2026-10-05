Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157C423E98
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191058; cv=none; b=gPDZp+oZ7avrETQtmaF2kjakHdr9FuWdnYA2a6D2gIAMgM5SWC3vddcXZI3lX4COCVhMPetrCkhp8Q13lnBCh6Rdsb3VfucivsPFKcMTU85YK5G/pkvGnuJTkahb4wsmk8WNQndp1yj/X+bAOO7jsKAtfOqUR42oPJI8n8m0ByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191058; c=relaxed/simple;
	bh=augZfpsje6a7wQkecCXpuihv3YYu4uksVretngbx+bw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H2HZOfzkex2Ou+s4jf/QQcXTlSgGBM9QdMGTj6S/jbEvDOGY+AOMpaMjgnwo/bNVGMWoFPfvlmnKQNutZ8QdGlsGW8juEfwAc5RfqFukwKOEFAVbLfDBZ2AaV8CB0gr9H3Zi6ko30UP1rcPkuSCmLacTUq5zTHioJGEXqVGsGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2kMJLrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2kMJLrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDBA1F000FF;
	Mon,  5 Oct 2026 09:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791191056;
	bh=rE0SogJz2lHVL2G6Qbv71jtz8xZNOcPo0aXLWMdlozY=;
	h=Subject:To:Cc:From:Date;
	b=D2kMJLrx5TyIghPs8irvAmpkMQezpOLf9EvZj27XdadwE5FhFGb8sQwWYmx2OHfyg
	 ylk6THPh/SSzkobxxessUknukmayY3XOIwnqdf3ucbvdrhLMY6DsNVeUIx0iaJ86Tj
	 S7qt6oVRKKEtTwHCk8fjTvPKF9jNq3SAzvMmlxMo=
Subject: FAILED: patch "[PATCH] Input: s6sy761 - fix resume ordering and restore sensing" failed to apply to 5.15-stable tree
To: david@ixit.cz,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 11:04:13 +0200
Message-ID: <2026100513-squatting-hankie-9c73@gregkh>
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
git cherry-pick -x a215720959c5450b3699e243904b39c3f8f68888
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100513-squatting-hankie-9c73@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a215720959c5450b3699e243904b39c3f8f68888 Mon Sep 17 00:00:00 2001
From: David Heidelberg <david@ixit.cz>
Date: Sat, 26 Sep 2026 22:26:47 +0200
Subject: [PATCH] Input: s6sy761 - fix resume ordering and restore sensing

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

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 0f24a9b73063..899c179fb2d3 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -500,10 +500,22 @@ static int s6sy761_suspend(struct device *dev)
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

