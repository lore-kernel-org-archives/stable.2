Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C63672AF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836785; cv=pass; b=VFkZtgqFkTa/MjQ1WFjP9avPq4Pj7GESgKR6P8pDeNWzpARn0An/IFfQ4Kg2FJElUlwGwezCfmqEyrTn8JjgJcu2i4m9McfAnOUtgZTnDVkE+y/VN5SLN9UhzEI81uyCTtAk1Xpg+oakpZ843VQ4MPHTvbSYrlYRx+kpbWXEHLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836785; c=relaxed/simple;
	bh=EkvcFjeOIe3ZRu1wP7x5nrjhNbNxwdD5ryNryAjdiFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDT7dxcH15CFuyKd8uSscFzn4RPhpuliPdRXwmxJizp66TcPzuJCmTi9BQuPE/KE32VlP/C4IYxya2vX6WAENWm88LUNE2juM6I1fqj0ymUEEXlquIZpoaWxbs7lZmWIPpBCmBgCiyUwdtH/2R0HoB9xxnTKJhDKrv+HC0JYEb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=BMve6f9y; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="BMve6f9y"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ee88fce572so10137436d6.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784836782; cv=none;
        d=google.com; s=arc-20260327;
        b=L41B9rjJIueaNqJt4b3k/zyaqndbt2p9RmH1K0Fokn/Xy1iVCboUZieYVujh5q71fy
         AcLDpZLz4LhA43+ynu6S+mD6TUP/yilPtu0MQ9ueRuNmklmgtJzV99Ha4W8lVu0V7VHn
         zt+WpAAi1P3WULL2AVnUbBi+Dh3dsVoalqD4eCEehRMM6nKkjHzPWQ3tag6jiBxcU8tE
         dv/vqUBgFv8Rx08rN+BBMcAgy1DC7csw5DQtw8dTH2rYxw2K6uLVTqXvrfPOod6+WKuz
         1CHdyBlZ5tY4lAHc3qkidhGJb7DWZSdTViaHboKnVy+i4aGh6Wpynlsi+kT/wkumMUQF
         JaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EkvcFjeOIe3ZRu1wP7x5nrjhNbNxwdD5ryNryAjdiFI=;
        fh=xpJYi8RKlMrWZjrDdYr9rm+ChQNL7xIMrrTVlGhxx80=;
        b=fFXOGIhCaijlsNABlo7oGeF5QQhuqmnO3ZysE5vmHJlOb39RgMrO1dDmucKLnWXBZv
         Bgn3jEG9RKQAYkuH9EDFTTTmjNjJyr29GzyvP7MneLVyGJBXg+oaQOM9lXlC46ZuNpTx
         8WWWH/ytclO15xIwt9ShBgjulS+c/o/ydbHSA9nkT/mxRhBwYYFMItoWiTCUVJw1G2qK
         rs6s0Q9W9SYUjlLZmKtwhhH/W3rkj0wyYZn7B0z+nzbDk9B3k9+W8W1eud++cArg3EtT
         egf0ggo7WGD+ZAJa6kc7WEpXVLVrObYXO6xOnlkEmS1nuOKOE9K9gfmkD42DLlvgDQgv
         yi4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1784836782; x=1785441582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EkvcFjeOIe3ZRu1wP7x5nrjhNbNxwdD5ryNryAjdiFI=;
        b=BMve6f9yLhOTt2LxCRX7o3O02oV3dqDxgbQVabEsCF/bar0TwMLKGecWHnwypiu5jv
         WEm/sPlMZ90t5g2G07BogqR7Neiw1GA4ivf1ZlD/Mh9PP+5bzl7sW2eSetRJHXD0MIFk
         CSLEdVc6jp2qlUat5GAJO22uzwzCm3kWC+baXGeo5nLMWhBAwuHXGFhxSG8tJmAL14LQ
         Soml/eWnFFA5crlzjbhpNqZRPShEvgR6YIGatlxDh7DqF6SaJUAC2u6jGvWvkTTtNObh
         x0aBMzUtRs/Blw5SMqhaWccqx+oRdYLqRigY7UIaMXavk0l51H6I73lRChF1SXMG6ie1
         VEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836782; x=1785441582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EkvcFjeOIe3ZRu1wP7x5nrjhNbNxwdD5ryNryAjdiFI=;
        b=hnq0XykYoXh4xIXkEydHCOM0q3ej2s3l2XDp8DCZa2Exd1IjcKzd6wiHEXJ4I1KuiW
         talzxwgni/YfgRJSvvSjybR9c4YkITM0aMHcts4rwOvzQ89ieoxHE9pA2rqIHj0s8hGv
         YJoooP+v2D5nBBXQDE8CFwtWpwQjGk/HuJTRaiZqEaR4CuBW07XUibNb7SbSIhBquPye
         a9YqAohQA38eOQU0ZZPi/72SLgq9x1xdYHVDd+Cea102BDpXYRyU55PP+kP0dNYvZ5yS
         irb0nKGL3adIcdEYhCz0mAF+lMflRp+Vw5q3KqhXM3paD1SCq3KGJCHqn4v0KD0H1aZM
         dfqw==
