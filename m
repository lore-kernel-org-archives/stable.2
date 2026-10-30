Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353877;
	b=ZY+BNgz+xK2wY8Q4ob/IVFBxvAL/daoeeAO7I1WJI2W+DDkIOG2G0OMR475GVV0lraBp
	 2LUewa+l7xOxLMZHaOJhn1lsw4Zy2AZacP/MTntG18/DMwYU/YhJrHe2CcWu81u+w7U7r
	 L4J0DmPJ+udwp1EWNxG5QAsoY973xx6Jc9AjoQVur+WR1Kngpg6r/QO36+oZUSlpsyXBY
	 rCfHW6/b7lbERMDy5a9gkCBz9tfXbh8UMrpIJ223WoKsYOivbuqhjY/dmVhqCmxkhnnfq
	 WfPViNmYGZ9eD8TDhBRfbKj0mB+mVDNAFe/6Mw2T3MHGWatD3fQm227MXhHX9ySvUog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353877;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=Pc05rPVx8BUnwZN6Esfs/3POdwyr4e457JoVhP2uVHo=;
	b=3KTjF5/DS3m/E0u3FO0xGVbb8MMs4PBgilJ3Gy07i7ffqLbHZlIiqQUlTTrWm4rxDJgK
	 +0d3O0JDBSkb4kVoQfp7rkA57u8Q6+irRPqmab/1UJ8gFwVL9yNNhf4Xf5FTlnVEnJG4L
	 0uSBMn1JMcI+Z6brC5osL467sVrENnD/GHS2FTje4dOmdlcKiKA+IizmZ2KtXQZBzEbC8
	 opQGrCrGRG78cb+Ga7eDn3Mo8JEaLDR3UHZed5NeUQw69j6pBFWfMbB0EeroMxMjMjLZ3
	 6AF4ILR3F7Pqk/JpRzTHwWVJs668XI5RZSVp5JqTgzz1I1kJbvyYWU3Mqd48mwrF2Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="x/ieRjDT";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48D606A31D;
	Fri, 30 Oct 2026 09:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE48D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x/ieRjDT
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EB7DBC49F5F;
	Fri, 30 Oct 2026 09:52:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C25B603C2;
	Fri, 30 Oct 2026 09:51:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5485D103287DA;
	Fri, 30 Oct 2026 10:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793353873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pc05rPVx8BUnwZN6Esfs/3POdwyr4e457JoVhP2uVHo=;
	b=x/ieRjDTB/siPI1w1YtydrICOdZux15f16W7k7Gh1k1ZcH1N0eaSyZvsog5fPMrXRBMEzW
	WhhGVlBVeNorl1LqQfUncEujshyeShl8yzGGtRk2CWDhBrtGhwFwzNjj0Lt9Ftj22P8irG
	gGV9donnbH+JD8hU7c3LrjrbugEgps9BY/Ufq8YyAFHcMA7XLy/ohCJbVZS/JomRgR9pKo
	Ie53dbEqaGsbCx7jMEq/qc4nJKVbKoOWcbNnWbkBnjJtFjfMJlBWjl9rboTGLpMJh6FLI+
	fl7BnBpLdJ63wgLKhrJkLRYO+xKIio0nQpuQDhvxiMQVX9ryuQLFIc2YM4yBtA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@kernel.org,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  zihanx@nebusec.ai,  stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: use pinned interface for beacon
 transmission
In-Reply-To: <179335297474.14852.9229658182764909973@stu.pku.edu.cn> (Yifan
	Zhang's message of "Fri, 30 Oct 2026 17:36:14 +0800")
References: <179335297474.14852.9229658182764909973@stu.pku.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 30 Oct 2026 10:51:07 +0100
Message-ID: <875wyjectw.fsf@bootlin.com>
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
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Yifan,

On 30/10/2026 at 17:36:14 +08, Yifan Zhang <yfzhang23@stu.pku.edu.cn> wrote:

>>From 1e3faf146431b4c28bdf0923fa54754c1f8d8902 Mon Sep 17 00:00:00 2001
> From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> Date: Wed, 28 Oct 2026 17:18:59 +0800
> Subject: [PATCH net] mac802154: use pinned interface for beacon
> transmission

These lines should be in the header, they appear in the body. Something
is wrong with the contribution. You can use a tool such as b4 to help
you with this setup.

> mac802154_beacon_worker() looks up beacon_req under RCU and takes a
> reference on the selected interface's netdev before dropping the RCU read
> lock. It then passes the selected wpan_dev to
> mac802154_transmit_beacon().
>
> mac802154_transmit_beacon() ignores that argument when choosing sdata and
> reads local->beacon_req again. If the beacon request switches to another
> interface between the two reads, the worker pins the old interface while
> the transmit path uses the new one. Removing the new interface can then
> free its netdev before ieee802154_mlme_tx_locked() dereferences it,
> causing a KASAN use-after-free.
>
> Derive sdata from the wpan_dev already selected and pinned by the worker.
> This also removes the redundant RCU lookup.
>
> The reproducer hit the use-after-free on two separate v7.3 KASAN boots
> before this change and completed without a KASAN report in three runs
> afterward.
>
> Fixes: 5f26a690e8ef ("mac802154: fix netdev use-after-free in beacon work=
er")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> ---

With the commit fixed,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
