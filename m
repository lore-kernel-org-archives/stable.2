Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634155;
	b=uWfFqPdw7+qVKGDaHok+j+XsbGVpAOsQ6/KSSGsHxJ5C0K9hRo5zS/nZh1oamp8kZsJL
	 +BnAt9+FOHvyd9s7KfZEzcC5p6vOQs7Jnw2XoPhqP43FPtJoVW9B+etpdyN2iGGbKeW5A
	 g2nesRFuZEK5jnJHivTLUmm/9MEDg3nwciu4/gIN7kmYtrRj5nKHjNrKf7NN8ccBrt24f
	 PGalZB84XFCd6i1OAG4wOkUSQkSFWii304LrSrJdPj1li9sBeG45VLduqLoevHGeeKJpG
	 JMUiDjrx+a4D/3/+o+1n2B0/pdYdp0PeiPjJnySWXsSXLf9q86lUL3q6LccbNKGr9Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634155;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q2sB6LK7JBem8Wc9iovY0h+gbudzawzx57EtdbyfsBc=;
	b=33NKxalkzX/7Pv0+Y6eJGJrgC1QexjHnYZQkSMpVHbTp7uQY/BODskYmp+sWWsyQF5LW
	 SjMZ9Mudp/aLLTq3oXQcESdmDTHEvOTYg+Xlqn+E5oDgA4gJD3qmOzRzZpYR0oOeljD13
	 UN3Bfc1Sx+e7IKueT6I3l6DKHdwD1jnSGR7LrTmD0Nop7AjFC/XK7F9Por9wZjahJl1OU
	 BGoHNt+gEpka+cQxh8BHXN8lOLbJ1MXDRO7QPzvd9PxYOzT9Q1E7rALnNGpVU0+oVooDC
	 v78SxHiGVTalU+bygsoAGD9v/+bpPMj3eIcj8POQ7oLAFk6S69cqwiK15pCNDIPGzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=X+HUWnu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C86076735
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=X+HUWnu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2C91F00A1C;
	Mon,  2 Nov 2026 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793634154;
	bh=q2sB6LK7JBem8Wc9iovY0h+gbudzawzx57EtdbyfsBc=;
	h=Subject:To:Cc:From:Date;
	b=X+HUWnu624wSrlEzYh9PefRUY1BW9iWODViHTx7nMc6BL65hklM3LBL5yv516m2Lz
	 Qbm7M5P7MjyXD2fZp5Ra6ddzgG3rUevlwadngRU5pXbBRCxG6hFHekQ9m6dFKkC0MY
	 BMD0StcPqSdGvgCII6J7rd6QUEr+fP1zTsU04/Ok=
Subject: FAILED: patch "[PATCH] ocfs2/dlm: drain join handlers before releasing module text" failed to apply to 5.10-stable tree
To: zzzccc427@gmail.com,akpm@linux-foundation.org,baijiaju1990@gmail.com,heming.zhao@suse.com,jjzuming@gmail.com,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,mark@fasheh.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:38:26 +0100
Message-ID: <2026110226-singular-frayed-fe6b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 28f366d84023651e50e32e29931401ba0df3e679
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110226-singular-frayed-fe6b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28f366d84023651e50e32e29931401ba0df3e679 Mon Sep 17 00:00:00 2001
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 22 Oct 2026 17:09:10 +0800
Subject: [PATCH] ocfs2/dlm: drain join handlers before releasing module text

The code for a registered DLM handler must remain resident until its
last invocation finishes. dlm_unregister_net_handlers() only removes
dlm_join_handlers from the o2net registry. o2net_handler_get() takes a
kref on the wrapper, but that reference does not pin ocfs2_dlm text.
o2net_process_message() calls nh_func after dropping o2net_handler_lock.

With CONFIG_OCFS2_FS_O2CB=m, ocfs2_dlm can be loaded independently of
ocfs2_stack_o2cb while nodemanager continues handling messages from a
configured, heartbeating peer. If no dependent module or module reference
prevents normal unload, the following ordering is possible:

  Receive worker                       Module unload
  --------------                       -------------
  o2net_handler_get()
    take wrapper kref
    drop handler lock
  <preempted>
                                       dlm_exit()
                                         unregister handlers
                                       release DLM module text
  call saved nh_func
    in released module text

Use o2net_unregister_and_flush_handler_list() in the shared DLM
unregister helper. It first prevents new lookups, then waits for the
ordered o2net workqueue to drain, including a concurrent destruction of
that queue. The acquired invocation therefore finishes before dlm_exit()
returns and the loader releases the callback code. The same helper
covers partial registration and dlm_init() error unwind before module
memory is released.

Skip the drain when the private join-handler list is empty. Early
dlm_init() failures can reach this helper before any handler has been
published. Partial-registration failure also reaches it a second time
after the first call has already unregistered and drained the list.
Neither case needs to take o2net_wq_mutex or drain unrelated work.
The list is changed only by serialized module init/exit paths; a
nonempty list still uses the full unregister-and-flush helper.

Oops report as below:

    Oops: int3: 0000 [#1] SMP KASAN NOPTI
    CPU: 2 UID: 0 PID: 54 Comm: kworker/u16:3 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy)

Hardware identification omitted.

    Workqueue: o2net o2net_rx_until_empty [ocfs2_nodemanager]
    RIP: 0010:0xffffffffc0423871
    [Instruction byte dump omitted.]

Register dump omitted.

    Call Trace:
     <TASK>
     ? o2net_rx_until_empty+0x19b1/0x3300 [ocfs2_nodemanager]
     ? __pfx_o2net_rx_until_empty+0x10/0x10 [ocfs2_nodemanager]
     ? lock_acquire+0x190/0x300
     ? process_one_work+0x935/0x1b40
     ? process_one_work+0x834/0x1b40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? process_one_work+0x9a8/0x1b40
     ? __pfx_process_one_work+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x177/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_worker_thread+0x10/0x10
     ? kthread+0x351/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ? ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf70
     ? __pfx_kthread+0x10/0x10
     ? ret_from_fork_asm+0x1a/0x30
     </TASK>
    Modules linked in: ocfs2_nodemanager [last unloaded: ocfs2_dlm]
    ---[ end trace 0000000000000000 ]---

Link: https://lore.kernel.org/pm-ocfs2-objects-candidate-0076-v6-12de5f4628f57fba3be3@gmail.com
Fixes: 6714d8e86bf4 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Assisted-by: LLM
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: <jjzuming@gmail.com>
Cc: <stable@vger.kernel.org>

diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 97bb9400e24b..a7dc3da6dfc7 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -2215,7 +2215,8 @@ static LIST_HEAD(dlm_join_handlers);
 
 static void dlm_unregister_net_handlers(void)
 {
-	o2net_unregister_handler_list(&dlm_join_handlers);
+	if (!list_empty(&dlm_join_handlers))
+		o2net_unregister_and_flush_handler_list(&dlm_join_handlers);
 }
 
 static int dlm_register_net_handlers(void)

