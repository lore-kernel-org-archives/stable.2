Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108092;
	b=hrbCYzWfAS+hNCPXgtRWvZky1pFF5FQ9EeK+7yqvBsXpmOlfsB1pF0XOAtVvu+hUWrWz
	 60Nh9nQfxiNhqq0ZRB8GWXbM5jV7FSKwdm5q2MtxwNN/8SMBMXwjPyM5BE4iRs23yc9tI
	 GFGBCymjo+5z5EB8xGzf+NwoyEUrXfmBFc+dSgiCGfdU5FN+tWtXZ8U81shKgTz+X9YAO
	 lHQuDdGqRFXqjwFmr6kRb62CdIQVmaNQnTbQ9+/6pg9Ew30J4/rVvowe1lIYYDT9amDV8
	 ELewphQd57qEpeMxmbpJ/Gyh1TjpHsNwmKmfQRYn9ZgwPMlKQcAMCQwIp5a4x+dg3Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108092;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=szr30qfed7aFxjATf+PSRuOQatUbk1IVD8s71KyY62w=;
	b=dIi4et9WSTfY+sHbMemGA4P+lW5buFg1ql+qCY6QnFDov9aJVOXlUNmf/U8CCeTQ5oO/
	 lBcu0bTcO4gH/zo/fic2/kfhuvTcYrFMOyqVmLFOLTB24OWTJP8u/+4A0RPMcPLSWpx/0
	 CP+WcJ7veNJc2zcn5rXXY9lJVlfhPEg8+yuu1BvukVkF5Pnpro817tmbuHpw/zRu5smCT
	 vMyaXeUKrCULG0OAGFxYLP0M9tIVzTJpujVQoHJqYVFA6QvybyvWjgD+bVZwqsKXI44z0
	 5oy9SuxAlga9Ho1GUe5nnSQWfQ3hcCkJ/eJOgIN8bG0Slcc76Y3QPQB29lecWuYNExQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Ix7Q8scf;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F260A260D
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 416F260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Ix7Q8scf
DKIM2-Signature:  i=1; m=1; t=1795108089;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:KwKMJLep594nIqt8wgpK28zZ4uby
   Zp+rXuzVg0n0kgf5oPks5TD3CHvkGfaG1UL2+nYdyukdGItxZrwpgtlJWUb0ulrIK9CuHIhuLou
   6tUqCBOGNOBB87G8zm3/c6M8GormCgu3Es2Eg3WcXFwcWSh+E5Hc3cxio7uFaYn8BBzNK3l9JwV
   17HQnahulpAuKbIsN6WoQhfpe73NtLpApf+3yQsbJL89s7c1Yh3GX5OvIUccnrb4KkMrkqyKCm4
   RPobM/Btp6dqgCgCcHvPZnj1dlug0Zq3bYPi5Tj3SK6ySAWs7IwUHxQZJJFa2RxM3s1NuwhJVRQ
   Twrz1oQxDZA1WQ==;
Message-Instance:  m=1;
 h=sha256:
   /keZ7M0FYczsNruQciTCQVi/goAQd1G6FnOliPa+L8A=:
   OXSP4KUFVqvyFbxwbF+XV8f63ESoiSpr7jEXOeobsn0=,
  sha512:
   367jVGINKBOzy7OhDa+eCsZaubzzyHbszPfNmfplAOoAJ4y447y4XOKgmmffjEq5dHQYv2w33LSk9+tMgf4G9Q==:
   AI3Yw2KF7dDS554c5lTFb5IG8Qn4nIYH+bqUCJNnqlnFt24wUkzau6mP+P5Jlx5dtrUWPR+dAmPUqjy2NHBxwQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795108078; x=1795712878; i=deller@gmx.de;
	bh=szr30qfed7aFxjATf+PSRuOQatUbk1IVD8s71KyY62w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ix7Q8scfljXRZ/Z8qs0OyZfWUQBOeCXhURd8lE6H9OS0mY+ZKGJ1pV/lcfc3u3E5
	 GM60L+2Ei+HCqMZUwbCYO4ci58PTPQpErDMGzyXQudPnuCmGv9F8HO47S4TvAcIcO
	 +Yt9REpGaUI9N20ABNwEYyqGTvhFooJ/UZCRpljLzLkPtHkF4mjJ6oDjuRYKXtEeX
	 CvL5ATD22kJhjyU/Ctq3UoRmMbW1WiLq/2m2/q85N2EJvhE3SjpWjfS8lsCh6a7nE
	 LnKgbTJAQeqdjbV/Ly32jUzaLWWePzfnfmBnOtT+P6wZROrvaTQvRIGe5GdUDy5nO
	 pA1qn8PCZvccr9S4Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1wPSb03lkh-013xZV; Thu, 19
 Nov 2026 18:07:57 +0100
