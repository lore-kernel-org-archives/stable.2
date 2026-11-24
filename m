Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562732;
	b=ZkOzeuuW1snmqpophzG1fdDQKrSlfC6UbHn3Q5J2AFiU2W4mPA0RN5hLQWUqLJbl69KI
	 6yYyvYNgptOpMZv6+mEd09xy852AOqILJDtPQfZxVGc44+UYSkh9risHj2aQQ4V1p52I0
	 23S43hMSIkwxb7J9Erhc064LZPc5RrNnhfmUMKXTlPVk1AvSch/j9RrNqZrSJZkCTZncT
	 n5p/R8JNe1YQSlcuV5sguk/k+pNFyVPR77eLyIVbFFd5Ch4iHxYBgjD2sMYkmBo5OS4cS
	 WD4E2Nlcz8UJEQhfFa/f2KHIVHsZaDrSXzVRqtw1M9HlkKTqE24e3CRmGKXZtzNDG2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562732;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ILUgPrE1cEY1/117QbLkMELilGTCoO7AIk3nTEg2f60=;
	b=Q1Tdp5vr/ubMQ1ndWdQw4uWN4dVF1pPBzkOIr9GIeS7znPHcx5KjG80T91tAPHQukH7Y
	 anY+LROuWBxIGSZwlStNvAOGqQzCySVRvXMlKuxaWttn9AhLMKGDam2055R5K+dXY0Ope
	 6/dJPN9XR0YaLCcs+NXkkam31aTbi74JFQv6uUoAL2WQdp4UlOiMM8U8m6rHQsVkWfPTU
	 SRB7X3FBuO307vC2ISOnyFniuEeK+WrTuIgJc3lnR/fFija7RkDVr2ivzEkmiE8gpth1k
	 XuW6nsH0mCTuAn9bcICuytWHKmc8THP5G4roZoST4iKYGOK1IxnvwQH+mFRF95U7XUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YGXBuL/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F2606A685;
	Tue, 24 Nov 2026 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGXBuL/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261161F000CA;
	Tue, 24 Nov 2026 23:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795562731;
	bh=ILUgPrE1cEY1/117QbLkMELilGTCoO7AIk3nTEg2f60=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YGXBuL/SDcdrb3em8E6BFR5vgzQhNQwJDIayOZdjYChorhU++lSxL7BgcthYZiw3o
	 OFvTKh0Wpul0T/Ald7uLybG1zQUY1Cd28EauCbfxlbfl1yF1QzHXaBehsn+q/zUSbN
	 ClZBkf3bEx1aLHU1ilnDKTuX7APSs8mEuNXDoAJUkgNOldIGJ1gTuCvjyAF2NFpJDe
	 sG1z96jyujnK2AjRF86GCW3YffJT5lyVNHipcKyyTneu7YNsd7wydqWBlUnHVPZyGc
	 GQs3xEqQ8xT8Jr2VRTUTxPzpAC5jYMne3ZvhL1ATVKEOzAS4pOPKv8xk0WRMrbM/QH
	 TezxMk9frvHyw==
Subject: Re: [PATCH v2 net] net/sched: cls_flow: pin file with get_file_active
 before reading f_cred
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 brauner@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, tristan@talencesecurity.com
Date: Tue, 24 Nov 2026 23:25:30 +0000
Message-ID: <179556273068.3135.1917720638218206148@kernel.org>
In-Reply-To: <20261120231354.1361803-1-tristan@talencesecurity.com>
References: <20261120231354.1361803-1-tristan@talencesecurity.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes a reader that runs under RCU only, without a
  file reference, and reads sk->sk_socket->file->f_cred.
- [Medium] flow_get_skuid() and flow_get_skgid() read sk->sk_socket twice
  with plain, unmarked loads: once in `if (!sk || !sk->sk_socket)` and…
- [Medium] Because the classifier now takes and drops a real f_ref from
  softirq or BH-disabled context, it can end up holding the last…
- [Low] flow_get_skuid() and flow_get_skgid() in net/sched/cls_flow.c now
  do get_file_active() and then fput() on every classified packet.
