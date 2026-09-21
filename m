Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58624A204C;
	Mon, 21 Sep 2026 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998341; cv=none; b=oTaRoxvv33FRo8zkZBnQl4FyptbZo3iG11N5hZmjYn7rdjmNNZlvIElxtGQ9D42+3sgTCVurnPd7JKyG3L4Sr6xJMNYsVCH4dBPqEZgkz/ktjmgnxonClpAjpBgN8LXI6CZeoMp/D7m+DF/bWFwbkvIkrPX70IRxtbyrGUyGSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998341; c=relaxed/simple;
	bh=8SAsMjkrngSWGdQKZl/aHd6rJ4X+T1wuo4AkDdyJKso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbIx09o0MWUKtNQJY3TdOFTgvtgbd6iSy7CerF7KqUg0+x/xrwpIuj4maLBJLG9na3pxXrjmt48vo/lNBViE6eh//oRw+akvJHi1YCGQ+ssXZW8x9GuPrT9O4+9mbre/0Rl4cgDmgULMzqPWMTmVlNrlz4RfAAr9J8y0d1pvDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jluAyHbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jluAyHbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E5A1F00898;
	Mon, 21 Sep 2026 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998339;
	bh=85CevHKublMmHOSHJkcM1sjBk3a15MmFBWjuAkGzmnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jluAyHbw2vEqmozixFTqdTe7zlSB6njFRBAJ0ExWMwKyQQrPnuLpAfq1sqHtIkLQv
	 /vCwG0jwKhX5dWk1usPTY5RW9pPsMgHw/K5WZYgbKog0mB29goPiwAmHbEvRXAhQqj
	 RMfOhw10tX/dA8m8hj4rPGsV1pIROIrdBpAZb4o6n+Cs+mJPL66eJUmoyaRjUv5QPx
	 Dpxe2vQvNMW+mVzy2NCrfmhfTaorDsespkd/MKmFbrgmHY90Twh1Fc3WXLh0CkHrrR
	 uMwGGpE25bIuDTXFfhKq6JyqvdVuUGD9lD4XRX4dKj1FKCbfuqIISCcPqkJKjNIv7/
	 6H5hC1Tk1CVew==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:58 +0200
Subject: [PATCH v3 09/17] ptrace: refuse to change the signal mask of a
 user worker
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-9-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8SAsMjkrngSWGdQKZl/aHd6rJ4X+T1wuo4AkDdyJKso=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLmzsfIlz+eogHshBmkqp7OcPmRILunQf6EqGXw1y
 /2qO/PzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUyDL8s1+X5tHrcadbPnPv
 4o/nblRe+tdRGHO29Plc/bz/J/+6MzP8M30iLPbjpPCdKJsZOpv87HT7G+4+eLAnId91l7tlTUM
 OCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/ptrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

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

-- 
2.53.0

