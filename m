Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581273;
	b=3FDYNlZEHG5162VwzRLxgeSQjO85JAqXDalmcLGQ87VoFkIiKc1QX09GC8C7b1MZhvIE
	 VSJ2UEFOekhsklvJFbL04q9DE7sloeeAsbsjSves866i7cRkgzB5/VKKbFK1M9ZZ5elPn
	 1+l7mFymFJaREw6x8623MSpfWezzwNYdOlHQvkF4tZ0aQ7BBUDytJt8gqQnHIw8HUeCBm
	 3TrRhJIUza84Ju/iqhsruu30yUIP1+y/JQanuSFYBXJ6qCZOpQStUB9pPynK1RvtFAuVi
	 syc5bhIzvBpZi+ti7kG9/U38lGz5F+a+9cHc+maqPpsDnglRJw8s/gxPoPjUCNf7Nlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n9v6PLdeUmm6NOifhbfN74tOGrZe1NqOpk5EkOtI9pA=;
	b=zwibZthXwVMHcgdIbvMKkWWLvtEY6F8kAWfXNvnFO70NlsyvhpbZosTh/9udrugILNHn
	 7CDnGSu6NC4sFzoV57hrptfuaCbqpbXx5yX2GMAPS1R0bTTVEkhuCyidCxTQ0SCecr+gw
	 VzTTAJB9q6riAVo7P++W63xg+Fa52mtHJGd5gv9Oer5VwKmY1rXvxAmcjxcVvvIZ3K+Mf
	 lmzelqdknscwv3wfKy45oaeyTCF+/juBLvbS1dQ1RXEAq643XAmYwrd7CznbXWV8yspDv
	 sNChci0cS4F0J0Bedn2aE390VKkxvXp0f/7C3OxBBIBLPlYQcL8unmM5ghi40A0iHYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2FCtqeM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FD606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2FCtqeM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3BA1F000C6;
	Fri, 13 Nov 2026 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581272;
	bh=n9v6PLdeUmm6NOifhbfN74tOGrZe1NqOpk5EkOtI9pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o2FCtqeMWponRjFOE7g4vRX8soiPcnDr96uz6svs1k4PYVCvdioQrWE5PLuFFN1tq
	 78i4i6YatU0k86iFGYG6/DBOhp/mp18UWye/+m5XgPq2FJaRoeoRtKyUYgj9YA4zy2
	 x/Kj0h4pnmL9oPZ8SdROiKl4z2iw5doBSYkWl2gchXw1XGGiFQwpb6Vitmq9o4megX
	 99Rr1ByKAbtVS7/deoVlZRBnn6OrwwX64SydyC5u+3P7w0+S8n0vl+ugbBMe/GfimM
	 nx4UNbHtfW99IW7ZcaB0WyrPBZiDac+7Qhevn45obcnI9xiOX2jicXFnHcafuJadG5
	 iAEHjhR1IxZjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
Date: Fri, 13 Nov 2026 09:47:50 -0500
Message-ID: <20261113135623.1396306-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113135623.1396306-1-sashal@kernel.org>
References: <20261109200341-failed-6.18-9a6aa085c94c@kernel.org>
 <20261113135623.1396306-1-sashal@kernel.org>
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
index 7c2d531d3ffb7..50a8f50a769f8 100644
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
@@ -400,7 +400,7 @@ static ssize_t show_temp(struct device *dev,
 	mutex_lock(&tdata->update_lock);
 
 	/* Check whether the time interval has elapsed */
-	if (time_after(jiffies, tdata->last_updated + HZ)) {
+	if (time_after64(get_jiffies_64(), tdata->last_updated + HZ)) {
 		tjmax = get_tjmax(tdata, dev);
 		rdmsrq_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
 		/*
@@ -410,7 +410,7 @@ static ssize_t show_temp(struct device *dev,
 		 */
 		tdata->temp_valid = (val.l >> 31) & 1;
 		tdata->temp = tjmax - ((val.l >> 16) & 0xff) * 1000;
-		tdata->last_updated = jiffies;
+		tdata->last_updated = get_jiffies_64();
 	}
 
 	valid = tdata->temp_valid;
@@ -520,11 +520,8 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
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

