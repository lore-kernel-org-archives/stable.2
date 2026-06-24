Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA738B7D9
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284817; cv=none; b=mcmWy0b6SKWCzRVGbeGbAiypllfGlOMaizCETyBi/cl6sRCp8Hd4K02VMTuRM0eizkphd7Mjn0Tn9JyDMvxno6Yv4zdtbULHKeigkz27PzWPdpCD54Gz9oWMnk/hM3vekaDhDKcmJp3pDPYlwi0y8Lcnko3qo8FEhF0XxVxisio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284817; c=relaxed/simple;
	bh=+T9ohydDlZPyQO9s9xYi0sfXN9/A6XgmewC5QY8H6WY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tG9VyzwBtF38S5mdsxluRvmyu4n0SDLPqSnsa0/jfoDwCf/nT7ZldO92Sulet04lKLSklY4NcJCkxpHJ4cwqFHwlHBkb8mePI/7BPTySyEZZzXNAnmYgU61z3BcWGKi0Spz+yd2Muj5v+vyb9UZV8r89SOcZcBJ3OrMaBYak5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OHt+zRUc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OHt+zRUc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C01B5C6B3AA;
	Wed, 24 Jun 2026 07:07:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D5593601C5;
	Wed, 24 Jun 2026 07:06:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8A44106C8373;
	Wed, 24 Jun 2026 09:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782284812; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t/MYXJlSVG1Z5SmTJh5V6eIBs7J1peYozBWO6nr4KlM=;
	b=OHt+zRUcUfC6ABxk321Qqqyo25cb9cgfzm/BFZlso8MBjXnHFhyzNROnse0N/5Nh8oRNw0
	/LRWUmdMd7kOaBFhsiWvjWBNsIE451Gk8BdV9ymSmSJTkgabkYYRwi9YhPG20oQTCASTlm
	Hq6nbG47SRaNmeMvlRRIZBnwGHn8qIpKTKzBW6nQxHsnFexK6NI3gWsIX0nxLyQcw5E6+Y
	YpknaPI15Flw5Gi+VYI3wrjktI1tfNp0RsGI62xi7QcJS6xyuo0FJwRQO77G4Q7wrApvcM
	jtIJgTjYBO4UGVEHrtLbVN4j6h/+58gNh/6t9CJXTFPefBVpD99DcjJyUWVS+Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,  Frank Li <Frank.Li@nxp.com>,
  Alexandre Belloni <alexandre.belloni@bootlin.com>,  Kaixuan Li
 <kaixuan.li@ntu.edu.sg>,  linux-i3c@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: bound IBI payload to the requested
 max_payload_len
In-Reply-To: <ajq6EgLq_B5YtPIu@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Tue, 23 Jun 2026 12:53:38 -0400")
References: <178222990006.2767135.12462569914183698733@maoyixie.com>
	<ajq6EgLq_B5YtPIu@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 24 Jun 2026 09:06:49 +0200
Message-ID: <87h5msmn7a.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/sv=
c-i3c-master.c
>> index e2d99a3ac07d..7420bfbdd259 100644
>> --- a/drivers/i3c/master/svc-i3c-master.c
>> +++ b/drivers/i3c/master/svc-i3c-master.c
>> @@ -465,9 +465,11 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c=
_master *master,
>>  	buf =3D slot->data;
>>
>>  	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  =
&&
>> -	       slot->len < SVC_I3C_FIFO_SIZE) {
>> +	       slot->len < dev->ibi->max_payload_len) {
>>  		mdatactrl =3D readl(master->regs + SVC_I3C_MDATACTRL);
>>  		count =3D SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
>> +		count =3D min_t(unsigned int, count,
>> +			      dev->ibi->max_payload_len - slot->len);
>
> now needn't min_t, only min() should be good
> see:
> https://lore.kernel.org/all/20251119224140.8616-1-david.laight.linux@gmai=
l.com/

TIL, thanks for the pointer Frank!

Miqu=C3=A8l
