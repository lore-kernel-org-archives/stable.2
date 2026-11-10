Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273699;
	b=OYNx4XCETkU3pduf2JEWcKGlygm/q68gfBr/ZQGWbbYwVKVr05fSCt/bALUObf6qt2z4
	 5xULVP/GNI2wyIkRGe2DvJsLdUHEC9D/8bgoK3rRHnZhaU485Y1hY6pLlQXuiYyyHcTxK
	 UtU0VyFybDepKcmoQqgE6Bs/iCRmlcbftxnNphqcU41E+ZNbJOfnpLO7iv8LBhIXopx+T
	 6/0IKyo4e2JhU7MPO+xxzIFu66/mg9dVMufj4MZSYlDo0GG1CBcB7pIJD6WvvACHW01PK
	 dqAsVOqLx0gWbWCQ/prStoTHTnToQkb1CrBdjZSHJkrcL7aOjDuAvLqzxt9UR8APrdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TY8qQIEDZhxjBTnNUASIhsWUcDq9ypQ3Do8FP4jyxMk=;
	b=Y097RcxNp/5itsQvH3sBqNSnoXucbeWShB6GvGB9qDshwfgmbWY70Hz6NYz+M41yqfq+
	 EAAUcIc5kskMxrlbTCtlibYJw8ThxRqnEbeHf2T0A7OPZJauMQGPvKK7xQ0VdL66zFU1i
	 sTZHovSHl5iGpvvaB0eq9OaG+iMTGD3x+2+015lruHm/zUm0erbKvqLaw8s9XJvZUSfny
	 Oz151D7r7XhyDcaCEDxB//PgHW0b2zUUTjK0vb3IKt5cBvGD97sAex5xHqk4fEK24ngy1
	 ja6xo85S9o4Sy7402XmvPUA5/uXhIo0nSrv8o2ZxOd2KEXjprpWGydB9q0TcJUVA/RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8mGBrJv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097360A2602
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8mGBrJv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18B81F008A5;
	Tue, 10 Nov 2026 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273699;
	bh=TY8qQIEDZhxjBTnNUASIhsWUcDq9ypQ3Do8FP4jyxMk=;
	h=From:To:Cc:Subject:Date;
	b=a8mGBrJvHbAeYccIACmiP1I13nAmuMu7dUIswkLv35GlXrIOtWGEgSK31aSCQ3s7D
	 txgQwJjS1K5vQO+o5CYk8JEoMDC3XDqTPJI84LYoKdrh/wNiyu/KEqnnC2AgJmX2M9
	 Lhz/OmU14dTDTQQws5BdsFsgGApmdEbLbrjFzd50VM4ScZ3m/uPMuB/Ho6I7qxKxLS
	 fYF0ExKejzM+pKw4T/6IFZ+KhLy5kR3142nczKdlngBoaH06D4iaNimGDa50i/Wo86
	 76dCPu3Eb4mTOZQ6z4f+1Plgy8g3iwueJApQRUHOArQPwVJi/4cvr22asESljoSmdH
	 BZBSgLtf+s4mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org,
	ycistak@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:21:37 -0500
Message-ID: <20261109202137-failed-5.15-9a6aa085c94c@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9a6aa085c94c7f2817c4d50a7264e6fb51286f40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202137-failed-5.15-9a6aa085c94c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9a6aa085c94c7f2817c4d50a7264e6fb51286f40 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 31 Oct 2026 03:09:14 +0000
Subject: [PATCH] hwmon: (coretemp) Fix 32-bit jiffies wraparound in
 show_temp()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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




