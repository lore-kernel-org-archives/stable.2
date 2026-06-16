Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115F324B31
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606485; cv=none; b=DHtVPOFd27k0LAFSI+8zkDK+UKH/fWfLmswuYz32pVSmaiLWmjt034eSkdBTxIoGaey4gtEpRLUjYkI17KeKma9YHB0pF5KAety76HJ85jKXE4NHkvsnTzbZbavwacXBNXUE3N//hCz/QqdCpacBPl1ZsWvbIw20HSNllm2seg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606485; c=relaxed/simple;
	bh=GiwgUDhVPuccDsHM6fcajwPeBmdY/V23LoCQ/JyqQ5w=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5y7rkpxVJ2bKfoIHigBMNQVkKS25NPxBabL9MJX+rmk7XQfh33DJJYvYhWxkPW13QjlYxM0rdY4FJGUOj1spFYORhq+DsJp7ZrJtGhgbbA8uwHBpQMIZM4L2yWou1j/lmx4EkMRfQK7eU53+86e3gmfN1lT9S4tlZ21yaEbIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDST57TJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDST57TJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5AC1F00AC4
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781606484;
	bh=2tpmLa3dd6flsbsy+JH4P54/CMX4D7LsJ6W8CltvTok=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=lDST57TJodRceigb2VwiaQ0BBbw1vD9bcd9X+L/nZuc6pTHePvV4PTHHs537n9baA
	 67mbbjNVI3bXFnrZcPIUhGxb4fRHzSstlZPhGjb1gUDOui4i92rQevtsl4KRu5s+/j
	 2B9u0UDWiPDndFFN60XSAIdtKWCIPeoP+spHQctav/sGCBTE8KIcMW1AZtt5Ytfhjv
	 nrJn6CdUEheRPHjszM3T5wAzpxGipr4r/hjfBCCTKzppunk8tdW7OYuxo0yDYA5C72
	 RXkFbjX3cgn4dc3P9PweExe7AuoSMG7XiyGF+ZQad0sEK+YfaxLoOmf0/MV7haV9dG
	 8+XZ1+sV/eSLw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa6863327fso3764820e87.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:41:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9WuVYrCMmfQCnWZqy3hpYgnyhrB5fiYsqflR12JHnin2vdZILIrReYSPdadb1iQIrSKxGRuJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9npmYhPCXR+AsIXR0cTVJSmfRXDZY5LveTzf1IN4HZnwBUgr3
	gQlzY+UY53/gdAa4i7lrSO7Hgcv5YMtmvvUtUjrONgK2Q/w8iyZLNfK6WnretfREKAhQFlkbNzB
	dbo27l4PTX+9eKBcYFB3vkhLn+WC3rd3pBxPRMZoHKw==
X-Received: by 2002:a05:6512:3e17:b0:5aa:6946:6e4d with SMTP id
 2adb3069b0e04-5ad4351b594mr963896e87.19.1781606483423; Tue, 16 Jun 2026
 03:41:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 10:41:21 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 10:41:21 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260616051820.GA127019@sol>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
 <20260615-qce-fix-self-tests-v2-1-dc911f1aad42@oss.qualcomm.com> <20260616051820.GA127019@sol>
Date: Tue, 16 Jun 2026 10:41:21 +0000
X-Gmail-Original-Message-ID: <CAMRc=McmpeWY2yVbf-KoAG-uC8_cvcW6MJXFSOjnEFqpmjaoig@mail.gmail.com>
X-Gm-Features: AVVi8CfBtys2dQpRs7E2oMR0x48_wmRqAKjUTOb8b_ZnXmDQi8Ass0ebG3f0ZrY
Message-ID: <CAMRc=McmpeWY2yVbf-KoAG-uC8_cvcW6MJXFSOjnEFqpmjaoig@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] crypto: qce - Remove unsafe/deprecated algorithms
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, 
	Eneas U de Queiroz <cotequeiroz@gmail.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, 
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 07:18:20 +0200, Eric Biggers <ebiggers@kernel.org> said:
> On Mon, Jun 15, 2026 at 05:49:52PM +0200, Bartosz Golaszewski wrote:
>> Remove algorithms that are either unsafe or deprecated and have no
>> in-kernel users that cannot be served by the ARM CE implementations.
>>
>> AES-ECB reveals plaintext patterns (identical plaintext blocks produce
>> identical ciphertext blocks) and should not be exposed as a hardware-
>> accelerated primitive. DES, Triple DES and HMAC-SHA1 have been
>> deprecated for years.
>>
>> Remove ecb(aes), cbc(des), ecb(des3_ede), cbc(des3_ede), hmac(sha1) and
>> all AEAD variants built on these primitives. Also clean up the - now dead
>> - code, flags and constants.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
> What is the rationale for still supporting the following?
>
>     sha1
>     ecb(des)
>     authenc(hmac(sha256),cbc(des))
>

No, I should have removed those too. I'll update it in v3.

Bart
