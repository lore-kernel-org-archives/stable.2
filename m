Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941B34DCC8
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491645; cv=none; b=Ne/i6ZVTB2xJPW8NOytuXe9eWnQolex/rFMnf5zOGd5RodtDk8YP2Kii8ZM3Vm+NHmQH5p7C0KAYutm29PIysl43BvjIsoFYM4wnJKN6R9FDmpVC9GVXpcnmMePw5dtcliCVm9DS8IqJpqzBEJSfVXCRB7pVbIniP2Hm5yWZbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491645; c=relaxed/simple;
	bh=AN2GzrMWkyFaJbYvNPReXuJ+xD3LE+ovrbMBLCvTCio=;
	h=Content-Type:To:References:Cc:Subject:From:Mime-Version:
	 In-Reply-To:Date:Message-Id; b=VK3m9boz4VRFF3ZsZnIdjmHHtABO49IG0cLIpZ7KFCqXrC74gpfgNyxz2OBu21ot3gfmEXtD+riHN4Qz8/AiWzzGUP69zbcJL6DjCt5LxgOaNfrEHW2TAhYRdNobOacTchtCPAqT/xC5sPv7V/gd7N9I2GLOFoT2npJFjRZ+oWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Xh0KLllu; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Xh0KLllu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783491637;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=AN2GzrMWkyFaJbYvNPReXuJ+xD3LE+ovrbMBLCvTCio=;
 b=Xh0KLlluYI56IvxQgmg14Ig5KjCro7Rdqk1mRMbkh4oPkXunjrNe1J8TJ8V3L/eoEgEeBQ
 pVEzmB8SsS9qd1ZbqBIIn0yNaLS6r1rTVoh+xXCYFp6Rf/wyySTwUAnputTYpptr7LZffD
 hJKyF0dCJJqGoysHtGcTDxIsSp3BVjezX4p2PHV/XIcaF2+ay2ayU1/TCdosax1g9uE/he
 1i3fkOJO6UE42/kKfOt5KF6J21b6S4JvApwHr29HRzm62wSD+cUW7RPs3LJ+61J+iTM3RM
 eYOC+VXF0Clp0nr9mzK4bkmJ/idBrmE6VnEumq65hQCpM3DW7JXGT+cM5ykKEg==
X-Lms-Return-Path: <lba+16a4dec33+85c115+vger.kernel.org+wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
To: "Jiri Slaby" <jirislaby@kernel.org>
References: <20260527092052.2086342-1-wangzhaolong@fnnas.com> <20260708031115.3757150-1-wangzhaolong@fnnas.com>
	<25599a7f-e9cb-4aa0-a375-d9b4ed52be5e@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	<andriy.shevchenko@linux.intel.com>, <albanhuang@tencent.com>, 
	<tombinfan@tencent.com>, <jackzxcui1989@163.com>, <kees@kernel.org>, 
	<osama.abdelkader@gmail.com>, <realwujing@gmail.com>
Subject: Re: [PATCH v2] serial: 8250: fix shared IRQ startup race causing IRQ warning
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <25599a7f-e9cb-4aa0-a375-d9b4ed52be5e@kernel.org>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:20:34 +0800
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.5fc19520.ca7d.459c.8589.c67efbed854f@feishu.cn>


> From: "Jiri Slaby"<jirislaby@kernel.org>
> Date:=C2=A0 Wed, Jul 8, 2026, 2:03 PM
> Subject:=C2=A0 Re: [PATCH v2] serial: 8250: fix shared IRQ startup race c=
ausing IRQ warning
> To: "Wang Zhaolong"<wangzhaolong@fnnas.com>, <gregkh@linuxfoundation.org>
> Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <stab=
le@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>, <albanhuang@tence=
nt.com>, <tombinfan@tencent.com>, <jackzxcui1989@163.com>, <kees@kernel.org=
>, <osama.abdelkader@gmail.com>, <realwujing@gmail.com>
> Ah, you are fixing the same thing as:
> https://lore.kernel.org/all/20260707-bug-221579-8250-shared-irq-race-v6-1=
-f8c499a90bdd@gmail.com/
>=C2=A0
> I did not look up who of you was first.
>=C2=A0
> Note the above contains you in the commit log:
> Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221579
>=C2=A0
> You both CCed each other, so you know the other's submission. I don't=C2=
=A0
> understand why you both send the patch? Anyway, you guys speak to each=C2=
=A0
> other and decide who sends the (fixed) patch.
>=C2=A0
> On 08. 07. 26, 5:11, Wang Zhaolong wrote:
> ...
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -154,10 +152,18 @@ static struct irq_info *serial_get_or_create_irq_=
info(const struct uart_8250_por
> > =C2=A0 static int serial_link_irq_chain(struct uart_8250_port *up)
> > =C2=A0 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct irq_info *i;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;
> > =C2=A0=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Keep the hash lock held until the first=
 request_irq() completes.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The first port publishes i->head before=
 request_irq() starts the IRQ;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * a second port sharing the IRQ must not =
join the chain and run the
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * THRE test while the IRQ core is still b=
ringing the line up.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0guard(mutex)(&hash_mutex);
>=C2=A0
> The same as in the other patch:
> hash_mutex is no longer an appropriate name for this lock.
>=C2=A0
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D serial_get_or_create_irq_info(=
up);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(i))
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return P=
TR_ERR(i);
> > =C2=A0=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scoped_guard(spinlock_irq, &i->lock)=
 {
>=C2=A0
> thanks,
> --=C2=A0
> js
> suse labs
>=C2=A0

Hi Jiri,

Thanks for looking.

Just to clarify the timeline: I reported this issue and posted the original
minimal fix on May 27:

=C2=A0 https://lore.kernel.org/r/20260527092052.2086342-1-wangzhaolong@fnna=
s.com

I also pinged it on Jun 24:

=C2=A0 https://lore.kernel.org/r/ajtFoTHUQHJGYV5Q@MiniServer/

The other series was posted after my original submission and eventually
converged on the same core locking change.=C2=A0 I had also commented on th=
at
series around v2/v3, pointing out the same startup race and the need to cov=
er
the first request_irq() completion, so I was aware of that thread.

I sent v2 to refresh my earlier minimal fix with a clearer subject and comm=
it
message, since the original patch had not received review.=C2=A0 My intent =
was not
to create two competing fixes for the same issue.

I agree with your comment that hash_mutex is no longer a great name once it
also serializes the first request_irq() completion.=C2=A0 I can send a v3 w=
hich
renames it and keeps the patch focused on the required locking change.

Thanks,
Wang Zhaolong
