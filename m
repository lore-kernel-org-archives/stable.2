Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D53F44CE
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652786; cv=none; b=mnBIr/E6IWk/W0xpLcknfBsN+wj6Jr5vxSxt4h0d6qTofsg+0x6sb+Afjzjefg9NiAU46FNwKkBbIQ0dqF2tetn/z+8nBT79P++l92oNl+PrstZWgI0Zl4+jzPPGEA6AJZsQaY5X8MbOLosBV9caX5Qgc54uUDggA4lA8+6FzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652786; c=relaxed/simple;
	bh=RAGFgUE/hL9ns4Dc9Yzxf5XGA2OGySAH7T6FTytqKYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUuiUVBo+zkhEGqFql15eOAUVpaoGplKN3zfJ4dHaknT72OD0s4HOPYafZO62146ZGGfu3EvTKN4fzD/171NZIgG9H8sRIt5q+ADjVif8i5E+8jQMSmdgkHhYyPoD8rFq2YaK3jA6p0s6+d1+xI9B32ALethDYkeYFpdFuvR+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfoYJ12h; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfoYJ12h"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so232499a91.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787652783; x=1788257583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=okcv3TiKdUkjHH/2Q47/3TclBNSBZ0LXy94OPqvg5Lg=;
        b=LfoYJ12h9Lbj4GtcLPEKRC37EUTWUFOGtsvoJXaOXKSc95SDraOnVnhqW2x66ZMf/0
         iQ0GZnI1PctpJ3tofW53ifNircHQw5nvoi9AXucg+5BjTntOawpOwtKR+93GdWnW5JiX
         GW9Uv+stfB/+VINoUtLxI3pvU1Iqq/SmVWmgVza5BbO/YLmcIMNXD/BMr+aIWSu7a9qD
         Mr6Kzgx+d3eAbI6vCeO6ja2vjuwJNNm/Z9RhseFZZcM0Zb5W0T7xQTuUEktiwySDBkYW
         vNvKUXaVcMnY/uxpVlMLKM+1tSKFsSTen7Vce6R1g0kFf9U77DwBoZrQRLo2vVCvcnEd
         ZfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652783; x=1788257583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okcv3TiKdUkjHH/2Q47/3TclBNSBZ0LXy94OPqvg5Lg=;
        b=GbqVJybkHXqxZAg8qlerNDHcsAvn+7o1RNLCQHOcJLtvqg4RVtFdm4t5ZxgroqLRmB
         hgQ2sA+WkH0wq+BXOhJDlMK17NgxA+4GR3CsXDlCQfNmmuQcB3HhFKPqhF7Kgo3uj4pX
         /ComC4MHrZYXF/gUgEh2ZrPaTUdgqFhuEHL48Gn3G8gR549kimieczE8thMX9eORqrWQ
         CwjpcYsH7en95pVK5/7MfhBV9LrIrTiCPNIf6ZOq9AT3mFchN/yRLXsKtt+5YtVj0XP0
         MgGXud88s5YPWWt+MFOCSpi4v6pyUf9vpKooQLifrTVA93C9p6Qt8FwX1X+M8dthQD1x
         jb0g==
X-Forwarded-Encrypted: i=1; AHgh+RqeDGpIaZzJQ7m7yu+n7uaOgILcv2y1ryuN8F1y1gmdwnNkAfufQe5tN6NqXcrcUM9V1rbwYc8=@vger.kernel.org
X-Gm-Message-State: AFuF++mQMRCKBPUIFt6exl5/Z2UrbuGvC5sksKRBHpSqokQ+9UXtbrot
	GfaKs0MmBjEWyjLcH9AoZzehyKI17Kfby2h6jFgsygojdTulo9CJp5py
X-Gm-Gg: AR+sD1338yirhg9xnbdvwDdSrOD1jtlR5wVQAgv0V34j0DxE1NqCpbOM8rUnr/7nLW6
	AlFOLQS3vdOLRL9XJES80BKe6p6riSI2rZ7y2pYRggEUeomCdzOuCErGrvh9ehuELyDLBHpK+uM
	zMMcGh4MGNBee3fpr4qEEOceY79YhuFoLp79eduvHFWItFoTToax3WD6D3BunxzU3NuroQCKAB7
	8Jxe5QlxH+AgHlMBLb5soa/lVfV0S2Vd2ODRcuVPp92xGdqLqiwWUUzTuR0MQX81kc6eF2cQd0Z
	CiX7nAVuT5drpgLadmaEjZWfmV472vg9j6+OWVYqw9XaU6pdjSY1ZFKNbURV06RdeHL4139aPtl
	Vf7ULF2Yu7Eok2iJzFvcFZWcSUHhoEAuzgrEMPgkUxYTRPRORz3Kf34L0ff9o3cLcBQ/nPS7GUf
	vrBwPatCiQeNMEPVJhlSoL1CDAuQTUSWT3NHYtFxIxJMCEf0z2KTfZaFyKm1OF63yafedHTvJUK
	3CTsBQisesW5K+urVPGiHd8f2658W88OSecaZNCCw==
X-Received: by 2002:a17:90b:5112:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-395df3cf1c8mr48525381a91.10.1787652782947;
        Tue, 25 Aug 2026 03:13:02 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209f51sm57715424eec.22.2026.08.25.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:13:01 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()
Date: Tue, 25 Aug 2026 15:12:10 +0500
Message-ID: <20260825101210.47782-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_wmi_perform_query() evaluates an ACPI WMI method and expects a
struct bios_return header in the returned buffer. However, it only
checks that the ACPI object type is ACPI_TYPE_BUFFER without verifying
that obj->buffer.length is at least sizeof(*bios_return) (8 bytes).

If the firmware or ACPI method returns a buffer shorter than 8 bytes:
1. bios_return->return_code at offset 4 reads out of bounds from the
   allocated ACPI buffer slab.
2. If return_code evaluates to 0 and outsize is non-zero,
   (int)(obj->buffer.length - sizeof(*bios_return)) evaluates to a
   negative integer (e.g. -8 for a 0-length buffer).
   actual_outsize is set to this negative value and passed to
   memcpy(buffer, ..., actual_outsize), where the signed negative value
   is cast to size_t (e.g. 0xfffffffffffffff8), attempting to copy ~18
   Exabytes and triggering an immediate kernel crash.
   Additionally, memset(buffer + actual_outsize, ...) performs an
   out-of-bounds write before buffer.

Fix this by ensuring obj->buffer.length is at least sizeof(*bios_return)
before accessing the return code, and compute actual_outsize safely
using min_t(u32, ...).

Fixes: c3021ea1beee ("hp-wmi: allow setting input and output buffer sizes separately")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8ba286ed8721..f3cab841afc4 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -616,8 +616,9 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 		goto out_free;
 	}
 
-	if (obj->type != ACPI_TYPE_BUFFER) {
-		pr_warn("query 0x%x returned an invalid object 0x%x\n", query, ret);
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*bios_return)) {
+		pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -636,7 +637,7 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 	if (!outsize)
 		goto out_free;
 
-	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
+	actual_outsize = min_t(u32, outsize, obj->buffer.length - sizeof(*bios_return));
 	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
 	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
 
-- 
2.55.0

