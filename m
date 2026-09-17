Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471F4D0CCD
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643698; cv=none; b=NCpJILrhk1s8TfUghyvWazHv82fuZC41eDkfx3B0j8j03GN9zUkHoAeFH4dKfUiEDCUDuwqaybdqhGUqwExxEPEqcDrARbY1evV7xRjB/bRDW4CnK1bhQ/zddho0m+TbNDYS9wFOu2Flh1990YvdSV+9Kf4ymMdmJzuVoc4r33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643698; c=relaxed/simple;
	bh=yaUHywk+HRls2oGlqzbXlpzTPa0QB+HsreFfTJvFWng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6oGKwL+TrSmbUhHUhxGfZQi0ruDz2XGYp2sAA+o4yx82WLRuc5fDWB8aCNcYY4qHOPwurqJpE0P+hhcWe7GIHDk2eLg10COnDZTwhwT95f0ZjnER2SssHBljklpFlBRKK3w4XSAz/En9x5ZaWTYVik6+yFB39e8CARw3+3sdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMGpU7/k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuzJb4Ns; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMGpU7/k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuzJb4Ns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789643689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB6cedv3wb2iJpHvP6bOucKdHMXRoYEnunTmHPPHgss=;
	b=jMGpU7/kdWWMiiQxhSJZwjSfD+CdYOhUzU4OvcVo3uI0nYPsoitB4nMlk1meBmSmOSFdCg
	zccstMVJTyW+KQAAWjWxALmRyh7U6EDTg3zbcresgIDCEyTszsAaeRIslaofS62JgxKyl/
	v6czAZbjHpkx7pybcDS4isfjNzRE8vQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-8L4wGW9BNfaKV7OW0ausnA-1; Thu, 17 Sep 2026 07:14:47 -0400
X-MC-Unique: 8L4wGW9BNfaKV7OW0ausnA-1
X-Mimecast-MFC-AGG-ID: 8L4wGW9BNfaKV7OW0ausnA_1789643687
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65ecd557so5822785e9.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789643687; x=1790248487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tB6cedv3wb2iJpHvP6bOucKdHMXRoYEnunTmHPPHgss=;
        b=ZuzJb4Ns9dFGa5+Pvr/BRDoJ60pUNZW8ZdVZWlP2Daf3wZzcFYy4uZbkuRhhQsXptr
         Wkkgaaz5Wt2tBHavcL6OKzEnsqOQrtp07Xycz0e9slf6oxT8lFlxVSGcR7jILJ1T1NQ4
         2fDd3QXGsDy7Fl/CMuPC2hhd4i1Lv7SYAyacp10lvg1gb5GFpo6PSfS3lBsyCvys8LKw
         ny+63VFFa3Pf2o+l2wabVvO4xHLLJ3PoyNPb7aib4/GeLguYvoaNSmNu6tX1Sq+o3J23
         Fw4+auJQlMVpojaq4owhU2AgQf6TX68QHHTZmXaw87GqweRJnQ2pHpG/MbbHdPNKULPm
         ltUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643687; x=1790248487;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tB6cedv3wb2iJpHvP6bOucKdHMXRoYEnunTmHPPHgss=;
        b=HFEtnBXcjOw/l5VC6u0E2GA0BK8RVtUWrrKt/+GXnmX9J1vPk5BtU11mx4+1mFzDUY
         2H3h8f0dWBkr8RGBoowB4CddUErijBFsNzFhPS8tI7Jfng+3YadJd2qE62Cja0TkVBVP
         mkxsOFDhe7B/aNgBeBBSFMA5oLx5TZlZ1GH+e1NtDAo62EldvNjbMr/fKe0qF+lZDF+n
         xlIMPwy+KqyM/CWo5d5gvKYh5w/B4zIHhag4kCUDEvG44l785195vhlB6NwLarghGbKc
         l9aLoCg+vre+Z/lrPTNrhvTBneiU8PuHbkqBif4ZbldyqGTFh+WBa9urxhxraj4ZxhZb
         Ig5A==
