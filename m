Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADF3F8234;
	Fri, 31 Jul 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509419; cv=none; b=UcqUjQMsr9MHI6Z+SNjP/u2huBagJFaYczZP1OfW9IHwHTqGjEnJcRl9KWP+tPPRQjmd6A+2clLdlPLolmovIG4NwosbGeyUVOij+7E9dmCw8Z0T/9CQ5858iG9WJ0TKbe2Q2Eeev6qfsoO3VfaPI3aDUv0A/7/JzDOJOb+jgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509419; c=relaxed/simple;
	bh=8+tHxWlxS0Vp5IsPNqgKd34z1c/LPDc0ei1PPL9dfwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R73eELZCRJnDKXBGj/CCRuPJj5iQZx2er/CBIUM1oLTc/szgQQ5sPBmrPBPwhxe1Q2xh6AYXjs+oODhNGhUHm8jGvBNGsjmo8iKMCM8DU5okZw9qZsnFkrBe3DS/o7P3UlbRVGl3MivBBLxmrAKpCDzGhcCSTjyow/TWIVyoBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJm6WC+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJm6WC+5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1692AC2BCF5;
	Fri, 31 Jul 2026 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785509419;
	bh=8+tHxWlxS0Vp5IsPNqgKd34z1c/LPDc0ei1PPL9dfwk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UJm6WC+5R1ssxrsA0v7yPLnYZbmRJCL8gXC2nul6k/7wywkxSH8Q4DY6fBLrN5K2w
	 VqbNSDu8dfWg+TrGJq9WA6ocQvGXs+41amNEvmqraW2A3PfnPgkgOfgG9GsbK6u5BL
	 RyVN/mlj9zjcmIcgs1zzJ392D5I25SHcoKUOlAtXHFEG2Ssbu3gmCS9k98foDm6N+G
	 pzU4otBmrhpHkwLHZyq3fFcnXLPIRs4VWUjwURloR6X9I+ijFx6dRO1E8Jichka07N
	 9brsShh8hQrH3MgArUjZ3e1Gy/kvl2c3fjjWamo+TwcDsezuG3lOqYfpx15kmfqTw/
	 DaRrL8Mrn9KLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D8CC5516F;
	Fri, 31 Jul 2026 14:50:18 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Fri, 31 Jul 2026 22:50:08 +0800
Subject: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
X-B4-Tracking: v=1; b=H4sIAB+2bGoC/yXMQQ6CMBBG4auQWTtJi4jiVYwLmPnRUQNNC4aEc
 HerLr/FeyslREOic7FSxNuSjUOG3xUk93a4gU2zqXRl7Y57z8G0V8YC4TloO4FfozxZcULTOH+
 opKYch4jelt/4cv07zd0DMn1vtG0f9JoJ6noAAAA=
X-Change-ID: 20260731-pidfd-exec-update-lock-de8e990154c6
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4028; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=gJxDMscKxr+JjJaFB0L7y8rHfQS5zqJmYPjkNSkCdPk=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqbLYliStba0h1+Y17GT/dFfejdT4NtXg2y4Ky6
 7nOBdpaHeCJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCamy2JQAKCRB2HuYUOZmu
 i1BfD/97E4VqK4qYN+bNztpB54PT/i6A3EGR08ituKTKkiE7H3F06Ayp1OPnVdofRPM7RWgJh00
 gHQAdxvuk2Kyz4L7SDaU0abuwzf5DWvpuIOOCQ4kAVHdtGrWq8KXpDvOCf70fxPtiPjP5kbXoxB
 sE8qW+CmYRU1Uyc3Qo34UDhSnsWOrhewOZnt30CwyN9BUdMBULtIsNchewo8zajEnhMDI1Z+YFa
 602ATEzLbFZnoH2kJPYsYM85KuEZPggVx9dLaHXbGvpZVkdwvD4/jTzyTjdmK9Z9Qg1dqSfHh3u
 63yNfiWyrkr6dpiSvzYxw2D7yvC/32ELsoBLjz5Ia0BhEcLbpge99ak/EfQyv+8YhaFDijy8Bjq
 aR8j6JSZG6NKQSprXDJ2jXbEhahlCXlMTsZ2f2W5sVkc5M8TylaXXNWFkqPbhS5C+HtoCnZF2P6
 xReilp459fv7WWIzGBXZLlZ9BJffnB7UOuFT5z4m+ro9UXoFIott/0PeB+hVWvJ8XOhFK9u6mvg
 w2EJVZEZspYiuDEw7E5Rw5mSg2qmcn5SB0zWcnRHMZuz5anSxH8ec3tq2gnUOybxwxXzTBKZsO2
 W1EUcQ79z4+kHuEaTZwjSZzRSjY3O4arcY6nq096ejY4E2KBo0TzLq17xMAnPKtJpyjyUzG80HG
 cpjandZGlLUmIXQ==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesystem
