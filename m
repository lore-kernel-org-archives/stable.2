Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021256;
	b=JmqrFH8ROyq5ixzs4P8Vrcs1+VIQB9pOBUQ/PAI1lCKsW8Nv1Gtjb2Y2S6eArwpGxCsO
	 W0/3yCY9gHtleUApu5atZnAbRt6g+0VUjJkWlJf6aHaxhN1W/tJ9tBEeZAntgcxE4zF4x
	 va5DJI+FUhjnOxutXP/gIkE39J2j5jTiUpPPnp5X6RMvspL2S76wMdPo15tC18GeVmDOq
	 5uf2P0DN1Vyqnv52RHVtoUVcQ8vkeR1uB/dUltA5VClfmGilMsxg4htr3Jtef+ZpXJj+u
	 iHFFrw5OcJfWNDZMkKr3JXNVAOMZ0Ab7u41kGUueV4XBi4cQPusfzWemDWb2vEgNZnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
	b=4fF2qlHceNUgnRh+duVbMZInPOYIE32rQuEg2CHd1kZ5xYtky6Md550JzeV4WS6VGg+r
	 5o/+7iDAQonFT0O55vYJp/rMl7gNFi9iLTy+tENVTi7pVFCdwMhiahbSbURhfIU+FD+N3
	 Jz7QeaUHn3qSRIf4dPracUdQYiN/A8LdsAlwTcpX6cYT8l+oJH2cxZd6q/UDa2eD81Mbj
	 ao0cR4tfn7eWzeDSNAXVpnloqioCQNeGh0H/6JFUb/uA+k6xX/e5cRlWxHOxBEoVvvW1L
	 yf+DUld9j/WiisMuhq7USo9wH4ZiHbeW1OVZVeTpvOR0ULFyz7k+m3u4y1bHBIXUj0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hAUPdKhF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956EF606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 956EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hAUPdKhF
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5337c7b9937so430171cf.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793021254; cv=none;
        d=google.com; s=arc-20260327;
        b=LcxkoKCq+ThV/A8/+5/oE7lQFn33Y934jpDLEgQokI7z8jLnxlXRMLdMfHBYeY97Jy
         riYF8H6yhAHpAv7ahy3JhaOo91nOPZj9z/gcS1pJxOYx5Yi+yECQy5c0IEfq13i0w88h
         50oPeKexefzAkU4IKsj9s+U3oJb7CRwOPZ+7Y/FVg4HK6Ay5lagc89BUlvzXB2HvA+BQ
         ug25okWuPzzCoLI0TalCejo2xQMDneRn0O4rNsT1xPv5kJQ3xrd7zQ/4Ed0aHc7mmifF
         oBgHlXtboBJVb+mUUN51034/PmU/IJ0MrIv+NGzwf6FU/7qnOCEe20T7op1Y2AfLkVXj
         rDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
        fh=wufbyq/lpRhQT115ztFwDjYpG02l9k/aBK9fvk7tDCA=;
        b=MLovlOjx8BJgBGNfSxHw2eLznmKEdAW3sSOgIz1jGPuEtIotVGrcPXKk53TxYJg6jP
         J/0Cf1WvGcIy4pK/LR+xkf2vrrI9xI+ms0NivGT5rKb3hMIs2GUkxqpAcKI27W5LHlFa
         Dh2WeVwWY1IS01YN16BUsx3D2kdD2yB8LQfuizaSgf9xEuQC6pObuG/dPAlKAAKdWjHp
         WGUJpw3n9SZV1K+ZPObBjmOHpGhBVcpVeUnUgeyRPUWifbyShVD48M5iMXHphlOXIeOX
         IRWI6Xtwl31amMpl4hiCOqob2dCMokGXxM9wckIUQWBy6tdzJB4bVBzspA4NGEKflDTU
         iEWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793021254; x=1793626054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
        b=hAUPdKhFb4YcJgs9WppssCBaF0t60fSy0OghEfwc4oVYYVnVADcmw5y8kjPhTd6unZ
         mKt3RW8zeOnh3ZcDBOM+30XGP9+AHaYXfahxBsoNL4k6D0AmNPZ6lUHI+D0jkrxz8D2i
         vB/xGjULPsl89ub2+BEPfYi5fZ/OmyVEc95jYnp/xC/3UmAVXuFjrTvwDZRST0gUtX+i
         /Coh/IxdsB6CDtnBz4AF1jK+q8dx/9NmatD+dSDArUZF7taXL1yugOE3jeue/vlsqBrD
         UhwUDFrYiR+/1GSQHUl8VjCuFoFiLb20U+xxaagT1N3YuTOnrX4JFeW+rmwi6DGSoL8T
         32fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021254; x=1793626054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHqLvj8Lae2DmWkzf4tbdqzHokUVVq51GUhntGgEEB0=;
        b=RjBXiGwQ937XDbh6dKEv/Qec8Fthpp6omfcHmzhFHAwkR4wyo8Qk3khZcHazP3HpcP
         mx+nXd9dWHyZUVHa4NSONED5gydktsd12sowEnZ3uLuWqwFSMjF2ZB0OstOCUDTnG4ef
         kzhp/WDxFnkS6VHMeCztk6wSMhIQJc036AoWkBHVIfI/6WGEQWbiP+a9dRKGx1NDLuxn
         01Llj88l8tjOF+jwErHXcs9e+X6e8HL24M8a4iknWExNFNaHOW29PFGXJ2pFXJIyuLmG
         zjoHWfBxtMPPpcfWImJ6ME8eqeDtu9XQtyx4DGdNPtZP7dTwdENW1TbV/2wPselUPfBP
         J9KQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLypY5bFaijuJ/01MySbdrsPSgfuhG5nAGI4pOtB7Qd7dwJS/2P2Cwzw8Qym6rR+Ea9wUSN/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlXnoELam4qZF5wjHv2YsFBlcK9hDceQG3u2WGNUvaMMz8VtCg
	/6Ty7lV7hmxsHKDqQsBZHuyqcszZngRKre74/Z/svT8o4iUShsjxpH6Eb/cjsWQn2eX7Gt+jLR3
	U8bouPg2qKLXILnws+Ge6WSjjdvX48IluAXERO55c