X-Forwarded-Encrypted: i=1; AKwUvBwLoYKaxblds1b+q7G2DSw8dNywNCfghQLyTExa9NQc8YGel+GISf33KCKcevu1WovIAL2fZtw=@vger.kernel.org
X-Gm-Message-State: AFuF++kVFwXNsy+8inDiVoJZ9wYcpjR9tZQJ5//o3SEtGA7g16U5m0n1
	sZHVer+2TTq0G/uCLacgqjotnj7XfTvir3ODzQW3xImfAZK2xFaPdamJDGCKtvGrbamTzJ1msWV
	ZenvZ5DvbmtwW6rr080Oma6P/GEsBGxERln6xvk1PaYF4IF0rwAJnC7GtiA==
X-Gm-Gg: AYBFou11dultI4PVdrv0FGyN2ZbUBc7eRs63W//eu8rVUUBkJwlEoRzb9Zw/CtE2fYi
	YdNloPwwNTKSIiNTUQMs9HuRrlPqZZ/xrI5DuSspOYoCPhV9aqRe8bWvU5TsftMjW7miO9f2pJY
	NIep/MnKLs9a8TsGyNk9fTr97LDwHH+80oUcM/i2I/sfzgGbjXyk2K9psGc/5EapSt5zfUyE2L/
	uNmGqu/DDOwlea36eb+YpwyiCii2/4K6vpr/K4sI7lNZRi9dpo7PRjwFtwxyj2cNZ+DHZ7fmfRz
	JJRrk+4Y9B5vFerr1ZdY+pIEY85jTI0NJzA69nL2EIYPiHizJV0Fl29+XwRdR40MRTOJ407CVTd
	sIdJOp30kJ7rKefQVHpjA8hPZ1bdFzsJC2LLlyDiBDIB5G/Ra83SvBpYAns0QIg0N2aU2sw26Xw
	==
X-Received: by 2002:a05:600c:a14:b0:49d:433:c3b6 with SMTP id 5b1f17b1804b1-49ec053a640mr75279835e9.27.1789643686579;
        Thu, 17 Sep 2026 04:14:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a14:b0:49d:433:c3b6 with SMTP id 5b1f17b1804b1-49ec053a640mr75279395e9.27.1789643686000;
        Thu, 17 Sep 2026 04:14:46 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbbd83e39sm95218655e9.4.2026.09.17.04.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:14:44 -0700 (PDT)
Message-ID: <21775818-943d-4978-911a-4da550d49781@redhat.com>
Date: Thu, 17 Sep 2026 13:14:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] mptcp: avoid unneeded actions on subflow reset
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org,
 shardul.b@mpiricsoftware.com, xinyang@anthropic.com
References: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-1-a257797dd5d0@kernel.org>
 <178959153492.22033.1944011998010756543@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178959153492.22033.1944011998010756543@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 22:45, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 · Medium: 1 · Low: 0
