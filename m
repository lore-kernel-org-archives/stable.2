Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954592;
	b=EYdA3/v3jhsru0clDApm+xMh1sYny9YnC3nCR3u/FSzx+x0c8Mmy9iaiNACaNhVEm9cX
	 hwaBOqyiXbkhiDlJqfkFr82VM3cC0hAuz4H0Y/IBvYq0w7baXekrAxgBvKQ3BUxEPhVR5
	 tvxOl+HMCbdFtl5sIEVcrx9ZoNzDSBd229tOuxDfi/GmEKg+0lGlSdKvm8lF/BHXmO1kd
	 QCJ/9Dh/4Xu3tpveC+uPG53U4Mw/zGpPA9aFo2OeJg5DXh7u4iecb6e2CBMBkHfhOSzOg
	 BRseUR1y761httEfA8zoRggOlCazd9Z4ySLxiooCJyE+IstelhakgK8y+5GNRqhi9GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954592;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FhtaZTTm//7DS+AhnI34d+SKKb+pKBt5QiLl5KQsUmg=;
	b=gkiYF2edwct3ZBz8jzJ/brXCb+o9Vgjy5ZchEyW7jvlRenROm//+30QhktfYumbuN1Sg
	 AY2E5qQwd4GgdV9HDiuGw8f0H8aWkabyoifCiICdGBwUXerY/7x+Al7dUZHyrHpO5Z/61
	 BLeiU7IykNS/wj/PTRVTDSQZITmE3ilf3PvGCGPAf7CBIgsgKwMA/mlDCZ8om5CbywYSx
	 wJjYo7yrk29pHSY26W1iToBIJKm6YkXONc0zFqWkAK3kKKy5qocPHltAVZv7zXt/zAi85
	 XOH0BAz8JL53XX5DTAVgOL+ayNAWUcrsvpjg70NqmUqbLl2byVNmNBWgIrH3P73MV4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCS8h0Jt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AF606A88B;
	Tue, 17 Nov 2026 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCS8h0Jt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F151F00923;
	Tue, 17 Nov 2026 22:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794954592;
	bh=FhtaZTTm//7DS+AhnI34d+SKKb+pKBt5QiLl5KQsUmg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gCS8h0JtWsYLwZ8YyOZWAMIX8QW5nQs6W5KmBmf+PsLE80el2PrZ8XpnfVa/H8ZsJ
	 8QqAQ4E2KzlY/Qn5usTu2PActfCHpXQxccucCECbMTy3LCKDsmS8V54sk6hpFih/m9
	 5HtdB3eHjpvR/lwCzVa8WyN319NwnxBwTKMKqpFnWXtR0cqAWDZ16Zpx2hYAIte8Q0
	 xpbj8KgW/T0wbOITCeE+xmfswAHLFVLABgi1B1o1+8TO9ZHbYYaLhI1FKDubFmC9hx
	 /Ez2nZvu8WGTX1b6Fypmvq2yPqxsryXT3UWm8WvW8w0TCGiR9Ug1/mtrpDnVMYwLlO
	 RkAecOO6ckYHg==
Subject: Re: [PATCH net 6/7] mptcp: don't send a FIN before the pending data
 on fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
Date: Tue, 17 Nov 2026 22:29:50 +0000
Message-ID: <179495459093.3136.11317086858664422664@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-6-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-6-bf7656de653e@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new 'no FIN before new data' check in mptcp_try_fallback()
  (net/mptcp/protocol.h) is not reliable.
- [Medium] mptcp: missing pending data push after fallback in
  subflow_check_data_avail()

--

mptcp: don't send a FIN before the pending data on fallback

