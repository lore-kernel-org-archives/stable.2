Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5133F58C;
	Fri, 31 Jul 2026 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466009; cv=none; b=PmzyMynfWdgGawBFfpyNi6yd71HQ2pYtupQRfy5EZIS0+iTBdhI71E7QKLEzDjzFA7NNRYE0jpe4oamCh+U3ypNQTuveSwH5V6F/pxHtaJvHCbYJ+5944tsC5gt2W5oQDsBx/IhFl4KG02LG6EE/C/gSRurW1vjZ/ITXBy+3n/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466009; c=relaxed/simple;
	bh=VFqmMrYtNZ5X096CK4TVpLCm30bCCsyb+0NX8nqgMAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YCHR+UHqT0TvJ08Gm0c+CTUnEfkTTKX86hhIqiDKmladKHpQG7RV5Ov1Ita48hWW6dsea8bFvXYm24XQhdjgkXP2IDWwIbBDSVy1z0fy8bwQqju6lip5g7laSYijQvDTVtPQeqhbIG/KWLUeLoKLxlKHO4U3nUwEraMyy1+u+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.164.227])
	by mtasvr (Coremail) with SMTP id _____wBXX3yRDGxqdSVSAA--.541S3;
	Fri, 31 Jul 2026 10:46:42 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.164.227])
	by mail-app1 (Coremail) with SMTP id yy_KCgC3BZ6RDGxqrkRZAw--.51708S2;
	Fri, 31 Jul 2026 10:46:41 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] tty: serial: max3100: drain async producers in remove()
 to fix timer UAF
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <2026073036-coping-starter-ad07@gregkh>
Date: Fri, 31 Jul 2026 10:46:31 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 jirislaby@kernel.org,
 broonie@kernel.org,
 zhao.xichao@vivo.com,
 linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3BAD313-F584-40E0-B0B8-968A9E2D8719@zju.edu.cn>
References: <20260721035631.3186613-1-fanwu01@zju.edu.cn>
 <2026073036-coping-starter-ad07@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:yy_KCgC3BZ6RDGxqrkRZAw--.51708S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?WJdrtwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBH7r6nLMU0tTQMWvC+8AaMQ4hfoAY9qyalzGqWITSoIqhZl
	ekwcg/FcW8r/MU7KeMGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW3Zw4kCF18AFWDWw4DAwc_yoW8GryrpF
	Z5Ka1ayF1YqF4xX34rJF4DXF1xKrsaq39FyFnxGa42vFs5urWv9F1xKFyagFyfZFn3tr4U
	ZFsYg3s5Zrn0yrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9mb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
	YxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=

Hi Greg,

Thanks for the review. You're right. I'll respin with a concise =
changelog,
remove the boolean helper, and rename the state to irq_registered.

I'll send v2 shortly.

Thanks,
Fan

> On Jul 30, 2026, at 22:39, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> Yes, but that's not needed here, right?
>=20
> LLMs love to write text, please don't let it and write your own
> changelog that actually makes sense :)
>=20
>>=20
>> +/*
>> + * Stop async producers before tearing down the workqueue.  A normal
>> + * shutdown must leave the timer re-armable for the next open, while =
final
>> + * removal uses timer_shutdown_sync() to prevent max3100_timeout() =
from
>> + * re-arming a timer embedded in an object about to be freed.
>> + */
>> +static void max3100_drain_async(struct max3100_port *s, bool final)
>=20
> Having a bool here makes no sense at all, and it's a horrible api as =
now
> you have to look up the documentation each time you run across it.
>=20
> Also, you didn't even document it (well, the LLM didn't...)
>=20
> Please be more careful.
>=20
>> +{
>> + s->force_end_work =3D 1;
>> + if (final)
>> + timer_shutdown_sync(&s->timer);
>> + else
>> + timer_delete_sync(&s->timer);
>> + if (s->irq_requested) {
>> + free_irq(s->port.irq, s);
>> + s->irq_requested =3D false;
>=20
> It's not "requested" it's "is an interrupt registered or not", right?
>=20
> thanks,
>=20
> greg k-h

