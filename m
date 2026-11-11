Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421260;
	b=Fj1yGLyOaQi+fNNT/sj3pgo+lkWWTJIDXO0Zj+glfmSWsESNMd5rEfn8Ba7r/2WymRlM
	 I+oH+ufedHGXqeUUb+F5aJS/zPF+WSx4ZBdfYD0I73PgK10N9qpUHnGw/AfBbeTyhj9wt
	 eMtTYlNEt3wCYuGwk2GrqddxvYXUdq95poy0uKU78TM39+GlKBsxKfSNAaAgpd+UbUDRt
	 IA2eA74U/IsZzGX6wCdPeoHIEi/ZPUgKWkjCW49lE0RC1OP7iD+h5Nl3gdKI4V35GeKL9
	 KH33Y9xuCj25E7aJrm8kQWYYlVtfVUBZoHg2G9rRc3h95Kta5L5MiaQkhxgC6zlKC2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=plt81vRQ+79Q1R/D7SZu/GmJzMzz+R32sw0OjXwQ1wE=;
	b=CstPEtUW1Qy0KpH8Pky/qe2OgBFzCUHGs+5uLFHPm24ES5ap2qTkINDrQLVj1JRFDN2t
	 AaQ8C+4EGeWPM4ZK8KZaGc275v4HnrwkzZGlsGeqsAo9ElqTtivykSEKGnsFXipd6PLLB
	 Ns/HlKTPdMTLI/qCEHT7BN/HemV7g8u9DPF0pwxX6Dk/6D0F0gW3sLRnhcsVCXSWbZ4uC
	 qzMPWTaJHxLOnWEe/YXeROPq1lKY67GzCtTNIhVpfL0oWs50719V15/s8yfQK6bHjDv7D
	 Uekt+O8Pf600xCibJcND+h34t7REP+vpP+11LWCGYUsNp8G26Y699qWqJZEQOUnmInw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTTxBQoK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B8606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTTxBQoK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F421F00A05;
	Wed, 11 Nov 2026 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421260;
	bh=plt81vRQ+79Q1R/D7SZu/GmJzMzz+R32sw0OjXwQ1wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTTxBQoKEfwdmQa7mbgivMDHpl6lBCzOyXuo8A77sHl2dBQDRPn/uBkX0NZocGR5b
	 CQzIMBUp9m1JohUBEvB7MwXwOLLb7uvGohxLy4AFursXOHqo2ZJya7RKtzruYh1/aF
	 oTGDDfNXL7+3Kj6X89scX/sPlxqdNxpdneo/OUsnb24kQulbCVbgUwBlXPhNuiJaGG
	 WaiGhEx+SkfSB5Fm7nMDrxLDFdDvZ4Z6+wM7y9V9AjeHc1UEZWGZI3+lgfI91t0Zt5
	 iaWCLs7RB40zRssgFRhWUiocpthqV87NyPk+2mwt7IJ1uXozYRvClbmeHqZoivClAl
	 13c/IMsoEk7HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hwmon: (coretemp) Return -ENODATA for invalid temperature readings
Date: Wed, 11 Nov 2026 13:20:58 -0500
Message-ID: <20261111182038.3820042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051231-failed-6.18-f63aaa529cbc@kernel.org>
References: <20261107051231-failed-6.18-f63aaa529cbc@kernel.org>
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
[ sashal: Adapted the MSR validity check from val.l to eax to use the existing rdmsr_on_cpu() interface. ]
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
index ac56319ff90cf..25a9cf8feb311 100644
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
@@ -391,7 +394,8 @@ static ssize_t show_temp(struct device *dev,
 {
 	u32 eax, edx;
 	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TEMP]);
-	int tjmax;
+	int tjmax, temp;
+	bool valid;
 
 	mutex_lock(&tdata->update_lock);
 
@@ -400,17 +404,22 @@ static ssize_t show_temp(struct device *dev,
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

