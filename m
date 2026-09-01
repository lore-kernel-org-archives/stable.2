Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638E3D9DA0
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268004; cv=none; b=ulAQ6SizIDATsxtM7WbSCfq9InhT35dd744rxg/mcaly7VqH4u6OM83i2MBqNQRibIbNuV15RrgRSBflrJDLARXEo8CV/iOAnAWLPWVG0xuq0/FenUf8KCEDSA2Gq7TtUXO6JQMWssgH57WprpCKYPRKox6VIznPXmDb9xvfpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268004; c=relaxed/simple;
	bh=8oafQKn5E1afmjR0jBaThKt8NuujDHb/1wpNQn0jknc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOCByPI7RIf7AEzUG2e8GQYZHhhk9qkq1bfpHOaIRjTbg0Wd+BD5LQuv7QLPHitmMiIsvkdpA3wVbbhItOLd8625ghgcdskmuZHadKmg9jtRVdQyUZcOxpdsVSPJu8rF6GGa/2nGTve2EpZ89Vs7JTjvoGedcrRpkWPI4iqjPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6Btcb3b; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Btcb3b"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-85dbc24d398so42441177b3.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788268000; x=1788872800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o7XTCNgZ64MJCC1OTIr3HJaK9bEsF0FVXR7920AQRVk=;
        b=R6Btcb3brXw0ZKyH1xCJstdChuCpgMpeYfUIsBtKfGAR7lkq5AQ/CeYmxfwmTsOLtn
         DDzUZvH95Jik2Kk1/VsnuWNSLvZDx1jUfhI9PUXfqagtgBHxkxv4WE65xxZoqXJZnTzM
         BNGuyx4QOHNUPLbjJaq3EnshgS4maAQhID4hzwXrYaPyxh6KxR/1rXhiuRvReioaZU6H
         rfqJ386QyyT85P02c5suurWspHRq0BtZYvEbvR3QGQt9yE4BExmbHkZS+UyUsxDNmzKC
         l5qKc6tOIDF/tX31HyqbePEjCmcarbc0lnnjqODh6G+Pv/i2gQ1/s6USKxtcwqhcxpQT
         A2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268000; x=1788872800;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7XTCNgZ64MJCC1OTIr3HJaK9bEsF0FVXR7920AQRVk=;
        b=ZPCWWEceKkCQ7AgeiCAn4ofDN9B2cwKeR1x8uLxqFRtu6xthgQw19r020j3ab4bE2L
         Z7dE23WdFqGem7y5AXSCByPWVWzvt8csM6xz/OZsgo8AVRW7+pQyQnuGtqVBQI3MdYYE
         TtZlfsErgD67mWKj17FrG/rQH3fBs/YarmzEGY7+yGczG7T71mVM/oofm0XY9jj9p7oy
         xsYLNHdl75c0pXcO3euc1iBymTL7ETnCavtrXjS6j1SzUJyvDOj2lZmbjoY99IIi8B9E
         Hdacnf+N7Vi0aZ78lGQyxvD2Qomb2bWRrh0hIKOM9yH76VBhh1KSJBlbastzF7TPR6DF
         NdxA==
X-Forwarded-Encrypted: i=1; AKwUvBwa0gkSm66GfRuLofc8aeZKxLttOGdFk3qI4j21Xfd2Ca5HlWBQNh8v/VNe/c2MEaUJFHD9VKA=@vger.kernel.org
X-Gm-Message-State: AFuF++l3DgXdnD9TQjMDz09EpJ43PKRlMnchYqawBcqqfz0F+Nnd56Od
	ELU/ZHnOGLB7qI1L7UkXeov93fe1rKah9tUYSZc/ACyA3XfBTB3FNatU
X-Gm-Gg: AYBFou0OCHM/3TShr3cA7tTHUwN2iRNovzSWk+CBke9ekwRJ80S4PW8XnASQKcJa+Vz
	d4X0nsoltqH+HsSzPUhp57jrMDUcikFnhWFvtm0Oq3tBcmCFAmxM/Yhlrhsslth7pFi9BvsgU+3
	+h+9DXnMfPTPfeVHNjSnqRwMUcsojziW1jxVcFLybbGKlEVhOOSK0l9mp+AHJTsDzKgjHvRXMl0
	1XI6pr5N5I6BdTMHfOXJSuiCxeYru9Kt3K4DWTGH0+TTntu1J5mDKRE/dSpHrQk1LlfNPi3W4G/
	2kJ6AGfZaEOWNOE+Bpugs/4PF7WYdpVcpiUQFlcpJO/LNPDxtTbo/pkhnGtwMC5Dq6VboX9QLIG
	WA5+1saaO2xaaZZgOR+aTTvaIe3W/lnY3ut57hdA+OJHur2iKCTT49rn40JeCJt6PIyXqJ/0YVP
	h27yZCbE9ulfUv63tX/qYReM3H0JIq86VGv1/GPJGALZ1jDfY6IAZqZjtpDKphH7Z/
X-Received: by 2002:a05:690c:4005:b0:856:98e2:6e9b with SMTP id 00721157ae682-85d69640f36mr102875907b3.5.1788267999872;
        Tue, 01 Sep 2026 06:06:39 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1cd5bsm73290547b3.17.2026.09.01.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:06:39 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 2/2] Input: zero ff_effect before compat copy in input_ff_effect_from_user
Date: Tue,  1 Sep 2026 10:06:28 -0300
Message-ID: <20260901130629.24078-3-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901130629.24078-1-ivanrwcm25@gmail.com>
References: <20260901130629.24078-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the compat path input_ff_effect_from_user() aliases the caller's
native struct ff_effect with the smaller struct ff_effect_compat and
copies only the compat sized prefix:

	compat_effect = (struct ff_effect_compat *)effect;

	if (copy_from_user(compat_effect, buffer,
			   sizeof(struct ff_effect_compat)))

The tail of the native structure is never written. Callers pass an
uninitialized on-stack object, for example evdev_do_ioctl() for
EVIOCSFF, so those bytes keep their previous stack contents.
input_ff_upload() then stores the full native structure in
ff->effects[id], from where a uinput based force feedback daemon can
read it back via UI_BEGIN_FF_UPLOAD, disclosing kernel stack memory to
userspace.

Zero the effect before the compat copy.

Fixes: 2d56f3a32c0e ("Input: refactor evdev 32bit compat to be shareable with uinput")
Cc: stable@vger.kernel.org
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/input/input-compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index a5043193ead8..8860a0730294 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -76,6 +76,8 @@ int input_ff_effect_from_user(const char __user *buffer, size_t size,
 		 */
 		compat_effect = (struct ff_effect_compat *)effect;
 
+		memset(effect, 0, sizeof(*effect));
+
 		if (copy_from_user(compat_effect, buffer,
 				   sizeof(struct ff_effect_compat)))
 			return -EFAULT;
-- 
2.43.0

