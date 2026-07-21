Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC261EEE6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594717; cv=none; b=gtFWR7MEx/gR2ere3+PxUXCkbTBE79pw7v6SvdLlnfiVElI9AISIRnqu5hFAbRrBhi6wqDmsdDoe0IqLGBeTHvh1oybQFfmVQ/2RkUAUq/vHYn1HlM5Q1r7jvGul2VjvUK0fPODE2d53ExbIx6E+kJPv4vo4UPSzfcbTLOdUW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594717; c=relaxed/simple;
	bh=gO51MZl+z5DhW9pX7Z2NuTfRQ3jPVuEkBptMTuryUkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCECEKGLvHwho9oH1gHoxJjr7Z12hdRVfjnkaPPUU9XfJ7qYDQqHri/aUCCSZwvuoY6iSdavRowucvobqodxU/xgSU5Rg/3Tb+L9A4wYTD5ZA9eXDxKpCj+AFW6NRJXv1BD9USBBqfTzVZ6VOComQvhiWS7zVwP1WS6Dl/dIzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL73rGta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL73rGta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2861F000E9;
	Tue, 21 Jul 2026 00:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594716;
	bh=mfLrb4U/vM5YXTZvh2dcenuq27/4rJ+q31btdgMsMIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aL73rGtayUENW6okIgKD/Ot+6Y3HZSXXZ6OYc2GP6Wey1lQnuOkUaLPVHXbbF9e1V
	 v+/h+2aaW2P2uoSHnssvVXcaK2M9it69ThxdhF4v0KCaBsFdy8yfKEa5turY99vTLw
	 m3nZe28SGBHdBh7Rl31/JhVZbSZ+h8IRO4TfGFhswV4hPNe7kmOp/ZTNgRVzD2tYi6
	 r6pdAIDnhMuSB2jTMUI3YnyTIsa5pxPqrwplQHbHgIkpROSFtoaMY5yIxn14GcAqoH
	 Np7sfNuApMbFB4ianmqN5E6IJKhLyY9nOZV+na5xcI9MWKE3iMijgLEjy3ksohdzrf
	 tu7qhTqlhjpgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Pratyush Yadav (Google)" <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] liveupdate: validate session type before performing operation
Date: Mon, 20 Jul 2026 20:45:13 -0400
Message-ID: <20260721004514.3421718-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071506-civil-broadside-de8f@gregkh>
References: <2026071506-civil-broadside-de8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

[ Upstream commit 507e3b479f9c6d85135eb5e1a77fb3fddb259ad8 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/liveupdate/luo_session.c | 37 ++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index ec7aebc15a8016..fd69869bc54ec0 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -295,32 +295,58 @@ union ucmd_buffer {
 	struct liveupdate_session_retrieve_fd retrieve;
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
@@ -345,6 +371,8 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
 	if (op->ioctl_num != cmd)
 		return -ENOIOCTLCMD;
+	if (!luo_ioctl_type_valid(session, op))
+		return -EINVAL;
 	if (ucmd.user_size < op->min_size)
 		return -EINVAL;
 
@@ -615,4 +643,3 @@ int luo_session_serialize(void)
 
 	return err;
 }
-
-- 
2.53.0

