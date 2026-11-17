Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910671;
	b=zR5cCHnESeWHhwklHcBsDrayiNYk8Z2DHUXLfIygpAG3Ov6rUhP/kcDtB4SaVOlbtNlN
	 SlUq1LLu76o2l+yiBfj79tH+7ZY7cRLaa+zSU1siwTNPhT4azPeKa7FgVda4YFDwk2sz/
	 GBSnbC/HTFrhcM/ypeWuPql7DaAoFiQLYEfYUmAkxuxLb+UPtMFz0fpwd1vycTD7B6Tq/
	 X4vUQv5LajC773yXhn4F8gZGrFz98OOHetipWMe6I2RkrCweWMQReMO/KLlAHaMOQfRoF
	 uAJygok2+r3UEhLTcTO9YxuXtxB7QCaOxB7eBes89iRXJmp/nwHG2ngzmKhR9hmaoSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910671;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=RvfKLtJx1LzpSXU6MV8aotz6RXl92/Gwx2B+niglRns=;
	b=bOCGi3wH5Tetp6+l3oKZd+puR+u+90IMleJ3UQLIo6nyhePzMbOK7CU9exqw3bQWtcUx
	 7OLmVH+ZaJrVfTXO/mkUIUDovur8k4ekPgThfAn8bwmlqwYBHU+KP/OOlVke8c9/oan6m
	 POBiTQKxq76o4NWq/Nc5yokbmUwMQ/BKeLhKf3rm7eKzRaoBPl4uIlNstEvRRi6UI5GX/
	 nP+w+C7aVsgbRtyMSn8wrvhBmgsWDSo+nOwZMlNI7PQWTQn3wKalmH5DoeZCGJFDnv0t4
	 kcrt48fVDFebRQ2o7QyMPTOI932Wt5VjAYqG8elgf4bnP5FfFzteuO6GwUKeUCXgMgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=GWMqxOY7;
	arc=none smtp.remote-ip=83.166.143.169
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B73606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B73606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=GWMqxOY7
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLJk5vv4zSLD;
	Tue, 17 Nov 2026 11:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910662;
	bh=RvfKLtJx1LzpSXU6MV8aotz6RXl92/Gwx2B+niglRns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWMqxOY79t9/up9AQphDnpRvFs0//1c/WNeT3/qNfq3mNw5ae0vtGeFAOhpFyANJS
	 rqtgV5FPR132TSvDdgetwvESb53cXf+bLLnUqOE0sQprz1RHRYgTF3D7+mSEfU3Pgf
	 Uwteuw++SSQ0MctoeE7sAczHaftBmfJiCjeNwBbQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLJh6RM2zM8R;
	Tue, 17 Nov 2026 11:17:40 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>
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
	James Morris <jmorris@namei.org>,
	Serge Hallyn <serge@hallyn.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] capabilities: Check PR_SET_SECUREBITS with ns_capable()
Date: Tue, 17 Nov 2026 11:17:36 +0100
Message-ID: <20261117101738.2523492-2-mic@digikod.net>
In-Reply-To: <20261117101738.2523492-1-mic@digikod.net>
References: <20261117101738.2523492-1-mic@digikod.net>
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

PR_SET_SECUREBITS checks CAP_SETPCAP with cap_capable(), which skips the
LSM capable hooks, so a task can change privileged securebits despite an
LSM denial.

Use ns_capable() instead, as PR_CAPBSET_DROP already does.  Move the
check to a helper that only requires CAP_SETPCAP when needed, so that
changes limited to the unprivileged securebits still do not reach the
LSMs or set PF_SUPERPRIV.

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
Reviewed-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Fixes: 3898b1b4ebff ("capabilities: implement per-process securebits")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20261110202811.2409395-2-mic@digikod.net
- Check the non-change case separately, with its own comment (suggested
  by Serge Hallyn).
- Shorten the commit message (suggested by Serge Hallyn).
- Add Serge Hallyn's Reviewed-by.
---
 security/commoncap.c | 45 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..9794a594bdd9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1283,6 +1283,26 @@ static int cap_prctl_drop(unsigned long cap)
 	return commit_creds(new);
 }
 
+/*
+ * Doing anything with securebits requires privilege (go read about the
+ * "sendmail capabilities bug"), except for unprivileged bits.  Indeed, the
+ * SECURE_ALL_UNPRIVILEGED bits are not restrictions enforced by the kernel but
+ * by user space on itself.  Only checking CAP_SETPCAP when it is needed keeps
+ * LSMs from seeing (and logging) a capability check for unprivileged changes.
+ */
+static bool securebits_need_setpcap(unsigned long old, unsigned long new)
+{
+	const unsigned long unpriv_and_locks = SECURE_ALL_UNPRIVILEGED |
+					       SECURE_ALL_UNPRIVILEGED << 1;
+	const unsigned long changed = old ^ new;
+
+	/* For legacy reasons, a non-change requires privilege. */
+	if (!changed)
+		return true;
+
+	return changed & ~unpriv_and_locks;
+}
+
 /**
  * cap_task_prctl - Implement process control functions for this security module
  * @option: The process control function requested
@@ -1346,28 +1366,9 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
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

