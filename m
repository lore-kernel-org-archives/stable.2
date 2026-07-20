Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC5419304
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551154; cv=none; b=iLcWcVmBujBG1DHVLA6tyi8qvr2b6aLYbCzRTbB7MIXig+ZZksPUKr6qBMszvxzWU+ddqJe+M2eNpFl+jnGyMiAe78bOVDcf4hj5y4Pvm4of8d3hkQ7HHsy61pXJV5Zr3ElR/+dCuVlpCMS53y+2VHgBcoojmTHjCrwNUJJk5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551154; c=relaxed/simple;
	bh=ExTKxPv0B2v2MpuvA1oIK0maP5czifkvKwyXndLnAhI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C5E9Jd3OHYQRaI778HiPkckeM+Vp4chDhX9s9/05CLGf3EUNZ/AQ9HBiW2dz3r1b2HKq8zrIW21Y2W8YJhV0ziWz8wvxuNOb+s+8zYn5xN/Z4sRGwPzWFNhdn7fiMrue4o0M/WZfUuZxKoGllFSh5cAH71k6jUsrzOkJYtloSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R7nifhEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R7nifhEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB2F1F000E9;
	Mon, 20 Jul 2026 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551153;
	bh=u/kPFUOsyM8yo6w0AJRE40GBL/ZYWMdDyLCc/pIUS5g=;
	h=Subject:To:Cc:From:Date;
	b=R7nifhEWxgRx61b+3w3k662ZVQ9tqYdXpXAH7ocU+axxRAL/jm27VvBSEFA0HE1HR
	 2qPchP4FVicCMHOPrWxhFJLx2/8rbDSYlJ1W91qxC2n5TFEq+GK/XBekPt4uZH6HMV
	 jjroMm7RuJd2iHgMs9KAsEIpa+4erxvVuja2WWbs=
Subject: FAILED: patch "[PATCH] perf/x86/amd/brs: Fix kernel address leakage" failed to apply to 6.1-stable tree
To: sandipan.das@amd.com,eranian@google.com,mingo@kernel.org,peterz@infradead.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:38:54 +0200
Message-ID: <2026072054-trickle-dance-0971@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 47915e855fb38b42133e31ba917d99565f862154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072054-trickle-dance-0971@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47915e855fb38b42133e31ba917d99565f862154 Mon Sep 17 00:00:00 2001
From: Sandipan Das <sandipan.das@amd.com>
Date: Fri, 10 Jul 2026 22:04:49 +0530
Subject: [PATCH] perf/x86/amd/brs: Fix kernel address leakage

A user-only branch stack can contain branches that originate from
the kernel. As a result, kernel addresses are exposed to user space
even when PERF_SAMPLE_BRANCH_USER is requested. On AMD processors
supporting X86_FEATURE_BRS (Zen 3 only), perf can still report entries
such as SYSRET/interrupt returns for which the branch-from addresses
are in the kernel.

E.g.

  $ perf record -j any,u -c 4000 -e branch-brs -o - -- \
        perf bench syscall basic --loop 1000 | \
        perf script -i - -F brstack|tr ' ' '\n'| \
        grep -E '0x[89a-f][0-9a-f]{15}'

  ...
  0xffffffff810001c4/0x72e2e32955eb/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94a9821/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94ffa1b/-/-/-/0//-
  ...

BRS provides no hardware branch filtering, so privilege level
filtering is performed entirely in software. However, amd_brs_match_plm()
only validates the branch-to address against the requested privilege
levels. For branches from the kernel to user space, the branch-from
address is left unchecked and is leaked. Extend the software filter to
also validate the branch-from address, so that any branch record whose
branch-from address is in the kernel is dropped when
PERF_SAMPLE_BRANCH_USER is requested.

Fixes: 8910075d61a3 ("perf/x86/amd: Enable branch sampling priv level filtering")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://patch.msgid.link/f05931c4f89a146c364bd5dc6b8170b1ac611c65.1783701239.git.sandipan.das@amd.com
Closes: https://lore.kernel.org/all/20260710110235.F3FD81F000E9@smtp.kernel.org/

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 06f35a6b58a5..dc564688f3d7 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -259,13 +259,13 @@ void amd_brs_disable_all(void)
 		amd_brs_disable();
 }
 
-static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+static bool amd_brs_match_plm(struct perf_event *event, u64 from, u64 to)
 {
 	int type = event->attr.branch_sample_type;
 	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
 	int plm_u = PERF_SAMPLE_BRANCH_USER;
 
-	if (!(type & plm_k) && kernel_ip(to))
+	if (!(type & plm_k) && (kernel_ip(to) || kernel_ip(from)))
 		return 0;
 
 	if (!(type & plm_u) && !kernel_ip(to))
@@ -338,11 +338,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
-		if (!amd_brs_match_plm(event, to))
-			continue;
-
 		rdmsrq(brs_from(brs_idx), from);
 
+		if (!amd_brs_match_plm(event, from, to))
+			continue;
+
 		perf_clear_branch_entry_bitfields(br+nr);
 
 		br[nr].from = from;

