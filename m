Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9330E82D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005991; cv=none; b=Xa3SvO9QQ58XH89ANrjKjrvezjda89Z6WCGUTpcimPAfdH0t3Kg8idnsqH1DUpiY6yy3e44iQj0ktTSbnlqULtLSpOwJSwxQv3bgaFvEA4UhnJcOEJRHjohg+QhPdG7YzDsVfgL0HdXihNP7wlcMJy3AMmllPYDAYjHg7Nz75gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005991; c=relaxed/simple;
	bh=rxA2g75mZ2zg4WRZA/M0wg/BD4vaXQZyz0JOAv3FOk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzRlEeYPk1wCW/l0CXxJroW7aJkYzbvE8npZSwyc0HQZAENOeBmCK3PDBOHtxY13U86NknjVCKmNcI/9f2Wqr+/oYSKobwX7kEQ+OIV66vLaaXosPocbrev0xV+2NIZlkoL0v8oU/Zj+iqcn19J6NILHPSYvZ+M08Bfv0olq3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgyGEVfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgyGEVfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA461F000E9;
	Thu,  2 Jul 2026 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005990;
	bh=GVV0eXw6QGhbOUwbf2ycu3cMPbwOpommhUQ8YFYOKII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OgyGEVfQ2D9Sj/xAuMuld7hfxvMLajEXUXhqUKWz607MSw+Q5Ruu05WNKriRnhGWM
	 75JA1BJ3ZWdT2XCa/y07QrNGKmlLFhz2UMizm7k1768R1GWY7qpIHCOML8NEM7L1Mi
	 EvzSDHCY2FChsBDnkRSN60oYodT0UKi7dtrBHqipIBdGKU79iNnhtvUCnULcEJ2Bmk
	 oi1O0llcRITcMdfc92RKSbNEgB+4IT0s4lWv2K/5wNfgdC8xaqujjzvk77D073+LGt
	 7/jKKR91HlOY4gh57wkmtnbQvERoNcXwaLH7fnaTrIy3Mj8TBePbjRb0EIH9Ps15UO
	 PWO4+FfCs6RNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruslan Valiyev <linuxoid@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] apparmor: fix use-after-free in rawdata dedup loop
Date: Thu,  2 Jul 2026 11:26:28 -0400
Message-ID: <20260702152628.3530333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070221-sulphate-cauterize-488e@gregkh>
References: <2026070221-sulphate-cauterize-488e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruslan Valiyev <linuxoid@gmail.com>

[ Upstream commit 6f060496d03e4dc560a40f73770bd08335cb7a27 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/include/policy_unpack.h | 19 +++++++++++++++++++
 security/apparmor/policy.c                |  8 ++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
index 61cc9b5b8a1f36..b6af40885860b4 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -122,6 +122,25 @@ aa_get_profile_loaddata(struct aa_loaddata *data)
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
index 62ac50db5f803e..46d84d3a099866 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -976,8 +976,12 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 		if (aa_rawdata_eq(rawdata_ent, udata)) {
 			struct aa_loaddata *tmp;
 
-			tmp = aa_get_profile_loaddata(rawdata_ent);
-			/* check we didn't fail the race */
+			/*
+			 * Entries remain on rawdata_list with
+			 * pcount == 0 until do_ploaddata_rmfs()
+			 * runs; only take a live profile ref.
+			 */
+			tmp = aa_get_profile_loaddata_not0(rawdata_ent);
 			if (tmp) {
 				aa_put_profile_loaddata(udata);
 				udata = tmp;
-- 
2.53.0

