Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22B3FFFA7
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784694194; cv=none; b=B0jZD5Th8bjJUXYD7AZFMYiPsyl1xpRktwPOorxmKjou34Mn9iad/s0xG0S0r1aMAUIABIm1NGc7tzGhqAQTLGyvrAX7I1Mj30DcPMAin/sK9xIqBNKHg2/Y2vwqxGxWLVll+Gh/ZZry1OWJ3K4izllMuGH1jBuBO14j01j61ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784694194; c=relaxed/simple;
	bh=Tz8ATHq3AOH0oiRHBDlB0/d5Gvc7fJ2Zya9H84QVcgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSwgcGEvm3h8R16hhKdIv0xf7z1Aty2vnVVhQhSEL8wS6Hwo+rzd3JE5gWccSiVCJIoHBKiT0GFM1NWYw5BPQrXv2cKbcYunww8e8Cn02VUySOxTYyHhRv4vivtWZMw9IjHiPa+6Sq43xuR1uAgH8LOGAKEpymUR8sCqvAGVYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihNe+z1K; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihNe+z1K"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6688dfaed31so611241d50.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 21:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784694190; x=1785298990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVU1uXONejBx60ngAbjZKU1diMFaAoxWI34xUNLIr4k=;
        b=ihNe+z1KC2yBiwU3FjLI/+98w/HV6PAZD20uzxDED9jQMebOvhGSzIsVORh9BF8E06
         GgpEsTZJHCjEYtUpnYYx10uegl60U+eIJXY+6hq37Mx43UjYmT/BjAwflyBDu+pU2tRI
         +UtTeqRVKkdZr25Nsp9qG3iykGa6BPCZ5YKn/C064wSqowy8U+mUM23ZxehQFLWuT787
         kbSxAg97zGa5NquU1MKriElfow4s64ZTjaALLI7yVMyAlu4fJ7b2al5+FvMt6bwowL4u
         J9EywylXAcXQUWQh3fQGnWAurboc+oKHzudvbsWlGAP2ZtnoWqdQgnI9NWTALp9WWBME
         /6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784694190; x=1785298990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVU1uXONejBx60ngAbjZKU1diMFaAoxWI34xUNLIr4k=;
        b=Lh+nXUryozb70oTizBZUXEl7l4e10rdwsiTXxM05XSYnzJ86vZAefubdC5sdCmNO/w
         Nci3syRVQMMutXstR3VCmfTCj0yuFCzlgbyCjFSKqiSfZeoa4NJwFpvPyo3zzu/1kkQ+
         B8vQmYHJdQWQDQg8fpWTWVCPYdUDR/IHrOxXxzSVhUzlt2mJroT1FM4I87ntvWGTaE0W
         Om9hYvqdOK/w6wPp5dO4oTNLvciCHNV/37FmxrJB3YXD5iVQ+nyGouKpMlKsD9zlK5E1
         EgXMp9EGE+DCxCUelOK+0pCBzxNrg+la8E0L03D0QPFPNrEOuTjPrhTfckL2vy1sDG30
         Huow==
X-Forwarded-Encrypted: i=1; AHgh+Rp3g5ILq18lQ42UVx8nOK8xHnWLlUL8PMMB/8h2CJAIgpep+QATWz6HZRvaBkfNZK30o2hZgZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFT0XV3r9VpP4FLhQTRgBzI2mg8hiS02vsBCe0w+Pp6S5vIhwl
	zyF8Qz0OmvpSqHvO2GO+GqCeLdMnJJSE8t6XGlqw9QtPH3pojWyZy/gg
X-Gm-Gg: AR+sD10Lb0RwVxHIFC9+WnGHe9A0CRJaHk8GDOl1fp1L4+Y5wclcmfDJ55dwGR3gnMd
	wSxsN4FSMQVdtoPWEUKl0f1+HDSCOpi57ElE+ae3t2yohDmo/6I4vPeWIc9dv7Pxd5ObVQWJbuU
	twUr4yueIqWLysqXMRxCazu0ItPdmzBRHdEeTKE9Z29py28niqPnhka6qvGv7wZWkPoSwG+4oqo
	kvrLmOxZOZze9LCPKHzm3A8ELfu4+Lfhf/5mqLGzMWCONrth7xCpeaGHR0D+bfimILsI5LzR3Vp
	+Ia6TNT9JbT9m3PoA5+s3Zm1W/k0qMTYQ1n1a1rTVFYx/aom/imnS817+362DdAblNTpu7j8ery
	z7E1bn6jbpf3DFqmI7dE8DCUVQgfWh8efiUt1e3lAQ9VGn0C29yrXFQwFlJNIfw77KEoxwIhyF8
	kJPp4lX8a1njmDNOHRzgsTT5H3152zSMeGhJ5xvD6tBUwlN/UaP6ajmyndR40cuav2Vevij6fMu
	c0evZOWtx0hbw==
