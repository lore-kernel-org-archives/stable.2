Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792115;
	b=GZuqys4n809DPCuSWEXSdEWOOFDUiwHj+MkBfZSyyqPfHRiWr4/6Hz+0AHVAJEnbki3a
	 C5lZY3TTo/ujzAouiDmLKDSZtgxbNMqewum64lwpD8IGOR7btZ8ohPl6Z7HlU36zBakaY
	 sKy2LeQkKio6A8nDPKbopjZZpfb74ltJQS+LOxSKUyTG6LKQSfVobbSluk6BLSoI2nFoF
	 13sneiz5m8iGewMTCRKQDgR0i/v7szgkfPQczHyuuz/QWMB0HfPq2ADfJg6GiWSAPFS3q
	 ux6o5TzW1wsd7HqTt+lALf07/s9A2+8C3l2oOKeShWiKGXfEsDWzye4rwzEtPWVQkMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792115;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FSFbGUYPBF+vskjcLA7ce2UQmE5OpYuaOFY7qJRQQZ4=;
	b=KH/uGN6bgK53xvCdsKHXBQwtZnmpefLNw70ltKTH9+8nxCErxvf7jgwmg8XtHhRPmtuO
	 hvB7TfHG3AvsK/vNYqkt/1ywggFZB4pw/FDXnw6g6FFMv1nnmg88gsLgi4/c7TJ0StQkR
	 4SbV3zYXrbseIoig4FisqNV5WOP/5Sd0Oq97s5vbmH8PCrGqBNw0UrEubkLlwZ+dJY7gT
	 WX+vxLcBDDCXb28Nxkzib4Ktsh8JGxhiAMxdkm+5ILFvV+SrGN7bYNq0KGyE7VjTNF7dL
	 5XooEcKYDWEoi4eziLbPAr8e8SZOr/XU8ESbjy8FBjPH77amdTQIgvmV4yslUDHLQCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Zyww3G3a;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=A2um4VxW;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997D606A31A;
	Fri, 23 Oct 2026 21:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C997D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Zyww3G3a;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=A2um4VxW
Date: Fri, 23 Oct 2026 23:48:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792792113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSFbGUYPBF+vskjcLA7ce2UQmE5OpYuaOFY7qJRQQZ4=;
	b=Zyww3G3aigotUUBwh0nqMLfRIrVaxQiKEV7PxP4+KuVfale2pxaRubdLg8SryhBA6u7ZFk
	utXyqLIEdlK8Pv0Iw1ac5UInU7LyNtxfrBwLovPbIdLeuQf6tZz9ai0pp0gTD58tMBp9eu
	UV/9gB2YgaGI09hvGulBHZFOdqccS2QQMdIOGJir8GytT2KmBybJiAuXufvDLs25ZLk4hG
	xH5/rE/KQoW9bEhPHi7DDGK1o0eZBTlnb6I9JOZpM/hRjNiw6fyS3qIMHDdQ2DBKBzyOYA
	IGBwEbDQWswaHdsewFMEQUnZ8Iz42JunUxLtKKohaeSibK98CwApT3o7yMZwyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792792113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSFbGUYPBF+vskjcLA7ce2UQmE5OpYuaOFY7qJRQQZ4=;
	b=A2um4VxWp9vCI9lJ+vkRsYhvvdVqul9hd7psOZW1HxZ3NYqWAIa1luhKMGnvT+R8kp/erY
	NAodkUUyF8merqAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: liuhangbin@gmail.com, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, shuah@kernel.org, kees@kernel.org,
	petr.wozniak@gmail.com, qingfang.deng@linux.dev, fmaurer@redhat.com,
	luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: Re: [PATCH net v7 2/4] net: hsr: preserve submission order without a
 forwarding lock
Message-ID: <20261023214831.sW81vU4b@linutronix.de>
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-3-xiexinet@gmail.com>
 <20261014134718.YGcKmfB9@linutronix.de>
 <003d3e2a-3568-44f6-a9cc-3202de60da58@gmail.com>
 <20261014151838.6RyMIRVM@linutronix.de>
 <2f153755-11f2-4d0b-8d56-101e2dd01923@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f153755-11f2-4d0b-8d56-101e2dd01923@gmail.com>

On 2026-10-23 23:19:16 [+0200], Xin Xie wrote:
> On 14/10/2026 17:18, Sebastian Andrzej Siewior wrote:
> > Okay. In that case, could you please teach HSR to reject bridge ports at
> > the very least?
> >
> > Given that HSR is a ring and PRP faces two networks, I don't think a
> > bridge setup would make sense here. So rejecting this should be any easy
> > fix.
> 
> Yes. The same chain also exists with a bond or team device as the port,
> and with a macvlan or ipvlan whose lower device is an HSR master. So I
> will make the check "a port must not have lower devices", for slave A/B
> and for the interlink. A physical NIC or a veth passes; bridge, bond,
> team, macvlan and ipvlan are refused. The only real setup this excludes
> is a bridge used directly as the interlink; a veth into that bridge
> still works.

Thanks. Sounds good. veth is needed for testing ;)

> > Or (c) tell HSR to reject bridge ports. This should avoid the case and
> > the problem.
> 
> Nobody else has commented in the meantime, so I will go with your
> suggestion. In v8 the lock stays as it is today, and patch 2 becomes
> the port check with the syzbot Reported-by. Narrowing the lock can be a
> separate change later, outside this fix series. Patch 3 then segments
> before taking seqnr_lock and numbers each segment under it.

I will look at it once it gets there.

Sebastian
