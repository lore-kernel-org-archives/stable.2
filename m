Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561070;
	b=07F3KEkQLqnnIasAkOMp5mAA+n6iJ7fXQeYdTK+V2IkfyeVRmmfUDj7hLGRK6fENNt0p
	 PEWRjmWRD8Z4MVIO/hk+dU3Emu2z6CgUUoJ1YZvg8kJTpkSFpRWXb/SGNJLKLTo2YpHra
	 owE4PiJGBAf4vAzv09ICNCVEHCEvCSpLeM7NO8bt0uJe1EcA2u7aBDIUTzBr25Q0reiyd
	 XSnOZt44XK5k7dOzi16YwS5JRpRlbo/aXZttb2Z6PQSTbB/ePk9XDcgjP5eqP08tddyTO
	 kTUdKL9DXdX+fUoC9dGG/XZQIO2s6TsRBZh4qoU7nxo6uvaDOuH9wH5S3TUxmNvK3LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2D/I2rGbZlEudAsNkTbusGdvyJZTBHqRLMiuczqMUVM=;
	b=K0DMNhjnPYkxMO8ipXM/tKji9kkLlzYxNzuijSS9KwO+xn4O/kNMoA678PDP9vQaxadt
	 SyJRVtnigvH+F4i7EY6+3yipv94mWujIxJ6Twr/CXe1x/YwyF46WNeA+TND3WjtTY1xTO
	 6+MkMVEZzMUr61H83vqhdC88Vd+bUbTIRHKC4Lb7IB2VSf6bsEf8pSh/hZDXXmW4GuV2Y
	 CuyjUyKViITMmrDxMtEUdNSk8kNb6bRjqjLncqZX6wPqWQeht0jW2sWeL6kezHUMTlGxI
	 yMh6ALOgDZ9doFRA1ApaWhOCPzqNYRVQR2rKHfqmCBOayOa4G8jTeUlyKHges8m5WKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IcS8U/zm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897E606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcS8U/zm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC441F000F4;
	Tue, 24 Nov 2026 22:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561070;
	bh=2D/I2rGbZlEudAsNkTbusGdvyJZTBHqRLMiuczqMUVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IcS8U/zmMD81OqpamIkM7YxAzE9HItA9sbwb3vLpwKK6QD+w70E44gtYCdTBZe3X5
	 6iOU/jCLP8Fg7Q+KeZJMCe4OCKMOUeYeVdIM0frW2hAWcoLqXcs0ib7XSk3C/T55Lr
	 TJvo0v7e8mLjPNNC+yHBXbW7dPKXin0nptXD+X8KqflVV6cY3OcBW1x6dJINlKCSMD
	 7nW0GGi9R3A+qZxKwE+uQGXic4jZukR1w4s1jSXL1DvrCR4FruZ3mpszRZQ/De/mcB
	 gP+qtsUVqJc8dDLzwBfwetk3tez1Oe9Fsi8L+XXY/kZwkjr2gb7gTojCFYboLFMBK4
	 GB+Wm/pyecsJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <me@black-desk.cn>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] pidfd: restrict task access ioctls to the caller's pid namespace
Date: Tue, 24 Nov 2026 17:57:48 -0500
Message-ID: <20261124225728.3116936-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112429-trident-saloon-7b03@gregkh>
References: <2026112429-trident-saloon-7b03@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Linxuan <me@black-desk.cn>

[ Upstream commit ee8323fdc827c580425644db605a4be776cace57 ]

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
[ sashal: Replaced the missing pid_in_current_pidns() helper with an equivalent pid_nr_ns(pid, task_active_pid_ns(current)) check, since that helper isn't in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pidfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index b2dc613a64f6f..7a5efe86426bb 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -131,6 +131,14 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!task)
 		return -ESRCH;
 
+	/*
+	 * Require the target to be visible in the caller's pid namespace
+	 * for operations that grant access to its resources, mirroring
+	 * procfs and PIDFD_GET_INFO.
+	 */
+	if (!pid_nr_ns(pid, task_active_pid_ns(current)))
+		return -EREMOTE;
+
 	/*
 	 * We're trying to open a file descriptor to the namespace so perform a
 	 * filesystem cred ptrace check. Hold @task's exec_update_lock for the
-- 
2.53.0

