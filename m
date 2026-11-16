Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793755;
	b=EKC0HTnkWzOnnilphYSGTqdxXmLs8qcHQPTyvp5mHDT/9Nh988fPNQfktJU+mtuUPeMe
	 5tE1GAp6NMky5QkJw+U9XDC5IizuaMgeFkGeBLOJ2vKz8+fiT9PZM5CnwkKGzrDBsFWfb
	 h9UxP0DcyvbDDNMVaMttbP/TOMmHhbPtSKj4IsCXX54yaJRwqbwtEQKIuDDaT0pqkLCf3
	 T/kcaj9oetEQk6nEsc+jrO+jTzX9uwbP1gUHVf4KtLRD/mKney+VZ9H3bVej2NQm4QRH/
	 0+TttA2qwXkMfI05lL2WTrc5UiNKELEsFxdw3jSxxhNF4rR6CwJQem1UH+aXX/gHlyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793755;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=VkBZsAiFAz9Y4meBWnrjGsMls9VyjXgRjtpNrWV7Y34=;
	b=u1nngLvjDWl0wJFFE3ncKoTbjKkLpOra8lu80//sac5Gd8ORZSg6jQqfpuFn2gNMklIR
	 OEBXrXH2Yzh+IXaezYAh2wkB99caVejqGQTD49w6Vwj82v35YCwkzKIbP9UtF3mV6mqqO
	 2vfT55cNHPvYYXzZKrsBqy8VPqXg8v1OR6HKkqEidkDovS+OjB36O69ScsAVJoaFWCM/6
	 ZvMrAhwB/JpYGRjApj/m2yOnziVcHcoOfkeS7VRtNdVm7dOpkeSj2imvTGrQvtIKYHylR
	 veKxRxb20AlgJfWudiFYBW9fGShachc89laFqLnzjOVu/YUslnbr/TeP3ZW3cC0LU9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="Y8f8/gZS";
	arc=none smtp.remote-ip=103.209.128.121
Received: from mail-m128121.netease.com (mail-m128121.netease.com [103.209.128.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5F606A888;
	Mon, 16 Nov 2026 01:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB5F606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Y8f8/gZS
Received: from xf.. (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54c22ece0;
	Mon, 16 Nov 2026 09:49:03 +0800 (GMT+08:00)
From: Finley Xiao <finley.xiao@rock-chips.com>
To: finley.xiao@rock-chips.com
Cc: cw00.choi@samsung.com,
	heiko@sntech.de,
	huangtao@rock-chips.com,
	kant@allwinnertech.com,
	kyungmin.park@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	myungjoo.ham@samsung.com,
	stable@vger.kernel.org,
	tony.xie@rock-chips.com
Subject: [PATCH v3] PM / devfreq: governor_userspace: Guard against NULL governor_data during switch
Date: Mon, 16 Nov 2026 09:49:01 +0800
Message-ID: <20261116014901.896762-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022022109.642339-1-finley.xiao@rock-chips.com>
References: <20261022022109.642339-1-finley.xiao@rock-chips.com>
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
X-HM-Tid: 0aa1e20b245703a8kunmd57494981cbbc7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGB9MVhlKGRhOSBhPTEhLHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Y8f8/gZS0dF8Xu2hNuvJAklZVFzfXEvqDzdY2Tv4puUxqL5qPHyWFIP6zC6DugWu/Mgo/7gqpmBt2hPp+dldAb3YgFB6NCwl1GneHbZqC/MgAEvv0pZ5kvIn6puKefsDqs1aa986QpTS6m894rbpRCIib7wEStCvB7jWw+UQUxo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VkBZsAiFAz9Y4meBWnrjGsMls9VyjXgRjtpNrWV7Y34=;
	h=date:mime-version:subject:message-id:from;

The userspace governor is the only one that uses devfreq->governor_data,
allocated in its DEVFREQ_GOV_START handler (userspace_init()) and freed
in its DEVFREQ_GOV_STOP handler (userspace_exit()).

When switching governors via sysfs (governor_store in devfreq.c), the
sequence is:

STOP(old) -> df->governor = userspace -> START(userspace) -> userspace_init

Between the df->governor assignment and userspace_init() completing,
governor_data is still NULL (the previous governor never touched it,
and the core does not clear or pre-allocate it). During that window,
asynchronous paths that call update_devfreq() outside of the driver's
control -- the OPP notifier (devfreq.c:686) and the pm_qos notifier
(devfreq.c:707) -- run devfreq_update_target() under df->lock and reach
devfreq_userspace_func(), which dereferences governor_data without a
NULL check, causing:

  Unable to handle kernel access to user memory outside uaccess routines
  pc : devfreq_userspace_func+0xc/0x28
  lr : devfreq_update_target+0x58/0x158

Add a NULL check in devfreq_userspace_func() and fall back to
previous_freq, which is the same behaviour as the existing "no user
frequency specified yet" branch. This closes the race for all callers
since every path ultimately goes through get_target_freq.

Additionally, take devfreq->lock around the governor_data assignment in
userspace_init() and around the kfree()/NULL assignment in
userspace_exit(). Without them, a concurrent OPP/pm_qos notifier running
under devfreq->lock could race with the setup/teardown of governor_data:
it could read governor_data after it is freed but before it is set to
NULL, constituting a use-after-free. Note that all DEVFREQ_GOV_START
callers invoke the handler without holding devfreq->lock, so taking the
lock in userspace_init() is safe.

Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
Cc: stable@vger.kernel.org
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

Link: https://lore.kernel.org/linux-pm/20260723080806.1451-1-finley.xiao@rock-chips.com/
---
Changes in v3:
- Also take devfreq->lock around the governor_data assignment in
  userspace_init()

Changes in v2:
- Add Fixes: tag and Cc: stable@vger.kernel.org

 drivers/devfreq/governor_userspace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..cfbd72892598 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -24,7 +24,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
 {
 	struct userspace_data *data = df->governor_data;
 
-	if (data->valid)
+	if (data && data->valid)
 		*freq = data->user_frequency;
 	else
 		*freq = df->previous_freq; /* No user freq specified yet */
@@ -94,7 +94,9 @@ static int userspace_init(struct devfreq *devfreq)
 		goto out;
 	}
 	data->valid = false;
+	mutex_lock(&devfreq->lock);
 	devfreq->governor_data = data;
+	mutex_unlock(&devfreq->lock);
 
 	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
 out:
@@ -110,8 +112,10 @@ static void userspace_exit(struct devfreq *devfreq)
 	if (devfreq->dev.kobj.sd)
 		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
 
+	mutex_lock(&devfreq->lock);
 	kfree(devfreq->governor_data);
 	devfreq->governor_data = NULL;
+	mutex_unlock(&devfreq->lock);
 }
 
 static int devfreq_userspace_handler(struct devfreq *devfreq,
-- 
2.43.0

