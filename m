Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06753D9CE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077961; cv=none; b=qVAUNJ3LeVa3kQ9BX9Z8YXtDjPs9LI5dEcSUCvacG0UQA6OH5qkbklY33tR8Q5a9itpmWOZfzhYpqWsPlhM8bOR6sJpX8dkyChMEkzo+5J4bbeGtxpzMudFCD/M20chT4KdjkmoW+n0qthlIS0m4DjDNbj71VzT8QlsOKVsOxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077961; c=relaxed/simple;
	bh=V8+MeDra6cSjzL6gWqbC2+T0T4Zis89/lQ6OEUfYBGk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoVrsZYeC61cJr76wfkuKWWAYM7rXbU9B9w6FV83rl3OtcFDsPVcFYKuYu1L874MZQlPdH6V1wQfDahQkpuzFGT/2BhChFFMnMBJPaL3Sk2rPTj+eHrQWl2RvtumDPCzKu0R9/gvn6NPIk9XXsWu7udSeWHz/Bdr+HsuziInfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivnD1FpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivnD1FpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9631F008A0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077960;
	bh=eP5mxCA22PcDYQqT6PJN84Q1ZYL8VkL3j8RWyf4Xjt0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ivnD1FpGeR92WYrsVhCHMkbo3bcYdeer6lZwM+4QriN1gfgXmSgnvOMY7t+uMRwPX
	 gbQQ3ZwJjllFNhMuZh0Ul2OYtIB/QzaSi0R5k8O4jrWL4CxjNjZWJWzg1dMdX8PNAG
	 o68dwnh1wWEs9UcInz+x3YwXkeMC4Ic+yBcyMFZ+e4poFSDb36xwnpr1s/QwiODdoO
	 rGtBEb26r6FZIJCv+/Dmm3mFIqvrICbut5Df0a/8T3EdWZJoFarku6fsLkRE3CBb6Z
	 cr7/uexby8cmOKLLVOee6YnoRtOkYvCepqxpiyoX9bk04pLejp1Eog3ANo3CzTBruZ
	 wxLnK32OarWBQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16cd1so3670169e87.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:52:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByABGIsPhRssiFezpLrBgGWRls0P1euSSyodfMRfa4PSf7wHPpPKQgS5E6HU8by1xmUps6TfoQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k74n+Y7h01gxaQpaI8JuVmUx5G0JmWOUWA8OPCIrF2aF1IbCkM
	azPZkj6xtdZp4OOnH1ZGFr3TfsO7XvcfvxVSUbvt0s39HgxKuoRrWzkYYl93zBtHMjIgdokoyjb
	ubkWhhjDOZAmqep/M63SaYt+oDPjvm7xyaaknLrBPbA==
X-Received: by 2002:a05:6512:1394:b0:5b6:4ae:a3f6 with SMTP id
 2adb3069b0e04-5b8c1833f9emr4493348e87.30.1790077958932; Tue, 22 Sep 2026
 04:52:38 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 04:52:36 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 04:52:36 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <arJGAjRRC-5EPjH6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com>
 <CAMRc=MdWZhLy7AXd2OiVsaT92xTh1EF+B+LNo2b-1D2TO3rAmA@mail.gmail.com> <arJGAjRRC-5EPjH6@gondor.apana.org.au>
Date: Tue, 22 Sep 2026 04:52:36 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdMbAw5pfOOnV0ppdZyKqFe8c+ypt0e92vZqxhO4dSmGg@mail.gmail.com>
X-Gm-Features: AcwNN1VABbac5dFrDJiTxQAG7Ey-cY0fj19Y-QeBI1gWJEBtWlgt5w23NbxPNkM
Message-ID: <CAMRc=MdMbAw5pfOOnV0ppdZyKqFe8c+ypt0e92vZqxhO4dSmGg@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] crypto: qce - Fix crypto self-test failures
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Thara Gopinath <thara.gopinath@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Stanimir Varbanov <svarbanov@mm-sol.com>, Eneas U de Queiroz <cotequeiroz@gmail.com>, 
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sep 2026 11:10:26 +0200, Herbert Xu
<herbert@gondor.apana.org.au> said:
> On Tue, Sep 22, 2026 at 01:22:31AM -0700, Bartosz Golaszewski wrote:
>>
>> Herbert: Sashiko still says it fails to apply. I have no idea why, it applies
>> fine on top of current linux-next.
>
> The first patch doesn't apply for me either using git apply.  Please
> download the latest cryptodev-2.6 (a9a2152d292fd0bc73814eb4a127278ee7dd3f6a)
> and rebase.
>

Yes, this does help but does it mean changes from cryptodev/master are not fed
into linux-next?

Bartosz
