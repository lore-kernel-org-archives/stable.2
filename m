Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839447;
	b=TFwF4RrzlMLv3M24p9Z632Mlp+Umd5xWFfeTgk5pKNH0/psQpVaYdsvmzMcRZLWTfPYr
	 UAwnfA/8MhVRL6zYZNvFOm+7LdH4c0KtXwzZ/zA+yeRBajeMP/KSHmqSd9Ne9kBXrPTzA
	 hgOXYbVUV8aPPnhW/5JYe5Hcrdmseqo2qZBfaR+5TGLeiI6ZIY1LraU6Oe7WF2y+OBzvC
	 7xG9iowMfiaX5topZqsQW0+qY+X8teuG+K55JRHTXapo6aRN1QBdWTLEYF3HjDFiZMQII
	 Sy2LaSZy1ohd9aTzSYpmWo5uhQNgllQUh3Vp4wcbRZeSdckmqgpknnsipv1Qck15obg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7CvZjphlLYyviRYRDAzTkF165UvtFroVZsLD8Snn5uo=;
	b=cVtx95NnZs4PERO9LPjafThiunZ/ipiq00kGr32jLJjiDDSIA0Klhh/pOPxt3q5uaThp
	 DRECfSd3MAvy9hNGoI09yLnv0jJVEukb7bco5ESXAKUuEkMHM/Xt1gab2Nlpej5K1JGEd
	 g52tMs8AjTVtm0i5wh8Cf8JGlOzjLbQeq3/FTkiZBSICJVHLw97Aq9p3wMM1R/D2GVj2K
	 oj/OjZWQBEo0zEgC+gdtAKZst72k82rwy9jxmlSDV79H8R9ai+pWU6V115hj+XAgvRkIz
	 XXW5GGFzcKsmN/p7GHHUO0L2pA8p83Bh70MYKshbaWyqkf4WH65qfQeq2rjjlTT0jXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iAqxQnp3;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519A606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3519A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iAqxQnp3
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2010307a91.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792839447; x=1793444247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CvZjphlLYyviRYRDAzTkF165UvtFroVZsLD8Snn5uo=;
        b=iAqxQnp3AQBKM1cGnvIzCGVwNnsmGET6EuG8ExmkDqmq47YbAMrsWNY16I6KlZ6jw+
         iQ6C14TlApJAsDeoBOFfsG1FoHW6/esAZcLJX9dd+YQ8o8MaYpDbJ4jukHj34vyJV6+y
         gcdwJe3yDze+D1oKSVgvPya23KgVj3VlfbLd1VTAoaLbV8jhDYsRPdxSqsc8WdMEVowq
         ve4Gxa1QP50MChxu/m1KIhADJ4Xi/BFK80Z3AKv453nDFkd+paU3X3CzYx+MW4+0kyIv
         KtE2xV+SCSimCpOB4Y1GR7LVOYyCyMLjUQNwWZwvceoriVPAC8KYBv9+tEyvRe10h81u
         9eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792839447; x=1793444247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CvZjphlLYyviRYRDAzTkF165UvtFroVZsLD8Snn5uo=;
        b=p7/6CUcZA+UR0SMTrXsV/FsGv8UO0q5Tj+8MOaR12w92apTkY6/2slRFtmP60cMfJy
         oKNnshv2y4kZZHJpDpU16XSmH2oKGK8uqNeeyzaMhqGBKlBHwPAJu5PsdWXqWVqxAi9w
         lgNF/+3jDSuzcUOgsBNRpRKYV2O6FyMXYoU0NXE9l46DEgV/XVj0y/KQjKHCJY7kf0je
         Y5CQOP79MiPa+P+2w3A95iqJqSOvUHJhHaBilvCqMVUpH4wZXgxSqg10X7Q4kWchgb5V
         9AI+ZTrmsUYosjuFsdV+VZjqJ/Sw62XPzjGTU6wgoYwc09ERSDEPKPQAtHu/q3fYSpVj
         WEWw==
X-Gm-Message-State: AFq9FYL0sutNIuYLN4ztGnfIfwHmq2TGbbBmqpsh3y0leHyvmp+NyU3t
	n7ozk9dGMYGweMexrgAUBb6/6L0vqdXrJuR/GVzNxcqy0D+9XD69e5UTdemT90XzF88=
