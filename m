Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643511;
	b=mmX8v9Pc/Yw6le4JXl6ccsZeipUBGt1kdNPQvazKw9Bn0Lkxa71ZU9UvBRw45+jmvVtv
	 v8/Ia8jHVcyngrajBB+gra/owYYmTvGcWH6eZcbKZxNssmdGe/GHEfrVC6EGC6jx8n3iv
	 fvh543EBb1sK0ENbZ3q9V9xSzcdqmZ7pEuw+k1lVURm0vHhUgR4KcE3zEa7P8U6O/4M8+
	 3L3dtGBbd8PuccT2mOyk+6DxrBYURRt0w03VXEk1mqvDOjAZTGfwg18oQTSKB32Wd3U+O
	 XzbIcgIS47be5xqfFIxmntPhQ1fCQ2AeHV2yzvExX6mZv2wuSZDPmGWq/gVXrGkw5iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NHRs95xsQgjnwOuFrugRmWxAc9XLLQLwb+OYmfFck/4=;
	b=p2wQo0kdaGUj8Vw77FxlyWBfjDuXliuCgd0FjbsGO7eUrKvKC9Xds9+jjkhiyn7R9Ze2
	 fZoGKtYykxCvy6AcbUB+yar1pb5gUAbwJb5w+XIVAIuTEatZ01DzhiGSkY98LjZApK+Ju
	 zKek/g6pyBtD6SQPLIHklVtM97zeeISk0TgVND0lRy5/9k3JxR2aYF6VooSqVmffKXave
	 c1iqvrCjqyepsV4L1pI3qtCwAdkDKoA5QizExbnzji1qzCspEt6lxFX8oKvyXQmJaqvyi
	 P8HMaCH6XlI1LiORqe8OW9XfZ1f5wTWxiH7WoGvguPU4yN653hqWRkGFhR6tSDS7xSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNcbP4a3;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EE606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 18:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 153EE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNcbP4a3
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so2570175f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643509; x=1794248309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHRs95xsQgjnwOuFrugRmWxAc9XLLQLwb+OYmfFck/4=;
        b=BNcbP4a3nURPwGReohMJlcBk7a+a/QqJYDJigkMRVyIu0fGjRRoEhJMwq/Id8ORSVy
         cuB198sVread6+W+jQ5TzCWxhFtJyV+DI50GNK2tk2WzojkKwvynA2v+0Kby0Py3Hl7S
         OXq1ci1nHxaX+emvJAan4BUEQOxPMv8xlLxdiT7dJRJ/awtbLOlGWv+i28diy5ePqwUn
         pGPdpeiJkkLof9X+5xiIZR8LndVMPlD9VFWDVh/iC7cMWuSKWqtk2usG86ld7PrXMLkY
         24CvM2zC3D4PvnYVmvaznI2ziS+kR8vehsO6akIBvV3pWM6OnY6bcYZErkjDgkZ5wRDN
         wl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643509; x=1794248309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHRs95xsQgjnwOuFrugRmWxAc9XLLQLwb+OYmfFck/4=;
        b=W78PoOOZPieVEWNOADm5waDA8VZKML0QQ85M8gLRhdG0dY06HSRFCwmACtXmA7rawr
         j+29g0f3CQSZo83XE/QX0LZdlmtEMBCZ8a5xIjYAPndMrEAfl95T2cjmDrjAB+tOwDUR
         ibrDxwhioUxYZykiu7aLJfsAuVNZesyK7SRXJ67qBQilZg16LF4weXgFWCAaS0nsujBe
         nXraCw2ICK5H3742IiShOMqliNgLFEgLLvJFr//ZydLPCjAa4X1sdjQQ368d/7nPEmeC
         5I2Bwh0f4GFRBC4liU73S3ciF6LvHtLO665yRMAK0iBRsNZk+E+oPq44ytXUbdN3jBEG
         Y/LQ==
