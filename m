Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD94B1CE5
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359539; cv=none; b=TAdLGhWh/09WCENCN867KytnZ1V2yblBXDidnfaZjlUQwjp4Jv4mfxOo5nAJOhSnjh0eMUjHVYV8szUQc/096fF1dW8l+DFsSnYQCWfwinwuRPmn9FWMucq/WtnN6u4VNtKuqnmgIHU7yHQuYhH4nymPL7Eq9xhkBDelUPmXzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359539; c=relaxed/simple;
	bh=s5+8pjr6Fwtuw6XJ7hD5nPa7v+Qr2/LhjInKDahwUig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsdbqO9Qsx+gRLEyDaw97tmvSyXhLFLgM0ZJQP7fIpJuhRNtM246dwbAcAk6OrzOzwXYGGz7FPy6T8Gn5nVY3hNXrOmS1e8fIw4Yhf4v457Uf6np2VoX8MhpdFqmPSRah7JO5vOvFIzhS6OQKO9hGtqG6eI0cYIkCmiMVGRlYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be; spf=none smtp.mailfrom=inspiral.be; dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b=0hRc45tQ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=inspiral.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b="0hRc45tQ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so7353855e9.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inspiral-be.20251104.gappssmtp.com; s=20251104; t=1790359536; x=1790964336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jlZAHXA/+Siu5/Nc7tK0sL1VUl2GgSD7bLrNdmf+Xek=;
        b=0hRc45tQFHneENMDmtdYWQl09hdcnu5Tq8RbrO5w0YP0Spt2OUarCsn3PrbVbRjrQb
         T9pArz8DHAvpeJpqCnQ9f/vj1sd9boWenB4uiXhR2h3QqwP3V3b6ojte6bXLwyvtvBGp
         6uhFJASymnOnERn7YJGkXYdUc0v6AlhJskM7nWa7FdQwMyexEzkztLTuN8C6hjExN+Za
         Zi/PXkHKY9CtWZlkE+VKrdzpSwaGFpPKVl3p8uEco4qTeMFAj4wJH2vS4nM3wxhByAOO
         WEe16dozKBrpE1LpXvpe3t+PJDFHhqa2R2D/vfHWNnTo5XNfE5hG9haHt0GEoI/ahYRv
         bdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359536; x=1790964336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jlZAHXA/+Siu5/Nc7tK0sL1VUl2GgSD7bLrNdmf+Xek=;
        b=g9uASmI68qgw3eBPrN5zs3DX1MGPC7fTPAcxqwEWldlT4fwzpZHc9C1kIP/idrBvKZ
         wklTR8aTzAgBSHf/wnE64txyBsDIN/vcPtw4RbJoZyGM9CuS4czo6ooYVWFpTtdPQ8LD
         Ljn/AqrOaxY7dla7wPhI3+vARWYsCwiaSESLP+FsLMpLw/uhhV2G5H+kLsUsq/UdWhHY
         wu705oRqEEupXa5IO7xehQhHmbms+gtsCGc9+3ta/o6goj/xNevWR/vUqijA28ZFZTy6
         WwBr5yBsX1KjuAQLY3VFS9Tj248s3qCEH9s3s3wtooQ0UXUliwlDVSap2SAGT/JtmR7l
         LWdQ==
X-Gm-Message-State: AFuF++nF589Kl8he/Xe6Q27EFHCfgVnbxEPfTtHu7zySnCnXnLIIlvjT
	bZKBx0wJlUG7UTEN2ma6OjTfBAGfec+X/aTlLg2TH+eCVK7QfEogQCTqe+Duw9jDFk8HZ5PQBf/
	XmPoj
X-Gm-Gg: AYBFou0SbTjmkfnfqEnyZI8s+aSW1Ox1VsG2ZdQM1ZwBXm3+bsSTkwNUaTgtdlck9Fs
	yxvy/NtQeAfUOa8gNkQqRclsHKdUA/43I2XNk04VCky+ZEINVS5GO0gHSvS9MtjsZUgm1DWMCuB
	NoCOfgR5hF7CssvoLQNgR7S0SThAW5A1mYv80PWciECFr9X6+64eosNK1mS+z+NyLqumI61c2WD
	0xP+IQaAHCIx4ouQ0hdxBC46FyPBs0y84ub7JjaFYNCZq3haJZ+dvPhH0Q5I3PochLpOL0ecwUa
	Pz9KG7Z02WoB1pOgAVRyExLpvIC5Vq7JGXd5/Lk75gO8smx/YGcuX0USD3lDMb5Ecx5r1ueyeSh
	b8rAuFZeCNrLYmD3d6AeO3rS99//G5kdjXzKUQWg4ZvGrgfMs90dMtCdEKaUAoo8F/3W2u4ELxB
	leyTP561RMbR5UG1as0PNBMMcrbQ0lt+cU0hmDMKHq8mLk/broy8CwoDKXVDb4H6R4hVmUPBV5a
	TXz8cLR/b85Cn2RC1kxy28k8UkEMds1kD8cnhevN343NMNM
