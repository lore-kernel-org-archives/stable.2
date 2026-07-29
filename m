Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA446E01D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322697; cv=none; b=mmSaOKOXjiccCIHjbQN3JcOKHPqZu57QOnCAZyUAN4jyIVEWO7VjCXsYu98QhJ/jECjmoMelYoYYjvFjuYQgSI3hSWQy/6Rb++Tvu6KI922UjPZ+t2T2k22Ao1J3e8pnC6wtBlVz97wSQfpHuTLlq1jROgZ3JxVRYBgYlVZNVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322697; c=relaxed/simple;
	bh=uPKf3PTi8dbM8alxSwXEEcEJflU+LA4Gq8ylJrlVdT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=THhAq/yeofB0+xkwJVHDquBhONmdcDcTB9ZKO13BGpp1VkQFTnKsljkrsJs1DMYlODG0ZMUVGUe/DJsay+UQCtitJmwu4BwNIPOxSVfxI4BSxDmN8iJnvoD5lz9No2H0XREbtgbigoK00NqGgmnPM86uhzQIL6NravpV3Z1AvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=POtvRxq1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="POtvRxq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795061F000E9;
	Wed, 29 Jul 2026 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322696;
	bh=dfXy/rXuEPrmWxrzkBiCmnAL2p30/7Q5XcKdLOVvMEk=;
	h=Subject:To:Cc:From:Date;
	b=POtvRxq1LqYZcVyIfkPpd04p+y63c2V+POp9PfSZJWUrya6Wc1pA2Up30e/sfDq5B
	 LZusisnyLa98lcDur5M0qpPc9I990S0ICyY/ZWzqShX2S2te6lCecfOdZhJv3Ggnml
	 WMk8/z6qn2h77NKu36m9K7MxAam14j9xj+ZeQ8zw=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists" failed to apply to 6.18-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:58:02 +0200
Message-ID: <2026072902-gorgeous-negligee-5e08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e70086a3a06d276b4a5d9a2c51c9330c6cf72780
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072902-gorgeous-negligee-5e08@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

