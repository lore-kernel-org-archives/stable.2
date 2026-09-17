Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5984E4C4C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659615; cv=none; b=YW9OSkrpaXAOyUnKxwVhKopDqvrxMBW15XX+3cwavXCi1KpYEy1YflefD1MGO0J3pnkXW9Px7k94KHojUmkgWz/WKFu4+4iwCA6S1eP8Kq/JD9xgpeSfsuLKawFByE+fCLp2X81AHdqGpCnZz9D2AjHrkOKTT1SERLTK/MWCDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659615; c=relaxed/simple;
	bh=i6ji6RubUHsICcvgDroUGAWDhGAHXV0Gq7Qeu4Sj2oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCwMcGgTujBeLVPtrd6V0/ogbm3Oxiev44BtDSfsbpk3da3AsDjEiHZPtuODpFKSrpiBwqOT5KvUxxVye21jnXFaIcZpjneEn4b+4Hp9hKgAglhpWtMQ2PYYM5cU195kIE7dwXweT8YaSX+NolcSNWDjwBDmrn99r6NkgBsmP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=l+pTSTj9; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="l+pTSTj9"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm0Lq4TStzYyn;
	Thu, 17 Sep 2026 17:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789659603;
	bh=dQ30RS8/DvGpTzDKQfVxw/QGBrog5zT/undT9jXKm3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+pTSTj9hluC5HEEE6yTEBe0oZ9CiY+HhECIiJgl2rNGhKtCfyHg4e8hVCPQxvKvM
	 m1PVJ3eRBqrm9jGE445o3lXMhaL51jbKPXY149Wmva774c6JLq+zZlWL5oM+6PP7An
	 /wZPtphUu5KQ2kDEvvvOJ7niFf5UanV4GT/85ugQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm0Lp5tZZzx8c;
	Thu, 17 Sep 2026 17:40:02 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Greg KH <greg@kroah.com>,
	Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
	gregkh@linuxfoundation.org,
	kernel test robot <oliver.sang@intel.com>,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Maximilian Heyne <mheyne@amazon.de>
Subject: [PATCH 6.18.y v2 2/3] selftests/landlock: Increase default audit socket timeout
Date: Thu, 17 Sep 2026 17:39:56 +0200
Message-ID: <508da3480254910c99a740df88dbc3d9f22b49b0.1789655724.git.mic@digikod.net>
In-Reply-To: <2026050420-overfed-obstacle-83f2@gregkh>
References: <2026050420-overfed-obstacle-83f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

[ Upstream commit d8dfb4c7faa87c3e41a8678f38f136c2c7c036fa ]

matches_log_fs() and other audit_match_record() callers intermittently
return -EAGAIN under heavy debug configs (KASAN, lockdep).  The audit
record delivery pipeline is asynchronous: landlock_log_denial() queues
the record to audit_queue, and kauditd_thread dequeues and delivers via
netlink.  Under debug configs, kauditd scheduling between
audit_log_end() and netlink_unicast() can exceed a syscall round trip
(more than 1 usec), which was the value of the socket timeout used for
the recvfrom() calls.

The observed failure [1] is an EAGAIN error code (-11) which means that
the access record had not arrived within the 1 usec timeout of
recvfrom().  The expected record does arrive, but only after
matches_log_fs() has already returned.  It is then consumed by a later
audit_count_records() call, making records.access == 1 instead of 0.

Switch the default socket timeout to the slow value (1 second) so all
audit_match_record() callers wait long enough for kauditd delivery, and
lower it to the fast value (1 usec) only on the two paths that expect no
record: audit_count_records() and the expected_domain_id == 0 probe in
matches_log_domain_deallocated().  audit_init() drains stale records
with the fast timeout (terminating on -EAGAIN once the backlog is empty)
and switches to the patient default before returning.  1 second gives
~10x margin over the observed maximum (~100 ms, while the happy path is
~23 us).

Rename the timeval constants to reflect their new roles:
- audit_tv_dom_drop (1 second) -> audit_tv_default: default socket
  timeout, patient enough for asynchronous kauditd delivery.
- audit_tv_default (1 usec) -> audit_tv_fast: fast timeout for paths
  that expect no record (drain, audit_count_records(), probes).

Invert the conditional in matches_log_domain_deallocated().  Check
setsockopt returns on both the lower and restore paths; preserve the
first error via !err when the restore fails after a prior error so the
actionable return code is not masked by a bookkeeping failure.

Cc: Günther Noack <gnoack@google.com>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Cc: stable@vger.kernel.org
Depends-on: 07c2572a8757 ("selftests/landlock: Skip stale records in audit_match_record()")
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Reported-by: Günther Noack <gnoack3000@gmail.com>
Closes: https://lore.kernel.org/r/20260402.eb5c4e85f472@gnoack.org [1]
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com
Closes: https://lore.kernel.org/oe-lkp/202604300436.a07fae12-lkp@intel.com
Tested-by: Günther Noack <gnoack3000@gmail.com>
Link: https://patch.msgid.link/20260513105112.140137-2-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 tools/testing/selftests/landlock/audit.h | 80 +++++++++++++++++++-----
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index f6d7b9ad6016..34efa5d9b0a9 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -45,17 +45,25 @@ struct audit_message {
 	};
 };
 
