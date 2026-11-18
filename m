Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039423;
	b=XEAmzPpwbZAKpWOPbeAmpVjPvwpcJ0yHeOSujITGzZnMCnEgSr6eDqugTXLb1DQvQ5XS
	 gLpCxrB565cpicnixiD+6iWyJZT0Py4oEbahrEC3HsywF1yn6dYb/S9MogTGf2hRnPWcm
	 A4po+KIyJp+AEg7wdvCYMD6mIzl4Oxo2OfiWA21C0fIcmmqjAhGcrhvfbi46jtT0RP7N3
	 nx7TQ83n0e7560o+yy79pw6iY5huWais51cMiCcwIEB273B+52Vzsv+miOjeM5pi1Z+LR
	 I+MwpygpO81gkqEhpBE64xws/HoQOuu9QikTJY+Q5uXse5SKOS8NWDOYruChe7KZrvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039423;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oFrBCJah7w3imnVbLeDvOxFUWcthQiQzvQDbtTXDpYg=;
	b=JiZkvi0qha7LM/aRzpEXFMvUL4Fy8ijdpIlyz9fiTcOsUFjGQNZqFLAekPYBpUL7wR6U
	 r1bTJ16diD7JkewA8g/vSCXyIGOpPjsaDDktoH/tc1Xfxx5j8M5MO1KWe0epg/7PbjY6W
	 bQqiPSelB9eE5gZqCzwfl9VrRba/3iZvyaGEV7QULI2FtGN1+1E0DmyFTTNSXSveMM/13
	 vxPWrbpFTcxnbHEfvAPKSp/CYiYaGFWBIwOxO5owutYB9mqMRPeVUPRP48PbJ/FMg1Hg9
	 zyReJMw8IhRQgCwT4yBhpDMTgoZBhpPwtaUz+OkqaNlteamYsXyxjAXcgJ4e4fGFx0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4WHDeKd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA38606A31C;
	Wed, 18 Nov 2026 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4WHDeKd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554881F000C6;
	Wed, 18 Nov 2026 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039423;
	bh=oFrBCJah7w3imnVbLeDvOxFUWcthQiQzvQDbtTXDpYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F4WHDeKd5F6tWs6uf57JVeNysViadpbhtro9k3xjl3gkGAcU2F/EergybTl5g23cH
	 8dh4fzSlLZyNZAqdzm/qe/jFr7w2ekBQ3DlccbhiKJqypCqaroWvVmth+2mDgVv/0L
	 npttaG9RTrXuYZ6lagikQfB6GSw7uwWZBmXUMSqZrxK8kKyeX9Kv0Jw9Ifoz6iZMxE
	 zHy9T0GyU8V5wNc6KfLE7hNxa7+5UdcfEvNatCq4qr3mRZPwhkIgqCVqLZ5H/8Snld
	 dZBjKJ8rHnhWwUpajpb1ZoPLnFnOi+gGnoNewdVZqSnvQdtV9RHtr0fIp7lalRGvv+
	 atdn/Ji2FGLtQ==
Message-ID: <a25b7f89-88e4-419e-83cc-83c5d1776421@kernel.org>
Date: Wed, 18 Nov 2026 23:03:37 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 6/7] mptcp: don't send a FIN before the pending data
 on fallback
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-6-bf7656de653e@kernel.org>
 <179495459093.3136.11317086858664422664@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179495459093.3136.11317086858664422664@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 17/11/2026 23:29, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.

Please see below.

(...)

