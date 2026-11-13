Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584256;
	b=hHBAtLlmE2OeUbP47xjFikeCP69amrubMBCnW3bHXaGBZxBr4iTqs+amApdDUJbzzmaV
	 xQh/Mr6vuJcO1uUswmXu12nupixvBif4huxYWrHCc6lpnwZLjVAeJHfGAD6hzfl54DA4J
	 Cj4YpIYMoTwtzagq39u5swf9sItx2pHHNX866VuBGhHzeiQma28lKsW0+cpPwRb0EAqvO
	 EHNDdPe8IsA1WN24xdS0+YtiverGi4G0+2O0MfV3/qFvhEX/sT4QF/N88++fuJ/1/gVzo
	 MOnqSb0/viL5qQIDmBXKZLp/JaoiR8atfxjH1FCEG+LeMiEESHwN9QkaPfq6xsfFoqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YtI5ZvkhSdXM3gv6LxvMvZnIMiTfdQG+UvdR+EMOhB8=;
	b=P5AaMxV3hk8kiRQ8q0anTnriqBYLPfCCPkUaoRCxdFtIM/mEulflVDB6qzI8apdnBhoY
	 zt1/cEdLcSZ+fdk6aFNwsJADfyRNx5to2zFXpiOMKYZvq4ayFuMOfrLKlONMNCprHJq8X
	 2JYuu+f7dHr1s52VNBWYddhteoHSxjETPnkhpyBL/8gfQFBem9rnmF/OsgIVIJwmaQF+p
	 XfuerZ2pIpT4uIb9TOPlU7/glQtKnZCeoPe/Hv3EvfifKcnMslUb+wwGzEi/sw6O0aQ1J
	 U3uMuBDH6LVm9Q0PaAUDy5kU2/EgNfJtloiBi53CLLW75EiRNqj32r8rqf4GJP11bPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e7RJ/DW1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0422606A884
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7RJ/DW1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C91F000C6;
	Fri, 13 Nov 2026 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584256;
	bh=YtI5ZvkhSdXM3gv6LxvMvZnIMiTfdQG+UvdR+EMOhB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7RJ/DW196A0cAeFmnOXAUaAmokRFKacoDL5RVF7vqZBTyhyXgfkCAOY8tg8QtS5V
	 jWmtKVxVNRZ6vam2b8qCfETikSifgQ1S22cjF5b2sAdw+f/Ch9WJN2Gz8WWobKd0Mz
	 pmaJ9YCvRyiHSJ+wXKPQm409fiWzOEdi0b/X8Cdqmj7wlxdiyS8DHWL6Ad2z8jksgj
	 D+nbxAaRsLribAuPWh2ri5snweRCE7j62lXnCPrnPhoiG99xjCuugWnYDEquRAvYac
	 5tcFknebpFyvKG7smVnwIvztKT7kpsUV5/94EHG8/BzxooYt4QRIbzIoiy42X2RRiC
	 7Sw8gK2arBMNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
Date: Fri, 13 Nov 2026 10:37:35 -0500
Message-ID: <20261113153710.1972639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201149-failed-6.6-9a6aa085c94c@kernel.org>
References: <20261109201149-failed-6.6-9a6aa085c94c@kernel.org>
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
[ sashal: Adjusted surrounding context to match the existing rdmsr_on_cpu()-based temperature handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 6c10349ea68a3..a8b16b6eeca73 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -71,7 +71,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 struct temp_data {
 	int temp;
 	int tjmax;
-	unsigned long last_updated;
+	u64 last_updated;
 	unsigned int cpu;
 	u32 cpu_core_id;
 	u32 status_reg;
@@ -402,7 +402,7 @@ static ssize_t show_temp(struct device *dev,
 
 	tjmax = get_tjmax(tdata, dev);
 	/* Check whether the time interval has elapsed */
-	if (time_after(jiffies, tdata->last_updated + HZ)) {
+	if (time_after64(get_jiffies_64(), tdata->last_updated + HZ)) {
 		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 		/*
 		 * Ignore the valid bit. In all observed cases the register
@@ -411,7 +411,7 @@ static ssize_t show_temp(struct device *dev,
 		 * really help at all.
 		 */
 		tdata->temp = tjmax - ((eax >> 16) & 0x7f) * 1000;
-		tdata->last_updated = jiffies;
+		tdata->last_updated = get_jiffies_64();
 	}
 
 	mutex_unlock(&tdata->update_lock);
@@ -491,11 +491,8 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
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

