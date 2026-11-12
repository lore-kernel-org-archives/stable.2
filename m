Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522865;
	b=TGnWu0hyNl3hmHqczAEWiGUvK8YnlpMonu4VEuJ/y0vEHr5HfE/h4kMLFu4FZmA9PHgT
	 3XvY5rn2W47b1QrAQveWIbaM6Kn1EuUjKyBpVSSj+e+TDaDZI17WCGdu+YIVxIJrKD+5j
	 r5/yHIVwtnXMLz5/+V9Z74MVpfDls+MSx9YIXli4YiScPq6mCP/cAQPtJ2DXK1cjOYRMn
	 1y74A/x5Md0ATxqOFh0UGotR7AH9jOwUOaJ4Nov68fh1UhSvCQu51f/jey4aEs7SfjQu6
	 GCC/sIkcXGOTfX5/bm1vxKnNCp0UFIV0In+MUa9/u8THVkM8z+XKWMAaDc0hhZsVEtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522865;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xGWAwNDnbQAoH+VcWS/eK1bc8gnUFywi2IqyuToUcKQ=;
	b=ZNfq+CwxEBJH2PLRap7hHV1Zeudi3SeMUVkByq7ntqmbWm42W6lwu6q2VzZTYpjbVgbl
	 yREOKsuKSPAVVCfaG4Q+4ajs+3tMg2sUDA/szchOXxmsPt4O2gVC64s41qNWrndhcHVIE
	 //Gfcu3X7lDO0xxRLWJL6m9fUIIVyXhK+6TmHY2fpKCIECx50NdxJZ6BT3UX9rWLHW5LD
	 4pgzdsGltymbFscIXh+y3QRritgQwlX45uAC18VaGner/VT8Lrw7bjYEw9KzgptifBLBo
	 EzR+q7/5BcJ55R3NMfg/LiDgvLFV2eQIyQSu7S5SZdfvgCDdaYO9sLDKAZYfjyHsgaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2U5ZZm6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4F606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2U5ZZm6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8E41F000CB
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522865;
	bh=xGWAwNDnbQAoH+VcWS/eK1bc8gnUFywi2IqyuToUcKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E2U5ZZm6jS8B4+jl80YtHjY4vgWgA2R8mTKPHpxwuyA5oK9Q+ZugRcJ4NBriynvOz
	 hjS0onr5yTTyNLmulKlpnexs6WqMXTLzUQLAwP1ZNqIQg6I+aobsX0OXjWUWfcvH3y
	 lZJT+mIRjhEeIn5XqEMLt6fylWHq51LGTGUhcjnXW0s1jOZH6+LvQMKw/8Dj1BdH1s
	 05Cq0jyjtd7dFftXd984daBsEKn+4r6nsxhrc+NacXIU3zZXwqPhUidhfWBntT55tB
	 roT2O5nP875Tnmq5tehni48fus36Jiv9f/O7sZfWFe9IUNUCKvQJDNWD3Wi5kAXUnR
	 GS4wJRr6/GUdQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c50933bdf4bso20252166b.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:34:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEfZuQgkc+7j3Wek7eFqw+IvdzP/4qv/gkWpgBxwyNsL8GIG+teeXaC5aKi83xAnE2vSw/J8no=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BHifAJFBa/TCqSxS1ckn+rnmbVYnX5T0Z7+RIpZ6TJnq914XK
	UBTlD6OSoyMGLM0AU3uQ6LrYfXK6iYeeG8HF0Iy/7WHgd5X9L98eBx4ROjw8UR8oOMALx91xfIO
	oPk0SVba2C5mNczu5UQSGJ/nexSFqcl8=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id
 a640c23a62f3a-c50963856f2mr54017766b.15.1794522864032; Thu, 12 Nov 2026
 14:34:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112111637.184045-1-koray.fra@gmail.com> <20261112182737.1659245-1-icb@fastmail.org>
In-Reply-To: <20261112182737.1659245-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 13 Nov 2026 07:34:11 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8k8uTW_rLRADHz9mA5VFm2RZj1v6r=H+jEF95912XTfQ@mail.gmail.com>
X-Gm-Features: AclHuK-zDwCv6-7jAZ86Bdbg7IgiGEAgY_lu7kOXMxGX-tXuRmxUNiiyyi_ewJs
Message-ID: <CAKYAXd8k8uTW_rLRADHz9mA5VFm2RZj1v6r=H+jEF95912XTfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ksmbd: fix negative timestamps being saved to disk
To: Ian Bridges <icb@fastmail.org>
Cc: koray.fra@gmail.com, pc@manguebit.org, senozhatsky@chromium.org, 
	tom@talpey.com, chenxiaosong@chenxiaosong.com, hyc.lee@gmail.com, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:27=E2=80=AFAM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> Hi,
>
> On Thu, Nov 12, 2026 at 12:16:36PM +0100, koraynilay wrote:
> > When setting a timestamp before epoch 0, ksmbd converts it from NT
> > format to Unix format without normalizing it, leading to the nanosecond=
s
> > field to be saved (on-disk too) as a negative number, which leads to a
> > garbled stat command output and a reported +4 seconds in the timestamp.
>
> I tested this with the ksmbd code from ksmbd-for-next. Before the
> patch, setting an access or write time before 1970 with a fraction of
> a second stored the wrong time on disk. The stored time was about four
> seconds late, stat showed garbage for the fraction, and a query over
> SMB returned the wrong time too. With the patch, the time on disk and
> the time returned over SMB match the time that was set. Times after
> 1970, and whole seconds before it, behave as before. smbtorture gives
> the same results as without the patch, and KASAN reports nothing.
>
> Reviewed-by: Ian Bridges <icb@fastmail.org>
> Tested-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
