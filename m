Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB048EBE4
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989512; cv=none; b=KF/Mn6Zh6EkUhlApWnj3zSO1EufX+oknkCVMdF7noCOch6aKa35wqEcBONoQoSQuEM6K+qmqZ3DVYhRCT/PdLQz7H7pnTxZfjMmr3ibx3DDPvdGvDQ8zMX57RLvtJ/L9jDQQjYRC+AazcrgTXQ6uBpPp3UBAeDNmeIlJsKMzzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989512; c=relaxed/simple;
	bh=0lhdK++H52V7C+9/x/WAXf/65wpHuCIWIjfoxP6pJTc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eedX4pC8BTZVYU65IL7HAOtVI9zY2KX6qcDaTpn+D7x4bsXSXQ25DnhaM/TR9nkSQ7RQXIds7eYNsWB9Mkrwzvj1LWMVgCqdCVgjDvr4v8K5qtYv9/gtIVOmMpusosRwY9QSJPeZc2XY3m0dp0LR4u5x6juHwWdJrf272KOnM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSmonRtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSmonRtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1721F00899
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989510;
	bh=UAYY1SKAjfvrtU2FyE9SAIxYBApmyvXhnLVQf2IeOzQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=jSmonRtcUHOLrHqyI6wdYl+qQvF6gDNIfJ8u3K8x/xjkOeehQgoKAPZ7QdM5MnzAI
	 6KhTX2mCbFBgyRi9BBd2wSd5j158Z/AuYe1/I4+RerK4ceYFvbedU0O5dnbjgJgkTd
	 LafYoUTH3gJyDNZjvOyVjfY8TLDRpWP7s3cJWEG9PfzIilkhY0OTz1lfGwj2iWkaSj
	 lJZ4FPzBmABSnu0z+KhLjraXl0zs//rfEeBxHromHaA1EbKh3vXBkiQ4hJg3uU4rWz
	 ApVF+iGcLYxCmc97jnrx7RiqGDmuakgVSXCjFfV3mDq4aWfuvEENXUOiDgnjlfm3GN
	 7QMNtC7VjXnMw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso2376162e87.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:18:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByl0RVgaPtvmI7erXzGqdiBZd1msmTgrEz1PzKfhvltSC6gZPOZ6H3lJR5vObXAzZ1GfGfEef4=@vger.kernel.org
X-Gm-Message-State: AFuF++lvAc1oqZOQ/p1KwVxSuqA+sbUYVIW6ZD36/ugQt2mr11U6tI8c
	3BJsjpLDEM8cSIpdys7fZ5dZ3nAazsX1H0EGo1b/5IhHV1N+eOJQojc0HTslihoQGHkZA5GrFGE
	+l/haAt7WsP+atNEvi9dVoL+vpwc4l5A5pDkKPflWmg==
X-Received: by 2002:a05:6512:220e:b0:5b8:c326:7a4f with SMTP id
 2adb3069b0e04-5b8c3267b91mr2872421e87.35.1789989509300; Mon, 21 Sep 2026
 04:18:29 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 07:18:27 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 07:18:27 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <157aa2cc-65b3-4d89-aa5e-eccd87296293@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
 <7e1b4800-258b-4410-8e88-2ce49505689e@gmail.com> <CAMRc=Mdd-_t4HniR0k-xhyS4aMD1gnqJPYgS2cEY81b0dwDZGA@mail.gmail.com>
 <157aa2cc-65b3-4d89-aa5e-eccd87296293@gmail.com>
Date: Mon, 21 Sep 2026 07:18:27 -0400
X-Gmail-Original-Message-ID: <CAMRc=McHLjU5Fk8fr94jHy4=F_6vbj2dGkyA6azvv9OGH_qA2g@mail.gmail.com>
X-Gm-Features: AcwNN1WQVPgZRz06Xz-84UQd5zPX8aR-SdtsdHb1A5-uJBJBK1nBSycVRXt6zWw
Message-ID: <CAMRc=McHLjU5Fk8fr94jHy4=F_6vbj2dGkyA6azvv9OGH_qA2g@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] crypto: qce - Fix crypto self-test failures
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, 
	Eneas U de Queiroz <cotequeiroz@gmail.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sep 2026 18:45:40 +0200, Demi Marie Obenour
<demiobenour@gmail.com> said:
> On 9/15/26 05:42, Bartosz Golaszewski wrote:
>> On Fri, 11 Sep 2026 20:34:39 +0200, Demi Marie Obenour
>> <demiobenour@gmail.com> said:
>>> On 9/10/26 09:00, Bartosz Golaszewski wrote:
>>>> This iteration - in addition to the previous fixes - proposes to split
>>>> the QCE driver into a core part necessary to bind to the QCE DT node and
>>>> enable runtime power management in order to allow to drop the
>>>> interconnect votes, and the crypto part registering the crypto
>>>> algorithms. The core module is then enabled in arm64 defconfig while the
>>>> crypto part stays disabled by default.
>>>>
>>>> The QCE hardware crypto engine has several limitations that cause it to
>>>> produce incorrect results or stall on certain inputs. This series fixes
>>>> several bugs and adds workaround allowing the deiver to pass crypto
>>>> self-tests.
>>>>
>>>> The failures addressed are:
>>>>
>>>> - HMAC self-test failures for empty messages
>>>> - AES-XTS returning success on zero-length input (should be -EINVAL)
>>>> - AES-CTR: partial final block causes the engine to stall, output IV
>>>>   derivation was incorrect
>>>> - AES-XTS with key1 == key2 is not supported by the CE
>>>> - AES-CCM: partial final block and fragmented payload both stall the
>>>>   engine
>>>>
>>>> All fixes were tested on an SM8650 QRD board with
>>>> CONFIG_CRYPTO_SELFTESTS=y and CONFIG_CRYPTO_SELFTESTS_FULL=y.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>> For stable, would it be better to not register the algorithms, thus
>>> preventing their use?  Another option would be to replace the whole
>>> driver with an always-on stub driver that just does power management.
>>
>> A module parameter called: really_register_algos that's disabled by default?
>>
>> Bart
>
> Works for me!  If you add that and fix the tests, go ahead and revert
> my patch that marked it as BROKEN.  I suggest reverting the defconfig
> changes too, for power management reasons.
>
> While the driver is buggy, you might want to add a kernel taint if
> the option is set.  There's precedent for that in other parts of the
> kernel.

I'd prefer not to. I hope gating the algos behind a module parameter is enough.

Bart
