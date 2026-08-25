Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363D38B154
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664469; cv=none; b=gejsP05JGoi43BAryGR53tR9Ucx7tVPp81TPoIXiBLHKRYHwhyvcNK/LI3pHJKAdb2gydZ+YYVz5Rh9dmCR2ccGGSPn6b/DGSdqkwOWsJd8pNUtuOUqvBKjpGFI8b2vTRqRb4Kc/rtHOdgqYoQi1QiNr1ZYY6TKgsRH8PwflreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664469; c=relaxed/simple;
	bh=sB8w7icDhblNM19I/EDhKyOKG5h7KK7ZDL0y1lspcZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4M4sTVCymViKUSrFjK0YFdj1IX6SO2rhit1dLHkSZmthcfW+cyeasmKcHJIuNYIe55cMZM1tGL39/HP2+qnZpvD370niLwoqhrSXIdV2p13R2GCorfkgTKkWN/oCc7I266HouORxdPqM+Mb8WOSyYYWjkk6l6wbWAKfGndlqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k40e525P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k40e525P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025A01F000E9;
	Tue, 25 Aug 2026 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787664464;
	bh=BgqJ1DxLrX17GVYxoEEDZbEELkXAK40zFLXc/H2PjFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k40e525PwqgPhd3epAyNFweqQ1flkV6nx+6TQZtOS9O/4qJkdn8ly1XsS99M1SdLw
	 FffoXpHFEwLqjDBOKI+5wVn/jYPnExyD6IXZB4l8mIX9hUPKEr0SzhJZpJHWqGP7of
	 DsRJI/CZrnOBUPGU+3pWnnQ1usD7Wa6m1lLWStfa4yBiGk9w8yaRnQY0qlCm/vibzC
	 Yr6aOhgCdh6vlR7RfSXJ/WoxtL+BnoFzzXV7UBUEwjQ+HhTECL9wbW/sud3lnGptJi
	 MuWkpLpUEHH2rXDAcu5jTXxiTxij0N0iq3GB41ZzgojDZnzdsB8K/Wo9Ll95ZVhL6L
	 /E7iWEUmHaCwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] selinux: uninline unlikely parts of avc_has_perm_noaudit()
Date: Tue, 25 Aug 2026 09:27:40 -0400
Message-ID: <20260825132742.3865669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082039-waffle-overlabor-d7cc@gregkh>
References: <2026082039-waffle-overlabor-d7cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit f62ca0b6e31d82e0622a8e31ce5562e80edf6c3c ]

