Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB154AA596
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439641; cv=none; b=ciSwhORmKDXkwKBxGvqhn3LaZ4n0k2vc1tdllCQpYJeYO49LMA4dEeVlY2ioMqRtsghczRDuZMh4U3QgM469AIuykHHfzygZMmKpnEv/zURGQ/1S2g3bcP+utPZp/it308jlpW2CEZCYU5qf4xnItgHJdaFzcNbVU/x4KIvnkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439641; c=relaxed/simple;
	bh=nxHPeHNR0hU5EgbxatpLgPnFwma7JxR9qiB0u75Fokc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J56VXQtLVnPX8Y3zxeUYA3j3D5T4af+7lEQbR3F//nFy/7dXULG1tU02Q5prryvvVSFJY1eh4wo991gZlbyTvtj7/NK5T3ksG4stJgLpXl0XCgPM30Ma3Yt+B564+rvr7OA5WPM8wgE4obYyWVhPQ+rOQZ8PAAvOLR1/cmYL/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1KxHANyT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1KxHANyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE681F000E9;
	Thu,  3 Sep 2026 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439640;
	bh=qPxLGKJiUEqfyw25s+5mjQvPVXgVfXr8dY8wwEEDn4Q=;
	h=Subject:To:Cc:From:Date;
	b=1KxHANyTE1k+GxBTR/fiBsm3wtuKBN41D7sUsbIDMSV/8En3CQ2gSCQcsqUujLajr
	 CUiEjtsh42KheWYM9oyAfx2dD6JRejoQXpWmd7JRuwbIEOg53nYs8mP6FdpTawIlv8
	 7j4KOGLjxTTAOvA3uDRH570b/uVxWASkv4KkbjuU=
Subject: FAILED: patch "[PATCH] x86/locking: Use sfence for wmb() if SSE is available" failed to apply to 6.12-stable tree
To: me@ziyao.cc,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:53:22 +0200
Message-ID: <2026090322-unsaid-demote-cc78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d824ed1307680dd482f607b0e707c575f70668c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-unsaid-demote-cc78@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

