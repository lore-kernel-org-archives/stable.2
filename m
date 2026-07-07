Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CA42087F
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455717; cv=none; b=HTngQE6AQ2B/wZSIl3kTrtkR2/kjc665jc9tJiMELS1ZO6h1tpjKP9hzI17+VA/V1KaaZB5bxsFuyrmpcJZnwEKDGbTcdZjcoczmqEwKnBBwKH+uk9oMDVg4sQk9kfG8iJney0i9df1x/lqQQAX88quIo+j5qOuOseTQVzrZagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455717; c=relaxed/simple;
	bh=qcl9sa0L912dX135ZgE1P2im4R+ONGCJ2l9u2P55DEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUpUMdd2zVH7GwnNjx3GxL9aVZAIIDwiFpYCa+xHMmJIxd2x8luCb4lthmk3dm+YpedqeHM6z7mG0z5kylk3x7rXjMLXw8qjaVYjYuPK/3wZo20Uqf5WWB94GrgLAMThnJc9KVJuWUYknqie0VkxP8uKkxPRes8ibmXTK5JcKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai8nUsOf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai8nUsOf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so7093908a12.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783455714; x=1784060514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXj0HwSgdqnA4nhT2m9sIPxyqB0pdz1tagDSDjLU+cU=;
        b=Ai8nUsOfXeMJNtleNF201nlLfAG+j5SXou8uAm55KcmbZAHIsEVgkan5uyJr6xgNGI
         s+i9hm4RFy7jEPeTOkJXeeALP75yXIU7jsbmaO34ayQeorrcm8dwc+/CT4ROzZNs/zpp
         bAhaf4f0zX54OaAMfMOv7+MPhLXPwL3pZ6XQzb+vmqKcP6dImllgfmGBdT6PLodv81Pb
         +XwjA8Vlp4zJu6XRFIZykuNG1MsbJSHA2Qgco5UTeGLT0unwycPBTX84aa/GCUTqrtPb
         16R+i+GwcZOUXjQk9YN21Oc76AcAv1NsrzRYLQMVVlkj0s694nlLF27pfqQ0De4dYvod
         dBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455714; x=1784060514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXj0HwSgdqnA4nhT2m9sIPxyqB0pdz1tagDSDjLU+cU=;
        b=dyW8k0ojP/VPHx7lgM3LAn8CluDwk8ifmbC8N4DeW5TJtfg2rgW3eCI3LLCABtMD+R
         sK3kcDx7c7W5/ChrAHIh7GJKy4ps+M2tKAv2VlArj3rrrM/pe48JYPSHLUoagQaI3iGQ
         NTUbibfddFrceETEywPlyXmd77qXMqVv1bwAPChAahBX4k1vKqQm1tyQaPfuPq+F8S5t
         kmIsNPOwd4WbKh60QexpxYn1DcJITC6mId20HrGfbFeEcJHp/XtuiTxVAfKwFTFM1bua
         9+EeUwckeifLnsFnhmFhtnvlo7k02JjwQ9tOqVMH10NfODc3Um2micaRZiPXt1Kn3LRZ
         K6hQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcLR2tsVDT36CXsirhWQwlcsXvSOK7xoWB6uSrTxtJ2EHEszOqNVo0DYgqvToSFP2AzrVZZA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyanOzFeCTeszIfqzGf2b5y6Xes/bzXdletPeq4RH3NCtxD0/
	kL8uWpxnud0KdWPMdWR1sdqp2D6FHC0pL5MaJREXz1QXy66sWxsmuZFc
X-Gm-Gg: AfdE7ckBF3hickGWSlveieWkTAlrexm+UOD0g86hhVVDwuE1wHUFdbG0Fxfe+d0+zkk
	k1FwfPrRGn5d0+e6isxPDWawDiplc+JhSVPFU8laeRY0JHj3BPSSZ/wQzGS+DgFGOIHIWg5RcSR
	/f7udk0uMxOBWqWSczx5dh2KvmfWDReT8oqO3qbPatFBbm77a61mo+YJ0rqN6FpvFhsUZMxWldL
	JkqQxu1Ku232imV3ixkjX68FaAzVm9JacvOzYheSy9KoMF4YkpACaEv/GznOKn6pLmT5eIu/XD2
	+T0TnHl1zEZkSLTDGBY8+BBpyJOmvEPbQ7fh3gQN8FDorpYtTlFosdllivsbsMDv7RUsllX0Lnx
	mM5RqvZoMGvjloCEyGgTI1eikab6gBwu6xEXFDy3zH7H362ihjkXy99YFCEauOPdVY+yKPZWvcm
	t3GMyP2UaUJPzjWG8KKnMnUi7ivMNiqoofrKVptIctR6miaTBW1miJrJERS/Q2eYI=
X-Received: by 2002:a05:6402:3586:b0:69a:a9d3:9fc with SMTP id 4fb4d7f45d1cf-69aa9d30ae9mr278714a12.1.1783455713801;
        Tue, 07 Jul 2026 13:21:53 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm637930a12.0.2026.07.07.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:21:53 -0700 (PDT)
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
Subject: [PATCH v3 2/4] platform/x86: hp-bioscfg: bound ordered-list parsing by the package count
Date: Wed,  8 Jul 2026 01:21:09 +0500
Message-ID: <20260707202111.35414-3-meatuni001@gmail.com>
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

hp_populate_ordered_list_elements_from_package() differs from the other
per-type parsers: its main loop is bounded only by the fixed per-type
count and never checks elem against the number of elements actually
present in the package,

  for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++)

whereas the string, integer, enumeration and password parsers bound
their main loop with "elem < count" as well.

This is safe today because hp_init_bios_package_attribute() rejects any
package with fewer than ORD_ELEM_CNT elements before the parser runs. A
later patch relaxes that check to accept shorter packages; once this
loop can be handed fewer than ORD_ELEM_CNT elements it indexes
order_obj[elem] past the end of the array - an out-of-bounds heap read.

Bound the loop by the validated element count as well, so it stops at
whichever comes first, the per-type count or the real package size,

  for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT && elem < order_obj_count;
       elem++, eloc++)

order_obj_count is the validated count plumbed in by the previous
patch. No functional change for packages that enumerate correctly
today.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
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

