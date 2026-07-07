Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08623A2540
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455724; cv=none; b=YhxwPXe5YMeQiPPGWL1qgOkclEcZpaZWCk3mH0BZ6x9C8VS3+WOEIBbQoU7qk2XICLQEXn845A5secw+9vEJXliPIZIPozTgNLL1HOmb1YwwWfLPWuvoAL1JDvF0YkQ4hdNvgoX2ZX5hlTkVhDYT+bNqwa/AKqquE02TQrXOTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455724; c=relaxed/simple;
	bh=+fb2hm/AV+gpBOcwwKZ0VASVGKm3XP6ZLpjp9sYFqfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy1/9UhbTXU/zAn70Pol8ZzL5jEEtQmxfONQcrsAbr+AzoU1zhidFF4Sd0XtX7lRB10Eov5HDrs1q/m/eFYlH/xCAT4ywjO0SscEgXOHj5KfO4DSgAyDT5hUWW9uBY/RocFRL36dnA6VAUFweV/8JuPCWaGOkGuP9Xp5eBmYFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpioySt8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpioySt8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so6909343a12.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783455721; x=1784060521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWjcO3quzBLPCQpyEkYQryJlDPpxypgV7KUttYaLljc=;
        b=rpioySt8g43amb3wPDAvzV2tjYh9b4Qgl4fCThMAkiYRotEaainWy/SOOSGD04GDPg
         T8IGYvvRYxdsAwqC40w/Pt+bNDcNjEe+JxWaMLm6OF26DuJgyj7IVeSKATgM7mp4cT9E
         wJxkv8V2howT9LDwC6kKkV2pT6PJuakqVgLyuPcKZ8ijvx3anmHzakbjgpJRNbKJTMgG
         yh3BOrfbTjzG0L3Or/DVbPXjY7OX3wKTAxWJeeNH1OxFSytdWVmJFYQsUwgFp1xZ4YQa
         4NrLifDud5PUBiBrmucFvAXHislL24VcDJuPJ7IpFdhbAEbMUAP+Yb7dXeRx7aolsQcq
         Ttxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455721; x=1784060521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWjcO3quzBLPCQpyEkYQryJlDPpxypgV7KUttYaLljc=;
        b=njI4c2suYIpz+JLwa2RglTa8PrTlurN9/XOxdPzmCkosuXfRd9OON4tAQvdJqU88mN
         2zd4EPCTsAZWl3gfy38aKC8WAxV8bKDOv44x5v4IABG4+0Z8g9dT4tbsZxBU/2RJ4KQh
         hfTkf1nrKytAvVRBipAsDR3WRv+4HWXMCyuq0WYP3Wj1Mtv1F/M+b4vEPExQApmGDGpX
         QGdgvuMPyOicTRl7S8g//aXxBz/l51j4dWRsw3IaOxc08/WDEkCc5WFr5vAhqbwmxUeJ
         wG/OHH5K/6LS3a+PkoMaGuZT1mMda9w1fQ0tImQbw6cmipGHjifbHGsXiq9FdbhLSmJx
         gQGg==
X-Forwarded-Encrypted: i=1; AHgh+RqNH8hUILW6rkB14hYSn2n/gIvuyKBZTqFC+GedcYENyP/bJ8SnVsJmYyUJLvb4EYUcDh5RMys=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfq4DhfG/4y25qtmLplED6D3dqI8VUml8vThawvfhodjXqeRYO
	LDUZz/Xp3NNwe6Qcb2XMZfymHsoxUUY7k8LGOI16EtqiiGpaURfKzRYo
X-Gm-Gg: AfdE7ckpYAMTJO8Yu+Y7WOTQgCEfoETmzhd/0msKUpJt9uc7lOhQMMBumlD9tHYHLcN
	MIRMOJBNbMARmR9BQbupdb7tUdJHTSkRYP6wj3Ghav2I9Tn/2tMZsMnskKNOTzE1Rgy8IrbT3pe
	Yy+m5MDq1ZCDPDKjQk6HnE+4IMcrPUi84oghboveJqcnI8BNw/OEJ11GoCape1QFmCO3jxAC7ft
	22l6xbv8KIHM2l6Hf251jDI3EEaX8lCzpHaxOiOoXfNpmFtvOm5NTWFkjDNSokwtyyWKaNjBIB+
	cxn5xTY559hLiKbofEaImPVXlQK+2OLPpCancTsojdx/QG3UOT2tcfQd/XYsmP13buSkIiliIUL
	9wYm4mtGRz4BZP8ZXjPoNtQxWkdk8gjY4g76OKAN1/Jy5t57zawkza90gQ8qViOof9yg5dSk2nQ
	A/mxJSHzb/2xfMfkJhiGArcpp8IzQCqQxBU3ks2dHvcpOY6QRw7K6oiMOSRSWXZwQ=
X-Received: by 2002:a05:6402:5107:b0:698:b23a:e54a with SMTP id 4fb4d7f45d1cf-69a85c281cdmr3729267a12.31.1783455720810;
        Tue, 07 Jul 2026 13:22:00 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm637930a12.0.2026.07.07.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:22:00 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	jorge.lopez2@hp.com,
	Thomas.Weissschuh@linutronix.de,
	superm1@kernel.org,
	W_Armin@gmx.de,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 4/4] platform/x86: hp-bioscfg: warn on element type mismatch instead of failing
Date: Wed,  8 Jul 2026 01:21:11 +0500
Message-ID: <20260707202111.35414-5-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707202111.35414-1-meatuni001@gmail.com>
References: <20260707202111.35414-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_populate_enumeration_elements_from_package() returns -EIO and aborts
enumeration of the entire attribute when any single element has an
unexpected ACPI type. This is observed on HP EliteBook 840 G2 when the
BIOS returns malformed ACPI data following a failed WMI query:

  ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Index (0x000000032)
    is beyond end of object (length 0x32)
  ACPI Error: Aborting method \_SB.WMID.WQBE due to previous error
  Error expected type 2 for elem 13, but got type 1 instead
  hp_bioscfg: Returned error 0x3,
    "Invalid command value/Feature not supported"

Aborting immediately discards the attribute entirely.

Warn about the unexpected element type, free the temporary string, skip
the offending element, and continue parsing the remaining package
instead of failing the whole attribute.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 3aa2c440e0528..b834303e5bc79 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -163,10 +163,11 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 
 		/* Check that both expected and read object type match */
 		if (expected_enum_types[eloc] != enum_obj[elem].type) {
-			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
-			       expected_enum_types[eloc], elem, enum_obj[elem].type);
+			pr_warn("Unexpected element type at elem %d: expected %d, got %d, skipping\n",
+				elem, expected_enum_types[eloc], enum_obj[elem].type);
 			kfree(str_value);
-			return -EIO;
+			str_value = NULL;
+			continue;
 		}
 
 		/* Assign appropriate element value to corresponding field */
-- 
2.55.0

