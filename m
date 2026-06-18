Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE340D56F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742717; cv=none; b=Rq+cHV8HIqIOq5OyhV9xrEHRn6OUNNEe9GXUGPkjN8JWUDVePG3frZBIhA/oVdhalr+RGGg9MdkmmDObDRj2NojbsFEIp/9nwhlzZ1d5PO5KUUXwv0D4geF98h2Op/rQLMAKRRXBuMT5zL7XkReQOkflvhwOiSXvdVeX7J60PMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742717; c=relaxed/simple;
	bh=/WHCWhFxY2+syYetDITBw3GDYSYzuP3wuepVQ/Ml6vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfMBAvNmwtPh2YA9l778c0KJq4KbwQ880VS8riRwKbO8f+RCIZmHyyfxA1ARY2dfcdxUu4s/WjHkeNKSpBYfG7GIENJa5ccEs7yrGTj8eoL+l1dP6InfjevCBgyK+qeOm/EcyGEnA6cuYUOQ7gNWZ2fa68HdJDb+WFnBvMdN8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Dt8nV+4q; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Dt8nV+4q"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30b6dad2382so688228eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742715; x=1782347515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQJzb5fV0IKHFshEeBXod6ZNECLY0MLpcvMvoWuSEGQ=;
        b=Dt8nV+4qXR6CYHUHKDYpbkujDJ6jt3jRy7ug6WbaI3iL8Pg3kFrP6dtvJ87wVFzQib
         Ir8D4Th+WNifYYKf6ELgTjEcmyNXNIrP1pn8LPgbLO0jVQmPXS5gy93h1Vb9N5eyc7ol
         t+XogO+Y+eiZEw3N7FybG6YtXiTKokYlgYTapHaYrc0fFhRdc4FiAhF9SzXwGjtrp1HK
         F3lJN2IjGRhwQlgKBEpArndVLugC1hlM8BM2SnDpofLQoCdaLn35X1CqNCEzCT78p7ZD
         kn4a5P/Oy+MzBWsYMFKPjd3NlkU4bNDzaISwyp2K5Vek8SsZO6zYcwegDwy2EQmFxkOF
         RnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742715; x=1782347515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQJzb5fV0IKHFshEeBXod6ZNECLY0MLpcvMvoWuSEGQ=;
        b=G1bw4kSVOENOLi/jaN/HTp7geq9MPreutyrG4SOl1iynNguUaPKmGe3HUD43tElqyz
         cl4AYdHrNp+nbq5WZuNuFJlsnpJ88y37lFidkMeipzQedxlVqw88V+c2TYqwGjiPTm7m
         R/Q1KxPTJpa8BL99ARzreInqKZ3mKn+2lTXXrojnQN5YdWbhAAtZQNpetvXuZzuYUs15
         Cp14h1dq+Qr+Kw+dmpK3qNi4wT486od43WTR1UKF7oIjMiPGMBytsINF8C2QQGypzfzu
         gH3GVIQk36/+dgN/UvSqDGWHgFFokzKAFEEGDwb0OAQO22WxLh7kKTwSvsNk9OetDS1F
         6S+w==
X-Gm-Message-State: AOJu0YytCof2jgTy/QDUOr9Es2UrdfdhMc6NFVPrELyEuP5C54Xi670A
	L5OUuDLxbKtj0MjHQzyabnc47wrO6ckN7+Tit8RNxHG/qoovQ/DVJUfFDpYzsJ7md2I=
X-Gm-Gg: AfdE7cnx5d6bLMt0b3K0I2m9178eyUZZGj/nsCajNLy33RfH/+gDf/sugReHD2FOdge
	Wukum1KryudpBHAvBy0ND3dqgNiHjm+9Yz2alOgxKyuvw3pSRmY2cPGLQHfIWqFcyYQhgK4iXWO
	EaxojduI9X0yVcS+avwjcye2SqaymREOLe/Vbot4B4ZegOuJ82Ny/id7O1DUjrkUz4gro7W3lPy
	RKtnciGZ/Ka6FybCEIKrRaXyxZvfwKHCcfkNFJIirScdhxrpb7W2BCILiPjb/8dxeNACjhfdE0g
	kMEP+7I85HcD7ZNl+h8Qdyh04cfk80ezYJfd7EmQxRHRGcZXP1lXaPHGdv6t0CMf7Kh4wdClRVI
	izZ3+DLdKZNPR3o8vcZZ9HAgapLWb1E2z7OqcRIqT/PXqOoLeG/FmT8TfGy00hR19aLg0feeDf4
	ewzFhpYvpK6czbB9MhorandAaDi5bABG9x7w==
X-Received: by 2002:a05:7300:8c85:b0:2f0:5605:466e with SMTP id 5a478bee46e88-30bca92de91mr3177972eec.9.1781742714752;
        Wed, 17 Jun 2026 17:31:54 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:54 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 22/38] hwmon: (pmbus/adm1266) reject implausible blackbox record_count
Date: Wed, 17 Jun 2026 17:31:12 -0700
Message-ID: <20260618003128.3112824-22-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4afca954622d672ea65ed961bed01cf91caa034e upstream.

adm1266_nvmem_read_blackbox() loops over a record_count that comes
straight from byte 3 of the BLACKBOX_INFO response.  The destination
buffer is data->dev_mem, sized for the nvmem cell's declared 2048
bytes (ADM1266_BLACKBOX_MAX_RECORDS * ADM1266_BLACKBOX_SIZE = 32 * 64).
A device that reports a record_count greater than 32 -- whether due
to firmware bugs, bus corruption, or a non-responsive slave returning
0xff -- would walk read_buff past the end of the dev_mem allocation
on the trailing iterations.

Cap record_count at ADM1266_BLACKBOX_MAX_RECORDS (introduced here)
before entering the loop and return -EIO on any larger value, so a
malformed BLACKBOX_INFO response cannot drive the loop out of bounds.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-3-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 31adbe65e3dd..ff7ebd9b2935 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -46,6 +46,7 @@
 
 #define ADM1266_BLACKBOX_OFFSET		0
 #define ADM1266_BLACKBOX_SIZE		64
+#define ADM1266_BLACKBOX_MAX_RECORDS	32
 
 #define ADM1266_PMBUS_BLOCK_MAX		255
 
@@ -360,6 +361,8 @@ static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 		return -EIO;
 
 	record_count = buf[3];
+	if (record_count > ADM1266_BLACKBOX_MAX_RECORDS)
+		return -EIO;
 
 	for (index = 0; index < record_count; index++) {
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, read_buff);
-- 
2.54.0

