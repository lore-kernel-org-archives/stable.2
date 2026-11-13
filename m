Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586347;
	b=lWp2k4rf3j67MhWylOMNUOtggRIJ37LMnPdhP7PuuUOMCb7izjxtnoLBbGkPKSDrOXF6
	 VJjjIvbvuvYNhDZyoFbDfsQyDmAx1qGCxeii7JKWE7anKXAbX9+VrHqz8N1XTargS041O
	 aqnJUHt/L4UXHURfqt7dfYyRuy8L48ZaafcG6WPD7UvaJEpw/QIQTc5rWEjrC45YbfUtn
	 M0QHQtPPz2zv+QmTac3reLzsNVUYPBThuXRLtv70R1Nu8l4vqCoYXLlFB2UdMjTdUyKiu
	 Oi071rvVdZqVUSOfXFP9ycBGHwjfY9Spe4FlYfTZLy32EXbT1sevnDAs74q4Aqa0unw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586347;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kLkWXqKoPgI7ZDZJxohM609hxChDJcrsEDiVhxv85uE=;
	b=sXpFZPO+9IrmHSE1Xu2kLZl4rQUurUHK5PGejARJtBywoGgg4nfyUkayTnD4HNCfjHlT
	 5xhn2IQEPe7rI9czU+TQ2kTIQ8UgnPGpLJuCYs7lJ4n9HaITj2DUYVOi/LM+TWkY1q5e3
	 J//FnzRo/sbDKwAq0tMrxCXTwfQ1jzVSWrrlFCFAgHkk72/SpN2wqDyO7xX4jzTwAZgdX
	 IWqt6QEvBMeSmvHiggETxpWfQwsWsqnz5P05Znokqg8eKQl92MgfBGakgSQ8WhVdvtxB/
	 Ma87J+Fn7DiV7DaWkdXYEnZb2y71035dvo2o53zUJQHAD3Hxpejir7jYZg7R0ElED0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohov0JEG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80C606A893
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ohov0JEG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632E41F000C4;
	Fri, 13 Nov 2026 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586347;
	bh=kLkWXqKoPgI7ZDZJxohM609hxChDJcrsEDiVhxv85uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ohov0JEGxt/PnVTqHp55aSzYO3i6X/FiXLlAV6Sgm5l0zUUmTTXvODSc3QlwFc9x2
	 JTZSFoLJ9KnWJyhrpGD90jrswTwT3Gxn6o3+x02beffnfPsUGR0AnMT2z5pyxeib9K
	 LRZjjDT8pk+rtQFuKDmv4FIT2UK3D/sEeYRIAxSs4QsjlvxOx5TBOJExgdPyeG4Z9J
	 ZmaCjFxzqr7wXIj3T9hjtUGDCfJitnzmw04km9IpsmWAV3Ni6SG25TKQNwfckvgDVr
	 MfdecKaj/nj6Z2DFCHdE70cncalZlgs9xJcnRyJuokGZi4f6nQzWaVHbNpeTGHeGdD
	 qyrQTsSu4+9xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
Date: Fri, 13 Nov 2026 11:12:25 -0500
Message-ID: <20261113161207.2013859-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201625-failed-6.1-9a6aa085c94c@kernel.org>
References: <20261109201625-failed-6.1-9a6aa085c94c@kernel.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 9a6aa085c94c7f2817c4d50a7264e6fb51286f40 ]

show_temp() rate-limits MSR reads by storing tdata->last_updated as an
unsigned long and comparing it against jiffies using
time_after(jiffies, tdata->last_updated + HZ).

time_after() relies on signed long subtraction, which only produces the
expected result while the two timestamps are within LONG_MAX jiffies of
each other. On 32-bit kernels, if tempX_input is not read for more than
LONG_MAX jiffies (~24.85 days at HZ=1000), the signed difference flips
sign and time_after() evaluates to false. Because tdata->last_updated is
only refreshed when time_after() succeeds, subsequent reads remain
blocked from refreshing for another ~24.85 days until jiffies wraps
past tdata->last_updated + HZ again, returning either a stale cached
temperature or -ENODATA if the sensor had never been read since
initialization.

Store tdata->last_updated as a u64 and use get_jiffies_64() with
time_after64(), which does not wrap in any practical uptime.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: bebe467823c0 ("hwmon: New coretemp driver")
Cc: stable@vger.kernel.org
Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: Omitted timestamp initialization because the existing !tdata->valid check already forces the first read. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index c0aa6bfa66b24..8ad0ac882afb9 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -70,7 +70,7 @@ struct temp_data {
 	int temp;
 	int ttarget;
 	int tjmax;
-	unsigned long last_updated;
+	u64 last_updated;
 	unsigned int cpu;
 	u32 cpu_core_id;
 	u32 status_reg;
@@ -157,7 +157,8 @@ static ssize_t show_temp(struct device *dev,
 	mutex_lock(&tdata->update_lock);
 
 	/* Check whether the time interval has elapsed */
-	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
+	if (!tdata->valid ||
+	    time_after64(get_jiffies_64(), tdata->last_updated + HZ)) {
 		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 		/*
 		 * Ignore the valid bit. In all observed cases the register
@@ -167,7 +168,7 @@ static ssize_t show_temp(struct device *dev,
 		 */
 		tdata->temp = tdata->tjmax - ((eax >> 16) & 0x7f) * 1000;
 		tdata->valid = true;
-		tdata->last_updated = jiffies;
+		tdata->last_updated = get_jiffies_64();
 	}
 
 	mutex_unlock(&tdata->update_lock);
-- 
2.53.0

