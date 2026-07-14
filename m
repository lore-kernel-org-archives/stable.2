Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358348B37D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040667; cv=none; b=N5OGwaBvms8yFOfKHOVu4/a//gRV7KyxV305WicTK903L7AKmif5UBLAdGtBc8iyzh/E+/rwanrOUqvY3SBKf6OEhCdSlfBk/uZuS9/mRN3q7x55X5GCjeR+KKZMjX1XmqWPS+oxCVnDkQ9jKHjTf3cuSm18bv7oKqJEO/DHEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040667; c=relaxed/simple;
	bh=4perge6q1werx2318h19T72G5c4ilVkoRRCjM2OC3eg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uQBHhIs/YZ29wE6w6ktpnuZf3Uuvn3hFvWvwNi6qKOP0ZmDZ8xjZaKtWNbijoJGVtOBDi1JMdRiGUYhagQJKxKO6aKNmty8or1cIgDjtC3OOxP4doGkHb+FNeIswaKeBUFwFiJC1iN8nbEPUJZriJ3HoMVivqXF3HNd2nVh0TkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kxhaSPjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxhaSPjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC4E1F00A3F;
	Tue, 14 Jul 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040662;
	bh=Nn5CYtt5v7vKz6EMTpU0DiWPCim3IMeAUIQxdXnjrhI=;
	h=Subject:To:Cc:From:Date;
	b=kxhaSPjkGWoIT2A9f27IxqYldremgllRluHSdEqjyBmUqS2iJswvrPx68Ik3IWeBb
	 Uq2nsUZLvvgaULfPClSu5fNEZOwzuqg9TwGlkWlWzPumtjvuSrsxZGaB3cpCMeITEL
	 BQtrE9JpXM5fXD8CvM718Dj+CREZ3ogU4P73wMLg=
Subject: FAILED: patch "[PATCH] perf/x86/intel/uncore: Defer ADL global PMON enable to" failed to apply to 5.15-stable tree
To: zide.chen@intel.com,dapeng1.mi@linux.intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:50:05 +0200
Message-ID: <2026071405-reach-wasting-2c44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9a0bb848a37150aeccc10088e141339917d995dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071405-reach-wasting-2c44@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a0bb848a37150aeccc10088e141339917d995dc Mon Sep 17 00:00:00 2001
From: Zide Chen <zide.chen@intel.com>
Date: Tue, 2 Jun 2026 07:49:05 -0700
Subject: [PATCH] perf/x86/intel/uncore: Defer ADL global PMON enable to
 enable_box()

On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
may increase power consumption even when no perf events are in use.

Drop adl_uncore_msr_init_box() and defer programming the global control
register to enable_box(), so it is only set when a box is actually used.

IMC and IMC freerunning counters use a separate control path and are
unaffected.

Fixes: 772ed05f3c5c ("perf/x86/intel/uncore: Add Alder Lake support")
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260602144908.263680-5-zide.chen@intel.com

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3dbc6bacbd9d..edddd4f9ab5f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
-static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->pmu_idx == 0)
-		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
-}
-
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
@@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,