X-Gm-Gg: AYBFou1WolFsTCix1tDka3H6UUDwEiFJAvL+mswj1nN7+OqzkFjVv9CHabVLFWRxClO
	a3ouNplGfP7KzlXpJMB34OY0tplfb1nrIFDJE061lwL+6HGtQlXSjJ2AVw/U/kgE9OQJIfghyHD
	P6VkxFlKQ8r72ms7dpWsmq19KQ63Y9VYmok/B1/IYq5+XUB+mF8ZQTZwJJcyxscErnpldm2b0Go
	roEwqAjR8pCKwNyP+LS/EnxT+BbDBenqnr+2qZNu7VT7ivgJP1+sV8vgSqYOX5umA71paS3Ql+a
	jOOYOAzNNhuV1PZAuVLWadf9rpCBOXJr6r4skZHcRLl/LdHmdZrrKhLKyJ7ynPjmCoEoKIFme7/
	VlIxl9NAYEZX5bwlTNvzoEutkBkBpbrZEf4TQDBknyeiw/9xBJ6hodbew+r8VU30xBAkSrcm6Ed
	ICzOdfr2cwa69O5jYDOVYltKIXyxFXYGZz4ZGB3W2vCKw9bL83wEv50B7UiWg/1z5sF4u93NPZF
	Wo48NCg38tzZoPcdv1lOsITtpR/FKESdvpPaE9FOAHidqgB+QCvNSCGpUAjpct0Zi8I7umfNrCr
	oLxJNdOjjWXkhgXLU8Y2rlu8dbqmZEO38NMozQZIlJfJIsj26GWWrBgaC8+HmmYaH1uNgvyDHqL
	/xfW8WcCaYKRjwXpazNmzHF9o2vf8U6sQfBDw4/TTYifDcFVcwVj3cjIQvHbe3Ofky7xQrD8yv7
	Et7GuUsoSAGWWn9FkocZ9XP1Rs4VIiLWhYN6er3dhssj2x9B8gCt6lw4LQ
X-Received: by 2002:a17:90b:4ad0:b0:3ab:d26b:c2e9 with SMTP id 98e67ed59e1d1-3adead26b38mr1613976a91.33.1792839446604;
        Sat, 24 Oct 2026 03:57:26 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm2565666a91.4.2026.10.24.03.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:57:26 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
	Wolfgang Walter <linux@stwm.de>,
	Bob Anderson <kernel@ametros.net>,
	Domenico Suppa <domenicosuppa@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Julien <julien82453@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.18.y 2/3] ACPI: scan: Avoid registering platform devices with resource overlaps
Date: Sat, 24 Oct 2026 18:57:09 +0800
Message-ID: <20261024105710.593-3-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024105710.593-1-ue081723@gmail.com>
References: <2026102308-twisting-bazooka-12b5@gregkh>
 <20261024105710.593-1-ue081723@gmail.com>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

commit f234fdaae1cad8c39265e7ca0a14633076ec7154 upstream.

If acpi_dev_get_resources() returns overlapping I/O or memory resources,
the subsequent registration of a platform device will fail with -EBUSY
due to a resource conflict.  This is reported to happen on Acer Aspire
ES1-572 [1].

Avoid that by adjusting resources returned by acpi_dev_get_resources()
to eliminate partial overlaps between them.

This has not been regarded as necessary before because putting
overlapping resources into the _CRS of one device is really pointless,
but now that the issue has been reported to actually happen in the
field, it needs to be done.

Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
Reported-by: Julien <julien82453@gmail.com>
Tested-by: Julien <julien82453@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ rjw: Tweaked the new message ]
Link: https://patch.msgid.link/12955541.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/acpi/acpi_platform.c | 39 ++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 52c8d602f..abdd8893e 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
@@ -71,6 +72,36 @@ static struct notifier_block acpi_platform_notifier = {
 	.notifier_call = acpi_platform_device_remove_notify,
 };
 
+static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
+						   struct resource *new_res,
+						   struct resource *resources,
+						   unsigned int count)
+{
+	unsigned int i;
+
+	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		return count;
+
+	for (i = 0; i < count; ) {
+		struct resource *res = &resources[i];
+
+		if (resource_type(new_res) != resource_type(res) ||
+		    !resource_union(new_res, res, new_res)) {
+			i++;
+			continue;
+		}
+
+		dev_info(&adev->dev, "%pR expanded due to overlap\n", new_res);
+		/*
+		 * Eliminate the previously processed resource that overlapped
+		 * with the new one because it is not necessary any more.
+		 */
+		memmove(res, res + 1, (--count - i) * sizeof(*res));
+	}
+
+	return count;
+}
+
 static void acpi_platform_fill_resource(struct acpi_device *adev,
 	const struct resource *src, struct resource *dest)
 {
@@ -151,10 +182,14 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 				return ERR_PTR(-ENOMEM);
 			}
 			count = 0;
-			list_for_each_entry(rentry, &resource_list, node)
+			list_for_each_entry(rentry, &resource_list, node) {
+				count = acpi_platform_adjust_resources(adev,
+								       rentry->res,
+								       resources,
+								       count);
 				acpi_platform_fill_resource(adev, rentry->res,
 							    &resources[count++]);
-
+			}
 			acpi_dev_free_resource_list(&resource_list);
 		}
 	}
-- 
2.53.0

