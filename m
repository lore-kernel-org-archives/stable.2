Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047033;
	b=r+jhGpqmtTMARKwJ+/MuCximkyKkZ/cgPStUQ+kUisSwh15R9cmv0cb4bY3N1xnpJif0
	 xCkKWwWigKIF442q9sCibt5vuUokbHcxj90BjhqNy1qDDt/DdqwT6rnNMMw5yy8AhdrrA
	 4SQfY+us+sUabFLFL1QQH7FFBO3107jWDKTvL09tDCVcXWKG76HY/heNi+sEUGaGSMn82
	 8pScUICeHoNp1gr5LMrPlXgi3BiRtaCcM1KxXugeVPSrSaBqI5GQ2PqAcUT9V+ZzO3Eh7
	 +l4078wIz1/OO9VO5Qm4ILD7z9ZgBaAQLX+cLHaFiy8T6+tvUaQkfe/2ORahjkyoTSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I6VBG+51G2XrDYnAwZ9iV4dFwzpjsPDQOraiAt6FvDE=;
	b=N/1KE3I2jd3GE67/kK+zZwHIQTXN5Z9zWzy45kGIamxmekkfNo2n5jNLXjQ4ff6ZtoBb
	 0AQT5M3enYw4c9fnAy4RwcN2jQIL3pETU/aTERBytGP1mY0zDiV8w9Gjc2v0cUzFlz7dT
	 ri0VV4xpjkhs9i3fhMwQ/kNqBatqgoaL9hKd52plpN35//ArOa0+UgHPJsa5YDYTAnWdC
	 H1RoZxE5i53/1ZfRZoCnIcznmuLwhIYTQ1DnZSjKvzse3CWxpaSeP4F1L4NP+m6PgJWDH
	 wwloFy7l4lYsLI0emv6x9NomM9fpJdzHnhZiStUxRjAwqXZ16LHRjRClZfpRBLhWYmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQexbtfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQexbtfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092941F0089F;
	Sat,  7 Nov 2026 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047033;
	bh=I6VBG+51G2XrDYnAwZ9iV4dFwzpjsPDQOraiAt6FvDE=;
	h=From:To:Cc:Subject:Date;
	b=CQexbtfJ36KtfBsFM5sl0aURV/gJ/TZ8G2aqmraJoMgPPhz+2N52Qec6jixmV8kYc
	 EKeKESpFw2JQQ53+NadfVxv0rUisDfKa2eEDvfPxG8dmiU773pUmFXEgAc1bs7kwZl
	 7eYa69YW6HVcHXqpOpTghCaPwy34L5ENTyrZdS8dafJStcZqCpaSa+ZcWXpTl+nOSe
	 1FPaxjqbDUTMU6ZSMCqTYbq1JSYW1AjKBOr6kdj/QdQt344QgQtAGP7z7WQ01m20F6
	 B7+QpxcwhE5vGRQYTDnjff9+AQz2TLb7wtjveWZmiDiuKYtRPn17t3h3K5GOvcLM8i
	 quvfGTV9m+bJw==
From: Sasha Levin <sashal@kernel.org>
To: ricardo.neri-calderon@linux.intel.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Return -ENODATA for invalid temperature readings" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:52 -0500
Message-ID: <20261107052352-failed-6.12-f63aaa529cbc@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f63aaa529cbc73146ff0d52235e5479042285cae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052352-failed-6.12-f63aaa529cbc@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f63aaa529cbc73146ff0d52235e5479042285cae Mon Sep 17 00:00:00 2001
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 6 Oct 2026 06:04:56 -0700
Subject: [PATCH] hwmon: (coretemp) Return -ENODATA for invalid temperature
 readings

IA32_THERM_STATUS and IA32_PACKAGE_THERM_STATUS have a valid bit, bit 31.
The Intel SDM documents it only for the former, but the package register
implements it too: x86_pkg_temp_thermal has required it since commit
f1a18a105660 ("Thermal: CPU Package temperature thermal").

