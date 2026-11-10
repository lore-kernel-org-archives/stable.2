Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273996;
	b=RsYbvZ7GUCbMpsVl0XkkyGOLXoXI56KxGWfO/2xdS78ZalrfgTetmf+JOZk+PLXLUQ1Q
	 kg8IYe68CYaNG63iXYTQusMz45N0CoYWz6vPumi36PwlrkTIc3GYIIuiqwLsNbG20iWzV
	 WpG4xBCcqJa7VkARKCn2jX+r6b7ZDBxaCQAoP4y+4XalMuppteDGkPwDSrTB4dE2dS+ri
	 IcrjYiKlx4k2Bgms+Ih95+SupCioQwPKcHWxisMrjQMZ6LN9t8Y0AWj58VIMbwtt19+ko
	 //kKNROp0K59YtIF52OStBldBFoYsMsFc1NXCmr5H/kERUxqvA5cojxjlLtUEcE/Tmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273996;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fbdfo1YCJ9s9P3deZ6bhKKAQxkjgzdXQeiX/w56daVQ=;
	b=w5lqPdpCxXBz8buhir+H+nTgImxSKF6OXzo3zng4sRORoHp4ptUZMrD9wwfr+zR50V6v
	 WP+PuN0Yg55rBGPDN+FhDVo9YtJe6baN/k5+0XiH6kI+zr7TkIFj32eX0bIxrzGkE52MG
	 7HWepUg3Ym3sg46CjOH7RMLUmMP+omojZ9jCdrx+o+gA7y0APOgE9WY4rAO/iHpDLA/K+
	 iklG/2C6MelSKO+RK5DUyvH7lzI3lK8vatliG8eFLvD4C6IJGmmtkh1AM+WNm5Ha77c3w
	 ceXK2B7zYnhuVdVj98ZEvGxtSO4IpKACy6Hzet0bphcX7RxIl4pCZy+hsHCoF2SDjmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBQ78E6h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBQ78E6h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED50A1F0089F;
	Tue, 10 Nov 2026 01:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273995;
	bh=fbdfo1YCJ9s9P3deZ6bhKKAQxkjgzdXQeiX/w56daVQ=;
	h=From:To:Cc:Subject:Date;
	b=FBQ78E6h4tIczEpTSXT3Ro4HPkx41E+xRlaZftJ9QF7G5EOeoL7ShWzmOjQW4hLE/
	 /kZr8AhQ3q4tTKIG37rBC1G5JcKUDjQb4DFZlUbXmb8Qlj72/8oIzybqWtDDtlPoOx
	 iBk+EthyeSpy0f+EHwC+83ml/Go0bg9Lmj9GDeMF6sr45prhq8TrUYy5p1AEDiB0XK
	 LQvV6wHR49B95UfT6r8j+C1pwdt1xIbzlhBXv1RhhB0rx96P+n+TMwCOqyYDlmSb3p
	 E5LrMfIkcFCHXSLoovQx+giCg/prIF0skUDTOLeGbyatXB0F6sunT/aXMnoLu5Qz+s
	 X/kGGbTac1s4A==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org,
	ycistak@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:33 -0500
Message-ID: <20261109202633-failed-5.10-9a6aa085c94c@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9a6aa085c94c7f2817c4d50a7264e6fb51286f40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202633-failed-5.10-9a6aa085c94c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




