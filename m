Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803201;
	b=N+gdQZ94oovxzOK+XbfV3rhYZUUoTwoHPalDKNPszPedW7MqGwwmq13Tp/ODmxCmA6Ei
	 tVem81Flw323mWPMyckzurhgOKXY8X5j0T8u+n0++AQaf4H/KaFQ3iT1E9n5K2kSTWWso
	 ZppLhaRMBD+eM91raa8ZqRDQMD5GCW+4Znp6I7prFrG/zw9cEhEDwwhX2kHm9bWnVbtMJ
	 U9fyYpOPc3QVLm2cs2v80hPEwKa7zh4Qshi8wx5QoX1lbjk0NNKxNMEELuQ7L1/UEXzyU
	 79YEZVw1vhVeoJ1UfKK7x5m3kmTvHONOD8nKnboHPlYHjJqfUDLdBia0HZKME1E8JgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803201;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Iv4STDTwjSbcPZ7tdIoiu8WqPht2hfBHjjQiA65MwfE=;
	b=KqvmFM2Z8JxWBnuXO1A4vMH6KAmMrCXacYtEHHgdrzVmBIUx5vYLQsAqmpETAlMisxuw
	 5NiKZTmVnSHkcXgRr8QRjgvzz9rUE8I2ZBGMTZ8ta2ztc96mn+OJt9bJh3thvwaptBjph
	 tcFtVVPytKops0UXF58Ub7qZhfhJ8Sb+AJLqW7NcuaiQ95mprNBMiWtV/u2sRe4Dt54M6
	 m/4B5MrpNyhejbpqavNre7rowQs2WTONPlFIIfQnBLySTMIh5KpQvp/CKctwv+Uh8vjFq
	 NjqHtXA9+XTOVpPIsCoYswEh5ZADO0bE38DFoouq7r+7ruXiMZ/QYc1sWXKSYl0bItQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=twueK7Wv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED7606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=twueK7Wv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF291F00919;
	Wed,  4 Nov 2026 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803200;
	bh=Iv4STDTwjSbcPZ7tdIoiu8WqPht2hfBHjjQiA65MwfE=;
	h=Subject:To:Cc:From:Date;
	b=twueK7WvqhRT5rnh2F21tqt+93I9kHA8zyxAeZBSRnA5TN+0S3wx3QsEpG+ARrBKm
	 WFE4UXA9ZNJ0QeZvAMCDmjqX5CXJu1RlwpstHHMhoPa8XaO+PPAHseiALkAaRvVHGR
	 FDA34f1xqSNMWdNjf4EM55WNYPMrPqE2QliDnBqM=
Subject: FAILED: patch "[PATCH] power: supply: sbs-battery: disable polling before supply" failed to apply to 6.6-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:39:59 +0100
Message-ID: <2026110459-old-quarrel-7ee6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5c1c602463d597c5189ddc5a73dece588ba2c57a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110459-old-quarrel-7ee6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c1c602463d597c5189ddc5a73dece588ba2c57a Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 4 Oct 2026 00:10:19 -0400
Subject: [PATCH] power: supply: sbs-battery: disable polling before supply
 teardown

The managed poll-work cancellation is registered before the power
supply, so cleanup unregisters the supply before draining polling.
A pending or running poller can then call power_supply_changed() on
the released supply.

Commit 8d59cf3887fb ("power: supply: sbs-battery: Fix use-after-free in
power_supply_changed()") moved the IRQ request after supply registration,
but did not change the poll-work cancellation order.

Add a later managed action that disables and drains polling before
supply teardown. Its retained disabled state prevents external-power
callbacks from rearming the poll work after it has been drained.
Keep the original autocancel to initialize work before supply callbacks
can run and to cover failed supply registration.

The teardown ordering issue was found by static analysis.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20261004041019.1123723-1-mhun512@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 501c8e069755..6714313bb3a3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1068,6 +1068,13 @@ static void sbs_alert(struct i2c_client *client, enum i2c_alert_protocol prot,
 	sbs_supply_changed(i2c_get_clientdata(client));
 }
 
+static void sbs_disable_work(void *data)
+{
+	struct sbs_info *chip = data;
+
+	disable_delayed_work_sync(&chip->work);
+}
+
 static void sbs_external_power_changed(struct power_supply *psy)
 {
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
@@ -1208,6 +1215,10 @@ static int sbs_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
 				     "Failed to register power supply\n");
 
+	rc = devm_add_action_or_reset(&client->dev, sbs_disable_work, chip);
+	if (rc)
+		return rc;
+
 	if (!chip->gpio_detect)
 		goto out;
 

