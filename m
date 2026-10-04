Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430115746F
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099451; cv=none; b=PR1mHh+EuM7r7cJSrgERJT5SxnqDre0DdmamX4HYJCKDGGVeLW5kO7cE6pLzEzQiOIC8J+z5MywUVWpv70fXe70K61YDyOxFHEznMNgBRoI3fYrWosAH8VTc5DaB3Uez/CIKdwzvb26schgy1iX4BlO0Rvl3LiEcGFefZ0Umzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099451; c=relaxed/simple;
	bh=RpFEFCpPSyO63BDgpy6eYcmtlAr9m5shErg1bROGwVo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b8ogRJoEMR/cTzxAILJxSTsK4BFnSDPMHJGAU6CxxkaJzjqPmNo07ImoS2hdUqhOG0MnEOV4ZyRigXG8DGGKlAEl4rY9ISgVsHWR8F346qx7w5J0r08PDVDA0EGfxVDbje9ekxcyS3103R7YnUJ4ReX7utbL/3aeszIB3r5xprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vb+Cb9lX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vb+Cb9lX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391A11F000FF;
	Sun,  4 Oct 2026 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791099449;
	bh=iPH1JK5WMvR9Kc9O2LH1YGwJj+Qq9+J1WeRfivkUJqM=;
	h=Subject:To:Cc:From:Date;
	b=vb+Cb9lXwzZuAeRnNLTdx8RpnsRi5ZyTCLlRadR5tVnQ1aNfGQQwle32SsRrR81Ea
	 2s89ScT31kgg60v8asnrrP4EJDQfil+oQEtDG7oGsQuy0PDtOQYNCsSJENcc4n5tAW
	 PimjjtGuxzmUnfvCjApCfnodsidX2nAbGlVp6AMY=
Subject: FAILED: patch "[PATCH] vt: selection: Fix unsigned underflow and slab-out-of-bounds" failed to apply to 5.15-stable tree
To: benquike@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 04 Oct 2026 09:37:09 +0200
Message-ID: <2026100409-flashcard-glade-b72f@gregkh>
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
git cherry-pick -x 39495ef5d6f8019e62d65807f217a7ca8232727a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100409-flashcard-glade-b72f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39495ef5d6f8019e62d65807f217a7ca8232727a Mon Sep 17 00:00:00 2001
From: Hui Peng <benquike@gmail.com>
Date: Sat, 19 Sep 2026 11:00:41 +0000
Subject: [PATCH] vt: selection: Fix unsigned underflow and slab-out-of-bounds
 read in paste_selection()

In paste_selection(), the loop copies min_t(unsigned int,
vc_sel.buf_len - pasted,tty->receive_room) bytes per iteration into
tty_ldisc_receive_buf() and increments pasted += count.

Because the selection mutex (vc_sel.lock) is dropped inside the loop
Whenever the line discipline buffer fills up and paste_selection()
sleeps on tty->write_wait, a concurrent TIOCLINUX (TIOCL_SETSEL) ioctl
can replace vc_sel.buffer with a shorter selection and reduce
vc_sel.buf_len below pasted.

When paste_selection() resumes, vc_sel.buf_len - pasted underflows as an
unsigned integer to a large positive value, causing
tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL, count) to read
up to 4094 bytes out-of-bounds past the newly allocated vc_sel.buffer.

Fix this by terminating the loop when pasted >= vc_sel.buf_len.

Kernel stack trace (Linux 7.3.0-rc3):
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in n_tty_receive_buf_common+0xa01/0x1650
 Read of size 4094 at addr ffff888101c58010 by task kworker/u17:1/65
 Workqueue: events_unbound flush_to_ldisc
 Call Trace:
  <TASK>
  dump_stack_lvl+0x70/0xa0
  print_report+0x153/0x4c6
  kasan_report+0xf1/0x120
  kasan_check_range+0x11c/0x200
  __asan_memcpy+0x29/0x70
  n_tty_receive_buf_common+0xa01/0x1650
  tty_ldisc_receive_buf+0x66/0x110
  tty_port_default_receive_buf+0x6b/0xb0
  flush_to_ldisc+0x1b4/0x410
  process_one_work+0x6ff/0x1110
  worker_thread+0x4a8/0xb70
  kthread+0x307/0x3e0
  ret_from_fork+0x3ed/0x680
  </TASK>
 ==================================================================

Fixes: e8c75a30a23c ("vt: selection, push sel_lock up")
Cc: stable <stable@kernel.org>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
Link: https://patch.msgid.link/20260919110041.3763078-1-benquike@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 13f4e48b4142..f1a3bc5b5fad 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -434,8 +434,8 @@ int paste_selection(struct tty_struct *tty)
 			bps = NULL;
 		}
 
-		count = vc_sel.buf_len - pasted;
-		if (count) {
+		if (vc_sel.buf_len > pasted) {
+			count = vc_sel.buf_len - pasted;
 			pasted += tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted,
 							NULL, count);
 			if (vc_sel.buf_len > pasted)

