Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077545;
	b=s5yk6kBG74JSZgACV5IK3MVwhAqa3GlqGMS2YYQuWVIa5lsVtANV2PrgeersJewavzEz
	 c9l/7J0qRa96KXWC9xfgFTX+kEowZmmUGFZlEZeSof/Fa++4et+hmTO5eXlyPgSi/9m9z
	 iXbfRaQempD2kuoZ5oZ/jy/z0QoTl5SXrW7LjnLEbRAFySScw6Iek32AEuyOwZtzqBE4U
	 Sl7WhgEE74PK9rdJ8egvzif/B0/Hl/O3r6x2XdTW62Pdt4oEbYmpe07DOws1sE9RUIygQ
	 SBp9qwfRpRnostmQO2XU9xNgTrlgl3f19vBtbC4ouf4dhLdlidO36SwQIk39R/uNfYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077545;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qTu0M8ZplBrwJ8o8XHJM31ciLhynvJopV2Hs5MErUkA=;
	b=PKErw0+WtogU66gBqqHTrsqKRWQfDSbGhODTrMhUk2cr8FuNB5VQRWIdkCADCPzVoNdU
	 jVPgb2nzKl+TDCUpyGkEc/bg5Q+wYMXGRk5AaskPGKeQqvetf1Vyx3cUOF1q2AiBaF/RX
	 nim3ec+wZP5w7OkJwvkxamOxeQ4mTcp1vfs3nwaRgLNsbSmzL0eP/F5/vDmvReerL3ai8
	 09qTryGKoH6V+d6VuOTgZ2UVXYy0LDVZPwdN0urL+FC3ApKs7XYYzSVGI33DoPvww+qDZ
	 Qg7HWaxAMGeQsCcrUcQcvIh27acBpxzI56B4JQ6BDH/k1H4n+IyHOH24iT91wzWh4Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKfQd0wD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA91606A320;
	Thu, 19 Nov 2026 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKfQd0wD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05001F000C4;
	Thu, 19 Nov 2026 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795077544;
	bh=qTu0M8ZplBrwJ8o8XHJM31ciLhynvJopV2Hs5MErUkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mKfQd0wDGLJjb24cW41DsQamVSmxNTgzqMVqhL7hwMk4MySWEzMk9euwHpQBvvaLS
	 DfeW8ZhO83Pd803T7ZRJPYLtgSwyY6njZTo/B9nsPl/jV1zSZSKQMse21qhPAKAmHn
	 oxWioP6Z4n4YbK5oeGVAmT+DZ4JZZNijC1qSifMfB1IqB+gt9noNo5SVkiwwioANAE
	 fW24p5HuLVd3CIPZ8kSWI1+cjSO22tLV0SwYVO7A2kMdjPMedFVaYI39vhPlQtQPa4
	 IRRLCSiIyAa+XwemwfK6CNv3sTnhmGrgyo7n1xUBqAejA49zenc4tMP1rpgOJGBT3n
	 paLxpg4q2+wnA==
Message-ID: <d06163a2-b29c-41ce-8928-2dd21aa5709a@kernel.org>
Date: Thu, 19 Nov 2026 09:38:59 +0100
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
Subject: Re: [PATCH 5.15.y v1 1/1] mptcp: fix UAF of child socket on listener
 close
Content-Language: fr
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, pabeni@redhat.com,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261118125032.200934-1-jiayuan.chen@linux.dev>
 <20261118125032.200934-2-jiayuan.chen@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261118125032.200934-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

On 18/11/2026 13:50, Jiayuan Chen wrote:
> mptcp_close() orphans the listener subflow before inet_csk_listen_stop()
> runs on it. A child created in that window inherits SOCK_DEAD, so a
> following RST frees it while it is still in the accept queue:
> 
> close(listen_fd):                            3-way handshake & rst (plain TCP client)
> 
> mptcp_close
>   // mark ssk as SOCK_DEAD
>   sock_orphan(ssk);
>   __mptcp_destroy_sock
>     // ssk in conn_list is listen sk
>     __mptcp_close_ssk
>                                              // in 3-way handshake
>                                              tcp_v4_syn_recv_sock
>                                                // inherit SOCK_DEAD state from listen ssk
>                                                inet_csk_clone_lock
>                                              // process RST
>                                              tcp_reset
>                                                tcp_done
>                                                // sk is SOCK_DEAD
>                                                inet_csk_destroy_sock
>                                                    sock_put(sk); // freed
>       __tcp_close(ssk, 0)
>         // free child
>         inet_csk_listen_stop()
>             process child        <==== process freed sk
> 
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 59 PID: 404175 at lib/refcount.c:25 refcount_warn_saturate+0x12e/0x150
> RIP: 0010:refcount_warn_saturate+0x12e/0x150
> Call Trace:
>  <TASK>
>  inet_csk_listen_stop+0x3e1/0x530
>  __tcp_close+0x3bc/0x440
>  __mptcp_close_ssk+0xb9/0x210
>  __mptcp_destroy_sock+0x11c/0x280
>  mptcp_close+0x25d/0x3b0
>  inet_release+0x44/0x90
>  __sock_release+0x42/0xb0
>  __fput+0x98/0x270
>  ____fput+0xe/0x20
>  task_work_run+0x6d/0xb0
>  do_exit+0x1e7/0x3c0
>  do_group_exit+0x3b/0xb0
>  get_signal+0x17a/0x940
>  arch_do_signal_or_restart+0xba/0x130
>  exit_to_user_mode_loop+0xae/0x160
>  exit_to_user_mode_prepare+0xad/0xc0
>  irqentry_exit_to_user_mode+0x9/0x20
>  irqentry_exit+0x21/0x40
>  exc_page_fault+0x93/0x190
>  asm_exc_page_fault+0x27/0x30
> 
> Unhash the listener subflow and drain its accept queue before it is
> orphaned. No new child can be queued after the unhash, and the ones
> already queued are not SOCK_DEAD.
> 
> Upstream fixed this in commit 57fc0f1ceaa4 ("mptcp: ensure listener is
> unhashed before updating the sk status"), which does not fit 5.15.

This patch looks good to me for v5.15:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> This may become much easier to hit once services move to a newer Go.

I hope they will switch to a newer kernel first, v5.15 is supposed to be
EOL next month :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

