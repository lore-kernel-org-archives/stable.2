Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793742115;
	b=ez4RiPNAJyyxLubMXpJoaa8L9snY8X9cKDrNFbW6hJKyyzq4s4atJJ73cnEDDUc3L7jA
	 Fz4kMQLRBGNhRw3/zuwosLRKaxwJC5+s6q4igFFGAmLDwYVnX47smDXe99Kq6W6msnjGQ
	 CzCIuhlH1nApHoG36u7eXubjWaHGd24v4p2dVe1rn3wstTHsl2jJdkOl7VUl8uNbiARf2
	 KH/sudIK1CNTJwOg86ZmujcVLhjuq/yDGdaD1zs8GoqmvxWGZw6iRl1iLGjTTA5ASbOJ4
	 6sLe+RQUNfLKP8jxLJI6CMfhzV4l2qP0ahs/p8kswpOY5NDYWNaArPiUFDN0cDDe9yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=KCOOPH9EoiMG+L5AFnPDYrfGK8mdFww7XEnRsLZL6Cw=;
	b=yeVFzfh6ZAEDVrwXL1lYtbimKc4fEW8eW13AifPfHvqYeqA8K+cfXDCET/ahRbwAZNu2
	 nXqaNLB+GoB/UVpxDm/bTjaPxDn88xS1pJU1P2SB+LyspXJpOpQkuGSrqVmuJFU8avZxw
	 d4K0WEY6GR+iwemfL3L8E/Ej0za1Nk9yjpdVFldHMcWaELcvITaMI1ZeMhbjCkt5mfOr3
	 kPp/Ohun77wpWtlsa54UuJqvQ/9zDvVCQ/w464qdu6Q8tnW/LCQrH5jHm//QL50Sz8H30
	 DkSu9HdFvyXh0uJHgr1H8bb1dWN/Gvk24IfnZHyDiWc1vlnQ6rhQ2j6UCdnCCKrPsAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=utTW8N6h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BA606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E34BA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=utTW8N6h
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ac9d666d4eso572467b3.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 13:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793742114; cv=none;
        d=google.com; s=arc-20260327;
        b=EY+k96Qvg1cENDI0dvi1XLcfsNZcCuHZjcCSJprkWYt9dMFBtUMRlJLPsIZU1vWXat
         xrVcDiI6qLZJd30lZIIgn0hXLqGAxDtXP1AUoLbvsE2L1jcmc/i5k1qYh04h9ZzEhz91
         5uzmr+rATbs90kDT48KoWlQEY9ENWfsTXG1f+GG1AmAGqzEoirzSMcwIZMquCK+KhmMy
         9U1sun7YzBdIaOOmEDsiC6bkJHa2kiTZJ/q3A6yDb4DzFD5gOBNUlKQ+6vISVo5a0TnX
         9qKXEDi/qXWwV88oSzkCSlexM3wgA6du3Z75QfJBpdEoHcqVz8rOJl7iEOdnCTo3rbbE
         ig/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KCOOPH9EoiMG+L5AFnPDYrfGK8mdFww7XEnRsLZL6Cw=;
        fh=noA5WXW3xCA5quOVXmR0r3ta3Xxk7oM/iH7AxRGpnlM=;
        b=g2z0A1qCnjQNQnrjHrEbV9jrQJ2ujh5cSdCX1HRY16rtEMl1bYwDyBE7EVgFaCBWzG
         AX6pNQi2a63eU4E0bgXF8vOhNFPdAJYq6Tl5ls6c08K9P9DZc+mb43DxqvZs6TBc+rk1
         BNsCljKyHiESwcCTgiJS9XMx4lvZyFn+buREv9nqjx5zY+cxdPiBqln7eI3Ya0l6eQ1w
         Zl+L55Kg3zjLaENlcs2j0InKcnhQtbAwx/6KYBBP7WixU7BGwuLj7TS93LdgMsumdNNj
         ATQH6Hvu6gRoDd46A+crsA2byhCnVSf/uRgTALKo7GzqaTVZBvIrqyLnnlPKxyOukvhU
         GkmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742114; x=1794346914; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCOOPH9EoiMG+L5AFnPDYrfGK8mdFww7XEnRsLZL6Cw=;
        b=utTW8N6hoLFJa3OX9Zm8ycpNLKL+FZRDww6xotWwXCKnR8AHOVJxGZ3WoXofwVHPUj
         v00EyWdbbrvmxqfYdIq/JkNGI93n5o2HtXPPjfiiZoKaIDezYrvjI1KBkQYY0Q8Is6VJ
         3IHXnGEvh4iymk5jBoDaTnBhiUT9R0+yCCvie1ouKEGf34ALqAINQLAcoHN3beWU7Dti
         dZu2opgpUW8x6v0shumPnF1nJoJP1h1b1z9sBCJY/sTJp9BnqS9yXi5odgZWerhKYDpa
         pCPCNk3nVBOVGHS2NSNIv8sG9nWt2jAdyEfkOIuYXB8J+VwKVfHaDb6MH/YDU2tXR+EP
         Qncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742114; x=1794346914;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KCOOPH9EoiMG+L5AFnPDYrfGK8mdFww7XEnRsLZL6Cw=;
        b=d+GpQ32FDSuhwISQiU5t2uFrUOh8J89Pd/liBoneuCzHf8bAs53rxX+IG3S4fmkKx+
         P0j7fd+lqtiyw/jQMDkXm8PaI7GdISvEPwKowjeVM8VeFxxeW2+p5i+yUv1P7Rvf0woK
         81w/CU1h7t1jFSj+yU1eUPLcP4NaHFGolS5imG2MD9Kz7qoplWs/6O3bnSkIF/6CH8vO
         4erjzKHRNWA92W0MvKzwFRdquO/tdYxDp7CDF9FY18gARmUsyMguHCfQj0MKYFO8ezB7
         F05Y5zDIyzRWw3MrXYM+Kt1xPTjD11NkAkqmO8+tKrT9X0FCruuKNdBFJ3UrvUjkEv7S
         CxxA==