X-Received: by 2002:a53:d057:0:10b0:667:8b90:2eeb with SMTP id 956f58d0204a3-6683bdb71c2mr4845726d50.102.1784694190034;
        Tue, 21 Jul 2026 21:23:10 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668906d9344sm695500d50.12.2026.07.21.21.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:23:09 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] media: v4l2-event: limit number of event subscriptions per file handle
Date: Wed, 22 Jul 2026 00:23:08 -0400
Message-ID: <20260722042308.75939-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_event_subscribe() allows an unbounded number of event subscriptions
per file handle. Since the subscription id field is fully user-controlled
(32-bit), an unprivileged user with access to a V4L2 device node can
create up to 2^32 distinct subscriptions, each pinning a kernel
allocation (~200 bytes). This can exhaust kernel memory, causing an OOM
condition and kernel panic.

An unprivileged local user can trigger this by issuing repeated
VIDIOC_SUBSCRIBE_EVENT ioctls with incrementing id values. The allocated
objects reside in kernel slab (not accounted to the process cgroup), so
existing memory limits (ulimit, memcg) do not prevent this. Most V4L2
drivers are affected because the framework function v4l2_event_subscribe()
enforces no limit, such as uvcvideo (USB webcams) and the vicodec test
driver used to reproduce this issue. This leads to:

  Kernel panic - not syncing: Out of memory: compulsory panic_on_oom
   is enabled

Fix by adding a per-filehandle subscription counter and capping it at 256.

Fixes: 6e239399e580 ("[media] v4l2-ctrls: add control events")
Cc: stable@vger.kernel.org
Reported-by: Autonomous Code Security <AutonomousCodeSecurity@microsoft.com>
Link: https://lore.kernel.org/all/20260722004818.72310-1-blbllhy@gmail.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2:
 - Add Cc: stable@vger.kernel.org
 - Add Link: to v1
 - Wrap long line in commit message

 drivers/media/v4l2-core/v4l2-event.c | 14 +++++++++++++-
 include/media/v4l2-fh.h              |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index 9dd2aaa95a67..fcd8ce4addc1 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -18,6 +18,9 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 
+/* Per-filehandle limit on the number of event subscriptions. */
+#define V4L2_MAX_EVENT_SUBSCRIPTIONS	256
+
 static unsigned int sev_pos(const struct v4l2_subscribed_event *sev, unsigned int idx)
 {
 	idx += sev->first;
@@ -218,6 +221,7 @@ static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
 		fh->navailable--;
 	}
 	list_del(&sev->list);
+	fh->nsubscribed--;
 }
 
 int v4l2_event_subscribe(struct v4l2_fh *fh,
@@ -251,8 +255,16 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 
 	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
 	found_ev = v4l2_event_subscribed(fh, sub->type, sub->id);
-	if (!found_ev)
+	if (!found_ev) {
+		if (fh->nsubscribed >= V4L2_MAX_EVENT_SUBSCRIPTIONS) {
+			spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+			kvfree(sev);
+			mutex_unlock(&fh->subscribe_lock);
+			return -ENOSPC;
+		}
 		list_add(&sev->list, &fh->subscribed);
+		fh->nsubscribed++;
+	}
 	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
 
 	if (found_ev) {
diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
index aad4b3689d7e..65a7f31af889 100644
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -33,6 +33,7 @@ struct v4l2_ctrl_handler;
  * @subscribe_lock: serialise changes to the subscribed list; guarantee that
  *		    the add and del event callbacks are orderly called
  * @subscribed: list of subscribed events
+ * @nsubscribed: number of subscribed events at @subscribed list
  * @available: list of events waiting to be dequeued
  * @navailable: number of available events at @available list
  * @sequence: event sequence number
@@ -49,6 +50,7 @@ struct v4l2_fh {
 	wait_queue_head_t	wait;
 	struct mutex		subscribe_lock;
 	struct list_head	subscribed;
+	unsigned int		nsubscribed;
 	struct list_head	available;
 	unsigned int		navailable;
 	u32			sequence;
-- 
2.53.0