X-Gm-Gg: AYBFou2981t0zVHeUu/hjICtQLYSabAvgPPLfQC7un1RA1UduLdQHOjusrjEcx8epEa
	1Vdk59k8pXwwe3OiMxFUHoUH1jyet0BKS/AW7ThNJxSr7TQBN+D3GFmaHUILnFUjO3P/axoInsU
	YG+6mil+GKlszL8z0SgltP88btGhEW4w1Cu4++t7wSvwBDAJnKrK5iZTnAcJuhs9jcqiK1WcBbW
	K1Q7k4e3LCp5NJH6ZAI/9Qc3V79cB49x9uUPaePrb/lgZx7Cdo/hJm9PATBWKewT/K95d+WhLqC
	KhgkksD3TZRCyDVuHBFxk3kA3CwSy9wfIhfqicArP4Kz2QsbmemoqTQzKsCIfr4+ZKdFORSxnhg
	iBLLuNwAS4jFK/RzoN6HxBmn53uESZWv6vlaa4neinKMiX/5qKgTCzWiXkH2aNhiwsSwOo5ka4X
	2Ru7ySzrQfUrPWvPOKrMA1PuH2dKA=
X-Received: by 2002:a05:622a:17ce:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-5383b334525mr33163801cf.1.1793021253663; Mon, 26 Oct 2026
 06:27:33 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026123244.239766-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261026123244.239766-1-jiayuan.chen@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 26 Oct 2026 09:27:16 -0400
