Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887D56C624
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064532; cv=none; b=V433+7I4wEjVIDgcJT1QZUQo016rNuuUM6BPCp0SgvkFdeLIk0k7QSk7DqEYYQKQ/aYQZqp2nixGipes64sntnaeAHXKplayc9IBRhcwRlSGF3O5TWjUviGAOWz5pyMfdJJ4Yy/FybPG+YLOgp0yOQxuEhVbl0zYQ7wG2tg3Bc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064532; c=relaxed/simple;
	bh=xeBaVq34Fvm+F/zQVDvqjxr/qQQkcNW+NLJKAnQ0Gzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byHyjn7VK0uRh/qt+RvmgE/SdqY3WTuc8cdhYeueYwvmPsm1+RbKL2ZC6dJ/UIrjZv2JOTEIA1+k8/n4CtIJ6220c2giRQts27Tk7U/7+yhg1deeziZ92oJFDvG3pUEcu7g1H2DO3zzHj8a3xT32HabvArvDkKbssTEWrWOzAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hiq9LTIH; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hiq9LTIH"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso1393565e9.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1789064526; x=1789669326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqDHIUprFGhLpfjoTtzfh0mDO50nuGrZXReIflYDQ28=;
        b=hiq9LTIHwK9bGox2e61Q5JkEOIfi+7XrnWER7D9SJLinSRQdrsBjxlA5spo7zgyAVa
         7NYb7ST88F24ybJlmGl6mksaluXawXRSUr/HaVSdc6QDYpqeo4VKgTGz/th2wYgKZFvo
         QQzwAJa+3qc7MyKVYBaHba7QLHkuhZca0UWtBE9gkN/O08doU6OxkReN/DoVYsVWtu7W
         weEJ3ksB3WQC+JIhHBg0FbK+PrYk/W9kxYDp2Mmg/8xdU14P+HMFFpLcyOIcWk6NXy3E
         ayBUpZt5yP3Si/1PnXBfAGXs+ikXz45dEYYaQ4j1Pqxx1ByjqfLiakl+NUIVCZ5pN8J8
         U+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064526; x=1789669326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqDHIUprFGhLpfjoTtzfh0mDO50nuGrZXReIflYDQ28=;
        b=bFj6CEgcZVAAh1v0co0J/mESgIAQE58dfA55INQEe5o7+R0YPnC/RucBca1tB3P5mo
         r/uCpwqjK5zXFsbrfo07JBknDFV5U3Ioeg5wUH1jODVfsQToyfWNugwtjnmUAhYR8hhU
         epsYnz6oCeNbUbOCLWK51MZ7N+fJDmgwsBHxMYP0KOhpTgdl3o/a06gddkxZumKvSLPG
         IpS4MGMxDwZ6KGi+HoXdfYVIDZqjeEiBRYpWS4gE4foAKb2eEmoByJzCYn2I3FZc2R/K
         QN/Ok64UEWlbC0yKPiJXg7jORqt6MHmw9qlzcTIuubuP/LxyC7hti7SCTlemttOK3slA
         nJbw==
X-Forwarded-Encrypted: i=1; AKwUvBzCm3GjuS7Zh6jrIkmxhwg8ENGIWJgD6m6zKUJ/Az7w7InJ/Y16OTnWAGPOK+E+f35CVEGHzWU=@vger.kernel.org
X-Gm-Message-State: AFuF++kaccDR30HNdhKJzCb/mSiCFYrzOAlXJnjPsCFDt7Wl9NH5bJds
	EwOleq+Vjt6fQL1fzQXt1fJvXxzXPAyy9IyqxBDwvA3gkV+hwUFDuex0KiWL4aOSoAQ=
