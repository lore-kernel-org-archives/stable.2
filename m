Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321760;
	b=L7zXUsMJ7TjERxUvJcZKBUov/xLQg/+UZZRJuQ/0EZpDLzmyzZ+qJt6SN0he2xNqnSoG
	 49Hj6LGh7fZCL7IpWem04fLcLl+nl6/8x88cx6nrfGEjFVA945B9sbt150Xu93m+qoaud
	 3Sb1jClIlhNBrdsoDIRwCK89uc2iivKiKDjL0lyJfK20ayoMlQwYYtMxtI7ZkbDUlX7fN
	 tyUkvdN7BvVOBbTrW4FOIU39gfYth/Wf25Qm/s2Gc6uCr1p8k4W3LLdyHmUl/PLdgTfB6
	 H57IeC9PEikeqt3eOUiEU5Y9OXQ53+2sovTRtFs2a/sVFUTFRZbywqnZvJaZiDGYfOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=EBvJvQIhk4ppMA+gv65m7RWSrY+BMyw9S1PCdUauxHE=;
	b=pAUMPWJYimrEUrFO7kCFle23rT/ZX5k+OT7rAP7gtGtI/Bcq9lRrhtOc7kGUIYriE9B3
	 qvjve863lMTdD/wqFJRcKUV9WcENI/KTSREk7hONCDisWiuql5QuAdfvFcRkaL2VxdMv2
	 Qbv/0v/JhRodZZlJIGJ2Xl2r0Bf5iAjDGGMZkQ5EG9Dp94uchJ3s8fMhPH0qgTxLZbNOy
	 FgY/dzxFLLOVWORwvAeOtZx+h6OLoozOzn2EsiHwT3OiUFM/0Q8LcP7Bjr5gGmmglrE0E
	 f8GEXDY0ML/FX1qg9tmj9dwtlM3yI11prUEtOrPTgSOtQJG03XPENXVhjVnaGTrxVUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=XajUHfZd;
	arc=none smtp.remote-ip=45.157.188.14
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA2606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BACA2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=XajUHfZd
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jP8WT1rSqzSH7;
	Tue, 10 Nov 2026 15:42:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794321749;
	bh=EBvJvQIhk4ppMA+gv65m7RWSrY+BMyw9S1PCdUauxHE=;
	h=From:To:Cc:Subject:Date:From;
	b=XajUHfZd3bFKUuh8801cAMV/wLlEJA/fZZOUcO4QML5qjF2you4uth2JC/50PQ6PW
	 5tMM3BArZYFH7UefdX0vnlv1dhiT89WiOgUDSrpSVSWHo6nhPeDSBcNDGB4D+uhi1K
	 mo8jQ+zA5vfdHXTWnU24m+30gr14RaO+UkQLQ9WY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jP8WR300JzdJG;
	Tue, 10 Nov 2026 15:42:27 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>,
	stable@vger.kernel.org
Subject: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for mapping uid 0
Date: Tue, 10 Nov 2026 15:42:04 +0100
Message-ID: <20261110144205.2404088-1-mic@digikod.net>
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

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
records in parent_could_setfcap whether the creator of a user namespace
had CAP_SETFCAP, because a creator writing its own uid_map only has
capabilities in the new namespace.  The snapshot uses cap_raised(), so a
task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
namespace it creates.

Use security_capable() against the parent namespace instead: the
creator's credentials still belong to it at this point, so commoncap
returns the same result, and only LSM denials are added.

Do not audit this check: creating a user namespace does not use
CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
that later fails has no LSM audit record.

Checking CAP_SETFCAP when the map is written would not work: the
writer's credentials then belong to the new namespace, where commoncap
grants the creator all capabilities.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: stable@vger.kernel.org
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

This is independent from Josef Bacik's series, which reworks this code
to close other ways around the CAP_SETFCAP rule:
https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com

That series still computes the creator's CAP_SETFCAP with cap_capable()
and cap_raised() in cap_setfcap_level(), so it would need the same
change.
---
 include/linux/user_namespace.h | 5 +++--
 kernel/user_namespace.c        | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 91232053775d..370961fde45f 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -86,8 +86,9 @@ struct user_namespace {
 	kgid_t			group;
 	struct ns_common	ns;
 	unsigned long		flags;
-	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
-	 * in its effective capability set at the child ns creation time. */
+	/* parent_could_setfcap: true if the creator of this ns could use
+	 * CAP_SETFCAP in the parent ns at the child ns creation time.
+	 */
 	bool			parent_could_setfcap;
 
 #ifdef CONFIG_KEYS
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index cd748e1cbace..57b7f10be74e 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -128,7 +128,13 @@ int create_user_ns(struct cred *new)
 	if (!ns)
 		goto fail_dec;
 
-	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
+	/*
+	 * verify_root_map() relies on this once the creator only has
+	 * capabilities in the new namespace.  Let LSMs deny it, but do not
+	 * audit: the creator may never map uid 0.
+	 */
+	ns->parent_could_setfcap =
+		!security_capable(new, parent_ns, CAP_SETFCAP, CAP_OPT_NOAUDIT);
 
 	ret = ns_common_init(ns);
 	if (ret)
-- 
2.56.0

