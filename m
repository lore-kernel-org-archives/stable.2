Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536429;
	b=JiFsphIHkz+cChCNT1OPliiaf8qH5McC7X81nrmn17SRMo/LErDwhsNLNqGWbzVEZ12X
	 gwOVV/J1zqlcZnfoJKkCC3i30kQaYWacCioXCNBOyvdj9UzP3/DCj3yBEqvcPrGYBGFhk
	 URSUW7oIb/IKsj65ffy7vw0H+uzWh+Cim6EN5RvrfZ+2wIieSQL2kWTosTGgW+btZ8kT0
	 Y13olQnELZs7rg3JEWTSgGUckGD7oKJLOo8y6SfvmdEZuLKPxwVBjf+dKWOqdvG6OqtzQ
	 y1Lf87S8jo742Pigl8WeE0HhhPLH+GuPJlj6A2AOlCnbsAzZEYr8gRKl3H9/EbSrsQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536429;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mz4yjFTJQ2YrANn/qKHhE9wlWB2CBlXlN5v+2xFvgTc=;
	b=xFrG5lr+XeexzFwuWOo3BkqMw7g6+zP9GuI7MKmdvL0KAcw0nYfBk9vUVrJ0mF1JRDIz
	 IUXK3IjcN9Ox0RElCy4l5ofLYrwTnNZqcdNul+ghEitaOJcAsTf+5xaUCG1hB1gLZdpiO
	 Glj1F+tWYLjUaALqUj/eevMZkHtteJDrLEwk88bJPJz3EVxooXpi+DA2NCnlyJREMFCsY
	 0dh2OjG9GXXjVoWYO8WnOb8xrkCqj72u626bTHl/ZlZiNAcC0JPs4/aXtR1F2DTv6Q7V8
	 avf6ulxdQkknPu29eS1uEx0sDmRQdhGJwVYsMJlNuBJ6NDK2MUjhR0GnNSb6cTGRhWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="sCu/xXjS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A1606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sCu/xXjS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09DA1F000C6;
	Tue, 24 Nov 2026 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795536429;
	bh=mz4yjFTJQ2YrANn/qKHhE9wlWB2CBlXlN5v+2xFvgTc=;
	h=Subject:To:Cc:From:Date;
	b=sCu/xXjSwMd5+ddY7jU837DlxgAEPTB6ACNDXtpQHxXRd6FZ/n/qWQltscBbtluGp
	 PxfwV9oRnhBzEjlUTxra+q6gPPwgKJlfdtE8cvs3iGpEXcFfMckwhP1hZJoS0SS5gg
	 vnpKbHIXWHWyov5/TythPRLDO0G7+FHvmhyeCc1Y=
Subject: FAILED: patch "[PATCH] pidfd: restrict task access ioctls to the caller's pid" failed to apply to 6.12-stable tree
To: me@black-desk.cn,brauner@kernel.org,jannh@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 17:07:29 +0100
Message-ID: <2026112429-trident-saloon-7b03@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ee8323fdc827c580425644db605a4be776cace57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112429-trident-saloon-7b03@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee8323fdc827c580425644db605a4be776cace57 Mon Sep 17 00:00:00 2001
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 27 Oct 2026 16:22:15 +0800
Subject: [PATCH] pidfd: restrict task access ioctls to the caller's pid
 namespace

pidfds can cross pid namespace boundaries: a task may obtain one for a
process outside of its own pid namespace hierarchy through SO_PASSPIDFD
or SO_PEERPIDFD, via SCM_RIGHTS, or through file descriptor inheritance.

The namespace ioctls gate access with a ptrace check against the
target's credentials only. That check does not account for the pid
namespace relationship between the caller and the target, so a task
inside a pid namespace can use a pidfd obtained across that boundary to
acquire namespace file descriptors of a task outside of its hierarchy.

procfs exposes the equivalent information only for tasks visible in the
reader's pid namespace, and PIDFD_GET_INFO already answers with -EREMOTE
for targets outside the caller's hierarchy. Extend that policy to the
namespace ioctls: fail with -EREMOTE unless the target is visible in the
caller's active pid namespace. Callers in ancestor pid namespaces are
unaffected.

Unlike PIDFD_GET_INFO, the visibility check is performed after the task
lookup here, so reaped targets outside of the caller's pid namespace
hierarchy answer -ESRCH instead of -EREMOTE.

Link: https://lore.kernel.org/all/CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com
Link: https://lore.kernel.org/all/20260925-gewischt-auftrag-tierzucht-c153cb3f9f74@brauner
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Fixes: 5b08bd408534 ("pidfs: allow retrieval of namespace file descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Linxuan <me@black-desk.cn>
Link: https://patch.msgid.link/20261027-pidfd-task-access-v1-1-d46cf0fa4ca1@black-desk.cn
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 114d2713a79e..d1aa0229866a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -590,6 +590,14 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (arg)
 		return -EINVAL;
 
+	/*
+	 * Require the target to be visible in the caller's pid namespace
+	 * for operations that grant access to its resources, mirroring
+	 * procfs and PIDFD_GET_INFO.
+	 */
+	if (!pid_in_current_pidns(pidfd_pid(file)))
+		return -EREMOTE;
+
 	/*
 	 * We're trying to open a file descriptor to the namespace so perform a
 	 * filesystem cred ptrace check. Hold @task's exec_update_lock for the

