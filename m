Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717933;
	b=xGpLsi+gvbPwBZhXRXBQgghH64xo/Ix71uvWr+n3zFgw2cEPeE6JJCxfcxrwC6C4eY0E
	 tpYYU2pp0QidJUke2bEjCIkEsq1RfocdhAV4KtWf5RceeL/E433gw7ap9edQXffUxdPrk
	 HetfDx14FXHxaE9w+547VP+rMgLrxGvbwOqJzX5d5+5HdfESefrka2TIqbjFzLtVF7rSs
	 C+tQEXWiQXzfrO4T6EdLeM6iyG4uEhOIYK+Gf9OO9qmdR/z52cELz8a4y+sbxtZ0BLMEH
	 7YlH6PmRpS5UVliRB6Y3/MLiPnH0pLxXRzHcOacLA4y58+vJFHolrsyQsWpcoHzkFgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TqCMhIYVeuUR/tIpIwjat3KXf2S+Ibx/wLePBi+7jI8=;
	b=lN8TcWyJF0A82sTZOih6y6lD8gDXDi+tPDiWajauSOvQ2weMpn8vlaHFMKHNgL6Tusxb
	 qTOUk4fUyXqoBgBsZHVHwYYDYOMQ7c8e74XEZTZA+6vaMUwfde0zNm9KdC3OTn9sQIqpI
	 NTXvQ4QxkDvbf+bFfgF3b1BsLKqoNKGuEUeTeT4SdZ7Wy98CWCbClmzF8ahesXw1fan2O
	 A0lvGm8Utfnqeov5u7+Rzt6a6DlB3gFl3U03+C+IF5+STwDp+8IUXBL6marqgVOsAYvYf
	 rAK+/rDZVH6gtVZO7hQTFEvpWttBOJhjvV5NddFhJmOYw58T+pIsXt9sO5tZlIb5LCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCNGcRZB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B5606C80F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCNGcRZB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F11F1F000C1;
	Tue,  3 Nov 2026 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717933;
	bh=TqCMhIYVeuUR/tIpIwjat3KXf2S+Ibx/wLePBi+7jI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nCNGcRZBQR/PTZy1P5WJQO8dM/7vmEkCn7oWJQsCP4XzPXtmxJVX1cwx+dsc2ayK+
	 kVl90CzC0LWunfXVdJVD53MUSRsWVvTKpp27nCdwrpCECN2+446cW1DiXidwWHrDe8
	 7HBLrziMiDmfhxogSEFbQQ5cOKJMNybwquJ2Gz8p38v5F874ZRGS+Yj0mU56I6AVrX
	 1RoAa7cUQEo9FslRd0ozbXMH75Do3xzRR3Ipk0Ls+qmcav/bSrsTcHMyFoyqjoHYeU
	 Av6yDQwU9LCHu1eoAO+CxQkavmGwLFzqRkvrJBKpBkX8NXcQ0+VUWXHEl24z7lNu3a
	 +5+sTau0fSOIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] driver core: Limit the messages on a refused uevent
Date: Tue,  3 Nov 2026 09:58:51 -0500
Message-ID: <20261103145820.4164256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110326-defuse-swifter-f038@gregkh>
References: <2026110326-defuse-swifter-f038@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit a01c8e5b1dff1ce489e6b339139e744db36b8bb3 ]

A write to a "uevent" file which is no valid action makes
kobject_synth_uevent() print a warning and uevent_store() an error every
time.  This is generally considered a bad thing so rate limit these
messages.

Fixes: b0e37c0d8a6a ("net-sysfs: make sure objects belong to container's owner")
Cc: stable <stable@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Link: https://patch.msgid.link/2026102718-conduit-glorious-a8dc@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adjusted context for the existing dev_err() message, which lacked the return code ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c  | 4 +++-
 lib/kobject_uevent.c | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a900bde641491..5bdf76e2c14f0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2032,7 +2032,9 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 	rc = kobject_synth_uevent(&dev->kobj, buf, count);
 
 	if (rc) {
-		dev_err(dev, "uevent: failed to send synthetic uevent\n");
+		dev_err_ratelimited(dev,
+				    "uevent: failed to send synthetic uevent: %d\n",
+				    rc);
 		return rc;
 	}
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 38716b2eb671d..99de6689ccc21 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -224,9 +224,9 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
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
-- 
2.53.0

