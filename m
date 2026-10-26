Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048047;
	b=A2TlWt/2ZyaJ2bb1KNXoAdOkQFYP2By89wC1OnjWWRZeCxciIT9/O+F/GBTK+zpWAajN
	 ufyt4SDkdNvV4kU+pPjHMOYiKAZvZ8izgY7nvo8RHrhOPEW1b9S1EVJrlIhbGbPmLJwdQ
	 2sM4PfmK0XoQmh5UmzNwmbMa+mUb3lT2MPANlJwHbiDf9CU9q1nswnYQzFQDTiAXg/RCs
	 20rGpy8/I3h7xTzzVBHU/csoTIKEm+ew7ickMB2IbhvOltiOYiS/XXhBLa809LssBb7ox
	 GAc5A7e2nz3gDEzWz9b1ySz8Tik3kLDuYIAGyT45m4x2MdPvCDoZIM/kBW0Eh/VoHCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048047;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NIm3ZS5KbjzsYJ0WSulRKaxitX/G7rtbCDL/MIRA6Dk=;
	b=gBFDK0kEs/77OiU4TgBmmXyuCHpAap2YF0+n2I07XlO6iW0P6RZb8UYuDaJIR1I0aJRT
	 NiXQ0jKJHYIRlC7JiKEK1U+y83k0L9axe9oUwnYLqOKpY1v2uQf9SvzRQugaotyIt890n
	 AuYz/9Ob+ewkw3rhziSsvOjSjBnNh8he6A8whOSSifpCp05NekcbAJTwyw/QXLDNbuhee
	 CyaxPLlQpUzTTJ+tXz9KdvMwwGkNusNoMEsSLBVIGR3dS7iBNvgoqn586Pz3Eox+SOAw9
	 CkQ+PU51FXcTP7z8gAsqmzPcSYEnhraJEPv03VFMW9V9Za4Vy0ST7SM6DzMHr6bIb/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxkksvOg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AF606A31E;
	Mon, 26 Oct 2026 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxkksvOg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4966D1F01828;
	Mon, 26 Oct 2026 20:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793048047;
	bh=NIm3ZS5KbjzsYJ0WSulRKaxitX/G7rtbCDL/MIRA6Dk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NxkksvOgoUJHDLEYuqZxoDN5w6CVnX11WAHXavjWLJdqMAD7f4eIg6lK7/L6FE42Y
	 mDawIcxsUDXZB96MfiHTVnvxKvW84UxjxKGbhI5jX08pPzNU4+wCJj96guJTzgbhdP
	 ySjO1NE7g4mrWrlDutJuY01uq16Eq0ZXqYGGXp3d3QNxRqtAB8pRMrRKWw8sYSfw1J
	 huEYOB8iz4jSxyI6UgiF1MoW/dw8NSvpcS8jQRYvh4RfJ3ZsxSYxWxV6OFflFgC5Xs
	 cJ/ZxtgWZnDoh1Gtp4Nzd5n3XbpZ8hNW/VPjKJTfL+RUbArRbUnkTGUHJNmzcgHZO1
	 c0M9B2lg17dUg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 21:53:29 +0100
Subject: [PATCH 1/2] userns: don't drop the exec securebits
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-work-securebits-userns-v1-1-b35473fa1a34@kernel.org>
References: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>
In-Reply-To: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4204; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yXUxhGjrM0vd95PWJeUZxGZvenzi/6XOwtjTBjMe3FE=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGrfveijG/63VwF2dnEFNKUYyMAEz4cxYRc2NV6OHRsTnZeRt
 Yh0BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmrfvegACgkQkcYbwGV43KIu2AD4nj3u
 VIkyHvgxybscgEGv//3yG9Ldw5lqqzgdkEbALwD/cz6zk+fUQ9NjW+dckrZYKWtR+NuGsOsh9XU
 g0aP6zQg=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE tell script
interpreters to only run what AT_EXECVE_CHECK allows and to refuse
interactive input. A service manager sets them together with their lock
bits so that nothing below it can turn them off again.

But set_cred_user_ns() resets all securebits to SECUREBITS_DEFAULT. So
any task that can create a user namespace sheds the locked exec bits
with a single unshare(CLONE_NEWUSER) and joining one with setns() does
the same. The lock is pointless if anyone who may create a user
namespace can drop it, and that is pretty much everyone.

