Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727FE46AF16
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248250; cv=none; b=XNpLteRcsyExb5/mC4uFJzBjYAhvDCqplq5O0GZlC0Z7zwLqiS1qhV669exaKJzC38kNZ70JaD/ZA6kxoTBxbgbd3Ahl3EZevlkaOchJH9b4v/0ia7sPuaFOGFN7h8u2za22HCX4JMgTb+ZVFvkaLQVHBMpeZW47qI66V6d7g7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248250; c=relaxed/simple;
	bh=pYS/GFrUanOhlcC/NmixNJR7ATn1F3+XrW8M7qWpBNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdsfG8/AM70o1MrDQDhZ14IEu04qTUGPvH6gH8wqyGgBE+kFAlTOpND6QjTkG1Om54icVmQQpgdBjB+Da627o9gs/mty/Vqa6AxAZTWVU0CyWQDC2Aia0lckyd0N3JbrfDpD4uisp0PqsXMixJ740KTpqGrDtyCJehmQXQn/n3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpThNfJs; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpThNfJs"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso955964a12.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788248249; x=1788853049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rxm6irMUrWNwyv0K7EvAQpfSMPkiF7ptXJMabfvOf8g=;
        b=EpThNfJsQ9AomChPdkMhC+ueUfmuhcnHCj4LepdRK4IArvzFdfELpSPntEyyRt2Cfp
         DqVs/NN3eSXkF92ZXPLTLCswhB8ioJNF2lbekX4NmLTZqjKD5y4zcNd511t/AbB199sc
         vLTksHuaI1C+AGw5NIrffhR2AvMtdHLb9odAvEnllfL+HxW4EITCTXsJgiQqPQE6z73Z
         Q4Dt28GZUMpgDIPzepD7THKCdBO4R4b88QsOss5eT4KmLl1NzIbyTj+5YT3qCilL/KoF
         I9V/TvMpzmEH5buvK5+aDuDUAp6ET6mJazF5H47HTswCb40LAD1n47GSPTQmhDLgkO8n
         VVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248249; x=1788853049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxm6irMUrWNwyv0K7EvAQpfSMPkiF7ptXJMabfvOf8g=;
        b=TLbURLwbHi9Fmo34iJoTIsZitQRAdqKJsEuIhgcc5usdYXFyExJFJlWx0PVnWneqBh
         UsTyqlOS15GZ7cG+D6/9daUz1TICSbZZZeucDaUE/R9YGbnIRGdD3kgjqkqdtezvETLW
         dGMZKGC+o9Oy88xmdG6S+Y4RsMJlOzMjnZXomsmy/l4H2KoRsGWNyWC1ewBGbupH26LR
         OqNZqzqPOemz2KByKBKNTxu1JoRvsIcHaxe1roDA8cfxpBhnBLUwOXEhTy4pqlKcufRZ
         on2KDaqZGVki0LxvMblnCohwAjYaRKReMw9T67TYHhOx4BKcs4Y4F00HRyOT4Rz00p66
         LtkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkDh5mt8yjjVUcuON5CHVsnAohVKG7Kf7zHJv49cE9v+FkaPRvQcaiov1wHI9zwuW0L+h6E5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mHRfBBDxx26JkzZFKgCsWkaBPeAe83+TbhkUBeJtSB2LMKr6aq
	8lNeB52bL+h57fT+M8St7wgnVMT9+HEaNfJcl5iL2RDWNE6QmeOZuqf3
X-Gm-Gg: AYBFou0Fbo+wOBjJCUajzJg5ArVwJ0b9ybPjqSZ5Q5mGPkuJewqdvcFEY+g57kHO5Yr
	v9++ZXbzOAOZ4xBi2+BIWuYhgDlz9yOTNeGD63jeItbn1TTWmFxBL4DsKaya13CO7+ObdBmDJK+
	k29+56oBMdHUbNlB7MsXs67dRoGBJX7MCtbjP2vRe0j+FNqT+6ZM3+IuV6TVW58meSyZZXk/nkE
	Heb8rL6slVpIR3Jgp3JmDP3cQ7Z4iPEF9mvjhka69hfNnvAV+zwpIuMRNx7oVnrtsCMfau2peYt
	TEKj2LndKDHefcEla8begTvjydx0a4sulg1emG0ILjoG8K8M+3fjN/hI1r6u3332v0RT/RgOQrN
	iFu7UMJ4i2YMW+v4NKopf+Bg65JWG9y02RSS5+fBsghzXY+Jx1MBBEPjitz6ZqoQMzH7Rg08tWz
	lnZEGzqt6j10woMZXlhBxGCgPSvaiOTglU2cG6CoUwutSHKD3dmTbUc4RjHPQrrN12l2i08Hzz9
	wv7Rs4=
X-Received: by 2002:a17:90b:528b:b0:398:c16e:69d3 with SMTP id 98e67ed59e1d1-39907ab521fmr9594085a91.1.1788248248379;
        Tue, 01 Sep 2026 00:37:28 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990c40d0c9sm4465448a91.7.2026.09.01.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:37:27 -0700 (PDT)
Date: Tue, 1 Sep 2026 16:37:22 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
	idosch@nvidia.com, kuniyu@google.com, horms@kernel.org,
	willemb@google.com, andrew+netdev@lunn.ch, kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org,
	shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
Message-ID: <apaAskNL-IvdcR7h@v4bel>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
 <20260824033331.1084971-7-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824033331.1084971-7-imv4bel@gmail.com>

