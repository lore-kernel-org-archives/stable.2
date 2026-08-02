Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDB38F620;
	Sun,  2 Aug 2026 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785676081; cv=pass; b=tDv3BvjsncYetcI+n7ygUbxuvlnPs59+q4sHwmD7rVbM2dbz8HbU6Puhp3BxXrLv19yqQL+hiEjOQgNuWeyFLEbwczAB8JzcKfz3DYUAsHQeRCeZp2FQctS1zy6fgvgrDStf3/q7jxzzEkWDmfLKylCmWhJwcbXhM/02B5U42G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785676081; c=relaxed/simple;
	bh=xs2Y13enJ6fu9TFlYnKVKzgAO7Vvj4Vitdr4WAxNot8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AU6fdGhefEWUn2Z3tnYbsMnj00LecL2dx83eE978khnZQLUPfQ2p/xqGKTuCUr60pV+g2eampRr5bFnFDSIZgvtV7ime9hno0LB2GjzBkXT6xKoNDJ0dQC4UtUVpQCALekKMIBweevzjKs4ouJdmfNbDpm/qvIkYts7N8AUAVnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Bw+ZKwGi; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Bw+ZKwGi"
ARC-Seal: i=1; a=rsa-sha256; t=1785676061; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PN7uVsGlxAuomxZLYMu9FsjAQz9bDloPtP6SFX17Yu/8uLbSLzebvcKr2nhnXMqwVJLg1W/2w/sk9A0qPzFIOSas/fDWZFEr4wFsUUgXjMmGWyHykuei9vyeZn2sbMVv4hY+uCWJiS4fCyNJ8aVNhLkQ75WGb8DEVHsaZ+mHeO4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785676061; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JCDY7Z7yrh+BIUHCUDpHf72wImPu0VgKqB6Sdp1eG+E=; 
	b=NtvI/3IPvoqg4RlQY+6kz/mMJme9lqg+hdkUMJ1SmxAITkfBUKY2zEVCnQdA/FiEzWKjOXo/T8+xOIqQWboJssTYvbcAHrFllvWfToX2uLS0LsjfSztmV8sOtCtbke9/Ke9Na+P14rRrv2zrH2xjuJvKBamaQEgT5GjXFewDWig=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785676061;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JCDY7Z7yrh+BIUHCUDpHf72wImPu0VgKqB6Sdp1eG+E=;
	b=Bw+ZKwGi1cgJVcq50PV6GPJL9HgwAExtABj3ObpNtOnptyFRBOmuNPUvp+Zn2Nd7
	jrAY1STSxssqGD6qCQ4UFTtVW+ZZuTxZ6cqSg3NGqUuWh2zEbaUvs6FLzwBZHnhZow9
	LP6JJ8DBs06ZTzptgg2S6uYsCW40KKxGkRdoRoms=
Received: by mx.zoho.eu with SMTPS id 1785676060067727.2023961621147;
	Sun, 2 Aug 2026 15:07:40 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (sg2042-mcu) reject short uptime reads
Date: Sun,  2 Aug 2026 13:07:28 +0000
Message-ID: <20260802130728.25721-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

uptime_show() asks for two bytes and only rejects a negative return:

	u8 time_val[2];

	ret = i2c_smbus_read_i2c_block_data(mcu->client, REG_UPTIME,
					    sizeof(time_val), time_val);
	if (ret < 0)
		return ret;

	return sprintf(buf, "%d\n",
		       (time_val[0]) | (time_val[1] << 8));

i2c_smbus_read_i2c_block_data() returns the number of bytes the transfer
actually produced, which the device supplies and which can be shorter
than the length asked for:

	memcpy(values, &data.block[1], data.block[0]);
	return data.block[0];

time_val is not initialised, so a reply of one byte leaves the high half
of the reported uptime as whatever was on the stack, and a reply of zero
bytes leaks both halves. Either way the value ends up in sysfs.

Require the full two bytes. The other registers this driver reads go
through i2c_smbus_read_byte_data(), which returns the byte itself, so
the existing negative-only checks are right there.

Fixes: 758b62e562f2 ("hwmon: Add sophgo SG2042 external hardware monitor support")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 drivers/hwmon/sg2042-mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
index 591f5f572fe4..10292417e766 100644
--- a/drivers/hwmon/sg2042-mcu.c
+++ b/drivers/hwmon/sg2042-mcu.c
@@ -79,6 +79,8 @@ static ssize_t uptime_show(struct device *dev,
 					    sizeof(time_val), time_val);
 	if (ret < 0)
 		return ret;
+	if (ret != sizeof(time_val))
+		return -EIO;
 
 	return sprintf(buf, "%d\n",
 		       (time_val[0]) | (time_val[1] << 8));

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.55.0

