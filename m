Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803210;
	b=yQHyiJcPV21fz97J1AVt7TLVPJSlpCgjQvUBwa3PTYnNNPCPDNVDMOUagVK5w+sPAKzr
	 8PxVzYo2K68YFGKiElI31WaVEL/GHYI8GWda5LdGcLxC24PCdrGwHtVx2SBVJfYnGhPQy
	 DWQlSopI8DS9IG7iUTOm/utPAWCvEkM/2dj9qW7EMO40IsrBPYsJKVhXWuUSPAW1HdPR2
	 bc9z4dulCLRkQL/MevVGNiUzlk9i6ePOwgW27g0df4dPMANVnJDdxVWmrHtsylX785V/o
	 FsYjaFifyt3Co+0COopZJcmyZZbyXPtFV1IBONhNXub9qsBZ1unUS3F/ChOw9Y/ZHbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803210;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JOUvg3JlCF3aTnLtf870TwUeolnZ/qVmJ8c/4salg+s=;
	b=mEkED5ExBn76g78KeyfT9zDlvePd9SvWugaVahrqffmTn4b1UXCQz5/uHXNM5vXNkKw7
	 2kPHJfWqalZ38J20ma0Z5iXUVfI5Ctd0xv8YB2AEDYjssFBafOxyAPGzW+FqAuUaRlagY
	 PqVtZHksYK+d/o1bI2webc/VluNbwwvY/sHZYuUq3l510syBzYOcPpaQBa3DChaCIQzMH
	 O6ct5DPCe4c3HbkDayJ9CE97EHXVNwc4jN807Cyy1lOTc0lmw3IDzuPQKr+hStsKw5SPq
	 lJegE7nY8VcoV+95JQYGyF3RseSb5/pzTltdNgY1u4cToCNxkuZi5CZXzwfl5pIn1sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gvbti0FM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E007606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gvbti0FM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C5A1F000C1;
	Wed,  4 Nov 2026 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803209;
	bh=JOUvg3JlCF3aTnLtf870TwUeolnZ/qVmJ8c/4salg+s=;
	h=Subject:To:Cc:From:Date;
	b=gvbti0FMFYm/A2kOI7elFnYZPMfyrVLRI2+Vd3awdTE7cc0a1Iu23yMRWvNU7nGUu
	 JmYMWN6Aa7OML/CkifXSrwFGRAvcR0pRdFgn8JOW4AlH/I6310MvjR5cfdJI+sZLKN
	 IJ02zB0zEuqTF575jNnatzegwOB90bZDsV7SeeBg=
Subject: FAILED: patch "[PATCH] power: supply: sbs-battery: disable polling before supply" failed to apply to 5.15-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:40:00 +0100
Message-ID: <2026110400-sled-identical-a8d1@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5c1c602463d597c5189ddc5a73dece588ba2c57a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-sled-identical-a8d1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

