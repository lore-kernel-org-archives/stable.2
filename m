Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD23F12E7
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525739; cv=none; b=CfT/1q6GZZ+0tlJ+4Gq7whkPyaX76MXXCUqyN2ONZJNSC/y2LiCVCHBXjJJnqt9ZsyAwpRiQaIyb7L9L9GIwbA3AYV2eV2mhzxyegTak3V9ibU6y9FbrtXSmE7+k3+0efc2TxBYmDerPCUI1BmojK/ZMwcFFqlCVrwON6PwSxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525739; c=relaxed/simple;
	bh=ULNMmbxVh4tHyr9ahlwXKgzZ7AKozKUrjhwvPkGtpoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQU7n7TIG824RtIbqijrmwSXaUNWyYduJataP7NLzCovIr+J3L549HZ1gzPkJ9nvfiOcP1d5TnCpHN/AIJMfNxmWMLHn1S5EctIFvZMNp10JvJdqdEAfHhkyJdOePTji8d5D7mtR8Dkx1UDFuHu1MYEfmw0U/KrtzbwAvT8xHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWmalRrI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWmalRrI"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so1471358a12.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783525737; x=1784130537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/fgggRHrJbJt1RDIuoWb+BH35AXwLqWARanhG2X30s=;
        b=TWmalRrIelf9bZmAGpz6gJ4mDr+L5xgwUiANUR23iZuApfN/lk+PoP7KE46LFz2lnN
         WdXOQ2cnLCZTKF73YdFIDsWc9WfM01ZuJhwCXSxHfHSrzEDXIYWNx56FZ0B2C32tdZTB
         XIfeWFD61bYfWGUjgjWiWy/qrK7s4K7Bu8kKWs7aB4gEVLJWueVzuZwYb8US0mFkvktA
         PszCloy1oo0NE6mXOxuKqHyPF7vZ8dcWX8oeduPByQHwUE0GFnjSSLp24RJIPfYRA7Gb
         eKjJ8f3eR0moxykh1L1tFW/8ttMJXkphfpkiHPnygC/lTPgDHqXSDUtrz0VcYLed+gnA
         vBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525737; x=1784130537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B/fgggRHrJbJt1RDIuoWb+BH35AXwLqWARanhG2X30s=;
        b=UEivOjl6Bftpk/Yna4JHF1sjGh1sdsLOg/Gw3PQWv0sEE0osls9Axjsir1Q6VazqAu
         bciIHLMwPfys5yMJ7AS4yKAZococtU2KwjNWQin4nbNjS0Hayx6MkUWnODjSmD1mLQbn
         ziBqt9skjTAfi+BuJ9XkiWtPdORPgs6eIhRkMkOyPnPhgfwcV3e0EbPmEgOP08tIfZf4
         YXVAsjBpAmd9uDjVqxzhJ2WcI7Y0dJfLzMUNPKGw0yW3uC3QSXYFa0vRACM3Xv7VqWYz
         DFikVPuxUzQaihi4stFszu1W9/QkiQovtxiyB8kryv155mMW9G41fjik0h/MURVGnNBy
         re7g==
X-Gm-Message-State: AOJu0YwrPEtdr4obi0jskX3Lr6FN1okI0OWRzdNOE5PE8JUSdzy9MC3V
	s6qYGJy2LIu2bcIuAPkBz1rv0Am2jk8fOXBEp4/7A17x9A3KaQYiZB6t
X-Gm-Gg: AfdE7ckkonbwVlYynvd7HEbzV35DMWslz5KNwxLRddzl1Pf58cMBAuUaEg4uVYL7Gd2
	SOPZ8tmhNicMb1k7HsjUatzgFowsEC1y/GvMX05bq5849rNRo5lGCxkYVruMZo4mN6yIKgmYC30
	tvNppObO6oOJQqkc/OIjjk8fXsHEAJjAvzmYYc/5GvA3JqKq2ivdYvvcjpMIv6U9wCEClmU/nV7
	UufOxX854y45PAZT6pSKmUnrIVqiSe7pmCmfNS67srsIiPp0B+Bmapky8U+fvVrZengOs5SgDFL
	MZA5nFGCmcvdfQBzR/BrCLvfAnjCehlQS6YHgZSa3NAJcbp/eFDL1M6r50ZIqiO+XEo1zFiqIh+
	6tHjShT06VF/3c1pucLvTGIaTSWroEfTx4UvIuTsCHXP3thfEP+hnsBJ0rs70V/wHMsPCzWKtEH
	8xb/gz04TG3SQ1vqydI3AuZko2pNvxZJNRLc5+EZKgEq2yYG9r0JM4dus5Nhif0GwBkAGRmQyld
	w==
X-Received: by 2002:a05:6402:e85:b0:69a:a4bb:bfcf with SMTP id 4fb4d7f45d1cf-69ab4471007mr1196178a12.14.1783525736512;
        Wed, 08 Jul 2026 08:48:56 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69ac41d7ceesm945125a12.23.2026.07.08.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:48:56 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	linux@weissschuh.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4 2/4] platform/x86: hp-bioscfg: bound ordered-list parsing by the package count
Date: Wed,  8 Jul 2026 20:48:43 +0500
Message-ID: <20260708154846.12356-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708154846.12356-1-meatuni001@gmail.com>
References: <20260708154846.12356-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_populate_ordered_list_elements_from_package() differs from the other
per-type parsers: its main loop is bounded only by the fixed per-type
count and never checks elem against the number of elements actually
present in the package,

  for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++)

whereas the string, integer, enumeration and password parsers bound
their main loop with "elem < count" as well.

This is safe today because hp_init_bios_package_attribute() rejects any
package with fewer than ORD_ELEM_CNT elements before the parser runs.
An upcoming change, however, relaxes that check to accept shorter
packages.

Bound the loop by the validated element count as well, so it stops at
whichever comes first, the per-type count or the real package size,

  for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT && elem < order_obj_count;
       elem++, eloc++)

order_obj_count is the validated element count, now correctly forwarded
from the caller. No functional change for packages that enumerate
correctly today.

Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 83ddf99f93954..a50d074125268 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -145,7 +145,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 	if (!order_obj)
 		return -EINVAL;
 
-	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++) {
+	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT && elem < order_obj_count; elem++, eloc++) {
 
 		switch (order_obj[elem].type) {
 		case ACPI_TYPE_STRING:
-- 
2.55.0

