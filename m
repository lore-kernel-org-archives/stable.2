Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342502;
	b=S1vViv6I5ouohDYoogeu5QZbLZwcGO9P1/3WBZM3xGemU31YHQh13lOM75/QWnAFHy1U
	 MuEVEW4VRvWkF0eiE6kQu+k16i1ZhMDRVzrLDNu9VOzmuCGNuVdFCoVdG0pkOycDQZhmN
	 uIw4L1KDoLIMjWXtcjeu7+0IEk9VJlAKjE4QWiOyXSjIvAe7JZnVPVeeYMEPtIQjcuWrh
	 94LxN6aSCLJoziylHiu+GJ6PrA2KwF5Pfbu5XBWQtFmM733KzmBg90QNlD+X6ektdwQkC
	 NDpXLEpdhY8OLoBHhMokX2t23Vegmt90yb3SE62miVxoOC06BYoGKpNiSZhv5hhudHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342502;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=ZIYDZloriPMk7SgdWjx1Bnwqinw66Jn4lozpHN9Yguo=;
	b=ukG1ZM2CRUvQWeaCL2FsXeC7A7o/yItEseYrJAwuOtaXc56v8ssVK+/y+jIblESp2h+c
	 Ausbp2IRx1hyfsq6gTfvoqhd5zEdEUQuUZuvXcgKz2jMyaOhpGd/YkNXADnYNTPN8hxEN
	 wQkrU4XaUEy2Q9Ny7KZ1vF0AQBDN6fypND1VkBGUtTJYVoXtqKk4MDIg6ncr8QoS5Y2Ux
	 /AGVG1chori/niL39kPVyCoKw1yNfxwe6IZTmXKtcdoY4ioPF7bFyRNBDybZ3Q8lVigpv
	 oyxu88nm0qM5enbVjeVxQdPBF9p5bWDBeY4Owb5bxUXOB16ZlO7TDKjUArBHElmlX3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=YPc9tNKW;
	arc=none smtp.remote-ip=45.157.188.14
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C21606A8A5
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C21606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=YPc9tNKW
Received: from smtp-4-0001 (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJBV6X0WzJF3;
	Tue, 10 Nov 2026 21:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342498;
	bh=ZIYDZloriPMk7SgdWjx1Bnwqinw66Jn4lozpHN9Yguo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPc9tNKW7xsY1BBIeO1Cx5gpjT8dSyxOPcUoTyR3lQDDcPDtVTR8TSQq+SMwntDEx
	 DV2HHv0sJNe+e6CXO+qh2LMm4iAuiUXrlpfDSCBmcX1Qy6pyFAMvVv09uuY07TuoqV
	 tTZWl4MSLaXOe+d4EfRjyTTF9kWTYzbJUTL7aJJ0=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jPJBT3nv1z4Nc;
	Tue, 10 Nov 2026 21:28:17 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] capabilities: Check PR_SET_SECUREBITS with ns_capable()
Date: Tue, 10 Nov 2026 21:28:06 +0100
Message-ID: <20261110202811.2409395-2-mic@digikod.net>
In-Reply-To: <20261110202811.2409395-1-mic@digikod.net>
References: <20261110202811.2409395-1-mic@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Per-process securebits were introduced with a direct cap_capable() check
for CAP_SETPCAP.  The capable LSM hook and SELinux capability policy
already existed, and SELinux forwarded task_prctl operations to
commoncap.  The direct call therefore bypassed SELinux policy from the
start.  It now also bypasses AppArmor, Landlock, and BPF LSM programs
attached to the capable hook.

A task with CAP_SETPCAP in its effective set can consequently change
privileged securebits despite an LSM denial.  This can alter how its
capabilities evolve across UID and execution transitions without the
expected LSM denial or audit record.

Use ns_capable(), as cap_prctl_drop() already does for PR_CAPBSET_DROP.
Call it only for a no-op, which requires privilege for legacy reasons,
or when a privileged bit changes.  Changes limited to
SECURE_ALL_UNPRIVILEGED and their lock bits do not need the capability,
so they must not invoke an LSM check or set PF_SUPERPRIV.  Successful
privileged checks now set PF_SUPERPRIV, as other ns_capable() callers
do.  Without other LSMs, the same requests remain allowed as before.

The check now reaches every capable hook before commoncap commits the
new credentials.  A later task_prctl hook cannot provide equivalent
mediation because commoncap runs first and commits the change itself.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Matt Bobrowski <matt@bobrowski.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: stable@vger.kernel.org
Reported-by: Ada Smith <adasmithgt@gmail.com>
Fixes: 3898b1b4ebff ("capabilities: implement per-process securebits")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/commoncap.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..1947128396e2 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1283,6 +1283,23 @@ static int cap_prctl_drop(unsigned long cap)
 	return commit_creds(new);
 }
 
+/*
+ * Doing anything with securebits requires privilege (go read about the
+ * "sendmail capabilities bug"), except for unprivileged bits.  Indeed, the
+ * SECURE_ALL_UNPRIVILEGED bits are not restrictions enforced by the kernel but
+ * by user space on itself.  For legacy reasons, a non-change requires
+ * privilege too.  Only checking CAP_SETPCAP when it is needed keeps LSMs from
+ * seeing (and logging) a capability check for unprivileged changes.
+ */
+static bool securebits_need_setpcap(unsigned long old, unsigned long new)
+{
+	const unsigned long unpriv_and_locks = SECURE_ALL_UNPRIVILEGED |
+					       SECURE_ALL_UNPRIVILEGED << 1;
+	const unsigned long changed = old ^ new;
+
+	return !changed || (changed & ~unpriv_and_locks);
+}
+
 /**
  * cap_task_prctl - Implement process control functions for this security module
  * @option: The process control function requested
@@ -1346,28 +1363,9 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			/* cannot change a locked bit */
 			return -EPERM;
 
-		/*
-		 * Doing anything requires privilege (go read about the
-		 * "sendmail capabilities bug"), except for unprivileged bits.
-		 * Indeed, the SECURE_ALL_UNPRIVILEGED bits are not
-		 * restrictions enforced by the kernel but by user space on
-		 * itself.
-		 */
-		if (cap_capable(current_cred(), current_cred()->user_ns,
-				CAP_SETPCAP, CAP_OPT_NONE) != 0) {
-			const unsigned long unpriv_and_locks =
-				SECURE_ALL_UNPRIVILEGED |
-				SECURE_ALL_UNPRIVILEGED << 1;
-			const unsigned long changed = old->securebits ^ arg2;
-
-			/* For legacy reason, denies non-change. */
-			if (!changed)
-				return -EPERM;
-
-			/* Denies privileged changes. */
-			if (changed & ~unpriv_and_locks)
-				return -EPERM;
-		}
+		if (securebits_need_setpcap(old->securebits, arg2) &&
+		    !ns_capable(current_user_ns(), CAP_SETPCAP))
+			return -EPERM;
 
 		new = prepare_creds();
 		if (!new)
-- 
2.56.0

