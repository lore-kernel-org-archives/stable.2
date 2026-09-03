Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33173481255
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439639; cv=none; b=nHAd88U8Br3GYYi9DXncisi8oavZ8Xpfm1sQtuI+kBlgpGPggv8oTQDwhzgSB5iL4zMlxt4VZB1IoBz9NcAX/HEL6w5O5c0HpO1seM3+VqL8nruUpbiSyWfC0jfj0C0i42NaRSMim80fmJX5m/Xjk+6Y8fnWyte6qR2S0LPJzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439639; c=relaxed/simple;
	bh=lU+jBe7snP2Na2dDbjxdDmAqEIz55vM9ntnv7NSCAYE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J7y7rql53UCeqtqzWeYh503/A/rwXzrkk19AtNiAec4JlVaAooemliIv8T2ZtIGHPPGuNObjNTnLI5xFjIoytnfpSBPzDBu73BQAdqZ7GaZVZq+7fuYcWgsxzRdx08fnwv9W7cUHgtejgDU/n6UX8fT2Ue0QN2MfjohgBcxR10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b/rr93gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/rr93gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FBF1F000E9;
	Thu,  3 Sep 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439637;
	bh=YdMw1QbTGdT0K16fu2DZ+aElw0YGWk4ZAXrzJi1OFIQ=;
	h=Subject:To:Cc:From:Date;
	b=b/rr93gjtpXQXoi4xYzyzf/YC9v6rEeZGPXeL7Brp1Q2A0y/kg3vcYJF5i9fEv+jK
	 grPNABx3TyjNOdRQgnni9WEh9FoHe8MpJNb9aO9fuWegkZrvZLNY5YlJdelSCZqtOA
	 4jeto1KB55T0B5xyhHRv4dzLSZfzvCzqU/do/oNE=
Subject: FAILED: patch "[PATCH] x86/locking: Use sfence for wmb() if SSE is available" failed to apply to 6.6-stable tree
To: me@ziyao.cc,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:53:22 +0200
Message-ID: <2026090322-entrap-donation-7004@gregkh>
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
git cherry-pick -x d824ed1307680dd482f607b0e707c575f70668c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-entrap-donation-7004@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

