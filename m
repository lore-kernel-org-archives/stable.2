Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A028391844;
	Tue,  2 Jun 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424819; cv=none; b=TqEC9wE/VgT1ay4A+RTBDPllkb+pgmhEidylUhRD3gyexOnprym+MSuTwglDxdK2RdPe4KRxDdceldIPR0Oqs7vEYxJXtdx821vOnD2XsapHA63DO8cNDIai1TMgvBFWSI2Ust3iv7FNswTpuEhPP9JDzvVTB496ai//Mt09hMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424819; c=relaxed/simple;
	bh=WtU/TY+tLWZo7SXm/3T5z1vU2glFtKk0L8WiGjxPHZE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nENmnIcODv4CmgTyY0/NiqAnGz4dwxAiFOehMIL2Gen5ZYDDl76rX2/HTUbrWNAUCwEMmTrcqfz5x/CqLWsz8MDqPcI9qpnpbG/KWGw9Gw+2Digs5d3WSQXALx7ncB5+VhnobvwLReI7029X4kJQbLD488oQwKXtmIVj9oCZgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ey4EivOt; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ey4EivOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780424808; x=1781029608; i=markus.elfring@web.de;
	bh=DM/upRZnOXhOMpD1AtcG6pm5AmOWS2z74VVufYR/c9w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ey4EivOtrdZwtgD78Tg7wW5mZW10wvU1Nm4kPuHgfuKq0DFL86dW1GqgHbm0jmfl
	 SRWERKS+Fx7jMJ4pwqCDQwFH0iyYvcs0D2pX2JOCFJl2LV3g67Qu426sSTmrkCXuV
	 1pj6jZJJ8a7eBCZ/3Ex0qs7zCLMMm8cJ0oHSApnMcBOx2v5+r5Ytlq/CG2ScYLgCQ
	 NQV068o2kO9mvsiHXjGrrchkGPEdTVSaNPXYy/a7HLXZ8FegylcWw2XDwLzTwejaE
	 l71UXU/KrTMyhLfPugCV0ZjS8YsigHIk0rKoM8jmSRIUqu04wB4WoeosucJvAklsq
	 xsZOvQ00wNounKad7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1x7NPP2AJ1-00mPM6; Tue, 02
 Jun 2026 20:26:48 +0200
Message-ID: <913d1b9f-627a-47f8-856d-6b20bf552247@web.de>
Date: Tue, 2 Jun 2026 20:26:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, ceph-devel@vger.kernel.org,
 Alex Markuze <amarkuze@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260602090754.3678981-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] ceph: fix writeback_count leak in
 write_folio_nounlock()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260602090754.3678981-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UbYex96UvX6/O3CohCU6zfNVrZeVBzI4iFTxA6h3vj1KpHXKQMC
 82FMoV9THqb+M4iGcUTbmZRetZhNc6DDHmRwcCn2QlIC6aSnYhyCBh6ErV+/AVqFhG7q1QV
 GOS3+5onN8efLG7ZYNGBhrIV3jtLFrlVAq15E0btQO3NADJnZ88fEj8GeWIdvsYhlwox/0h
 5vnHWhsNAHfObatIt/sNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mXek/pW3BsM=;bhrp6bzUnpiiKzI6j4D+NbEs48P
 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
 09CRus/Y9SAAghk8W15qKdRhZGo=

=E2=80=A6
> Add atomic_long_dec() calls on all error paths that currently return

      atomic_long_dec_return()?


> without decrementing the counter.

Can any duplicate source code be avoided in affected if branches
of the function implementation =E2=80=9Cwrite_folio_nounlock=E2=80=9D?
https://elixir.bootlin.com/linux/v7.1-rc6/source/fs/ceph/addr.c#L717-L874

Regards,
Markus
