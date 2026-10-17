Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DA2DF126;
	Sat, 17 Oct 2026 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250811; cv=none; b=eSahyhtmClTop7FLSGTmXUAUDr/WKS2PFB0P80gC9aEPbFsJXIRVvxFXes+Pz5Z5fQEpJ9SieihsmCX84beHbosCr42SxihfFf08UE3W2XvfSfGHGfwpWPzH7wGBuZdX4qBch3wCAHQa7H3LHIkzEaoZJCMBGNiWYz7rRv3p/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250811; c=relaxed/simple;
	bh=nhakPVA8JKp3AZhT9iEwdgMEyGsXHRwczaW9lMZjvy8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WiQNVy9YF0fJ+PnbSy6weZerPuRAyi6eXtypdcrr/n/MbJ/g0Gix8r6JjqRLK8JN2CXz2ONPFPG8Lgs57sLfMfZcJM9Ruvh4iIpx5IEtrWSSFNRz+c/uGwiYWuh+6knA/1RF9bj/kggfGi832DvbiBkPsPfmcKJi/+eihjjWIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NH/RcBpx; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NH/RcBpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792250806; x=1792510006;
	bh=kmo73JZ+WE61AhRHhomKf0ebO/aZsMtxEPXAwuecSQs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NH/RcBpx+1emWM6RfdKcuVnzmPlHbEF6NMJITHrMiq1gUsraMux/0wtwVAzRhXTJ0
	 5NwiXbFnqtoQEGzV02SDqT6wHWvU4u9kXiFfnGZ0zPh2bvqf9r9YkxhsS03LezIdeK
	 2nTvu92j/s3+XHe1X4srAX9GOVhl0222HSsnGPfF0vSuNwilKZMy6iq5D1wkUfN9Az
	 xOxZt10eKTQNRY0dDmpQqoDu2dz/HA2UCe0tF4KeRa/XT10SoDl9lOftUCfdxEgvPg
	 VIpNqXsR91t1nPAVWWa5FZliYmfjpECxvH3Awv0KDdDP2XNkMCVaBjodP3cgi+Cjyx
	 CsObpZAw7e7qA==
Date: Sat, 17 Oct 2026 15:26:43 +0000
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Hungyu Lin <dennylin0707@gmail.com>, Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil <hverkuil@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "media: qcom: iris: use disable_irq() during power-off"
Message-ID: <179225079986.90879.14436056966495077586@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 3aa12eaa5299d896a99c8a45d83be2d7fb11d6c0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 Oct 2026 17:01:05 +0530, Vishnu Reddy wrote:
> iris_vpu_power_off() is always called with core->lock held. The threaded
> IRQ handler also requires core->lock to proceed. If the handler is woken
> and queued around the same time power-off is entered, it cannot acquire
> core->lock because it is held by the power-off caller. disable_irq() wait=
s
> for the handler to complete, resulting in a deadlock.

I hit this deadlock on a Lenovo Yoga Slim 7x (X1E80100) with 7.2.8, on
the second rmmod of qcom_iris shortly after an H.264 decode through
h264_v4l2m2m. rmmod never returned and the module stayed in
"Unloading" until a reboot:

  INFO: task irq/229-iris:2028077 blocked for more than 122 seconds.
   mutex_lock+0x8c/0xc0
   iris_hfi_isr_handler+0x34/0x100 [qcom_iris]
  INFO: task irq/229-iris:2028077 is blocked on a mutex likely owned by tas=
k rmmod:2030918.
  INFO: task rmmod:2030918 blocked for more than 122 seconds.
   __synchronize_irq+0xb8/0xf8
   disable_irq+0x60/0x88
   iris_vpu_power_off+0x6c/0xb0 [qcom_iris]
   iris_core_deinit+0xa4/0x1c0 [qcom_iris]
   iris_remove+0x2c/0x70 [qcom_iris]

With this patch on 7.2.8 (together with your iris_get_ts_metadata()
fix), 20 rounds of a decode, a pause of 0 to 20 seconds, rmmod and
insmod all unloaded in about half a second, with no hung task. Patch
2/2 does not apply to 7.2.8 or v7.3-rc7, so it was not part of this
test.

Tested-by: Birk Skyum <birk.skyum@pm.me> # Lenovo Yoga Slim 7x (X1E80100)

