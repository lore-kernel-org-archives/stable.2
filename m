Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D236DA1D
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616356; cv=none; b=QAqIN5KmoA5SdpF6a1XeVHLXFMedKb4GLL0rGjpcewZpodW5I6XD4QbUqg2inWQkt5Y/oyULrwh1NRvemiEYFWe4fWRazSFXhO6r4Bi/6RldOosgD4GsT3Aspf2W6sgKDfzn7RKFqK/aTAmWuU3NKiCQ6WBBK2DbjtWgTxAmM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616356; c=relaxed/simple;
	bh=uJoYCDCn9PmHieohB5D8uKh80F/3g84Pf60VaEuspDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+SnGA5FngFwGCzMFphYPkeNZQaKJ8uPullJd0kn1vvLlUuVVo6MGlOVlvKK+CbUL/qyP3h1JrB9vlZXs0zPiNi7XAjSMuSVmIv640P+9swgbGq3lk3xdc0jdacphHD5Har7eDfVGtt5ewT3RJ0X8a8z0Xv7duszc8AtjIhpros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1vsZ4o9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1vsZ4o9"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15cd3fd760so10341566b.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783616353; x=1784221153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BdQgCcOZ8AsbD39pJ/8+6FU/oteVawK7PRRyjumlzGo=;
        b=M1vsZ4o9xHisNGI4Ucm+gDuW05HosHIl9eHvr5jq5Q6EqyzXN2JI5JaWGbHMRe+f5+
         Tl7sdUV38BoFQM5HUZMTDmrGr1XQS7vsvsjqHobfcd9my6nPPYTubHMYmAaM9wmvuB0p
         dnJTBa+x4gpEszalMZfUs+rWw0m0oIT3iRco3mCvDuKXrU5vWxq36Vb0pjiHFyaR57UJ
         VSjVcMnRUtwhg5ncAkMp5G2pVzXLJpt4zvMxpo1ZxWsn0UtpLCnmSLvBZOri6AyufO48
         9CgnZGGVYbrNDK/8xOFB1+0plJtYo/99khKzBo6JFXVKxeb4+R1+wHabwgjPhdbTAyna
         xl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616353; x=1784221153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BdQgCcOZ8AsbD39pJ/8+6FU/oteVawK7PRRyjumlzGo=;
        b=Y0e1Nb2UkbYxUWEQCUF5dl3cVng2yWca3rCs35Rag47L1XJkL8sCnjOPcl9xaHAVss
         76WkTON32W1AZNwsRFfSOAiVJq1nkSOm8IF8E7PcX0jprEcRbptpDE33/4478wpJKyLq
         rUI7pzlYSg/WzjH+hxj/KWVu8pNHMH8/x+ss1uvDH/kp+rcN/1AqSpxsxtpfUKsFvuy1
         681T9cFsXQt8UJ8EZE7KWmLhd5uUiu2U5NvUBNfrHweJUeOpzgWv6WaMgmfmuKhS4s1K
         0VEPxk9ZMBlqrA2XthgVKdvrf8T+t00Ad83WhDIpj7kkzdJe9edbMf7mJhvCL6uF4Lhk
         fhLg==
X-Gm-Message-State: AOJu0YxQbML6SLZrMRF8BoxrBaaIIxwN5hmmXif3ufrk2bO97KAe5Rs4
	ccg7tS+FI9lgSAwhDHdBahjCQbL4SuO7pwpCPcwGHwSVlVKOdaM7GwfD
X-Gm-Gg: AfdE7cl9+BjPudeJU5s8bUajgK5eHqQ/i7w04UU8WoglCvZuOmPeiFkDoLbL4mNZV9e
	khD+9uLH2SiYyApXo2TPI3CqRJ4cTAV1pIUMqbvIN3rMqeJ95MhI0WWas/xJKRgV7ZrTz1gkQVe
	4ApwMh0RvkvoTsmn3TiLfrl8VChvfe8FTukWS3P7QDFKeB5odtynt4FhLMC0PLJVBZ6GP5pWMI3
	+QZT01sl05AG+E29vbllpY1O7+mwIvjaFMZ/btudMcli4C3U5GMHyr/Z+YUkJA32WiuvmNPx+lO
	jKj+wdR9qHzsmfsHkTNJVG4yF4rFB60mB2vL1EVPqsPn442ED8WAVhaNKVsp50SqTAWk0dqmzQ3
	K5diC15rjVQZeUJdNWCfbcCvC8RCF7i6zUgNdg/x9ONstNvOeD+SXgZe17fnQegEvPT+9sh7gXI
	Y3+VUCXoulhJbubrCrrPq5sYZWynSRkKmzk4q+0blM+IKUnYy0p0tRP2S4VY6pNrQ=
X-Received: by 2002:a17:907:3d12:b0:c12:979c:5a5e with SMTP id a640c23a62f3a-c15cda428admr403802066b.0.1783616352383;
        Thu, 09 Jul 2026 09:59:12 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c79f2a3fsm329902666b.49.2026.07.09.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:59:12 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v5 2/4] platform/x86: hp-bioscfg: bound ordered-list parsing by the package count
Date: Thu,  9 Jul 2026 21:58:57 +0500
Message-ID: <20260709165900.30615-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709165900.30615-1-meatuni001@gmail.com>
References: <20260709165900.30615-1-meatuni001@gmail.com>
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
index cc5bebe73a93b..863e486474ad0 100644
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

