Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490740D56F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742720; cv=none; b=i7GPcUaMyX0YpSx3V6hD4c0vCBCUVFTZLQa2oIAoDxC6hauj+ZAWLRO3FDAAInrt+euJuk4qP48Cc6gKDIEK+qdYfCkaJMfjs9ymlV0050G9oHMNSNgQ19MoBljdB+OA/UpeOYpgCiOVQyXjVNib0OwjGI+SAYEMFowkJ7cXMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742720; c=relaxed/simple;
	bh=iUveUyhhVzJQgMhsNkmulJFlySxdeaCr1DBMHxIZPHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YU0+lAfP6SBOI2c/Lvn7Yty51dS2dSO4065+8YGBbvKaIeiws6P7qeb6VnEDWnNTuhrsPbpwXkIU72eqH61WanqZFAmL3LyAKj+F94ti8Pyuwqs9jFTgqV0kBpNdm8o/F86b/eCi82f9hs15yYiAjEctYcGsCjl34lOzxeplxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=bhpO1UI1; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="bhpO1UI1"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30bdb3eb5f0so574627eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742718; x=1782347518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5UdfRLnBQMgYr7pg+Soz9uz0GrsuT7mnWGl1ZIE2NQ=;
        b=bhpO1UI1S8pgU31hB5nWVUxezsIusT1fn5oIXGn5gzJiSOsp7Lc2rIlZmlTq6lTAdg
         4BZz9+05Sd3VwF9sqErmUi6O2Oq6GzMKOQdRDcB8aHKtE0cuZX5jpY5gS+Ty2FZG2VzF
         WVKfhdpJWv1OFBNNtKO2MrIG6RvEGQiWQdNzQQBAnVn8RAYWTRx3kilGYqvrk+2DNkyE
         QmtAgGQiu7mwFVatZAD8Pf3rTxtvd3I9NS37toGegpI8asTyAFrzPld4e3uy7VYf5ti4
         UXapP2WFg3Vfgf9z4kw7gsSAcnYp+4rK4citvjDvT8MjmYsSIYBgjecZzr5UuPWke9BR
         7Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742718; x=1782347518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5UdfRLnBQMgYr7pg+Soz9uz0GrsuT7mnWGl1ZIE2NQ=;
        b=kYlzB2gS+0+0rKiP7igVPtiGI8E3UwnNWez/gXX+z+ZO1Ry7XJtqYPGCruyRDMproi
         S/bp0pebLpsRrHkrlLYr7UR/u/sOnq1PhEdZMYjjQmEfRyYBgWHTJ1LbvNODD6kUTuDh
         hPL8z++LAb3cy2ERCM0+IrKPw3v9Sor3NFw1kNMZBUqYFOnjR/aNW4Pabthj36JShc8S
         ns0tj9cWcTbw234JhIxILW8HnJLvCt9V+JlCNNVqqc7sAuv2BG6jIKYoLCtELVX5XMus
         S1xlzy37WF5g1mmSyefvkVhwUJCfS2PBCr3u+9Jdtl8QX9/8uKQkMST40lZrs3p1BQnx
         fnnA==
X-Gm-Message-State: AOJu0YyiQwtkcpkTmrBSZjXxsv5Arrt7QBmzvlS5R6XXa/BoTMQzR86Y
	LaHuIiiHGGMUJZNP0O31ixLny3zCGIfbu6G5DUzqVAlH3yx9llDkRW1kqxo5CyR5R+s=
X-Gm-Gg: AfdE7clTyfHu2B3UOLE3o97NuTLhB0MwGrHcQURwMsGyDW1ijI2YPGe0c9TGg5G6Sst
	6tJR9t9T8xz5Kyo3K9DohrtHIwgHyz3a+BeCi8LDzbY6IGCEjyavASnk+rLiyhgcx1fcXkiW6IG
	pVMcsalI3VrOlrYpln75T0OudJEqdSZs+WPtd67s5WzIKHskE7xVQW+JWUOaa7EfhXlQJl9UPyk
	zf2sy3M9xoDndV0P3wA9c6ZpxwcT+wC1jBTdCnee0dYfCFm6+N2aVbFptcHJWQsk9F5TSm0FMNw
	XJUTrOh4FUIKD7nUSg2RVcLtMpfG6bS7j7r2GMA+4wujqpSDdMIsq1TzokwtYMiGW/JPxyxtb5a
	dsfAo5Bw6iwlUM6UzXB0r4udx6iL0lQQzZPidlXjUT9G9cXtGWKFGE9OKbE3xt7y8m/nlgMPxtD
	r7AlBxdyxUa+4bFzcg4ToHHx9wz/aXxMfkrg==
X-Received: by 2002:a05:7300:f3ca:b0:304:56fc:775 with SMTP id 5a478bee46e88-30bede7e845mr767846eec.21.1781742718370;
        Wed, 17 Jun 2026 17:31:58 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:57 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 26/38] hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple
Date: Wed, 17 Jun 2026 17:31:16 -0700
Message-ID: <20260618003128.3112824-26-abdurrahman@nexthop.ai>
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

commit 3327a12aee9e10ffa903e28b8445dfd1af5307c0 upstream.

adm1266_gpio_get_multiple() zeroes *bits before the GPIO_STATUS loop
and then a second time before the PDIO_STATUS loop:

	*bits = 0;
	for_each_set_bit(gpio_nr, mask, ADM1266_GPIO_NR) {
		...
		set_bit(gpio_nr, bits);
	}

	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, ...);
	...
	*bits = 0;
	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_NR) {
		...
		set_bit(gpio_nr, bits);
	}

The second *bits = 0 throws away every GPIO bit the first loop just
populated, so callers asking for any combination of GPIO and PDIO
pins always see the GPIO portion of the returned bits as zero.

Drop the redundant second assignment so both halves of the result
survive.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-2-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index eba838bd401c..5395cfbb3821 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -211,7 +211,6 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
-	*bits = 0;
 	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_NR) {
 		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &status))
 			set_bit(gpio_nr, bits);
-- 
2.54.0

