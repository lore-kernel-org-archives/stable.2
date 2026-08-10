Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDD3AE6E5;
	Mon, 10 Aug 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365416; cv=none; b=EeZqvzE5koEOu+CLBqXtMKD7fqXy1Po/BqUNi1cKGLfJQCvk7T6oWHFZeE/iIgY+JVQLOuKiyg8b+lVJTmStk98xr3DqSm5om/YkddSIOvpTJf+FKykUnJzfQggGxzok4mymYDlC+L7Vf8fBLSkYuDIIvwG9npJMW82+cTApjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365416; c=relaxed/simple;
	bh=j4F3tgNrpv0XFiriZBcZk2urtDkPZeiy2AJEH+WvzM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=evnkD+SAmr6BQYFVxNRDdTMhBhyf1hl/XJ51kY6vc974zBPhvux1UTKhmtQfm/fVx458kjoiKbB8odJH5FW1bDOmvsoY46AFra31pT22SQqFx69qUxwZw12ANiOfEfUclAkcPXcV9ZYm4KnCfY1yYEVvGDaeHwVIlX50aq7hOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u55cUtK+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u55cUtK+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BD2CF1A152A;
	Mon, 10 Aug 2026 12:36:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8072D6033B;
	Mon, 10 Aug 2026 12:36:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C041311C4A500;
	Mon, 10 Aug 2026 14:36:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786365401; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f7VR1hd95VoqCyFMdN0c7NIB9QevljWPF/Tlu8MmGBY=;
	b=u55cUtK+OUd9hipscxjuaRgMXOqYdx258FCgQ8IbMheYj77mC0GegPbs1MyijjdMcdCb7U
	e/utZFaQHj72F364cjtCbbyNPUo2chh1fwu5FGC6siUKW03oI2uifaiBirXRJS9M4IvrZW
	VhM7VPeFxgtmRO4VQOdyGmQbLxekGu4xYSiUbVDrRwfLt7hvkdoDqzIZ5C1FzD0Up2hdwh
	0Zue4LKRvqwWsLPSjXEeVUno5spIpKNakLPiEBTHlxVCrlmwjVKFMw2u7GtFif0GeKuKDo
	riZtmJSKW2QJhG84Q5Z21q4VM/0p1yQEUjmeixj2esoCCJm2n9Hw7NuUNvCU8A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-wpan@vger.kernel.org,  Stefan Schmidt <stefan@datenfreihafen.org>,
  Alexander Aring <alex.aring@gmail.com>,  Varka Bhadram <varkab@cdac.in>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2] ieee802154: cc2520: fix FIFOP work use-after-free
In-Reply-To: <20260809021917.102947-1-fanwu01@zju.edu.cn> (Fan Wu's message of
	"Sun, 9 Aug 2026 02:19:17 +0000")
References: <20260809021917.102947-1-fanwu01@zju.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 10 Aug 2026 14:36:31 +0200
Message-ID: <871pc6rw34.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 09/08/2026 at 02:19:17 GMT, Fan Wu <fanwu01@zju.edu.cn> wrote:

> The FIFOP interrupt handler queues cc2520_fifop_irqwork.  On removal,
> cc2520_remove() only flushes the work.  The devm-managed FIFOP IRQ
> remains active until after ->remove() returns and can queue the work
> again after that flush, allowing it to run after the private data is
> released.
>
> Disable the work with disable_work_sync() instead of flushing it, so
> the handler can no longer queue it once removal begins.  Destroy
> buffer_mutex last, since unregistering can invoke the driver's stop
> callback, which uses it.
>
> Install the SFD IRQ before cc2520_register(), so it is available when
> the netdev becomes visible.  Install the FIFOP IRQ afterwards, so a
> registration failure cannot schedule RX work while its hardware is
> being released; cc2520_register() no longer frees the hardware on its
> own failure, leaving that to the probe cleanup.

This is a cleanup mixed with a fix. These must be two different patches,
because I don't think you need the cleanup for the fix to make sense.

Thanks,
Miqu=C3=A8l
