Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8644CEE4D
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163636; cv=none; b=SqjGHXHhMwli8nMvG9Yb0RgtPc3pJ3c2CMUUUTHEbvfK6EbbXQzn+GMmKn+AZ+9ZV9D0mj7guuQ4wnR7yxRwPQclTwdvv985XFzkzClgv5miGRCQ92rCc+MDpVzxPwclSjbYxAuC079Vm2Ow4D8BUVL95bMhlUmBczWT5uAkeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163636; c=relaxed/simple;
	bh=SZW8P8HaP/6LFI6azkqEpyOh628pL3diXyOw+JET4z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aozDA8SeZVjhQzOSVBEskSvCWTvJQrJfieOse9y8hX49BIiizLf9fmlIbf3p8KPPcCTWwgqEPv/fhnenfnvtrc9bNpG4CFKGSsjDAITdwQQuZvWdwdsTQZaCaRys3j+aoR0BWHY9u4eKmKYfOwIulo84A+LKpGR/xwnO5EVVix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9GxdE3A; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9GxdE3A"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53512cd2f85so34391cf.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792163633; x=1792768433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zv8TTKfbeUYEMQDxnGPnn21N4WT11tkkmWwxYn+nfTY=;
        b=g9GxdE3AnRDhHpq2JtaRCYRYwahCYQkCA3QXNcwF6kEOwQwcumkcGMnpeA2Czi7GYt
         ETmS/mozBP4P4/Ab4vFaC6b59nN3r8zrMKTCFUqKas/EJW2cuEGnkbc20aDwDis9GX09
         ZHKjjGJ8PgEp19cBdweQ0ZRUrhYPHa4RqU/e06otogoNHOWW28dIN8ijmK8qQcyRQae1
         3B8z1LBOPz4o8Po4vE8Kj5N68X9E7pIK4xbokGliEiS1fNVtLJwo77ZF1bbRAdlef1EI
         w9LX4FgF8ZgZPtthQCbt6nGwxbzbjJd2ihG6+tG5sQuQte60/Bc7GtOJ3m5YGO+ZVM/8
         pN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163633; x=1792768433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zv8TTKfbeUYEMQDxnGPnn21N4WT11tkkmWwxYn+nfTY=;
        b=e19jNmQxxX/784Rh3Z87dmHfyhwG2ojcQXQtoFcXf5rXSbBd7Qbo5J6siy8AvOxZQh
         LrD7u7QLtvUAilTakiXuIa9Kk+vt8oC3ZQQD/LVRrLbNTPwdE1OSaIhGdD72Xu94LdMi
         GGUBw+se0Flh733Ui5g4nRuFsBgBx9BRkiI7HOpZVkxuUtsVkfK8nkmDewiF3/DIPg8J
         17yUD4CLAUIVwshP0EfmE5wagpzmF16mfjPLu0cAPhALZVqKXBC1oGEITdn8vPbZfhik
         mgVeAgtfWX+/cYAbmjnt95+TDxwK7mqAdozgXbuhDEojYxjursBT8w58njGlmLgvYknU
         0xKg==
X-Forwarded-Encrypted: i=1; AKwUvBwU/IH63mxN93nmEAJOOSuUL+NN5eeb5TkWfYOSrwUIY7GmG1rRy1IfM+KqJVkxJBaRxba7QMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNgFc6yMdwBJecjF+Ngx23xMr1cQYHaABiU+/J28wDcUcZzJYu
	cZytDIq3Hd+BoJRe36J0lmsUgVpBCN8pUK6LwozhP0Xo9B205/bkWCkJ
X-Gm-Gg: AYBFou07nDapcbvYkXeY3meY2/qYdGIHqGnDYNvdpj9rQNS7smGQ1EiaCGkFSSfxJkE
	07E+JvuWnyfKDW19D9zlQpvdRg8DNCoJfLdyJ6sYczw05sCmgN/xTFiarzpJiHhXH15Lz8MR+8u
	urpsMwzi3Zq8cMv0ppUKOl54wV4I63cFdy1EfWItIg1UogT1AlhG4A8K9/soSwt1yxw6S3h1Fdz
	1o2Q4w/vjOSkK1z88FoVTpNJ8f1uQg66L3AhDfuxMPBoYZrL6bEgN4pKzeiz8tbyiFflAp+bV9w
	qfPGBUxnaCQYU1flwifs6mFUE0UmpULqwvggKpE92xUd/KAtu6ZA8pMgVNDPwea0MXXnDSbMl5/
	+fJ6BuBs/0XRhvpnnb5q+1VibX7r61sthWFYxgxOY+GoFRC89PIjqQcxoNu7vFhK7VbVg/IisOA
	cZ/+9mIYG4LauE9A3zIpaxN20Y3qFOV0REx942bY8bklCd2KZIYvMwz7pXanDXRWE=
X-Received: by 2002:a05:622a:260b:b0:535:8567:662 with SMTP id d75a77b69052e-5359fe116d0mr371801881cf.62.1792163633191;
        Fri, 16 Oct 2026 08:13:53 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa59b03sm24674041cf.27.2026.10.16.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:13:52 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v6 0/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 12:13:40 -0300
Message-ID: <20261016151343.3120300-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016135516.2957381-1-qwe.aldo@gmail.com>
References: <20261016135516.2957381-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6 fixes issues found by Sashiko on v5.

Patch 1 is unchanged -- reorders try_module_get()/get_device() before
input_ff_create().

Patch 2 keeps the devm_add_action() design.  Changes since v5:
  - module_put moved to hid_haptic_destroy so the module stays loaded
    until the FF subsystem is done with the callback; a second
    __module_get covers hid_haptic_devm_release itself
  - guard against double-init (return 0 when haptic->wq is set)
  - NULL haptic->hdev and haptic->input_dev after put in devm_release
  - restore dev->flush/event after input_ff_destroy on devm_add_action
    failure

v5: https://lore.kernel.org/linux-input/20261016135516.2957381-1-qwe.aldo@gmail.com/
v4: https://lore.kernel.org/linux-input/20261009103333.2476105-1-qwe.aldo@gmail.com/
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: reorder try_module_get/get_device before input_ff_create
  HID: multitouch: fix use-after-free of haptic data on delayed input
    release

 drivers/hid/hid-haptic.c | 93 ++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

--
2.53.0
