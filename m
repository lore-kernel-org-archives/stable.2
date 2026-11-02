Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584573;
	b=EqqnINiIZ3H5mP02MILtmxRMHSn3/9hdXn79BT6DH3qwZ7RqhTYUGkJ81o8AbOuJgkOO
	 CScIw3xrmZimbSiEDv1oYIeGqY1E5rHQ5pJOV7Tf85skIpLDJgzhGbbqXnk3IxCBFEFJL
	 Fc0AgtgekiegDiiR81oNLJiyc3lcoxXD0pIjh2OMT70kiLb0V6vdkpitThsCMi3t6k8D8
	 K6Zct0l5FxzR/xTUNDbV6afx3Wl3cv6LnIL4eLkRkrwB37l4qrvXGgkyjURykoWzqkl6v
	 kjmfqqAg76WfuhXrohpze5FGDXc7UQ34F0UDBdLVsOZFR9uguQTuA+Z0dU49txl8m/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584573;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hPEzD1WQWoI6DLgJc3nFH78eRCH06B+HG0fOl1fLX4c=;
	b=27aIrWAQp7SVeW3rrUVIEGv4Y/Vfc1l+okmINupgYVO1gl48PJkLddcOc+DeVw6zZqzq
	 11Mw7l5aSgqbClo3LufMj1/ur/G7jVRS+yVid/idoTBDNcj40lPMS5AFv2ElZhFiBlGhZ
	 rfLs3iHmadMnX2D2TpxFo1fdgW1kcBK7jBD3zHU5H6Yfks5z7lFwI673705KA+DI8kTIo
	 q8m+vtM44RMM/Yql/RQ+F3freRLLkBvNtvyFfiy3ASKfNYkl/mhsNK/HME56r71Pu81J6
	 YZPQ065AaOuX/3VxfeGhmFCMpV2M5VBr8RI2wxKVJYBerLSmRS9ECuZdrP0vjB8YuWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="i/q1ROh2";
	arc=none smtp.remote-ip=91.218.175.81
Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AA606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 01:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A3AA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i/q1ROh2
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n3WZoTD06QO8DsgnhDFWT7ENJHabABG8avIZs4EqSgM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793584570; v=1; x=1794189370;
 b=i/q1ROh2Ry/IdMr35s7tZ7vEQ7ZiftKZO5/dovMQQjf3wv2HzqOCWBmiTYSqJAwOeptji1g5
 /sTVb2gvpVd7KqLfc4u7dTxCV9mSUmfaQqQLxft+cjLeRSIeTeu56lou4/lgMWkoy55XxtiuI1p
 MiRRl6DOEWUzcDZ4Ms9gBwa0=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d5ce155f172fdd98;
	Mon, 02 Nov 2026 01:56:09 +0000
X-Mizu-Trace-ID: d5ce155f172fdd98
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 09:55:55 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Thomas Gleixner <tglx@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Flavio Leitner <fbl@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 5/5] net: restrict message_cost and message_burst
 to non-negative values
Message-ID: <auftqzpuuNFiScrb@fedora>
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
 <20261101061331.286404-6-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101061331.286404-6-jiayuan.chen@linux.dev>

Hi Jiayuan,
On Sun, Nov 01, 2026 at 02:12:03PM +0800, Jiayuan Chen wrote:
> net.core.message_cost and net.core.message_burst feed the interval and
> burst of net_ratelimit_state, but neither rejects negative values:
> message_burst uses plain proc_dointvec, and message_cost uses
> proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.
> 
> Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
> negative"), ___ratelimit() splats on such values, so the next
> net_ratelimit() caller warns, e.g. a martian source log:
> 
>   Negative interval (-250) or burst (10): Uninitialized ratelimit_state structure?
>   WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/3218
>   RIP: 0010:___ratelimit+0x578/0x960
>   Call Trace:
>    <IRQ>
>    net_ratelimit+0x1c/0x30
>    ip_handle_martian_source+0x1bb/0x340
>    ip_route_input_slow+0x1057/0x3650
>    ip_route_input_noref+0x104/0x260
>    arp_process+0x109b/0x2510
>    arp_rcv+0x381/0x460
>    __netif_receive_skb_one_core+0x173/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
>    handle_softirqs+0x204/0x9b0
>    __do_softirq+0x10/0x18
>    do_softirq.part.0+0x49/0xd0
>    </IRQ>
> 
> Negative values never meant anything here: 0 already expresses both
> "no limit" (interval) and "suppress everything" (burst).

Will this limit breaks the UAPI on old kernels that supports negative values?

As the comment in ___ratelimit() says:

        /*
         * Zero interval says never limit, otherwise, non-positive burst
         * says always limit.
         */

If all others agree to set the limit in this patch. I think the comment
and the WARN_ONCE() , and the admin-guide/sysctl/net.rst all need to be updated.

Thanks
Hangbin
