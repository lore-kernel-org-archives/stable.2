Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2237B030
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042271; cv=pass; b=QtDD0Il5d/51NrzvPdyyR1PNcMa1tgLBMNuU3is1YM0RZJ2aZ+OJGH6l8A76tRxSDKzABQrTa3Z/SRdO6w+U094ub2LIakr1u8EuF+IV+/jrmCY7NfrXfL0b/mrG2DJ47XXDi3jWtYSOJeFyZTisUQH2YUb00sI68HzzWhFmJLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042271; c=relaxed/simple;
	bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1CD/tMjSbsLtrzViJ+MFYQOyW8GKNTQ9jUDr1wIPx6m+0to66m1y/FRqUvoGTlfdTJcBpiQjE9EVnQsZAaThZYK9A/YIz+bpk2rvUnwVMGsE1EfZp5WRimxjTDr7+lBv+1mpAJeDyKNzymuDbMMiWOerMyKh39Nhgtof8HisT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGI0BITP; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGI0BITP"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985fba28bso4355231a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790042268; cv=none;
        d=google.com; s=arc-20260327;
        b=CCHvKd3BZwZdRPn4Zf3uRjgjH/hPylDPdaGW5bSjd8QRHvxLPwgIjJiRhEUp0qNYZV
         6Vs6gguCukH0NDlXTJiPsw3kI87NBcH/6HWU79KjDNV3ztOEQHRHGY/yO/pMwmyIbOH5
         Afo9PsKz7c2jF64SOGrK3m09GXHWKFvPn0zoSz2YOfqmrNyhYfVlvIWuVNWUBKCqunI7
         4BzW6uB4FXIrvCIpsOi+FetPplypzpaaCV9fsc9ctpB9kt38w7GJwZOP70YvW/H99CHT
         7WUS5codXmbnflNt/cx6q4ID2wBq2GbvviuESLl0nnT5Dc6nCmWKzcWOYpH2mEV5E8W2
         gBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        fh=7FcV29QQoI3HCXj09DPEFEM2jSkZxbfRLUyWf7Jsn8c=;
        b=flVTayYINO7j7HM3HEUlYK8KNOIO/Q6/BWkJmqGVUnF4Fd+ErD8xYw1cb9v2Yp1Q0n
         4vtiQ3JX7+v2Ly6Lneysvq4zH45qIWkauQLzGris5pDpcm1H+eXNTcAUxxrZeoe7tAWL
         rUBkbbNLkupuB7QLSbQb9iiULTTCitFRkUJRvRjw/H71oqLMGVTZcsF6ZgFR1jSEnCEg
         bLUJ7XuC0ESyjn6iwN3lYUd3WVXU22u7o27lSSDzmyScFMiylN1TZ8ntCNLa94biNFAp
         5zUJj0Cy2NBWWCt3oP/iinAkrQDdfRXIV/yxyuLnbxwsos6JnwqGBAZTW5GENLyTKOuV
         XlCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790042268; x=1790647068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        b=NGI0BITP8L/a/qC0xbm7HZrUB1FhX5qvt3/58DbVkDoNSmQslwggSrJ4B6WAIuRrHq
         +fb/Oj+HxVeJ57uqvBgbbtCcTcE9YqLjHg8GWfhsAxh6rc1lxPvF+gJQZtPSNPPT1rU+
         eXlYrkqEScXOMJmDneUFwHwXyI1J8OY/8TFwyBCGeRaPiB22GPtqnCxLr6jbwiiBANCo
         atOrATWzy6hJfHRvLfzoxwCa1AX/WXodQiKsJVfXljILq3zvMqVPqmHHfS8fX5hyLmBv
         vfFGv7QiRc3FpXVjQJ63L0EEKHh0dzPYPhTsvpgbIg+dkKkZTogq5Z+ybRovjQWj/6gg
         XWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790042268; x=1790647068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        b=iO8kPtwWXESWhBM24D6oNXba9fUCqt675K9HYEjXfRTtPQnK5FwNtemeVhpKGoYLk6
         eXT9TGmjj0K6rnCXAaoz9vM6hLIrbB6IGTsmtkEFHGrE94TzX3UqbpvVm4P5PyIOZqFl
         H0M2WVhYWNEIevFQ6ZyBqhAVTy70VhBi5TXAR8gyyPkkqFIkWeKIYZHKvZipd2+TuHxR
         9XUsaKXjd2AEKsmW5BE6amLIG97KFYG+8pBAYzOFL9XrP/iltFhnpwmy57aTBvrPnmmv
         AQElAF3cUZhV/pgjfsHgCpAxzgWK8qscNJupy/fZ2R3ZLmg1fwrAsJ5x4Bl0uJVT9UVG
         hfhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzS52anQb3ILnjhBAWKISFZnPUIiNWcL8OGo8WgQPXokSu+kgENBUc84RX21EfVYaQagtgq6I=@vger.kernel.org
X-Gm-Message-State: AFuF++kBDY+VD5j8qx5LL4sZoIWf4D4TA3+jBOwWBHO2zGTbb5+p6HjJ
	pRvfzq//WAL4DTbvuevlbF+k/DM4S1tZgxiZo1NfQSm6CvHikvu0Ko4+0oNKpJ5V6B7Azxk4aLg
	8lpkdIw3qoB12fPiUEbKle7vw0eH1Tqo=
X-Gm-Gg: AYBFou3tG+iyP6v73+tffJZGZuT4/B4KjyYjRkg35I2jGqPrjPzMotJulWdp69qZc3x
	RVFatkuWuSn28F3zwCVrbsYBbwiaBn0wDZkWuebMtlGZKEpwaw7ZpEFlQ9l1GJHmrt6GfkmZYlh
	mAPXx4HAFVf6NhMMa1m74wJdQlxRtXaue7nSNWsdQ0KCZDgAC2BlVR5c5enWpBvHLDRL2KrV6cB
	yh2DryagoRSkDcoOFyP6EwT6z3wN5WdZqiWJnSra87QgH19X+RB8Vn2TU382srLZ6rvHOs6uDQs
	6bCaL4oJFUeaC22WGSBgfcVvGDXMD8Xdjn91oggf+tD9kVLbVL8qeDRYiubcsJB/KY0+e2HZt6j
	KPYKFjov4WGqe
X-Received: by 2002:a05:6402:1942:b0:6aa:a133:cfd1 with SMTP id
 4fb4d7f45d1cf-6aaa133d1e9mr802399a12.20.1790042267824; Mon, 21 Sep 2026
 18:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917153923.904124-3-bestswngs@gmail.com> <20260921154147.4e1e092d@kernel.org>
 <20260921155826.5970f028@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260921155826.5970f028@kicinski-fedora-PF5CM1Y0>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 22 Sep 2026 09:57:10 +0800
X-Gm-Features: AcwNN1XB1q8PoR7CFScqBTcECMNzsAWeNJ-yjmOWlW5xdCHggLWmz-bfJMhZfLc
Message-ID: <CANgPUi2JeO9psd1gL8Ym0k4DMmkzww0fjocvGN_yDi_9wttKPA@mail.gmail.com>
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=8C 06:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 21 Sep 2026 15:41:47 -0700 Jakub Kicinski wrote:
> > This is pure slop, cramming loops into functions which have none.
> > Shameful, really.
> >
> > Please test this and submit it if it passes the tests:
>
> You know what, I'll just post it myself.

Hi Jakub,

Sorry about the poor implementation.
Thank you for pointing out the issue and taking over the fix.
Best,
Weiming Shi
