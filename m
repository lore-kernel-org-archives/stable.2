Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355C47F2DE
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792249031; cv=none; b=QrRhRF6qwQEEyhMZMSV6Z8B4+3Px0lhMqSoFDtQJ4BHbODx15Ttxv7Old48Z/t/rb065dKLn8X+A6xIghANf/7jitklPlunN7Sm4fGokHEusyJGq/Fs8CVunfRMkbOlbzT9H6dUWBOgKSZNUgrxStagxuraGOkWjH/6iSUwGmuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792249031; c=relaxed/simple;
	bh=VuVXjvSr1R1tbcsWSH+eg7jtu+PhAtFidy4pJTRQtm8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mmc5UW8U26KK8aiOLH8RWzQIU2ogJvACvv7o77AVZTsUmueOS8oFGJnT5tEyee7aXCeIP0aeZB2pU8UtefWQjIDN+rvqfIm7jo29XceHHs12I8Tcc0y+C5QXIH83ArGhk630vonT2gBAf/4w5WcFo9sfikUBklXksNckywLdcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ibNnxq/Q; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ibNnxq/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792249026; x=1792508226;
	bh=mkXG1yRg0PCrEI5WMRERzginCLVDaIb+U7qUJ6FAQUk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ibNnxq/QCpHpC6RNFVFuZXVhOfFNsRjTVNnlR8qWfFLNVJLTKUxmXZRzgBAwRKDrY
	 srl4B/UO6+WnJhBMwfFQmxFT+hGSS0tzCiZ/TPzGtuXy4GwXSKIBd6r8oV/l042Uib
	 xbWH2xOERWjs73TxnpipiCsgKRJUCAkN1PhIRY9SP/3VEzvsu3Db/zrWo/kLXOhI1Y
	 uEqpeHnUL1eC0pVQ1rK8ZzV4I5lttgQ5jTqKZJK6xUPK/ddkHvUaSu46RAQVwVOAQe
	 9pleIdgcK+RdELxrsIR0Z3vuko2nm2PA3ZS3RQtnUM1zmNTV2ttnfpqrGmQWPy+RK1
	 5ZzlEmFmkLZTQ==
Date: Sat, 17 Oct 2026 14:57:01 +0000
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: iris: Fix out-of-bounds read in timestamp metadata fallback
Message-ID: <179224901845.60580.12634525576974095945@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 3a03eb28923baec3bbb5a7b3e37cf7d96ee9e64a
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Oct 2026 08:55:04 +0530, Vishnu Reddy wrote:
> If iris_get_ts_metadata() finds no matching timestamp in that window,
> its fallback reads inst->tss[32], one entry past the end of the array.

I hit the same report on a Lenovo Yoga Slim 7x (X1E80100) while playing
video in Chromium, and it reproduces on demand: decoding a 64-frame
H.264 clip with ffmpeg's h264_v4l2m2m triggers it at the end of the
stream, while clips of 30 to 63 frames do not:

  UBSAN: array-index-out-of-bounds in drivers/media/platform/qcom/iris/iris=
_buffer.c:932:26
  index 32 is out of range for type 'iris_ts_metadata [32]'

With this patch on 7.2.8, 22 decodes of 30 to 192 frames (64, 96, 128,
160 and 192 among them) gave no report, and the 64- and 96-frame
decodes match a software decode frame for frame, timestamps included.

Tested-by: Birk Skyum <birk.skyum@pm.me> # Lenovo Yoga Slim 7x (X1E80100)

