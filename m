Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0945A28B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322705; cv=none; b=qAGCqRKTX2sBvyFlaOlrBJ5WUvvq1UT5UcK+6sfKK0u8Wuuj9jxgzpIG4JgrX0CvFs0pCt67mFDHbq70SmyVqsfrb6PwbxeAh3+JNZL0xAsw5VcOWG8QVd7MNFdC3CTY/9VOazhUG4fhfC9IfD4c2GKwQfO2r0DPhMkEPn2Fbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322705; c=relaxed/simple;
	bh=KiG/WTl1rf56zYQ5xYtYq0WljVIk0+9hhxtna1oSONk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V4IxkaTNoQ6/5nkZc9omy5EXxQ1gru4OiOUnKwvm/pbT2fuKEuSd4IikkJeohnsrzevMkjOj5fQMP17bJCcMFvlWiXbvJakg5mkDzt9SMSVUQlt9ml9RyJBZ8KAmsIyF0Rej/NCpjJRdIE+1j8kcuqcm7HUoKEJ4DptGsp207Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GR+8v8BK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GR+8v8BK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD01F000E9;
	Wed, 29 Jul 2026 10:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322704;
	bh=j1U5Y7dTlx6TeAIWSJUxVzZ7sQx/lIGrR2l00TmJWho=;
	h=Subject:To:Cc:From:Date;
	b=GR+8v8BKqI7fq3EeifUF8AOyJWymbarSYHzpQAEZg1M6H1qVX9HDX5JJfXtSa5lhH
	 7qGoKh0LIOWEQWT+ppPgLxcyQaqQ4LS9BwZoh0qv3wG1WmApWiLyh3ms/zaRfinQGU
	 YHuAkN1SJPrf6NnYHJtkxdtk/7Osa7DKk2dhvYWY=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:58:03 +0200
Message-ID: <2026072902-purity-frenzy-fc0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e70086a3a06d276b4a5d9a2c51c9330c6cf72780
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072902-purity-frenzy-fc0b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e70086a3a06d276b4a5d9a2c51c9330c6cf72780 Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:19 -0700
Subject: [PATCH] drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unconditionally whitelisting OA registers is a security violation. Set
RING_FORCE_TO_NONPRIV_DENY bit in OA nonpriv slots, so that OA registers
don't get whitelisted by default after probe, gt reset, resume and engine
reset.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-2-ashutosh.dixit@intel.com
(cherry picked from commit 90511bdcfda97211c01f1d945d4ea616578d8fca)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index fb65940848d7..d3bfc05949ae 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -104,10 +104,12 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 				   RING_FORCE_TO_NONPRIV_ACCESS_RW))
 	},
 
+#define WHITELIST_DENY(r, f) WHITELIST(r, (f) | RING_FORCE_TO_NONPRIV_DENY)
+
 #define WHITELIST_OA_MMIO_TRG(trg, status, head) \
-	WHITELIST(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
-	WHITELIST(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
-	WHITELIST(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
+	WHITELIST_DENY(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
+	WHITELIST_DENY(status, RING_FORCE_TO_NONPRIV_ACCESS_RD), \
+	WHITELIST_DENY(head, RING_FORCE_TO_NONPRIV_ACCESS_RD | RING_FORCE_TO_NONPRIV_RANGE_4)
 
 #define WHITELIST_OAG_MMIO_TRG \
 	WHITELIST_OA_MMIO_TRG(OAG_MMIOTRIGGER, OAG_OASTATUS, OAG_OAHEADPTR)

