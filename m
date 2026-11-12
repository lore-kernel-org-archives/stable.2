Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464114;
	b=ljtHFL4qsr5gdgm58LVrHDeTSBYwnMRMGsAoi/B0Wfmt1uv11eIngIMv4ZZwYXoUHKYV
	 KO/x0+h/U7fxXN5pRZBczQRNBEN5olaQ070ijTj81n9oh3+XlbyrdjyauDEwUV1VR9Uzq
	 CNKAhgnHa09KiUkldjudqVpTNKjwrvwuFFBGy79eWd8XPXHDf35EDnEW2Wk3aFfI3OvHk
	 H8fdEYi5UnYBpigGO48JAuxWxG+CYb5fBnLuhxYyZ9iyPKz0QgGUPfee1uERS8pS4pYeR
	 igbnET2J12swVTA0S2My81ZzSkWROJPNmLRkXqH8AzUxfLUc+c+262vx2c9wdB5QdHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
	b=Fzq2saUF9xeJuROx/ZkwNgfvOfU8fOoN+qatqEldzMOivMDHGxEkAZgm9Iox5ENcGoQW
	 7Z9SXnlyS3pJfShpXPdTHlZP+9U7Uvi/+I7z2bCNadl0lc+ep9Z4q1oVJsKq75FtCJhzE
	 JpiEcucunl9owbNa+z57Px+9k4zIPd+k7vbVP2v2hqApVKqEk4TnYm7Ch8Xstj1hKY4fN
	 isfSJksGCapwuDZ09Lk3iL9jd6OCc8Ig/6zp5MpEy9mIBUBGBfcH5OY+ofpGPx35h0Hfb
	 byV5iwhZw36V9qjJyZPH3Sd4LfuPWGVEY8WSncF6e9SAHwT5d6lNcvxXTVaR0f3sG0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DfBtHZiA;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D4606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F0D4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DfBtHZiA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a13ae043so4653300a91.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794464113; x=1795068913; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
        b=DfBtHZiADm8aC1tIo3EBpHmPHMVbr7D6BjdBoK2VJBrjXXlJu/3NFxui5H1d6DCWUw
         De2QHLNcIqLLTOnXxnkpXkprRoegjS8s+jb8K8ih1VwQnl/3AYLhR7Un2oKQnWvUvPF5
         f2ChaFGA/RIIarWf+k44PrAyM6EesC0A3rFNoy/JValIylnNdCBggZUA01b4ejL7h3To
         aNw3p+RaefqN9eHJ7UJKD/wpR6IuBR/NyQS00D/90dLg3W3jhIc+Vf8vezS46xHvrHlX
         fEEV1Ew9K3rkG9ZooGMxEAFRGww8gOHmr35RKNw6qSuJDjwHprjV5iPx8x/zP5EKTXmR
         L9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464113; x=1795068913;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
        b=ftFhkU73uSToaF76n3A2QCQpSqcFb+uVRKYzZy/5xwJ+DdGVF+b8y66W0ybRO6/lRA
         eA8N27PWg610+uwIa/o5qqIvW8YNs/v//uRyCed7M0tTaUql45Od1ZeKH8F4tZtyTsXv
         hboxP+DFnz/DX6d0a1/2RPH6rTw4wsBI2h/PGYvaBqAwTnQZNic5JKm+Jm9CrNOcdFtC
         KTUwwWL8CkbtXrKSzuQd2aWApfpoNTnw4D9p68yCUaVNE/CyUGgzi4TIEl85xS4dHhIC
         Jqpgx7rB+EEw/A5RZj24nb9GE1UAevORQeAajaeGOMqp0HnnBE0lHju4FfReqgCCQODb
         6PLg==
X-Forwarded-Encrypted: i=1; AL+hErGbL7wAq1RocPHCUTDHaTPeHAWYAxloCrS0zzSXMiL2p0virYOzm9t6TR76QXKBide2bL0vDt8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vu+PgAvPgVlodE/M4mUcVB7nP5s8QCNXGym9h0mGNS+KNWsld
	wdUO8608qhKF9EWK6/z1j5YUCa4yrbMyOnrOObWsc6T0asUlRVFvwCQawqh+TtYed0GHV7sgq6S
	yl7e0Yg==
X-Received: from pjbee14.prod.google.com ([2002:a17:90a:fc4e:b0:3ae:c243:313b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2245:b0:3b0:ab34:afc8
 with SMTP id 98e67ed59e1d1-3b182e94123mr4304859a91.20.1794464112721; Wed, 11
 Nov 2026 22:15:12 -0800 (PST)
Date: Thu, 12 Nov 2026 06:15:12 +0000
In-Reply-To: <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1794325665.git.x-professor@outlook.com> <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
Message-ID: <avVX-3s3AYwtxQe7@google.com>
Subject: Re: [PATCH net 1/2] tcp: avoid wrapping Fast Open blackhole timeout
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@kernel.org" <edumazet@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "matttbe@kernel.org" <matttbe@kernel.org>, 
	"martineau@kernel.org" <martineau@kernel.org>, "geliang@kernel.org" <geliang@kernel.org>, 
	"ycheng@google.com" <ycheng@google.com>, "weiwan@google.com" <weiwan@google.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, 10 Nov 2026 15:47:58 +0000, Yingjie Wang wrote:
> tcp_fastopen_active_should_disable() calculates the active-disable
> interval as multiplier * tfo_bh_timeout * HZ. Since all operands are
> 32-bit, a large tcp_fastopen_blackhole_timeout_sec can wrap the delay
> even on 64-bit kernels and re-enable active Fast Open too soon.
> 
> For example, with HZ=1000, a timeout of 6912213 seconds and the maximum

No one wants to configure 80 days blackhole timeout.

Please apply a sane limit in proc_tfo_blackhole_detect_timeout().

---
pw-bot: cr


> multiplier of 64 should produce 442381632000 jiffies, but the current
> calculation truncates it to 512 jiffies.
> 
> This issue was found using a static analysis tool. A loopback reproducer
> induced 12 Fast Open blackholes and waited 1.2 seconds before opening
> another connection. The unpatched kernel retried active Fast Open, while
> the patched kernel kept Fast Open disabled and used a regular TCP
> handshake. The reproducer required neither kernel modifications nor
> fault injection.
> 
> Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding
> it to the saved timestamp. This preserves the existing exponential
> backoff for representable intervals and prevents large values from
> wrapping into short timeouts.
> 
> Fixes: cf1ef3f0719b ("net/tcp_fastopen: Disable active side TFO in certain scenarios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  net/ipv4/tcp_fastopen.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 7f7eb3cc1c04..aeefd605414f 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -613,6 +613,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  	unsigned long timeout;
>  	int tfo_da_times;
>  	int multiplier;
> +	u64 delay;
>  
>  	if (!tfo_bh_timeout)
>  		return false;
> @@ -626,10 +627,11 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  
>  	/* Limit timeout to max: 2^6 * initial timeout */
>  	multiplier = 1 << min(tfo_da_times - 1, 6);
> +	delay = (u64)multiplier * tfo_bh_timeout * HZ;
>  
>  	/* Paired with the WRITE_ONCE() in tcp_fastopen_active_disable(). */
>  	timeout = READ_ONCE(sock_net(sk)->ipv4.tfo_active_disable_stamp) +
> -		  multiplier * tfo_bh_timeout * HZ;
> +		  min(delay, MAX_JIFFY_OFFSET);
>  	if (time_before(jiffies, timeout))
>  		return true;
>  
> -- 
> 2.43.0
> 
