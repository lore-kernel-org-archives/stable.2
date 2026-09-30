Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C1353A77
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781978; cv=pass; b=KWO9rNyrbarhXA2FFGUYpaC2j6j5nLtEKtrrAuVex7pxRWVyXN81C4yPT+8xVtd7aTxO/CxqZt0h9bSOINepjgl142G3OVQho4Qb6LzlCCRT6M3Cv1fOrjMoWv6IxejWpSJ3Fx2r3eSezich8jO/ZG6SWmqT57ViB1AjATLaBaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781978; c=relaxed/simple;
	bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lpp/rr7crA78iHJMeMrwcZtcR5IfWG3CE3sxrttc3NDuHBY/2eyhtvrGk2SYJpFCrBh4Df9zk2klWRk1zX627aasHrZlUFO1Coum9cWE4OWvGs0DyZiOav5rGveVG/QH68QQCr+g3z+K+LaXKotLwHnee8fNlc0BA9ShHDQc0iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2l7/XlY; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2l7/XlY"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-343241d5d34so346760eec.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790781970; cv=none;
        d=google.com; s=arc-20260327;
        b=NHH3a77IbwY20s2qA62CLIShB4DMQTEMQiBEcdb118tm1zHpPo811mefgv8NlPHsnC
         XXY8Sssd+QYWWDehBpXII+BuLERxNnpLXZ6KTEzFmEPuD6+L7QtNs387u+DkcZfMUyud
         mtyoaFt6cgpGr20LyuqO89TaIMITdfk9eEl8AkvJ/d14AoRibSL/WVRbBVus4GKEAn5s
         DdmYeydUOodO8zCsHGO1eJH/rlNCaA7aNE66uY3MMTFfuNB4WJCX9qmpYZgG1kXyemrw
         UB8lv8A+6GcLvWxjZukr3nOw1K8KPMvRzV7cjj5WiNaU18sxqO0ZXDyvhwAgDbQC+nds
         PEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
        fh=UCWZ/DYD1nQlbAen5CPUS9ZzsR6TaLLp4XeA54OrqF4=;
        b=JrhI7mbN4pewe+qp42y2JESGW3IrOheG5naR5br55bGsUH9o4Ge/wMvlwiZi+THtYG
         yenUaLu/Y/UAAOhFu3oRVW41q9lvcR1LQtU0xK/R6xccY7yg2L6aPsPdRU+UOfqLspr7
         kF6JaVFv+CJfVL+tF85do0ui+b0O5eN/liLXIF333JGwm5nKTkrCCTJBzrQu2Pa0Lxit
         axcJUnaIeb5Pr53yzGlXu40/iKRbS2pvf1dqOd9IwRirB1ohy0Vd53f7BXIXH6h2XWk8
         ASFBOJ++r3TFkBVUTaGhkDURxix2kxOTobOGKNEXNsaKy2esvV+Ep32H7qR72gRY4H5P
         /kIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781970; x=1791386770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
        b=G2l7/XlY3zQ6NT95T4GJIABV70dQH3YXfhm4enxJMeipuwl+3j1XoUkEd8u8oHldOK
         esuecKKwebCbmzlTH9xuDG4FzzeSEAX58acn2Sv6Miqp0XhSDE5nU4vxFdfpDOVZZFRc
         LwN+K2QUSnmzMioeswr6m+PTzU01zYe1ikW/ZbHMWFZtlbNdvpl5a0gl37FJqtb0bRX9
         5g52nlVMtKtu4x6GY2+fQcJiHz85/rlk573rk9oNCNmlG4aPmR/XFdDVLgpw6NBLOK6Y
         5SGhhvCUzM97hK80rknNUoW6UjGSqbJUARHn8XvaFHmRFork3u6xX2D8znP/ZC8nJfjg
         9CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781970; x=1791386770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
        b=mFbNa1lt+41LiYSDhuNYtN258aQ3Ut8O/7Q1uEOvOVKi2yKcfHPCjXqZ87TdlQ9fUt
         8uFoc1+9NrYRm43fktKyHf8I6pLqrIbiUTUX5RQZ8tRyi/dz1iKyvyKlO/QVhleMWe+c
         WHrzQyXyBsJcGiDhYSwSQ5UDFsC14gaUD6DKccTgmm40CyZ+UCk2yGOlq8AhMF6rX6V0
         xaN3CVhJhQTPaxsdC98+aTU3Wuyf+XiEtRIm87eOzV2O3d6TQLhAIW4cxaWEEAiS/SPh
         iQAzbq8vd+Tji/R1v4CWkaCc0ZGzT1rWe+tyEo/tQa8wKFriEGy2MoubfjCo0TaiBPhu
         /+Qg==
