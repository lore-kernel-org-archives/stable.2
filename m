Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202023;
	b=myfeGIloA5snWSdnOKOMXIqt/eJZNtxWILBwcWwktXWy+6MHACv+0l5EvtnWj7qokbwK
	 OWQU5eODPrtXuAyDaf6mm7fjEMeHwKqcp32bbZF0e9g1/lv35WOA/VctKQEqFBMn/nLw6
	 hLurHCooseexhcVC1t58laWfjYS6eImewenVwgZjs9ZSupq4+CLYbrrTxmfqHVeqfmWVQ
	 oce25/utxteK0CUoxKt/nqkNUzB0szqfjmih6bDRg2h2PF3ozaTgsu1dDTsJ/dOxdPiWQ
	 09+N/Ni7lp+O3GKjGgq2ZOhpfQIhFZPPbdc6Pc66NXr6sgnnKqcCn7U1WeZI91cRBnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202023;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CuU9wE17heteMnzxDDNaaCT6vuQKTNZeLdKeogLAHqs=;
	b=hq53J80LMS/pKigu8BmVLFavKa4qyAkPn1vqIE/TFdgpIojMFOQyFjA3+K4vn2jlDsrT
	 63wk/RAOe2F4wr/E0bEhalqYTR7mn42mQ4Z+W6ZGc6gNdzyMyU/GysA4z6W/pNzvrO7Lx
	 QWj9vvsjN2urmamn04AIoeu6y61zr8ZpagDpFLC1mF00KEm8rpbvfkvq3IRNDoQDYOByb
	 tIUwIR4GXS8NmtfVQpiwyAtBD1ZnCcujGkpvzWlPkRtWvnwFQe30WAwk/eOtAzXKu6BKy
	 mLMGrrpLS7PMZ03dEVqpMNtZM+nLS293ENftWOiIRL+zkjrVaiXQpp0exSV2F9T9IZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sIBIc91U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40A606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sIBIc91U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595031F01825;
	Wed, 28 Oct 2026 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793202022;
	bh=CuU9wE17heteMnzxDDNaaCT6vuQKTNZeLdKeogLAHqs=;
	h=Subject:To:Cc:From:Date;
	b=sIBIc91Ubg0mfZfwX9hXy7Y1HV4Y6bZb2U4xAqJ/us4j74g8phOpuTLTmEUunx8te
	 iyxwUcIO86fmJRiNNXcNwYhTHNagJWZx+LamUf4TuC8H0pVa3ObwiGf9eFWnpOfCnk
	 ZEhLZu1ArC+LicLmXPR/pB6lhuB60Abft9FAmSYg=
Subject: FAILED: patch "[PATCH] ptrace: refuse to change the signal mask of a user worker" failed to apply to 6.1-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:40:21 +0100
Message-ID: <2026102821-foam-upper-ae17@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cabc249e6560bee7bdfee9fbcb7ce4e951dcfd41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102821-foam-upper-ae17@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cabc249e6560bee7bdfee9fbcb7ce4e951dcfd41 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:58 +0200
Subject: [PATCH] ptrace: refuse to change the signal mask of a user worker

A user worker is created with every signal other than SIGKILL and
SIGSTOP blocked. It never runs user code and that mask is what keeps
get_signal() from dequeuing anything else for it. complete_signal()
never picks a thread that blocks the signal, tkill() queues on the
worker but nothing dequeues it. ptrace_signal() requeues an injected
signal that the tracee blocks.

PTRACE_SETSIGMASK is the only way to change that mask from the outside.
A tracer that clears it makes the worker eligible for every signal.
Whatever the worker then dequeues it can only act on by leaving.

Refuse PTRACE_SETSIGMASK for a user worker with -EPERM, the way
ptrace_attach() refuses a kernel thread. A worker is guaranteed to only
ever dequeue SIGKILL or SIGSTOP and an injected signal stays pending on
it, which is what already happens when the mask isn't touched.

Taking the request and quietly leaving the mask alone was the other
option, the way set_current_blocked() keeps SIGKILL and SIGSTOP
unblocked whatever userspace asks for. But then a tracer gets success
back with nothing changed and no way to tell that apart from a mask that
took effect.

Fixes: e8b33b8cfafc ("Revert "kernel: treat PF_IO_WORKER like PF_KTHREAD for ptrace/signals"")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-9-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d041645d9d17..4e9822a87aab 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1227,6 +1227,12 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
 
+		/* A user worker only ever takes SIGKILL and SIGSTOP. */
+		if (child->flags & PF_USER_WORKER) {
+			ret = -EPERM;
+			break;
+		}
+
 		if (addr != sizeof(sigset_t)) {
 			ret = -EINVAL;
 			break;

