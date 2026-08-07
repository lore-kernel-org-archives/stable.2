Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616E4756A5;
	Fri,  7 Aug 2026 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106396; cv=none; b=jkYeJ3RGCY+nimf4QUsKDB9vIBtkrcpi2T827dv1rsVJtWFou6ypVytN7/yb5rE1GV2cr874zFsS/nIVeg04o1VjBdgC9HPfOmQYToi6yDfWIsCM6rCM7SepQ2mIzVhKhc80ndzIaF0n5lN5uIvnhl9qvap7fnZfwI7BTUaes2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106396; c=relaxed/simple;
	bh=gUztX7aVlm0QkztdNBiRFkWvXDdxFPmm50jIYqOP9UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cnzDK8VLA0DPXd6YxODXE8uuy9JAE4nG0v6+qn5cXxYMXc2O4E0Mk8QWH2JF1lJGtzVcEcZ6Fm1yoguyqS5kG3MkGa9W1TwoiHig9dYdxUpR1FFHk4CJIZp3ly+uaVJcGyKnL09Orqkms9hJi4DLIth5eOjuAq2qEJqCY5BBsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AY3FcVR0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AY3FcVR0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A147B1A148B;
	Fri,  7 Aug 2026 12:39:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 606B9603F0;
	Fri,  7 Aug 2026 12:39:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7914111C3779F;
	Fri,  7 Aug 2026 14:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786106366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9cjfll9Ld3UQKLhTcpG7qSNojtvD2IM9y5+iFB7Ik9o=;
	b=AY3FcVR0fopvVNiK4+vWCM3zx6O5OT9G0ygM5ThrXIOxu5/KexxdWs1hkCwFl1plYDbf0u
	MNRJTkPdp801gl8PD2PsTAbKSUNgb/Z32A9N3wzIZq/UtqZyzNRmQKxUO3CLhLYjjyIUrU
	6/jFyRHmlDp1GbndZb0I4ovYxpr7JApmw4qNvv7Nskx0H8c3fnF6p80iobad7SSY2wAZtz
	/xXmOsZ/Vk6SWd5760ghB4lc0gjEIwd75xOPGWkURtGDgiLhi+BnwdQ5WsgTHPWpO8a8Fj
	K1qSOmko1I2bjeue/Ys+WfyOSU83d30G1QQ7+xFNsGN0BJJr8pBho+z+S33bVA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-wpan@vger.kernel.org,  Stefan Schmidt <stefan@datenfreihafen.org>,
  Alexander Aring <alex.aring@gmail.com>,  Varka Bhadram <varkab@cdac.in>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: cc2520: fix FIFOP work use-after-free
In-Reply-To: <20260806050328.422480-1-fanwu01@zju.edu.cn> (Fan Wu's message of
	"Thu, 6 Aug 2026 05:03:28 +0000")
References: <20260806050328.422480-1-fanwu01@zju.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 07 Aug 2026 14:39:18 +0200
Message-ID: <87pkzucdft.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Fan,

On 06/08/2026 at 05:03:28 GMT, Fan Wu <fanwu01@zju.edu.cn> wrote:

> The FIFOP interrupt handler queues cc2520_fifop_irqwork.  On
> removal, cc2520_remove() only flushes the work.  The devm-managed
> FIFOP IRQ remains active until after ->remove() returns and can queue
> the work again after that flush, allowing it to run after the private
> data is released.
>
> Release the FIFOP IRQ and cancel the work before unregistering and
> freeing the hardware.  Keep the SFD IRQ active while
> ieee802154_unregister_hw() flushes the mac802154 workqueue: synchronous
> TX waits in cc2520_tx() for the completion signalled by the SFD handler.
> Release the SFD IRQ afterwards.  Destroy buffer_mutex last, since
> unregistering can invoke the driver's stop callback, which uses it.
>
> Install the SFD IRQ before cc2520_register(), so it is available when
> the netdev becomes visible.  Install the FIFOP IRQ afterwards, so a
> registration failure cannot schedule RX work while its hardware is
> being released.  Move ieee802154_free_hw() to the probe cleanup.
>
> Found by an in-house static analysis tool.
>
> Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio=
")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

While I may agree on the problem, I don't like the solution. It is
overly complex. If the problem is the fact that we might queue works,
what about disable_work[_sync]() ?

Thanks,
Miqu=C3=A8l