> 
> - [High] The new unconditional `if (subflow->resetting) return;` in
>    subflow_state_change() (net/mptcp/subflow.c:1891) removes the last…
> - [High] mptcp: data race in bitfield resetting and close_event_done
> - [Medium] The new early return in subflow_state_change()
>    (net/mptcp/subflow.c:1891) is justified by an in-code comment claiming…
> 
> --
> 
> mptcp: avoid unneeded actions on subflow reset
> 
> This adds a new subflow->resetting bit, set in mptcp_subflow_reset() before
> tcp_done(), and uses it to return early from subflow_state_change() so the
> nested mptcp_data_ready() recursion is broken. The early return also skips
> the data-available check, the error report and subflow_sched_work_if_closed().
> 
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 01db7edce18a6..cbe227d218449 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -438,6 +438,7 @@ void mptcp_subflow_reset(struct sock *ssk)
>>   	/* must hold: tcp_done() could drop last reference on parent */
>>   	sock_hold(sk);
>>   
>> +	subflow->resetting = 1;
>>   	mptcp_send_active_reset_reason(ssk);
>>   	tcp_done(ssk);
>>   	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
> 
> [Severity: High]
> The new bit is carved out of the same 32-bit bitfield word as
> closeing/close_event_done/mpc_drop, and a C bitfield store is a
> read-modify-write of that whole word, not of the single bit.  So the
> question is whether that word is only ever written under one lock.
> 
> mptcp_subflow_reset() now writes subflow->resetting.  On the
> mptcp_mp_fail_no_response() path the caller is mptcp_worker(), which
> holds the msk socket lock and then lock_sock_fast(ssk), so both locks
> are held.  But the DSS-corruption path -- mptcp_dss_corruption() ->
> mptcp_subflow_reset() -- runs from get_mapping_status() /
> mptcp_subflow_data_available() in the ssk receive path, i.e. with only
> the subflow socket lock (and possibly in BH context).  Meanwhile
> mptcp_close_ssk() writes subflow->close_event_done = true holding only
> the msk socket lock.  Those two locks do not exclude each other, so
> the two load/or/store sequences can interleave on the same word.
> 
> If the msk-side store wins, the resetting = 1 store is silently
> dropped, subflow_state_change() takes the old path and we are back to
> the recursive mptcp_data_ready() and the data lock re-acquisition this
> patch is meant to break -- the failure mode is the same deadlock, just
> rarer and harder to reproduce.  If the reset-side store wins,
> close_event_done is lost and the post-close event handling runs twice.
> KCSAN should be able to flag this write/write pair.
> 
> Is there serialization here that I am missing for the
> mptcp_dss_corruption() caller?  If not, would you consider keeping
> resetting out of the msk-owned bitfield word -- a plain bool next to
> data_avail/scheduled, or a bit in a flags word updated with set_bit()
> -- so that setting it under the ssk lock cannot clobber bits owned by
> the msk lock?

This is actually a pre-exiting issue, and quite unrelated. Could deserve 
a separate/later fix.

> [ ... ]
> 
>> @@ -1883,6 +1884,13 @@ static void subflow_state_change(struct sock *sk)
>>   
>>   	__subflow_state_change(sk);
>>   
>> +	/* Rx queue processing is unneeded, error reporting will take place at
>> +	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
>> +	 * fallback: subflow_sched_work_if_closed() would be a no-op.
>> +	 */
>> +	if (subflow->resetting)
>> +		return;
>> +
> 
> [Severity: High]
> Can a reset subflow with a non-empty ssk->sk_receive_queue still get
> cleaned up after this early return?
> 
> mptcp_subflow_reset() calls tcp_done(ssk), and tcp_set_state(TCP_CLOSE)
> unhashes the socket, so subflow_data_ready() cannot fire again for this
> ssk.  That makes the tcp_done() -> sk_state_change() ->
> subflow_state_change() path the last remaining entry into
> mptcp_subflow_data_available() for this subflow, and the new return skips
> it.
> 
> The flush that exists for exactly this case lives in validate_data_csum():
> 
> net/mptcp/subflow.c:validate_data_csum() {
> 	...
> 	if (skb_queue_is_last(&ssk->sk_receive_queue, skb)) {
> 		/* if this subflow is closed, the partial mapping
> 		 * will be never completed; flush the pending skbs, so
> 		 * that subflow_sched_work_if_closed() can kick in
> 		 */
> 		if (unlikely(ssk->sk_state == TCP_CLOSE))
> 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 				sk_eat_skb(ssk, skb);
> 
> 		/* not enough data to validate the csum */
> 		return MAPPING_EMPTY;
> 	}
> 	...
> }
> 
> With the skbs left in place, does __mptcp_close_subflow() keep skipping
> the subflow forever?
> 
> net/mptcp/protocol.c:__mptcp_close_subflow() {
> 	...
> 		/* 'subflow_data_ready' will re-sched once rx queue is empty */
> 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
> 			continue;
> 
> 		mptcp_close_ssk(sk, ssk, subflow);
> 	...
> }
> 
> mptcp_worker() has already cleared MPTCP_WORK_CLOSE_SUBFLOW at that point,
> and recvmsg() only spools msk->backlog_list in mptcp_move_skbs() /
> __mptcp_move_skbs(), so it never touches ssk->sk_receive_queue.
> 
> A concrete path with net.mptcp.checksum_enabled=1: a bad DSS csum arms
> subflow->fail_tout in mptcp_subflow_fail(); a later partially received
> mapping returns MAPPING_EMPTY leaving skbs queued on msk->first; the
> MP_FAIL echo never arrives, so mptcp_worker() calls
> mptcp_mp_fail_no_response():
> 
> net/mptcp/protocol.c:mptcp_mp_fail_no_response() {
> 	...
> 	slow = lock_sock_fast(ssk);
> 	mptcp_subflow_reset(ssk);
> 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
> 	unlock_sock_fast(ssk, slow);
> }
> 
> fail_tout is then cleared, and since __mptcp_close_ssk() is never reached,
> mptcp_start_tout_timer() is never called either.  Does that leave the msk
> in TCP_ESTABLISHED with its only, dead subflow, no pending timer, and a
> reader blocked in mptcp_recvmsg() that is never woken with EOF or an
> error?
> 
> The same early return also appears to leave reset join subflows (the
> 'reset:' label in check_fully_established() and __mptcp_flush_join_list())
> with their context and queued skbs pinned on msk->conn_list.
> 
> For reference, the DSS-corruption path itself looks unaffected, because
> __mptcp_move_skbs_from_subflow() re-calls mptcp_subflow_data_available(ssk)
> in its own loop.

