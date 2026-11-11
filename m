Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421403;
	b=M/ZMdck0jRK06p3wo64QLNgItJdUQb51X79ZKdusd7fD31cLieobWD8KOeEsl4Qqy1I/
	 4TflcHvAWGDgRVUqUQobCbY57WwosN2Z4vGWvYxY87A+BMQblNzA8TTAPMJuAv/nByBbL
	 zDf0LEYn35EhN/pLa5IAlMWz1sNFihZZbP7xs3lWhwROB1QbLNv3KXA7hbNVC/fRlVzkb
	 pkv8E4QPJFSp3WxI7kko7hhp1/WCVRgUCyHGXUFkWVJ7Czecca6h2WHq2n0HrPYRhwYHl
	 +E5y6sBrvKnaa04Xf2DawTSL8cf62TvxjY7vS5eAOFOMD1iFMSeuI4Y15WHQPsQAh2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421403;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UwJB1YWyj9pDO/W8xyKSxCNsv5DxN1vL9s38Rnbi8Ww=;
	b=vCNFfvfyQ0zRgl6Ats6CQUONrEIoeqbFAFJZOtLHh1zWIERJwh9MHSUhYWGw29ncwb3x
	 tbIl41eekkzwfZOpU9XAua2bzVBdmG3/HVJDvIoRTqBfyZsN9zRLpCpPgSYk9lSssQfHg
	 wIHaJGaDOYtPUBBHugc2dik87KShYrjbB6Hopvu80i0PCuprHEsi3f7dPM5iyg1c719yi
	 J/ifQ8/tAKY7GSmVWIONJ/OZYIb8vSbu1ZqGNPbS/aGniFU/VmH5YW0Z/atGStUzA1Haf
	 7eEeu3WaLsKLd5MaJTbL/RH7ImfyxUdYO4nQSWNxwXphcyybnG21Ipy0vhw2fG2aKWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObfD8RnZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5C606A336
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObfD8RnZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3704D1F00A05;
	Wed, 11 Nov 2026 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421402;
	bh=UwJB1YWyj9pDO/W8xyKSxCNsv5DxN1vL9s38Rnbi8Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ObfD8RnZckfiCoRcIm/0jQlFRRW9YePJJ42uOLLo2xxfHj/b8YGDlPYTCYTZNGQbA
	 9HnqRzL/dxDy+bbOm2LsVlChNDGrRVWwtUuKw7xqapAfiNBAsG0w+6ymoqleJ/+iJ5
	 H/qcOcmS9/0+RdAcV+EA/sVB8e5lt6cSrN0Nz3UsI1MiaDB1fvke889MbrImAt9Tyh
	 Eeolj447U0sTiQOx6UjDisgN3rP+jGu6EPEZjg6yA2uCb3Yy0uJbgfyJNY5FgugnKV
	 rbQK4nXKJuOma4vGFVAF6jIKxTYpVOmv4zDDA7ZRVUdbncl8UcAOKv9wiGhGMO210j
	 49B/HWZNU73xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (coretemp) Return -ENODATA for invalid temperature readings
Date: Wed, 11 Nov 2026 13:23:21 -0500
Message-ID: <20261111182303.3834607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052352-failed-6.12-f63aaa529cbc@kernel.org>
References: <20261107052352-failed-6.12-f63aaa529cbc@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

[ Upstream commit f63aaa529cbc73146ff0d52235e5479042285cae ]

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
[ sashal: adapted the validity check to use eax from rdmsr_on_cpu() instead of val.l from rdmsrq_on_cpu() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/hwmon/coretemp.rst |  3 +++
 drivers/hwmon/coretemp.c         | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/coretemp.rst b/Documentation/hwmon/coretemp.rst
index c609329e3bc45..6089bee1159f1 100644
--- a/Documentation/hwmon/coretemp.rst
+++ b/Documentation/hwmon/coretemp.rst
@@ -47,6 +47,9 @@ All Sysfs entries are named with their core_id (represented here by 'X').
 
 ================= ========================================================
 tempX_input	  Core temperature (in millidegrees Celsius).
+		  Reading fails with -ENODATA while the CPU reports the
+		  temperature as invalid. Some CPUs do this when the
+		  temperature is too low to be measured.
 tempX_max	  All cooling devices should be turned on (on Core2).
 tempX_crit	  Maximum junction temperature (in millidegrees Celsius).
 tempX_crit_alarm  Set when Out-of-spec bit is set, never clears.
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 8de1c781ac7a8..cc81b849c09ef 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -61,6 +61,8 @@ enum coretemp_attr_index {
 
 /*
  * Per-Core Temperature Data
+ * @temp_valid: Whether the CPU reported @temp as valid. @temp is not
+ *		reported when this is false.
  * @tjmax: The static tjmax value when tjmax cannot be retrieved from
  *		IA32_TEMPERATURE_TARGET MSR.
  * @last_updated: The time when the current temperature value was updated
@@ -73,6 +75,7 @@ enum coretemp_attr_index {
  */
 struct temp_data {
 	int temp;
+	bool temp_valid;
 	int tjmax;
 	unsigned long last_updated;
 	unsigned int cpu;
@@ -397,7 +400,8 @@ static ssize_t show_temp(struct device *dev,
 {
 	u32 eax, edx;
 	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TEMP]);
-	int tjmax;
+	int tjmax, temp;
+	bool valid;
 
 	mutex_lock(&tdata->update_lock);
 
@@ -406,17 +410,22 @@ static ssize_t show_temp(struct device *dev,
 	if (time_after(jiffies, tdata->last_updated + HZ)) {
 		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 		/*
-		 * Ignore the valid bit. In all observed cases the register
-		 * value is either low or zero if the valid bit is 0.
-		 * Return it instead of reporting an error which doesn't
-		 * really help at all.
+		 * Bit 31 indicates whether the reading is valid. Some CPUs
+		 * clear it while the temperature is too low to be measured.
+		 * Such a reading is not a temperature. Do not report it.
 		 */
+		tdata->temp_valid = (eax >> 31) & 1;
 		tdata->temp = tjmax - ((eax >> 16) & 0xff) * 1000;
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

