Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711506;
	b=H8i16yqb7v3fJZVzJ4vQxa8OrOQ/HW6x9I5qzkcPWtgQar+xHmNoXgCqpjPrM5Up9Z/H
	 SyqjxzmGzc1EMer1x7LTXVPKdU0Co20PdbtfDKDlR2PN/VHGIP6D+yz9rI+V1rW7hiaDZ
	 g3fvZJnGPwyjqlDq+Lr0QA/fOn06nS5SuQ7qL8i84tAv/bPMI30bGI242viRd0WGFenlD
	 6NPSt8Ux9AzXC8D0hPfKtMZgYof5CL5EVRVXm3rmNO9mc7/AAa8S/8IIUWOxUwS60NxMl
	 Dj7MDnh2KQygEELTbjFO0EdXSZFbs0JJZfAgANZiA7lDlzD6IeVTHoEKaRpL7S1j/9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VOOA2bwtAvUt2OjvGKWdyfSoQby6p78bYhX3pVQdB6M=;
	b=BeDB2l3vcAf6vHJeukESh7Qn2qeYDv4Jp3Qd6wDIGjuxam0AW6zHq/L/pV//NQAueFyw
	 hFnoQ1sVjDIvuYt0X0K684KUhRId41mNFarrKpIcMb7z9+ytFsBW9nGZcHStEO7l7AwY9
	 Xw7LWZ5A068wJPQpvQ+6UYB/uU3L43p64UhpDMqRaHpyG0s8IUZAcknPtWyQ1WxZd5sEA
	 4B58Jur3tbcLrAlVx5H3+dtntVpmE0zpvTQHJNOBR7PNUw0hAWxkm2Tppp/d/QhZtGj+Y
	 TmA5WeaAm5775T3qhUyWp3ue9K0jLUfdpPT+UlaC2J1axTuXLvSIqPvQqqKqJObvpMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPYydE0g;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFC606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CFFC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPYydE0g
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a0eecf73fso704680eec.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793711505; x=1794316305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOOA2bwtAvUt2OjvGKWdyfSoQby6p78bYhX3pVQdB6M=;
        b=vPYydE0gV5NsEeeaDogS7BgzpRCbgHgU0WSCZQwQCoMqDHDyzf9LteAAtIvHoISRg8
         Sqkjjfggu9hKf0eYo+kC4RiuFq4oVduhirfqu+Z4r6LgEKLI2urun+FTuH+tfSqYyH5L
         AIq97Na5n86Sycc7/8E9ZamnJLgSUBJtKAF3WMWHqvWv9QzyhBvGhPu7hPQBbGCWEneP
         PcAm6BUxU7nhKj7WiD0SPouHh7pvAbi6Mn/f/a7UhVNesrdrt6Pq/IeTSzJnHUxCA9Mb
         uGg5O91x4Spk+K8/yecj2KeA/oJ6zCSGCZqLSi1TljS5COGXbQHGXSeK3An1wZccqGC/
         hi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711505; x=1794316305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOOA2bwtAvUt2OjvGKWdyfSoQby6p78bYhX3pVQdB6M=;
        b=ef0XS7tPv/V4w7so8eZrQoyz7ev4xmWpgdb4J6xia3FERmgks+Kqv5dTrDzmz7iNIx
         CV5Y0MW0aFqh40HefFJZHQI6x39FrJoJM2e+EG0PbCxA2G9/RkLpl0LfztUuT4uumUWd
         C7327TmHrqZNtHuq2O396uIKvUcwlfB6pNMZ6MolEl9T8A5FPK+buFLaJJnOx61h5Kku
         yKQqESdb6mqwDv3SNbSRsRwja2/wxEqZRtEVxGASov2wm63Ziafb1q3TtZPjDEH8oBGj
         CQsucltoqYo7VPO2QOqZ0DhqfufSHH6m5nl6UstZeXmFoYm2ki+qI8bTBPo7M9jjKS8G
         bvTA==
