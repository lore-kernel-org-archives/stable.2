Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770522;
	b=mcjVxolbbBW1X8CSovE+lAqnJ6qpRF8NfektllvKIEQGyINoZ70F+URc4hhguIecpXhc
	 avcrwTewK9KwZ9IluolNC9/9EbFSGWQGAb/ctJVpLA1gZh0cp6chM3KGZ9SvOa8vfD8F6
	 f5w/ausmTvl46/dzYlBkzVyvlZHm3hhzsBCJw/sYTiHLrTBV0tWv7+gp0bhiIijCg+CIG
	 2SJZHXUt9jyEKi9JPcFJpbkgRbVt0lKdM5y3PL/CdljJndZ52hyQQ4iR06IltZh/5jATB
	 ZIN0mt6cnwcaH1QwAieFjH9ZUKqxH3qknMh6AUMuk+ZUJXrc6OM5IOe3wH5rIAfeEpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JDoNSN/ccvThmpxJ1pEvOfhTc1YMWgt5laJmjZ6WIdg=;
	b=f86E3Ts31KsXzAJbAoKfcvAT8Gnr3Bqpuk7LIx2rJPPuWP4ct3qwPeV1o+iyM5DvmxYM
	 pB0ouI9eZWtSFe6d2n0IR9sYLoKzIW+dLiBYluTRyeFY/YmA/kIRdA0lKeGxPOgJCRgs3
	 2LdxU75hGuBagvhlq+E4uHBq3GZcAGHqC/25Aaz+NZ9635SB4SrYmHOBvvhSL+0US2eXu
	 fzDsfVV+JdVO6BclpG6MsbkJdr7YcHGaMbXTVpZxvh5S6pvquplD+zkI/eC4KY5LybDJL
	 HnjTzEBKrd/ds/8wFgsLGPVEIsze0JE04Jo+K2wV0sg0gDTK3DCeqECHsobnhIXkmCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+GBscLM;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643B606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5643B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+GBscLM
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33fb4680717so4358735eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770521; x=1796375321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDoNSN/ccvThmpxJ1pEvOfhTc1YMWgt5laJmjZ6WIdg=;
        b=Z+GBscLM3RTGFJbG2jH92f+0wKgsUV2kY2bWwzeKt1fs5F9RubU/5FmkS60t4cmTL3
         Fchq3wJD00JZcmIXtnLgKb5YGEoWRoRK8MwYzCJUR0K+5pe7EMOAK60ABtNVijdrhYjE
         kGxiPD1RpYs0SOurJIAZPJBdCtTiSIatW7OUFnQLcUbOw8FhFh2xmEOAmvkNoX+sw/XD
         HzUV0VRelAdR/tTTEgkX8sYn4vqaCOOyzraDQBAxHdmr9FLDAnxB3/JiPlcrHZNcmICK
         f0Z8Tx4cObss+OFF5Yw9uP9XxKKYzLw1y29qmhlLro0DqU3c8jRyrGLVcGrMitR8yyzj
         m0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770521; x=1796375321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDoNSN/ccvThmpxJ1pEvOfhTc1YMWgt5laJmjZ6WIdg=;
        b=dq5noO6isPAlbAXoPCUuDlrVjsYhCm3pGF2j9kPkRTp1xFgdis6f61MMadyeeCh8SA
         WDsnw6ioLg9kmC79hV2qMB9doWtNQZe5rp17UQgLfl3R1JEWkizp9u/KreATBqufC6b1
         YqhetYQl3QcK9x0Y0bX7djpFsWf31slP2PLMGkqsKQBCjleHYYBz4TDquR/3rs7y66WL
         BA4zA1YmdvJ4TA+IEJAUTPayJW0cC4nWrCbaaurlX1nf9G+TytlGBS3Q8gBkDHAOmDPE
         040iSxZL8mXQ6iN9D06j7vdeGblOCeySAetpBrHu7WCgcETRa2WJUgrT89J3yTFgP2Gs
         gjUQ==
X-Forwarded-Encrypted: i=1; AL+hErEpI3Dt7/YG9EeALMjOKSzDjiSV57hSnOyk5VODnYdEsIhQdFmhOcQ+vFxx6JXVfN/dL3qsj6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RvVfLbIHIgByNWkfmesI4WUQSLtD/j6ZvtL4GR8Ojxl/VS45e
	7FNilP76O0O4TNOCpYz7DvjlGQZyy5EGat8zPHXzTySCbG7TNVP3ozbO++IDew==