This is based on earlier patch posted to the list by Linus, his
commit description read:

 "avc_has_perm_noaudit()is one of those hot functions that end up
  being used by almost all filesystem operations (through
  "avc_has_perm()") and it's intended to be cheap enough to inline.

  However, it turns out that the unlikely parts of it (where it
  doesn't find an existing avc node) need a fair amount of stack
  space for the automatic replacement node, so if it were to be
  inlined (at least clang does not) it would just use stack space
  unnecessarily.

  So split the unlikely part out of it, and mark that part noinline.
  That improves the actual likely part."

The basic idea behind the patch was reasonable, but there were minor
nits (double indenting, etc.) and the RCU read lock unlock/re-lock in
avc_compute_av() began to look even more ugly.  This patch builds on
Linus' first effort by cleaning things up a bit and removing the RCU
unlock/lock dance in avc_compute_av().

Removing the RCU lock dance in avc_compute_av() is safe as there are
currently two callers of avc_compute_av(): avc_has_perm_noaudit() and
avc_has_extended_perms().  The first caller in avc_has_perm_noaudit()
does not require a RCU lock as there is no avc_node to protect so the
RCU lock can be dropped before calling avc_compute_av().  The second
caller, avc_has_extended_perms(), is similar in that there is no
avc_node that requires RCU protection, but the code is simplified by
holding the RCU look around the avc_compute_av() call, and given that
we enter a RCU critical section in security_compute_av() (called from
av_compute_av()) the impact will likely be unnoticeable.  It is also
worth noting that avc_has_extended_perms() is only called from the
SELinux ioctl() access control hook at the moment.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: 22b05fec62c0 ("selinux: reject an unclaimed class value in security_get_classes()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/avc.c | 85 ++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 8984ba92676db..d5ad01834dd67 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -988,25 +988,26 @@ int avc_ss_reset(struct selinux_avc *avc, u32 seqno)
 	return rc;
 }
 
-/*
- * Slow-path helper function for avc_has_perm_noaudit,
- * when the avc_node lookup fails. We get called with
- * the RCU read lock held, and need to return with it
- * still held, but drop if for the security compute.
+/**
+ * avc_compute_av - Add an entry to the AVC based on the security policy
+ * @state: SELinux state pointer
+ * @ssid: subject
+ * @tsid: object/target
+ * @tclass: object class
+ * @avd: access vector decision
+ * @xp_node: AVC extended permissions node
  *
- * Don't inline this, since it's the slow-path and just
- * results in a bigger stack frame.
+ * Slow-path helper function for avc_has_perm_noaudit, when the avc_node lookup
+ * fails.  Don't inline this, since it's the slow-path and just results in a
+ * bigger stack frame.
  */
-static noinline
-struct avc_node *avc_compute_av(struct selinux_state *state,
-				u32 ssid, u32 tsid,
-				u16 tclass, struct av_decision *avd,
-				struct avc_xperms_node *xp_node)
+static noinline struct avc_node *avc_compute_av(struct selinux_state *state,
+						u32 ssid, u32 tsid, u16 tclass,
+						struct av_decision *avd,
+						struct avc_xperms_node *xp_node)
 {
-	rcu_read_unlock();
 	INIT_LIST_HEAD(&xp_node->xpd_head);
 	security_compute_av(state, ssid, tsid, tclass, avd, &xp_node->xp);
-	rcu_read_lock();
 	return avc_insert(state->avc, ssid, tsid, tclass, avd, xp_node);
 }
 
@@ -1112,6 +1113,36 @@ int avc_has_extended_perms(struct selinux_state *state,
 	return rc;
 }
 
+/**
+ * avc_perm_nonode - Add an entry to the AVC
+ * @state: SELinux state pointer
+ * @ssid: subject
+ * @tsid: object/target
+ * @tclass: object class
+ * @requested: requested permissions
+ * @flags: AVC flags
+ * @avd: access vector decision
+ *
+ * This is the "we have no node" part of avc_has_perm_noaudit(), which is
+ * unlikely and needs extra stack space for the new node that we generate, so
+ * don't inline it.
+ */
+static noinline int avc_perm_nonode(struct selinux_state *state,
+				    u32 ssid, u32 tsid, u16 tclass,
+				    u32 requested, unsigned int flags,
+				    struct av_decision *avd)
+{
+	u32 denied;
+	struct avc_xperms_node xp_node;
+
+	avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
+	denied = requested & ~(avd->allowed);
+	if (unlikely(denied))
+		return avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
+				  flags, avd);
+	return 0;
+}
+
 /**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
  * @state: SELinux state
@@ -1139,29 +1170,27 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 				unsigned int flags,
 				struct av_decision *avd)
 {
-	struct avc_node *node;
-	struct avc_xperms_node xp_node;
-	int rc = 0;
 	u32 denied;
+	struct avc_node *node;
 
 	if (WARN_ON(!requested))
 		return -EACCES;
 
 	rcu_read_lock();
-
 	node = avc_lookup(state->avc, ssid, tsid, tclass);
-	if (unlikely(!node))
-		avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
-	else
-		memcpy(avd, &node->ae.avd, sizeof(*avd));
+	if (unlikely(!node)) {
+		rcu_read_unlock();
+		return avc_perm_nonode(state, ssid, tsid, tclass, requested,
+				       flags, avd);
+	}
+	denied = requested & ~node->ae.avd.allowed;
+	memcpy(avd, &node->ae.avd, sizeof(*avd));
+	rcu_read_unlock();
 
-	denied = requested & ~(avd->allowed);
 	if (unlikely(denied))
-		rc = avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
-				flags, avd);
-
-	rcu_read_unlock();
-	return rc;
+		return avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
+				  flags, avd);
+	return 0;
 }
 
 /**
-- 
2.53.0