On Mon, Aug 24, 2026 at 12:32:50PM +0900, Hyunwoo Kim wrote:
> tcp_v{4,6}_rcv() calls tcp_v{4,6}_do_rcv() without holding the socket
> lock when sk->sk_state is TCP_LISTEN. Every other path into
> tcp_v{4,6}_do_rcv() holds it.
> 
> tcp_v{4,6}_do_rcv() and tcp_rcv_state_process() below it read
> sk->sk_state again. A listener can leave TCP_LISTEN through
> connect(AF_UNSPEC), and if that happens in between, the second read
> returns a different state.
> 
> tcp_rcv_established() or tcp_rcv_state_process() then runs without the
> lock. If the second read returns TCP_SYN_SENT, the incoming SYN is
> treated as a crossed SYN and reaches tcp_send_synack(). When the SYN skb
> at the head of the retransmit queue is skb_cloned(), that function
> replaces it with a copy and releases the original with
> tcp_rtx_queue_unlink_and_free().
> 
> The original is the skb that a thread on another CPU is transmitting
> right now in __tcp_transmit_skb(). skb_cloned() is true because the
> clone made for that transmit is still alive. Once the transmit returns,
> tcp_update_skb_after_send() calls list_move_tail() on the skb's
> tcp_tsorted_anchor.
> 
> In short:
> 
>   socket(AF_INET) -> bind() -> listen()   // the socket that changes state
>   socket(AF_INET) -> bind() -> listen()   // the peer
> 
>   Several threads keep opening new sockets and connecting to the first
>   socket's address.
> 
>   Another thread repeats this on the first socket:
>     connect(AF_UNSPEC)      // TCP_LISTEN -> TCP_CLOSE
>     connect(peer address)   // TCP_CLOSE -> TCP_SYN_SENT
>                             // another CPU still sees a listener, handles
>                             // one of those SYNs without the lock and
>                             // releases the SYN skb that this connect()
>                             // is transmitting
>                             // -> use-after-free
>     connect(AF_UNSPEC)
>     listen()                // TCP_LISTEN again
> 
> KASAN log:
> 
>   BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x14/0x140
>   Read of size 8 at addr ffff88800a5d1460 by task poc/125
>   ...
>   Call Trace:
>    __list_del_entry_valid_or_report+0x14/0x140
>    tcp_update_skb_after_send+0x62/0x170
>    __tcp_transmit_skb+0xe33/0x1e40
>    tcp_connect+0x1b67/0x2490
>    tcp_v4_connect+0x998/0xab0
>    __inet_stream_connect+0x22c/0x700
>    inet_stream_connect+0x48/0x70
>    __sys_connect+0x101/0x130
>   ...
>   Allocated by task 125:
>    __alloc_skb+0xd1/0x370
>    tcp_stream_alloc_skb+0x2d/0x2b0
>    tcp_connect+0x72d/0x2490
>    tcp_v4_connect+0x998/0xab0
>    __inet_stream_connect+0x22c/0x700
>    inet_stream_connect+0x48/0x70
>    __sys_connect+0x101/0x130
>   ...
>   The buggy address belongs to the object at ffff88800a5d1400
>    which belongs to the cache skbuff_fclone_cache of size 472
> 
> Instead of taking the lock, keep the lockless path from reading
> sk->sk_state again to decide how to process the packet. Move the
> TCP_LISTEN handling out of tcp_rcv_state_process() into
> tcp_rcv_listen_state_process(), and let the TCP_LISTEN branch of
> tcp_v{4,6}_rcv() call a new tcp_v{4,6}_rcv_listen(). Listener processing
> does not change. The TCP_LISTEN arm of tcp_v{4,6}_do_rcv() is left
> alone, because a socket can finish listen() after the state check and a
> backlogged skb is then processed there.
> 
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Looking at this further, unhashing the listener and then calling
synchronize_net() lets the disconnect path handle it. MPTCP needs a fix
too, though, because it closes and reuses the first subflow directly
without going through tcp_disconnect().

This also closes the trigger path for patches 4, 5 and 8. I would still
keep those, since they add no work to the fast path and they remove the
root cause itself. Their changelogs would have to change though.


diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d6f..ae6ab3b22beb53 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3373,6 +3373,8 @@ int tcp_disconnect(struct sock *sk, int flags)

 	/* ABORT function of RFC793 */
 	if (old_state == TCP_LISTEN) {
+		/* Wait for lockless listener receive paths to finish. */
+		synchronize_net();
 		inet_csk_listen_stop(sk);
 	} else if (unlikely(tp->repair)) {
 		WRITE_ONCE(sk->sk_err, ECONNABORTED);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b474d03620a75d..e41a5e1bf8dbf3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3432,7 +3432,7 @@ static __poll_t mptcp_check_readable(struct sock *sk)
 	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
 }

-static void mptcp_check_listen_stop(struct sock *sk)
+static void mptcp_check_listen_stop(struct sock *sk, bool sync_net)
 {
 	struct sock *ssk;

@@ -3446,6 +3446,9 @@ static void mptcp_check_listen_stop(struct sock *sk)

 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	tcp_set_state(ssk, TCP_CLOSE);
+	if (sync_net)
+		/* Wait for lockless listener receive paths to finish. */
+		synchronize_net();
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
 	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
@@ -3462,7 +3465,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);

 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
-		mptcp_check_listen_stop(sk);
+		mptcp_check_listen_stop(sk, false);
 		mptcp_set_state(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3593,7 +3596,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return -EBUSY;

-	mptcp_check_listen_stop(sk);
+	mptcp_check_listen_stop(sk, true);
 	mptcp_set_state(sk, TCP_CLOSE);

 	mptcp_stop_rtx_timer(sk);


Best regards,
Hyunwoo Kim
