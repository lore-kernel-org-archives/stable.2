Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D94E3230
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659613; cv=none; b=p2bfK8W6O5bMbW7P14EYi2mnjdly0dyvjsEyipwh41bYjmvP1622oU1/20HBmYU7WIt9+Y+Sui3mul6kO794Tl9X2dmuFDCtvYUzZXTJ2LGjKpM29W23Gd7hh31RORzS1LvksaOHPioHYZexNRMUTke/i6jt6l+VBf8e2FXrvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659613; c=relaxed/simple;
	bh=0Uv/Cwif9dghy6+diBgvylWjk1pooxG0WVEpbZRmKdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv/HbyYqMnFcBaXkF4JVZhZnX1QdJtjY6KdTEdNNO4J1kNhjjibX2sOasorBa5ORTC+LmbgIgUvsT8+qOigicf+tQdR5YA7e2ggY843h5zT5lHOSolaNtMPmjvmAU6B2shO/hHHPrX5E9OIG+vEsBCZs+Nz/Bi+jBS6ZLDUzLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yMSI4zxg; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yMSI4zxg"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm0Ls1QbNz9V8;
	Thu, 17 Sep 2026 17:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789659604;
	bh=tXg/YZ8/Tg68/WA5ez/ttWOyVSNjDHjh4hMdtdh5UNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yMSI4zxg8it22D9TKKuA/l+sz2UYdnQFmNmgSns4WJl9IWar44algr7Kw+jWnQPzi
	 yrj5QcVQd8EPAg1StBJtpbbaCI9KJJeLYdrxodeZf+qP9Q7Bid59JjO0WT09hAmnEm
	 1WUMw1AiTKAjNDt5EnmXqZo7+c7S98jtfKY1gfYg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm0Lr25WtzCM3;
	Thu, 17 Sep 2026 17:40:04 +0200 (CEST)
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
Subject: [PATCH 6.18.y v2 3/3] selftests/landlock: Explicitly disable audit in teardowns
Date: Thu, 17 Sep 2026 17:39:57 +0200
Message-ID: <91ac2d167556f82c548dad851e3b90f3b93dfc78.1789655724.git.mic@digikod.net>
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

From: Maximilian Heyne <mheyne@amazon.de>

[ Upstream commit 0302cd72fe196aee933e3fb76f6d175d1ab0e843 ]

I'm seeing sporadic selftest failures, such as

  #  RUN           scoped_audit.connect_to_child ...
  # scoped_abstract_unix_test.c:314:connect_to_child:Expected 0 (0) == records.access (8)
  # connect_to_child: Test failed
  #          FAIL  scoped_audit.connect_to_child
  not ok 19 scoped_audit.connect_to_child

This seems similar to what commit 3647a4977fb73d ("selftests/landlock:
Drain stale audit records on init") tried to fix. However, the added
drain loop is not effective. When setting the AUDIT_STATUS_PID, the
kauditd_thread is woken up starting to send messages from the hold queue
to the netlink. Depending on scheduling of this kthread not all messages
might be send via the netlink in the 1 us interval.

Therefore, instead of trying to drain the queue, let's just disable
audit when running non-audit tests or more precisely disable it after
audit-tests. This way we won't generate any new audit message that could
interfere with the other tests.

The comment saying that on process exit audit will be disabled is wrong.
The closed file descriptor just causes an auditd_reset(), not a
disablement. So future messages will be queued in the hold queue.

Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Link: https://patch.msgid.link/20260529-welsh-nagoya-b4d9ca60@mheyne-amazon
[mic: Fix FD leak, update subject, call audit_cleanup() in audit_exec teardown]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 tools/testing/selftests/landlock/audit.h      | 21 +++++++------------
 tools/testing/selftests/landlock/audit_test.c |  4 +---
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 34efa5d9b0a9..a1768a4dbf39 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -553,10 +553,9 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
 static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 {
 	struct audit_filter new_filter;
+	int err = 0;
 
 	if (audit_fd < 0 || !filter) {
-		int err;
-
 		/*
 		 * Simulates audit_init_with_exe_filter() when called from
 		 * FIXTURE_TEARDOWN_PARENT().
@@ -567,23 +566,19 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 
 		filter = &new_filter;
 		err = audit_init_filter_exe(filter, NULL);
-		if (err) {
-			close(audit_fd);
-			return err;
-		}
+		if (err)
+			goto err_close;
 	}
 
 	/* Filters might not be in place. */
 	audit_filter_exe(audit_fd, filter, AUDIT_DEL_RULE);
 	audit_filter_drop(audit_fd, AUDIT_DEL_RULE);
 
-	/*
-	 * Because audit_cleanup() might not be called by the test auditd
-	 * process, it might not be possible to explicitly set it.  Anyway,
-	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
-	 * process will exit.
-	 */
-	return close(audit_fd);
+	err = audit_set_status(audit_fd, AUDIT_STATUS_ENABLED, 0);
+
+err_close:
+	close(audit_fd);
+	return err;
 }
 
 static int audit_init_with_exe_filter(struct audit_filter *filter)
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 67ab175ef5e3..dcf63b2f822e 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -617,10 +617,8 @@ FIXTURE_SETUP(audit_exec)
 FIXTURE_TEARDOWN(audit_exec)
 {
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
-	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter,
-				      AUDIT_DEL_RULE));
+	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->audit_filter));
 	clear_cap(_metadata, CAP_AUDIT_CONTROL);
-	EXPECT_EQ(0, close(self->audit_fd));
 }
 
 TEST_F(audit_exec, signal_and_open)
