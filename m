Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713939;
	b=RdD7NwWC6w8zI5pb0pmdQ02WpfztdRji2zv3HtGu8yofRupCjJdTxOxTFIvjVf9epQj9
	 HvAxc8pDZxsDInMVIGo1S/nKe0k9PDW0N5kJFSM06DTxFXPWty7siysNrP9RVT7oGLmD+
	 2vjDh+s9YhGGvouHqfk0vkZ3hUWOjqmV/xn6Oa9SJc67eBOfX5QUyLfXWD2f0nnBbHCgY
	 PiCLwzUHEGIARMVPb8SZ6BAKAKnwg6+kPJiK8/wq0VJoB8YrX2RlbtQtghbC36IP8hNmV
	 vIsfsTaCKe11KAsM7P3svC1cp1AC7lOk80MCAP5bwWxtmlXGLzTdNvu4Zjc+7KBgCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KVD6b1RpNaXokQ5LhwNVafR8NF3t9xBYTThbDtiEwe4=;
	b=Xm6o/6RMQYmq0Ymor7n+X/omLmx+ZOGgdK8VHjl5mJts5LsNtJy+BUa+x6UGckel+Uz0
	 nNmCepCLvlUALDKNHnScQitr+7/+pkX/umzoDLm/+BV+yQPm3PfW/Z1DPc1a4lM0VhYVf
	 Yj693urqTBukFIb7doqUBCUnJ/z7dAqgcg1oVEgAa5BsYXHp0DQm7wOGRiEpkvOFZfSju
	 +U0Jp8Q3pQ329IirN2xwQosPVmAFbAf4u0dtllToGfBn0YD1cNrf0XIoxC4TKc6aEpgUX
	 Qik4wgQTqR4Durm1mXrR1H/7YhC3Tem4TFEjSdumHMIJbNu/0hy908FHk8/Tg5Rn9NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFxPzJ1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D41606A333
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFxPzJ1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77EB1F000C1;
	Tue,  3 Nov 2026 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793713938;
	bh=KVD6b1RpNaXokQ5LhwNVafR8NF3t9xBYTThbDtiEwe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fFxPzJ1BT24RdSPgPraTkZH6xrEjJEQpdmYMacvrAa3QvtnCDs+NTBJHaO0kzn+cX
	 H6XGiJX2KMvKIcZQCtYBq3WLGP6ioa+ZNpu//3WiMDEzvG6SeGHIq/SpZ9bw+BvF/j
	 XIiNSvP8nXKA7mbh2fNYbDClQpOckpmnytq1XMHD9XqUbohssE/loebHcMzJdjz3Yt
	 ww+qf+5FkdsCdS+36aAqgqVaDNqK8SPSfcA3QLWzcz+cBVG8z230G28h2qN/au4vch
	 3THvFN+jIzG1xkbDnLBIWgLhIMWpizB0MMxCv444Mca0WzV289LXjUH6kap+88IDz9
	 xtroVoCQ/balw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] driver core: Limit the messages on a refused uevent
Date: Tue,  3 Nov 2026 08:52:15 -0500
Message-ID: <20261103135045.3979793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110325-yoga-strut-6a3a@gregkh>
References: <2026110325-yoga-strut-6a3a@gregkh>
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
[ sashal: Adjusted uevent_store() context because the existing error message lacked the numeric error code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c  | 4 +++-
 lib/kobject_uevent.c | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d11cf07e1441c..dda2bc47bc81a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2428,7 +2428,9 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
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