This may deserve to be fixed in the same series.

> [Severity: Medium]
> The comment states "subflow reset can't happen in case of fallback:
> subflow_sched_work_if_closed() would be a no-op".  Is that premise
> enforced anywhere?
> 
> mptcp_mp_fail_no_response() resets msk->first purely on fail_tout expiry,
> with no __mptcp_check_fallback() test.  fail_tout is armed by
> mptcp_subflow_fail() while the msk is not yet in fallback, and nothing
> seems to clear it when a later fallback succeeds: __mptcp_try_fallback()
> only touches allow_subflows / MPTCP_FALLBACK_DONE, and the pm.c side clears
> fail_tout only on an MP_FAIL echo.
> 
> With net.mptcp.checksum_enabled=1: a middlebox mangles the MPTCP options,
> MAPPING_BAD_CSUM with valid_csum_seen sends MP_FAIL and arms
> fail_tout = jiffies + TCP_RTO_MAX; the echo never arrives; a subsequent
> MAPPING_NODSS on the same first subflow makes mptcp_try_fallback() succeed,
> so MPTCP_FALLBACK_DONE is set while fail_tout is still armed.  The tout
> timer then runs mptcp_worker() -> mptcp_mp_fail_no_response() ->
> mptcp_subflow_reset(msk->first) with __mptcp_check_fallback(msk) true.
> 
> In that state tcp_done() sets SHUTDOWN_MASK/TCP_CLOSE, so subflow_is_done(ssk)
> is true and msk->first == ssk, which is precisely the branch that is not a
> no-op:
> 
> net/mptcp/subflow.c:subflow_sched_work_if_closed() {
> 	...
> 	/* when the fallback subflow closes the rx side, trigger a 'dummy'
> 	 * ingress data fin, so that the msk state will follow along
> 	 */
> 	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
> 	    msk->first == ssk &&
> 	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
> 				      subflow->map_data_len, true))
> 		mptcp_schedule_work(sk);
> }
> 
> Skipping that call means mptcp_update_rcv_data_fin() is never invoked, the
> msk never moves to CLOSE_WAIT/RCV_SHUTDOWN, and blocked readers get no EOF
> until the close timeout (net.mptcp.close_timeout, 60 s by default) fires
> and mptcp_do_fastclose() sets TCP_CLOSE and purges the backlog instead of
> delivering a clean EOF.  Should the comment be qualified, or should the
> check be narrowed so the fallback DATA_FIN injection still runs?
Yeah sashiko does not like my wording, plus another unrelated race 
between fallback and mp_fail timeout.

/P