X-Gm-Message-State: APuU4Z+xw19yerNMl3/JAOl6He+h0CF8cgv+o7NtYOXY7eYkUxL13WEd
	H2yus6Kl6cgcu4sqgEfFzOfUydfohVTaEVg0LnXN3/UNQ+RjU6KOYlFUOwTStBDfNzTNREetYCN
	ZidB8cqA7I1zV7K30wHgyELA6Ey6FZvw=
X-Gm-Gg: AYBFou1A8C8qi1B92dk0LscpvxtvubKATTv589XbP2ShDn6rbO+9gO6KSSEcoZ8onSI
	kH6x2YZiIBmbjfYp11QqEHQ+LGdaNqeXu+9ymaORpKfOgBTVUV9fMsLr1d6015ZZd2uuqUMZPwZ
	zz35wZaVhCK/JmXy6YXEtWHSOCrigIVDSj3e7dpx85vqI0EX/f+lI0mf9u+JnP+3FhHKK1tHi6M
	SoUr4pfv/sTxpdQX3quXUPYlj0BWfBxRqfF6ATg5H8WcDYACD40vRz2FfOuCtROB8TfL8kdRfzS
	o3uxjx+Kj98te9pa6cfNWCCCz7XpZVtX7h5wDJqlEyMpf/T9IrKiV1xdntBv+zYTkzvp1y9ufvH
	mCrVA3KzXNBr863YJ39trHWbNlpd1Fg+ZZEzRThWYeU0h/SFPRDKlWmuc8P/PS9E2VRLIZIDCSO
	N/zOv1QJexELPC2oyriouRKJED00GJcYmq6uNgKT76D9R9RD1813uK/qH7R7y6mVKfuPmoACMyg
	F3CSvIl
X-Received: by 2002:a05:690c:f96:b0:8b3:7fd:6a03 with SMTP id
 00721157ae682-8b307fd7022mr6881287b3.17.1793742113870; Tue, 03 Nov 2026
 13:41:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102201410.55089-1-sidchintamaneni@gmail.com> <2026-11-03-1-daily-reply-0011-re-smb-busy-dentry-dio@kernel.org>
In-Reply-To: <2026-11-03-1-daily-reply-0011-re-smb-busy-dentry-dio@kernel.org>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 3 Nov 2026 13:41:42 -0800
X-Gm-Features: AclHuK_01ZslCkwhHMUTU4pe2o_levuSAfGqJ69o96WTPIQVW71HhP9wSgxG42k
Message-ID: <CAE5sdEi4GOXeVDPEUk-RR7bjE8z=25f+waQNedMQd6VCum3TrQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] smb: client: fix busy dentry warning on unmount
 after DIO
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, wozizhi@huawei.com, 
	lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com, 
	glaming@microsoft.com, linux-cifs@vger.kernel.org, apais@microsoft.com, 
	rlmenge@gmail.com, hargar@linux.microsoft.com, pc@manguebit.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 06:52, Sasha Levin <sashal@kernel.org> wrote:
>
> > commit 75f5c412fa867efa0bf9b646bffe0d912109e84a upstream.
> >
> > Kernel 6.6 predates the netfs I/O request conversion and instead splits
> > I/O across three reference-counted structures that each hold a
> > cifsFileInfo reference
>
> This is a hand-written 6.6 adaptation of 75f5c412fa86 ("smb: client: fix busy
> dentry warning on unmount after DIO") rather than a cherry-pick, so I need an
> ack from a cifs maintainer (Steve French or Paulo Alcantara) on the list before
> queueing it. 6.1 also has 340cea84f691 and the same bug; please send a 6.1
> variant too.
>

CC'ing Paulo Alcantara's correct email for review. Thanks!


> --
> Thanks,
> Sasha
