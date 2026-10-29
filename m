Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272116;
	b=rzQDd9V7bHPI85A4wUBrT5pNzKJryzfqH2Tu34sdyDH77N4bNRgiUFiQHyXTsqXOnxZp
	 FNnqj5WhgKALihWIHAGrpFaIfBVIWZ3S7wtGbSIONkK56S3fVPaD6qkzPWDcfPLOHYho0
	 jTtkCY8OHg+ARcZN6pCtPcJiSaLAjCLz+5Kvo9PHAmbE+IDBeU2mnMXfsuEl+OxmZP2AI
	 iJDUs3QkvD4O6swAWLhBPNtPZnQg/B6mXzfMUSW6Foa+XUNRFYC0UrPovvxgm74LIiKmH
	 Bk3KCY2nAaQ859j4nVT9RS0qFA71ogyFFR1ND/R+0seOGUB711PGdin8FLACEv+89mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D5Bct6ORVWbKd1PZDSJ4YkoXvIXlK7X6xeDbDKwtWiM=;
	b=BXcQahAufYbsdgTh+z6aGyzn9Bo5A4PWaR50YLSLWILabXRRdDv/U18VToh0WONUiph3
	 sxS7DpinFQM5qBgBp4PDNwNSXNTMzPzPA0jF0W4ErI8PG2TkdZnlJ/InGzwObUd5np2M4
	 IWrWYNodCCnAhyX/PYWtCPrJiwq/ZuWcRyC3SmAvEtiLJkaOg/cPpjXyrxBBT9hXch9rK
	 kJ0fudY4L760U/DzDzDqBIsA7ANXt9HiaJ/UldpZXWCKo8KSSeok8tDvZ9b/uV6m2s7xk
	 XMqaD+0xKNyMyswaQxDqPB2c+S8LEkZhXfPF/YL6V9vySvbD6XqFt0i7vhKan9GLq/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVU2S9f4;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7F606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E7F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVU2S9f4
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1547996f8f.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272114; x=1793876914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D5Bct6ORVWbKd1PZDSJ4YkoXvIXlK7X6xeDbDKwtWiM=;
        b=XVU2S9f4VIweHZFAxkuAGLpNrTAFXPJAh2+1+VWl9ZWl8azMfLX2uYKK6FnTAgKgNU
         XHTURhdfP0iNlwhm/9j2ZN3nvw8+EpkJBXs1PdlkkuqhzD1yc5n+4of+Hm9H5DGv7BNF
         8WXhfPc0FGrFAy9hkSMv5u6dk5p1shiQ3smIYRNMOhnFwdQRLOFTQN8pi0TNB0VH5eGu
         0tjPxztmUzoQUvei+WoCv4p6sjg6UtWsHiwFymX2uo7T0wd+jRGc4fYWTed/Hu3/QaNS
         g/17ZcspeDY6jHg+o1++iSKLmx7XWnrLHIJHh3m7rnb83Vio0bYWpCJKdI6S+ELOg9vU
         zJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272114; x=1793876914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D5Bct6ORVWbKd1PZDSJ4YkoXvIXlK7X6xeDbDKwtWiM=;
        b=0ByN2ubhKFSBcFIdBwGEp1XtUClDnlQQvqX7dEWm/lhUKl93VN9dvvrnU4dBfh4wH7
         H3uEY2v78vlbsK8GEqAm1zqwGiJavNB1aLBGSy7l/78gATdJLcpdbGvA745yMKhfu384
         qCcEbN9lEZLl20HLtyWkR6fs7OXyF8BRd/gC6T40Tech+Cdiz9UYAYcLXtV/PQ6YUVqB
         AZ2KXijLEFcKp4Z1rJytPYiJQ7MQvl2LDsV2squlX7Mjwpr6rZQSEiXAHsoLEM71XPUZ
         pv78YpSxmUDbBuXbNeYuI+mvSWlrNedH9is5zCAl1Q7yXo286ofcRVfqw/iA/AX39tGk
         ap3A==
X-Forwarded-Encrypted: i=1; AKwUvByWOiAj3Qt5Rl2CVdpUTwQjxM450YVuQ/xDULC8TVLrlvFvA70icFJDC5oXAKb/PAWDovrfzRA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhjDJPdDf3f4zgywOiAjERWWVhQXNhCu/6di56wdSauf5p7Mf7
	Eh4f2DjwXXetvmJ2UlRSCrCeSkivK3HFxfvcsHMknlp8UFoSQmmJCeI=
X-Gm-Gg: AYBFou2k5VMnLX5qCGLIZhhEvq6NO5tZGoURZiGnScZLs5z6UUipMbS4g1B05KXtiwS
	FcwFB4Rxe+6K8IUH5o9cMtlH0Cbk4JRuhtd9KQ6nO8kU+Duh8kZB573qGbUUvk2EcYOEWlE/zp1
	EMWmg/ou400co+aHjFWGMO0WgG3/CPRl+9a5fTwWheMQMBa1/9GJxq5CItFkqlHEt997APX2VcX
	Sn9fJUgC1Yg8k6z/gPNfdZweV07CtdNF37KmjPY7zCbCLxyF33b2t1Khp+q7pDWxIEtYeTF/U/V
	mtbt+xxaCSvZ8G9tv5t2zGlu05QLjL9qzvTMsqP9w/TAQ8QoHmdUr/4MGsQZeH63bmUG7lQdCkS
	/Keks5uNQBCallKf/y/mXtQPaJb6jS+1kx8/WoOVwL9m2QkRIhIiJh3C1e5BohAjTyOQgoCN6/M
	OZCXR4RDyyZX6UVLiDFLMQ1VE+ajGMf0Rw1y6abizYOv3GeHl3vBeDhDzWkAIkWzNM1TCX1KwVs
	rneazwX317gRPE3ey/ZerFK6M0X0ETfF4VWuWaeYg22tcBoDdkCHShN2u5+vnPEvGxktjNIjA==
X-Received: by 2002:a05:6000:40de:b0:48b:e50:714e with SMTP id ffacd0b85a97d-48e5d308159mr11719738f8f.36.1793272114213;
        Thu, 29 Oct 2026 04:08:34 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33716448f8f.54.2026.10.29.04.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:08:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/2] iio: light: cm32181: validate ACPI object type in cm32181_acpi_get_cpm()
Date: Thu, 29 Oct 2026 11:08:28 +0000
Message-ID: <20261029110829.1086835-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026142040.62383-1-tristmd@gmail.com>
References: <20261029110829.1086835-1-tristmd@gmail.com>
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

cm32181_acpi_get_cpm() accesses cpm->package.count and
cpm->package.elements without checking that the returned ACPI object
is of type ACPI_TYPE_PACKAGE.  If firmware returns a different type,
the package union members alias onto unrelated data.

Use acpi_evaluate_object_typed() to request an ACPI_TYPE_PACKAGE
directly, so the ACPI core validates the type before returning.
Also replace kfree() with ACPI_FREE() for the ACPI-allocated buffer.

Fixes: d34ca613b939 ("iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/light/cm32181.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 9df85b3999fa8..a16fc83bcbb08 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -115,7 +115,8 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 	if (!handle)
 		return -ENODEV;
 
-	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
+	status = acpi_evaluate_object_typed(handle, obj_name, NULL,
+					    &buffer, ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status)) {
 		dev_err(dev, "object %s not found\n", obj_name);
 		return -ENODEV;
@@ -132,7 +133,7 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 		values[i] = elem->integer.value;
 	}
 
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return count;
 }
-- 
2.47.3

