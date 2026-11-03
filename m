Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700748;
	b=VZsFWGeFMSO7trWJIwh0XVQiTY7QUfABULgA0UQ3NFG7IR4fVmUL8+keR14+SfduTTIS
	 ntjyg5eF72di4XbU334RF/da3EtyzIRZoJJDmvCew7BYlVld8bYvp4R3Vr9ozQdRmExFY
	 Npe5LZ80OHvhdWsZ4jZk77g/NUVUySWphKW8/6QTUTVabh0siit/sduZbpP834ffhzT6m
	 8DsNzaElFi8Kdwd5rh1FpQN9dkLDVQqAbEsBBpkEqJAdiHnEqbWLK8Ln2AufaS2WlDR+z
	 2v811DPhDEZdMwC5K2JbBRATxME9ShiFDAR9IHgdspK0J4vY+j5EWF5KK5QkC4EuAWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700748;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ow8yH0V5ZwJSUaoVpjAdmyCtMNgOinLdFqlRQvSr7gk=;
	b=FTKV/rT2WfUAWbbCUIaiHrXQBufpKcFrtIkep5qG8P6puGqwHcFnP1xgfoqHQi1bIDH1
	 WaWkPAGdna6zsTji2e9iqf28eFKtAkUxmcPNBsENTeaNFal6oQ63XuGqkWJ6tXt7Kf2Il
	 UzIyUJhhuKPzB+pdDeDpBvR/Kz3zuv1sCyKk3TFA94A++QTS9k5aCYciI1BSmEBzNoS8V
	 JH/hoDaEOdqjn5W27RT4pk2Hl0TrRpbrZHZ1EExHYFUJ8oNyGQZ8HapMqdBzyOm3MgDUW
	 lwlUww4GL//tt05m3MFT1Kq4Gw9YVxZ8PEkXd2GbHqwukSjCcuXtnttecAu3CQSoqNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qTZL7UxX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EABA606BF9C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qTZL7UxX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB031F000C1;
	Tue,  3 Nov 2026 10:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700748;
	bh=Ow8yH0V5ZwJSUaoVpjAdmyCtMNgOinLdFqlRQvSr7gk=;
	h=Subject:To:Cc:From:Date;
	b=qTZL7UxXiSW9qLai6DpKJu8tYU0R4CdLeh5whrfLb2Tz8NzOt7dhwR18hPQlmmvOh
	 QROSCvo7IKvaeY91gc19JGu7lziL4PwEIj+UiaTwqcCf21pM/z/PPUOIHxYIKos7Sv
	 fFvHWzg7ajUOpCJxtZZinQQuYgervT9+uRf4VuWA=
Subject: FAILED: patch "[PATCH] driver core: Limit the messages on a refused uevent" failed to apply to 5.15-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:12:25 +0100
Message-ID: <2026110325-yoga-strut-6a3a@gregkh>
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
git cherry-pick -x a01c8e5b1dff1ce489e6b339139e744db36b8bb3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110325-yoga-strut-6a3a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a01c8e5b1dff1ce489e6b339139e744db36b8bb3 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 18:18:19 +0100
Subject: [PATCH] driver core: Limit the messages on a refused uevent

A write to a "uevent" file which is no valid action makes
kobject_synth_uevent() print a warning and uevent_store() an error every
time.  This is generally considered a bad thing so rate limit these
messages.

Fixes: b0e37c0d8a6a ("net-sysfs: make sure objects belong to container's owner")
Cc: stable <stable@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Link: https://patch.msgid.link/2026102718-conduit-glorious-a8dc@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5daa88fa724a..cbe05197d4a0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2847,7 +2847,9 @@ static ssize_t uevent_store(struct device *dev, const struct device_attribute *a
 	rc = kobject_synth_uevent(&dev->kobj, buf, count);
 
 	if (rc) {
-		dev_err(dev, "uevent: failed to send synthetic uevent: %d\n", rc);
+		dev_err_ratelimited(dev,
+				    "uevent: failed to send synthetic uevent: %d\n",
+				    rc);
 		return rc;
 	}
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 1480e2c27ed0..1d29378d4f55 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -223,9 +223,9 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 out:
 	if (r) {
 		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		pr_warn("synth uevent: %s: %s\n",
-		       devpath ?: "unknown device",
-		       msg ?: "failed to send uevent");
+		pr_warn_ratelimited("synth uevent: %s: %s\n",
+				    devpath ?: "unknown device",
+				    msg ?: "failed to send uevent");
 		kfree(devpath);
 	}
 	return r;

