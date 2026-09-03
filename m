Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE74F7995
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457130; cv=pass; b=AnmkwubsvvOyELLd0T4BejhXwXjdarO3dRXDEuDS0gyf35lupXNMZsla950TZStg8OQqswHT/f82ix+bDSnHy2N7lVZmlcMnuFrx/5M6c9FUuanPrq16y0blzgcNpdoQaIZDMJ2NZ94Q+ULBMPXjbHy5Hm7v+nDBYdPNB42XgL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457130; c=relaxed/simple;
	bh=zKBNNdsqyLMqdx3MbX8O35nuXM3rEjpx39mqJ7Doh74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAdnzk1HOrFgjB1+tbKtypwzGEGVblg6AdKnmXh0WuO7y5FMQnsVGURK+h6/OuMjMEyuRSQJNOa3l+wdsECPmDNkZ/uSQntUwYPhm+Pq/1N7U3GbeXtGk4k25ARskWFDBQ9vuAuZMPv07amWdSBlCy6DDh44qI69Dlws7izCWwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmO8CTir; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmO8CTir"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398fb0feb91so7716a91.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788457128; cv=none;
        d=google.com; s=arc-20260327;
        b=XXaRjngu84NoNiPPfYAeqfOeTa73qq4+10QIWPU8vtlEn6OXEcDiFUjI6Zy8oHjB/x
         YKzIeLh1ackco5B/n/cZF2NDDKmQEW19UxJPIrilO0ZyWzMPghdIFFrYnHWek1rJMWlD
         6UfkW4DRD7IsVmqvqKPEsNNe+yFf0X93MAAuleXDkxXRiDMTp0zlEc5ysZSYTH6ZVZey
         qa9pHh+rbILwOYDoqgpSM0rTolV1U/S4H7M2n7MC+oqK2xbQs12lqnUsPTpEWuxRHBa0
         GtvKv1nHFWKhzsUbMaGnAqdqnB8ui+a4OVAbMWTkIc2uWVXO8A5plQZkjUr61KAXOO0O
         gkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SLPJSHj51fXIYeAXjqqrQGe3GA2HxKsHoycy8AT4Bg=;
        fh=Ay1e92n3dMM9oXzANqtc4L1BmClsC/aHMJMB9+I992Y=;
        b=OiCyKlS0HZDouzTRcVKRsd6q8pzWas1SftLAxACMycCyZXM7+++OK7l92IJmW4phh0
         a+D9ezind16ugpajfXb+MRajZlpR32h2oI1DEIqAFg8QWabYGuM/L31KYHgohH+fj/8P
         w84xzUJrHPDO+1oYzC+LJqTEOzeG7MakdHoXWJI+FHkGgYSwcTGpFf6sMINY96geWrkF
         KOn3D1yz64HFBjM8Dqsnw7C0TIu3NA6pBPUkmEQRowlrtpqshARPiBG/BMJYhupWHWtx
         QzZIujBcFR6WCEZRJTbV72w2vx1anne3S7ge/mLZVtl7Fb0FzsSh4WvSUGta17PDyJSr
         5leA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788457128; x=1789061928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SLPJSHj51fXIYeAXjqqrQGe3GA2HxKsHoycy8AT4Bg=;
        b=lmO8CTireiI3vRfdmLYnu2JjqcK0mmQFMYycxlQZvQKcxBMv7QofyCti8f/BjgCRSk
         0txyNRu/U/og07U4m+9u8diyHiUf8e83k7ogLbK8DL7iO547xbGaNdOKUpKgTMc/LC9B
         GGQgLuqwc2+vOuZRMHkr/Jy/5Ya9A6ygdNokKTFKyB0oDirgPbii4TID7956psSQ0htq
         ADF9nNFJ9JXfhttk0tqzuMLHJxasBmiwG1PxPOWsCujiMQR2DNx7JWZkeZarPL9GErl2
         rTM1ieL+ed9ohYg3Qt05j2Yrj0XLxgJaijYxtK9M6mHVfrUCa1cKvYUS1S+Hn+b6LS+u
         oedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457128; x=1789061928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SLPJSHj51fXIYeAXjqqrQGe3GA2HxKsHoycy8AT4Bg=;
        b=suu+GbUYYmfoD82STmSH4/bxUmQgTstUia1VLBQYda5fRe/UXGUryk8AgGn34dOPXP
         kj8LuXLTsm7/lsj1wRcUPL5sH6FFTXvNW6Wp5sEOUudHee0HyFiW+w0XQPqDfrASPgA9
         s+aOfjGGHQ3k0Xr8I0V9zv28tKJYUXDg/z2HFPjTMfKUtS4oSpi/AzRIdnAQIQN83SKJ
         y3ecfY2FFNMJzwnUjoU9MTDubf5zlzMBEpE1uQy3G56rdqORGGaHcHDErLhFXIAet1Oo
         KFLb0/1/xWqlTtDohfTATkAE+rXGoslK5rxqynXpDc0uFGT9gv1VGhxKJSeuWDy+e7xj
         +IvA==