>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 011e73d04ee60..7d226ee38315d 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -1333,7 +1333,11 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
>>  	msk = mptcp_sk(sk);
>>  	if (!__mptcp_try_fallback(msk, fb_mib))
>>  		return false;
>> -	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
>> +
>> +	/* no FIN before new data: see mptcp_check_send_data_fin() */
>> +	if (READ_ONCE(msk->snd_data_fin_enable) &&
>> +	    !before64(READ_ONCE(msk->snd_nxt) + 1, READ_ONCE(msk->write_seq)) &&
>> +	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
> 
> [Severity: Medium]
> With this change, the subflow FIN is deferred while new data is still
> pending, and mptcp_check_send_data_fin() is expected to send it once
> that data has been pushed. check_fully_established() now calls
> __mptcp_check_push() after a successful fallback, so that path is
> covered. What about the other mptcp_try_fallback() callers?
> 
> subflow_check_data_avail() falls back on MAPPING_NODSS and
> MAPPING_DUMMY:
> 
> net/mptcp/subflow.c:subflow_check_data_avail() {
>     ...
> 		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
>     ...
> }
> 
> mptcp_dss_corruption() does the same on a corrupted mapping:
> 
> net/mptcp/protocol.c:mptcp_dss_corruption() {
>     ...
> 	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
>     ...
> }
> 
> In both cases, mptcp_incoming_options() has already run for this packet
> while MPTCP_FALLBACK_DONE was still clear. Without a DSS option, it
> returns early, before ack_update_msk() and __mptcp_check_push() are
> reached. Neither caller pushes the pending data once the fallback has
> succeeded.
> 
> Before this patch, the FIN was sent here unconditionally. The data was
> lost, but the connection could still be closed. Now the FIN is skipped.
> If the peer doesn't send anything else, what pushes the data from
> msk->first_pending and then calls mptcp_check_send_data_fin()?
> 
> The retransmit timer doesn't seem to help either. If there is unacked
> data at the head of the rtx_queue, __mptcp_push_retrans() returns -1
> on a fallen-back msk, and __mptcp_retrans() jumps to clear_scheduled:
> 
> net/mptcp/protocol.c:__mptcp_retrans() {
>     ...
> 		/* Can fail only in case of fallback. */
> 		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
> 		if (len < 0)
> 			goto clear_scheduled;
>     ...
> }
> 
> This skips mptcp_check_and_set_pending(sk), so the pending data isn't
> scheduled from there either.
> 
> Couldn't the connection then be left with both the pending data and
> the deferred FIN stuck, so the shutdown never completes? Should
> subflow_check_data_avail() and mptcp_dss_corruption() also trigger a
> push after a successful fallback, like check_fully_established() does?
> Or is another path expected to flush this data?

Somehow pre-existing: Before this patch, this pending data was lost: the
peer silently got a truncated stream. Now, the data and the FIN are sent
at the next push, e.g. on the next ACK or window update from the peer.
This is the same as for pending data without shutdown, which was already
not pushed after these fallbacks: this is a pre-existing issue, not a
regression. It can be handled in a follow-up, if a stall can be
reproduced, but I didn't manage to reproduce it so far.

> [Severity: Medium]
> Is this lockless check ordered against the writer?
> 
> mptcp_try_fallback() can run in BH context with only the ssk lock held.
> One example is check_fully_established(), when the 3rd ACK arrives without
> MPTCP options:
> 
> net/mptcp/options.c:check_fully_established() {
>     ...
> 	if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
>     ...
> }
> 
> The writer is __mptcp_wr_shutdown(), called from mptcp_shutdown() and
> mptcp_close(). It holds only the msk socket lock, not the ssk lock or
> msk->fallback_lock:
> 
> net/mptcp/protocol.c:__mptcp_wr_shutdown() {
>     ...
> 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
> 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
>     ...
> }
> 
> Nothing orders these two stores. Nothing orders the three READ_ONCE()
> loads in mptcp_try_fallback() either. The spin_lock_bh() on
> msk->fallback_lock in __mptcp_try_fallback() doesn't help, because the
> writer never takes that lock.
> 
> On a weakly ordered CPU such as arm64 or POWER, could the BH reader see
> snd_data_fin_enable == 1 together with the old write_seq?
> 
> Suppose exactly one byte of new data is still unsent, so snd_nxt + 1
> equals the old write_seq. The new check then evaluates to true, and
> tcp_shutdown(ssk) sends the FIN before that byte.
> 
> After that, mptcp_check_send_data_fin() returns early on the writer side:
> 
> net/mptcp/protocol.c:mptcp_check_send_data_fin() {
>     ...
> 	if (!msk->snd_data_fin_enable || msk->snd_nxt + 1 != msk->write_seq ||
> 	    mptcp_send_head(sk))
> 		return;
>     ...
> }
> 
> The byte can't be pushed later either. The subflow is now in FIN_WAIT1 or
> LAST_ACK, so __tcp_can_send() fails in __mptcp_subflow_active().
> 
> Wouldn't this truncate the stream in the same way this patch is meant to
> prevent, only within a narrower window?

This is theoretical: it needs a weakly ordered CPU, a shutdown racing
with a fallback, and exactly one byte left unsent. Without this patch,
the stream is always truncated in this case, so not a regression, and I
don't think it is worth blocking this patch for this theoretical reason.

> Would it close the window to publish snd_data_fin_enable with
> smp_store_release() after the write_seq update, and read it with
> smp_load_acquire() in mptcp_try_fallback()? An smp_wmb()/smp_rmb() pair
> would also work.

A release/acquire pair is cheap: I can send a follow-up later on.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

