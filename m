Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0540F74D
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767473; cv=none; b=BI7Mklm8VtYSMJimC+80Oz4ww+DVQ76Yf88qNx+bqWuRftWqC4p7FhBDK86kkhvGBe6CD7R0CYETYLuyZjTVhPLMwXTC4p3mkd0TuXs/ywnZtKtD+0PFhaFEBKu/PMvaM1TcFeqqQ8MN74MqA/taD0KF2U9smzS75E6Oumm8m1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767473; c=relaxed/simple;
	bh=rhIU1zG+Cz1JEJ/DZCxK23rcEZYVi7vpJbqoVBA+2qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqkhwSYp2oCiQuP+ubX31XJEUU8hLbvAYllnKD0LbtZfC7hWyrS/1rK1TnqWMOl7NKQCNFL7oVVRFO6hCiweIX/mdK0nb7Ty3EKptl2OUEhBTmMwg8HCi5B5pOAEZYbO9ZcDsu2hyNdQY+8d3WdwjNtdFg3Cii/hmNmToaZUj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN5AsLZO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN5AsLZO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2188027f8f.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767469; x=1786372269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzXAlvJrvz8VJKZL5THLFAhA3g1WFYpeVuZ+6qv41B0=;
        b=EN5AsLZOMn9+iUtyfCYtIKMbFvHptztVv+bPHFA279POyADHOG7dixnM1f0411liHX
         1PrbJZBzQIwEditG2W6wojAatIoBiGxAJd/wLzW/kS179E72gKahzvmNEdr2PUHZasCF
         /uNQUqpJbkQ89P/Y3YFc8EYUonMWW+Ti2KnKGvvSBL86ycM/ev7qHiO0plpvIbSrTDir
         hArKa/sM1Ld4W4vKlF86AIKp1P1m65B5WnJ1vkEQZJi2w/8XuEpWp1lqMgU2XXDYA15z
         MoflB0MCxFRLbu2mLz4rQcHentmwCMrUmlY82EnYk+iqO6meeg3u9jdeu4BYD0pu7crr
         FTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767469; x=1786372269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzXAlvJrvz8VJKZL5THLFAhA3g1WFYpeVuZ+6qv41B0=;
        b=LnTfgKPpoBOGb96HzmI/KY+3Z4LkwLgNwCP1hc6+rlAhEUkd1XoeGw7o5+/8FDAMSj
         Ze1+zSuWZvRmfQ27eC1/tqB7VHWNMSh/icH36O6Bv35EhMZ1jmrIxAwk4PqT9Wb+sdTW
         orj9LppH6/8tm6qgkWOsYB1jIr3yPqdN7VrBLsOYTRhWruQfoGZdA5TBt56MQAd2pRtm
         nfjsLW6Q74tuRaHXmVXFcHWdZTK7UWYQedB2bWSl7cvc2mnGhAAhJajI8VkV69eHW5aH
         ZPYR0i9f4xsWsYd+o2+4fE56bdM2o4qay4egU+85W7eXzMvmjSitXHw79xUFk2iZ+DPb
         fcvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyiwjzegpBosoVCnaCqjWGDLqD37wfr1dSEPfXwGPOBSaprvV/rDkIxrxx5lf7rRQuTTMqpTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDOdx1jPrsZ/4BBE4gVEAtl9xK/99ylgqrXUJboGUgBl474m8
	mg8FlyN6NYQaiI5Km/wftbSWltCQBFqSSH0NRwFoV3ZoY/vJBcAZYMERCD2gpYsY/sU=
X-Gm-Gg: AR+sD11xXZovnY9f+jypurpqtORMnRgHI67YXAYWhfGso2k/bZYlJva6kzTp1KKOZ/K
	kM37xP74oqHp8UX8Z2SK6DCEgy4QWDS3uL/xCikouBob4AIBEsgB8ebGKKi7rZzKvyon3Kg7ibO
	ENkL+G9vESVVTy43UoYPs/OVZlPpn/Rf9dzfY22+shj+ET0WFLvuTiN1F+j3sVjM3yCEYp7bocC
	hXJsy7QQ8ABP2wzDzIuiEGeS4t10Wn+2nWwsq7xhKvxSSe/WgJVX3kz6Fnv4rf6LtL5ChTiOZr2
	3hzQQAu8zuKc3Ww2WodtFJvnh7/nx5Cmy0WnprvWg1Ab43DHuCrMLVKwrzOlOvxSzUociXMc8DU
	R3FX0nF23LNBejH+woszwCpWNzVd36Bl13vmbmGwtYk+8dQRlojqeCznRxbhxOteoeSCqz4bw3V
	bjqWG5cY2vqOPkBkbgpWNcHjPAu8Ta0/LvtLIHpkayq8QdSapj5UMghDgNFQDmPGKWJjZ+OQHsb
	r5QE0IGaRhd00erAlYfOYc16V28VS7zlQ8D6LjH+A==
X-Received: by 2002:a05:600c:214d:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4980c653c0cmr169146715e9.9.1785767469327;
        Mon, 03 Aug 2026 07:31:09 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:08 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 07/13] platform/x86: hp-bioscfg: fix new_password_store overwriting current_password
Date: Mon,  3 Aug 2026 19:30:30 +0500
Message-ID: <20260803143037.93105-8-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

current_password_store() and new_password_store() both call
store_password_instance() with is_current = true:

	static ssize_t new_password_store(...)
	{
		return store_password_instance(kobj, buf, count, true);
	}

so a write to new_password is routed to current_password instead, and
the new_password field is never written by either sysfs entry point.

Fix by passing false from new_password_store(), matching what the
is_current parameter is meant to select.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index acb123985ede..6bd56d3f5bd0 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -123,7 +123,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 				  struct kobj_attribute *attr,
 				  const char *buf, size_t count)
 {
-	return store_password_instance(kobj, buf, count, true);
+	return store_password_instance(kobj, buf, count, false);
 }
 
 static struct kobj_attribute password_new_password = __ATTR_WO(new_password);
-- 
2.55.0