X-Gm-Features: AclHuK9xXY2sfDTTRDFEqgc-QLnjFc7Mr6f06K7c4ldWWLoFtzMF4Hg3hrOtA5o
Message-ID: <CADVnQy=ZQ8VEdwSB6gcC=67aD+OJkMvu-tbhgwEn0YEZCyVw6g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: fix shift-out-of-bounds in SYN-ACK
 retransmit timers
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Kuniyuki Iwashima <kuniyu@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:32=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> req->num_timeout counts the SYN-ACK timeouts of a request and is used as
> a shift amount:
>
>         /* tcp_reqsk_timeout() */
>         u64 timeout =3D (u64)req->timeout << req->num_timeout;
>         /* tcp_fastopen_synack_timer() */
>         req->timeout << req->num_timeout
>
> Once it climbs past the width of the shifted type the shift is UB. Seen
> with tcp_synack_retries=3D255 and a peer that never completes the
> handshake:
>
>   UBSAN: shift-out-of-bounds in ./include/net/tcp.h:917:34
>   shift exponent 64 is too large for 64-bit type 'long long unsigned int'
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0xc1/0xf0
>    dump_stack+0x10/0x20
>    __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>    reqsk_timer_handler.cold+0x1c/0x5d
>    call_timer_fn+0x17d/0x510
>    __run_timers+0x662/0xab0
>    run_timer_softirq+0xdf/0x260
>    handle_softirqs+0x204/0x9b0
>    __irq_exit_rcu+0x13c/0x220
>    irq_exit_rcu+0xe/0x20
>    sysvec_apic_timer_interrupt+0x40/0xd0
>    asm_sysvec_apic_timer_interrupt+0x1b/0x20
>
> num_timeout is a 7-bit field. Once a retransmit limit is above 127 the
> "num_timeout >=3D limit" check can never be true, the request is never
> expired by that limit, and after the field wraps to 0
> reqsk_timer_handler() decrements queue->young again on the next expiry.
>
>  - split tcp_reqsk_timeout() into tcp_reqsk_timeout_sk() and bound the
>    shift there; a num_timeout well under 30 already saturates the
>    tcp_rto_max() clamp, so nothing reachable changes for the u64 path.
>  - cap max_retries / max_syn_ack_retries at 127, the largest value the
>    field can hold, instead of narrowing the sysctl; 128..255 are still
>    accepted and act as 127.
>  - cap the TCP_DEFER_ACCEPT conversion in secs_to_retrans() at 127 too;
>    larger values kept an acked request from ever expiring. getsockopt()
>    now reports at most 14527 instead of 29887 seconds.
>  - route the TFO path through the same helper; its u32 shift could also
>    wrap to 0 before reaching UB.
>  - document that tcp_synack_retries values above 127 act as 127.
>
> Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v1 -> v2: reworded the commit message, no code change.
> v1: https://lore.kernel.org/netdev/20261023064915.401112-1-jiayuan.chen@l=
inux.dev/
> ---
>  Documentation/networking/ip-sysctl.rst |  4 +++-
>  include/net/tcp.h                      | 16 ++++++++++++----
>  net/ipv4/inet_connection_sock.c        |  2 ++
>  net/ipv4/tcp.c                         |  2 +-
>  net/ipv4/tcp_timer.c                   |  3 ++-
>  5 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 4b19c8d3efda..eac33072be2d 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -956,7 +956,9 @@ tcp_stdurg - BOOLEAN
>
>  tcp_synack_retries - INTEGER
>         Number of times SYNACKs for a passive TCP connection attempt will
> -       be retransmitted. Should not be higher than 255. Default value
> +       be retransmitted. The sysctl accepts 0-255, but values above 127 =
are
> +       silently capped by the SYN-ACK timers to match the 7-bit
> +       request_sock::num_timeout field. Default value
>         is 5, which corresponds to 31seconds till the last retransmission
>         with the current initial RTO of 1second. With this the final time=
out
>         for a passive TCP connection will happen after 63seconds.
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0265c27a5fd7..986b7ea05e4a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -183,6 +183,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define MAX_TCP_KEEPINTVL      32767
>  #define MAX_TCP_KEEPCNT                127
>  #define MAX_TCP_SYNCNT         127
> +/* request_sock::num_timeout is a 7-bit field. */
> +#define MAX_TCP_SYNACK_RETRIES 127
>
>  /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
>   * to avoid overflows. This assumes a clock smaller than 1 Mhz.
> @@ -912,12 +914,18 @@ static inline u32 __tcp_set_rto(const struct tcp_so=
ck *tp)
>         return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
>  }
>
> -static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
> +                                                const struct request_soc=
k *req)
>  {
> -       u64 timeout =3D (u64)req->timeout << req->num_timeout;
> +       u64 timeout =3D (u64)READ_ONCE(req->timeout) <<
> +                     min_t(u8, req->num_timeout, 30);
> +
> +       return (unsigned long)min_t(u64, timeout, tcp_rto_max(sk));
> +}
>
> -       return (unsigned long)min_t(u64, timeout,
> -                                   tcp_rto_max(req->rsk_listener));
> +static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
> +{
> +       return tcp_reqsk_timeout_sk(req->rsk_listener, req);
>  }
>
>  u32 tcp_delack_max(const struct sock *sk);
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 8151c638a24c..ee7b64f3141c 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1072,6 +1072,8 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>         net =3D sock_net(sk_listener);
>         max_syn_ack_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
>                 READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
> +       max_syn_ack_retries =3D min_t(int, max_syn_ack_retries,
> +                                   MAX_TCP_SYNACK_RETRIES);
>         /* Normally all the openreqs are young and become mature
>          * (i.e. converted to established socket) for first timeout.
>          * If synack was not acknowledged for 1 second, it means
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 99d7237a623d..a309fd45ad42 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -358,7 +358,7 @@ static u8 secs_to_retrans(int seconds, int timeout, i=
nt rto_max)
>                 int period =3D timeout;
>
>                 res =3D 1;
> -               while (seconds > period && res < 255) {
> +               while (seconds > period && res < MAX_TCP_SYNACK_RETRIES) =
{
>                         res++;
>                         timeout <<=3D 1;
>                         if (timeout > rto_max)
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index e56eae4bc341..f7b100334a89 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -469,6 +469,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk=
, struct request_sock *req)
>          */
>         max_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
>                 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) +=
 1;
