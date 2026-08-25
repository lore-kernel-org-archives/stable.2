Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5803AC0F6
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683600; cv=pass; b=INUaAPH164TIl8ot8jdYDNWcz1L5bjAYmVwzCND8r9m0/hYimU2HWicVgkFL19KpeUx4zwIRdt3MKVFgdZBZLpxdBb9tYvyLD4FXwKrAyjkn7BidhhpQjAP5TF4aDgFGXiRoiJ1hOAjpbAptdRlMDKGOj7swQdg7oNJRtf7nuOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683600; c=relaxed/simple;
	bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbNEuxIxvsvbZILRnBkn/sLktfol5Cw6e41Hx5LIKhy/XUYBi/cG/CXSOJjzkMqJqMFI5OGJQqZaq5yBYmj3jYiZFn4ducuMyvFnYQsFjN7T4RRS59zdf4hZCv/LY2YlWhY1JlboV9l4HJ3ykSm4CUh1NWsBNRBiBkuMRJkxLL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9KpAPT+; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9KpAPT+"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20e4487bdaso48209366b.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787683597; cv=none;
        d=google.com; s=arc-20260327;
        b=H6Zpm5rc/7sDaDn0JXJAeoRpv1Lnv5vSAG3Z2qXtcdx/XJPKS6xyiYUBk5duv3huh7
         WTrB+tk1KxM2JDjmG252P57jkoR/Lm4GH8b4WSaohJL9ERtCRoZ2FjFR6lyUp7SonuCM
         lcXFp/KcIIY+KcPw9K0+T/3T3/0uXHYlylktO2OY9d8QEjyEVEpIIwfyIKKQxarWqFNV
         bqmy7Hb23EfIZJjoBaEEiRnhfTShf/5OHun2GyUQO3yoDuWGBXO8uMJtw5nvTP2O+YqM
         /3503YV4BC256p6yXC9/sicYtODL8zle+SU0/aSO6UI8bKdhxpf8BZQkdF64mmyOUqyB
         xNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
        fh=fD2NAdmJRd46YZxwLCAFUTq72dASm1BftIYjiYzTbbQ=;
        b=lyU+rgg5VnTbkyuwuhJepWrm4oRu0B+Mv8Y4u2ab2lriA1iHRGSym10dOixImqRokR
         9HIxFB0ajzYIEM/EyKv7nS82xiT7mtBFs8OvAWN+gAZr19+y99vEBhIABVHzWar2P1C1
         dTRuQG76LdYGWD8aMlw+8b8nEpD4Ycb7cSQBCmKxVDB09c4nDOM5K7Ymbuxlpz/GEwXb
         gEcguMhCz7W9oZzUj0zJRtLQ+C3KGdkbx5Y9mgC865RCh+2WSWtZmIEBCHI/PZRVSygW
         j92kcbzjoN5sLn/FMSwmTMcfdNmo+J6dv6apki4jhuxatlDS1oLrT4aNep/sKQJM6ref
         9L/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787683597; x=1788288397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
        b=j9KpAPT+PqNtqTZML7Sbmzhi7NyRp+KYNrt1iMWhVlxBNM/BjQp7Y5RonSvuDEPUuT
         BhFxfTdgcGE7qgp1QLUUU45fe0aOYhKeTAR0ljTAw7c/5DzlhAkNElevxwhLPXVAm+GW
         5A4jS7UsWSi3llA1ZGInQLEEJCXMQqOvuIZmOBf4+JXvYEPCNUsIT8tlwXMawRAxvpB/
         4E+7NDc1AISawnnG/mzlyVsXJGhx+aMy9rnSkInGS9i6l7xLbCFxtyPhr4VOw50+Ue9b
         PisSwHNo+/Ot/0lxTwASlI+YwWzxEeXNErGj7rHwlSrBZedHQMo5+EgLpe4bTtSrK/aC
         6nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683597; x=1788288397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
        b=M2h+JwLJ6aZaOiKPZOF86kJzZcPhrtgyq4hmErYUQciJf0MO1wWgRbB/Y1TRTxWjcA
         V2lrwvKli63bGjkA5THbahgyugz//9AcjbxT9XuI2IfCgEAMQsz636/xY+5bjd83vtIP
         5AyMLxAUA9MA02l3FvVuXh0iHHsQhSUKDD0a8D0sWU/Oq04i2MkUNZJKqLXWSVo4M+gM
         RpybL+3sYBhFxYo+RGUTaz5xv3kRIM9Dwabp775RqOkFCG1wNkHnomYUfvNAK4A1xozs
         KCBqIzLKX9F0YhcIOh0IoNw+dA9NlWWiB/FBuL0z9unBwkdUhjsa0v8my+nDRIuNdHGT
         b6Dg==
X-Forwarded-Encrypted: i=1; AHgh+RqiSkwa7/D3VJbWo4KUbgxTfhSVa5fFOsn/V+H7Kr0oDE6D1f7ERRucAz0pKxqsv5FWBQkyAn0=@vger.kernel.org
X-Gm-Message-State: AFuF++nX3DZhNT7vzaInacapiHwQLofDAAW+o7MN7cp0ZZwlnTkQ9dN+
	l8iMm5Q5FF17piF+/Kg9iTi6Q0NZwn9rkWOckJSNj42I7E5pl7GixSwsCLOEmwTodBCiabW8AkE
	lyDr+mO22A0bf67FW2Jmmc3jP29A1Ckg=
X-Gm-Gg: AR+sD12rDf1vfS6IquFX0Q4gGkHV2q/k0T59xvjWw+495BafGnq1X4X++Y6GhcHToTX
	bWCRwVTXqKTLRcW35B0ZKDtaADcDj2ScMBq/JNwMFELVwwzE9asBbEhHSTt8siWE1GMLcKRc0fL
	dTYcMoyvM8AsA3h8MMe8VSpqLQ70z6f6Lp1QXX3lXTPK15Ny5BOB5YhxjO/9tXIp4ehBurWtXw/
	bw6mJ86ex44yKG5mUDflA690PMWAL78sRcghWl9U6jqvaVBkIw4UGW/LpIQXmFaWNwKFH2VGFxV
	QjgKyakvlJRaE3jZi3vrwLZTpXzy16pG2nS97FMDnhVPxaXnwDj5TsPOuvmjy+xgAz87OssoOj8
	=
X-Received: by 2002:a17:906:6a1d:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c250c46e2a8mr39875166b.3.1787683597474; Tue, 25 Aug 2026
 11:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org>
 <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi> <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
In-Reply-To: <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 02:46:25 +0800
X-Gm-Features: AcwNN1Wo0UdOc9O2d4eIjZGkfhUhoFh1uhDN-_aeGYC7cwhApQHDp3cnjINmNfg
Message-ID: <CAAo+4rXEQ7DbjtB4ZTUAm5Yg3-jKRzmWbH+gTfUF510PU5caYQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Tue, Aug 25, 2026 at 4:24=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Interesting, I though the kernel_connect would actually behave as a
> syscall and use it own thread so it wouldn't result into
> l2cap_chan_connect, in that case it is probably useless to use it in
> place of l2cap_chan_connect directly, so we may take the opportunity
> and clean this up.

Sorry for the negligence of the possible deadlock cycle. Could we
avoid the locking cycle by directly moving the session lookup and DLC
walk onto krfcommd so rfcomm_security_cfm() no longer takes
rfcomm_mutex from hci_rx_work? If we need a fix like this, should I
send a follow-up patch or send a v2?

Best regards,
Chengfeng
