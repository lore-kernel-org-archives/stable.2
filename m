Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046353;
	b=xvdWEQ+gBH5r5dB0IFvf6QGn58gPXVpSm5uYPzrWz1QnxYwAHYbL2DUQPxUTf4FCCs6I
	 cWMtQymb5q0d3V/BJsefC6+iQAfrkVCo+bix7/SwSSCjmENxgdCnKFkxHggj6NzpM4/tE
	 eXR9G17fPHWlpthjrRkG2+w05Dj+3gg6x8SAmNAKJYq/I11drbgWEd1u7HKRxSSJVu1R7
	 FrNfN1gUDhuXvTV+jYg5Hu4WFg4QBj1IxvoIcgXMPIrEhIVE3RidTeUW/zFws1SMEeWH5
	 CTS8nMtSgsn5VAZ1Bv/lCrcWko81o+HRIKOtq+SRre4qGyYpvWtaQB/gt5QWdp7igAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FDc1NipKNeSdBMM11wJJMkIhGKQzHdLWJwLbjmQQexg=;
	b=tFf2WTTuph267UET0l4yRoTo43CDlyudVSHlVYy9v/N6S/hfP+gwJPPAq8KuDPW28NPE
	 1oZiRejT9jWAD231AmAy4YJNyKinlB3UIX5w/HR2g/K7+XWaD8QZvSohVyW+hN4ME/VVD
	 Z5xLJv+U2NvM31tEzheOlR6mTWlVBgW1eC2UT/sUCm5k95TRmg2rZTBY36R3G8guQwwH+
	 pLjd3JD0AbYFvLa15ztaNfLoziMM+gWE9zt5/kSt8DkQUG2eWulS1ci2pc4B2By1up3Ca
	 t+rXEC1mcm35Tteq+dZb1sQixPpAuR+qeGdsB23q2swpRiZXDDGOUpreQZ38hQVe3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMWU5C7U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0A606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMWU5C7U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CEF1F008BC;
	Sat,  7 Nov 2026 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046353;
	bh=FDc1NipKNeSdBMM11wJJMkIhGKQzHdLWJwLbjmQQexg=;
	h=From:To:Cc:Subject:Date;
	b=XMWU5C7UURLK2kSeuDOJJ7IEskvssr5dnG7q+oZpQgMtvArC4TEMPPMDYD/cU3RGN
	 +oKvwkZ+L6yofhgjq9jwtfPqa6hX4g6s9N0lJFZxdcwx4tvroKa/Im+5gG4mq5Qkhd
	 toq3aFFv01s4krgCCBwhh6WLEqPsc2fZvlWkZcZPMsglA977IqQeF1y3YrXW/EtahX
	 83+F6sQ9UmlPmRbFbogwyPagw1k4PIeY7ewPJGVBzBTpAGweYg8YiCnyqALBJTGls4
	 C3800zMWfG7S4kmyvsxRDtvuAJ5ZHhAYX9M6JuuorTW0OQJ0G9JlLSLgycCHEtojzo
	 XHrLBUIPEN1sw==
From: Sasha Levin <sashal@kernel.org>
To: ricardo.neri-calderon@linux.intel.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Return -ENODATA for invalid temperature readings" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:32 -0500
Message-ID: <20261107051231-failed-6.18-f63aaa529cbc@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f63aaa529cbc73146ff0d52235e5479042285cae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051231-failed-6.18-f63aaa529cbc@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




