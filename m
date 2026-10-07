Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0694AE8A3
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380883; cv=none; b=oB9r9DQui3OAFpOqsX/L1alX6BXS13B+qLRyG2QrdVet1477fC//5SyQ1B+M2l/N2JsC8qOPvqCMI1eSnAXrIgQRgEWYeKvonw9Ix9r6ohrvGnMwA27HpbKuhN6zS/RGiN/sUpAMMGSCMJFWIshcw7vJFmVmjubps7uNUIYfvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380883; c=relaxed/simple;
	bh=onzGCFTh+2rNXII7iXfF1revtsH+T4ZuDUAmpOR8U0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfVBIuoywHGdJHDQUGPiapCh7r/q9ux2PWq50kh2br7OmWeTHFdw0DX6sRhiZUKvaYaVFzfhC1EeUyZ+CiQHU49rp1q6I+LH+7rEZ6aG7TrIsK9TkO0e1P5DNddVVBHk6ISGVqnYvvmgAVb5YsaAQA9c6ApD/LfhKCgqYv9NH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+aIvdJx; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+aIvdJx"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35171047ac8so18316eec.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791380872; x=1791985672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sui9Al/keQRn9LzsJhep5PKyFrhoL0LEL3YQX5XZ59A=;
        b=B+aIvdJxw0B7pPyEQAT8Ii4hOkyralIs9Zx+j6asPBAYpckl2n1vost6S+3VS6j37j
         cpqtOEQVZzgM/3aqBZd6Ekk0yfP/MRkqQTNlpn7FLnj7VtOXaCbnN255MCh8ystFcKHV
         P3kD6So7R0aTn9k00rtSw/je8POxJLwdbKYTuxt7aNpZ2ncvskTdcaAAmvLogfczOQPB
         4upeKAFoDFwWaffT5k1wzjTcUBc61RhyitaLgBoz7w8o8BkfBnUOP4jffVfr1+WOu2mr
         Q2d6E4Yz5JgEprlZ/yaL5xWeTcGFU6sL15m9GAGYWytHXPHtHS8VH3I7DH+Jo3Fz6cAs
         520w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380872; x=1791985672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sui9Al/keQRn9LzsJhep5PKyFrhoL0LEL3YQX5XZ59A=;
        b=QKvrXLpxeHHiZXGdOPbegb17rWBEUwF/et5ELac+YtbdFBw/DhugfE6z+He8GXFotQ
         yo1XSoeX7mNPxsFB3HqF8SlLLxYH4ZRfULvW6WPRIkskYybW97b2T8VQI/yJV+f3pnKT
         LlT4OqBrsveH4dm9dVSoq9w9GgWNmnSvCevDaUtW8Qm29xSY5QVffQb3GuhOduFKNqsa
         9vams1SPVvC/UHG8RMVQ9pH20uLaPu6UMFWa9jD8DVROkdu+fZvz8VlS/2wBGk4jRin+
         cETb7i6cisAjKbqtNmf/7lkiLk/2U+WVs5BZDn1kqvauyG0of33/gyfgzIGyaUI+IhSS
         bfqw==
X-Forwarded-Encrypted: i=1; AKwUvBwyMtGwmoaSeFW55nzlo+Y8Faq5L67Ap8n1KSXyHvWyzjfZxAPgJs0x5KVx2j0VUXDACNmNiRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKz1NyxtD1S5IpJFp3+OViQwBBEXmP8gieupfmpvv7b9Ktysem7
	ShC3Ghs9GiVT+1KfY8kaFOuZhsUuKiaajfd1aU66LIck9NiP3qCZsUmc
X-Gm-Gg: AYBFou1QVpBHKqedKR4oQnIdasRcGzbdYwLQlYX1B/64COK7OZiEkW29DW/Gz+TojJB
	OG84UUh0syYVGRN3qAX2ngTsvniLVMFYSwpDmSEsjUVisyVR8/3dZiZVTnTgyAvYl3g0AICLBg/
	50OiHfQW+ozkY5UYwddO3SmNaD3ageAxHLleecDtnSR5dbf386ZoO/mWTmNRxUxorrNhMfMEI2l
	LrcCSnY3Yqx+5JCgxr+fqM3WIUn4vnmm5+XoH84N9aN11jPoRePTGVcYrUz9dmfcQEsUNmXGkYR
	Kv5Ewt8+2Lm7co/5+1XItkx0cEgU5Af9No4ZvOUSmNTgOyOUi2NBDL2/5nWvOSZpfEkfUVFo7gl
	CMsF0CRppVNoLHGs++hcoN6MkP1DKTJgKA6nH6yW6PaOEXov+xtf5au1BTD/f/XZkJZ2/ZK2gCL
	iL+vLnf58OXrZ3CXIqCd6M0H+tkU3xo7yDJSjhGlK5Y6U1IqPzixidv34PmaIwCxyeR7gB3TA/L
	zjYJQ6bjeTUWK/Am2yc1cojaMPSijPd8Gbb
X-Received: by 2002:a05:693c:6089:b0:351:4746:49d7 with SMTP id 5a478bee46e88-3515de434dfmr2404250eec.5.1791380872216;
        Wed, 07 Oct 2026 06:47:52 -0700 (PDT)
Received: from fedora ([2a02:6ea0:c803:3091::12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c2esm7304472eec.10.2026.10.07.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:47:51 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 4/9] platform/x86: hp-bioscfg: allow clearing current_password
Date: Wed,  7 Oct 2026 18:47:06 +0500
Message-ID: <20261007134711.473857-5-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007134711.473857-1-meatuni001@gmail.com>
References: <20261007134711.473857-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ABI documents echo "" > current_password as the way to end a
session, but validate_password_input() rejects an empty string when
min_password_length is nonzero, so the password stays cached.

Skip the length check for an empty current_password so the write
clears it.

Compile tested only.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v5:
 .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 8018ccb2b439..96172342d4a0 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -60,7 +60,8 @@ int hp_get_password_instance_for_type(const char *name)
 	return -EINVAL;
 }
 
-static int validate_password_input(int instance_id, const char *buf)
+static int validate_password_input(int instance_id, const char *buf,
+				   bool is_current)
 {
 	int length;
 	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
@@ -69,6 +70,10 @@ static int validate_password_input(int instance_id, const char *buf)
 	if (length > 0 && buf[length - 1] == '\n')
 		length--;
 
+	/* An empty current_password clears the session password */
+	if (is_current && !length)
+		return 0;
+
 	if (length > MAX_PASSWD_SIZE)
 		return -E2BIG;
 
@@ -97,7 +102,7 @@ static int store_password_instance(struct kobject *kobj, const char *buf,
 		id = get_password_instance_id(kobj);
 
 		if (id >= 0)
-			ret = validate_password_input(id, buf_cp);
+			ret = validate_password_input(id, buf_cp, is_current);
 	}
 
 	if (!ret) {
-- 
2.55.0

