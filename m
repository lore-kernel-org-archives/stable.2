Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6729BA34
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033349; cv=none; b=UfWQjF0kdGdISZgorbMxQ+oOBuzlkqAP0KUlIFg1Llg7Fa9/gqrkftj5C7A6wg+dN3QnEHJmdAtK4mMug+xIN0ILlcVDedIgqsRJiA3ToRWWApcXGogzlNiDTRa3eH5Qk0wOyItFzs5P4kzY2rS/d9H/pSgl7Jm9lMNE7LKMS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033349; c=relaxed/simple;
	bh=efXqRvHAdoZYr0G/12ypXNGMO6TQMG3PLRaxtE7K6BQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u+RkWPXS7hYeWa4iGLwbKXeiJV3TkIAVymvn4J3fUwYhCO3tnSIrLnAToj8x2myfJvO7gllKy77PetKJLGKV7vApWt7q+2f5DzzzROwHxz/kEWo1+UoQpeAdMiDoXJqlHEipT3PePhl4ajLcAEcWQvQ5cdbpyHYlSCQBduyOSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJs+x5tI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJs+x5tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009DB1F0089B;
	Sat,  3 Oct 2026 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033347;
	bh=kksmwmvizkQNntR3pGPGfPCP9lBDh8XDgr1rDqd5Hbw=;
	h=Subject:To:Cc:From:Date;
	b=AJs+x5tI/yD2nTiYCj4gLNOyPb490fa0MMjSovpyZCYCixCOQt6mCKJfj7cUrseKy
	 hu4xZP0E/A9Y1QIxwMHyp2aEQ5rsM1zr3gU6NrmpXB/pMKn3MBqlgsE6TFBaVxj+QA
	 OZ0Shq+lbATHeU3WkiGNl7mMHl/PyR2qtd4ZbtEo=
Subject: FAILED: patch "[PATCH] kprobes: Skip disarmed probes when checking optkprobe overlap" failed to apply to 5.15-stable tree
To: leon.hwang@linux.dev,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:15:44 +0200
Message-ID: <2026100344-anchor-outpost-f7ad@gregkh>
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
git cherry-pick -x 7a39c732a22ec4a369af9e19fbe3d666ec83eec4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100344-anchor-outpost-f7ad@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a39c732a22ec4a369af9e19fbe3d666ec83eec4 Mon Sep 17 00:00:00 2001
From: Leon Hwang <leon.hwang@linux.dev>
Date: Wed, 30 Sep 2026 13:36:18 +0800
Subject: [PATCH] kprobes: Skip disarmed probes when checking optkprobe overlap

On x86, an optkprobe at A replaces five bytes with a jump. If a disabled
probe B is at A+2, get_optimized_kprobe() stops at B when arming a new
probe C at A+4. It leaves A optimized:

              A    A+1  A+2  A+3  A+4
  A's jump  | e9 | d0 | d1 | d2 | d3 |
  after C   | e9 | d0 | d1 | d2 | cc |

The INT3 for C overwrites the last byte of A's jump displacement, so
execution can jump to the wrong address. B can have prepared optinsns
while disarmed, but has no jump to unoptimize.

Continue past disarmed and unprepared probes to find the active optimized
probe before arming a probe in its jump.

Link: https://lore.kernel.org/all/20260930053618.104498-1-leon.hwang@linux.dev/

Fixes: afd66255b9a4 ("kprobes: Introduce kprobes jump optimization")
Cc: stable@vger.kernel.org
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4edd8ca5c657..e787e4948c8b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -496,14 +496,16 @@ static bool kprobe_queued(struct kprobe *p)
 static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 {
 	int i;
-	struct kprobe *p = NULL;
+	struct kprobe *p;
 	struct optimized_kprobe *op;
 
 	/* Don't check i == 0, since that is a breakpoint case. */
-	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
+	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++) {
 		p = get_kprobe(addr - i);
+		/* A disabled probe can have prepared, but inactive, optinsns. */
+		if (!p || !kprobe_optready(p) || kprobe_disarmed(p))
+			continue;
 
-	if (p && kprobe_optready(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
 		if (arch_within_optimized_kprobe(op, addr))
 			return p;

