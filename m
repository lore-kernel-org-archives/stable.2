Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593180;
	b=Ifr4vYuLev6z14oAZaL/R83GbxoFRAN4uZ084v4Mvyv8ZB1SFNA+OBr0aJ9pqGQEn8L4
	 3Juct9SJ5v/S/NQ1tXQvP2x6pbRFut4cZeezP/qF3HooX1ia2sZNTPTfiKTA+f0Kapdll
	 D7auWG2DwNhBQRz9s1u3Ft7lZOLC/1RZwcnZm9HbpooJTgs8RkJuYtgNVkanrV93pLVTY
	 C0iJhwWrINXOp2pyrhXz6aZv4Kzsvp9vhDISeSxpoF5a1VYw37j3rDWQIBPM/DyNmTwsS
	 SAcxX5dJUfCBgCqbHSyxftFYjErrv8j4LhoRm7zwBkpPDd2D0tUOGLG5w2zfFbR9dww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593180;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aghL0n4xHOOBVdICBCFpw4KdkZPEgwXa08cyFpZARtA=;
	b=OIRjJ32iVQgue2GwFWM30iLvVneMklcGKR3qzHhTMA9gMqppmWogVXiB7zlApcyVw3Bt
	 9a0kMJTrV3/+kCqR2LeNe9zhgYVgp2VodyeBFKhvLVHJgIM41MWfl78SCmODIvUaXE8Ue
	 6A4VHTrIagyKvkky4quXa3yZ82OHXWX/yTLeZ3CqUIY2nd1vCrrSe2LRtDXdQ3sOH06f4
	 4UXqTfqeXXMmTc4BoFfDz04BECp4jBcdN6hsz0EZ+2c9sgXtNPhPNScB5DuDjkBHSmlTT
	 LNJHEweF6Q6ZsrfyRKYmKWOzRk4wTt+pJec/x5cYO4pcMDh6M8IhhOSCxZuzg9iDajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNybgH1A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8996606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNybgH1A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFC11F000C4;
	Fri, 13 Nov 2026 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794593180;
	bh=aghL0n4xHOOBVdICBCFpw4KdkZPEgwXa08cyFpZARtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KNybgH1AGBcJ0DTyeX1y5tpmW4dhPbSyBAnO/kqKtifSZza4Jwxhtb38REdi39spP
	 6u9RjeghD3oeqsKXoHzGjR1FCUD4mNmNEY8/xASmA0YF7nJJovkYuyVEU2m+yZjAJm
	 8PH12FVCBnGKPOplWQ0FMneDqGRFeUF2SXphXc3ZlBqLWuSeu3mnzAE71O/UxH86LU
	 WETOC59W513ZaCBaw2U2n3z93+DUW/Y8zXY0uIhVTDadjhF/tdHN30MxZB3VNPfctg
	 nD7LLDPDIV/ryWe0K7xdK7MqkLzz0naJSBT7+QAtDIIUNcKdkRjhQI1qkmwVd7AAX/
	 /if7q/SQoPoLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko-bot@kernel.org>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()
Date: Fri, 13 Nov 2026 13:06:18 -0500
Message-ID: <20261113180601.2165641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202633-failed-5.10-9a6aa085c94c@kernel.org>
References: <20261109202633-failed-5.10-9a6aa085c94c@kernel.org>
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
[ sashal: adapted the time comparison to preserve the existing !tdata->valid guard for first-read handling ]
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

