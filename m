Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795627172;
	b=s/EVfr3K9SzEYap9P3WHjOFDf8T+nYf/8h+4igz/CBIk0oKoLTI/DEeSTKxMmVg6Mh74
	 1Sh9Y8kLjfy36HdPzUSFW3Z+m1zqnngAMk2hqwfh+szdEJAQOmHR2OSKNPuaK0cyzNY6W
	 B9l1sNgO5IUpnzAdIaHtegeu8jSgyKjJ9e9mm8+q3Ld1wLS39QLHji1z6fTojaKHTxQv3
	 Zr/Co84Jp6FbsRGuPjeXAVfk+MXidFdzxPCLRayGLk5Munp3WxidhUgMJXFUdGmxhY9wZ
	 lXdMtUtCUAoTZ0l3Ro0SfdoMjSx4hGC2QJbqIxLKd65jTXRlLQUGzu2FCtDy2HDJkzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gtfKMOmu50CH2ZfqiXKpmGMmRETZ2ynWP++k2I5UOuo=;
	b=eBPGz0P6XG+o1hbGMGK5M6pDhzJhlJQfdbEtXnjfwteFA38F0Nfd5W/NjZJ3YqijYDSX
	 1cOmLpZQgoq7KPuwPmsUCQPF+qo3kcU1vC0Aa62dvM8Gv+Ry04qBWdwn2kQTwak/e9bki
	 wtc02lEaV08wXFUeSxZNtfMXQldfyi9278/tF3dQvIJJ9Vty9KOuuL9GTZfl00Xq2lp4B
	 e6RWx8fmsNZqt/i6Gz5hs8GQ+QzSNt3S4H2u4qrYOjau337a7JGQ3qDwbzh4g/0cMI4Qk
	 pYYL0PiVexSr1pMMAf5o8kx+sL7xfS307nVdFNlb4P2CvEfiaQ5YWiqH85ker1SjyeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mvista.com;
	spf=pass smtp.mailfrom=mvista.com;
	dkim=pass header.d=mvista.com header.i=@mvista.com header.a=rsa-sha256 header.s=google header.b="A8D/16Jh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56407606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56407606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.a=rsa-sha256 header.s=google header.b=A8D/16Jh
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-71aed54d4c5so3530753eaf.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:19:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795627171; cv=none;
        d=google.com; s=arc-20260327;
        b=FFvbn6TfTnbk6Y6RLa67uEEscmDdKAVz4nNkNGjNdikndl8E/a+MTiWVsncq+IB5bO
         y062F3+MJ6EkAtRy8pfMuf/5zBxGwFhA3QjxkwxOl0oV8fSRoG3fmBqSSdij++cZiTZX
         ffzjDlWzmk+g1jEzSyN1IHYoBmrZr/3h1g0Sa537gkF3qZpmaM0jwCs7LTtkycAoa5Rn
         r3W7IIXERewE3pHLh4YopzrhWVrUANwkH5i/IgGooDPX5IHfFJP8/U3eXPr7casQ0rFl
         nGixBRTEfPswE/WnScm0qtNstSBFZNr8RgRbQfeLYFu6phBkCv7UwNtlqwXoLaxJn0fU
         ASoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gtfKMOmu50CH2ZfqiXKpmGMmRETZ2ynWP++k2I5UOuo=;
        fh=m1pZWZB/5Jfxk0L2kn9qnc8SXYetTw8DEh8YxMMpYng=;
        b=KFx/oOyHWfnd7/yX8GZmj9K0WMVrOALQ1LyLYgryTXaOMJQuqg3wcII2qoXyjhQiXF
         SVm1MHidIrw7A7m1CwxtBT0UTmQIixD5XnWQG4NmImovljwgjedh3pmy+TJzVZIkLkyE
         nwchTqLXmUyq/wjZjgSHejZAaoPIQk+jVPivPrj75AfF/TZ2vXmltQXc0RBk8n6b5slJ
         W3tBT+7A8+AAQDPZVnWKsXFe9jwXF24lqgz1oEykTIRcytINJgGnJrKOptwM22UrPuTY
         sIXIeeSfswTaxnbIh4Woo5q7Qq18NTiD4Pu7D6e3mgb3KM0+KcALJX1Sl+935cibOWLK
         QvAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1795627171; x=1796231971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gtfKMOmu50CH2ZfqiXKpmGMmRETZ2ynWP++k2I5UOuo=;
        b=A8D/16Jh2X2r+VAttEEEyGth9vb+pBD9nkptar5kmgVlDYbNzT94leTwMU4KnrcKUP
         sfF3t63s6a+f3DmA7j1TZb6WJVf+IJfmJVuVa96S23FBJm0DgkDs58YrcJoiEyDJKnne
         1iNszPmoXGSY6FgpxS+kYUMSz3YAYByIkL/1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795627171; x=1796231971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtfKMOmu50CH2ZfqiXKpmGMmRETZ2ynWP++k2I5UOuo=;
        b=GcaQh2KIwCYZ80ZArA8twnfcsySXy+SNl7T3EOdytt+a+UTIcRbqbj3WOzduBWWlZY
         sSQgmZvMIZHsCFcpPNpR7lEZw9e+1sk8UxEo23DNVoLxHoUO9jq37/5jZAncdxKZzVj3
         wHXrJ8DXqZadQArw5u+VlmDbBNe/VDKY+Jhl1+aXCDgAsW96EKbPIfbuWWe5KlACTfhi
         yZxvfogr6cJEnxcVUbEqRYRdK/MiYLIbxT6YOdvsM4mpw3ggP3uLu0UvjzmV0CeMOefH
         IKTM7rQNhyPW0IBi2ptVArprXJapiO7JbIPGVF30ONiT4fF6XPIcOfrW6XnZjl7L2nx8
         7CCA==
