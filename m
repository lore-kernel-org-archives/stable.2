Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A140D56F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742715; cv=none; b=Z44/enJEXs5KY0a21593ZP5txqS1szAtYWG5MRp1e++LXG4eCZJHrbvCeGbVF2J6ayVyITSjNjaFaXJSyrHYZlQbaXR6RQdcyp6WVh6/slbuef7EK6fJ9xxeh81uMEMATtX9OTCzKetyf8BgoWbw7VioxctebZuPAkiO6zQRt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742715; c=relaxed/simple;
	bh=V8eVDzEJ/EXsdxLqQjGJeCp1bBawG+CFFqztmJuq4sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIlArHeCxGnA0m5jMtsRnRFGAE/r6aqsLD0pfKOssziOzc+rgcbF7s0/+b8MZcR5X71NTrOAlfP/njahNPy4wncEb2w5MsTOZ9x0RSTcO4O1sDHMhNc2YpB1FlN7f1GxWTvvruVx+bN6XBnP9hT4bc+nP514X9qchtZCotdw2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=bhz9sRS5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="bhz9sRS5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bcc877b4cso900698eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742713; x=1782347513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2oIID51puU7JJzGz0XGb+Q1A43Bs0Eo4iPuyQ80upQ=;
        b=bhz9sRS5tmlHUiw+U3GjExrdctvwplPJ1jTqVpAh8MT6kZ4Q3AlCF3sM22aqlPXtYq
         Ao/GgJvtrRovLwGfOjEjkPB1esOgoJwf6csZCvagdTzYsDs4OynKJZdudw67CcGlhyDk
         rD6MYcwzCTnltfeqN56T9STThhSeHgguc0NXZ3kMEx33J9tP6GS0uEE1yIt0GrEcW388
         F0EADUQDS1FaTGR4l01smnnRVTAjnySXOEr1zhRhVzgMgJXl+NzM8sOdMMoa/olcNiyE
         nhqA1WOMPD7yQceGAncszjVpXutopkmjVQ2HuBxYYHgmjKIhhC0eBfSD4lFvkQbMax6d
         cxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742713; x=1782347513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2oIID51puU7JJzGz0XGb+Q1A43Bs0Eo4iPuyQ80upQ=;
        b=iumQUMHV1a+qClRUjJXdkkoZHEUuSoFt6mAJrxXllixIDTw2WFmLzC8h0VYemCQLlu
         TdMSmJg19VvuEppZNvK1S0FJHsWgOL940Q2IxUj0i/JLz8USeTXENpnwp3MWv8uTePAk
         Vi+e8KYHT0PlZReRnP9jpFpV0hmEeOvXk78qP9C8EkMNR7bpNmxOSyqNhA1T5GUatZI3
         I7Db21dqOlJ9oOSmGte6ddnpfwV4fC16JqDXxhkJqtAy73wplxZvHoEONAaEh8nDX6c0
         KX+Hyzfal9s/JpJMpxNf27ylrhf2Z/DafHpMCK5WK8rZZ/oVX/WqW3cN0trhCTtOqFoA
         mTkA==
X-Gm-Message-State: AOJu0YwkmtQ7uq/XfQZHREqM+uUIrUnq6YHkpisPrxi3qnkLe1/pSm/1
	89wIsObTmqMt0RWPtIC/Urxyqm0Iu0Qw/kbN3ziHIc7Hpx7rVCg0jU+qlS/PZSi1p0uo14Cnooe
	CDnJk
X-Gm-Gg: AfdE7cnwOBzreiZZFfOrxy/oFVJAzfsWQSjGjFm588ZDXq/GenH3IG/eOolWXJKjIxR
	UJPPkvelkJykGQ3vbeigTfX4ToeBHfyEGUWgcDBmYC7JL3W5zsUy0JNuhR+FA2TkSKQIbg5goVA
	/5yHCRU0J4IwotfCK+tsoXgwY8m+oshjao51ZkN7Hrs28u6cDcKUS6wMcjD88Uv4nCyCub17ocd
	sWZ+ruwAWiZApJWeNNFcSaJ1JPYllrVEfDYclMH8o9GUP7i+lUtBYccNVXPjirv37Kje+HZsfDI
	mP+DbmPqXCmQpiNpYjcaSGYvI9TMZBEI8FpqkLdIvFYgINitjzq/PdVQFlbTNYEErfbOI4G+lnq
	jZHGFAdOUrJ69WFeaWReBtw7cEU3RmFHClsHXBUnEr5FdN/dsi27NasGbO8VKkA2zzEYJEwg0V9
	RCptp0SldFpnDAf+fD+EIugGE741WK/8AziQ==
X-Received: by 2002:a05:7300:d0c:b0:307:140f:d511 with SMTP id 5a478bee46e88-30bf0a289d8mr780141eec.33.1781742713112;
        Wed, 17 Jun 2026 17:31:53 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:52 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 20/38] hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
Date: Wed, 17 Jun 2026 17:31:10 -0700
Message-ID: <20260618003128.3112824-20-abdurrahman@nexthop.ai>
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

commit eee213daa1e1b402eb631bcd1b8c5aa340a6b081 upstream.

adm1266_nvmem_read_blackbox() declares a 5-byte stack buffer and
passes it to i2c_smbus_read_block_data() to retrieve the 4-byte
BLACKBOX_INFO response.  i2c_smbus_read_block_data() does not honour
caller buffer sizes -- it memcpy()s data.block[0] bytes from the
SMBus transaction (where data.block[0] is the length byte returned by
the slave device, up to I2C_SMBUS_BLOCK_MAX = 32):

	memcpy(values, &data.block[1], data.block[0]);

If the device returns any block length above 5, the call overflows
the caller's 5-byte stack buffer before the post-call

	if (ret != 4)
		return -EIO;

check has a chance to reject the response.

Widen the local buffer to I2C_SMBUS_BLOCK_MAX so the helper has room
for any well-formed SMBus block response, matching the convention used
by the other i2c_smbus_read_block_data() callers in this driver.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-2-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 2c4d94cc8729..a03066f26595 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -349,7 +349,7 @@ static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 {
 	int record_count;
 	char index;
-	u8 buf[5];
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
 
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO, buf);
-- 
2.54.0

