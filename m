Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581272;
	b=VEzzM6wSTp2ch0E7ThjFfFjOT27NPUbZ/1XL0q5rFrDrC4FiXJfg97w6sQSkoOSvju4q
	 euAYbVActGeW/6MNaCxKteKFfRf1U9z0yPcdzbZp3nknHq6rPooH0TbbsNdXjJljrgjrw
	 v+evAv4zOxQJIZ5Npb+zbAmTRz5toFFnMCiyPjMKfeOaEdNFQPTZ5CijeTLyYLVboOYyu
	 QXJ83KyvadST5q51XWgjJOFJeU7xC7+xr/L9xFR4Z1KOVzz0qmqoTO72sSQhdOPJ3OQh6
	 TC9kSwKV/RpSrbzkqQ1o/3SvbatxX+RsgHpMfPxYxMUl/Kcavl93tzhdxIZqCyf8UiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581272;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M+aiT4XYIrTKg6608Ukrsg48EgQ5OWjzFBlXdwB7wa0=;
	b=42lHzNt8dpJ0Hyo4d5zZb5PeqsW0aos9iPMN2FhQ1kv5N3MPBtvk3grJQmp+OF5Q2SHP
	 a5t4FO/BuNIq75ly4yUi0hmVXb+0EX+O+4+h4wNqn7L0YjaDU5EaM1wTq+tF6SYyr1hhv
	 uqK/81qrslosAEMrXqBo84gTxpyoUe3MfOZd7ZioV7Steh6p297fmfMzifUWDWhu8BP+u
	 oXeKqqWED295Uz0TTla3sbDxmAj4ipGguBKk/zVWvaXvbpQ/CFmCt5AZup5yn8wwgMiXw
	 DM1/aiIVMjW8fWBHef5ikOB0FAqIQ2X1QR11G0sm+3bwK8qj9SJNWMNvWAjwFqbrxGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuVBtcQS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80718606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuVBtcQS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF1D1F000C4;
	Fri, 13 Nov 2026 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581272;
	bh=M+aiT4XYIrTKg6608Ukrsg48EgQ5OWjzFBlXdwB7wa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VuVBtcQSGWbls+cyaHlW320p9bCSa//i1QP9Jyf5213ner+6MB6uF8KitJEdvfxem
	 JFW/4h/FK3CBE4OnPY51DHu4nuILPhBIAamXBqeRtbbacEy3RRgwAjA7DrNSIN9Ian
	 vbaeuGzspI/rgA9tl/ppr9Nl6gx6hpUtU7f0sYyVirXaRQbR1j4NEV20Ru7LN664r3
	 /B1eWE3HTX/SY6IZdOPtq5ToqqHS9DRyaYIU+WXPyVBHPPd4I1FQj104wkENQkTyiF
	 LX8u5zi2TOiPHk/k1tXDSpsfcvrutSN7m2CP/qCKdeicmStEYoiai+22eHTjFk6xc0
	 nxM8bYgDciAHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: (coretemp) Read TjMax only when refreshing the temperature
Date: Fri, 13 Nov 2026 09:47:49 -0500
Message-ID: <20261113135623.1396306-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200341-failed-6.18-9a6aa085c94c@kernel.org>
References: <20261109200341-failed-6.18-9a6aa085c94c@kernel.org>
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

[ Upstream commit 5407d2b7d5279b7100621d92f2181184c8f00d62 ]

show_temp() reads TjMax before checking whether the cached temperature is
still fresh, but consumes it only when recomputing that temperature. On a
cache hit the value is discarded.

Discarding it is not free. On CPUs that report TjMax in
MSR_IA32_TEMPERATURE_TARGET, get_tjmax() returns the value it just read
without storing it in tdata->tjmax, so every call reads the MSR again.
That is a cross-CPU call whenever the CPU owning the sensor is not the
current one, and it is made while holding tdata->update_lock.

Read TjMax where it is used. The value cannot go stale in the meantime:
bits 23:16 of MSR_IA32_TEMPERATURE_TARGET are read-only, and the register
is package-scoped, so every CPU of the package reads the same value.

The temperature reported to userspace does not change.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://patch.msgid.link/20260924-coretemp-temp-fault-v1-2-1884f0ff97d5@linux.intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Use the existing rdmsrq_on_cpu() interface and struct msr in show_temp()
so the subsequent timestamp fix applies without changes. Read the
validity bit and temperature from the same low word as before.

Stable-dep-of: 9a6aa085c94c ("hwmon: (coretemp) Fix 32-bit jiffies wraparound in show_temp()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 25a9cf8feb311..7c2d531d3ffb7 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -392,24 +392,24 @@ static ssize_t show_ttarget(struct device *dev,
 static ssize_t show_temp(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
-	u32 eax, edx;
+	struct msr val;
 	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TEMP]);
 	int tjmax, temp;
 	bool valid;
 
 	mutex_lock(&tdata->update_lock);
 
-	tjmax = get_tjmax(tdata, dev);
 	/* Check whether the time interval has elapsed */
 	if (time_after(jiffies, tdata->last_updated + HZ)) {
-		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
+		tjmax = get_tjmax(tdata, dev);
+		rdmsrq_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
 		/*
 		 * Bit 31 indicates whether the reading is valid. Some CPUs
 		 * clear it while the temperature is too low to be measured.
 		 * Such a reading is not a temperature. Do not report it.
 		 */
-		tdata->temp_valid = (eax >> 31) & 1;
-		tdata->temp = tjmax - ((eax >> 16) & 0xff) * 1000;
+		tdata->temp_valid = (val.l >> 31) & 1;
+		tdata->temp = tjmax - ((val.l >> 16) & 0xff) * 1000;
 		tdata->last_updated = jiffies;
 	}
 
-- 
2.53.0

