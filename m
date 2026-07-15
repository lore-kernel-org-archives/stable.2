Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB933909A5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126235; cv=none; b=q6JDldtncpO+wMw1GiS1wj+VKDsEBavcSJOYckdHPvXB6lY4EhAEDBqJoNRP+Tc01Qa/Jmal4587InBNeOttwBFvxmbAf1GMexnKt1o/sR6XznxNrsC9gCxPf4/oQOqyBSFPKWfFwY7A9HI1hq1WYba/4Hoc5nbInVFiWAUvbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126235; c=relaxed/simple;
	bh=1vLwkdIWCC4bcvnW0HdgMuJhpCgIpthC4ObG5KEkSmc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gFqJKVUoj8X4oQsnLo/oNJbqr5ZbE+rWucYJJmDPde1UjGMEAioA3PouDE5yvAMvW1y5UX0mr7n/pMGf8VZ2JsfpN5HEOP4ClQWaxkQch6PSP7KJPJJdxABbnYkG8aQQ+3dbJgiEk2Vcn6/Tay5d3lYXJdty35Rep5DUmHvknBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jwncomod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jwncomod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8574C1F000E9;
	Wed, 15 Jul 2026 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784126233;
	bh=c+NBVVzfN+fSIovb6m1n+9ySorJ2EUhAblSwZpVxFa0=;
	h=Subject:To:Cc:From:Date;
	b=JwncomodAqXysV7aIwfGu9TyASnA5vP+pJuolzKF1huljYJ74Xm2FJPM/IdDQ189u
	 ZrrbEiphCHKYMLTB60v2+iqHi6ZYZ0oalSDPk5Lm5ffBeYcRZ0DjbdrCx0nWK99wUA
	 72HI3J4W60FItSbsAgOmHaOIPE6dAo8Uw6DLZQss=
Subject: FAILED: patch "[PATCH] liveupdate: validate session type before performing operation" failed to apply to 7.1-stable tree
To: pratyush@kernel.org,rppt@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 16:37:06 +0200
Message-ID: <2026071506-civil-broadside-de8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 507e3b479f9c6d85135eb5e1a77fb3fddb259ad8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071506-civil-broadside-de8f@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 507e3b479f9c6d85135eb5e1a77fb3fddb259ad8 Mon Sep 17 00:00:00 2001
From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
Date: Tue, 19 May 2026 14:24:26 +0200
Subject: [PATCH] liveupdate: validate session type before performing operation

The sessions ioctls are not applicable to all session types. PRESERVE_FD
is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
valid for incoming session. Calling a incoming ioctl on an outgoing
session is invalid and can cause file handlers to run into unexpected
errors.

For example, a user can create a (outgoing) session, preserve a memfd,
and then immediately do a retrieve without doing a kexec in between.
This would result in memfd's retrieve handler to run. The handlers
expects to be called from a post-kexec context, and will try to do a
kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.

KHO catches this (thanks to KHO_PAGE_MAGIC) and returns an error, but
since this is considered an internal error and KHO throws out a bunch of
WARN()s.

Associate a type with each ioctl op and validate the type in
luo_session_ioctl() before dispatching the ioctl handler to make sure
the op is being called for the right session type.

Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Link: https://patch.msgid.link/20260519122428.2378446-1-pratyush@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index e7f27815c051..099db679bdc5 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -309,34 +309,60 @@ union ucmd_buffer {
 	struct liveupdate_session_get_name get_name;
 };
 
+/* Type of sessions the ioctl applies to. */
+enum luo_ioctl_type {
+	LUO_IOCTL_INCOMING,
+	LUO_IOCTL_OUTGOING,
+	LUO_IOCTL_ALL,
+};
+
 struct luo_ioctl_op {
 	unsigned int size;
 	unsigned int min_size;
 	unsigned int ioctl_num;
+	enum luo_ioctl_type type;
 	int (*execute)(struct luo_session *session, struct luo_ucmd *ucmd);
 };
 
-#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+#define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
 	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_SESSION_BASE] = {                    \
 		.size = sizeof(_struct) +                                      \
 			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
 					  sizeof(_struct)),                    \
 		.min_size = offsetofend(_struct, _last),                       \
 		.ioctl_num = _ioctl,                                           \
+		.type = _type,                                                 \
 		.execute = _fn,                                                \
 	}
 
 static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 	IOCTL_OP(LIVEUPDATE_SESSION_FINISH, luo_session_finish,
-		 struct liveupdate_session_finish, reserved),
+		 struct liveupdate_session_finish, reserved, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_PRESERVE_FD, luo_session_preserve_fd,
-		 struct liveupdate_session_preserve_fd, token),
+		 struct liveupdate_session_preserve_fd, token, LUO_IOCTL_OUTGOING),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
-		 struct liveupdate_session_retrieve_fd, token),
+		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
-		 struct liveupdate_session_get_name, name),
+		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_ALL),
 };
 
+static bool luo_ioctl_type_valid(struct luo_session *session,
+				 const struct luo_ioctl_op *op)
+{
+	switch (op->type) {
+	case LUO_IOCTL_INCOMING:
+		/* Retrieved is only set on incoming sessions */
+		return session->retrieved;
+	case LUO_IOCTL_OUTGOING:
+		return !session->retrieved;
+	case LUO_IOCTL_ALL:
+		return true;
+	}
+
+	/* Catch-all. */
+	return false;
+}
+
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 			      unsigned long arg)
 {
@@ -361,6 +387,8 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
 	if (op->ioctl_num != cmd)
 		return -ENOIOCTLCMD;
+	if (!luo_ioctl_type_valid(session, op))
+		return -EINVAL;
 	if (ucmd.user_size < op->min_size)
 		return -EINVAL;
 
@@ -631,4 +659,3 @@ int luo_session_serialize(void)
 
 	return err;
 }
-

