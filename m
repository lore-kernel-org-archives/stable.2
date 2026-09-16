Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351814C33E1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577164; cv=none; b=mjFp8QtT+ozOpn09/OjMqa1/Xp3ZYwjmhsHqIypy4cwgOnhXvSKV3KtJ7JsO/Tfb9kTkVIFuuzwY+DzJY7DUpkPPJdqj8Dk3byEbwp49vIChYFSOCO0pTx092WPRqSe8IEExIOs0hZbexZlTc3QV/TxMR6tIfkTt9rSbi5Nbds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577164; c=relaxed/simple;
	bh=qUjUi4OUkxEIztp25vsRitnlL+dXfqSGw1HVgzhiFO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oT4LNFUbuKXoo4P5lPtAPOA8ZcwgwbCvpnqi3HzfgKnSJ3X+pfCVOVeZHBp029xXtUGgB2kL2aOEe6606lEmbDRoHHK+tRbh+YmbgOCML26bmjTMsAN6jnGIK1Z+tejGz8kNY+os6O8O+DN87tAWVcKYiNBPyc7juGmNbH5uI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPKDZ+PL; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPKDZ+PL"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8d881so1450386d50.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577157; x=1790181957; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bn6aZ1lxwJ4I9Ak9bkD3kswRMqJ+xZxBaB9EJrANxpc=;
        b=EPKDZ+PLK5/qV2BV9dlC+vUbDDr8CnTKrtN0betFSOYS+eL8+V5Bv3HIVcBBw8nZkG
         XvhCJX/4FvNyMkMAzvXNG0dhRvApwgrvst//XT2eqy5l1sQrgagon4+ITro8R827A2j6
         mTo2KPv7QWxuhHJ6H82l+G971tl2EeL4s5RaKmnWNey10/zDsUK2xJHi39q2qyID6xKE
         x0hbedXU8yudpc43hhJaA7YZok0lfhP/R1VizEnTiHBod/wEQ98gbTzxZ77k+H3nPJ+X
         mRBqkaFQ/zLCAKIdQFEEpfiMGm6RE9Iu7pjuL6NHvWjDy3fjWAlVKa65s1UCdr7v9ifJ
         q7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577157; x=1790181957;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bn6aZ1lxwJ4I9Ak9bkD3kswRMqJ+xZxBaB9EJrANxpc=;
        b=h+kyKBJHh2w4f2nqxJSBluYdd34ERy9vDYYBHvIfBDr7FwG4E/hqjQmcZlrroeAN9j
         7BHzXSnilij0twczjIRh4novL8lpIqlQBl/3KRyTjYRnLYpQ35VPhsOnXafQIC2cqkCo
         yO3yG+mdmNXy6cahRRHLalm5dWZzFz5qdi042IDppETrlArVk0wfA3dK9yNzKxJq4P+G
         0g6bJCMpAczIFgW2g1FSl74KNGPE265EhdZSjYIGlOFvUa9GGcgtZQl+34xFKXWv0rV1
         WGiB28jyhh0zxzWFu0K5TwBxM2sfW9odSNB62zM8TTkKFAwjWP5humGscUQpd5Q39UAv
         4tNA==
X-Forwarded-Encrypted: i=1; AKwUvBycpeWlhMlPJSKlq+I/HdfXRMuPLt13eEtvfP7HBMZRrcvIgg8TfxWrQnyLhENKFzcXRl623fM=@vger.kernel.org
X-Gm-Message-State: AFuF++m+2s9S8MQveOEYyYxEpwdAbyUSpZG3fgpALDZShvBH96/QEwR1
	mwqGlN93MAT+I4WWWZ26iBW+Xd8CAn8TkL06vqZ6LmtHCC/dNlmcPc3n1IASWXzM
X-Gm-Gg: AYBFou1LkGBKQ651NsazdLCpxrgFZXGlrIJ/C4+lrPH6YXPA/3UkogTHQ/dqVSNjS0c
	Twu9IJYvJF7rSWyJg0InSwcw1YV6p816DqI08Zq9xCdx94d6S9juqIMQsvXgjj4CaTg6iElP1ct
	YQCHbMuyVBq3dG2rdQ8DP51RjqHz4ANlYydn2nEI8dRUnApuDLOPKDMvNYTaXoi3Ff+1tiv55U/
	egv+8rKJQ8oKrLpi3bz9hDN4UoujbDPSf56NUoMFUl2dnzOIOTC+OIe2X+HN/GwI99cE6anQjBt
	GJ3QeTsV4diwrTmZVsVGr0XVr84cAQsz+TXKGVooRuJaECtVZOYEzyu8l0rrUkAQTOEPcQrXPz1
	AmSihvNQEnO3YHS352l07D878qXAcsgyHXipQuAqqy/ezTEjqCid7q2w97OCgHDh37yXSSV+vVu
	3KXwty3yFz1NCqglob2RHm2Qcxr0rL0TTBjOps/3VSxpFwEgzKZr4oLc93HMrULncOc52p62FRF
	Q==
X-Received: by 2002:a05:690e:1501:b0:66f:c1bc:4025 with SMTP id 956f58d0204a3-671632afbedmr1106459d50.82.1789577157100;
        Wed, 16 Sep 2026 09:45:57 -0700 (PDT)
