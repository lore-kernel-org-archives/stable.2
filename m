Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589675;
	b=x16j6iaUQaOB3DiR8mGc2fWCAoYzd0Qgw1vOCC5pk6qIYl1TIwyz2Z8LGuZhvKnizvq9
	 covioRi++xuR9Ce5L93p1lt6wMx7owLHoP3OR7k5VcKvR44qTENn03RlhP/c9RIqh65cF
	 eB3Q779ATwWpxPrX7BXY/eTF6OJocGIagR9n3gJGQkgDiP0YyLd3hJkpiJIsjpCQo6Piy
	 bE0USg/P8BJ01+yUWiW0x4hQp/uc7Jcu5BEbbL+ja5a4xEEk8t/0k1O97s4VXbhevxMRt
	 e2Gh98nWEpnwt2S/5DOCJY50RG5SL+tzzM9przSD+ONGhtQuKsPN1BYLeS4jK24Nlrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3f9banulEsGIg8JobGIJ2BmQKqHCq7akuArCGoGLEJM=;
	b=dp5/lP/+oNk8Hc7AhRixlKBBc0R2Cq+p1JkonO7AOGvseVqj2NTQpkdqiyFiC8Nl0GV5
	 +TaveJzJNv6doAHmI8IbzSuCFIx9o24iei+7XEa8DYyar7U+jLTuYbMAbJnuGFlIK4YVs
	 o1ZSAvumk82sIzcNmkMyHk/wzn77vFYSv31Tjur1glOJ9WFkZVnyRaGsUNblkftODSG6H
	 Ev04qLFak+3RRFWZc+h5oUwNiIVFT3jjh4sdxdGMBIoEj79Bq+MZ4xy8OimkuEzn8pa1J
	 UQnBLtfMFAGhp7OurZsTisEk45kWnzaprn/gwMmqi08Iq0KUmN+4SO5gWMENNqiVGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctlYK3g4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308C606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctlYK3g4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67681F000C5;
	Fri, 13 Nov 2026 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589675;
	bh=3f9banulEsGIg8JobGIJ2BmQKqHCq7akuArCGoGLEJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctlYK3g4PKg8Lm4lKSg+0NIjQlkJccvxD0UFWLUabFtsc5ebBRrUduTw6DxLtab1E
	 WLbJP01c9j2S397fpadY4zAHRwK4fDyrWFWYL8MyLv/klPZk666cHNZDkQH0B/gdqO
	 9O04pwx4GnwrVTybiPQqvoZTD/NQFNiq3LmwEWxx0rPgxv3sL0S1/5uN4MDcBPSbo4
	 xQPnBy8CnHldkLsWTFnxWJk13Nz2UTYVfqDn9MngGJsHJLUPZ/8qZ9V2ddVjR1ikXe
	 yMBUXOY5/jh1mplABHEefptul7zk/EeysCy330ZIa8ghn/J3ES2hseoqRdlw0R8gP5
	 WNlA1oXzlK9hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
Date: Fri, 13 Nov 2026 12:07:53 -0500
Message-ID: <20261113170736.2099600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202137-failed-5.15-9a6aa085c94c@kernel.org>
References: <20261109202137-failed-5.15-9a6aa085c94c@kernel.org>
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
[ sashal: Omitted timestamp-backdating initialization because the existing !tdata->valid check already forces the first temperature read. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index cbe2f874b5e2f..d8ab0175f16b1 100644
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
 		tdata->valid = 1;
-		tdata->last_updated = jiffies;
+		tdata->last_updated = get_jiffies_64();
 	}
 
 	mutex_unlock(&tdata->update_lock);
-- 
2.53.0