- [Low] The commit author is 'Tristan Madani <tristmd@gmail.com>', but
  the only Signed-off-by is 'Tristan Madani…

--

net/sched: cls_flow: pin file with get_file_active before reading f_cred

This patch changes flow_get_skuid() and flow_get_skgid() in cls_flow so
that they take a reference on sk->sk_socket->file with get_file_active()
before reading f_cred, and drop it with fput() afterwards. The stated
reason is that filp_cache is SLAB_TYPESAFE_BY_RCU, so a concurrent close()
can free and recycle the struct file while the classifier reads it.

> Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
> Cc: stable@vger.kernel.org

[Severity: Medium]
The Fixes: tag points at the tree-wide conversion to SLAB_TYPESAFE_BY_RCU,
but only the cls_flow readers change here. Should the other readers that
use the same pattern be fixed too?

These still load sock->file without pinning it and then read file->f_cred
under RCU only:

  owner_mt() in net/netfilter/xt_owner.c
  nft_meta_get_eval_skugid() in net/netfilter/nft_meta.c
  the NFQA_UID/NFQA_GID code in net/netfilter/nfnetlink_queue.c
  __build_packet_message() in net/netfilter/nfnetlink_log.c
  nf_log_dump_sk_uid_gid() in net/netfilter/nf_log_syslog.c
  skb_may_tx_timestamp() in net/core/skbuff.c, via file_ns_capable()

Most of them carry this comment:

	/* The sk pointer remains valid as long as the skb is. The sk_socket and
	 * file pointer may become NULL if the socket is closed. Both structures
	 * (including file->cred) are RCU freed which means they can be accessed
	 * within a RCU read section.
	 */

If this patch's premise is correct, that comment is wrong for struct file.
file_free() calls put_cred() and then kmem_cache_free() right away, and
Documentation/filesystems/files.rst says struct file fields cannot be
checked under RCU lookup without first taking a reference.

The same race applies at those sites:

  reader loads sock->file
  __sock_release() does WRITE_ONCE(sock->file, NULL)
  __fput() frees the file, another task reallocates it
  reader loads file->f_cred and gets the new owner's cred

Cred freeing is RCU-deferred, so this is memory safe. The result is still
wrong, though: the xt_owner/nft_meta owner match, or the logged and queued
UID/GID, would use another task's fsuid/fsgid.

With Cc: stable and a tree-wide Fixes: tag, how can a stable backporter
tell whether this bug class is closed? Could the commit message at least
explain why only cls_flow needs the change, or could the sibling sites and
their comments be updated in the same series?

> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

[Severity: Low]
This isn't a bug, but the author address is tristmd@gmail.com and the only
Signed-off-by uses tristan@talencesecurity.com. checkpatch reports this as
FROM_SIGN_OFF_MISMATCH. Could the patch be sent From: the Signed-off-by
address, or get a matching Signed-off-by?

> diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
> index 2ef449706638b..8653e6fdcfa2a 100644
> --- a/net/sched/cls_flow.c
> +++ b/net/sched/cls_flow.c

[ ... ]

