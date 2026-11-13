Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583551;
	b=wVnZrjuIp8TCTUHgLgIdBGw93hWnibpnwNxlQ7Hjwyieu3dgpmXukJMVUJfoPRbBVLdB
	 RIkQDJyV0VgTysp63cpiJlvegXmM39mNnMss0V+YDOMZkuC+a2eji8ukuRo7Q+hxdpUL6
	 F2AVxSjdRV8fPzdm87b3bGUE4IrooUPdvP5cRcWZK1Oom2NX691oPkHDUh+teLRXpfZot
	 Nnc+e6ND7zPasY9Lkc+xZ6MTAXybmitEG4YA/GNvKT0y/i3rTPVbHkhn1Gq4nVQsvIqPn
	 VdPMiHbNMU12GOPHTcVS7BFpVfNhejJDXQtubQ9Q/CTVVJUbH7Rlzi6fsGNyWfSpKGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9UIr1+rbk5AXUriZ3QKv6PFT6niCB7NdnKw1bTZBNPY=;
	b=wsOOmFUGqw7AlaGDRVWvn0lun55YctONNR7mYBhThWil6OQxAz7s28HrKUXxcodbJ4Gd
	 U7V2GVvhCVV6aqDTjoP+QHrW2vJtzHnzmzCG5H7D+vFEK4zr9VBRjJaYRj6Dm4pEs41C7
	 bQ3UR8+DaLllK505Ny1zvHMPIx52JFZWgluZwKVVTDZrN+0+UNVhwYziQVrMH/N0rIQ4Z
	 Ua8UREjiAqIU/ffWCToteX3XJH/ragVl5uCO3cMTQFivUxutNPFanLwQ1/dvJpeFpIDj7
	 rwxv787egVrI0Wh2asHrhzYjbJPG3ZaFHqaMTlyxqdtlFwUlTAsZSZPMp9kPl0mldVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYr0OmAK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B2606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYr0OmAK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564921F000C5;
	Fri, 13 Nov 2026 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583550;
	bh=9UIr1+rbk5AXUriZ3QKv6PFT6niCB7NdnKw1bTZBNPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYr0OmAK9QuksJGiMRqN0KeX3Mnmyx5IDHg5R05WkjmLN0s0FB7a32QJJfqtRSqrT
	 hQjabDKU95YZycOHfQPXypMACcDALQvOOHDi9a2RBHUJ1fbFPvlUGe+udAestxxjY3
	 lS//s49t1abwRIXUJXfoyw464j4IganPjYk5hqlpTfeubKV8DmgkVKfZ9d0mLIzewN
	 DivsagSkuloZeq9Gq2ylSfWlKyRy9ixB/Y7ukBKf1boQmkSLK563yc28P6cBQCQ4G/
	 xqWDH4xMIUUlzxlOq9z9vQVxrd8Ib1Yfd7xxdHpwABvHaHy0vNKu/CFPEfSF/FgL2o
	 /EglecmaK8IMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
Date: Fri, 13 Nov 2026 10:25:49 -0500
Message-ID: <20261113150908.1843141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200728-failed-6.12-9a6aa085c94c@kernel.org>
References: <20261109200728-failed-6.12-9a6aa085c94c@kernel.org>
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
[ sashal: Adjusted show_temp() context to retain rdmsr_on_cpu() and the TjMax read before the refresh condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index cc81b849c09ef..8e55ada186b1c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -77,7 +77,7 @@ struct temp_data {
 	int temp;
 	bool temp_valid;
 	int tjmax;
-	unsigned long last_updated;
+	u64 last_updated;
 	unsigned int cpu;
 	int index;
 	u32 cpu_core_id;
@@ -407,7 +407,7 @@ static ssize_t show_temp(struct device *dev,
 
 	tjmax = get_tjmax(tdata, dev);
 	/* Check whether the time interval has elapsed */
-	if (time_after(jiffies, tdata->last_updated + HZ)) {
+	if (time_after64(get_jiffies_64(), tdata->last_updated + HZ)) {
 		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 		/*
 		 * Bit 31 indicates whether the reading is valid. Some CPUs
@@ -416,7 +416,7 @@ static ssize_t show_temp(struct device *dev,
 		 */
 		tdata->temp_valid = (eax >> 31) & 1;
 		tdata->temp = tjmax - ((eax >> 16) & 0xff) * 1000;
-		tdata->last_updated = jiffies;
+		tdata->last_updated = get_jiffies_64();
 	}
 
 	valid = tdata->temp_valid;
@@ -526,11 +526,8 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 	tdata->cpu = cpu;
 	tdata->cpu_core_id = topology_core_id(cpu);
 	tdata->attr_size = MAX_CORE_ATTRS;
-	/*
-	 * A zero timestamp does not look stale on 32-bit, where jiffies
-	 * starts just short of wrapping. Backdate it instead.
-	 */
-	tdata->last_updated = jiffies - HZ - 1;
+	/* Backdate to force a refresh on the first read */
+	tdata->last_updated = get_jiffies_64() - HZ - 1;
 	mutex_init(&tdata->update_lock);
 	return tdata;
 }
-- 
2.53.0

