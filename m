Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046013;
	b=OX8xnmEE9IHZkEFAEgSMZi89Srsuu8rkKXVPiyYT9FPgUPPYTHAOnNlu/l9yoU9AidAe
	 wedcepc7cjPVhTL9j13cOswn0K/NMDBPwBcyMdMRKhNPct3zWrJ20e8cCpj30ISPNjnkN
	 X2HEn2siQx7L7Ay5ROifmkqjPZQLnkCdQ42yOafdFJY34W0tK6ELDl6DWSv6TPLF2pFpk
	 Tu2GKbGWFOcBJmJfpZzrrp84jKNmSpkLfxsvVPZDcDDHMT524QrwObnwPENRK24Q38s8p
	 4J15d1d/OWy8YAiW9tBOls7KkTc5NZ3tBrkX90UIZDFwgOGOkQUuXSO/IDlXKCe47og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046013;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CDNk+HuXdWrB1kcad1tKckmH0Iz2dJk3/Z31MgKlPyo=;
	b=pucos8DSci3j+0Il1kcfcnIYH10o4pkGQrcAynWmIS434e5RdJPdGvW8fLydvmQwxTvb
	 GQ/Zn1C83WH3HG0WSjtJuxKtXfOjA6Zdv4WpgmJePByR+crCPgGgxSG/qaVwMQ+ez2fFj
	 wmDla5qM224WIs+oKssOCX0B+g/OJ0RT5raVbJKIJ+5NT9v3GdKbq88+rTbutGowwU1Lu
	 gNJ0DM8600Kvdk+cgJsSrU8aiLvJpMTw5mZA4dYJdfpcRycqWNI1IG80LmIEBnqGHSC5N
	 HFhvj0pjGp1CFIGLRSsKtGVzNwENViCQvQ73JzEXD42mm/FYREU4hjJSq7Rf0l8TPSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loILsDVN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E86606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loILsDVN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C651F0089F;
	Sat,  7 Nov 2026 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046012;
	bh=CDNk+HuXdWrB1kcad1tKckmH0Iz2dJk3/Z31MgKlPyo=;
	h=From:To:Cc:Subject:Date;
	b=loILsDVNU9mZ3QsipshFwLX0k/19NS4TrXqayMHuB4RUsOgFd03RUudM8Tun1k4Es
	 shJ3CdUK5TJ54YhJ4/lq/FAYsuWu/Y+9DJtDtbEoJw14ElhBEZG0A9BzrKD1wAs+F5
	 0GBNt/fcnca4oNAUhnT1J8A+GUPVqd+YemHioA3m51d0IE3MXr7lPG4aSBBroOz4GX
	 WEhnNDAPa6qtfqmsleO15aOHTcSuS/JjkgTbBCVgx5Het7ml0RInfj5UkyPWhrbcMi
	 hetnKR+Z7GYtfGVxD9Fhkwo4vM+3uUAKwHiBnwccndDWGYKfGHD6tWpdkqmZe4dZQs
	 89qtLhEvhYTWg==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: i2c: og01a1b: power off sensor on remove" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:50 -0500
Message-ID: <20261107050650-failed-6.18-a26c5ac46191@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a26c5ac46191ae34b3413f7a45d6241f63e15d42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050650-failed-6.18-a26c5ac46191@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a26c5ac46191ae34b3413f7a45d6241f63e15d42 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 15 Sep 2026 16:35:34 +0800
Subject: [PATCH] media: i2c: og01a1b: power off sensor on remove

og01a1b_probe() powers the sensor on explicitly before identifying and
initializing it. After a successful probe, runtime PM is enabled and
pm_runtime_idle() is used to allow the runtime suspend callback to
power the sensor off.

The probe error path explicitly calls og01a1b_power_off(), but the
normal remove path only disables runtime PM. pm_runtime_disable() does
not guarantee that an active device is runtime suspended, so the
sensor can remain powered when the driver is removed. This also leaves
the xvclk enable performed by og01a1b_power_on() unbalanced.

After disabling runtime PM, check whether the device is already
suspended. If it is still active, power the sensor off explicitly and
update the runtime PM state accordingly. Avoid powering it off again
when runtime suspend has already done so.

This issue was found by manual code inspection.

Fixes: a95ffde28783 ("media: i2c: og01a1b: Add support of xvclk supply clock in power management")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/og01a1b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/og01a1b.c b/drivers/media/i2c/og01a1b.c
index 1675f0460969a..1cece90c59eeb 100644
--- a/drivers/media/i2c/og01a1b.c
+++ b/drivers/media/i2c/og01a1b.c
@@ -956,6 +956,11 @@ static void og01a1b_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(og01a1b->dev);
+
+	if (!pm_runtime_status_suspended(og01a1b->dev)) {
+		og01a1b_power_off(og01a1b->dev);
+		pm_runtime_set_suspended(og01a1b->dev);
+	}
 }
 
 static int og01a1b_probe(struct i2c_client *client)
-- 
2.53.0