Resetting the other bits is fine. They are about how capabilities are
computed and a new user namespace starts out with a full set of
capabilities anyway. The exec bits grant nothing though. They are
restrictions a task placed on itself, just like no_new_privs which a
user namespace doesn't touch either. So keep them and their locks.

Reproducer:

  // SPDX-License-Identifier: GPL-2.0
  /* Lock the exec securebits, then create a user namespace and look at them again. */
  #define _GNU_SOURCE
  #include <sched.h>
  #include <stdio.h>
  #include <sys/prctl.h>

  #define SECBIT_EXEC_RESTRICT_FILE		(1 << 8)
  #define SECBIT_EXEC_RESTRICT_FILE_LOCKED	(1 << 9)
  #define SECBIT_EXEC_DENY_INTERACTIVE		(1 << 10)
  #define SECBIT_EXEC_DENY_INTERACTIVE_LOCKED	(1 << 11)

  int main(void)
  {
  	int bits = SECBIT_EXEC_RESTRICT_FILE | SECBIT_EXEC_RESTRICT_FILE_LOCKED |
  		   SECBIT_EXEC_DENY_INTERACTIVE | SECBIT_EXEC_DENY_INTERACTIVE_LOCKED;

  	if (prctl(PR_SET_SECUREBITS, bits, 0, 0, 0)) {
  		perror("PR_SET_SECUREBITS");
  		return 1;
  	}
  	printf("before: 0x%x\n", prctl(PR_GET_SECUREBITS, 0, 0, 0, 0));
  	printf("clear locked bits: %s\n", prctl(PR_SET_SECUREBITS, 0, 0, 0, 0) ? "refused" : "ALLOWED");

  	if (unshare(CLONE_NEWUSER)) {
  		perror("unshare(CLONE_NEWUSER)");
  		return 1;
  	}
  	printf("after unshare(CLONE_NEWUSER): 0x%x\n", prctl(PR_GET_SECUREBITS, 0, 0, 0, 0));
  	return 0;
  }

On v7.1 this prints "before: 0xf00", "clear locked bits: refused" and
"after unshare(CLONE_NEWUSER): 0x0". With this patch the last line
reads 0xf00 as well.

Fixes: a0623b2a1d59 ("security: Add EXEC_RESTRICT_FILE and EXEC_DENY_INTERACTIVE securebits")
Cc: stable@vger.kernel.org # v6.14+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/userspace-api/check_exec.rst | 4 ++++
 kernel/user_namespace.c                    | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/check_exec.rst b/Documentation/userspace-api/check_exec.rst
index 05dfe3b56f71..0904810e1d8d 100644
--- a/Documentation/userspace-api/check_exec.rst
+++ b/Documentation/userspace-api/check_exec.rst
@@ -99,6 +99,10 @@ This secure bit may be set by user session managers, service managers,
 container runtimes, sandboxer tools...  Except for test environments, the
 related ``SECBIT_EXEC_DENY_INTERACTIVE_LOCKED`` bit should also be set.
 
+Both secure bits and their locks are inherited across :manpage:`fork(2)` and
+:manpage:`execve(2)`, and they are kept when a task creates or joins a user
+namespace.
+
 Here is the expected behavior for a script interpreter according to combination
 of any exec securebits:
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 50c374ed4687..cd748e1cbace 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -46,8 +46,11 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 {
 	/* Start with the same capabilities as init but useless for doing
 	 * anything as the capabilities are bound to the new user namespace.
+	 * The exec securebits grant nothing, they are restrictions the task
+	 * placed on itself. Keep them and their locks.
 	 */
-	cred->securebits = SECUREBITS_DEFAULT;
+	cred->securebits = SECUREBITS_DEFAULT |
+		(cred->securebits & (SECURE_ALL_UNPRIVILEGED | SECURE_ALL_UNPRIVILEGED << 1));
 	cred->cap_inheritable = CAP_EMPTY_SET;
 	cred->cap_permitted = CAP_FULL_SET;
 	cred->cap_effective = CAP_FULL_SET;

-- 
2.53.0

