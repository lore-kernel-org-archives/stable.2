Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D74F7CDE
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625821; cv=none; b=qIOy56QBH4Uz/d+u1slDdHv5lIAIHk+d7faNKantFzaXqwljjfoRxQrpsBKuyQEAGmdOv0RyCl611cbqSeqTjbsUa9VfOxCQ/SFGlN5gCrFvGb/zGuXYzbCcAZaaCScsVvcS81qHi94il0DSkBVn/PAq0WtUtBwtt0F5F4KUbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625821; c=relaxed/simple;
	bh=YEdYxhIApJRRb/H+xRmCLt5a3CHQQvc9rbOlS/lYSJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWsw6EyDXGdlKvySgfzsRDA1sxdteeiLNX6dj9QjlU+UOnihR0crh5dGuYZJaCzJI/WaKUkXm//WKolpujw1sX/m5UKcXrA1gV5FXmc+0vneYL5iaUH4TK6o0HE3YCKn2gwfNWoFrpOkNW07HdKPIfnPfX7bzlbk7A1eeuLif0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkjJXmHg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkjJXmHg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffa15f67fso13176605e9.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625818; x=1791230618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NgJAjv7LJOWIoyDAobDDwkG2YUEnWGXF9w9IGSvXkDU=;
        b=SkjJXmHgIja2q+F/rvbLbxTP/oI09tRaKrKqTzfZAR1n+ceO9E97UZZK/9TrfyiUfo
         xCo3Bk+t3gp+ie/lDLpgT5yYYjHxT1Kbcc03YWyK7SBbcNz13WinK7YwRJgXzEEYyqhN
         7OjkuZD8UJp+KlpA3JrUm8rwPIos1gTgWDPy4apcYs0EQmzIxhnJnFKVetfKAZ6YFF50
         MxFBDvSrLP8g0tnkiaGM9uwWijvK2+VF/eSv15VB/jWkTvxM0zsKL4i38sejNpr+DhJ9
         CH3y8T45O5avuhQdLe972qsf5rOF/CAL/x1NCA4snv2GSCyBps3GSFsC0m4gMKheTbqC
         P88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625818; x=1791230618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgJAjv7LJOWIoyDAobDDwkG2YUEnWGXF9w9IGSvXkDU=;
        b=gsKj0FCv+5aOCaw9pVVG3mUeSqz9vpvtzTPfxNc0d2du9C+7TH0utYiiZFMVLeKIlN
         XB2HoZ5Y0N9pPQosacNVkiCw2qpoZ22u7Aibl1N9zveU8Gb95m1MlJz89G2zwOso5q/N
         lXW9vRK4WmieDp9xXa+ljgmEaPJfBlad9BsQj6JZdKbKQCKK/kjlGkMl2+U+MhIxBwoL
         RQglVR9NLovNMbMinTdd4h4WipFX5frcnOGwipQBGnnrrTf6f5jmWVFSAmiCaTGvZIsy
         8aANw4xWo8LKtFxEvGK4RxVHO5ToyRSzLCsQ5stUI44CQ/5CWMgj2lkgerDpufEy4HhB
         OzrA==
X-Forwarded-Encrypted: i=1; AKwUvBwBO2NRcReXj2ueGcnJL6aTYRIYqH6/qqVgcxTiYgRcUfsmaenTt7+W0oIE+EbZU/2VXSZ9uJE=@vger.kernel.org
X-Gm-Message-State: AFuF++mPdu7gDwgrIAYP296EthSn7hykbTS+cbA4TRfzHNnS9GpFlF7r
	Vsht1OKT64sHgLJYgIpyotZhopDxtQmgKAqTk164N01IqOSauFHNmuvU
X-Gm-Gg: AYBFou0UO90ia9jwWciEHAvVPkP7ws3rfVv4PbhVbmWKeEnXG/7OyGhg4ulIXPuy/pZ
	GWYgm0ljIDJ5Sl/TwV4dDJ/Y74GgLgWeI2VheVdhYJIOs2O/AY93YLvH8S1LzlmL1dawb0A34y9
	I+DxZhp2VKiEQZiCehO3R58lkpBN6s/ZQF6R49ZfHHj3oaVMcO9AdwVa6+oU7M+SQz2eOlZ3Py4
	Z/FSRxAXSE9XDBHWQUHaCzqAxVroaAnvnBzOfUfOKp7I0/T8CChAdz7TIJpiO2QHG/4XlldgkqZ
	GlqbS7v/Np36nOrM3ZaXmuPlEiJ5qDnftjvXFDgl9XmnBu/Mlic85OcLSpW8FupghoUZuOhycdm
	f6UkJGVkhnX1TlkyoDzttf2YlEm1WJ/wxO4pRxsmQubPGK+HTpsa4mtp5UledlK/7akIoPYfSzH
	bCXIR/aUA7JAJV9yM94Uf6/v2hDvutEC8hqVqwWnQWUIrcRMxn2KKhBIaZnKXeH6CDTgK2oNILF
	8+N1KqgcLwvvcllz3otol20bNGW19CA9WSHk5OksN4xS9DECUPD
X-Received: by 2002:a05:600c:8a1a:20b0:49f:f0bd:1e40 with SMTP id 5b1f17b1804b1-49ff0bd1ea8mr132227285e9.23.1790625818398;
        Mon, 28 Sep 2026 13:03:38 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm26506625e9.0.2026.09.28.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:03:37 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 3/3] platform/x86: hp-bioscfg: return -ERANGE from validate_password_input()
Date: Tue, 29 Sep 2026 01:03:18 +0500
Message-ID: <20260928200318.63383-4-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200318.63383-1-meatuni001@gmail.com>
References: <20260928200318.63383-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_password_input() returns INVALID_BIOS_AUTH (0x0E, positive)
on rejection. store_password_instance() skips the store on nonzero
ret, but its final "return ret < 0 ? ret : count" treats the positive
value as success, so userspace sees count instead of an error.

Return -ERANGE, matching the sibling validators for string,
enumeration, and integer attribute types.

Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7): writing 999
bytes to current_password returned 999 with no error before this fix.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v2:
 - New patch in this series.

 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 9b989ef756ea..b1c687fb4700 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -70,12 +70,12 @@ static int validate_password_input(int instance_id, const char *buf)
 		length--;
 
 	if (length > MAX_PASSWD_SIZE)
-		return INVALID_BIOS_AUTH;
+		return -ERANGE;
 
 	if (password_data->min_password_length > length ||
 	    password_data->max_password_length < length)
-		return INVALID_BIOS_AUTH;
-	return SUCCESS;
+		return -ERANGE;
+	return 0;
 }
 
 ATTRIBUTE_N_PROPERTY_SHOW(is_enabled, password);
-- 
2.55.0

