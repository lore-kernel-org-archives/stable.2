Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803212;
	b=IvXWHQ0cx5+YvabAG7Ao2jBLvt4oUiO7772bDUNqlXkEhtA2WYyhw5g7LDAoQnVN09Fo
	 PqXXB8OL8hZqeLiAHjNix1Ze8/4kRKyg8j/51+805cYJ2Dm46j0oKJt9S4ibbIX7J0/ZS
	 N++cM4wSW9UOXuXa8zfhU8YXd1G87ACPH6bYXlCJfJFHOTZksE5vSYsmwMDz13BnAIbWC
	 3K9WCArOcQYvlGmXC2c+mxg80e6MRuvWSVUCNZq58Qhj1t2dtNznOvB70O1C7NNLZ2hN/
	 lf9/Ly1HXCbpqul7KGWFueljP1BzCapISoIPW87ciIuQBa5ZXRjPOjH2IXxqdEgF9qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803212;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ylRvma0PNW4DXbtPX7FJu+DVe8kiO8yXzKptJ/vhwsc=;
	b=rDGz/+MoXyolu2/T9y07GJ6kha2iYKRPzdT0/zF5BWFrS4uHSAyl9z2chCn0hr37LKwu
	 Pq0n2DPSMYYSgtgS91bA44QYoeyW20waHrSO2Osv4c6Py0ushoPX2+T4ecTMVYK+stLv/
	 t7LHkGpqvDdgfwGo3pD1cOSrVIesbOfRNFfTfFT/64lzKKEmEBHz7PJRgKMU6IYsZRwM1
	 d34rFblgaq92KhvozoTHliZAqdJMQZmIp3wdfzoonaMUesG5Skm4hVSBlWr5TFvNkJKAr
	 w5eiEe07RTPJI3lv3PTc8H3GEnakxZylzk5FGB1NgB1VIwbefWFL2cWVtvfoQX0NJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZsySYynO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118DC606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZsySYynO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEFC1F000C1;
	Wed,  4 Nov 2026 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803211;
	bh=ylRvma0PNW4DXbtPX7FJu+DVe8kiO8yXzKptJ/vhwsc=;
	h=Subject:To:Cc:From:Date;
	b=ZsySYynOkCLSZixiN5sLWktJdxxTNBNXfmZwnTn4pIDuUX1kojNwKOxQrkLWL9PoN
	 RC9GvO4hfQf2rr2o71+9gtDSHBLsBUzKi7whvcd4MUI+puHMr1XCn8g933aHM8qUDG
	 ZHCSMaKUo5HsqqqjFDa0TIlJC3dbvZNePyTIndxc=
Subject: FAILED: patch "[PATCH] power: supply: sbs-battery: disable polling before supply" failed to apply to 6.1-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:40:00 +0100
Message-ID: <2026110400-companion-hate-de89@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5c1c602463d597c5189ddc5a73dece588ba2c57a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-companion-hate-de89@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

