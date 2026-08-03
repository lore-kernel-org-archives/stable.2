Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680240EBA9
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767472; cv=none; b=j1SA1oQZw6RaRxpJsPWus0LlZ23q/IFPmiXtCjuPmIJCW7NeL4ge946s23Vu8i1ojjCsGGVdUyCAlMBv7Nn2gqZo9V5sSsFGdCcJcnsQCoOzVhVOAEAWWDv0IdCnvwdhev9vKaYNjFsQ+eiwHHzZmalvlgE8hjTYfMJunIxs3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767472; c=relaxed/simple;
	bh=9EehTMGdJoM/pmPAG9mZtREZbrypCyCVR7Mvq/DwalQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYOJjCFE3jBmzg9iYVIdnVft3EAH+yguRsLDbW9vH8D8WgkKyL4LbqSmNFnVz5/HBlTP6vyyIRdesjADTHjAzqLAv+u8bM9sbbk9Ap2prRZ3Dd+b/T3/UkpxxYVdQvFfDAGuOWuPat14PwILGIUJ6PBbsDdOWq9DYZxwlwp90vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j57ld/vk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j57ld/vk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso14083885e9.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767468; x=1786372268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+s/eo+/pWpLLFnoufPaOpVfgTjc+a46l3h08Co/MXY=;
        b=j57ld/vkaa2fmuH3Yi1q5RQ/SjAtSvZQAuhOZekAqC+zoqQeXCzpLSh/lfSLPmVSn2
         9+hs5OcdIIZ04ZsczuuqgKkZJ4A3FjsmBOVhjZpCeNVDxbhLWxp5GYw0i62t9i5gugjf
         BJwpFcKJvSctA2OCXysPKi5KL7cz3NfC5dfS1Hl5ED1dEkEvhRtwEariEKt19nlP8Iwo
         JN9Mznz7z6KSnG5rzqFNe67svlelMGa3o2IJ1DMUGPGGc+QoABWQ40c4UqA2CB/WxKvW
         U+bbZW+lcJvSdKKBkQvHDqyrfV4EzEXlAO1mMZOe1b4o5otHzZjuX8jbl1MRX/d7psqC
         JDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767468; x=1786372268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+s/eo+/pWpLLFnoufPaOpVfgTjc+a46l3h08Co/MXY=;
        b=rWy8tX4N4ydytvx6t8OrYOWnjVqnZJ7+lq5sDVPZ0nem+1OGcgE5ijXJl/6La0hVmS
         JTOC4FTqvrFTlOVSDhJ55+VasGInp6TW+K7FaUMoCJgQvmp1X8EEHgbk5yPOzLAUMsir
         aFOK056kSkJ9x1NAfeP8dL67s6XLnNMB41hwtbWLMHZmh3iPhL/p+gdh4tbiw3bDaime
         omwrvwlYVyf4QL1INgNlinQJxbPAdFp+VZ/yJqqOolxMGXBysZBfNI4xSaKB1uN/JL61
         P9gmRGc4obq97DUH1426TK0RP1ySUQanST6wsEs+NCp8nBqvAvT/JrpegGB1u3uCHbN0
         r17A==
X-Forwarded-Encrypted: i=1; AHgh+RrsgjS4KGkZjfBbTJShQAowBWWQNOzQlwK/LqrC/St/FIn5AKIFtuQfnUCdZh8xJN72HQDkUWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqDUnzlGz0l+HaZ5WJr2w9RxIR7CIVV5DoRx2KRNSTrDAlqYM
	T974Ximev3Wi54OOC+2C42vlZKUCIJ8euXgk/oTx1/N4yIVhwrwgZL1B
X-Gm-Gg: AR+sD11VrWLIStT3izSTbWj92S522ONZBaiqPacQ1Dh8B5bYrqH1Sm8mcPqqm3BLlTC
	/EUraFjLP5FzNPLuiKOpk40k8LRCuiy8HAC8WNZ4bzGk8kr6bEAyJM4TZHGmzwXDkJH+kyoCzZ1
	JIdla34kQaulqfpKXdwR2Rk92a/3z6Z2RmCBWC7BCVzgHOP0fmCPhRF33d8tBBY4xmQYIKST3cc
	wH+ztTkBkMqbs7GBRnyC53wkMtQkIhKBPiUdEEwALfIUQdbKbxmq8mGyMkdMlZvmDwTo1L0LxPc
	C+1x8HbyhsFqKh/Jr3GScW1evK94pSFzqpDjouTjIaZYQipub28W9wOmxlMXQrUUj2DcU/TFbxo
	aG0asqivzxqxoCLDKpnN14/1EddvijOM5iqy07ZuMadEfbequEr026yEi2c3SUitr/gAGFTZSWL
	HWbexDWF3GGijEHZMIw2ZsjZl9VHdbrbVathHEeBG9a6i3tcunPAi9d1mTqTonhz43FOPEDrchW
	JCqOPifaeeS24hjHepJIdhShvjZkwBiwHrEYolWHUs=
X-Received: by 2002:a05:600c:5395:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4980c66c751mr293605105e9.4.1785767463425;
        Mon, 03 Aug 2026 07:31:03 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:02 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 05/13] platform/x86: hp-bioscfg: fix off-by-one heap OOB write in audit_log_entries_show
Date: Mon,  3 Aug 2026 19:30:28 +0500
Message-ID: <20260803143037.93105-6-meatuni001@gmail.com>
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

The per-iteration guard in audit_log_entries_show() is:

	if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE)
		break;
	...
	memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
	buf += LOG_ENTRY_SIZE;

At i == 256 (PAGE_SIZE / LOG_ENTRY_SIZE), LOG_ENTRY_SIZE * i equals
PAGE_SIZE exactly, which is not ">" PAGE_SIZE, so the loop does not
break and instead writes another LOG_ENTRY_SIZE (16) bytes starting at
offset 4096 of the page-sized sysfs output buffer, one entry past its
end.

This needs the BIOS to report more than 256 audit log entries, which
already exceeds this driver's own documented LOG_MAX_ENTRIES of 254,
so it requires a non-compliant or corrupted firmware value rather than
the roughly 85 million entries an unrelated integer-overflow read of
this code might suggest.

Fix by checking the bound against the offset the write is about to
reach, (i + 1), instead of the offset already written.

Fixes: 63e8f906e94e ("platform/x86: hp-bioscfg: surestart-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
index b57e42f29282..6b63fdb84606 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
@@ -90,7 +90,7 @@ static ssize_t audit_log_entries_show(struct kobject *kobj,
 					   HPWMI_SURESTART,
 					   audit_log_buffer, 1, 128);
 
-		if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE) {
+		if (ret < 0 || (LOG_ENTRY_SIZE * (i + 1)) > PAGE_SIZE) {
 			/*
 			 * Encountered a failure while reading
 			 * individual logs. Only a partial list of
-- 
2.55.0