X-Forwarded-Encrypted: i=1; AHgh+RoP2ARSferuKMWHmYpdsol7ApFMI5r7qnukG/wa+OUn97DZqoCbb7QnRGGx760tAgTT4tiZLqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhZo1aNlTLoFEmlqP8ktmYi9rNsbPpTOZt8wJSrgCAWlidnSF
	u8149PoCR/N5+huakYVcVyUlplt0RF3gG5QOptCVfLGURsQJe7TVeVR2ZKYGyX5+IWo+cHSyyED
	lq0r6pUsp1Igss1+Ss9Uqlvl6xGbjjL2a4ULLnBZmNA==
X-Gm-Gg: AR+sD13hTEm58jt8bdeg5Q09BcoelMoRq5WomTAdXpycxJg1JWTmbhp7hjwfufId84L
	6wIUVhzOKXcmTsOkUdIWI9XFESTye+p/KnAPH+HLd6S11myMcPUE8p5QuRVg6e40oLag82nMPHa
	aNpSPxj5WYjTWVN/DouCAcGQH+XvYB4fH7OvbaESuxEXNE8ee6J5ixm3AJ3vwecZ9EX70BsK/qS
	inwUVj+AODOMbek2YO2qnewRDLXsYar1vPJjKny9dSmuEa1owwA9ixdPbyt7w2nEO1aaRCfkKCx
	PYezluF7PeZ94I/HMQ==
X-Received: by 2002:a05:620a:414a:b0:92e:76a1:96cf with SMTP id
 af79cd13be357-93103879d21mr490727285a.39.1784836782335; Thu, 23 Jul 2026
 12:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13> <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13> <20260723-obgleich-kippt-gegeben-c84192e6d6bb@brauner>
In-Reply-To: <20260723-obgleich-kippt-gegeben-c84192e6d6bb@brauner>
From: Keno Fischer <keno@juliahub.com>
Date: Thu, 23 Jul 2026 15:59:06 -0400
X-Gm-Features: AUfX_mwzgei6zC1xBAQ0y_zogVAVyh98gVgG8DP7rT6lhHEdlwYJVQOItvHgNsM
Message-ID: <CABV8kRyp7EtTiuS2tBDY4EEQ1-VBq8GvsmUS8TsbnqTQZAaEbA@mail.gmail.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"Peter Zijlstra <peterz@infradead.org>, Darren Hart" <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 8:53=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Jul 22, 2026 at 04:21:12PM +0200, Thomas Gleixner wrote:
> > Unsurprisingly a robust futex depends on unique PIDs, which are not
> > obviously not guaranteed accross multiple PID namespaces.
>
> Fwiw, I added unique inode numbers for the lifetime of the system to
> pidfds some time ago. The inode number is allocated for every struct pid
> and available via pid->ino. A pidfd can be stat()ed to retrieve it. Just
> mentioning it in case this may be useful.

They have the correct property of being unique cookies but they don't
(currently) fit in a 32-bit futex word. And if we ever get 64-bit futex wor=
ds,
I think userspace could just mint cookies themselves per-operation. That
said, perhaps they could be useful for the PI case, although that's much
trickier and I'm much less convinced that cross-pid-namespace PI futexes
are useful or desirable. It is a bit awkward in that all threads do already=
 have
systemwide unique ids in the root pid namespace, but whether or not they
can read them depends on whether they have access to a `/proc` that was
mounted by the original pid namespace. That's why I was sort of hoping to
get the kernel out of the business on interpreting the value of the futex c=
ookie
in the non-PI case and let userspace figure out where to get a unique id
depending on the circumstances and isolation requirements.
