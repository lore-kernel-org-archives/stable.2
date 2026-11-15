Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794779115;
	b=EHZJjsAt8BMsJpuu+xcbf95/xqJQ5tpsoxfFOSvBfEkx7ZhYI2b0DnP6drY4FwY7TEeM
	 7eXwKPzG5VsBtJi0GpDps5W//GvkrYru2mkRiuzkEFOOXDY7h0st7YqiweWjdJrSXhPOu
	 kKrPV6hYWFhCsJpx6lmbhy1MmshcYLK0URmJpgwAbyh+0ZdmSJNp83ylPDf4DUFbuoKMK
	 7fxRvBxgV0wP0uqsnAOsckoQeDUbg/7lrU3+acDWaMcREYlpWN9GUTT78yCtWjsUvP8oR
	 tSb9WGKyLk3LzVGgE7Or+7p/hoAqnhzkmuP8W96QMrkdz+Xr9LObyjPTj/8n2TU4MIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779115;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=mD9hayVJvAjyxBRT0dnmZkuOvhkP4+8zcep4nlSZMwg=;
	b=2oYJvq1vCjnJm2lUv80nj9qmWRydhFMf0P36gWzNz6fEDI4H2Igp7vSvC/L2Qh7MCJP2
	 Eeob6DwcpR4hs0qeCAFeyMXrry3FlKFPviFuLmomrZ87Yyme9VxqFfw8JtSClMRH51ld/
	 d+2wM9mMt/rpTKYP/FayZ/V4LVMYe99lWoBVClCflwLxg3FS7fGIdrBj5JVa39lm1imwz
	 fBRmAGYYlsNzLOk/8s8GJ1UnWrGmHLxDx2M1TnCUD00un1n5poz48mtyZoMJ/8vXsrizE
	 YyeEFLp5i3N5Z1/NHBrqj3ChCHbbvGwmA/g3jYDZN+1ry1JrdNR9aIYAqqbWD7nWg1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Semlvncf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0MXy4QeK;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE38606A329;
	Sun, 15 Nov 2026 21:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE38606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Semlvncf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0MXy4QeK
Date: Sun, 15 Nov 2026 22:45:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794779112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mD9hayVJvAjyxBRT0dnmZkuOvhkP4+8zcep4nlSZMwg=;
	b=SemlvncfCZsr8wvzwJ9LmjkuUasMvqfPlROuJ9H1rzoRgdOzU6eG+GiKdAdO9bz/+Q2PuD
	XJxo9E5R5KmORZDsICthK9uqUL+XkbzTkcVEbPeURl4mWqnahfBkI97eXyZEPTn+5FiAPj
	ObIAUDx5U1MuSq4p/XTf8JliePdTMWftvG4PgO8JutWhsr7mnEC3hhy1M/OmJ38O5xbZVs
	hxHKs9Ej/tS9VDW8hFFAU7qyhOHCON03vYUE6j5pGIoe10zAWt8mVGoBb+EUPzuHmSIVyq
	ZVrjvi9itmv+RC1/laXB5AZyLkOsc8KC6e/OFX0ekZN/FsojOu2cW3YdStE5wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794779112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mD9hayVJvAjyxBRT0dnmZkuOvhkP4+8zcep4nlSZMwg=;
	b=0MXy4QeKAOE5FDfZNvA6N1LHvj9XBXZVVKTSUIPkyw88KgGhJXYpewH07pNTK9+Bb6Dqdt
	Tqsj5NDEMtdW1+Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com, lukma@denx.de, fmancera@suse.de,
	danishanwar@ti.com
Subject: Re: [PATCH net v9 0/4] net: hsr: fix super-packet forwarding
Message-ID: <20261115214510.MDb9zdCb@linutronix.de>
References: <20261112153333.20-1-xiexinet@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261112153333.20-1-xiexinet@gmail.com>

On 2026-11-12 16:33:29 [+0100], Xin Xie wrote:
> HSR and PRP tag, number and de-duplicate each frame on the wire. GRO
> and GSO can hand them one skb holding several frames, which the lower
> device then drops or which goes out with a single tag or RCT and
> sequence number.
>=20
=E2=80=A6
> Xin Xie (4):
>   net: hsr: keep GRO disabled on HSR/PRP ports
>   net: hsr: refuse forwarding devices as HSR/PRP ports
>   net: hsr: segment GSO before per-frame forwarding
>   selftests: net: hsr: verify GRO policy and ordered forwarding

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The test covers the aggregated frames which are unfolded which is nice.
It looks good from what I can tell.

Sebastian
