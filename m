Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801B3BFACC
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767491; cv=none; b=Hn/zk8KBdCog6RWAGJCAIApLvCl64eFF0huhXHedVRY0pnK2Ca2fo5SlDYFxdsUgcvHEYEuVsZwWogBUwiGmAMeIAanCgxRmgi9j/4i/ta9ZMaKBySvSatBsc+G2VuO7A5ZA4Q4Y5tuTiCcWDuyKpGQMYoUecQoKBiTibfYV630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767491; c=relaxed/simple;
	bh=arXYzsOl1OkfcjkMtMDJ5cgQlgHX5faJ6mvfLb2jvRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNt0HbDuaqvv8ySS/SHrOdFQPM3cjBTbz2bW5KtOHsgvmrFFf/kg58G79hYDklZF1Jhe/S9YozoECFAMmJyEtPppb8CyPHYJ+5V94maMW6sAGl5nuSykt/cS/rfrhkLkPw81tXsm6zb3ubxrTAHZok8E5RBZiJqcHAgstJu4/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5lIjtaF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5lIjtaF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so15860315e9.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767488; x=1786372288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRYAshv6bCkW3StAMRtfaFS8SltMPequV+AOq12EztQ=;
        b=Z5lIjtaFUtk11Di+K4rJ6WBu0izPFWDpllTVnWYsoZj7PbzNhUWFWXp5lDUM+ONSLg
         lJ1Xe//gpXw3okce53z2Mp0C6lYW+18smRhgI+gXA0kO0n6ABlqi4awZfnyqJa0t5ZKU
         GURyeB5nVGoZuQHhnwjzlykpjXPbjRoHM4YIvyQfjyWWzssClxOfZgXKsiSi0ODi2R3g
         lU+85YZLwQiNVz6jK7HM0ClfXuEcUh52mLbJyTZtuxM/BKMOzTODHy3xzBLlIaDBQCA1
         LzqNjQhSfyxsU1xCrZsi1T8OO8/mv+WMucUZcuQKjkTInQAKSrDAdFrAMLOsvaLZZJfh
         0O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767488; x=1786372288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pRYAshv6bCkW3StAMRtfaFS8SltMPequV+AOq12EztQ=;
        b=LQY8EnKXLfjIXiQjbM9oef/6rTfWvsxUNI5Y/xphuDZHHXlUATvk6GO9GBse/73TFy
         UrSsXVvG56XJNbL8+DWlQN3WZmw12jVH3wghdCzTl/yaJpSGlPqib3pwHmrFAvgj/+q7
         /DvRkTF5kYvAWIhNlOZKHG6NyCEvKqcKHx9gV2n+WPDfuLX3kJbHQbY+82cFHg/A1RAS
         TFaQBEexCzFzHQba0nmJU7DsLPZkR4rERPrEod14FmeQJSaaWuUYgVWZtbPNyaoKXV8S
         6GDNdeS2BctenNMAivPT3fcWDmeeOTige0kr8BmgoAA14z8mZcRS0w3HN7s9aZSsvMtr
         e7OA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/hK45fljDpMa1bsdI5nipehwzVXmU/1CBXoYqhdqlWZ3X/BtW2lOv8VF7LKg9u+Bq02HppSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+1cHHWATsWfMWC8NxGS7jV06WXgiO729uDzIs9a3Ix2gnjku
	toLW6U+YM9///Y3kh8V2raY5fM4orcfT/VE/8EWplMTJG0gGwhrcKBoo
X-Gm-Gg: AR+sD10HXS+pQ5OGlO00a5KysN4S+8nZEJaGNplc2AGIYzxQN+stbOhxLDdhGWSOnTG
	1xeK+JoD4mIEI5DnAp9q/Rkgnn5tELZYLIZE3q5XWanZVibxeVOgiizdfOFbDrtf0fNdfQDIE07
	HKxtr9FD7ghj+eUo+I03gtP8QY4zqnd94jJJ4aRY+j81nPR8kvQo+Vil68Nd0Ecs/f4YG0my4/w
	n20/0TZOOwrXe8E93rYgkKvL+r3gSVi9rfNjKWnH9oX9ec2ZQAcSq2nv8pBbfASVhushuHY37+S
	48RitByLAS4MbRkRsvuWmZStLMQT2pxaHmReiu7vEGC6MST47IZLLZ1nSsUFjwQ9/dv/e17+9OH
	UvzpYdwtiCdyERm2Y0siJ068a5WbCB1/FZgqsnN0oJBeSWJg5qXto9BJT4a1SANvtLdGvEuRr8G
	TyI+eWGPR25IqQE9ePTvVlXQ8qiL7mzoERAcxEqRbLUTmeBCnI97wBAZkSlEwpWO6+ebnkGUH1v
	lp5RCCL6Aq3e6BhpUk0KbmR9lDHcVKYuW6MaJ4fhQ==
X-Received: by 2002:a05:600c:a42:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-4980eba0a6fmr208724155e9.8.1785767488101;
        Mon, 03 Aug 2026 07:31:28 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:27 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 12/13] platform/x86: hp-bioscfg: advance elem past consumed array elements in order-list-attributes
Date: Mon,  3 Aug 2026 19:30:35 +0500
Message-ID: <20260803143037.93105-13-meatuni001@gmail.com>
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

Same defect as the companion fix to enum-attributes.c in this series:
the PREREQUISITES case consumes "size" consecutive ACPI package
elements via elem + reqs, but the outer loop only advances "elem" by
one per iteration, causing the next iteration to misread a leftover
prerequisite entry as the next property and abort the parse with
-EIO on the resulting type mismatch.

Fix by advancing "elem" by (size - 1) after the loop.

Fixes: 4b2672ec71a3 ("platform/x86: hp-bioscfg: order-list-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 704c69c18146..6696255738ba 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -232,6 +232,8 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += size - 1;
 			break;
 
 		case SECURITY_LEVEL:
-- 
2.55.0

