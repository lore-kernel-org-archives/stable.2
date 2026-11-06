Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971053;
	b=ge/+qtzXa1rRIAKlHu6H4e0I4gJg2LPdTG7UEfgUckcIxhneMti/G3BQ4lNR3ACymBAA
	 v+EUclg8sENg2nL3QPyZoSOouymDdRWG1tm4KbF1lFGLE0OXULkepVkuQQGaVqvyYmPrE
	 irG5RmC6RxnTe6ZIkzuqhMm9hDcT61BpbZYT8QOJbgPOOz6K1KBP9y1cNnHEGh7qME96Y
	 gHEZCEmt+Q3LsRhp79igVsTC8glXvSMBBnwdZfkawa+AKQiASaNUWbt7sT2yUtNa+Thu5
	 EAJ/6RXDTEl61HLHt9uHH7T2dqBPmBLnFTwCFgQJ6MqqzCXR1yn8Xq2Ju0+eVQoON+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971053;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u+wf99cMGcQ0pMiHmoB58UApKCibH+wm8RpTNlP6OIw=;
	b=MyXILZVpblLvoCfFgGpwDLNjt1UYUGR/ka05N24zfrBwrKA321t1Cag0jThekBhF7OQb
	 IRtKDUgR8D12jff/4HstMubjpJMiBizRgiBJ6voMp8QC+MTE4O4iN/Lx2+Qnpo+qV44d1
	 GDIXpVI2G9+bNTZlXM4WkzdyScjjaiJPtfH6AortWw6DkAeni51O145ta8aGpwCg/Ckxi
	 3eJfc3MNso3xp7cFIvUHP9rmm5wznHe/aMnxN3Bs3iTagH0QZUN3Jvrz2MC/HcfGLluct
	 Zl+5u0ZOraPk4mH/Q5NaZgf3doI3uxPnk6KqGWbW/9xv2/yaK+ScdWtmfrXOJivfQiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfynEgaF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D0606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfynEgaF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEC21F008A6
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971052;
	bh=u+wf99cMGcQ0pMiHmoB58UApKCibH+wm8RpTNlP6OIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GfynEgaFImZ746mES31pK1q7yEqfdXB+ZB4yDlEw3Z+sSnzAzz6//XKUgnTJkS5Jn
	 4AeE3OLN5vWpvgn6+hlRCbOM8V962ys2bNlnO8yb7Fg4MHR40KPWrj+XXJOH2kbsdc
	 C9TWWQAa22FJ/icts183MXcedtUP0q+So1USkbpUTyJLiAdv/kSLhlWAYB14mhQ18a
	 e8W8RVQ0ur2g0VI8OW4io0HO9cpCBP7gcsZdViZbuT/ebf9GGBg+vIzLSY6jXImDi3
	 zooBz1gt7JKIsTEvMQPGB7w+QVXRHdi4/7RFmH6S5IhtkEcAOJ0grIr5VXP4Ac+i8s
	 5rnTXe2nEGZIA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso456302e87.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:17:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByjUQclFdP+gh6CSwjIsv2K9Qlz3hkNkcurAooe7PrtHRdIB8SNWrOkSf13sagNnNYRY1RcNFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BE5kDifsfW61oA5L3nC5LrhdU0if7+P7n7h5tGhARV0GLXd7G
	GU108TQHLwvuWVLdnv7E2k6qSHrOsVxIfIBm0U5/ho3kz0mzRGdQBTfLHBoEL726uT5aMQNhIyu
	iOe2UyMv5ijcxQKoocoAYUoVDW7qTAf8=
X-Received: by 2002:a05:6512:ba5:b0:5bf:fd1e:1677 with SMTP id
 2adb3069b0e04-5c003c088d2mr846658e87.63.1793971051040; Fri, 06 Nov 2026
 05:17:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-pinctrl-qcom-uaf-v1-1-c9cbc0a93161@oss.qualcomm.com>
In-Reply-To: <20261105-pinctrl-qcom-uaf-v1-1-c9cbc0a93161@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 14:17:18 +0100
X-Gmail-Original-Message-ID: <CAD++jLn5fT=DuVZkXQdW4rM7Td46sKAfBxUkeYCrYhGj0KyHUQ@mail.gmail.com>
X-Gm-Features: AclHuK97tULkimWCed7he8xYURQ5GlgGYoHRoVb9Wa0-fs_u313mHIyxiwKFPhg
Message-ID: <CAD++jLn5fT=DuVZkXQdW4rM7Td46sKAfBxUkeYCrYhGj0KyHUQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: fix a use-after-free bug in system
 shutdown path
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Stephen Boyd <sboyd@codeaurora.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:09=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> msm_pinctrl_probe() allocates the pctrl structure via devm_kzalloc() and
> unconditionally populates the global variables poweroff_pctrl and
> pm_power_off.
>
> If msm_pinctrl_probe() subsequently fails, devres resources - including
> the memory allocated for pctrl - are automatically freed. However, the
> global pointers are never cleared, resulting in a use-after-free during
> kernel_power_off().
>
> Schedule a devres action clearing the global pointers that runs before
> the pctrl memory is freed.
>
> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/bug/linux-0c3a18a4-3de8-489b-abc9-e9e3a8641=
ed2
> Fixes: ad64498762dd ("pinctrl: qcom: Hook pm_power_down for shutdown supp=
ort")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

LGTM
Reviewed-by: Linus Walleij <linusw@kernel.org>

I guess you will decide if it's an urgent or nonurgent fix and
send to me as pull request.

Yours,
Linus Walleij
