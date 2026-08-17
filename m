Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7D3FD12A
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967690; cv=none; b=ktXNoUnh6UxQ7Qkho/0JyvZiQSkIIWIMywiZZJY++RQoNuF0dSLzjKHiZv+tidzqvSiqxSek1awCoQsgjMqdMrPSRyqTRJBWvz2Np97SJOQMWznRzKGDkN9kziJV5a0ZVfJPuTLr7KQejWwI+sITX3yKsWMwWHbg7V24SgwB89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967690; c=relaxed/simple;
	bh=4q3srqtFp1h3A95lCQEjKRdZTxaY+cGjas1UVMNU2Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LGWNUvx9y5/uxy3JxFQU5OQKij0rnJ7Eb4DyMT4YCmoh4NyhAAGT8Vtr2hrl271tCoPGsB4ieX9cWtlUagy0vb74pqdrb9jj4a6a035RJokMVNs4IQFb7n6ozDSHnS5BMlIcRf0UIFbkkaOB9Guiip+7qsdyWvbNxetLgPrqReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WUixdJ4M; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WUixdJ4M"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0148201fbso3119733e87.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786967687; x=1787572487; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9jIpGBastiw+6fayBkJLj/KHHg/HqumJJPDo7EbWiK4=;
        b=WUixdJ4MaeOLlSVzUI5et8WlIxi4/j6B0z5BqePxkAT2ezf8W7oRbNwAozXbQPuYRb
         D+onrpnRF8fxF6JDICdiPcZ9g0WwQzsfmXuQxGqSfX0zgpJJHJmvWFvQjvYAKpmB7cja
         wgL6NvGb2abPZMjFlRawhvcbSTdA4e7xZtbXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967687; x=1787572487;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9jIpGBastiw+6fayBkJLj/KHHg/HqumJJPDo7EbWiK4=;
        b=bqZsVMuA/dh1acG6K26PX6xMXtRqhvI5hlHBZxNKOmH9x7BZnViLHZD7jj/i0W6QSD
         QeutivUMl2w2rdg/6lE+T2ZiBjvXYpg+tWDuR0RYC7QgFf2Jtko7uhZeTN2kt8N5V+vW
         Ead8uI/VOINPw3vmuY8T6013HsnRSOu/JMRZ4PJr41UE6LATRx3oWki101+ndM9CJEZp
         lF5gi3D8vvX15ZMynxBaAP00BUhl+lbVw4aW0CC1Ce5B6TkHiseFkLH3uiFhYWto9x4D
         GnitwEZNBJxtffWpHawA/9lOYdV6/idAHyvoDsM61Udri3K2APhlyu7/J2jGdw+Zqc19
         bfwQ==
X-Forwarded-Encrypted: i=1; AHgh+RredcEau3GoI4HPo4Hlv9FPMvFk1qDM6p7md4NwdEy9i2A66G0CWP6tLIaDmVAAc93zgkMNosU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVt4PvtJO6PJ+MxJjrNtRYrsHSxmtRx9VDykIWZVDTBxZYKmt6
	8UmFxd84ciHMhA0VVRJ5Hl4YR7A9i2cjRzZxndf0QzszJvmLh8Bwtelf3+DrIkcwWrn9X/XJrok
	HEeA=
X-Gm-Gg: AR+sD10Cs426FrknyEVwgmHxH1D2pwuORTSeW486psv3Tcno8bxlo4xBPBE7ZHLW6tZ
	AFOkijXIYTpE4w9MokysWnfFj8dc0cu5wS9Faw3JvQQ8/8JExSpbVbuISIavEPAILIqs6igncG5
	tuQCDv68i98o6N3ltaE3FTWr/EFzur5KNQzyYbLAL+CrLJlcT4qhrx4dpUiaUSu7hipMprB+kJp
	kaxQKg60cp88SPvGU+83gJkOpLozO4P55WsOiVDDQ1zEALZ2Hgb6qVffyXhg1r8RYhCV0FejBxc
	gPE9l5uk1GFJYZ3OIGqt6AQHnRuge+gH17A3saxiTZvvRcvt6NFkovdIjQa0H4DSQBQ/NunEnqg
	5goabzRlCUZzDNBgcB/5/ISC2YTrXFm4epDpDji95bq7Yxb0zVk1ozsVEsVyihtY5wbnBp3Ay70
	tvUB6A/JtN5c8r4CLHxkJrNjcqjJV4xbzeC4FkPw5L+iC6YEvTWuPINXqWpGPTQU+IJqiw7YXEj
	gW2V5By4b4iPot4hbBVwetAZkvxzNXEv/NLxVOd5zZGlPY2uQ==
X-Received: by 2002:a05:6512:8384:b0:5b2:a353:e4bb with SMTP id 2adb3069b0e04-5b45910e12dmr2778513e87.3.1786967686907;
        Mon, 17 Aug 2026 04:54:46 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0e3c17sm3771201fa.14.2026.08.17.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:54:46 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 17 Aug 2026 11:54:44 +0000
Subject: [PATCH] drivers: base: test: Depend on OF instead of selecting it
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-driver-pe-v1-1-7003ddb9e400@chromium.org>
X-B4-Tracking: v=1; b=H4sIAIP2gmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nz3ZSizLLUIt2CVF1Tg8RU80TLxKQkY0MloPqCotS0zAqwWdGxtbU
 AorxpiFsAAAA=
X-Change-ID: 20260817-driver-pe-50ae7a9abb31
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Xu Yang <xu.yang_2@nxp.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

Selecting OF instead of depending on it makes it impossible to
disable OF when KUNIT_ALL_TESTS is selected.

The purpose of KUNIT_ALL_TESTS is to test everything with satisfied
dependencies, not to force dependencies.

Cc: stable@vger.kernel.org
Fixes: 0e6f8ccd4618 ("device property: add test cases for fwnode_for_each_child_node()")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/base/test/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 542ce07530a1..292cf33fbaad 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -16,8 +16,7 @@ config DM_KUNIT_TEST
 
 config DRIVER_PE_KUNIT_TEST
 	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	select OF
+	depends on KUNIT && OF
 	default KUNIT_ALL_TESTS
 
 config DRIVER_SWNODE_KUNIT_TEST

---
base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
change-id: 20260817-driver-pe-50ae7a9abb31

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