credentials ptrace access check before handing out a namespace file
descriptor.  The accompanying comment states that the code "mirrors nsfs
behavior", but, unlike the corresponding procfs paths, it does so without
holding the target task's exec_update_lock.

proc_ns_get_link() and proc_ns_readlink() both take exec_update_lock for
reading around the ptrace check and the namespace lookup, so that the
credentials used for the access decision match those of the task when its
namespace is read.  Without it, a caller can pass the check against the
target's old credentials and then read the namespace after the target has
execve()'d a setuid binary and committed new credentials -- accessing
namespace information it should have been denied.

Hold exec_update_lock for reading around the ptrace check and the
namespace lookup so that pidfd truly mirrors nsfs behavior, as the comment
already claims.  open_namespace() itself runs outside the lock: once a
namespace reference is obtained it carries its own refcount and is opened
with the caller's own credentials, so a concurrent execve() on the target
can no longer affect the outcome.

Fixes: 5b08bd408534 ("pidfs: allow retrieval of namespace file descriptors")
Cc: stable@vger.kernel.org
Assisted-by: Codex:glm-5.2
Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 fs/pidfs.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index b57ecc96e967..a6a643f15d08 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -532,6 +532,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
 	struct ns_common *ns_common = NULL;
+	int error;
 
 	if (!pidfs_ioctl_valid(cmd))
 		return -ENOIOCTLCMD;
@@ -555,20 +556,33 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (arg)
 		return -EINVAL;
 
+	/*
+	 * We're trying to open a file descriptor to the namespace so perform a
+	 * filesystem cred ptrace check. Hold @task's exec_update_lock for the
+	 * duration of the ptrace check and the namespace lookup so that the
+	 * credentials used for the access decision match those of @task at the
+	 * time its namespace is read, preventing a concurrent execve() from
+	 * swapping the task's credentials in between the check and the use. We
+	 * mirror nsfs behavior.
+	 */
+	error = down_read_killable(&task->signal->exec_update_lock);
+	if (error)
+		return error;
+
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+		error = -EACCES;
+		goto out_unlock;
+	}
+
 	scoped_guard(task_lock, task) {
 		nsp = task->nsproxy;
 		if (nsp)
 			get_nsproxy(nsp);
 	}
-	if (!nsp)
-		return -ESRCH; /* just pretend it didn't exist */
-
-	/*
-	 * We're trying to open a file descriptor to the namespace so perform a
-	 * filesystem cred ptrace check. Also, we mirror nsfs behavior.
-	 */
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		return -EACCES;
+	if (!nsp) {
+		error = -ESRCH; /* just pretend it didn't exist */
+		goto out_unlock;
+	}
 
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
@@ -650,11 +664,16 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #endif
 		break;
 	default:
-		return -ENOIOCTLCMD;
+		error = -ENOIOCTLCMD;
 	}
 
-	if (!ns_common)
-		return -EOPNOTSUPP;
+	if (!error && !ns_common)
+		error = -EOPNOTSUPP;
+
+out_unlock:
+	up_read(&task->signal->exec_update_lock);
+	if (error)
+		return error;
 
 	/* open_namespace() unconditionally consumes the reference */
 	return open_namespace(ns_common);

---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-pidfd-exec-update-lock-de8e990154c6

Best regards,
--  
Chen Linxuan <me@black-desk.cn>


