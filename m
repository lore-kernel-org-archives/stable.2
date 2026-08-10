Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F4357CF1
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336048; cv=none; b=XPghEPm2DLXzYGrlNtDhx4EL72gHaCi/aF3JQL8Deh5x3pcVEadTxOUN3h3DljIxH6vPVxLYS+j6r07WMQ2g07UhCPefhjeLjsIh3Q4fBV9D1snxqTtoQ66sM3TfA06s2hoxOOhZiKCa27vkXNm4tZ27CXeAnDN1HjoMZ3b5o38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336048; c=relaxed/simple;
	bh=wx9aNU0dlmH9zLsOACzljg6D67PZRBXkoGO2KHRk+zE=;
	h=From:Date:To:Subject:Mime-Version:Content-Type:Cc:Message-Id:
	 In-Reply-To:References:Content-Disposition; b=WrsV0p8ItPFw86+r/3eb3N7B3ckFmkTwh+ntZyOZ0aAj9Yca3Phd8Azh9/8MDdBo9Xh4l29ncI74PihJ5HMgi9Ow70ftgcwtDLzGdMtQybnFm6D++a1e7h3JfKzzVLMUsdObZfMojJL/KEB9r9PRhmSVVg2QJmTJ1d0oEC1h/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=DtW4o0Zs; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="DtW4o0Zs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786336032; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=07wPy24JVSeYgxJE8YgvJITtIL6el3eBMIYwcy8cb88=;
 b=DtW4o0ZszAJj2L4s6B7zlCXbzV5PzCHR22XmBAmJTLr0htHGrA+WleFnhwk8klSejnwwLL
 tYnPGnz7aQWqi0lN9MCmS+54sNWxwfr7QbZc51l24ve98PUkYsQfDpxjVfeJtlpyerAwWb
 aZm8zhUqFBcWCEfsEa7lDpRa5d1Dj+Au+wk5lAxzu3FN81RWZXH4r9eGXatG2JCHWGZwKm
 TmpR2o/1+RfIAy4G410CZgl37sQA64eugrDFUubVLOKR/i1esPTCZrJ2p7ix7kwNH4+hvq
 CiU914JEOY9mewQOplXgYmfJaOz1lvQRTo/BRW6YXZrzbvVoN/qxysLI3mkoxw==
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Mon, 10 Aug 2026 12:27:07 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from pve ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Mon, 10 Aug 2026 12:27:09 +0800
To: "Jonathan Cameron" <jic23@kernel.org>
Subject: Re: [PATCH RESEND v2] iio: accel: fxls8962af: clamp FIFO sample count
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shengzhuo Wei" <me@cherr.cc>, "David Lechner" <dlechner@baylibre.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>, 
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Joshua Crofts" <joshua.crofts1@gmail.com>
Message-Id: <anlTG3uxHEkyxtQv@pve>
In-Reply-To: <20260810003101.3a2d1967@jic23-huawei>
References: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc> <20260810003101.3a2d1967@jic23-huawei>
X-Lms-Return-Path: <lba+26a79531e+064959+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2026-08-10 00:31, Jonathan Cameron wrote:
=20
> Same comments as similar patches.
> - Not a fix, but rather hardening against buggy hardware.
> - Don't hide the problem by clamping.  If this happens in the wild
>   we want to know about it!
>=20

Hi Jonathan,

Thanks for the feedback. I also just realized that this patch
duplicates Bryam Vargas's "iio: accel: fxls8962af: clamp the
device-reported FIFO sample count", which you've already applied =E2=80=94 =
I
sent mine before noticing Bryam had gotten there first.

Since Bryam's is already in, how would you like to handle it? Either:

- just conclude here, since Bryam's already covers fxls8962af (I'll
drop mine); or

- rework to the error-out approach you described =E2=80=94 though your
feedback (don't clamp, report it) applies just as much to Bryam's
version, so that would need the same treatment.

If you'd like the rework, the fix I'd propose is: instead of clamping
count to FXLS8962AF_FIFO_LENGTH, treat an out-of-range count as a
hardware error =E2=80=94 dev_err() and skip the flush (don't carry on
reading), so a malfunctioning device shows up rather than being
silently papered over.

Happy to go either way.

Best regards,
Shengzhuo Wei