> +       max_retries =3D min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
>
>         if (req->num_timeout >=3D max_retries) {
>                 tcp_write_err(sk);
> @@ -490,7 +491,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk=
, struct request_sock *req)
>         if (!tp->retrans_stamp)
>                 tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
>         tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> -                         req->timeout << req->num_timeout, false);
> +                            tcp_reqsk_timeout_sk(sk, req), false);
>  }
>
>  static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
> --
> 2.43.0

The following review comments are from an LLM, look legitimate, and
IMHO are worth addressing.

Please either incorporate each piece of feedback or respond to
indicate why you think it's not appropriate.

---

Thanks for the fix. The logic looks right to me, and I could reproduce
both splats and confirm the patch fixes them. A few comments:

1) The changelog suggests tcp_synack_retries (or TCP_DEFER_ACCEPT) must be
   raised. But a listener can also set TCP_SYNCNT up to MAX_TCP_SYNCNT
   (127), and that also bounds its SYN-ACK retries. So num_timeout reaches
   the UB range with default sysctls. With TCP_SYNCNT=3D127 plus
   TCP_RTO_MAX_MS=3D1000 on the listener, the tcp.h:917 splat (shift
   exponent 64) shows up after about 64 seconds. For TFO it fires already
   at num_timeout 32, because "req->timeout << req->num_timeout" is a
   32-bit shift (req->timeout is u32). Please mention TCP_SYNCNT. It also
   shows the shift clamp is needed independently of the 0..255 sysctl
   range.

2) Before the shift amount goes out of range, the shifted value already
   wraps. With HZ=3D1000 and req->timeout =3D 1000:
     (u64)1000 << 61..63 =3D=3D 0, and (u32)1000 << 29..31 =3D=3D 0.
   Both give zero-length timers. On an unpatched kernel I see bursts of
   three back-to-back SYN-ACK retransmits about 1 ms apart:
     - regular path: at num_timeout 61-63, and again at 125-127 once x86
       masks the shift count;
     - TFO path: at num_timeout 29-31, 61-63, 93-95 and 125-127.
   That is user-visible on production (non-UBSAN) kernels and is also
   fixed by your clamp. It may be worth a sentence in the changelog.

3) READ_ONCE(req->timeout): as far as I can see, req->timeout is only
   written in reqsk_queue_hash_req() and tcp_fastopen_create_child(),
   both before the request is visible to other CPUs. If this is meant as
   a data-race annotation, please explain it in the changelog (and pair
   it with WRITE_ONCE()). Otherwise I would drop it from this fix.

4) Nit: this patch caps the shift at 30 and patch 2 caps it at 32, for the
   same reason. Maybe use one bound in both, plus a one-line comment on
   why it cannot change the clamped result. 32 also works here, since
   (u64)U32_MAX << 32 still fits in a u64.

5) Nit: MAX_TCP_SYNACK_RETRIES duplicates MAX_TCP_SYNCNT (127), which
   already limits the listener's SYN-ACK retries via TCP_SYNCNT. Maybe
   reuse it, or define one in terms of the other, with the 7-bit
   num_timeout comment.

6) Have you considered limiting the sysctl itself, as 651e92716aaa
   ("sysctl net: Keep tcp_syn_retries inside the boundary") did for
   tcp_syn_retries? That would make the limit visible to admins instead
   of silently capping it. The consumer-side caps would still be needed
   for TCP_DEFER_ACCEPT and for the TFO "+ 1" (128 can never be reached
   by a 7-bit counter), so your approach is reasonable. It would be good
   to say in the changelog why the silent cap was preferred.

7) Minor: once num_timeout wraps to 0, the
   "if (req->num_timeout++ =3D=3D 0) atomic_dec(&queue->young)" in
   reqsk_timer_handler() and reqsk_queue_removed() decrement queue->young
   again. That is one more symptom fixed by making the request expire at
   127.

8) The documentation text exposes an internal field name
   ("request_sock::num_timeout"). Maybe simply: "Values larger than 127
   are treated as 127."

9) Small user-visible change worth a note in the changelog: for large
   values, getsockopt(TCP_DEFER_ACCEPT) now reports at most
   retrans_to_secs(127) =3D 14527 seconds instead of 29887.

10) Per Documentation/process/maintainer-netdev.rst ("Bug fixes"), please
    state how the issue was found, how it was validated (the reproducer
    steps are short enough to include), and how the fix was tested.

---

Thanks,
neal