X-Received: by 2002:a05:600d:8653:10b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-49fe70151ebmr86184735e9.9.1790359536473;
        Fri, 25 Sep 2026 11:05:36 -0700 (PDT)
Received: from vger.localdomain (178-119-186-126.access.telenet.be. [178.119.186.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm165106255e9.6.2026.09.25.11.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:05:36 -0700 (PDT)
From: Tom Verdonck <tom.verdonck@inspiral.be>
To: tom.verdonck@inspiral.be
Cc: stable@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (sht4x) Fix jiffies wraparound in heater-ready check
Date: Fri, 25 Sep 2026 20:04:46 +0200
Message-ID: <7b2087ccb963e097cf3f6333efaec0c46549003b.1790358356.git.tom.verdonck@inspiral.be>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790358356.git.tom.verdonck@inspiral.be>
References: <cover.1790358356.git.tom.verdonck@inspiral.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sht4x stores in ->heating_complete the jiffies deadline at which the
current heater pulse finishes. It is set once at probe (to jiffies) and
only updated when the heater is explicitly enabled via sysfs, so in the
common case where the heater is never used it stays frozen at its probe
value.

->heating_complete is an unsigned long compared with time_before(),
whose signed difference is only meaningful while the two values are
within LONG_MAX jiffies of each other. Because the deadline is frozen,
jiffies keeps advancing away from it, and after 2^31 jiffies the
difference flips sign. On a 32-bit HZ=100 kernel that happens ~248.5
days after boot. time_before() in sht4x_read_values() then wrongly
reports that heating is still in progress and the read path executes

	msleep(jiffies_to_msecs(data->heating_complete - curr_jiffies));

with a bogus, huge delta, blocking the temperature read for a very long
time instead of returning data. The heater_enable sysfs attributes are
affected the same way (spurious -EBUSY and "1" readback).

Store the deadline as a 64-bit jiffies value and compare it with
get_jiffies_64()/time_before64(), which does not wrap in any practical
uptime.

Fixes: 0eed6fc3d2b9 ("hwmon: (sht4x): add heater support")
Cc: stable@vger.kernel.org
Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
---
 drivers/hwmon/sht4x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index a97dda9e92dc..da2b6130fca7 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -67,7 +67,7 @@ DECLARE_CRC8_TABLE(sht4x_crc8_table);
  */
 struct sht4x_data {
 	struct i2c_client	*client;
-	unsigned long		heating_complete;	/* in jiffies */
+	u64			heating_complete;	/* in jiffies */
 	bool			data_pending;
 	u32			heater_power;	/* in milli-watts */
 	u32			heater_time;	/* in milli-seconds */
@@ -92,14 +92,14 @@ static int sht4x_read_values(struct sht4x_data *data)
 	u8 crc;
 	u8 cmd[SHT4X_CMD_LEN] = {SHT4X_CMD_MEASURE_HPM};
 	u8 raw_data[SHT4X_RESPONSE_LENGTH];
-	unsigned long curr_jiffies;
+	u64 curr_jiffies;
 
-	curr_jiffies = jiffies;
-	if (time_before(curr_jiffies, data->heating_complete))
+	curr_jiffies = get_jiffies_64();
+	if (time_before64(curr_jiffies, data->heating_complete))
 		msleep(jiffies_to_msecs(data->heating_complete - curr_jiffies));
 
 	if (data->data_pending &&
-	    time_before(jiffies, data->heating_complete + data->update_interval)) {
+	    time_before64(get_jiffies_64(), data->heating_complete + data->update_interval)) {
 		data->data_pending = false;
 	} else {
 		next_update = data->last_updated +
@@ -237,7 +237,7 @@ static ssize_t heater_enable_show(struct device *dev,
 {
 	struct sht4x_data *data = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%u\n", time_before(jiffies, data->heating_complete));
+	return sysfs_emit(buf, "%u\n", time_before64(get_jiffies_64(), data->heating_complete));
 }
 
 static ssize_t heater_enable_store(struct device *dev,
@@ -279,14 +279,14 @@ static ssize_t heater_enable_store(struct device *dev,
 
 	guard(hwmon_lock)(dev);
 
-	if (time_before(jiffies, data->heating_complete))
+	if (time_before64(get_jiffies_64(), data->heating_complete))
 		return -EBUSY;
 
 	ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
 	if (ret < 0)
 		return ret;
 
-	data->heating_complete = jiffies + msecs_to_jiffies(heating_time_bound);
+	data->heating_complete = get_jiffies_64() + msecs_to_jiffies(heating_time_bound);
 	data->data_pending = true;
 	return count;
 }
@@ -410,7 +410,7 @@ static int sht4x_probe(struct i2c_client *client)
 	data->client = client;
 	data->heater_power = 200;
 	data->heater_time = 1000;
-	data->heating_complete = jiffies;
+	data->heating_complete = get_jiffies_64();
 
 	crc8_populate_msb(sht4x_crc8_table, SHT4X_CRC8_POLYNOMIAL);
 
-- 
2.53.0

