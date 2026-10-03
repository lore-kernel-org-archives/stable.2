Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D48BA34
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033357; cv=none; b=Z1BSEwFDuP7qSAJ+Wetp8tqIjYJPpKCyIIGrFR0WZ/eyyb3a6j9Vvm1Gacd6EN7ywyn2tszK6kK11GpbiW42IbUt/A1aD1H0+ywGhIp97Cc+sNHaxNeZqg/CVWsz4HBZWJG5gZRITJzrx+tGxO8DgG5ZRfW62mjjHIZDuMU091c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033357; c=relaxed/simple;
	bh=TanDfKmk8z8nPoNI3Rcq6g+5cItK+hBP6NrIW5BSipw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kaOwZSdRIG7duUz/h5YrjqODLW0jyblIGEb3IBzgrg2DszX51edqJBq355JbAuiCNbTT5Q5ZAwAcO7cXKf/x17tSqpu8z7Y+qcVajTs1TS4HAaos5wYlWE4parTlPyDb96aoVYMibY4dB3RuB5XTzZ9nfyrICcdLkhmO8nTrJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j6PrhXnM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j6PrhXnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF321F0089B;
	Sat,  3 Oct 2026 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033356;
	bh=eWshmHoqUmLvMQ3t4DuMnb3P+n0/VEZ9oGQ3kHglZ0Q=;
	h=Subject:To:Cc:From:Date;
	b=j6PrhXnMIgrWV0BB3ZOokYB9fMp0q0dWcD+UaSkEiEDkhlHF+nEc4Pi3edpzcfwXR
	 IHOhvHqKVohGczCQZnh035QejIrXdoWlFgDaxPEGJ9JT9Od93dSABSbwhdHNt+68ch
	 gwXYzFBRwSUN5d9NU9RnSsxQT10/A4Mfwkdg8q1o=
Subject: FAILED: patch "[PATCH] kprobes: Skip disarmed probes when checking optkprobe overlap" failed to apply to 5.10-stable tree
To: leon.hwang@linux.dev,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:15:45 +0200
Message-ID: <2026100345-divorcee-other-8be6@gregkh>
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
git cherry-pick -x 7a39c732a22ec4a369af9e19fbe3d666ec83eec4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100345-divorcee-other-8be6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

