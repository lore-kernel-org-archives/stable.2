Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD841B8CE
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419017; cv=none; b=i8Xx8G4vj+oRHmmhg2v0rwGGSTg2ssqCLh2SnpyH9JUUTs5LYoURB30zCIjPZ7UEIG3o5Rp85GpA8cpUPuBmgE8N/JFWju0VAMQKQnUP/BFlZVk86DsvaAgxw4N0OCedMq31VS4WYXntDe2FyE2OyBuSeEvi7a0G3NxiGcMDHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419017; c=relaxed/simple;
	bh=ICU4Cuyi6ytS/C4R22lJlFCUuo3uGHTm+woWo/XXcS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4cTTALCiopz09xUKgRAo0I1MzdUgQWdciC9zpGj6fNlkgyNpzfpGGpI7sJrrW/fF68arBUF3uxNE2uI7uGbzVp1uXdrhQYeWLYHfhCKwatNHzx6y4EnY3wMj7o813Ba7PzHvQf2E7ED/N2pTzT14wu+qbWSvp0OH5we2INLFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myIpUrHs; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myIpUrHs"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664a5193741so303026d50.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419014; x=1786023814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5magtKCCWYCyBY9UsWRVwfIoO8WQamQTvR+dMBS3YI=;
        b=myIpUrHsYWw/2Snt6z5XHorCEs3hbHOnRAF560re03cOJ5ce4K2pXYmr5uK6EfAEsT
         MSVTj6IdsNVBaUkD6J0RKzcHazt8J1SuzTO07hjC7j4R9oN2EfvPrXF5wBetuOPYKM+u
         YlvsRc8pv/VSCzy3rwXuz9S9kTCPqVtI/GFrxPiQkkc8Sn0IJoC4mnOSgQINE23AGpJC
         kCQufftdcRawOfnsdaH6MoNi2+1O5cXOlQCT+D+8qL6i5tJflaBUG7IqjkoWw8t7oi4S
         aTrGePL0yv8TPtmNI3PHE03P2Bps0VCuF4MYkKzX1FBlqeqVNSZQRLcv70DUlf1/ZJhS
         GmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419014; x=1786023814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5magtKCCWYCyBY9UsWRVwfIoO8WQamQTvR+dMBS3YI=;
        b=hC5fV/KiZnEc202cDisWl47ymZvbt0xmP6MPLZH8tAm/gDG00AuKir6klfxSnum+uc
         eSs5OyDyYRiTE8kVUarvvXUAQr+cD5Njvj5IETn2X7hQz0N3qxxzerviKqkCXx0KNH04
         OWEC7CwLYc8vMrdkGZ8odyodDGWWVQRakl98fdBfryFXDGgk90AqB7hMDWwkrkEE1Jfx
         9i2DjdtGI+WS8WRmnZCpKxVcLFqDhNYsrqmv00CPlsDk2mHsb+5k5Miw0xj2afInBZDg
         np5ApiodGopuGdCgW/AFisrod+9JEGuHQfJd8rVI0gWmuWOzz0qim8aahw/ncu41HnAN
         rQyw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6tTZTVNWcO4iqJnAJUqxaoB66kUW+lOH4u2N6tW7OXDQVWxV+RFiXremDkezSM0fU1WpVpSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDcd2rLIJfuM35tLnhkOu/wy06ly9MU00TOcELIii+W34Ppse
	m1TDH7zGJAU9fQERiKir9OunW3BETRvkGMb+kBTQsgOH74PqP5QMlh5S
X-Gm-Gg: AR+sD13vZn+61P05Cr/ZMt8DnSY9HOq5OT9bVUFsGaPvl7soiwCZ661A9ZRMPAGowp/
	zCc9Bi4B72ZFPlP/JsjkMZKTx3ys7aB8pWiHbswn1yUcNMKaGqPpaQZbaF1bxpwu3OnIars5eUj
	9RBiiI2l9UAtJKaZIc6owBRXeO0Z6eFdSboU03TU4PgakH/bDWfnQNTAasF2oAROK5Ze/RKfQgZ
	A5JAqIL0d8c+9NaooFwm4Z1SobTr/9yInlKB8iP+bZHywYiyzOCKP6cxfxcoGVS51BuxC5meN09
	MBG+jjXqpPtQbHqlzCoCcchlge/mfN32eZLl/a5OdXpzd4/16dukV+PweMlxNLLgl31RSR1f7lC
	FqaUPDRI7NhFdYgdjazes/BmEZEOxzlKZKhw4jBQdWPVW05Q/lYcaZyh9XtPbEJ/CC2ZcIRswMH
	PLYA1EYGOeI1Uwo15ACadQY362v/bq9E0cBWtGU2QPDMmNO2O3CeXZNs62w/cx9C7ufAeWipFvm
	5bZxKEiz28FVJ+NBXpbwIQ4IfSUsFpRfaYlP4Iz0/Rq5hMC5garXcM=
