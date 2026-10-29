Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272849;
	b=grKycfPA7nPkrnb+OBT2xv3gEJO7OUaZykTnvRMaru53PkQJs4DeAQMBejy4lNmRWYcp
	 CBn0yC1nkT63dSx5l7FF9Efvzy6VgkpCghNEEpEwtXjmffs0pIuvmZwiathcB+Ho85mvX
	 0qJYRzn3SOYvUqV7Y2oM3YeaLQvJpk1E8jnXfvpXITboJeV+RksDMcVDUArFFVh/P2VED
	 pMrL6Z6JNr/x/gNJfCgXLxAdcpjEt1avavYE3E55fljRk8Q70k4dURYuDwoRlhNC3yznb
	 JhNoC/3LELnMKCdQL5Hpmj97/hKZC/f3+gNLD4gpV8NbROsS5kbaIN/6UZqlWAPIAFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j8Zt37GO6hvBK/VWxNoOISHBNExAaLWjWwQPv4izgSk=;
	b=yKAyGr+gN9xVjz/2cqj2iBGrJ0a89DwlpIRgaQOzemxS5s8aYpfab3C+yzB1kKShAow+
	 EN3T4cxNzMdN7BwG4lLIT7knfzy5HOI7SawedzYEQ0mPs8S46doFF6JHhxrZ/sGMt2Prx
	 f4/lYSbpVP7szJ+GVFMVPUpL0mW6PVTGH2z9+xpSD8Kt8bL129mv4pR8PEhqfZEDft8IB
	 PrwlkLVVV+BPlVBUZQ6irvP4xS8r9et3sQXfLZFQrh/ICemhGH1H89jUpS4PZafI0cIOh
	 UH35KeAAKzZs5Se8ihxWOI6aWjqScLifGSw1TvTzzxiyKaNBO0yHxlt+6Wq6DJx+7Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qk8g6IaN;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26094606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26094606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qk8g6IaN
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1650959f8f.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272847; x=1793877647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j8Zt37GO6hvBK/VWxNoOISHBNExAaLWjWwQPv4izgSk=;
        b=Qk8g6IaNzLRC96s45UVqwO7Akh0xDEgB2oB6ShZ3S3dAYnMFYwSN6XIQ868uHVjD3w
         xlEevPfhiO1ASAnLxtEQGJJgjbpXJ5AxBnKiBeurM8yl/wFHElO2uSuaAtHqzLvf+h+D
         zd15rVtpEmpuYzm0wON0ynBdThtALn54vYy15737THserh8ttgQtYd/xsNDfCfYNqV2S
         fgzwTmB3aphkX0C6kAHV/D+5UC8LVvM2pPQtp3K+7IlBziBJS4eEeLcBBW11fzWbOlI3
         sWewwss36PTuCr7WyM0SVmIhkVQJ6EVNkkaKWrzk1Kdy8xbACOcCZ1VHGMxPR0D6LB4L
         AyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272847; x=1793877647;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8Zt37GO6hvBK/VWxNoOISHBNExAaLWjWwQPv4izgSk=;
        b=iLCPpZ9IHZOknwSJ/Er98vld5UuGnkUI8ikvMiV5XPJVK/wfhvlTgC8ng0tegvWdV2
         hA95WVl6VnF7BzSLcy94hTcUekK6+Al9mQ2Y+eE1fvmWguK9FlBovTu+Qw7u100hdFOR
         E4s1Osx8qjCwUC9DQxZg4vK5CGrYgqoCAjBQ8BcLiIEaqcRKrS3suJhubAe7vly7PHCY
         IBlHUwP9f7sAHPmHO6Ut+JZfKjkTUQWZyWFPOb778kNbwuGY7jvRXGu2hGkormBvtpqx
         i57h0wSCZrdxH3V12wvQfflFNUP2bTmQLTL1AbZG2LE/0xxskTZCaKJEi7paZmTT0QyL
         B5YA==