> @@ -208,10 +209,16 @@ static u32 flow_get_rtclassid(const struct sk_buff *skb)
>  static u32 flow_get_skuid(const struct sk_buff *skb)
>  {
>  	struct sock *sk = skb_to_full_sk(skb);
> +	struct file *filp;
>  
> -	if (sk && sk->sk_socket && sk->sk_socket->file) {
> -		kuid_t skuid = sk->sk_socket->file->f_cred->fsuid;
> +	if (!sk || !sk->sk_socket)
> +		return 0;
> +
> +	filp = get_file_active(&sk->sk_socket->file);

[Severity: Medium]
Is sk->sk_socket read twice here with plain loads? It is read once for the
NULL check and again to build &sk->sk_socket->file. The same applies to
flow_get_skgid().

close() can reach sock_orphan() on another CPU:

include/net/sock.h:sock_orphan() {
	write_lock_bh(&sk->sk_callback_lock);
	sock_set_flag(sk, SOCK_DEAD);
	sk_set_socket(sk, NULL);
	...
}

sk_set_socket() does WRITE_ONCE(sk->sk_socket, sock). The classifier does
not hold sk_callback_lock, so KCSAN will report this plain read against
that marked write.

The compiler may also reload sk->sk_socket after the check. If
sock_orphan() runs between the two loads, get_file_active() receives
(struct file **)offsetof(struct socket, file). __get_file_rcu() then
dereferences that near-NULL address in softirq context:

	file = rcu_dereference_raw(*f);

The peer readers such as owner_mt() take a single snapshot instead:

	sock = READ_ONCE(sk->sk_socket);
	filp = sock ? READ_ONCE(sock->file) : NULL;

The old code had the same double read. These lines are being rewritten to
handle a concurrent close(), though, so would something like this work
instead?

	struct socket *sock = READ_ONCE(sk->sk_socket);

	if (!sock)
		return 0;
	filp = get_file_active(&sock->file);

struct socket is freed through the sockfs inode RCU callback, so it stays
valid under the caller's RCU-BH section.

> +	if (filp) {
> +		kuid_t skuid = filp->f_cred->fsuid;
>  
> +		fput(filp);

[Severity: Medium]
Can this fput() drop the last reference to the socket's file? Consider
get_file_active() succeeding here while close() runs on another CPU:

  classifier: get_file_active() succeeds, refcount is 2
  close(): drops its reference, returns to userspace
  classifier: fput() drops the last reference from BH context

__fput_deferred() then takes the delayed path, because in_interrupt() is
true in softirq and under rcu_read_lock_bh():

fs/file_table.c:__fput_deferred() {
	...
	if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
		...
	}

	if (llist_add(&file->f_llist, &delayed_fput_list))
		schedule_delayed_work(&delayed_fput_work, 1);
}

This moves __fput()->sock_close()->__sock_release()->inet_release() and
tcp_close() into a system_wq kworker. They run at least one jiffy after
close() has returned.

Two effects follow:

- An immediate re-bind of the port can fail with EADDRINUSE.
- close() with SO_LINGER set no longer waits. The linger wait instead
  happens in the kworker and blocks a shared worker for up to the linger
  timeout.

The same applies when __get_file_rcu() briefly takes a reference on a
recycled, unrelated file and calls fput() on the mismatch path.

Before this patch the classifier never held a file reference. close() in a
single-threaded process therefore released the socket synchronously.

>  		return from_kuid(&init_user_ns, skuid);
>  	}
>  	return 0;
> @@ -220,10 +227,16 @@ static u32 flow_get_skuid(const struct sk_buff *skb)
>  static u32 flow_get_skgid(const struct sk_buff *skb)
>  {
>  	struct sock *sk = skb_to_full_sk(skb);
> +	struct file *filp;
> +
> +	if (!sk || !sk->sk_socket)
> +		return 0;
>  
> -	if (sk && sk->sk_socket && sk->sk_socket->file) {
> -		kgid_t skgid = sk->sk_socket->file->f_cred->fsgid;
> +	filp = get_file_active(&sk->sk_socket->file);
> +	if (filp) {
> +		kgid_t skgid = filp->f_cred->fsgid;
>  
> +		fput(filp);

[Severity: Low]
Is the new per-packet cost intended? Both flow_get_skuid() and
flow_get_skgid() now do an atomic RMW on file->f_ref in __get_file_rcu(),
via file_ref_get(), plus another in fput(), via file_ref_put(). This
happens for every classified packet, where the old path was a plain
lockless read.

A filter keyed on both SKUID and SKGID writes the struct file cacheline
four times per packet. The writes come from whichever CPU is transmitting
or receiving on that socket.

Nearby netfilter readers were made lockless on purpose, for example commit
cdec942ac2006d ("netfilter: xt_owner: no longer acquire sk_callback_lock
in mt_owner()"), which followed 983512f3a87f.

Would a cheaper check work, such as re-checking READ_ONCE(sock->file) ==
filp after loading f_cred? __sock_release() clears sock->file before the
file can be freed, but this would need careful barrier analysis. If the
refcount approach stays, could the commit message mention the fast-path
cost?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120231354.1361803-1-tristan%40talencesecurity.com
