Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93ED3BD62E
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740240; cv=none; b=rbpY3hnas9BcdPLgMACbJenphu4TTPqLJUPNoFQ38hDdE/Y7APSOMBnbycOAHelN/pDhFg7AaVi5jcd8bMWBYIqKVNP+XOdYNwqLd3JbeaMBdxIT4h7LaykvcvCwrI6bHe3/iuhjrYbBTliOwMyny/SrIiJ3UHQyTosgM5nZuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740240; c=relaxed/simple;
	bh=nmanUXENTYAWhJcrZe5nnCdfVN8VqAFDHENUPTMv+nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7wSmN1O6zCUqATjRno7TRSmPG6cGUA3M16YMZ8cgTVOe9rFY21URV1jnh5S1dauAJYRBRD8BGDfP6+Rx3XtThvhVXUwxWb5bAU4nX8UsJaJfeoWL/N4O7vKXk8iFSQ9rH1blN6f8zlFjWnNddtIwwDoM4vYoxS2VAkp8P/Y7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpoPN8+6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpoPN8+6"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so513883a12.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787740238; x=1788345038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTwczG03AOy3mBcQRAusH2eukvjICUjX1lQZk3L+S68=;
        b=OpoPN8+62oXfJZl20WXoSgC/eJu7Dlot0p27AYL5pC38nmxOdYVD7c+0IqE8iHVloN
         Lo8bqBqepJhI1qcgdbCaEPHZVSJYkzMZuWRoLuCuvIDZm18W/2v/japf5yg9uW1QMEaZ
         08A53TuOI+aifFdq0EwaqAXfIb/5vkmrJ3U8JnSso1epcyqARdJJwPYrSeWZe2qnq5IL
         lcKA+DNnLqLotBsW0tqSG7zQc3e1b6YH+TzLh3+9po/i8/HWS7VUGd75CkG3dbEFJn2l
         DO3NQ7sNoEBslwyJFgDSC5On1pYSs2TWK+X0vjEzTGTsglAtb0ukfn9KusC8ltJofVoZ
         tmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740238; x=1788345038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTwczG03AOy3mBcQRAusH2eukvjICUjX1lQZk3L+S68=;
        b=ICw+sziJ0+sS0WJSFwU4wxiP6luosnFCKuWcrscWK2FNdvHLDL3i2zfWmSSMC/nCLc
         ZJ3CDJRdM6oDpOCcG05jasehSoQh3U+/DwuqLPK0WJqpAzjU4pNkC/GRlKNKAizj53EP
         zzriqfss/FUedVG1cjXGt6McpTuKNNG7PqDEWyJAL8r7kfUKDsAN184GJ0Wm78BqmaQI
         au00zr1LweWGBLI4ul/+sVQjhkKiz23sFny5DhzI9vzDDeRXkNJtorgSiopQibKfP6MY
         9lpxavs6wTAr5sI6Ng+qZUgO2dkEN0xmqFf22YvgSy/n7R+f0/D3HbOZ5s8sY73fQeEg
         tUDg==
X-Forwarded-Encrypted: i=1; AHgh+RpBGoD6oM6JXjsGjdbm2Th236UCYcNCDVzacKsRuIO2pE+GehJQ7nNbx+PC4rQZjWcz6h3noB0=@vger.kernel.org
X-Gm-Message-State: AFuF++noQaXAD3uKVkGUyXs7f9tIjIugDi9Y/f85ULyvzH/e+BXhZ1w1
	a6wQa4UftVXDCInccNcuppUpS6XwwCPTyJjoeDIBexesMWcdqtc4baoA
X-Gm-Gg: AR+sD11TcKHMLxL1g4f2a6+LS2lLZxDduDNT55kfm8CsGiou9j8wKCyfzMxiE0VkMSb
	IPgLM0uzb5f/WSTgHzBeh2gF5eGYgelzAv22toruvpkqj9a9+l/5IZ0scWa1x4/iiixcCX78X3a
	NxiB3oS+yhhEngvVqEH4lxYkPc3+H0hLqmGRPvEXvsAORLSPVRqIMcGESjw6wwJcy53DEb0L0E1
	qX0d2atJoZS+I8dFfJcNpUJNM9a8DUm/MKau4wm1+zeiMK82RQVRPU5htPaDbmYgCjLTE8XxL91
	AjiwjudpQILlWaI8PaVy3wjMco2XBc/nHlUB2gLTEnvcBxssVdamCtaS6PELcMP8kRQEGQ/my0J
	KucfAqqNn2QuvNQZHTH90o7aA64JeM7VJg7yCNgl2bv7BE8AP9WI2+trrQooQxQGCC3tEPe3oeD
	+sFwpCogZoQ2RHWe7vK1fpgD0CgULq0LLwYaKzzcWa8xb28jRaXjNvquaDmbUKk84EYr5xIHOpg
	TjrqIBO1/x5iYJih9Pr86s+UrlssOK89EjvqAHa1g==
X-Received: by 2002:a05:6a21:6b0a:b0:3b3:d0f:7883 with SMTP id adf61e73a8af0-3cf762853b2mr12031072637.7.1787740237439;
        Wed, 26 Aug 2026 03:30:37 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8dc465sm7267468eec.24.2026.08.26.03.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:30:36 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()
Date: Wed, 26 Aug 2026 15:30:12 +0500
Message-ID: <20260826103012.240453-1-meatuni001@gmail.com>
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
   negative integer (e.g. -8 for a 0-length buffer). actual_outsize is
   set to this negative value and passed to memcpy(buffer, ...,
   actual_outsize), where the signed negative value is cast to
   size_t (e.g. 0xfffffffffffffff8), attempting to copy ~18 Exabytes
   and triggering an immediate kernel crash. Additionally,
   memset(buffer + actual_outsize, ...) performs an out-of-bounds
   write before buffer.

Fix this by ensuring obj->buffer.length is at least sizeof(*bios_return)
before accessing the return code, and compute actual_outsize safely
using min_t(u32, ...), which is sound specifically because the guard
above already rules out obj->buffer.length being smaller than
sizeof(*bios_return) by the time that subtraction runs.

Fixes: c3021ea1beee ("hp-wmi: allow setting input and output buffer sizes separately")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
v2: Rebased onto current platform-drivers-x86.git 'fixes' (confirmed
    matching current mainline, blob b2773fc1aca414792b99406315496a2c3a64dd06).
    v1 was diffed against a stale local copy of hp-wmi.c that predated
    a batch of unrelated upstream changes (GPU MUX switch support, new
    OMEN/Victus board IDs), so its hunks no longer applied. The fix
    itself is unchanged, only the base and line numbers moved. Also
    correcting the recipient list: Hans de Goede's address is
    hdegoede@redhat.com, not hansg@kernel.org as v1 had it.

 drivers/platform/x86/hp/hp-wmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index b2773fc..d7ad206 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -691,8 +691,9 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
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
@@ -711,7 +712,7 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 	if (!outsize)
 		goto out_free;
 
-	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
+	actual_outsize = min_t(u32, outsize, obj->buffer.length - sizeof(*bios_return));
 	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
 	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
 
-- 
2.55.0

