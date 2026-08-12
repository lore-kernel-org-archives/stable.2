Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0F43A7FF
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533536; cv=none; b=TAJJmEBVWXb91f1V/TQGQIk/W/E6snFupKLEXMcWoIIGMDAdDP2BVvUaWfk4EXAc2jltlU3Vsv4iaKeULQDkCthxUXcfgSp+pkDt8Ww4g3mqDEqYjuamXRCI2SwQnd99xhZ6pJvk35J3XL/gu4FdDu81F4ON0HvkE5HXJda9SkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533536; c=relaxed/simple;
	bh=rhIU1zG+Cz1JEJ/DZCxK23rcEZYVi7vpJbqoVBA+2qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyW69o7BFS7m1p182FoYJiGl78+M9glWLSOcM5Iv0foiMm46poQVM0eYHR0CYgM+0LL8u1Ej/DtZiX9FtQHVHAWh6aqJvgz2YwbGjRpUZFKn6BcEMzB7FnIymIP56oZxuEcZ3L0HDUdCh8jC9718kPSEA4cJdOQTUey9chtpGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyDDhKJQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyDDhKJQ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so686875f8f.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533533; x=1787138333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzXAlvJrvz8VJKZL5THLFAhA3g1WFYpeVuZ+6qv41B0=;
        b=eyDDhKJQcUn/6qaVG70x5845SB6g7ihlqCZ1k9C8xA4s08vUsk807yQ2iMtWsio3AR
         eyWyrgb7t4KDldnvAQbkbVKu9qRmGkn8fyAb4KLpFZFPN3VV4L+kWVJRpgedCGc3rtS1
         RNwFF3phhL4r1S04kTxp3VeywprfsEVJ4QIOBUGJYt8zZtMsXQYIw+WMa1c8yXcXI/Hk
         CyWCvNOCnMkPfCeVphomyYmgSylyVP4OV011SyQKlB+nw038Tea1oPI6Zss8wvXxUnCb
         JCer5DqazN1QUHGUOAyJkS/691E3Q9hpy47cZAuQyykkXhxzJYgH5Z4Kdn23CPmAWgdI
         hKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533533; x=1787138333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzXAlvJrvz8VJKZL5THLFAhA3g1WFYpeVuZ+6qv41B0=;
        b=V4ZKb0ICD7kfLoY+8IybPp3OLxHAZDkDRpTaDk6Ez1J9N4qVnlDDYYV9f9nQ0yEpG1
         nHrcgiqhiKbRGiSI4DoMfhyp3ie/cYI1QXPVUcR1gBmFvywZnR8Ppa94I2/vKXGxLDLk
         JkCxrftLWzg5HUAh91mOpS5Ld36R/Vnd5QpizmLaGlDv50PsuLwHdSjTXVYkjL2Ad+AQ
         WQ4hVdl5PU6u7DnmLryqq3X+m58c9gW9uaey1t9opjGARWZnD9N4PdT55e6tzNsEabiW
         KxW3ApU3o3XZovhcSdzSmPy+WRQAmsfNplUUSmyn0WJi9xfjWtxrvZYw8ptYE6wKirCJ
         +1mQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz819IQyMSHC9NurDeAwWJmQ67PJiiTWHVS0CWqrtHcO0ZH22mCAIKqwlynFFMB9cWPlImUPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6s9/jgCVqJ7admU5a4904xFMBBdFgnNI68imOjTQNuqWeiET
	Xk0HVJV2G/RLTJ3pvUhgpH04LvVvTg4JP8XEDRkGD4zv4IiqiNJXpCXr
X-Gm-Gg: AR+sD1331lyT3BI7e3ERkfvQqm7DWJ5A44TcXn+XcOkES9QBo1iymSV4/fDAmTlGCoW
	aJufFji0wLd40VefFfuQ8kx2YGoDURS02AuFeHgfAtHGEg9dHgjiv2+eTdiuq2596hJIPU3KHt7
	101H8tCnVIchJkw8zlG7QLMDZsJ62s8gbF5gPDFJsMl3+nU0t/JmfMUeZzRJV/m9LwJmDue1xCr
	1Uay2xelWwVirlF926Xph3HbyQiXWYAix+56GTKybCqbGsFJWxHuUFugt6C+v+ixfME5c2p+uyQ
	V6KTzNX6xXyMWlI8hheyWNJHM16UphC3EixhC0ysB5iqx+OrMxLZuspPud0bIYVbbttG5eoZnXA
	5zttn2rJNFDICGeK5uyGFA2xRzdjM/RLJdrb0mpDO7v2RAs3s56J4TffhsN3mh9SeGKoMtysnvQ
	Ftd6zK2Otnbj+I4XRNqYBmgA2ijzLlBMXDEulY9z1noJQLoJkD94nPS9J/pNDnf3xQQCHwOAMV8
	gSjHvmqjccAWDP6plcZtmJiPzNPq2n0yjvOWfSPPQ==
X-Received: by 2002:a05:6000:490d:b0:47f:ebe3:ca31 with SMTP id ffacd0b85a97d-48152dfd065mr6373537f8f.28.1786533533075;
        Wed, 12 Aug 2026 04:18:53 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d702c9sm6670072f8f.34.2026.08.12.04.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:18:52 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 7/9] platform/x86: hp-bioscfg: fix new_password_store overwriting current_password
Date: Wed, 12 Aug 2026 16:18:27 +0500
Message-ID: <20260812111829.172273-8-meatuni001@gmail.com>
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

