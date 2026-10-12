Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194954A387F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820382; cv=none; b=ReITxa/tcDVR9w7kViFOh6rnxZbCckkaL+RTC5LP35hgrqxg+3l+HrkbyddTsIVC9rPJ0q5AOW1ZjCOoRBjPKry61TSeBbAfzrHbUXR6MyMKY+oTw51SiBiobqb/XPQ9hruZMTcsXqIsWsF32QFrcLMcqnwZe/HJDbdzM51Fn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820382; c=relaxed/simple;
	bh=K6elS/6/k2JN5YOsbKExahXePXOrb+5zzxe/Ri0Uvu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HaRCx0r/UZLsDUN0SFaIVv1pTn+dMtVh09afEl/n469IadowqFSV3FrUBF+DAS+aYNWEZbFfRez6IfPfE9ErcQoGXF9Hmp+KUqL2FLtNBp9gOEiU43vtLg0gV50zEJa7J+L262VH64+NI95uI2LEzwzp8b1DP+KFNaE1YPkzWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ej76Qt+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ej76Qt+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB5A1F0089B;
	Mon, 12 Oct 2026 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820380;
	bh=Pf9NiVR1XWNYbG9KTFaqpOcAE1C4Gy6Lz6P5MUh084s=;
	h=Subject:To:Cc:From:Date;
	b=ej76Qt+C+amCRpuN0dz4xqmBXZLPUJgU8fgYK1iNO09t6kf7DI1BzptEA02G6iflA
	 hlHmIIUOjEZs/95JbDLx8OHqJZ9rjbPl1Rf/cLjtnnsLthWjEd+DbuAz9VXpsW+m0+
	 EbumGuLYuz6cIumACpQMI49rCMb2R4ACuQlrRBW8=
Subject: FAILED: patch "[PATCH] unshare: don't drop active namespace references that were" failed to apply to 6.6-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:52:52 +0200
Message-ID: <2026101252-outburst-unreal-c7df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0b6f31a3c0b16066f812e94b52a704174a6f23cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101252-outburst-unreal-c7df@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b6f31a3c0b16066f812e94b52a704174a6f23cd Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:08 +0200
Subject: [PATCH] unshare: don't drop active namespace references that were
 never taken

Active references on the namespaces of an nsproxy are taken when the
nsproxy is installed into a task in switch_task_namespaces() and
copy_namespaces() and dropped again by put_nsproxy() through
deactivate_nsproxy().

But ksys_unshare() calls put_nsproxy() on an nsproxy that was never
installed when set_cred_ucounts() fails. The new namespaces of that
nsproxy go from zero to minus one and the namespaces shared with the
caller lose a reference that belongs to the nsproxy the caller keeps
using:

  WARNING: kernel/nscommon.c:171 at __ns_ref_active_put+0x1cd/0x230
   nsproxy_ns_active_put
   deactivate_nsproxy
   ksys_unshare

Afterwards the namespaces the caller lives in aren't listed by listns()
anymore. set_cred_ucounts() only fails when alloc_ucounts() can't
allocate and it only allocates when the real uid of the caller differs
from its effective uid.

Commit cefd55bd2159 ("nsproxy: fix free_nsproxy() and simplify
create_new_namespaces()") separated the two cases on purpose.
nsproxy_free() frees an nsproxy that was prepared but never installed
and that's what a failed setns() uses in put_nsset(). Export it and use
it for a failed unshare() as well.

Fixes: a98621a0f187 ("unshare: fix nsproxy leak in ksys_unshare() on set_cred_ucounts() failure")
Cc: stable@vger.kernel.org # v7.1+
Link: https://patch.msgid.link/20260930-work-mount-fixes-3-v1-16-be34c83956ae@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 5a67648721c7..dc2447f5f092 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -100,6 +100,7 @@ void exit_cred_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
 int exec_task_namespaces(void);
 void deactivate_nsproxy(struct nsproxy *ns);
+void nsproxy_free(struct nsproxy *ns);
 int unshare_nsproxy_namespaces(unsigned long, struct nsproxy **,
 	struct cred *, struct fs_struct *);
 int __init nsproxy_cache_init(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index da48168c504f..d442cd68a37a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3338,8 +3338,9 @@ int ksys_unshare(unsigned long unshare_flags)
 	perf_event_namespaces(current);
 
 bad_unshare_cleanup_nsproxy:
+	/* never installed, so no active references to drop */
 	if (new_nsproxy)
-		put_nsproxy(new_nsproxy);
+		nsproxy_free(new_nsproxy);
 bad_unshare_cleanup_cred:
 	if (new_cred)
 		put_cred(new_cred);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index d9d3d5973bf5..3fb1595a4a59 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -61,7 +61,7 @@ static inline struct nsproxy *create_nsproxy(void)
 	return nsproxy;
 }
 
-static inline void nsproxy_free(struct nsproxy *ns)
+void nsproxy_free(struct nsproxy *ns)
 {
 	put_mnt_ns(ns->mnt_ns);
 	put_uts_ns(ns->uts_ns);

