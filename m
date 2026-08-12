Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353C43933D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533534; cv=none; b=UE9o3KXUN7ar40/pPjYrlpUj9ouWFf7ZL4/+fNMq7F0jX299Bn5ZYAp63KQXc45FNS2gl5uuyg36hPHv5+nT/sOVSUANLEF9RuMNgO3ppPLYEDrADUsxsDnl+ya5POxMi3PHdOoLrsNYovSaiej8ggJvwFkFMaChUIO44k7ZBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533534; c=relaxed/simple;
	bh=rhV+qOT/cedymAeQ3DQaL+LQcUHG8piPrtIkVunzAvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftQdmucm9nvyw+G7sXY2u/TuObnpPc1g1a/ndlbpTwtXff7WlUDxUk23N2crJWYi3ZGRy5RBLLi3Lm0oWRZgkdg2rFFmmNaNGrcrcCjtMu1bu9n5XO4xG0YDqimWUnM/a75fc6tg8Wqt+XqoUM1Zx+sSzhirt6BGkgAySuwbkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El+bs9Sm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El+bs9Sm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954dff6536so6373165e9.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533530; x=1787138330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNoDrCXm49lLgm2lL6InxDz3MAxyPtaZVFbbdYtrWx4=;
        b=El+bs9SmlR5VflEY64GBmIIQXIbymJJyrUbkoKgDXdttek2k9NrNJ5kx/71CgaEPR6
         zssv7Isd40wJNSNdFUzyZ8paFQuvU92g0xbLSrzWkLbQXXAgDwLMdUrouGCms1ZYbbUC
         9vyId+qBqtrq4oyWvlZxNL1dXWW+mZSOOJZ7A7GozfrPKNwW34OD1t517kqocku3bz3Y
         6gvIrWQscbjKJGXINXkx0GwprlqNZOpl5+s7hTX9XK/tuvMWx438UzC1H0DJG8R+TSOO
         FtPCAkP99Y1MULZ0AW/kezwl+VPKSQrAxfgG+sVlIUsyjZe9pv9XAQn/ms6f1xy8nz9C
         t0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533530; x=1787138330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hNoDrCXm49lLgm2lL6InxDz3MAxyPtaZVFbbdYtrWx4=;
        b=qnMqsnH6frBdf/AxOAKXuaU90xYyxBpBicByhqU47R0m8DnLz1PaQTZxef2n6OW9TN
         MDl+j+vG/QjhFFppp6PRfO/1uVUawHtexyiG046X3jkvKGGFsuFLLhCxarVCAZ99wzzt
         xJ+SRvaBxQEjv+ZyKLD+z8idgyTbsX3yagf8ySm7zHQiASDu+f0sZkox9eOEUxH+PlR9
         CLvxdrWygSREf93ouo1Pik1JnUuks4aB0Ak6eSRpCOD7noZwyFwr2wA0rb+RlYtSjtd1
         1/i77DSivdAbh+jvVOz7tOfDOeIXOVXyHD2eE54icTZbJLqGh+diJr5YUJi8njCQ3sDI
         9nmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdHjBoYi7AbbT5gSwh2PJAONxvrnV8n88dPH6LF+MQOWyo6WXk319kmZmF0rZdIoOGRrRP/40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJuaM5HpYx3CAzSgb/UFv9koDWWok7Pc4+A8kdMrQPHNRpyjG
	E9F3C5WdlecWuAmAov/kzHFKQBHl2BMciHXIi3fyrOAueN54GQNTM2h1
X-Gm-Gg: AR+sD12h28gvYx2nQWqwDHtxn+bx50slLy+/pVkGzz2/ekO+B6yhSDJQXXIa4q4kKPQ
	QAAkA3TLthC1xjBkHc7uQQ71LD4hA81OWi93j8Ye+gHLHoOlWg0JvBTUIgtX7ipDfvBo9A/yv8Q
	/VivetR9OsIaqaIQDrV2FpFL618DUnzVBI3iaD2MoZ2r8TMHQoeBmNNPt4YQYQwsCvN4tlOdPjd
	TrC+vHis6XkfO8kDoaGJOMxURfcTaLZgwbjOuC3J432NunqI2yeHKpVgEl6QDwdQboK5qTBvzAb
	VSmdyBZ5+ojeY8LxyGy2sq7hjZKVzkB+pJau73gTw2Cn2u1TD9ovWY5H3dwNjDW4L9wRlh2plhZ
	PTD4LX9vxUN6Ag10y9bfMd59I9gx9+ygEe9lQd5xYrzW6hIuQpG2aCn8wb8WvxPRDF8L7HiiUq6
	nhAgksWR5dicBU/YeQt3MhOBddxDNdeZ9mOldvwMahEfjX/e0tSP7M+bFEN07WpkQxAn8LUgQIC
	X2j/8Ec8K/czHG2ArH3A63TRVyvbpOJWZelkFWW8w==
X-Received: by 2002:a05:600c:8209:b0:496:c977:3b6d with SMTP id 5b1f17b1804b1-4997c139b0bmr62363425e9.12.1786533530450;
        Wed, 12 Aug 2026 04:18:50 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d702c9sm6670072f8f.34.2026.08.12.04.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:18:50 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 6/9] platform/x86: hp-bioscfg: add missing bounds check in PSWD_ENCODINGS loop
Date: Wed, 12 Aug 2026 16:18:26 +0500
Message-ID: <20260812111829.172273-7-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111829.172273-1-meatuni001@gmail.com>
References: <20260812111829.172273-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PREREQUISITES loop earlier in the same function checks
"elem + reqs" against password_obj_count before indexing the ACPI
package element array:

	if (elem + reqs >= password_obj_count) {
		pr_err("Error elem-objects package is too small\n");
		return -EINVAL;
	}

The PSWD_ENCODINGS loop performs the identical indexing pattern,
password_obj[elem + pos_values], with no equivalent check, causing an
out-of-bounds read of the package element array whenever
encodings_size is larger than the number of elements actually present.

Fix by adding the same bounds check, matching PREREQUISITES.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 86fa03a5ee9a..acb123985ede 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -351,6 +351,11 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 		case PSWD_ENCODINGS:
 			size = min_t(u32, password_data->encodings_size, MAX_ENCODINGS_SIZE);
 			for (pos_values = 0; pos_values < size; pos_values++) {
+				if (elem + pos_values >= password_obj_count) {
+					pr_err("Error elem-objects package is too small\n");
+					return -EINVAL;
+				}
+
 				ret = hp_convert_hexstr_to_str(password_obj[elem + pos_values].string.pointer,
 							       password_obj[elem + pos_values].string.length,
 							       &str_value, &value_len);
-- 
2.55.0