X-Forwarded-Encrypted: i=1; AKwUvBy11QWKUjoprBNffelCodm8SiWLtb6lN3aE7q5N9w+e2OtmS/fx6S3enKpj/QhQMvp8VyJTdPk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8An4vMr3TIunFnZdHZRq1+/54hRdR00xTQftb/ALlQFC8x6MFt
	eP5kQnQd/YrnDYSO4nzRUjY5rn0Jy+M1FY+3vxdafJEyqSMJJ8e7gLU=
X-Gm-Gg: AYBFou0ljHd3SACpNVwAUBEDULhBbjdYWg1qrY+05lxEsPehEOs4J/5ndWk4UHmeGMK
	AwlKW2Rucue1f+pOfNNPr+20EWWfwighxL5ZER3fE+1Pg+YAxnEZdN4YCW/FT++E4N2lFm6NoaH
	r0Ohgtg40dntFK/O9L+AG74UFNlcXhHohqS2ZFR0GCmEYXq5WtWVSYG02B7AfMSigPkr/zXK0j8
	8+rJ65jbet1kB8Xr1J6tdpRU+r0bMyzwkbNNxwetLUTezhJnxTOi5U31CbDe+Zp8YzkQmmKWBRt
	jQyXBv/mKB+1G8crSS7Lo9m0CN4Rf4TzbmisHOLco3uwSWqp89gBVa1EX60DSmwZej7v/2rwXFw
	DWmaUZElSW817JYkaLqmjccOCJZvkCF2lW6yYvNi9VDvSrX7BfJ259HzoIy+gIsYTllzRcOD5tU
	kPuZ3w6fhjUHvqBBL32DSz1qCirpvjUXF+WtRy5G/SqMk1lE5hxT5jlzIs88hYQKUidiI7GlWO7
	2hVYnX/8c62skgrd1QBotlQ2fKQ0v4V/xfGMpZ0jnPXc1yy3PTOmdCtgCAq+SyxJKPKcJJlzO9H
	iTZdbGT7V08=
X-Received: by 2002:a5d:5e8c:0:b0:48e:5c9b:f12c with SMTP id ffacd0b85a97d-48e6e2d4c32mr27465476f8f.16.1793643509167;
        Mon, 02 Nov 2026 10:18:29 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71baa1b3sm20326986f8f.56.2026.11.02.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:18:28 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Azael Avalos <coproscefalo@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] platform/x86: toshiba_acpi: validate ACPI object type in tci_raw()
Date: Mon,  2 Nov 2026 18:18:27 +0000
Message-ID: <20261102181827.1989460-1-tristan@talencesecurity.com>
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

tci_raw() calls acpi_evaluate_object() and uses the returned buffer as
an ACPI_TYPE_PACKAGE without checking its type field. If the ACPI method
returns a different object type, accessing package.count and
package.elements interprets whatever data the union holds as a package
descriptor.

Add a type check before accessing the package fields. Return AE_TYPE
when the result is not a package, when the package has more elements
than TCI_WORDS, or when any element is not an ACPI_TYPE_INTEGER.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/platform/x86/toshiba_acpi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index a0b8060836d01..4ccc8f51c3a5b 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -342,9 +342,20 @@ static acpi_status tci_raw(struct toshiba_acpi_dev *dev,
 	status = acpi_evaluate_object(dev->acpi_dev->handle,
 				      (char *)dev->method_hci, &params,
 				      &results);
-	if ((status == AE_OK) && (out_objs->package.count <= TCI_WORDS)) {
-		for (i = 0; i < out_objs->package.count; ++i)
-			out[i] = out_objs->package.elements[i].integer.value;
+	if (status == AE_OK) {
+		if (out_objs->type == ACPI_TYPE_PACKAGE &&
+		    out_objs->package.count <= TCI_WORDS) {
+			for (i = 0; i < out_objs->package.count; ++i) {
+				if (out_objs->package.elements[i].type !=
+				    ACPI_TYPE_INTEGER) {
+					status = AE_TYPE;
+					break;
+				}
+				out[i] = out_objs->package.elements[i].integer.value;
+			}
+		} else {
+			status = AE_TYPE;
+		}
 	}
 
 	return status;
-- 
2.47.3

