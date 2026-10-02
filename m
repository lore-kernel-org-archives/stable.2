Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E213EC69D
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968510; cv=none; b=MJJouvrUErLR1vtj3S8U67gHwIEcOL/HTMqZP6fk2jpA3oneMMXZrlgmRvKyHTOkK2MCBU3Hnj8lirAyhu65J4BbF8blqTaYyw0euVwdDf6XswT3cR1x/CYHVtNcfNgNV6+F+0n3YZYk5qj28rgkX2Nb+NsfXT4D/kVJYaY7GSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968510; c=relaxed/simple;
	bh=i9bU91CtXK+5JLjU4w54dq0UieND0jN/3nVvEZHlzjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liwCvxetZ2OeLIRw5xo6VaFFWOkkGW0cGOmV+t4fIPoEcA3rgMNkOfYdQM4YOkm7NHX+MAc5UlT4KRtbuXeAeJZssRJxCFeOoFCyoW/XlziwhmZK5vTGgwwOgRp/Z8rY1tZeWlnoHF8/kjNX6gRLsoKPR7xjMTw624KDxkzSuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDuqXnkn; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDuqXnkn"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso1076545e9.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790968507; x=1791573307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0anUkPzflkC5QgxWMGEWOtHrCLaMZ6h/PTr3/CKEwI=;
        b=XDuqXnknLaO8OXc9k78c62zKF4HJ//50i6j9m+HyV1sVbiBIZlWYBHWFWuabCFSNuF
         ekSM6Qa+ujIIpfZ3wlCrXThv5uZpYoypW8Sc7NoFW2WqfA0EY6Wjx+3fs16ZSnUFp4vf
         ggYbsXRWuYOaFxmUi1JRzhc/ahtUWQtJ7SlawQke3KfmmCXudGec2gitpZRBgi0wSSiN
         7KRIV8SqADVV7ZEGZ+qNbEomlKCrz85h6JjvpNRtY4dZ5KEwEacQ7qoAbMCCyxqvS8fB
         n5BwAyYaUQ432IFikiZfQO+jZKwOf1r8iqElm1Zu3IEl39KK1P8WUa066h/W8wEkxGmF
         iA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968507; x=1791573307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0anUkPzflkC5QgxWMGEWOtHrCLaMZ6h/PTr3/CKEwI=;
        b=fPv/oguf6HG5H8DNatdKwmMZengWhr7iaGiGMdg0zjxIj1Kjn7pwnLHmnO8l/1dExQ
         xYaHre06cOILG/GVPBCBT06WZI7i52j8PIU2pgcltKralvwPOLFFQMSwTi/QEa+A12Vz
         /Jl/5dQJT1qawmYH0ylJuxXx0LoLhN/8rK4PgDAjbG6R7k7seMdhRTKBAAD/DhW+msdW
         9sjFzmbIpBYdI3Di+PKiKUImP0zvs/WCoK6n+z/FycX4D1pwECLGGQMWEUtJ1gz11G/1
         7U8EL/bQPzQnuoWZUXJIzhHTfHShEkakX0GTnUZ+L7QIQ65BCCg0gOmrbx4Ru0wWpffY
         5s2A==
X-Forwarded-Encrypted: i=1; AKwUvBxMvTIX6u4RH7qtFeUVo89e3BtUJ1Qw75Ng6sR/XEDYnVujynTQCQcLb2gFZhnLl8EqQlkkuoY=@vger.kernel.org
X-Gm-Message-State: AFuF++lTcK6GSxERAWytG61gbZnRskaS0UCKz1krudecIC5ILn/W132K
	1CYHyZXPPH5KVdoGeGdiO9/0eE43iSAF1wFj1NM+3LbZeliflydoWbXA
X-Gm-Gg: AYBFou1bhq5YFlwFsxD5scWQJNkjcY6l3mUzKzxqSoIhg+dYJW6+Pjw+VV8BGpdk0n5
	4dPQdq2EKatYWV+htkWNP6P+LTpIefuR9sY+ehmQvurg80tB27e3YXIDzpawfWuumRpWvyJhLaC
	dQg7P1vFqqldfVTRxt78XU0V4b/rWmbq4UXQJiKfwzzHjYUR5Tt2QnpHryIvkg/JCNADTyn3kxm
	nPWgfcGqdEg/SwdqeZnCSjokpBxYyJ+fwVddbqajFvgSs3juh8PwpKYjGEOnQ7Wppm2gkdQALoZ
	hY8ffDJYRf6oRTRaSIlSkmA4beYoRhrnZwnxjt5e+TIF3iBE2SbJWDVXW+mFX1K7ZVugeF01AcR
	gDbdrKAtHcyvkxikSuTCJh0N0EJ1zsxReANwZfGoF7sa4o6Y1kgsy1P/uCeA/FE1SZrh8Irm3QR
	eMN4Wdt3NwxAvrldKla4kxIcp6TQlcEXbgPs2Qs5imbPFBpw4deZ/FaakdUf2LNT21B6znpXuPr
	nND53lyQ6OoTp2HwsHMEkS6OPS96wZrx0e+rcO/huQ3om4zxxvL
X-Received: by 2002:a05:600c:3e19:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-4a027534b98mr63059155e9.3.1790968506897;
        Fri, 02 Oct 2026 12:15:06 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm81151145e9.4.2026.10.02.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:15:06 -0700 (PDT)
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
Subject: [PATCH v4 4/9] platform/x86: hp-bioscfg: allow clearing current_password
Date: Sat,  3 Oct 2026 00:14:29 +0500
Message-ID: <20261002191434.58529-5-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002191434.58529-1-meatuni001@gmail.com>
References: <20261002191434.58529-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ABI documents echo "" > current_password as the way to end a
session, but validate_password_input() rejects an empty string when
min_password_length is nonzero. The password stays cached, and since
the previous patch the write also fails with -E2BIG.

Skip the length check for an empty current_password so the write
clears it.

Before the previous patch the write returned 1 on an HP EliteBook 840
G2 (min_password_length is 8) but cleared nothing.

Compile tested only.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v4:
 - New patch

 .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 3f4c45d9b..f0551b455 100644
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
2.43.0