X-Forwarded-Encrypted: i=1; AKwUvBxbLHpXY/Bs3nwj/s+6/z90oD7kOYnDOlkpSWdH78y4/2JbyZAX8yiMgklqYsxbDCekFNxN+GU=@vger.kernel.org
X-Gm-Message-State: AFuF++kl1pGHvMRvVARufOLrwNb/PBkRSInSKtdfteQ42j5imUaiyfSW
	CdnrmhVR9rKlGV/l6ISfT6d8wVXJ/+qTsljTd7ScPQR63w8KqtGOB+CBjNh1VJk0xNle3CcTqkc
	qiWJb+vJi1OJNInPGmkbho0F2utaya7956eWfN38=
X-Gm-Gg: AYBFou1tCHR0kxU3OhsIglLMJOn/gMM83oY8SJf/vhNaM6NiA5+768DCpzE50VXOFgc
	gW5Dp9HQhueRrPpiU/bMv7WhnJNzULphdVcB4dLR4mBXZr1O5lgPy7zL3tdI9PbyoYusiYkupQz
	jgPzJMXBeJm2BMj5B2q0l59nZF58NH9eyNtGdCQaaNUjacLbe87U4A0OMAqx5SSM1a74VA5Nfjb
	wCt03J+1D9lbambWmDpqXV4W0AGFpCJKs7n4zwV9n2DIOEyJkbluZnfHfpi8rQJkq5FBRQNk0im
	ZoQqtgEEtNjOcpJpyDy7qQsBavzk0K/8zJtM+mQsEeQTp1G6zlfkWogclF6KX/usmkUN3obO7lR
	ZT4Rmj3kMIATBR+KiunU9y9I339mVw+NzVn9xuuV11zPVRGSt04I73zCeSnoW
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr14134629a91.3.1788457126694; Thu, 03 Sep 2026
 10:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090341-uncanny-legwarmer-a899@gregkh>
In-Reply-To: <2026090341-uncanny-legwarmer-a899@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 19:38:34 +0200
X-Gm-Features: AcwNN1WNyEP_qL-1Do69ycbCLDCoZSv8y1W3LueEkrOnOErKOKIas157bX2CcTI
Message-ID: <CANiq72n7_EJDHnj7QRNTxrttuykOj+rs89gVQDuoLSukUKfT6w@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, aliceryhl@google.com, jpoimboe@kernel.org, 
	peterz@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:44=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 993f235c4af49d0e912cc28abe6d733531600237
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090341-=
uncanny-legwarmer-a899@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

To solve this one and the related ones, please see this sequence of
cherry-picks:

  https://lore.kernel.org/stable/CANiq72kmYx5GBU7VL3z8h3bAWB=3Dvw-TX+ptskDO=
0k3Ro-F450w@mail.gmail.com/

Cheers,
Miguel
