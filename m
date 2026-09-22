Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506933DB62B;
	Tue, 22 Sep 2026 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068553; cv=none; b=B0/C38c6Ei4RsZTkmSxEH7ckGRFZOEPYesNJuasvyU1hW7vf5CoTeupm49dy9N5mtUxSX7YH/p378zZOEO9TZh0RQR7FpkcloyQBBFjfpJziPXQeYwLVjOVwQrLa1Jqtl+23mXuM8r2SFCM744ZmHviHUwDiYd0V6dHCft6DITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068553; c=relaxed/simple;
	bh=AJCFjg60lw4n1Yvuc1s3T2B0Z4bcSQF+vsyrpGdItKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8yYI6slco6emha4yEvudmdQIQYbUKqOh4kyYJSwmFnoDl810YAsRAGjYqhSTZ1EVH+ZTu89mXI6/Wfpm4k9NF3lHHEyiAnq6SLPu0SYgvmQHMN/iJOI9jhtMDaB2MvRviMMvagRVj9S4ZelyviwANp0uteu4+DIijFe0uaTXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eTahjscp; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eTahjscp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790068530; x=1790673330; i=markus.elfring@web.de;
	bh=pfw6dyACFzdZKGitUbun/qXTmJLQ1ieg2kNuly6syGU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eTahjscpJEhOnSg62f+pUPVn5sSESOREj6i7QtJOuZ1su9qvEO6s3b7JpjvNh987
	 Yfg/TqV4y3lUGYAUTkwqc97jWVi/mTQNoS4pCRZXMEKAPAhhUg6MXuROmEvad8/lV
	 Jw6N3m50r45xJjk46wBZpqv86bzV65nTizs/+yansjR/8WJqzDYC1ALEuOhN51VQ8
	 dlGmZOAAASwUrHctBJyo/Q0JUGP2i/9IIONFjg+lvNIJqGKgiUetX1H67J9QHS3OM
	 t3IYCLOVuIwoSbxt5v9GVb8GR0b/8qHtG9YBf83xZ7j2t8rSF0yeaWgUoWVIk/tVV
	 6+8UcGP584SY08Z8aQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mdf89-1wa9sR1Dov-00lUuA; Tue, 22
 Sep 2026 11:15:30 +0200
Message-ID: <aa283243-da00-4461-b6a7-39c1454d6bf5@web.de>
Date: Tue, 22 Sep 2026 11:15:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dca: fix provider device memory leak on domain allocation
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>, kernel-janitors@vger.kernel.org
Cc: Dan Williams <djbw@kernel.org>, Kees Cook <kees@kernel.org>,
 Maciej Sosnowski <maciej.sosnowski@intel.com>, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260919175925.3739806-1-lgs201920130244@gmail.com>
 <4d1536a9-6836-430b-a84d-aaa19f6af9c6@web.de>
 <CANUHTR-um24oLb-446LRtHLFBGtJ7h=QwEksSjvig-SFonJpRQ@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANUHTR-um24oLb-446LRtHLFBGtJ7h=QwEksSjvig-SFonJpRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fjy3HIGfHtankcCaHnS48fYoWkhF3wfXVHYrW1tRlpQumTdldSe
 wxQkYO6O/0wFSfwhmXhL8WuZjZYM3962e3SvlnZRe+qXyjGpyNrwd+y3ctiqEBlwVKhiiDC
 3pGUvKPAizrrac28LvMrja2R7BhCvDD/own+Onb4vLVnDaPnmvFdAZ0Lnxrr5HxX6LkibXv
 trvQi0atjzM8cAssZynxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UmBF/EO5OAE=;FfZ39SwiYC01Xm5ED2ewtOSPdFB
 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

>> =E2=80=A6
>>> +++ b/drivers/dca/dca-core.c
>>> @@ -368,8 +368,11 @@ int register_dca_provider(struct dca_provider *dc=
a, struct device *dev)
>>>               raw_spin_unlock_irqrestore(&dca_lock, flags);
>>>               rc =3D dca_pci_rc_from_dev(dev);
>>>               newdomain =3D dca_allocate_domain(rc);
>>> -             if (!newdomain)
>>> +             if (!newdomain) {
>>> +                     dca_sysfs_remove_provider(dca);
>>>                       return -ENODEV;
>>> +             }
>>> +
>>>               raw_spin_lock_irqsave(&dca_lock, flags);
>> =E2=80=A6
>>
>> Please avoid a bit of duplicate source code in this function implementa=
tion
>> by using another goto chain.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?h=3Dv7.3-rc4#n572
>>
>> https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/dca/dca-core.c=
#L335-L389
=E2=80=A6
> Do you mean using a common error path like this?
=E2=80=A6
>         return 0;
> +
> +err_remove_provider:
> +       dca_sysfs_remove_provider(dca);
> +       return -ENODEV;
>  }

Yes.


> Would this be the preferred change? =E2=80=A6
Coding style preferences are also evolving into further directions.

Regards,
Markus