X-Received: by 2002:a05:690e:804:10b0:667:9a45:f7b2 with SMTP id 956f58d0204a3-6693a2f8f7bmr319263d50.1.1785419014230;
        Thu, 30 Jul 2026 06:43:34 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c74a27asm1273343d50.8.2026.07.30.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:43:33 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fanotify: fix use-after-free of file range info
Date: Thu, 30 Jul 2026 21:43:16 +0800
Message-ID: <20260730134316.2085087-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsnotify_pre_content() builds its file_range on the triggering task's
stack. fanotify_alloc_perm_event() saves a pointer to range.pos in the
heap-allocated permission event so copy_range_info_to_user() can report
the offset later.

The event reader can set the event state to FAN_EVENT_REPORTED and then
sleep while preparing the file descriptor. If a signal interrupts the
triggering task at that point, fanotify_get_response() changes the state
to FAN_EVENT_CANCELED and returns. This unwinds the file_range stack
frame while the reader still owns the event. The reader then dereferences
pevent->ppos and copies the stale stack value to userspace.

KASAN reported:

  BUG: KASAN: use-after-free in fanotify_read+0x293e/0x2970
  Read of size 8 at addr ffff88811434fc50 by task fanotify_inotif/95
  Call Trace:
   fanotify_read+0x293e/0x2970
   vfs_read+0x177/0xa20
   ksys_read+0xf7/0x1c0
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Store the range position directly in the permission event and use
FANOTIFY_NO_RANGE when range information is unavailable. The event remains
alive until the reader finishes, so the reported offset no longer depends
on the triggering task's stack.

Fixes: 870499bc1d4d ("fanotify: report file range info with pre-content events")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v2:
- Remove ppos from fanotify_perm_event and use FANOTIFY_NO_RANGE as the
  sentinel for unavailable range information, as suggested by Jan Kara.
- Read the event-owned position directly when reporting range information.

Link: https://lore.kernel.org/linux-fsdevel/20260730085801.2068723-1-nicoyip.dev@gmail.com/ [v1]

 fs/notify/fanotify/fanotify.c      | 3 +--
 fs/notify/fanotify/fanotify.h      | 6 ++++--
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a3555bebad63..b05b6d3abb87 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -600,8 +600,7 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
-	/* NULL ppos means no range info */
-	pevent->ppos = range ? &range->pos : NULL;
+	pevent->pos = range ? range->pos : FANOTIFY_NO_RANGE;
 	pevent->count = range ? range->count : 0;
 	path_get(path);
 
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a0619e7694d5..3710543dbf82 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -428,6 +428,8 @@ FANOTIFY_ME(struct fanotify_event *event)
 	return container_of(event, struct fanotify_mnt_event, fae);
 }
 
+#define FANOTIFY_NO_RANGE	((loff_t)-1)
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -438,7 +440,7 @@ FANOTIFY_ME(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
-	const loff_t *ppos;		/* optional file range info */
+	loff_t pos;			/* FANOTIFY_NO_RANGE if unavailable */
 	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
@@ -468,7 +470,7 @@ static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
 	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
 		return false;
 
-	return FANOTIFY_PERM(event)->ppos;
+	return FANOTIFY_PERM(event)->pos != FANOTIFY_NO_RANGE;
 }
 
 static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b604e3da58ad..bba92d691f0d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -675,12 +675,12 @@ static size_t copy_range_info_to_user(struct fanotify_event *event,
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
 
-	if (WARN_ON_ONCE(!pevent->ppos))
+	if (WARN_ON_ONCE(pevent->pos == FANOTIFY_NO_RANGE))
 		return -EINVAL;
 
 	info.hdr.info_type = FAN_EVENT_INFO_TYPE_RANGE;
 	info.hdr.len = info_len;
-	info.offset = *(pevent->ppos);
+	info.offset = pevent->pos;
 	info.count = pevent->count;
 
 	if (copy_to_user(buf, &info, info_len))
-- 
2.43.0