After this change, mptcp_try_fallback() shuts the subflow down at fallback
time only when no new data is pending before the DATA_FIN. Otherwise,
mptcp_check_send_data_fin() is expected to shut the subflow down once that
data has been pushed. This stops a TCP FIN from going out ahead of data
still in the MPTCP write queue, as in the TFO server case.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 011e73d04ee60..7d226ee38315d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1333,7 +1333,11 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
>  	msk = mptcp_sk(sk);
>  	if (!__mptcp_try_fallback(msk, fb_mib))
>  		return false;
> -	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
> +
> +	/* no FIN before new data: see mptcp_check_send_data_fin() */
> +	if (READ_ONCE(msk->snd_data_fin_enable) &&
> +	    !before64(READ_ONCE(msk->snd_nxt) + 1, READ_ONCE(msk->write_seq)) &&
> +	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {

[Severity: Medium]
With this change, the subflow FIN is deferred while new data is still
pending, and mptcp_check_send_data_fin() is expected to send it once
that data has been pushed. check_fully_established() now calls
__mptcp_check_push() after a successful fallback, so that path is
covered. What about the other mptcp_try_fallback() callers?

subflow_check_data_avail() falls back on MAPPING_NODSS and
MAPPING_DUMMY:

net/mptcp/subflow.c:subflow_check_data_avail() {
    ...
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
    ...
}

mptcp_dss_corruption() does the same on a corrupted mapping:

net/mptcp/protocol.c:mptcp_dss_corruption() {
    ...
	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
    ...
}

In both cases, mptcp_incoming_options() has already run for this packet
while MPTCP_FALLBACK_DONE was still clear. Without a DSS option, it
returns early, before ack_update_msk() and __mptcp_check_push() are
reached. Neither caller pushes the pending data once the fallback has
succeeded.

Before this patch, the FIN was sent here unconditionally. The data was
lost, but the connection could still be closed. Now the FIN is skipped.
If the peer doesn't send anything else, what pushes the data from
msk->first_pending and then calls mptcp_check_send_data_fin()?

The retransmit timer doesn't seem to help either. If there is unacked
data at the head of the rtx_queue, __mptcp_push_retrans() returns -1
on a fallen-back msk, and __mptcp_retrans() jumps to clear_scheduled:

net/mptcp/protocol.c:__mptcp_retrans() {
    ...
		/* Can fail only in case of fallback. */
		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
		if (len < 0)
			goto clear_scheduled;
    ...
}

This skips mptcp_check_and_set_pending(sk), so the pending data isn't
scheduled from there either.

Couldn't the connection then be left with both the pending data and
the deferred FIN stuck, so the shutdown never completes? Should
subflow_check_data_avail() and mptcp_dss_corruption() also trigger a
push after a successful fallback, like check_fully_established() does?
Or is another path expected to flush this data?

[Severity: Medium]
Is this lockless check ordered against the writer?

mptcp_try_fallback() can run in BH context with only the ssk lock held.
One example is check_fully_established(), when the 3rd ACK arrives without
MPTCP options:

net/mptcp/options.c:check_fully_established() {
    ...
	if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
    ...
}

The writer is __mptcp_wr_shutdown(), called from mptcp_shutdown() and
mptcp_close(). It holds only the msk socket lock, not the ssk lock or
msk->fallback_lock:

net/mptcp/protocol.c:__mptcp_wr_shutdown() {
    ...
	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
	WRITE_ONCE(msk->snd_data_fin_enable, 1);
    ...
}

Nothing orders these two stores. Nothing orders the three READ_ONCE()
loads in mptcp_try_fallback() either. The spin_lock_bh() on
msk->fallback_lock in __mptcp_try_fallback() doesn't help, because the
writer never takes that lock.

On a weakly ordered CPU such as arm64 or POWER, could the BH reader see
snd_data_fin_enable == 1 together with the old write_seq?

Suppose exactly one byte of new data is still unsent, so snd_nxt + 1
equals the old write_seq. The new check then evaluates to true, and
tcp_shutdown(ssk) sends the FIN before that byte.

After that, mptcp_check_send_data_fin() returns early on the writer side:

net/mptcp/protocol.c:mptcp_check_send_data_fin() {
    ...
	if (!msk->snd_data_fin_enable || msk->snd_nxt + 1 != msk->write_seq ||
	    mptcp_send_head(sk))
		return;
    ...
}

The byte can't be pushed later either. The subflow is now in FIN_WAIT1 or
LAST_ACK, so __tcp_can_send() fails in __mptcp_subflow_active().

Wouldn't this truncate the stream in the same way this patch is meant to
prevent, only within a narrower window? The later patch in the series,
"mptcp: fix dummy mapping of overlapping segments", doesn't touch
protocol.h or protocol.c, so the window would still be open at the end of
the series.

Would it close the window to publish snd_data_fin_enable with
smp_store_release() after the write_seq update, and read it with
smp_load_acquire() in mptcp_try_fallback()? An smp_wmb()/smp_rmb() pair
would also work.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e%40kernel.org