X-Forwarded-Encrypted: i=1; AKwUvBwvWHVmPX2ZI9XedBN9hwXu0Z3umTVva+LMY7vdM8rMyBs7cC6Jbj1wZjBxm6t4FmkvgKZBs1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEL95dt3r+xxCsVcKcNb3iRjjPELcPNZlvwednsGLuk0E7JBJv
	fyJN5SCkfyYX5Wo2dnaWCTBQTJEqlvobOO/cKHDbkw0lwyRTENl9306YCWCDQxkEzhymDh14jhK
	1bV5LaIiwZMBBGknF8K9bPdphoa/j0n4=
X-Gm-Gg: AYBFou3EiyU2+w3Z4XhOki4tXm2byMwd7Z8INNvrw3BHkT+wu1+lJl/TDBH9fPxUxuj
	dGaE846t4Gvjd4uOzyauIUAF1VutQCvIaG7PV61UiicFu7NU15gG2fVFkAn1p1CwjTGtzvuEIb0
	A/JPYkPv99PdbhQtX/Z+ikXXDxYlG65QtvppWWXBMVKGyS/D5vmqF+Q933DtrMrRFkW/C42V9mV
	5uGgZiwUgxaU4Ah8+rWzN1MzgDEfkn/e9ZDgbwzCXfUeG/3QjNQMubmXYd3frb4d8CCGgD27OHi
	2dOdjcKhOaEE7sYifMOhedhSPuTX+ZC1GtjBwC91nZjAlWsV3tyiKcUkOXXhhy5k1F8NaHnLS1Z
	fwJjs58eHfb6t6iuA16LEZNwJLxXAhi448cXHNXeklgFrZ22iFGlaPt0+V9fRNUSFQOf0hA3JKC
	SjDs5FY0Cwxz52L+GDO4AuNh0vsF6CXN6OCUpllqYxnlJj8dfMsno=
X-Received: by 2002:a05:7300:4fa9:b0:33e:8552:6e06 with SMTP id
 5a478bee46e88-34cd6003e42mr3012710eec.0.1790781969755; Wed, 30 Sep 2026
 08:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
 <179068244058.1205226.1765319338142659278.b4-ty@b4> <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
In-Reply-To: <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 17:25:56 +0200
X-Gm-Features: AclHuK_OBw9tG-s9O8MtvXyTH10ESbf_7IiKq4RprYC7l6RRjV0_TwsAnU0VqBg
Message-ID: <CANiq72nFiT0EoL8Z9iPT3xcPWynofUAs4F2gb6-NWmUQmtBHPw@mail.gmail.com>
Subject: Re: [GIT PULL PATCH 0/9] Rust changes for v7.4-rc1
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>, stable@vger.kernel.org, 
	Priya Bala Govindasamy <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan <ytan089@ucr.edu>, 
	Sophon Z <aiqubits@hotmail.com>, Qingxiao Xu <qingxiao@tamu.edu>, 
	Malte Wechter <maltewechter@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:07=E2=80=AFPM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> This series showed up in next today and broke the build for me on
> various Fedora releases for aarch64 and x86_64; reverting this series
> fixed that from a quick build test limited to drivers/block/rnull/
>
> The full error msg is quote long, find the top of it below. Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/f=
edora-rawhide-aarch64/11055137-next-next-all/builder-live.log.gz

Confirmed, I see it e.g. in my arm32 build.

Cheers,
Miguel