X-Gm-Gg: AZFdTZfU8jt/NYLEPfCq4P3AZYiwUgjOFxY4O5x2SjtwCZ/dLrBUegDYxZi6Gb5dRmF
	rBcGMU3KRdZeFUSMh1cFo4EkEKmgJVh4zRVfRGYCydKu3c8tNjtdg91F0Iww39AWVyANMHZRniI
	l/c+v7vnieHRd72M9sVW7Cw6QaISCuCi2gnAnzuu5WRp5eKSerE6TK9tszv66D3ajErQd8lVETi
	VlNJE+UT4VHSStkdBwuKGkHR+9RROE6tBaRk79G7MOElrg8cmEISp3zt9cnASBcBxbBvBUw9vn5
	R8bj0orseDiQlquUfil3+CwUizEtWGJDBZNShfIV0L3bIW/5YZQy1hGkVmDQ8zgqprOvmmQOyL1
	11/bo6WuVqe9eKck5juAYTYQs/FEip5v3KZfZ2SFROJXVixOqNTLzbdKqhLt7umjbj7V8B3+6ef
	cIjMmEYWmcI9KgVrBPUiMDDMk5WNLSXL09hblZAmqXz+rCU6b+Ez4pDaiiPwF0ksP2olmiZf9Vt
	iqEyB1ods8+cCOxwZxfsGJriGyNZ0EKUOpcK+WAAuCWIRftdcIIEX5dWte+OxJnFsbIdtx7XWSV
	sETYmZAxl2VwIcTxa0D0wGlUGgEiFlrGi3mUQ62LiWcSAmIZa8Cie+ryU3ChXlZiMzMEduSYCOg
	=
X-Received: by 2002:a05:693c:87d2:10b0:386:effe:512 with SMTP id 5a478bee46e88-386effe0580mr744270eec.32.1795770521366;
        Fri, 27 Nov 2026 01:08:41 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm63646122eec.20.2026.11.27.01.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:08:40 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: [PATCH] hwmon: (occ) Check sensor_length against the sensor struct size
Date: Fri, 27 Nov 2026 17:08:37 +0800
Message-Id: <20261127090837.164246-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

occ_parse_poll_response() bounds each sensor block by
num_sensors * sensor_length. The show functions index the block with
fixed structs, such as the 68-byte struct power_sensor_a0. A smaller
sensor_length passes this check. The reads then run up to 17340 bytes
past the block.

Ignore a block whose sensor_length is smaller than the entry read by the
show functions, like a block of unknown type. A larger sensor_length is
still accepted, because the reads stay inside the block.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested
on hardware.

Fixes: c10e753d43eb ("hwmon (occ): Add sensor types and versions")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260617201822.3B46E1F000E9@smtp.kernel.org/
Reported-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://lore.kernel.org/all/20260619023019.1064970-1-runyu.xiao@seu.edu.cn/
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/hwmon/occ/common.c | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 5836054c5c25..4ec954728222 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -1049,6 +1049,45 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 	return 0;
 }
 
+/*
+ * Size of one sensor entry, as the show functions read it.
+ * Keep in sync with occ_setup_sensor_attrs().
+ */
+static const struct {
+	const char *type;
+	u8 format;
+	u8 size;
+} occ_sensor_sizes[] = {
+	{ "TEMP", 0x01, sizeof(struct temp_sensor_1) },
+	{ "TEMP", 0x02, sizeof(struct temp_sensor_2) },
+	{ "TEMP", 0x10, sizeof(struct temp_sensor_10) },
+	{ "FREQ", 0x01, sizeof(struct freq_sensor_1) },
+	{ "FREQ", 0x02, sizeof(struct freq_sensor_2) },
+	{ "POWR", 0x01, sizeof(struct power_sensor_1) },
+	{ "POWR", 0x02, sizeof(struct power_sensor_2) },
+	{ "POWR", 0xA0, sizeof(struct power_sensor_a0) },
+	/* format 1 has no user_source */
+	{ "CAPS", 0x01, offsetof(struct caps_sensor_2, user_source) },
+	{ "CAPS", 0x02, sizeof(struct caps_sensor_2) },
+	{ "CAPS", 0x03, sizeof(struct caps_sensor_3) },
+	{ "EXTN", 0x01, sizeof(struct extended_sensor) },
+};
+
+static unsigned int occ_sensor_size(const struct occ_sensor_data_block *block)
+{
+	const struct occ_sensor_data_block_header *header = &block->header;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(occ_sensor_sizes); i++) {
+		if (header->sensor_format == occ_sensor_sizes[i].format &&
+		    !strncmp(header->eye_catcher, occ_sensor_sizes[i].type, 4))
+			return occ_sensor_sizes[i].size;
+	}
+
+	/* unknown formats are not used, see occ_setup_sensor_attrs() */
+	return 0;
+}
+
 /* only need to do this once at startup, as OCC won't change sensors on us */
 static int occ_parse_poll_response(struct occ *occ)
 {
@@ -1094,6 +1133,15 @@ static int occ_parse_poll_response(struct occ *occ)
 		}
 		size += offset;
 
+		if (block->header.num_sensors &&
+		    block->header.sensor_length < occ_sensor_size(block)) {
+			dev_warn(occ->bus_dev,
+				 "ignoring OCC %.4s sensors of length %u\n",
+				 block->header.eye_catcher,
+				 block->header.sensor_length);
+			continue;
+		}
+
 		dev_dbg(occ->bus_dev, " %04x..%04x: %.4s (%d sensors)\n",
 			old_offset, offset - 1, block->header.eye_catcher,
 			block->header.num_sensors);
-- 
2.34.1

