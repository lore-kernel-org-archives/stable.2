Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785569;
	b=za2xeTtj8cQdUIkLeivs9ALzNfKTyoXUKqRVC4GYEd700ND24bG5md/HC0I7S7kJpgWM
	 3Y9ZpHj6VIH8+bTz8jvBzgcNwKncziGhkDBgaeujzvvPC/tgbvgappJHgvLsm1yjUnS1Z
	 mw+jJyPHnGwyFQ39vCRd2oarmT9bCnpMURhjeZXFHArodJ2GsfFmKGlXKZgYcuT1Nc4nv
	 R5xf0HaPzXTScetSPC0eu0C//jC1pkIXSubtG8A28F8Ue5OPfPxo8RN0rrpKX7FWXuDUi
	 0yS+MEs/hRw7fFbCjDLXRJj/SvrcmSkQGdk9SBeEj3MJtbTIHETlnepocfn4v6q3sVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dubg1gFlwLFjUntHBfFzK7AT4OWC46obGwplwmSB/ss=;
	b=ZAymGbPemwH+j+lGXV1GiPrdDe5c1BsBnXdKNjna3cugpfrBnYQopn4/olcljTLUaGbC
	 +RclNtkJrgqNAy3HM0VLSkoQxyIEG3pMuQ4drj+YTqXlqs2pc9f3KtKXf70Fg7+vNHvJt
	 lwGj2ljAxxsI0XgU/gJjTv+bzsu8Vj17m7OdDBSDet4Qjvli1vsaup3QPw3T7+ExBhNPK
	 UmenelrI+8SJPVtX/cr6xJhS1JMjR01Fxm3VZs8Y1Q7UK8MmiRM1nFKILlFNqhlwSlw/W
	 zYFRDoV0/ZFJX3Y7w1UY0pm5KQPsRMe8tmyw3/A1zzAxXip2rkCdCqsT5p2AQE0PqIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="E2/f3yHA";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F17606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25F17606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2/f3yHA
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso11524405e9.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785567; x=1793390367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dubg1gFlwLFjUntHBfFzK7AT4OWC46obGwplwmSB/ss=;
        b=E2/f3yHAM6m0IbyoviLEbfad9IrNmtVeBbDh6YA1AxtThOvKYLp8ovQ5q8wwtGi60O
         BgXsxLo1t+gu8XptqE8IfuyLV6chhKRqTa5D+suRtQS3lUHnRZArbgkuHy4rAktdR0au
         KbCYy8GlDgZUpojaCEZl484mrGDwZcibJ0L2XiUihgTW599oDMBmdWZ7yTHcpFnAlRAE
         BTwHS3OM3xolyVEfLZ/49Efzxnb75j6pRcm2q/BA2bRsTviSYElRky4f4xBs3EwRHZyG
         LSk9+lUwt8WZF0RawHk9i1RMEgkkj03W7UTzUPndV3o9Qnxupsj2h340WS1OMYwtBkU+
         ve4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785567; x=1793390367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dubg1gFlwLFjUntHBfFzK7AT4OWC46obGwplwmSB/ss=;
        b=Sort1EiwU+FwZiPAq/DWNxfyxb+s91ypXEljtJbxwObVoRddc6eIuqMjf73xK23QST
         ec3fp1ff2PRjLBQ5rH/lryKGv2vkDl/gsA0LJj9tVDi+IfttbRK77mnB1f3krQ+xpry9
         rkKTZEQ6GNqJySUkW/KS0VCeHy0uitQ38dO+rduHGcirLYSi7YYMwe7mk6kXT8mtJkCo
         ocahMjkTu6tKstzMYTgwqyA1ofhcVgC6+Rt5HrUYuTIZMlhyMyqMqALQ9ZTkMggl63cs
         YdgQMn2Y42ZLryIHCM0hojdwE+1gbN0DwERvZ9Bhec8VK1ScsvhSL1C4RMQftmLoX2YO
         Cz/g==
X-Forwarded-Encrypted: i=1; AKwUvBybFiM8DTTruPvFUgoZw27fAS9oVkbZ8Kv1xFyQgPFFdsgKh9EMrL729GmRgJIyB5VmSSz7kXo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuAx2SEwXVHbOg9WBHOSJOdG4n6WrJTxGDHJ+SSwVhNkHufJUp
	3zNkZFaTTQ04jP7eXyyMgGq/aUCKWXf/qleM9D6q3aHFRqU32woKx/k=
X-Gm-Gg: AYBFou3lvFQRncY7Hoptany8V5BpKg5Cx5EcbmLDLv1WeLC2edGV9WBX+xO6Ob506XD
	IaxWmYHIPxD7EG7JCAIUa+pWIZvz0aLETzw18LAulYlcRpXXnFkovov+OHcMr8Qm+hCMi12ngzv
	n9EPUxXjSqQbMmkbarU0leQpChEQx03orAGVppsfkPWtYhOneg2lhCK9JgLYfVCPXNaxR7SGNyz
	BIsgW0ZOVm9D06yLth1Vx3p3DZZq+pZuliIPysrJwPwrBRrCj0stkE/nMllTndugoayhoN6zirf
	dDjWHvyOCWpkTXNU5r4sQDo4/ZS26G/XwHYC3asLA9Wg6Cz+Me631EF8IRmLh/I1RBiNHR/NKKe
	1oPOGls46x434SLShYmO0ATt8OiQK5sqYVf3Fzpknt58NQw97sbfYxInJArjscnwP/6NhR1Fcj2
	qPzJrX8UbTwzy304WMtglxaKQVuCv+GiNgXnGR0x8fm0I9rMD4DktJVx/YgvAmfkruqsbYwEFyo
	IewT5cfbQg9hef9AL5IICb4N5gXOlUCHID1WKQHwVcZ4Q==
X-Received: by 2002:a05:600c:a00b:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a211c9c5cdmr49065325e9.7.1792785567419;
        Fri, 23 Oct 2026 12:59:27 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bac37sm5688475e9.6.2026.10.23.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:59:25 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: "Lee, Chun-Yi" <jlee@suse.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Matthew Garrett <mjg@redhat.com>,
	Marek Vasut <marex@denx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] platform/x86: acer-wmi: validate ACPI object type in acer_gsensor_event()
Date: Fri, 23 Oct 2026 19:59:25 +0000
Message-ID: <20261023195925.3559887-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

acer_gsensor_event() accesses the ACPI evaluation result as a package
without first verifying the object type.  If the firmware returns a
non-package type, the code reads package.count and package.elements
from the wrong union member, which can cause a NULL pointer
dereference or read from an invalid address.

Add a type check for ACPI_TYPE_PACKAGE before accessing the package
fields, and validate that each element is ACPI_TYPE_INTEGER before
reading integer.value.

Fixes: 1eb3fe1d3b6b ("ACER: Add support for accelerometer sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/platform/x86/acer-wmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 61ae622c93d94..72b44f02a992f 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2043,7 +2043,12 @@ static int acer_gsensor_event(void)
 	if (ACPI_FAILURE(status))
 		return -1;
 
-	if (out_obj->package.count != 4)
+	if (out_obj->type != ACPI_TYPE_PACKAGE || out_obj->package.count != 4)
+		return -1;
+
+	if (out_obj->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[2].type != ACPI_TYPE_INTEGER)
 		return -1;
 
 	input_report_abs(acer_wmi_accel_dev, ABS_X,
-- 
2.47.3