Message-ID: <ccc56bc9-704e-43bd-b284-faf834ec4d10@gmx.de>
Date: Thu, 19 Nov 2026 18:07:56 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: s3c-fb: Fix potential registration corruption on
 probe failure
To: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261118-324f82bd41-fbdev-0@mail.sdu.edu.cn>
 <4fba8bdb-de77-4418-8ffc-7ad6982e8027@gmx.de>
 <AB2AtQBLLG04vL*MjX4Nuap6.3.1795092368475.Hmail.202321181@mail.sdu.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <AB2AtQBLLG04vL*MjX4Nuap6.3.1795092368475.Hmail.202321181@mail.sdu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ll2IOIM/V1nYWbw6D3QjvqxWPKKJ/VkAY5JEZW+8mWionSINDp6
 aZ2C0ujfZE3nl3p8JKJa2C1sTw6zbGgZ442Ri/+I7VYPcuOMGrRWSFKV9pBpvwiqUTPvotd
 xUO1nHipR/je84nkd8N9d2o/LvAbiaMHjqCAhYzGTatkLEbKc4q6B7uZ2w531TcScM+PLdV
 mitlo5ab5bqPmY2+mBq6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wh+jUNnLESM=;ip4bcnYeVXk8GLORRfIWEPpGTqB
 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
 +8d5K9TzqA==

On 11/19/26 13:46, =E6=9D=8E=E5=B9=BF=E7=A1=95 wrote:
>=20
>=20
> Hi Helge,
>=20
> Thanks for the review.
>=20
> From: Helge Deller <deller@gmx.de>
> Date: 2026-11-19 02:17:08
> To:  Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,Jingoo Han <jingoohan1@g=
mail.com>
> Cc:  linux-fbdev@vger.kernel.org,dri-devel@lists.freedesktop.org,linux-k=
ernel@vger.kernel.org,stable@vger.kernel.org
> Subject: Re: [PATCH] fbdev: s3c-fb: Fix potential registration corruptio=
n on probe failure>On 11/18/26 15:22, Guangshuo Li wrote:
>>> Probe failure cleanup calls unregister_framebuffer() even when the
>>> window has not been registered. Its zero-initialized node can then
>>> remove another framebuffer from registered_fb[0].
>>>
>>> Track successful registration and only unregister those framebuffers.
>>> Also skip empty window slots while unwinding a failed probe.
>>>
>>> This issue was found by our static analysis tool under development.
>>
>> I think s3c_fb_probe_win() needs to clean up when some things
>> like cmap fail to be allocated.
>> Your patch seems to just work around one of the possible pitfalls.
>>
>> Helge
>>
>=20
> s3c_fb_probe_win() sets *res early and carries on if fb_alloc_cmap()
> fails. I think it should unwind the current window on failure and set
> *res only after register_framebuffer() succeeds. That would leave the
> caller with just the registered windows to clean up.
>=20
> Is that where you'd put the cleanup?

Yes, I think s3c_fb_probe_win() should be able to handle every possible
error inside this function and do nice cleanups if it fails.

> If so, I'll send a v2 without the extra registration flag.
Thanks!

Helge