X-Gm-Message-State: APuU4Z/afheGaGul0jF2wHo/KwpEvvovRMMJgQp7IJGHjl3JnCkuJB6s
	rCWWXyNAa/c5uqbQEQyl/A2ZE6YdQZiM148dsZXutaDiQZSWRIiDiL7W356roUOK13JXVONgPYG
	OOwFwh9hm7U62CH5Tv/bYUraZ75dmwDhbMrDOLwuhtA==
X-Gm-Gg: AZFdTZdA04y819zoj2ztqFL5Hn/KIcy6bNIGZZ+mE2GJ2kOd/uOg/R4wDp/CpRAb3s0
	+Qs4T2lkPCHwlNkDebbE5x1yYtVlOx9p30ykpxbeir9Esv7UcNQ0BOxHlnXKrTmQKx2nce1dOwG
	msb/WrFgp3crG8U0CFCeXpWw+RpSUneW0ZGLU/vi3bVGtJUMvnGqMedbLVUggD2hnzdBJLaIQd5
	1Y024NBeaPQXzEbAyOzE16cK98mfhme2D3Yfva5eFBh5/L8IKswpr5fFT2V5MMWe0EfciQ0p8QR
	H6iLqErD2vZpeLI+CDiBi1tmHRJDodGYbE2Vo7aYI8BQDWNeqZx9cGKbON66I6CITYgGFw2OXbd
	HWUJtLX96IA/qD4V5TMtTNSdr2w9zNRekw2e1Bpv2NNHj1UqaaUsTAYhtb+X6zoEyQ4wMAomr+f
	PchPD3+dNtfyCaiYPnlNUf+EHC
X-Received: by 2002:a05:6820:16a0:b0:6fb:171f:2bc7 with SMTP id
 006d021491bc7-71b39299560mr15555338eaf.4.1795627171168; Wed, 25 Nov 2026
 09:19:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAH+zgeGo9V_DRG_2yRAEw82bk6SMsV_JRxSOM28p7q02oTKE9A@mail.gmail.com>
 <2026112521-paramount-panoramic-2531@gregkh>
In-Reply-To: <2026112521-paramount-panoramic-2531@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Wed, 25 Nov 2026 22:49:19 +0530
X-Gm-Features: Aa3M54oP7oY6OU18UeiY_5FtujTxx-01ifRRM0x8BO0KGlycTILhNyFLP02VDSk
Message-ID: <CAH+zgeGEXm2crJT+gENkckm0o2xAACXHj4Lf4vxTD_nUXij4Hg@mail.gmail.com>
Subject: Re: AI tools for CVE backporting/Fixing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, cve@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Nov 25, 2026 at 10:23:33PM +0530, Hardik Gohil wrote:
> > Hello All,
> >
> > I was wondering if anyone is currently using, or is aware of, AI tools
> > that can help with backporting kernel CVE patches or identifying and
> > fixing kernel vulnerabilities.
> >
> > If you have experience with any such tools or recommendations, please s=
hare.
>
> Nothing special is needed, what have you tried that did not work?

I have not tried any tools and looking for recommendation particularly
for kernel CVE's
