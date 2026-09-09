Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2F313531
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965616; cv=none; b=Q/XajPqq6g48BpYTVgJnsdgDzSi3VC/TPpBqoZgOh7/IrHn8CLph5p/lBDrpYTSQOXEGpPUh+9zSLzwY236hkVxurw+Aoq628HnMYPJ9Qzo5LZYax2f5PT2KyJYM171Lf1pxsKHRQqfPoX2pWUn1ba41gQdST+i37t77Z/l2mK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965616; c=relaxed/simple;
	bh=P0dv7ZgLLLxKvwZ8Ow6mespyF/CzK4a1CuYfs9SscMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/m9lBN/KUpTBk/UhjjnrjgFcewrYpksEhpwk5LUWWjrT1yEyxVYkPd5n5LZuKIlj1RMgtWwo+pm7jXf0LcZ0mGsn7kOP7FSUTpjvSPA1PhvFXHHAwqQe8qTgIJ6t6CftZmzgrGfoTP205EGQLsu3Iy2NVvfg4KG/vioJ/4G5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3cUEqtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3cUEqtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824491F00A3E;
	Wed,  9 Sep 2026 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965615;
	bh=8VviPkyMinJ+3RNKAzYaPf0XsEuJ7LjsGtD88PAGt5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3cUEqtOIF6Trd0PK2bKlCTYHzyx1517qSTs5+dvSRcu/MvZC1O0VQH5sLx80W/Vx
	 E3VlZGT+Rij6g2c8wzvLhM1x7WokeG89FPL0mwgb1j0Q0fc3In3w8NngWDSwasQvUG
	 BNA/S0NHsQx4JUjFDBly5Ery0zgBNJA9nASj8SOd8gGIlbWcERm7bCbzKEcsVs/uty
	 aDa1kQtYdR1mV2Bw8+lZB55lLX/7fUZijhvV+thS7r4DpjkqgM3Yc3aEydV5qc8fNw
	 omZx6s7DuIRxgpYE0jAdxXLReeV/2a9QKlserUJA2Z+y7rjhpb2Hcd5TgKNrI7/fjB
	 2ZqckJ7LK1RyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] PCI/sysfs: Rely on lengths from scnprintf(), dsm_label_utf16s_to_utf8s()
Date: Wed,  9 Sep 2026 10:53:30 -0400
Message-ID: <20260909145332.2696721-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-freeness-pelvis-28aa@gregkh>
References: <2026090357-freeness-pelvis-28aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Krzysztof Wilczyński <kw@linux.com>

[ Upstream commit 316ae33051215f92c72fe13bc1bfc4e513a26700 ]

scnprintf() returns the number of bytes written into the buffer.  Change
dsm_label_utf16s_to_utf8s() to do the same.  Rely on those values instead
of using strlen() to compute the buffer length.

No functional change intended.

[bhelgaas: reorder patch in series, len++ to include newline added by
dsm_label_utf16s_to_utf8s(), commit log]
Link: https://lore.kernel.org/r/20210603000112.703037-3-kw@linux.com
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Stable-dep-of: dcc5bec09e23 ("PCI: Allow per function PCI slots to fix slot reset on s390")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-label.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 6c406453b49f4..a24d28414f3a2 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -154,14 +154,17 @@ enum acpi_attr_enum {
 	ACPI_ATTR_INDEX_SHOW,
 };
 
-static void dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
+static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
 {
 	int len;
+
 	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
 			      obj->buffer.length,
 			      UTF16_LITTLE_ENDIAN,
 			      buf, PAGE_SIZE - 1);
-	buf[len] = '\n';
+	buf[len++] = '\n';
+
+	return len;
 }
 
 static int dsm_get_label(struct device *dev, char *buf,
@@ -169,7 +172,7 @@ static int dsm_get_label(struct device *dev, char *buf,
 {
 	acpi_handle handle;
 	union acpi_object *obj, *tmp;
-	int len = -1;
+	int len = 0;
 
 	handle = ACPI_HANDLE(dev);
 	if (!handle)
@@ -191,20 +194,19 @@ static int dsm_get_label(struct device *dev, char *buf,
 		 * this entry must return a null string.
 		 */
 		if (attr == ACPI_ATTR_INDEX_SHOW) {
-			scnprintf(buf, PAGE_SIZE, "%llu\n", tmp->integer.value);
+			len = scnprintf(buf, PAGE_SIZE, "%llu\n", tmp->integer.value);
 		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
 			if (tmp[1].type == ACPI_TYPE_STRING)
-				scnprintf(buf, PAGE_SIZE, "%s\n",
+				len = scnprintf(buf, PAGE_SIZE, "%s\n",
 					  tmp[1].string.pointer);
 			else if (tmp[1].type == ACPI_TYPE_BUFFER)
-				dsm_label_utf16s_to_utf8s(tmp + 1, buf);
+				len = dsm_label_utf16s_to_utf8s(tmp + 1, buf);
 		}
-		len = strlen(buf) > 0 ? strlen(buf) : -1;
 	}
 
 	ACPI_FREE(obj);
 
-	return len;
+	return len > 0 ? len : -1;
 }
 
 static bool device_has_dsm(struct device *dev)
-- 
2.53.0

