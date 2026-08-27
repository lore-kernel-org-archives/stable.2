Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99882DCF46
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868411; cv=none; b=ck5BH7ZYMtdpj2KBgM+BU1t9qoArA9BSKhMn3oV5rGCON8/9uMNuTpSyAscFL5KyKZ6ZYfELhHAO6oF7tWfdPZS3VfEROUrOuSd06Jy34bDgYbos9YAVjsEfLlwUQ2UnrA0OfjTE4fPDOiAb8PrUheWSX2+iUvLDwsbbHoPz860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868411; c=relaxed/simple;
	bh=iaHuxTL9GgUJZF86l4ALIIzy/p5FmBSH/AsEH222pSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jF1oLtJLJv+V5Ho+FrIUTKzl+FIkIIWLgAOd+jmytrfvVSWDuqtN5RVATpH40S0YuHOMTLSFxlnf6vkb/el06dp+ykai6gLFC4D7P7vJZEfPoQtenA1Ei5BCTz14E6bHWYofKgCrui0lBBuOOQaiXh23YrPU2Rb95BE93CS9758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0W+xDS/; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0W+xDS/"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so788960a91.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787868410; x=1788473210; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6GW+2Hhc2UcSsdCGhPp7Ouw0/2a2zcXh23hCHwGyqeA=;
        b=e0W+xDS/Np2tDy3zyJm9EVlLo58KFOT3yPU64sTUc2NOq+MudOuwy4dsnyIdTGNVQY
         XWNSmplb2pFe9xbyfV8tC2/f3tZTY10+zmf/dHr5VwI1VGdv5aIG1mK3Sa0kcfXfQMtI
         co3bn+b8swGeXelDpK1bUoBNY+0HjZmRkdUH6wBiO08aN4GcyEEucEKctq2RltyK5hie
         jHpzkG9xpvKdYCze1II93U/Fbc91GgsJ50Kt01YM/odZpMC5Oa1LtT+iywYiWYMNkWto
         +fjjJFUecNHiagp1gf5Q0LPsFkYSRpISSlZR0CSdXfBT3imQ6BAFzQqwJk1b/PDi09Rd
         RGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787868410; x=1788473210;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GW+2Hhc2UcSsdCGhPp7Ouw0/2a2zcXh23hCHwGyqeA=;
        b=amBUS8+TbkmASLEMqQtklsdGeoH4DPUwhcobuQOkkvG8qLcALTgTLEu36587r0M+QW
         aGyl0jXyQuG02Ue+nWkaEQP8F6aucKvwKwPQCCCiABsD6G/6uYM5EHyUctxgmJcgcJRb
         v/Dk44WqdeRcPflQK0iBqtaE+dZAMZJfhZhkO7eannOgOQhhTfAB1t5F1rY+que+un/R
         fcXbmXaoBYWGRcOgIyxCSoPxGjnOuz/R7k2/eFZ9VP/9bzJD/4Ob340FHNG72UmwlhSW
         Mz+u5oztaPfHU1EcH7l82+8BRbNn0jCv4uTANfOD3vEmdNyd0Yd3eABOMHvjuNeIF87P
         Cmpw==
X-Gm-Message-State: AFuF++mgxv5xJRWDJETUCkvXNQnR+/YuC+EDQaxEDpxTLURJ1PXqpNeC
	93jlvRqIU20t+EDwtaAvtlBPCjL+AhNRRWqjgOd/03swDJZkC/OeBvGX+Qd65MboMm7VIWIwhZw
	Gy7YXxvKUdpswkhrmguK4kKOV8Vsv7J/LMuFei5XrjkwerLwQW2SOQnm26G1+gBoJOdzuEVwzPw
	Ezktj50f/eLfy12JypYBptXYIjuEVO6MZzOsuT3MbQETKhBAw=
X-Received: from dybgj36.prod.google.com ([2002:a05:7301:124:b0:328:6c15:25c1])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d44d:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-396d0c15f3cmr4689966a91.0.1787868409462;
 Thu, 27 Aug 2026 15:06:49 -0700 (PDT)
Date: Thu, 27 Aug 2026 22:04:27 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827220428.2988999-1-cmllamas@google.com>
Subject: [PATCH 6.12.y] HID: uhid: convert to hid_safe_input_report()
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Carlos Llamas <cmllamas@google.com>, 
	Lee Jones <lee@kernel.org>, Jiri Kosina <jkosina@suse.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, 
	"open list:UHID USERSPACE HID IO DRIVER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

commit 63a694c51bf120a37550890b8e7736b4888985e9 upstream.

Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()"), added a check in hid_report_raw_event() to reject
reports if the received data size is smaller than expected. This was
intended to prevent OOB errors by no longer allowing zeroing-out of
shorter reports due to the lack of buffer size information.

However, this leads to regressions in hid_report_raw_event(), where
shorter than expected reports are rejected, even though their buffers
are sufficiently large to be zero-padded.

To solve this issue, Benjamin introduced a safer alternative in commit
206342541fc8 ("HID: core: introduce hid_safe_input_report()"), which
forwards the buffer size and allows hid_report_raw_event() to safely
zero-pad the data.

Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
the buffer size. This prevents the reported regressions [1], allowing
hid core to zero-pad the shorter reports safely as expected.

Cc: stable@vger.kernel.org
Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/hid/uhid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 21a70420151e..d16667207b9f 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -606,8 +606,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
-			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
-- 
2.55.0.897.gb25b4bd76c-goog

