Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308013B0593
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340077; cv=none; b=mcJ5AFYGOk5qu6zeRk3hMjHZamK2thJXEkFYZxukMCJ7n+hRGjVw8643mjciI5Z+jodjRfdkONt3ss7//gdtUMVcYpHaqUQStI37sHkhkFmRyDKT06nXDqx1whoDGEeFgKtofieylY5x2szYwIk8K/xR8i32U+nvQB35jZa+5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340077; c=relaxed/simple;
	bh=EXhgVMS0NxlxE5f0pFtmC2iT2ieedzhRX+u7Ni9PIk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzAWtqMq2GypzYEIrLFMmmsbTA3J+gtlQtlJlUM2cwIdjAKciRmrlJUHN7yZ4x41tbTeAzORfjFRGzV960cQiOFxi9tkEVqcyLZKYZaBETJxLUiQ/6jUM/GjtOOdFye7ijdVjyZAl3LmuM3NsN/nPYj85ozmBRzAAcCZjbPxrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y3NpFCR0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y3NpFCR0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso1546070a12.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785340074; x=1785944874; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fldeuHlUZsSgbof6A4RukHGxb8EkbZ80+aaj64d3jk=;
        b=Y3NpFCR0V57F56L9pDW8PbJ46B+ZIhiPUoD4ntZEYRWw6pydrtgh2ObgBXO7BK2EZY
         5Yse/kdvO13NaWi7WXXCF4l8wMho/d2UKgFESzpPMvBilqg+kWnoUrUGj/Uc6BRPekLb
         k1pmET9af22ltTaflwQaFHjoiaOdiakcmcpNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340074; x=1785944874;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8fldeuHlUZsSgbof6A4RukHGxb8EkbZ80+aaj64d3jk=;
        b=s42j3/rEn9WIeN6RWZOIRT032AQDFJ4mYQ0w9WEU3kmZVFENRyK+6WK1FiUirSxy+0
         9QtHua3GtGMNGZYEV1+Lg4p67eQle9pjw9bvwJUlYu2N3WvaShjM9QHPaIA35lX/5wJm
         +Z6E48epV311pdmXXME4CJcb3MHelzX0+KcVHxcWfU9fFuHdmZoHlTkdyciogIelFkbO
         O7qHxf0dcxQXgSMO++DLzcIJzH/l+wg8fK/I+9hZ54/SDn/DetRaKQinV40jnzu78xZj
         GY2edrz9tb3DUlf3OmnQrLJnGubTECsLr/Em7+gg867Af1nEnPlryE9sLxRjfXlfvAtb
         X7vA==
X-Forwarded-Encrypted: i=1; AHgh+RrO1TFqheafowei20YLU0ct6T3+T7LHCnqLORwCHggS91K9n37mL9Lh3NGwg3aoCKmwrBiX9vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYld0TBsRjgQKQi6BQz02n7biFHX5e9MO9Wpp3fEfhyPGGVYI
	QWIFpBH2TjwEkKsQR8Rq4mSsHJLALqUZTyjT2AkDnODZVjDhiPQK9CxaEFDtAn32zaHJUQ0c9MA
	oCAfrHWc=
X-Gm-Gg: AR+sD11yyju7ZzKn9tAlK6cyb3ANpXZNDFt2qpExauk/ii6sQnZnC9212uDB5sPN0fU
	3Bdrr9rGkpPLO4Djov6H3sQKka5gV8Book0Gi/6xuiwaW7cGiAyDZdCLeCruHgST55swgyWeAmF
	ViEc+aJrjPDpFbXj2E4qXgTd/3ZLt8VdNLJW6w05S7UVZFPhzzpWkikBkA3Xg/eg5iKsAY6QxGd
	7PxjiXWfJsSDEQ4tawNIgnvKL6fdTNP8nk6ug5d1Zy1VxbENFp0tTvZELNyhE0IqQ0SlvW90PTv
	4lJiTLsr4oY62IfdTVOd0s/DI95t69deIYJAyhSN3EyUQfvD3AfvZO4mnUA4Hi3v0bbnDITUv5/
	JkLV0VcpnGs7zACTS5Cj9W2OFZ/EVZ6wNcGWgYCcprkTiLn5qeIV2IJMb+acZRbXH5IG6A5IlgR
	jd0P3XQjYEd3961+zHvtsHIy8/5zWXW+Xzk2zKmxR4/iAptdZ2s9gc10IWzyss6u67/ATOYXmLW
	qJ4CmK0hLfukUyTdsW2Tt6XiAzI0HnOBKf9lQ==
X-Received: by 2002:a17:907:3e98:b0:c16:6429:a67d with SMTP id a640c23a62f3a-c1f727bddddmr437900466b.57.1785340074248;
        Wed, 29 Jul 2026 08:47:54 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83d271fdsm138386666b.28.2026.07.29.08.47.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so1088597a12.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:47:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpohyTyPYBtj4V6gGyPL07wwO2hQIy6i5ASZdmsHCs78GD8Q1ZdDj9UcIKZfNsU1+AbKBI5KQM=@vger.kernel.org
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id
 a640c23a62f3a-c1f7215dee1mr360497966b.4.1785340071289; Wed, 29 Jul 2026
 08:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home>
In-Reply-To: <20260729113136.32af2a4d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jul 2026 08:47:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
X-Gm-Features: AUfX_mzh3d70XkZOQ8mPTBmYgVx50lGXSyciETgOqHmLrGk5Ua4q2GHqtff665s
Message-ID: <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	jolsa@kernel.org, naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 at 08:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > Honestly, I would love to get rid of it as today ftrace has proven to be
> > > rather stable. But as it is a user space ABI, I'm not sure what will break
> > > if we do. I wonder if we just make it a nop, and print a message to dmesg
> > > saying:
> > >
> > >   "ftrace_enabled no longer does anything. Please report if you need it to."
> > >
> > > ?
> >
> > Thanks Steven, if you and/or other community members would approve such
> > approach I would happily do this instead for a few reasons -
>
> It's actually if Linus is OK with this approach.

The rule is always the same, and I don't understand why there's any
discussion about it because it's been stated a million times: we can
try to make any ABI changes at all, and what matters is whether it
breaks somebodys setup.

If people rely on old behavior, it can't change. And if people don't,
nobody cares. It really is that simple. That is literally the
DEFINITION of "don't break user space".

Whether something is user-*VISIBLE* in theory is entirely immaterial
except in the sense of "be careful, this needs testing and may have to
be reverted". So user-visibility isn't a "don't do it", it's a "do it
carefully, and knowing that you may have to revert immediately if
somebody complains".

So changing user-visible things is potentially a lot of wasted effort,
and needs loving care and follow-up.

So everybody should typically avoid changing user-visible things
because it's potentially painful and developer-intensive, but not
because it can't be done.

All that matters is whether real user workloads regress.

And please make sure that any changed behaviour is really obvious, so
that people don't spend lots of time chasing down *why* something
broke. A kernel printk is generally way too subtle - and no, the
tracing "make the printk extra ugly with crazy ASCII barfics" model is
not an improvement.

It might be better to actually return an error to user space so that
users can see that setting ftrace_enabled to zero failed and it would
show up in user logs. kernel developers may think that kernel logs are
important, but users seldom even think about them. Of course, that can
then cause even worse regressions, so there's a balance here.

End result: don't do user visible changes unless you really really
care. And then you spend the extra effort.

               Linus
