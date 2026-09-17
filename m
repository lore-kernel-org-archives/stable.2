Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7B4DE72D;
	Thu, 17 Sep 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654808; cv=none; b=CKw4rkb7DfnNqoBAvUYcIrx2H+xaMslqqyZ5nzvJ/Z6qz7pZqR01RLJ0USvA2x/ejHENVdHPk9r/F2hnckapXGlNzP3id4SnIWiydRuJaxM+f6uHQwctx200AdT0FAHLgiFMvWr3PYIiqUDelv9R8kIwfDEO/D7sfYZzRfueXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654808; c=relaxed/simple;
	bh=xa57NPFmTC5Yj/MpeYtU7y7Y4kssDDqDWXCcU5XWsSY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9rAkkzHFBnqBFNruG35/wWckYLDsvGMUoy9RvmdQy0/Z06CEXb7JQsins6pOZ9BJNFrDR1A14ZUBk/9zRd8+MRJMt3fxDJEEBmLpvt9rVCSuqGi6LVhuMLtIMRhV7FVDtCnM7NW3FARlVdB68yLj4tTGTbz7/BCKsg4k1IXI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFgMRizz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFgMRizz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EA61F000FF;
	Thu, 17 Sep 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654807;
	bh=2b6Fc6mZqxGMWHKPgaUO0EmAKAWEWiz9CQ8Lh3O1i7Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SFgMRizzakEYYR4ek8mkV+aeeiwakh5m4snf49LOhCvyaR9S8o/LMQ4Mfhov86mwU
	 4IUg601urXAc0fJn4WT6EASrkXz0LhNOgLWI4Svqze14bBkxxxTWjwqzHCDgljqvUu
	 9dBAOK/QCGVXWSi9ZlPjpDu4XkJzUSbZMx2K5RtPmIT2uuC1vTckyR6++ExsNzpMxt
	 DlSDVSlotQGkLnBdxGWZ+LaaOn5zyo9BqxuQSBXiEEhdEdrKTgLkZ/7UHoUzu7jOXq
	 RQHdA5VaRTh1NkKxG9MwunETgAaK4ptxsCOZNW8ktAF2MPUYEoqGBpa4iKrr8lWmrm
	 S9fhATAF5x0bg==
Subject: Re: [PATCH] vsock: preserve child namespace mode on an empty write
From: netdev-bot+sashiko@kernel.org
To: qwe.aldo@gmail.com
Cc: sgarzare@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 17 Sep 2026 14:20:06 +0000
Message-ID: <178965480627.22033.2840574060294474673@kernel.org>
In-Reply-To: <20260915111417.2726515-1-qwe.aldo@gmail.com>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

- [High] Incomplete fix: a zero-length write to
  /proc/sys/net/vsock/child_ns_mode still consumes the write-once child-…

Pre-existing issues:
- [Medium] Non-atomic publication in vsock_net_set_child_mode()
  (include/net/af_vsock.h:289-302): child_ns_mode_locked is published by…

--

vsock: preserve child namespace mode on an empty write

This initializes new_mode in vsock_net_child_mode_string() from the current
child mode, so the caller no longer reads an uninitialized enum when
__vsock_net_mode_string() returns success for a zero-length write.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b58afb..9f89f199478b9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2888,6 +2888,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>  	int ret;
>  
>  	net = container_of(table->data, struct net, vsock.child_ns_mode);
> +	new_mode = vsock_net_child_mode(net);
>  
>  	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				      vsock_net_child_mode(net), &new_mode);

[Severity: High]
The changelog says "Initialize new_mode from the current child mode so that
an empty write is a no-op."  Is the empty write really a no-op after this
change?

A zero-length write still reaches the handler with write == 1 and
*lenp == 0.  fs/read_write.c:vfs_write() has no count == 0 early return
(rw_verify_area() only rejects negative counts), and
fs/proc/proc_sysctl.c:proc_sys_call_handler() does not short-circuit
either:

	if (write) {
		error = -EFAULT;
		if (!copy_from_iter_full(kbuf, count, iter))
			goto out_free_buf;
		kbuf[count] = '\0';
	}
	...
	error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);

copy_from_iter_full(kbuf, 0, iter) returns true, so
vsock_net_child_mode_string() is entered with *lenp == 0.

__vsock_net_mode_string() then returns 0 without parsing anything:

	if (!table->data || !table->maxlen || !*lenp) {
		*lenp = 0;
		return 0;
	}

Since that return value is indistinguishable from "a mode was parsed",
vsock_net_child_mode_string() falls into its write block anyway:

	if (write) {
		...
		if (!vsock_net_set_child_mode(net, new_mode))
			return -EBUSY;
	}

so vsock_net_set_child_mode() is still called, now with the seeded current
mode rather than a stack value.

Does that still consume the write-once latch?  In
include/net/af_vsock.h:vsock_net_set_child_mode():

	int new_locked = mode + 1;
	int old_locked = 0; /* unlocked */

	if (try_cmpxchg(&net->vsock.child_ns_mode_locked,
			&old_locked, new_locked)) {
		WRITE_ONCE(net->vsock.child_ns_mode, mode);
		return true;
	}

On a fresh namespace vsock_net_init() leaves child_ns_mode_locked at 0, so
the cmpxchg succeeds and the mode is latched permanently.

Would this sequence then break a later legitimate lockdown on a global-mode
namespace?

	write(fd, "", 0);                     /* returns 0, latches GLOBAL+1 */
	echo local > .../child_ns_mode        /* cmpxchg fails, -EBUSY */

Documentation/admin-guide/sysctl/net.rst describes the behaviour as:

  The first write to ``child_ns_mode`` locks its value. Subsequent writes of
  the same value succeed, but writing a different value returns ``-EBUSY``.

which ties the lock and the -EBUSY to writing a mode value, not to a write
that supplies no value.

Would it be more in line with the changelog to skip the write handling
entirely when nothing was parsed, for example an early
"if (write && !*lenp) return 0;" in vsock_net_child_mode_string(), or having
__vsock_net_mode_string() report "no value parsed" distinctly from success,
instead of re-applying the current mode through the cmpxchg?

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but while
looking at vsock_net_set_child_mode() in include/net/af_vsock.h: is the
publication of the lock and of the mode value atomic with respect to
namespace creation?

	if (try_cmpxchg(&net->vsock.child_ns_mode_locked,
			&old_locked, new_locked)) {
		WRITE_ONCE(net->vsock.child_ns_mode, mode);
		return true;
	}

	return old_locked == new_locked;

The lock becomes observable before the child_ns_mode store, and a second
writer of the same mode returns success from the last line without waiting
for that store:

CPU0 (writes "local" on a global-mode netns)
	try_cmpxchg() succeeds, child_ns_mode_locked = LOCAL+1
	/* preempted here, before WRITE_ONCE(child_ns_mode, LOCAL) */

CPU1 (writes "local")
	try_cmpxchg() fails, old_locked == LOCAL+1 == new_locked
	return true;			/* sysctl write reports success */

CPU2 (creates a netns after CPU1's write returned)
net/vmw_vsock/af_vsock.c:vsock_net_init()
	net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
	net->vsock.child_ns_mode = net->vsock.mode;

Can the new namespace read VSOCK_NET_MODE_GLOBAL here and permanently
inherit the more permissive mode even though userspace was told the "local"
lockdown was committed?

A barrier does not seem sufficient, since the reader has already observed
the lock publication that precedes the value store.  Would publishing the
mode and its locked state together help, for example deriving child_ns_mode
from child_ns_mode_locked, or adding an in-progress state that the second
writer waits on?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915111417.2726515-1-qwe.aldo%40gmail.com