This driver checked the bit for both registers as well, until
commit bf6ea084ebb5 ("hwmon: (coretemp) Do not return -EAGAIN for low
temperatures") made it ignore the bit because some CPUs clear it while
the temperature is too low to be measured. Since then, temp%d_input
reports such a reading as a real temperature. Userspace cannot tell it
apart from a genuinely low one.

Fail the read with -ENODATA while the CPU reports the reading as invalid.
On a CPU that clears the bit, reading temp%d_input now fails where it
used to return a low value. sensors(1) shows N/A in its place.

Cc: stable@vger.kernel.org
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/46f9f319-de71-412f-a424-6cb801478456@roeck-us.net/
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://patch.msgid.link/20261006-coretemp-enodata-v2-1-64e788acc7dc@linux.intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/coretemp.rst |  3 +++
 drivers/hwmon/coretemp.c         | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/coretemp.rst b/Documentation/hwmon/coretemp.rst
index 3493016833814..09f885a847e30 100644
--- a/Documentation/hwmon/coretemp.rst
+++ b/Documentation/hwmon/coretemp.rst
@@ -50,6 +50,9 @@ All sysfs entries are named with their core_id (represented here by 'X').
 
 ================= ========================================================
 tempX_input	  Core temperature (in millidegrees Celsius).
+		  Reading fails with -ENODATA while the CPU reports the
+		  temperature as invalid. Some CPUs do this when the
+		  temperature is too low to be measured.
 tempX_max	  Maximum recommended operating temperature (Tcontrol).
 		  All cooling devices should be turned on.
 tempX_crit	  Maximum junction temperature (in millidegrees Celsius).
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ace51e08e72dc..bee2c9896d4c5 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -60,6 +60,8 @@ enum coretemp_attr_index {
 
 /*
  * Per-Core Temperature Data
+ * @temp_valid: Whether the CPU reported @temp as valid. @temp is not
+ *		reported when this is false.
  * @tjmax: The static tjmax value when tjmax cannot be retrieved from
  *		IA32_TEMPERATURE_TARGET MSR.
  * @last_updated: The time when the current temperature value was updated
@@ -72,6 +74,7 @@ enum coretemp_attr_index {
  */
 struct temp_data {
 	int temp;
+	bool temp_valid;
 	int tjmax;
 	unsigned long last_updated;
 	unsigned int cpu;
@@ -398,7 +401,8 @@ static ssize_t show_temp(struct device *dev,
 {
 	struct msr val;
 	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TEMP]);
-	int tjmax;
+	int tjmax, temp;
+	bool valid;
 
 	mutex_lock(&tdata->update_lock);
 
@@ -407,17 +411,22 @@ static ssize_t show_temp(struct device *dev,
 	if (time_after(jiffies, tdata->last_updated + HZ)) {
 		rdmsrq_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
 		/*
-		 * Ignore the valid bit. In all observed cases the register
-		 * value is either low or zero if the valid bit is 0.
-		 * Return it instead of reporting an error which doesn't
-		 * really help at all.
+		 * Bit 31 indicates whether the reading is valid. Some CPUs
+		 * clear it while the temperature is too low to be measured.
+		 * Such a reading is not a temperature. Do not report it.
 		 */
+		tdata->temp_valid = (val.l >> 31) & 1;
 		tdata->temp = tjmax - ((val.l >> 16) & 0xff) * 1000;
 		tdata->last_updated = jiffies;
 	}
 
+	valid = tdata->temp_valid;
+	temp = tdata->temp;
 	mutex_unlock(&tdata->update_lock);
-	return sprintf(buf, "%d\n", tdata->temp);
+
+	if (!valid)
+		return -ENODATA;
+	return sprintf(buf, "%d\n", temp);
 }
 
 static int create_core_attrs(struct temp_data *tdata, struct device *dev)
-- 
2.53.0