-static const struct timeval audit_tv_dom_drop = {
+static const struct timeval audit_tv_default = {
 	/*
-	 * Because domain deallocation is tied to asynchronous credential
-	 * freeing, receiving such event may take some time.  In practice,
-	 * on a small VM, it should not exceed 100k usec, but let's wait up
-	 * to 1 second to be safe.
+	 * Default socket timeout for audit_match_record() callers that expect a
+	 * record to arrive.  Asynchronous kauditd delivery can exceed 1 usec
+	 * under heavy debug configs (KASAN, lockdep), where kauditd_thread
+	 * scheduling between audit_log_end() and netlink_unicast() takes longer
+	 * than the previous 1 usec timeout. 1 second is a generous ceiling: on
+	 * the happy path, kauditd delivers within dozens of usec.
 	 */
 	.tv_sec = 1,
 };
 
-static const struct timeval audit_tv_default = {
+static const struct timeval audit_tv_fast = {
+	/*
+	 * Fast timeout for paths that expect no record (audit_init() drain,
+	 * audit_count_records(), probes).  Causes audit_recv() to return
+	 * -EAGAIN once the socket buffer is empty, naturally terminating the
+	 * read loop.
+	 */
 	.tv_usec = 1,
 };
 
@@ -334,8 +342,13 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
  * Matches a domain deallocation record.  When expected_domain_id is non-zero,
  * the pattern includes the specific domain ID so that stale deallocation
  * records from a previous test (with a different domain ID) are skipped by
- * audit_match_record(), and the socket timeout is temporarily increased to
- * audit_tv_dom_drop to wait for the asynchronous kworker deallocation.
+ * audit_match_record(), waiting for the asynchronous kworker deallocation with
+ * the default patient timeout.
+ *
+ * When expected_domain_id is zero, the caller is probing for any dealloc record
+ * that may or may not arrive.  Temporarily lowers the socket timeout to
+ * audit_tv_fast for this probe so it returns promptly when no record is
+ * pending; restores audit_tv_default after.
  */
 static int __maybe_unused
 matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
@@ -361,16 +374,21 @@ matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
 	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
-	if (expected_domain_id)
-		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-			   &audit_tv_dom_drop, sizeof(audit_tv_dom_drop));
+	if (!expected_domain_id) {
+		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+			       &audit_tv_fast, sizeof(audit_tv_fast)))
+			return -errno;
+	}
 
 	err = audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
 				 domain_id);
 
-	if (expected_domain_id)
-		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
-			   sizeof(audit_tv_default));
+	if (!expected_domain_id) {
+		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+			       &audit_tv_default, sizeof(audit_tv_default)) &&
+		    !err)
+			err = -errno;
+	}
 
 	return err;
 }
@@ -387,6 +405,11 @@ struct audit_records {
  * audit_init() and after the preceding audit_match_record() call.  Allocation
  * records are emitted synchronously during landlock_log_denial() in the current
  * test's syscall context, so only those are counted in records->domain.
+ *
+ * Temporarily lowers SO_RCVTIMEO to audit_tv_fast for the read loop: this is a
+ * "no record expected" path that should terminate on the first -EAGAIN.  The
+ * default patient timeout is restored on exit for subsequent
+ * audit_match_record() callers.
  */
 static int audit_count_records(int audit_fd, struct audit_records *records)
 {
@@ -403,6 +426,12 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
 	records->access = 0;
 	records->domain = 0;
 
+	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
+		       sizeof(audit_tv_fast))) {
+		err = -errno;
+		goto out;
+	}
+
 	do {
 		memset(&msg, 0, sizeof(msg));
 		err = audit_recv(audit_fd, &msg);
@@ -429,6 +458,10 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
 	} while (true);
 
 out:
+	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
+		       sizeof(audit_tv_default)) &&
+	    !err)
+		err = -errno;
 	regfree(&dealloc_re);
 	return err;
 }
@@ -449,9 +482,9 @@ static int audit_init(void)
 	if (err)
 		goto err_close;
 
-	/* Sets a timeout for negative tests. */
-	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
-			 sizeof(audit_tv_default));
+	/* Uses the fast timeout to drain stale records below. */
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
+			 sizeof(audit_tv_fast));
 	if (err) {
 		err = -errno;
 		goto err_close;
@@ -467,6 +500,19 @@ static int audit_init(void)
 	while (audit_recv(fd, NULL) == 0)
 		;
 
+	/*
+	 * Restores the default timeout for audit_match_record() callers that
+	 * expect a record to arrive.  Paths that expect no record restore the
+	 * fast timeout locally (audit_count_records(), the expected_domain_id
+	 * == 0 probe in matches_log_domain_deallocated()).
+	 */
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
+			 sizeof(audit_tv_default));
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
+
 	return fd;
 
 err_close:
