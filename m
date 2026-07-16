Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBC41BA62
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201905; cv=none; b=lvxfK53O0fXTemEHwgHAcJPN6dOLYfHc/D1NzVzPFcFC0e3scwHswPYEhjHXf0pFVAubLx/WpOQ90YalBRoVx0YH3+IAaTNND+5UkJYk5xI3DAzs7aDGBhiGScQkHmxSDcrMLqO+W6Qix8iXlYCtxABduhfQqQ2BFv0QvVwLk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201905; c=relaxed/simple;
	bh=Y4FOVM3eywsQFhkBOiAF+4Slfy4/5qb+6U/bEUm91uA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JzNzUVur1+p+DJL6UaqY9fCgmmBQwSmZC06UyfokJKwv8Y3JBgX9YL7mokl/7u0N5a9Jq3dzVjQuwWTgbJ2gqKdhD9qv/2sU+XqpfoOhJU78UWfvN7gNppVkQKHEagG4giwa+iTTB2vA5gqQfxEoa3PbVrJO3K7SeE8+0yiScjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qT4pd7I0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qT4pd7I0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBFD1F000E9;
	Thu, 16 Jul 2026 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201901;
	bh=V22tNo/ezlLvxpLYeaqINacNW75immgZ4TIvaGQluSk=;
	h=Subject:To:Cc:From:Date;
	b=qT4pd7I02bot+vTbvvsrUhW6Ef+S8ocEMrHmu2B8hCLIwoLpLLTkdRXUSa+dGMCyv
	 pxObVdClTMo/2mF+LOwYZ5Lb7SlCWUsJ+QuxyxXdYv5189MZdoC4rw6rDtBNi5OFcm
	 Wu3hisDPO4Om6FOc0PjIOvc+B0jHT6U9RoMCWfP0=
Subject: FAILED: patch "[PATCH] selftests/landlock: Explicitly disable audit in teardowns" failed to apply to 6.18-stable tree
To: mheyne@amazon.de,mic@digikod.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:38:14 +0200
Message-ID: <2026071614-nicotine-satisfied-6d1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0302cd72fe196aee933e3fb76f6d175d1ab0e843
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071614-nicotine-satisfied-6d1a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0302cd72fe196aee933e3fb76f6d175d1ab0e843 Mon Sep 17 00:00:00 2001
From: Maximilian Heyne <mheyne@amazon.de>
Date: Fri, 29 May 2026 20:03:41 +0000
Subject: [PATCH] selftests/landlock: Explicitly disable audit in teardowns
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 936fe20f020e..f45fdef35681 100644
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
index 758cf2368281..bd9f207b36e4 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -850,10 +850,8 @@ FIXTURE_SETUP(audit_exec)
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