X-Gm-Gg: AYBFou1xDaef+7AAtzvUd4hl6CayWHOONZTbmoIZMlKZVUiSLiJ12lJqHsdobyYPBru
	+y0Z10cYRXs0kttvjWdwn9F8uxwJ8+dMSQZVU8caRJ4GDaZG4RoAxEN19e0AF+4ZLRNfYbwXlOC
	7Hahk81bVCi3z0jxkdGIub+pyYZmS9cnGFvUJqDaZ8lmPmy+r3hAekGLNskQj+2M9mVDjpVRhDF
	O+6AL5Q3nNkmcybPkd998yvFmAaaldg8eHJw/7/oEhnC8Ze/B3x1/AmG5ONPRe4JohFrvXy3ZBA
	uFqgc3hB4IlY6pMduwI2It4gOGab0L45qr1/LA9VQa4K7AQ9vmuCDJSJSjUYY/6CzEt1D+5DD9h
	qPZEJU4Ck+PsLYgDvqkMWFWe0MLWxIXxwNcPUs7AEIARGsnlm1kD/yjJ8D/beqL7cO3fA1fP8f1
	VvQnsFpt13TtMwvgor5WklBrWMcFSOYx9wRp15o9JgdrwFQF+1M0TQGx48ZyB8nwdj0yfCAmUoy
	jIFmdIycv9yMfcmoZ0vSWt2QHbVdlxbQHak167QeP77tPpziDZmsMEjRRUh9oPfSMh5Rtus1eQ=
X-Received: by 2002:a05:600d:6501:10b0:49c:fa21:e73b with SMTP id 5b1f17b1804b1-49e619c0bc0mr2423325e9.17.1789064526542;
        Thu, 10 Sep 2026 11:22:06 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm40025455e9.11.2026.09.10.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:22:06 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	steved@redhat.com,
	viro@zeniv.linux.org.uk,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] cachefiles: pass a poll key when waking the daemon
Date: Thu, 10 Sep 2026 20:22:00 +0200
Message-ID: <20260910182200.1272489-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keyless wakeups bypass epoll's event-mask filtering.  With only
`EPOLLOUT` registered, any cachefiles_state_changed() call will wake
up the epoll_wait() system call, but will not return any events,
causing a busy loop.

Pass the relevant poll events with each wakeup so `epoll` can filter
out unwanted notifications.

Fixes: a5b3a80b899b ("CacheFiles: Provide read-and-reset release counters for cachefilesd")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note: backports to older branches need to adjust ondemand.c as well
like this:
-       wake_up_all(&cache->daemon_pollwq);
+       cachefiles_wake_poll(cache, EPOLLIN);
---
 fs/cachefiles/cache.c    |  4 ++--
 fs/cachefiles/internal.h | 15 +++++++++++++--
 fs/cachefiles/namei.c    |  2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 9fb06dc16520..08ca598618ac 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -255,7 +255,7 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 	    test_and_clear_bit(CACHEFILES_CULLING, &cache->flags)
 	    ) {
 		_debug("cease culling");
-		cachefiles_state_changed(cache);
+		cachefiles_state_changed(cache, EPOLLIN);
 	}
 
 	//_leave(" = 0");
@@ -275,7 +275,7 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 begin_cull:
 	if (!test_and_set_bit(CACHEFILES_CULLING, &cache->flags)) {
 		_debug("### CULL CACHE ###");
-		cachefiles_state_changed(cache);
+		cachefiles_state_changed(cache, EPOLLIN | EPOLLOUT);
 	}
 
 	_leave(" = %d", ret);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c93324e0f98c..b8a5ea4a5ced 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -15,6 +15,7 @@
 #include <linux/fscache-cache.h>
 #include <linux/cred.h>
 #include <linux/security.h>
+#include <linux/poll.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
 
@@ -117,13 +118,23 @@ struct cachefiles_object *cachefiles_cres_object(struct netfs_cache_resources *c
 	return fscache_cres_cookie(cres)->cache_priv;
 }
 
+/*
+ * Wake up the daemon polling on /dev/cachefiles.
+ */
+static inline void cachefiles_wake_poll(struct cachefiles_cache *cache,
+					__poll_t mask)
+{
+	__wake_up(&cache->daemon_pollwq, TASK_NORMAL, 0, poll_to_key(mask));
+}
+
 /*
  * note change of state for daemon
  */
-static inline void cachefiles_state_changed(struct cachefiles_cache *cache)
+static inline void cachefiles_state_changed(struct cachefiles_cache *cache,
+					    __poll_t mask)
 {
 	set_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
-	wake_up_all(&cache->daemon_pollwq);
+	cachefiles_wake_poll(cache, mask);
 }
 
 /*
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 88955249a1a6..52eb227f07e8 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -74,7 +74,7 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 		atomic_long_add(inode->i_blocks, &cache->b_released);
 		if (atomic_inc_return(&cache->f_released))
-			cachefiles_state_changed(cache);
+			cachefiles_state_changed(cache, EPOLLIN);
 	}
 }
 
-- 
2.47.3

