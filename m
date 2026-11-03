Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700756;
	b=3WJsQyY1nNu6t9QmpMZDxm92uTXSHFnYgYaD3PXZSror2//ezqB7C7BJIMVtqHOc2GZd
	 dUxyo2++lvGIn+WQOCSwrmVYxy+yVPIn603GrV1aPY/jEcfomtNSDPILqCjWNgroBkhK2
	 F2uVw2nMTByzO80H4UToEQ4+OJRyuOAW4tra90SlobZd6aHaHHd3QzrnBeCybEPQQBTDh
	 uHGYOpgpQcWykbSeZrajEvnmWQX1rLXkTED0cjh8GilfL3Ch4lyUXHBYlLKt4XNd33/6F
	 Ilhl8BKiF3ZEWQd5Tdj21RxZaCI6cRteaFwp/Co66EfvVPyz3+6rC4MkkBG9V19+xhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700756;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v50V2YdLqpJLG5g1OLGljgufXFpdpQPxt7zi9Fzizq4=;
	b=3gZuW+S2EQBTT7P4AVo43aIZ0FbwOqC5fk5GRnpjZmNGbNmsNNIM4xJJKqMgVpi7l6FK
	 r1SEWT7mw7sT1QB3illES4wQcaE/YfHt+vauYxl9RTkzZuaq1HlniKIM2c3f+MqT94Noy
	 9fmQK54zyMlW0N5ztTJdmaF7HKQBCyMKv/TPva1K2X+T737hDEbZabWli1d2EiUb0Kjm2
	 f1hP5g7JPMMJjgZiEcdKMZvL/8Yc0DH2iGmbC7SyUsVemz5wdxOMTjGdBsXCiLgWUCJz1
	 TVEjv/jUgSn+u/Nxoc6g58Bjd96DLAn5VdaROMG4zkDR4JkOejrfoC/Om50HuyTyPhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zLDz8rmO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCA606BF9C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zLDz8rmO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B883A1F00919;
	Tue,  3 Nov 2026 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700756;
	bh=v50V2YdLqpJLG5g1OLGljgufXFpdpQPxt7zi9Fzizq4=;
	h=Subject:To:Cc:From:Date;
	b=zLDz8rmOGlWgdgd/du6gmENZ132tzb3rlNV47eM1YpBA+g8+nQAN1+jhWHen9pgAd
	 NH9j8fcJ/IGomTR/gBEhBwFBwLBeVaNUCxDydpQ5ss2E+3btfsuytVyQygQKQutG8+
	 IbQ4n9KVZ/fXHH3Z/aFmREBjzvlaG88S0RGfeLQM=
Subject: FAILED: patch "[PATCH] driver core: Limit the messages on a refused uevent" failed to apply to 5.10-stable tree
To: josef@toxicpanda.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:12:26 +0100
Message-ID: <2026110326-defuse-swifter-f038@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a01c8e5b1dff1ce489e6b339139e744db36b8bb3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110326-defuse-swifter-f038@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

