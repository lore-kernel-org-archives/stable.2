Received: from sonic311-30.consmr.mail.ir2.yahoo.com (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612603B47FB
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136691; cv=none; b=RK+bP0FB95uUrMhICaLTio4AkLTlDM5uL8+vgchvdkOZ7ZfQxbBcocvzjVge/C8T6fGZWsqzu0v9nJFc5jWT2hgBWVxwp77ISxK8iR1IooRi01+GxgllxQ0/mbQmeOAxw49CnKreazj+ncWoV9KVtbLeP5H7ovmGQOr30mpA6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136691; c=relaxed/simple;
	bh=HkEzbJxQMOsi3KXpm0Z6tUB/wzFJRDYvcWcIy5jiifI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MywA3pusv1XagcZa95Zd/uTedM5kJqO7J0dZ1B2C8S0w/nHPLgnb1XD63BVm4ZAC9u8yOWptPcRxL03Ek40Zil0hDXMmu4PmC2mFjd5XLIfq0S6YTAYjs2zpKIw1sRUqT4qjgtZoeHJHDuvumiu/dUNwLUHuSaKehY2r5mcreOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.it; spf=pass smtp.mailfrom=yahoo.it; dkim=pass (2048-bit key) header.d=yahoo.it header.i=@yahoo.it header.b=INIpCsnH; arc=none smtp.client-ip=77.238.176.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.it header.i=@yahoo.it header.b="INIpCsnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s2048; t=1782136688; bh=hoeKuPJuZTU4yzEZeRi9SnV0/wIqpGVR8s8vVGwSILo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=INIpCsnHOaqONuUlYl9PbYGaw1xf/GXLvVKhX0BJVeEhIB9tY77q/QlN8g0S+nfI6Eqoy9ze2BRrBjtv+Ltr/zhJH0SQT8tfEFIi8ulPbpyNUm2hV3hKKt0DRHgo8ncKxKOYvGs6WMZbWPbE6Ysxvqaq1DIo4fDmkUhzftNGWKt+TAtSz7MpwI8iUgRKSgrGw3TvKmACS1DtCoRzfZi0HH7ujpJ1BF8NlqARFL6SXLwUYEOG2zLnrXS5GCVXRqHK63P04vo3AC7DU6uPfxy56C9N4vibBupfcsa1BRRZgI1GP1bTXxZl6y58q+OCrUWnWszhKY0iNAdGZYB1mxUeOQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782136688; bh=1ze1bNWmodINPcRC6EuiwHLpZHwVXWYeIC3XE0D93n3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=a+rxnYpdl1O8MIWK/ioH8+UwY7d8VQuMMgPHAZZdPb26Ea3IW9GaK5GgGN0XsQ8yzCkSwqq7tnxwvOK2Gfrv+fZPuqc5x/WIgqEAw2dTSvTZuIw3GC0moX8mkUzPP9A/YjI+KbVwqunJsu7M8OyO/Yxg2ugH5nJ6j1w0N1w7SfRaMW/IQ34o3uEVKo6F9wUOB6cpAZf+gZj9HbOmwld+GP2pNg1tD4mqIsCZuWf60zRL5bdPc71BtypoqtF8kDjWnDARRk3PuwzIDo1KL0rmfvxkZcOFBhFEdCXN1fH5GMshgqWkiKmHJS6kwhEYe6t9FcPi5w7y7GWJTgHOTx/vHw==
X-YMail-OSG: YY9d42kVM1kRe15fftSJB0NE9zxHS06QFILjmQg_0QktxybksgxclF1S.uKk1sr
 pMcxrXiWbKJdPInPq3SvFcDKJNNALbU75xDCU29PwS1V3hcZk8o36sb8mvrRw.ic2Y5tRfpnTzoS
 V1YhYn1it1O37N9s2G.wZ.kC7n049ESzTTu6oMmI6uwDLRBzc3CFp7G5N7djKWKUwQp3ZEPyYGfR
 Ojg51lFNqhEYlCfoDlHIqdmmSEN3gNxS8RmKAR3LiD8q8AkAKQXDUJrP_fSkpl7fCeVw9nef66Qq
 xdEObw3TWf3n.Csj02Gj8x.zGpwgGPDldrKqLhpbgntdz4nKaCMR6w8Truof05cQMy8pCpJyhHq2
 safw0uftemwU0GGhcXcHAbpFS7RxQIhLKT7AYM7SuWjM2d8qZ.dPB7L0O3rr3MjnmpzF85rwZDiq
 7NbgrGpJtGhtJH_d81Yc65aD3agDjLCa3m_omTZTi4Dht2qzhPpp48sdAdUU_yluR6RWlXrGxhoz
 yKKFK_UWePNe3tInF3U_Tfg1FK_yLvvxdRovsk7SXMILoI12ZM9jfcoAUwavFA.5ynWGdQ1HSgKx
 YLV_SucnKSCTuG16ido43pcPqMaIXwineR.51cpj2j..d.Fc8Ml0PRz11IexhZelh4osWFeVCmfE
 yex6AEugmwDEVlOAJazEtmHJaper3pabm7S42qL0N.L2PS0TeM9upL4nffcN5s0.rV2A1TlHEd04
 c5ALJmndS5.SUHx0TEGaVAwcuM5WOtttqG3wUgqBLa1ZwVLiE_RfA9Q7B.Wa2jRwxtmWtj0k8lQ.
 Ls7JjuvVNiEBCIxvxM10.cXTt5v91h.YhQcyURbu14QymTDGe13fWRxHxfXLRcr5d4Zl.Q4pmuQg
 VFMGmisuL9_V4vC8BwwZaNu5x1bvU2bFGTpprVHwZ8d408LTSpY.GTyCPOlxnTNgM4vrmyw2hDLK
 w.3CVNm.njAChvtji0nL4pjvj43o7KNJ0q6h9tEn2wxvUs41QPtj4hcabaHisrjZDV7FB3fr1cH5
 UxBNAF0BUC0jqo2HFLPxrWGSC189pHG0C1HDsrc92rXYHJws56H3yiv8x2IopeO7MRVxYFIfxueT
 Rrs9iCL36hR2k.7MmbdHO9Y8ShJds3Hrt1YAwJAey3qLWAy.dn8htEY0UNH78sE_NE5WJ2SJhJ_Z
 3GN4xrrIrvQ4jIS8WaUwkvPmqZjxm25vnawwtX63wiPw2b0Ugce_Bos5cbsSzia2XJpFVoifKIqC
 mk1C1zKKUvE321xNjfd9Fxujjk0aTX0JqmNbcgHGRGBk.uOIQysVZVuuN0RHenryK8DWs7knjy08
 Tog_e3BBC_KhTB2RZcuAjIeXZ93s_VYRGzHf7Px4gKQlnUVB4JhvhbzcvnxL7hdyK_AT6jKGN24k
 RImQiPqx9SKYjaeQsXp5yQo4qTmE_IyYebTDkmb8R2wT2znzPqnLuF3l6d8Ds4OEJAQvhcXieSnQ
 _9S6QSEqZHtvE29jNfKIEICgAC_yzbUsL2SuU3Rh3pIb20Q2YxzDMbliqlPYRIJ88s4ckNpTq1mi
 9010ws1V.OTlxexH0DVA0IsTE7ejv0WH8YjeXNxC6S3yvdDkZJxHBO7P5wd8UuJvjvoOkDA_MKhw
 ptk9B5yAl6TZO8B9UwFrG_XMSFcrsMF6Y56O8zsERTfiMAeB9BiCK_oUcz0Klq9NH3VcpkZb2Akr
 hO8pUlEh9UmPArF6APAC7sRI7LIcRfizZ9ao2L7iHwCDsUIPPuwE2MivoDTDlNyVYDa7ZgZSYMhP
 sdzJaaP_vRNpRFbluE3ncBXug3qGJs.WGO_39sJuOzlOb04VHcK1IrshIfkpwXk9jz2UJ0wC6se7
 z1YAAOwRRMStjGK4gXe9i09KWzzVVgjFbDaMRM8PtAV6sOrqKelp8pVF0zcUfT42kYrCcvKqV88i
 31W77cMqaFJ58LWeQpJWlPJ4IsVDhswpJ6w3OuA9VQ.4wWH6EaA2uG0VvTjbbjieZrajAOsIJdpE
 AY7cyOJVik7cwDZCcQOn8nEzTos6v3_2BtJ8KIbzV_eCHubKUoHIV7Bpn2XWiElgM4bL_5TH1nJ7
 b1f6SHEA66AY4LXhf8mhIcl2KQzXO9sxoKJvCGABTU1Ybehs1Ki1LRK2rAbqWy03192D3oKxqun4
 NCeI8XgPJKZOMXCkgJIGh6mELqsQ6J19k3nqbavRxDaJHa_un6UQwoh0vXkukyHU_S0YDtTRvoXX
 Wnj5rB1lGDJN7HififSWR0vZtiH8t5bxfrs6fJtdZHixm7I_yzynu1dvOuAWEJLodeDiTV7o-
X-Sonic-MF: <giovannisantini93@yahoo.it>
X-Sonic-ID: 18b50555-74d5-45da-8030-189559142278
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Mon, 22 Jun 2026 13:58:08 +0000
Received: by hermes--production-ir2-89844b765-tm5pb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32028e6f0f53486183f93035dfd9b18e;
          Mon, 22 Jun 2026 13:15:33 +0000 (UTC)
Message-ID: <745a32ea-0b17-431f-9aa4-f4388f9cbf10@yahoo.it>
Date: Mon, 22 Jun 2026 15:15:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: WiFi card is not offloaded properly when suspending the OS
To: Ping-Ke Shih <pkshih@realtek.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>
References: <10da4c45-74ed-4deb-8c88-6d0b803465ba.ref@yahoo.it>
 <10da4c45-74ed-4deb-8c88-6d0b803465ba@yahoo.it>
 <efae0a4db2ab4b6193922b393d3dcdd6@realtek.com>
 <02e09f1a-2807-4fec-aacf-1bc4bbb1ccd1@yahoo.it>
 <b3d2c32150884cdcae21b3bec5062864@realtek.com>
Content-Language: en-US
From: Giovanni Santini <giovannisantini93@yahoo.it>
Autocrypt: addr=giovannisantini93@yahoo.it; keydata=
 xjMEaH5G6BYJKwYBBAHaRw8BAQdAZnF+SJD511cVwFnagEObR10TvHEDWiUkXn55qPW4mEPN
 LUdpb3Zhbm5pIFNhbnRpbmkgPGdpb3Zhbm5pc2FudGluaTkzQHlhaG9vLml0PsKTBBMWCgA7
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEsZlH+Qx7w0bL59UyBjXtZomc07YFAmh+
 UU4CGQEACgkQBjXtZomc07aqRAD/dTapfdaiXcED3umK46Ef4oj+4yMmgvILQvAzbTWCW8oB
 AMbcBT7PaB6GuHTLiM0mZwLaB8koObNKxw3XtV7kMw4HzjgEaH5G6BIKKwYBBAGXVQEFAQEH
 QI7SNDV1L0Dq0IjkhOsUDwU7Wzr+AunkhuOy1hUDbY1UAwEIB8J4BBgWCgAgFiEEsZlH+Qx7
 w0bL59UyBjXtZomc07YFAmh+RugCGwwACgkQBjXtZomc07YxZQD9GgcfEawEgJeUijTqZtoq
 /knXol2L++0rMJkdr1SODwYA/07vSweYeVzo00XbyjcQ1le1Y852Ktp6A7O+DZsQJZoG
In-Reply-To: <b3d2c32150884cdcae21b3bec5062864@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26016 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2026-06-12 02:30, Ping-Ke Shih wrote:
> Did you mean 7.0.10 doesn't work to you, but 7.0.11 works well?
>
> However, the rtw88 driver has no change between 7.0.10 and 7.0.11.
> I feel the cause might be changes of PCI host, but drivers/pci/ has no changes
> neither. No obvious idea for now.
>
> ...
>
> Ping-Ke

Hello,

After some research, it looked that it could be an hardware issue.

I've opened my laptop, cleaned it and re-inserted the WiFi card.

As of now, the issue seems gone, although I've been using my laptop much 
less recently.

I will monitor the situation a bit longer and write here again if the 
issue comes back.

Bests!

-- 
Giovanni Santini