X-Forwarded-Encrypted: i=1; AKwUvByk7a07wCKKp+/2mMNoLj0RmLNKX2jrNzQ+ii/qsr18UA93J74rGcTAg0OTFz1Cbhn4KHnmLps=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkpQfg6ll6gHdwSiHb/N4+rFF059z5D2lIidJoeRqYaWw5csW7
	T+5lIoTCZWU8TnXwfW31QrrdIGzSd0AFdBHhhsm9cDwa+xg/n3pqd2up
X-Gm-Gg: AYBFou0B1GD4FFehxreXNEXx28LF6pcJhJSwnly5BWcwvfNa/uQJc3BPW4kc5a/XRbW
	zfRR+yPTojE4roHl1EMoy8DlHxoyzj11fpMYkQmNDZoJ6Lq5FIhHM25CwSqYUj2dS2GWkseh8Ha
	aVo1gKBjyXCy6qmUJjy13Dd72/wTmdrd8moicIsWJ4QdVh4n1pLNTCXIlJfKMjGf/24N/yK2xpu
	rcJk1BB976VCKO+kcyAImCzkfKf0euvyAi0QvRa1P3E85tEoixCA1WlPwCYTH46gPlLm24Ow9rT
	jdcjRluagFbxrGOEk5IDvroIU6g0kdaY6UKGnFmvD1BuDAgpAuRnbZFuagACU54/epN+3Z60fU7
	Lkt4w4n9wSFrawMQMD3OweQLihJR4hAn3EKF0v4WyQJhBdWZv4enLDPRfGw1b3FfEDTsGmSUgp6
	4b+6V+egp2y/lwm74mqeflVyXEitiOJW+JuLtKrmkPuf16vEhxMK2paiyXSA3Qla6jSLFXvPB9e
	pWhYt6WgnV2Yws0TE0xY70GiJeQ+/BJbALSRF2V9sxhrwyXLZZutSaTQCRWxq6W6phIcdcorcuj
	ynv9qUUDmMwzwxlnVvqp7zHQmNbqkbudlTQ4eNe6sr/msewq2sjwbCXEBv8/8rNihlY=
X-Received: by 2002:a05:600c:8184:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4a967016ae6mr109930585e9.18.1793272847111;
        Thu, 29 Oct 2026 04:20:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6419e05dsm5345525f8f.19.2026.10.29.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:20:46 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:20:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Esko Mobius <echoowall@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan
 <shuah@kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Eric Dumazet
 <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
Message-ID: <20261029112045.5e7d4317@pumpkin>
In-Reply-To: <22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
	<20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
	<20261029101859.6893f1a0@pumpkin>
	<22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 18:21:22 +0800
Esko Mobius <echoowall@gmail.com> wrote:

> On Thu, 29 Oct 2026, David Laight wrote:
> > If it isn't a silly question, how to connections in the other direction
> > work?
> >
> > I'd have thought they'd need that ICMP message to get through.  
> 
> Not silly at all. The frag-needed always goes back to whoever sent the
> oversized packet, and only the client side filters inbound ICMP.
> 
> Server -> client (downloads): the server's full-size segment hits the
> 1456 hop, the router there sends frag-needed back to the server, which
> accepts it, learns the PMTU and resends smaller segments. The server's
> send side was never changed by 2640e6419594 (tcp_current_mss() still
> uses the learned PMTU), so downloads always worked.
> 
> Client -> server (uploads): the client's full-size segment hits the same
> hop, the frag-needed goes back towards the client (via the relay's
> conntrack), and the client-side firewall drops it. The client never
> learns to send smaller segments, so the upload stalls. Here the only
> thing that kept segments small was the smaller MSS the server
> advertised in its SYN-ACK, which is what the reverted commit removed.

But that relies on something having gone the other way first.
In general that won't be true.

It is almost worth implement something that retries with the shorter mtu
to detect the PPPoE mtu blackhole at the sending end.
Or even just use the shorter mtu for long RTT connections.
It won't make much difference to throughput (maybe about 0.3%).

David

> 
> Thanks,
> Yongjian
> 

