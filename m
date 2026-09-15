Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B6199920
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431213; cv=none; b=pxZP9p+byZ7w2s6lB6lWlFxs6PwP4piCkW2Gto+mzLdGDM0yIpWMLwebvErts9ArPHXTYWXC5CEdIg25PLLxfoaVN5Eb/0OE6BrPV9Z4uqh1Uup5uLLGIC7VwVrIAwS9jjV7pW9C9hML2zGx8rYs+KcR8SBE6ljKKaJLHa7En4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431213; c=relaxed/simple;
	bh=tffxmS+pQvVXbjcu/RUtQEoYjvL47ymfo3Dfr7HH8NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpzyaUdGSK24El8mQc8CsstJgDutCrEKGP/0LmTT9h8s85nUfkS0mJy3C1/cFm7SYJl7aD9HySZeAjz+qsjBF1nNnEAmBkYnWf0oDqb+gYbBE6UBYneoCIdQk9rtQXQ2kSsO1mfn558J8vFB6+GyG+yUMhzbmDmFo+i88SYKt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4som2LC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4som2LC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924F21F0089C
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789431211;
	bh=f9lytcE2XegMAYQ5SLE8HvilyIu+GNdT3bUJNdbNgeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b4som2LCxOlJnKyr6uV8vDbTQBCz2fAD2TyPei2hxoS9th9d+HJY4pJKBMN/2srdr
	 RNN1v4LmdHWQV8SgORm+CsTbDVJiCVcTNvbGRqRqCbhyS9it9svo3udtwvkqJG1/2/
	 VymrwGkUdEPy+hGPRmkGVUsyFsIe90gH5d4gLVrccZ4KjX1udtLJTaDzfOohdRdXQS
	 rJYhSI0KIPW2ympYcDsvpjoQKmT8kz0863torKF63r1z0+xxIwuoX9Hyt5/lkRVRpJ
	 4EK6UN8TSJUCae6TiKNks9X8XdakXuVutJbgr1lx59WE1LURk85rTX195YuVeztoQ9
	 rpufgJETBNsng==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so5553837a12.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:13:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwtfYj4qQ+YtGlH4dW5iRqOD6S+hW9VVfwS+ceyXwrrYcP3hE0cYq/RKreXHwSdslxZ2IZpRt4=@vger.kernel.org
X-Gm-Message-State: AFuF++naz/y7tnwUesrqT9dO4scto2G2a7VXP0vVm3iFBUtSaMNhLKDQ
	cxPI30Ctf6kvmYjy8/dMoqyyTtDOg+uD2FIqH/1YjVZkb5UhoryFvacczUg9oXg/eGed2mwbK0Z
	/o256VUP6VXA7QQW5PyFsEhz0m3WXV90=
X-Received: by 2002:a05:6402:46cc:b0:6a7:ee54:f89b with SMTP id
 4fb4d7f45d1cf-6a9f63d6a09mr2684095a12.31.1789431210242; Mon, 14 Sep 2026
 17:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914011052.809774-1-pc@manguebit.org> <20260914011052.809774-2-pc@manguebit.org>
In-Reply-To: <20260914011052.809774-2-pc@manguebit.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 15 Sep 2026 09:13:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Kz49C7ey4m=3BQmpFu8NMWibaf5YNcbgFtt2O+nJnEw@mail.gmail.com>
X-Gm-Features: AcwNN1WVavc6_pbK86jW4lMYnXaAKQH9A8iUc0Oa5nEv6VwB9RkCuKSEXrBXoyw
Message-ID: <CAKYAXd9Kz49C7ey4m=3BQmpFu8NMWibaf5YNcbgFtt2O+nJnEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] smb: client: fix fattr leaking on wsl_to_fattr() failure
To: Paulo Alcantara <pc@manguebit.org>
Cc: linux-cifs@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Bharath SM <bharathsm@microsoft.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:10=E2=80=AFAM Paulo Alcantara <pc@manguebit.org>=
 wrote:
>
> wsl_to_fattr() mutates fattr fields as it parses each WSL EA.  If
> validation later fails, the function returns false with partially
> mutated fattr fields that callers do not reset.
>
> Fix this by parsing into local variables and only committing them to
> fattr on success.
>
> Closes: https://sashiko.dev/#/patchset/20260906200517.725015-1-pc%40mangu=
ebit.org
> Fixes: 78e26bec4d6d ("smb: client: parse uid, gid, mode and dev from WSL =
reparse points")
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
