Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751A22689C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742722; cv=none; b=Y0MVf8k76GaOOhZtNk0meKij+ZRV6ea0iYACYa4stipX+A4nNEIl2zNbc0S7Zgziq/SHFfp1EJlu/daIjoN1Cg/2K6R+BhQf0/s606Bp7SpkNRZZJ87QNDF61ds6EBND77qopoDHAtuXHJjwU8FHFqf5nW/ZvW+E5foX9yhKIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742722; c=relaxed/simple;
	bh=1WznqeidP6RuH9O0RxsqbGTmrWiX/M4mIt6MR1T4mmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0eVvbbOBeLThhntn8rtpXrrnvS8P1ZnVgqEIbuX+ogIQ6dIOURZ3Q1iwcK8guSqoqFdNSB64SqfUY5kniKnVtsYM/8kVltuErbl8ESXXnEwJrPCJsYjWZR41Fj15yNDHhUgiOeLF9hZ0qtP1CKyPT4lSjfYjRygqEEK/fLlI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=c9l/8kZs; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="c9l/8kZs"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bcf74e617so891224eec.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742721; x=1782347521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugrFGerBYS9NvDp7oFAzvruZYPKebO7voEhJBQz/I5k=;
        b=c9l/8kZsE7d9nSmN+cgpRTMnvMgYNjSZD0hxmjx28/O2QeAseIofl8Xkh/XR9Eo/Qg
         eruQkcyd2UdWnE+w+us2pBqr4DI6G0KqC1mtAn/84ABlvVfajvqZWiJzLVJ39UgMpEtF
         IZbz0MsXfJkCo04jfSIb8AK7qN3uFbNTuNRJbM/phor5kiRwXOcTcm/8XUgI4Oro6EFi
         uDRKWCU/PPtBywxD0i7ZlkaHa+4TAdAQ2Hz4VIl/y9cNdsj/D+/kpla2UX0A8z6YPGLx
         js5TAFdAPEcGmS4DNn5Q8MxA8013dGAkiWKcdPmHiwGwWqw/NZCZ8W882aUdGvNH2HN4
         PAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742721; x=1782347521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ugrFGerBYS9NvDp7oFAzvruZYPKebO7voEhJBQz/I5k=;
        b=MAKZNK4U+9P5T8kwtLOM7bFmE6a++y4qG5oFsOJLoW5TfMsfqd8bOXROAMPpgynxoK
         diCxRCc7wLJCxmNA3iZU4AvjP3JPeAX+dYe4j49CbP4pPn6qlpevjpbl5MYe2tSkztnk
         vRdO8q2RsDBNxseMtHtxVWTgUtQ+enVEtzljwJgkJCH0LXzhuX8/wn7XUlGIGZkWsdG4
         mANyfZWjeiUMABuRr+PaXggIJFO+lJISVeMt27SUILagdwxv67dN2lJ7Pe3scH3bYJaQ
         gnp3r58iux0hVBlUgOE9shxmUcCPv8TC159mkjS+dfxV/3QhAvnatLnjnT8kHF84xPmQ
         OvPA==
X-Gm-Message-State: AOJu0YyM7otTGOaVjQSq1uwUNhSaMyK1QSiuoECXMYaBIDJYyZRMp5JD
	874xUHMelYOLU3q835oYXnKI30lGWRoTUDPLSiq+Xtc8PIzaLbXI7MgtLq9vlWPZY5Q=
X-Gm-Gg: AfdE7clBi+qcP0YWOGYoMos1GuiT2clx/bqosjmkG4WZrWo5DdVzVJ3QkUVxgcvP0ih
	EgUw/uysdMf/3i4qQ7qp4u5UKslK1ryxsSNK+C5C2sonXwpXkMpZDHVsJuNwptx56cbQJ52M6N3
	t/ADkbeQINmgDuuTEjaa93b9As6l5X4d4n1PIRbxcIOOG8e6D2Lhm3F0gHYC17XPhKsxX1/ReDa
	YnGsM083bSmw9bFMwY+Tu+cLCRWtp0YaTNwlvL4R4kTwE73GpHHIbqh2gp/nbhfTUi9jzV3b64u
	exCEDqjEejwAMsrdD8JbJs+Uv/aieIT8eZDvJyhFFA4kaIueXsIirrsw/h/aWDvl6y8rnXIZrbG
	LkgsFit+waT7Ne2lHtQh9p3Ca+Ekk05xl0IkEMToRhYnWGZ4fA9OAkvMqIrFCvfP8DDLnGTxjvN
	hjBxU3T1+Rc7pHoH+XVtDqZWojCVWWQcnV8Q==
X-Received: by 2002:a05:7300:f18f:b0:304:cd60:b6a6 with SMTP id 5a478bee46e88-30bca21d25fmr3007290eec.30.1781742720717;
        Wed, 17 Jun 2026 17:32:00 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:32:00 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 29/38] hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors
Date: Wed, 17 Jun 2026 17:31:19 -0700
Message-ID: <20260618003128.3112824-29-abdurrahman@nexthop.ai>
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

commit a7232f68c43ca62f545049b7f5fbfc75137b843b upstream.

adm1266_gpio_get() and adm1266_gpio_get_multiple() both compose the
pin-status word as

	pins_status = read_buf[0] + (read_buf[1] << 8);

right after i2c_smbus_read_block_data(), guarding only against an
error return.  A well-behaved device returns 2 bytes for
GPIO_STATUS/PDIO_STATUS, but the helper happily reports a 0- or
1-byte response too.  If the device returns 0 bytes, both read_buf
slots are uninitialized stack memory; if it returns 1 byte, read_buf[1]
is.

The composed value then flows through set_bit() into the caller's
*bits in adm1266_gpio_get_multiple(), or into the return value of
adm1266_gpio_get(), and ends up in userspace via gpiolib (sysfs and
the char-dev ioctls).  That leaks a few bits of kernel stack per
request on any device whose firmware glitch, bus error, or hostile
slave produces a short block-read response.

Add the missing length check to both call sites and surface a short
response as -EIO.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-3-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d37c71c0ad9f..432a7088e22b 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -176,6 +176,8 @@ static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	pins_status = read_buf[0] + (read_buf[1] << 8);
 	if (offset < ADM1266_GPIO_NR)
@@ -196,6 +198,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
@@ -208,6 +212,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
-- 
2.54.0

