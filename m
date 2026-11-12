Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504918;
	b=iRpLOton4lTRIClBLZfRc2s4m0rHZBd80k9r3Z47415FsCLh4v9skxWZY5taiNJyOKbH
	 1rmrIQCuteXB2GWt4G1eK4HmqaGyyb1q5xLwDxjT+QgfUtS3f0deOCKLcYctrR1gR5gW3
	 y8KSI07OoDpcjpStIonpWTyzCl/b/W1avlom2bEy0ddQNFVLgqpAVHBYQ/UAoYSGlNZ21
	 hmeSDdLsnHEiMYSYpWLJzlllhV1Q59JvAkBS2nsOg4ESJDpMl1MZnyF76UqV7ysp6/im4
	 o8ZNMwaLqJWnaEt+R+FCkY9j3XsrUeh+CW3bai0cK2SuT65mr7AP09KoEHPWzMBm2ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U5KzOs4vVOy/F41dp1huMUYqU9c7yYMjxRBQ4Fr2j4g=;
	b=te4f55DjM5MV+eHo86i9+brwpfG+HhzJtf5HqYg1xQcYd5IO4O1jxn3NYh0dc8HEmgux
	 7SZBV1GwakO2BqZS41XKK/9AK96yYtS/57RzjTWl3twBb+EwgwVFJaejU3n0d+21XhmQZ
	 Q0yatIyUbuHKrQsFtYPEbXPglKFiXspVIMr9ywDAIFSBK0u0K7CDB70zKhTcFjTNHqLMc
	 54wyCB6297J26DX/NOaoluXWIo94E5IaL70I/NttWLQUJln17P/35HUoQCoMzfTGHzkdy
	 Qs2uSfz4ttJR9ahojliubyr7FNRlMfR7j4JkjTToOo/nSpInasmOY0Et7GNZtR2f+Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epIJABk3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF5606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epIJABk3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B7F1F000C5;
	Thu, 12 Nov 2026 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504918;
	bh=U5KzOs4vVOy/F41dp1huMUYqU9c7yYMjxRBQ4Fr2j4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epIJABk3Z727KQKajBEayrHVpSB5GTc7r7WHQ3M7JlMTBdoAOP+6Dewxz33jaMmrC
	 h0sjlRkZwSHInAFGr5llmZKtSIfl9Dwc+NbpU9qps05QBqL7/cGnUYIWi0xefOMmZS
	 G4RWyWvwvHBhSeznlB6r+tJtdwtkOsACOU4cjiy37zWj6s4OheFlflhdNSEs1apmDQ
	 65Akxf4UjGqOU+bpo3NgCTVLZxXxz7CBU4oWyc3UvrRd6lN7Czn+Vl+RgrVoPi0H55
	 fAnRSVnHOUydl2c3al/HigYekmavqkXQ2CUqi7AF/UQN9HGOz0LjBC688kZdaUWSzF
	 bSIJNDsoHSoiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
Date: Thu, 12 Nov 2026 12:35:16 -0500
Message-ID: <20261112173506.3075837-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112173506.3075837-1-sashal@kernel.org>
References: <20261109200125-failed-7.3-9a6aa085c94c@kernel.org>
 <20261112173506.3075837-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 7fced0e2abeba..96d57fe12de6d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -76,7 +76,7 @@ struct temp_data {
 	int temp;
 	bool temp_valid;
 	int tjmax;
-	unsigned long last_updated;
+	u64 last_updated;
 	unsigned int cpu;
 	int index;
 	u32 cpu_core_id;
@@ -407,7 +407,7 @@ static ssize_t show_temp(struct device *dev,
 	mutex_lock(&tdata->update_lock);
 
 	/* Check whether the time interval has elapsed */
-	if (time_after(jiffies, tdata->last_updated + HZ)) {
+	if (time_after64(get_jiffies_64(), tdata->last_updated + HZ)) {
 		tjmax = get_tjmax(tdata, dev);
 		rdmsrq_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
 		/*
@@ -417,7 +417,7 @@ static ssize_t show_temp(struct device *dev,
 		 */
 		tdata->temp_valid = (val.l >> 31) & 1;
 		tdata->temp = tjmax - ((val.l >> 16) & 0xff) * 1000;
-		tdata->last_updated = jiffies;
+		tdata->last_updated = get_jiffies_64();
 	}
 
 	valid = tdata->temp_valid;
@@ -521,11 +521,8 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
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

