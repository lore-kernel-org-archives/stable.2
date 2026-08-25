Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E307643E097
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662098; cv=none; b=mqpbdp41DM0Su48ngbuSX2GNq1gmeUunoSCt7inDtZzPNFVO0CSMFILZYwT/uvuAO55ebbFXyxen54hgknYXMJnRzTFvEaYdk0HIxUnFcQ1VmUlNbxjXphyNHqjuCSUlGXeeKX8RyWhwQhPxwXDMUg90KL+GYo4gBmQwsWcPKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662098; c=relaxed/simple;
	bh=DUs0PyexHQKpn4RGjEdMGUgHiCCOTDu16sHXFSiTgH4=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jpwasedyMQ+ZGxFYEbq91E1kLvNjBNVWZldqMwvWaJiNuQJlvEY43MYMKxKxFNG0Mv6lgfGtpUJ50Uk5RtFn9LDmd8lvdJgnyKkCXIzO5+pRrysSxGh60nvzEnOUTh3492vSWoRfcl1lY5V6JuSQKJ///2Sr4PJPkJwtemW4KXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmJsKQAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmJsKQAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B491F000E9;
	Tue, 25 Aug 2026 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662093;
	bh=OSMuc3xPUvIObN5R+BZMw+slV8Uu5oL1jjLsWkApj2Q=;
	h=Date:From:To:Cc:Subject:References;
	b=BmJsKQAstE6WUWo41/AJtZdrBYTAo7+ZQPM+P33eX2NJ0z33yEvR5Q6lW+Ktncls0
	 e9v0OEMwWwFMWLemTtJSsC+RRhJTp2C9WBz4znpuXlx5ODC9MtwaWSQ629YwVbN6GS
	 3ygj8OTf5O+BWIPXAE1KKiq84T8u/pzIWBKtKPdbNMKjV7hU62Of1PAuHaHOCmh5u/
	 k41gtj0xoi+m54lq6lQMALSyBEh6zGFONndaSw99HDUQaNlws4XuAWIUO9/C73+lfJ
	 50Aoenp6+YET5rFsZN3hxRMnbXJW+zR8BT3piBIWiEQl4MDFyxDADG12hzkCZWdJj4
	 zan6edtEPj/7w==
Date: Tue, 25 Aug 2026 14:48:10 +0200
Message-ID: <20260825091134.675317637@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 Hyunwoo Kim <imv4bel@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 6.18.y 4/5] futex: Fix race on the initial mm->futex.phash.ref
 allocation
References: <2026082450-shoplift-anew-8412@gregkh>
 <20260825091033.136528074@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hyunwoo Kim <imv4bel@gmail.com>

commit bde0238083647381d4747355c5a19115a3422b96 upstream.

futex_hash_allocate() allocates mm->futex.phash.ref without any locking.
Commit d9b05321e21e ("futex: Move futex_hash_free() back to __mmput()")
moved the allocation here and assumed that the process has just a single
thread at this point.

Commit ee9dce44362b ("futex: Drop CLONE_THREAD requirement for private
default hash alloc") widened need_futex_hash_allocate_default() to cover
any CLONE_VM clone, but left out vfork because the parent is suspended and
cannot race.

That no longer holds once vfork is nested. If a vfork child calls vfork
again and is then killed with SIGKILL, the parent is released from its
vfork wait and runs concurrently with the grandchild in the same mm.
Neither of them went through futex_hash_allocate_default().

When both call prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS) at the same
time, each one sees mm->futex.phash.ref as NULL and stores its own percpu
counter. Only the last store survives. The counter stored first is no
longer reachable from the mm, so the references on it are not seen by
__futex_ref_atomic_end(). A private hash that still has references is then
considered dead and freed, and a task that still holds one of its buckets
writes into freed memory in futex_q_lock().

Store the counter once with cmpxchg() and let the loser free_percpu() its
own. The initial reference has to be taken before the store, otherwise
another task can install a private hash while the counter is still 0.

Fixes: d9b05321e21e ("futex: Move futex_hash_free() back to __mmput()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ansrpP4ImE1MaBY9@v4bel
---
 kernel/futex/core.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
---
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1830,14 +1830,18 @@ static int futex_hash_allocate(unsigned
 	}
 
 	if (!mm->futex_ref) {
+		unsigned int __percpu *ref = alloc_percpu(unsigned int);
+
+		if (!ref)
+			return -ENOMEM;
+
 		/*
-		 * This will always be allocated by the first thread and
-		 * therefore requires no locking.
+		 * Tasks sharing the mm can run this concurrently, so take the
+		 * initial reference before publishing the counter.
 		 */
-		mm->futex_ref = alloc_percpu(unsigned int);
-		if (!mm->futex_ref)
-			return -ENOMEM;
-		this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+		this_cpu_inc(*ref); /* 0 -> 1 */
+		if (cmpxchg(&mm->futex_ref, NULL, ref))
+			free_percpu(ref);
 	}
 
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),

