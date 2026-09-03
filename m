Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706714AA596
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439647; cv=none; b=R1jZd47Lz5LdhPYm7J2riwPelUWJaeMurAssZXeaJlbMGxvMOIgA1cO2rXos77H8FcJ1HPoMOv6dHgXCguoMAV8mWB00tjrZ1idoMKiaVAZwA1trnKsK/GwTazPSFRc44aITUZwSV3crQMMVrTrchBvHao7ZsUTlc+eSH65lPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439647; c=relaxed/simple;
	bh=svIExkJrS8Soh7k93hSYQYh+JUUh1OE1ola0iVsiLNw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cs8TZTT651SG+eiVQ1l3N+8dWRpc5x3yjtj0qO63zXLUNL/GoEupSiHwSthnMDG3zNJ2fFhjLQO1wMJwtyltMoULExYtrANHdwDyNcRAxHuutja4S872lbJs9bXGWVuHtFK8j2UQcf6r2SyF/H9UxEiclp1moxeVaMqYoS+HO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7YNjCb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7YNjCb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85531F000E9;
	Thu,  3 Sep 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439646;
	bh=aysMSK/0qWp7Qp2MwTuqxDFgdLWO945bOA46AVmf0Q0=;
	h=Subject:To:Cc:From:Date;
	b=w7YNjCb/xWRHtjmv3SeD4UlGYGgQ3IgyzFPmfKAk/j8faTpFo/s5bwi7xvMD1gaBR
	 DTn8BlyrtR2FZcU8FV39ZuA8XsH4eNoFQoojxc6ccw/ce/S5+nL/r8HICbvIVjVlRZ
	 KwDumHwwYV9FHKKOfCkivFSLjd0fO/OfYR3gjUg4=
Subject: FAILED: patch "[PATCH] x86/locking: Use sfence for wmb() if SSE is available" failed to apply to 5.10-stable tree
To: me@ziyao.cc,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:53:23 +0200
Message-ID: <2026090323-fanfare-undamaged-c63a@gregkh>
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
git cherry-pick -x d824ed1307680dd482f607b0e707c575f70668c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090323-fanfare-undamaged-c63a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d824ed1307680dd482f607b0e707c575f70668c4 Mon Sep 17 00:00:00 2001
From: Yao Zi <me@ziyao.cc>
Date: Sat, 1 Aug 2026 18:29:53 +0000
Subject: [PATCH] x86/locking: Use sfence for wmb() if SSE is available

When adding cc clobber to wmb()'s definition, the alternative()
condition to use sfence was incorrectly raised from X86_FEATURE_XMM to
X86_FEATURE_XMM2.

Restore the correct constraint for potential better performance on
machines without SSE2.

Fixes: bd922477d935 ("locking/x86: Add cc clobber for ADDL")
Signed-off-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260801182953.15069-1-me@ziyao.cc

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index db70832232d4..3e78bb76153c 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -17,7 +17,7 @@
 #define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
+				       X86_FEATURE_XMM) ::: "memory", "cc")
 #else
 #define __mb()	asm volatile("mfence":::"memory")
 #define __rmb()	asm volatile("lfence":::"memory")

