Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A07428487
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981269; cv=none; b=To/NwlZSgJASDpX0MgP5kAKyz9qOc5LhLSZEKE4d8DD6uvmApGRteDcZM6C4M/Kctb1adKPyqTIfmE/x7f/Hc0k5JKKUurT1+IKNin6X0dXgYVDQ5r1RJQT9rvrXWT3+j+m9Et8X+WIDmZZgrS2DQFCq1cViGu1V+yj3euatne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981269; c=relaxed/simple;
	bh=nDydZw/mM/JoWuPsKZ6cRdWbP33VWVYHri5XWrR7cl4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s9s5tBgf/BxTyIgK/MZRkgj8qB5/oyKSZxm7Y343ftjNp+CcLNb2ZfuoDmX87lSTydCXagJzd1UPnYmwHzNO8zojrKb2bb8N5A/1rbd1s5+9IYeV+YAqN8pZZNd3uYQVbs8xDAe1r56rX9EYh5ak7/vAj0Lxx/3eTnX5e///FDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=byybcBUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byybcBUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CB31F000E9;
	Thu,  2 Jul 2026 08:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782981267;
	bh=r+770ipcwMoQmO73HuFDJZrkpTv8fEaRUaZ2U6pHMCw=;
	h=Subject:To:Cc:From:Date;
	b=byybcBUzWWhUg8TtQfgL9lWo3WSHE+K0pzJGXCK/yju6DKV4piVI8kZjPMSX9Dd4q
	 EcSgbsYHCVE1KaVIp5z+UjYfBIjk5vYFdNWVus0fhB5OvC9b6ZKLSop3vu815f1BIY
	 ssPyKRuH8+2xOgmF7CJkAntakxZSg1sVNLzsF77c=
Subject: FAILED: patch "[PATCH] apparmor: fix use-after-free in rawdata dedup loop" failed to apply to 5.10-stable tree
To: linuxoid@gmail.com,colin.i.king@gmail.com,john.johansen@canonical.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:29:21 +0200
Message-ID: <2026070221-sulphate-cauterize-488e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6f060496d03e4dc560a40f73770bd08335cb7a27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070221-sulphate-cauterize-488e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f060496d03e4dc560a40f73770bd08335cb7a27 Mon Sep 17 00:00:00 2001
From: Ruslan Valiyev <linuxoid@gmail.com>
Date: Tue, 26 May 2026 00:04:46 +0200
Subject: [PATCH] apparmor: fix use-after-free in rawdata dedup loop

aa_replace_profiles() walks ns->rawdata_list to dedup the incoming
policy blob against entries already attached to existing profiles.
Per the kernel-doc on struct aa_loaddata, list membership does not
hold a reference: profiles hold pcount, and when the last pcount
drops, do_ploaddata_rmfs() is queued on a workqueue that takes
ns->lock and removes the entry. Between dropping the last pcount
and the workqueue running, an entry remains on the list with
pcount == 0.

aa_get_profile_loaddata() is an unconditional kref_get() on
pcount, so when the dedup loop hits such an entry, refcount
hardening reports

  refcount_t: addition on 0; use-after-free.

inside aa_replace_profiles(), and the poisoned counter then
trips "saturated" and "underflow" warnings on the subsequent
uses of the same loaddata.

Before commit a0b7091c4de4 ("apparmor: fix race on rawdata
dereference") the dedup path used a get_unless_zero-style helper
on a single counter, so the existing "if (tmp)" guard was
meaningful. The split-refcount refactor introduced
aa_get_profile_loaddata(), which has plain kref_get() semantics,
and the guard quietly became a no-op.

Introduce aa_get_profile_loaddata_not0(), matching the existing
_not0 convention used by aa_get_profile_not0(), and use it for
the rawdata_list dedup lookup so dying entries are skipped.

Reproduced on x86_64 with v7.1-rc5 in QEMU+KVM running Ubuntu
24.04 + stress-ng 0.17.06:

  stress-ng --apparmor 1 --klog-check --timeout 60s

Without this patch the three refcount_t warnings fire within a
few seconds. With it the same 60 s run is clean. Coverage is a
smoke-test only; a longer soak with CONFIG_KASAN, CONFIG_KCSAN
and CONFIG_PROVE_LOCKING would be welcome from anyone with the
cycles.

Fixes: a0b7091c4de4 ("apparmor: fix race on rawdata dereference")
Reported-by: Colin Ian King <colin.i.king@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221513
Cc: stable@vger.kernel.org
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
index e5a95dc4da1f..b9de0fdf9ee5 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -163,6 +163,25 @@ aa_get_profile_loaddata(struct aa_loaddata *data)
 	return data;
 }
 
+/**
+ * aa_get_profile_loaddata_not0 - get a profile reference count if not zero
+ * @data: reference to get a count on
+ *
+ * Like aa_get_profile_loaddata(), but safe to call on an entry that may
+ * be on a list (e.g. ns->rawdata_list) where the last pcount has already
+ * dropped and the deferred cleanup has not yet run.
+ *
+ * Returns: pointer to reference, or %NULL if @data is NULL or its
+ *          profile refcount has already reached zero.
+ */
+static inline struct aa_loaddata *
+aa_get_profile_loaddata_not0(struct aa_loaddata *data)
+{
+	if (data && kref_get_unless_zero(&data->pcount))
+		return data;
+	return NULL;
+}
+
 void __aa_loaddata_update(struct aa_loaddata *data, long revision);
 bool aa_rawdata_eq(struct aa_loaddata *l, struct aa_loaddata *r);
 void aa_loaddata_kref(struct kref *kref);
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 847b0ff450c5..b59e827747da 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1230,8 +1230,12 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 			if (aa_rawdata_eq(rawdata_ent, udata)) {
 				struct aa_loaddata *tmp;
 
-				tmp = aa_get_profile_loaddata(rawdata_ent);
-				/* check we didn't fail the race */
+				/*
+				 * Entries remain on rawdata_list with
+				 * pcount == 0 until do_ploaddata_rmfs()
+				 * runs; only take a live profile ref.
+				 */
+				tmp = aa_get_profile_loaddata_not0(rawdata_ent);
 				if (tmp) {
 					aa_put_profile_loaddata(udata);
 					udata = tmp;

