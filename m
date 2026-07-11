Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960CA35AC1C
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755008; cv=none; b=ULy8e9119EO2vxqDVY3yv4aG+J96/Gi3OLZdh2OOwdUmdNgBAgn4L4huMRcqEUJzlPjKYAWe0Oa9wMfkyEgS5jZ4A2p/5jqMtIVeFXUN33kJTO8l4ZZwNxV+T7NNMCg+B3JjRHAHZSzbZrlo9mbkNZRB8NteoXlRVB6PRVZW43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755008; c=relaxed/simple;
	bh=ONCM/qwJ65daRbnhqLGAZvYZ1WYvjKpu2vGnwR1npUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcTjUYkME6i/2VxQ1sB5FTOvPLAz0s8Amw7X2Hi4LvCAyuxfGCQykHeInTZVFEE3c6W0TwDyZqBUvt9Y5dyTSan6VZYCtjQIlC2XP+4GQZh/X+zUq3W55Lnuv8fVYQvaXKNSdtbpAPWgL74UEftqmMJE4Y6yq5JTqnu4XsRfu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=zDXw+EF3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="zDXw+EF3"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so802218f8f.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783755005; x=1784359805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DP53W7dpzs/umsEmsxnzKCtbgmdsd+rN/OYPGxdQpZM=;
        b=zDXw+EF3xFaEQLbZRIRD6JTX0sUrPe5gsFNrb77rHDH6ODC/a7t/aKS4I5iKi0YLJH
         90EjBCoRtg16TCWrDHokxuTVAjYRz5fp/VBixlAJm9KFtalPEXdO8oiAi4Y/RCEF7X9X
         R6yPbiGf4HCUTglFbtcZf5B9L2xESzKnzfHRtfO+GGxk2MCDqaUqXFN4jU6nBDIyn/Yw
         n/tXPuyMcMFjb7XhbNC703quYyTW3KD2qHO67FIOXx/tb7BLN5JPf/vytbItNkKfagxK
         uHgtqj73FR/0XwVH2qeyENyu+2ciCr+/WoJratjMaGWWNkNQFYnbggmIa7/0FLzYoZtI
         /hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783755005; x=1784359805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DP53W7dpzs/umsEmsxnzKCtbgmdsd+rN/OYPGxdQpZM=;
        b=JwXVIwmMga1RiJhDCQXgI6ajV/BSqLgq/2sIxPyDjVGX1azfGmDxhi9AKe97POSq7A
         CzsELANSPM5NeWCpu6WQ/FtJZ9oRKQNhV2EkZIVoI4lWkefFj3fq0k2eEuetDSvuwrUw
         +39fAEJBlObUGzIE3C4GCTF7prsjPspPPB66kn9fUBb3WdT030eWDc7bYRkRInTZF7B1
         b9EkxTt0kYNvStzRea4p+sKxcZApT/1ZzinWK2gCGkCIS9W8PAjFeTCDqAJFqmutr+jA
         onQWtaCaYLhdI4CZMtvgkGs9+9YDW6oRCksefIrc3j3tQ6ZOjO4GPqX+LPL5GMnC4ghD
         ncSg==
X-Forwarded-Encrypted: i=1; AHgh+Ron59dNIof6YPY4FuMMPi2kqTrOYcFHtlAGfS+upUJqZ5mVoWjBA5PaTb8xhy5g2gmh8L3qIdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+zcyGsSjCLqZaK1Tilefbk+EmCLGvLnx0ZnzXc9JAQC/cice
	rjbCS3TQ2csO76Bo0kFCnpMESqzpTU1mBiQqu6ID3MnkNP14BVqrweyrq2HQZM9t823ccxOtK1C
	Fsgu7gd79
X-Gm-Gg: AfdE7clCi0NHk5CPj/onyFlSWY5039LZaTAuC17WXYW1AK+o8ysmNfSbBCZnn8SS+UM
	9UX451uMcLxJSKIaltjQ3MBx4mQmDjNjNCkY3jRDH6rddlcNIcMUCge7sIekGZiaTXA27tA1DwT
	4uNFDXgyYnpCIOxq/rZhFYTP8URJaB5eKHIpxv5kxXWNKdinnpugMWNebfwMdXNvbD6akXMfamh
	4Roej4De7SSANZsriAYIYNiq+P2yFNY7+UfulB7ptR0NcNygHB8dnDckJ1b5/HeEhhagbM07KBZ
	Rxlxo5K6NgmWSjsn1XPMMxoBZOC12qghO8sSA28omHDKK4gHsTchZ4pbiuZrv4sVqTjEoSgv3G7
	RPabAnuwvlwcKxH0OER8282ujdm70AUsP1YOg2uf8If3KdBj/QcWXUYPhiHqWWLz91zY+bcSBpS
	eceMoZPGWn1/WTMBfYfC7iZORwyt+1bn9btz/fT0hq8yLTMTNa/i7RrUBk5mlrnTmV2Ybp31mVD
	Pi4/V9vFxz8v3WJ1QaNAA8wCqCx9/NNMcs=
X-Received: by 2002:a05:6000:184d:b0:474:3708:c8 with SMTP id ffacd0b85a97d-47f2dcc0d79mr1873968f8f.15.1783755005049;
        Sat, 11 Jul 2026 00:30:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm67152622f8f.15.2026.07.11.00.30.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:30:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: spbnick@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] HID: uclogic: fix UAF on inrange_timer at driver unbind
Date: Sat, 11 Jul 2026 09:30:03 +0200
Message-ID: <20260711073003.71012-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uclogic_remove() drained the in-range emulation timer before calling
hid_hw_stop():

	timer_delete_sync(&drvdata->inrange_timer);
	hid_hw_stop(hdev);

The timer is re-armed from uclogic_raw_event_pen() with a 100 ms
timeout on every pen-in-range report via mod_timer(), and its callback
uclogic_inrange_timeout() dereferences drvdata to deliver a synthetic
BTN_TOOL_PEN release.

drvdata is allocated with devm_kzalloc(), so the HID core devm cleanup
frees it once uclogic_remove() returns. Because the timer is drained
before hid_hw_stop(), a pen report still completing inside
hid_hw_stop() can reach uclogic_raw_event_pen() and re-arm the timer
after the drain. devm then frees drvdata and the re-armed timer fires
on freed memory, a UAF read in uclogic_inrange_timeout(). This is a
disconnect race (USB unplug or rmmod).

Fix by mirroring the letsketch fix: call hid_hw_stop() first, which
synchronously kills the URBs that deliver raw_event(), so once it
returns no path can re-arm the timer. timer_shutdown_sync() then
drains any in-flight callback and permanently disables further
mod_timer() calls.

Found by 0sec (https://0sec.ai) using automated source analysis, as an
incomplete-fix twin of commit 46c8beeccd8a ("HID: letsketch: fix UAF on
inrange_timer at driver unbind"); not runtime-reproduced.

Fixes: 01309e29eb95 ("HID: uclogic: Support in-range reporting emulation")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/hid/hid-uclogic-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b73f09d26688..c440013a609f 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -548,8 +548,8 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
+	timer_shutdown_sync(&drvdata->inrange_timer);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);
 }
-- 
2.43.0