Received: from [10.138.10.6] ([185.98.168.18])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f45f803sm1587709d50.0.2026.09.16.09.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 09:45:55 -0700 (PDT)
Message-ID: <157aa2cc-65b3-4d89-aa5e-eccd87296293@gmail.com>
Date: Wed, 16 Sep 2026 12:45:40 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] crypto: qce - Fix crypto self-test failures
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Eneas U de Queiroz <cotequeiroz@gmail.com>,
 Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-crypto@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
 <7e1b4800-258b-4410-8e88-2ce49505689e@gmail.com>
 <CAMRc=Mdd-_t4HniR0k-xhyS4aMD1gnqJPYgS2cEY81b0dwDZGA@mail.gmail.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <CAMRc=Mdd-_t4HniR0k-xhyS4aMD1gnqJPYgS2cEY81b0dwDZGA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3xXgf3kbCf0caq6YE31E0Mh9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3xXgf3kbCf0caq6YE31E0Mh9
Content-Type: multipart/mixed; boundary="------------dkM26DHH2Ls9uC8sbskWeJcz";
 protected-headers="v1"; hp="clear"
Message-ID: <157aa2cc-65b3-4d89-aa5e-eccd87296293@gmail.com>
Date: Wed, 16 Sep 2026 12:45:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] crypto: qce - Fix crypto self-test failures
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Eneas U de Queiroz <cotequeiroz@gmail.com>,
 Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-crypto@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
 <7e1b4800-258b-4410-8e88-2ce49505689e@gmail.com>
 <CAMRc=Mdd-_t4HniR0k-xhyS4aMD1gnqJPYgS2cEY81b0dwDZGA@mail.gmail.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <CAMRc=Mdd-_t4HniR0k-xhyS4aMD1gnqJPYgS2cEY81b0dwDZGA@mail.gmail.com>

--------------dkM26DHH2Ls9uC8sbskWeJcz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/15/26 05:42, Bartosz Golaszewski wrote:
> On Fri, 11 Sep 2026 20:34:39 +0200, Demi Marie Obenour
> <demiobenour@gmail.com> said:
>> On 9/10/26 09:00, Bartosz Golaszewski wrote:
>>> This iteration - in addition to the previous fixes - proposes to spli=
t
>>> the QCE driver into a core part necessary to bind to the QCE DT node =
and
>>> enable runtime power management in order to allow to drop the
>>> interconnect votes, and the crypto part registering the crypto
>>> algorithms. The core module is then enabled in arm64 defconfig while =
the
>>> crypto part stays disabled by default.
>>>
>>> The QCE hardware crypto engine has several limitations that cause it =
to
>>> produce incorrect results or stall on certain inputs. This series fix=
es
>>> several bugs and adds workaround allowing the deiver to pass crypto
>>> self-tests.
>>>
>>> The failures addressed are:
>>>
>>> - HMAC self-test failures for empty messages
>>> - AES-XTS returning success on zero-length input (should be -EINVAL)
>>> - AES-CTR: partial final block causes the engine to stall, output IV
>>>   derivation was incorrect
>>> - AES-XTS with key1 =3D=3D key2 is not supported by the CE
>>> - AES-CCM: partial final block and fragmented payload both stall the
>>>   engine
>>>
>>> All fixes were tested on an SM8650 QRD board with
>>> CONFIG_CRYPTO_SELFTESTS=3Dy and CONFIG_CRYPTO_SELFTESTS_FULL=3Dy.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.=
com>
>> For stable, would it be better to not register the algorithms, thus
>> preventing their use?  Another option would be to replace the whole
>> driver with an always-on stub driver that just does power management.
>=20
> A module parameter called: really_register_algos that's disabled by def=
ault?
>=20
> Bart

Works for me!  If you add that and fix the tests, go ahead and revert
my patch that marked it as BROKEN.  I suggest reverting the defconfig
changes too, for power management reasons.

While the driver is buggy, you might want to add a kernel taint if
the option is set.  There's precedent for that in other parts of the
kernel.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------dkM26DHH2Ls9uC8sbskWeJcz--

--------------3xXgf3kbCf0caq6YE31E0Mh9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmqqx78ACgkQszaHOrMp
8lOXMg//YUoYq1jOWJhfaYWrvjJUWr4wIsMXxR7r4HrvqRlmSA7MysXs6nyT2/YS
0jq8PO5/hR7WNnQIKLnWOvCuVJAvftfLKXla2X2W+PUdjP6o7Z1B9w087OGk9RWL
iPMCo8p4RkK0m+eJs4FNBLV71Xi24ivv0/2o2ixyJSOH939/Xa8x3ndW3SGajA9v
ErJFDlD0nIpDNVk4lY/meOVy1Na/JTujjboJBcqqlkQcfATgqNkPepwqJCnYbe6w
SeqfPMOlG7LqzBU7FL7ZIbo5sRBLqU1qmAQ4qlVyRcvr3nuNsHku2u8/kMNFLB4n
cxM+PwZ+5LPhV50Cic/INKASvblYZ7sGkFMgjHP9sSiFctYUPylsm1jbHCl6rt3U
qRWqZURLgrV6AmSbb9wFPkmUeVdHyVq7ZiCzoXtpVTPJ3j8Epdx0B/M7gzTrmF5Q
4VyeVVbEap8sRQrJYmAbZtzlRppZMUQjMi7ZrAvg+r/FmTxcHGknFBZ9UGRgT/7Y
EYMBMuUCOGlos+6qS2PXLV3Onsi+olovwhrR45EffzBTSzopqX6EQDxZcQS04mVa
fJk8NcewRI9vnOoeJR7jsFhUlY0HSo7Xf1LShGGHEKGJB9nrDylccN4HqI/U6lI+
Ued2Zg9qqzbB/KIOZlyMWhn9FulgcVI84kpEsPXlWfTLt+f2NrQ=
=Uo2z
-----END PGP SIGNATURE-----

--------------3xXgf3kbCf0caq6YE31E0Mh9--
