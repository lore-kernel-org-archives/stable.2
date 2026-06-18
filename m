Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18E1DA23
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742719; cv=none; b=Q7Rt3t+HLx5StybM7KDWuuzK+IrNXcghFV30lfF047uMjli6ti9VvKFdnGCJ53ipvQpa2yvoUNcmBEPOKlu5OvBRo6PgGdq4FivWVkRBOoYNkkJ+kAQ7RA/Bjt1+WoqRSD1syBHpquoV5wClLJEUJ96fRtDeCYlq/Nwl6/DFH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742719; c=relaxed/simple;
	bh=d2kag8hcPalkXy9ZycnIx/kFJHNAtBtF5/OQtMcmMvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4hKgjibwj8gS5mLUqCwS6PwErm8HX0yp9vYc05V/GysX2uYAV2Ios/r8RTNpZNsbf3gp6O79fXzqYLdu7S2Gm9bqTDee2VQZeMthKEJn1hJfnsRHT4eKlCfzlcq2iSYZkmWtOFbK4VOZd2pQrDKYV0an+2mGYmm5Y0zmZ/lqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=k3/7wIZF; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="k3/7wIZF"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bd7f4fdffso384114eec.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742717; x=1782347517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRkKEQoiDh6arZc75pg6Jc04jTibA2bf+uDzEj7Lt7A=;
        b=k3/7wIZFmP10i2gk3bg4f97wgrrDMuUxwQmjcPA2mNLt3TZlQYw7IyM2l8j6HS2rut
         YsQo5bD/6rFkMuPtYgU+x88iI8V23t4sPRzuy+Nny0w8lNKwdoKYuF5ttXHmT2Qvpf1/
         VpKGvv1gDAaeDh0nTbm3WPIIOt7/EnlbWD3px53ZNnTgD8dhCdnoEcbe4Sg25HaI7zDu
         95dgLdjsPtZsOmezfJqw1pId5XBIfMefT2Pav0c7PmHwhKYDaCniy6hf7HG8q4p36F08
         4dqkx1QXBkM5zr3Dhc+/SAqX2b9/d1md8yM6DGl2V9gntWK9fVA0PP2BcUJWgHHEoPNJ
         m+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742717; x=1782347517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRkKEQoiDh6arZc75pg6Jc04jTibA2bf+uDzEj7Lt7A=;
        b=CYdKGMsnmShnncJ9FxFuGIhnwZLj/dWniKdndaG9nPXvyNeyLi3cOZgRBa/pFxPHcs
         5cZcRQIeuVdACqnM8aBZfTl5mogfDzpiC76jIhYFHpxQBQCmU1lUeHpr9DCbgvltKUoC
         WxosjHPXXPi4VbX9rkbqBnFkxdqZUR2ooQtWuej0OnGcjJsKbw/b7xX2tfVtXyy6EASh
         qCrnDRz4R/sbyTaVATfBwssdGEGHL85GZW3q6e2Ee5rwAEPniTgviVXC33uglr87ysI8
         58mB5orLpO5KI0iUsVKDDpBoiIW1BcCIvhuKbwAStNChzSCpf7pDkXaOlSXxulRAr91G
         u9ww==
X-Gm-Message-State: AOJu0YxonZX0CvQx43UgkCY6tUgH34V9qB2SOK199kGmeS3glM402mV9
	YLrkUxC5IKGbLO0R/EHjM9RFA5bd0+BLqUDL/Vipc8hSnQHeAYpki9FVf1UDS+5KIwc=
X-Gm-Gg: AfdE7cm4gUVOdOEFCBVJJUREeftOUyhuaBOQ87+D4wrP8hXGdBVomayjX8jMBGSe2Yq
	vBmRfKNpYLBNy1kjpI68xKWT4JQZzU+Ksg3vZ30bzqjbcXP4HWePeN+zl7+ul5otYAVs2WultR8
	4vtAG2wXiJ+tKVNWCuF+b0eJsC0LtryBfQ28lZuh3OKe/g70XtifJ96ahA+wydSWi0mZW2KpmKt
	TgHMxwJtZzpb9H34Ei+PvwKmQZcWdVJ5/fbMJKsfgYBYBAFkQZawNzrwfvYjW1ofTYBlNiFiMvD
	z33cukwz2ehJTETHspUfdjtYr+VldiXanF3/4wasywRIBs2HTh4xxFdKGakLurGAe22mvLGWHxi
	aRDanDsZjHfuUwjiM5pYjQR3TaNmfqIK3TNOWp9iOdemmCfsYDUdAc173ga6Ec43KzXSmVjEFip
	Svr3JZZagV01/Pnbz9qiMH4LY181a4Qa6aENdMIfmq2jRS
X-Received: by 2002:a05:693c:3105:b0:307:287f:9bbc with SMTP id 5a478bee46e88-30bca0a3900mr3218176eec.25.1781742717422;
        Wed, 17 Jun 2026 17:31:57 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:56 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 25/38] hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
Date: Wed, 17 Jun 2026 17:31:15 -0700
Message-ID: <20260618003128.3112824-25-abdurrahman@nexthop.ai>
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

commit d7834d92251baade796812876e95555e2066fa9f upstream.

adm1266_gpio_get_multiple() iterates the PDIO portion of the
caller-supplied mask using

	for_each_set_bit_from(gpio_nr, mask,
			      ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
		...
	}

where ADM1266_PDIO_STATUS is the PMBus command code (0xE9, i.e. 233),
not the number of PDIO pins.  The intended upper bound is
ADM1266_GPIO_NR + ADM1266_PDIO_NR = 25.

gpiolib hands in a mask sized for gc.ngpio (= 25 bits on this chip),
so the iteration walks find_next_bit() up to 242, reading up to 217
extra bits (a handful of unsigned-long words: four on 64-bit, seven
on 32-bit) of whatever lives past the end of the mask in the
caller's stack.  Any incidental set bit in that range then drives a
set_bit(gpio_nr, bits) call that writes past the end of the
caller-supplied bits array too -- both out-of-bounds.

Substitute ADM1266_PDIO_NR for the constant so the scan stops at the
last real PDIO bit.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-1-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 0fe711722415..eba838bd401c 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -212,7 +212,7 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	status = read_buf[0] + (read_buf[1] << 8);
 
 	*bits = 0;
-	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
+	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_NR) {
 		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &status))
 			set_bit(gpio_nr, bits);
 	}
-- 
2.54.0