X-Forwarded-Encrypted: i=1; AKwUvBzIaYw7zAIqDrGFNWLgIyrmO3S5SNGwaioOQk2bbA4VIEurCP/lGWfvK2PkDJ0d6IDOgIvhJDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3UegTM5WjJIfivJbd9IE/g/9eZGzw0VEp7A2cHIIJnCPpj1V1
	oiac6eX7Eh+6FGK8EbP2CUB/yCZ75zw8suiOsrxGF8BxL0IhpO7je37dnzeUc0KYCP8=
X-Gm-Gg: AYBFou0VyJbbN5eAq9rQat/HDv9FEou+Eu46t4e9YDsiTtO/JTiBjLirrWSXhvGxoDI
	RU/80+xo7PE1c5zHj1NYe6i1lzTpXGiHdHrXbvm57D1I5w+F847dSZKhXuTeQTtQ3t0W8r1TK/8
	I2jJC+Xoav7eck+phJbRsz+6DA7+vZSfV/QCo8OSxwMycBkD6ODvNcun2r+hCiH47nVOGHp0sCj
	ozoKqcd0zL7gHTsAKsqFn1tiC2d5Y3agzE9+FyhPz+i8q7wOLsfWZy5zOBDRBy3YNqiCqMDl0A0
	tttAaljlFQw6FLVcV6AIkHCJ+5KDCQ1zTbO7suhAYaTF/dX6X9YDXaAJE0J1vzKykXJiR9kijWC
	rumFxNkPAgeFHQ0Qw7nNGBMRrV+2mkxFuSKcRalUGc5eeCVodi6OM5FlBb3VZVVfds18IuFMzki
	PSj2t2VsqwSCd0Yk5Q6ojk/xzS+Pk04a8iyX3tCxh0f11iVzg2aMwXis9vYazsTnYkc6xYM1ZKV
	hWLYy+W/iaIKjbzgV6lQds1FFuwiQqXe32k5sdtEC5LnWyoBbLU0xd49APuHLDJU0D5kVvKmcEO
	8BR62Qyxl8xd/wwp3dU5iDEwawhZA66OHqR4TqbnxZY=
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id 5a478bee46e88-36a4231f8e3mr30427204eec.1.1793711504980;
        Tue, 03 Nov 2026 05:11:44 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm40133125eec.4.2026.11.03.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:11:44 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Input: cyapa - clamp SMBus block reads to the caller's buffer
Date: Tue,  3 Nov 2026 21:11:27 +0800
Message-Id: <20261103131127.1585884-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103131127.1585884-1-lui2012qwq@gmail.com>
References: <20261103131127.1585884-1-lui2012qwq@gmail.com>
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

cyapa_smbus_read_block() hands the caller's buffer straight to
i2c_smbus_read_block_data() without passing the buffer size; the i2c
core then copies the device-provided count, and any count <= 32 passes
the adapters' range checks.  Both the group-read branch and the indexed
loop (on its final partial chunk) can therefore write past the caller's
buffer.

The affected callers use 27-byte stack objects:
cyapa_gen3_irq_handler() (struct cyapa_reg_data, on every touch
interrupt) and cyapa_gen3_get_query_data() (at probe).  A device
reporting a count of 32 overruns them by 5 bytes, with contents
controlled by the device, in interrupt context.

Bounce through a full-size I2C_SMBUS_BLOCK_MAX buffer and clamp the
copy to the requested length in both branches.

Found by static analysis.

Fixes: 9f1cd857518f ("Input: cyapa - re-design driver to support multi-trackpad in one driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb95452..cd80ae51f4 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -254,20 +254,30 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		return -EINVAL;
 
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
+		if (ret > 0)
+			/* never trust the device-provided count */
+			memcpy(values, tmp, min_t(size_t, ret, len));
 		goto out;
 	}
 
 	ret = 0;
 	for (index = 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+		size_t chunk = min_t(size_t, len - index * I2C_SMBUS_BLOCK_MAX,
+				     I2C_SMBUS_BLOCK_MAX);
+
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
 		if (ret < 0)
 			goto out;
+		memcpy(buf, tmp, min_t(size_t, ret, chunk));
 	}
 
 out:
-- 
2.25.1

