Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB63A7F7E;
	Fri,  3 Jul 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076266; cv=none; b=tLsb2ALKjw/elZlL7Wwo86stWZRWxR8cxBE17r7scO+d9qOWBR3lJTvgOFzi9ehAljQ8jFZoVpt3PxwUOTAV4+npUuDwnRXTR2n8AiTLiaBje8qlRqyCVkHxhwJgyr5fBS9FmoZsxMauWv0IE7wp6czl0sjDPcrcpHhpZXjoXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076266; c=relaxed/simple;
	bh=NGPEkS/cDH9hPz3JVAVId0cAUJdvobfMKFJ5lBDhRzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Me78Nt7324AGmOANAwWJpGvhs2LeAEgwgLoBgVIzbhwp8Af57QeNizCZGgCdAuWX1BgHmVwZG9hbDYRJVyAn14wkZeGfe2ZGtMQ7NCZaxAbiddVRVitPSFUshK/RcttYtYb1mGlS8Op/HfQoyacmxMT7TIDDc5efGoanzPkKDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IlFqTRjR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IlFqTRjR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 865134E40C61;
	Fri,  3 Jul 2026 10:57:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57C0D60300;
	Fri,  3 Jul 2026 10:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE4C9104C83DB;
	Fri,  3 Jul 2026 12:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783076260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NGPEkS/cDH9hPz3JVAVId0cAUJdvobfMKFJ5lBDhRzE=;
	b=IlFqTRjR/7iWkCl9wpsKOaXJNHI9STNXgfinc2R5WRMo9PP3Fh+159g6zJWgW0zTRGR4VZ
	KfiECXFY4JC2qOPeu6R1omFuTA9RJehno2UT13CnpnZMVqHfGzfnPknl7hcpjf/hug/6cv
	pr2zOZokE26EIXDA6DcXPoUEhGTJT1s/y6opZYDotqLN1BeE+4+w9kh55m2Dyp14grwpKE
	EIE1PoJLKjjuOHrHgTBgbta9i9w8CYDd6/lo2MEPvIj5ZbYQEcps9ZBQMCPl9Jc19/ZACM
	oyB2eUQpjQhyU3oyMW/UBLsgQq73BelJYCybp83Aw214nbsuE6ChHDdNyOXrEA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  marcel@holtmann.org,  kuniyu@google.com,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,
  syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] mac802154: remove interfaces with RCU list deletion
In-Reply-To: <20260701164222.9094-1-alhouseenyousef@gmail.com> (Yousef
	Alhouseen's message of "Wed, 1 Jul 2026 18:42:22 +0200")
References: <20260630211808.50440-1-alhouseenyousef@gmail.com>
	<20260701164222.9094-1-alhouseenyousef@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 03 Jul 2026 12:57:34 +0200
Message-ID: <87fr20nxwh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

> Queue wake, stop, and disable paths walk local->interfaces under RCU.
> The bulk hardware teardown path removes entries with list_del(), so an
> asynchronous transmit completion can follow a poisoned list node in
> ieee802154_wake_queue().
>
> Use list_del_rcu() as in the single-interface removal path. The following
> unregister_netdevice() waits for in-flight RCU readers before freeing the
> netdevice, so no separate grace-period wait is needed.
>
> Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface=
")
> Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D36256deb69a588e9290e
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

FWIU, looks correct.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
