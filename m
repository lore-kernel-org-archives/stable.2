Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107533D79E2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465352; cv=none; b=LcjUcCvmQ4Te9XXILGjw/BjgW6DQ1b/VTmcolnDMwNHtm5iC9A6TuTWRGpeDpDw2EV3GmC0rzks2y4Tue7jO+4LNm6z0WmLB9/FECr75UAST/7uQC+bPbiRJt1uMU5tYdxLRHKTaVsGICcHsmNfXtGzNfqYozvHzj1czfcULOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465352; c=relaxed/simple;
	bh=Dtsw2jRRFQXkxa7dgV6KxVRgcUhLSW62NygQfZL0d/0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L36m4Y/vweMRfIr/z954MABzALC/TgD1aLdhoHBVBqdBrjBcP2/aye5qCqV8ec/JSLsvrBHLD7qoL5yPj/gdFTtURqaWQ8cOfSMPtyYOYmA49muXTs2PRg7se/1YCAiNraogTE+JOD9EIWIRWzTZbzvx/cMzT66BcETck8YZHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSurg9qL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSurg9qL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A821F000FF
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789465349;
	bh=IAWcs2+jgJniRfPcDxguAhr6z0wCyj+/raYf2jcKofs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OSurg9qLd4v0JVaP//W+MeArgk2xkRmh7fVqp4guE1SEE5nB9R2LyEFv//rzhjlgb
	 79Fam3g4l++WgMO/nzuvJl1HDwkWM7Y/e1tVPLB5YKyKsWMFpk2uhoQrY7r08AaqFz
	 +B/09RQ2YXis8iKdcZLuLcLUGzjE1x7EQj8KpsQfA16UUi/rqfxXac1MhJf/nyWwZb
	 6cXmouIxVXiqnpR0uhR6Oxn0kv7omkVFHy2MQjkpIZ6nERCKKVHaxuCdeHyBW2s2P6
	 rNCvWZdEPSq4tBkptfOctvTp5sv8ZOYWT1pcU1VgqkKVdwTdMXFBguJGskO88MC74H
	 fmGmTYCPttMGQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so3164824e87.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:42:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw5F+4Uw9kdj9GMT1kg5JlGEmXgVL3kAab3jzHNlVdoSc3dwTyoHbO28KkeOC65r171JUmmH2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kbbK350vWRB6XOSnMGSS+3BOOHtwVHhb8OGsj83vJVENn+aWAR
	G74Tj9TD2J9DmTZ+Vk9y5XoMrIU4CAw0D7mqnHC8WwFP0X1fRm92aB5ZAeDf4cC7poC4YtONPyu
	2AOyzn6SD4lXRVXTsqjZLH1T/mDJDqS5jTko5727i8A==
X-Received: by 2002:a05:6512:3c87:b0:5b6:421:a8fe with SMTP id
 2adb3069b0e04-5b8ae8a71eemr3220367e87.30.1789465348346; Tue, 15 Sep 2026
 02:42:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:42:26 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:42:26 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <7e1b4800-258b-4410-8e88-2ce49505689e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com> <7e1b4800-258b-4410-8e88-2ce49505689e@gmail.com>
Date: Tue, 15 Sep 2026 05:42:26 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mdd-_t4HniR0k-xhyS4aMD1gnqJPYgS2cEY81b0dwDZGA@mail.gmail.com>
X-Gm-Features: AcwNN1WFu7OKIWnYNDJOJ45qVWn6DlSRIE6IYiW9ZjvE6EJLrN4IQn3AQpsM5Js
Message-ID: <CAMRc=Mdd-_t4HniR0k-xhyS4aMD1gnqJPYgS2cEY81b0dwDZGA@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] crypto: qce - Fix crypto self-test failures
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, 
	Eneas U de Queiroz <cotequeiroz@gmail.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Sep 2026 20:34:39 +0200, Demi Marie Obenour
<demiobenour@gmail.com> said:
> On 9/10/26 09:00, Bartosz Golaszewski wrote:
>> This iteration - in addition to the previous fixes - proposes to split
>> the QCE driver into a core part necessary to bind to the QCE DT node and
>> enable runtime power management in order to allow to drop the
>> interconnect votes, and the crypto part registering the crypto
>> algorithms. The core module is then enabled in arm64 defconfig while the
>> crypto part stays disabled by default.
>>
>> The QCE hardware crypto engine has several limitations that cause it to
>> produce incorrect results or stall on certain inputs. This series fixes
>> several bugs and adds workaround allowing the deiver to pass crypto
>> self-tests.
>>
>> The failures addressed are:
>>
>> - HMAC self-test failures for empty messages
>> - AES-XTS returning success on zero-length input (should be -EINVAL)
>> - AES-CTR: partial final block causes the engine to stall, output IV
>>   derivation was incorrect
>> - AES-XTS with key1 == key2 is not supported by the CE
>> - AES-CCM: partial final block and fragmented payload both stall the
>>   engine
>>
>> All fixes were tested on an SM8650 QRD board with
>> CONFIG_CRYPTO_SELFTESTS=y and CONFIG_CRYPTO_SELFTESTS_FULL=y.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> For stable, would it be better to not register the algorithms, thus
> preventing their use?  Another option would be to replace the whole
> driver with an always-on stub driver that just does power management.

A module parameter called: really_register_algos that's disabled by default?

Bart
