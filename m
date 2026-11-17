Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942743;
	b=d1FpQsDpIzrCsVjvxbvwmVF/h+veCZCckVAm21WQX1U8lhDmFTD+qDTeF0JDfwmDofDi
	 5D7mooiS2JqwTV6B9b0cUVW0j5tnHaI458x/79lwgp3CXMj9mglYB9GvkCNoGe8CpNuke
	 hse8Q9UadEuEFQN1Upl9FNzp3TwKLSD+aUF9prvXThdyCtas/AwE6LP8CFbGvIGSLDIh3
	 UDzCu/iV6gztT4Urq9vJYm8bfCSItfmIP+Ycic49+/9TpTXaLFcOfNl+9OZarvqm+RGt3
	 NKDF/BQFi7sUuebVKILgjego6EIewmDaqKBymSROU6Dj4lgYplgU1lGE2+PX4YrTANQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fEyRTCIvFn0qfVWEf26UkSN1N6cLWQriDiBDA0wCb/Q=;
	b=YO40BEx1wAJ+guz4QV7jpJQ1OAk4Hsh+79Xrh5coACyfP+NlUbLfVFK7BgPJ6Sh8HCB+
	 /fkGJ37cmRrdcUp2/OzjIAUlf47UPhX+asOL+sCq6EaFKjfnWOU7Jv2aTjxcRRCG88xFQ
	 8HQjlIQZykYG4ZfjpdKtL83UmGnqNFwHJ7clnhc1Umzqjkq6M3BjLchLQuI+Onn0WpcG+
	 u7phBv52d1yFRkH6mm/ifLINRYqZnlX3opnjg7KwYEtWO9kyP491BmjS09GgIGEPZx9Pr
	 nhOIIF6oOnrQ9GxlcjuyjZH/G87/wbsVXLaET8oTzd+ZISDsI83onwYN9c1en/Swm2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=C3aPZAG2;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248A606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F248A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=C3aPZAG2
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso6473266b.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794942740; x=1795547540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEyRTCIvFn0qfVWEf26UkSN1N6cLWQriDiBDA0wCb/Q=;
        b=C3aPZAG2dTLoBFYlxxrQq6KwJnmdhms1ucgWVIjZ02zpCV2jhSVlbpMpZ1cXxKCqhP
         WScDxiriOBEoyPYHx660SiQKdRU4kGvMXXUAu4XFNCq+UNP512t5U5F5yJ6kyE9HvpSS
         uYa7IUMAAemFHtwZGl6efYIAsTzlkFqhu7geE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942740; x=1795547540;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fEyRTCIvFn0qfVWEf26UkSN1N6cLWQriDiBDA0wCb/Q=;
        b=oNhpK2KWwHRHucfDeqariJQdCiozUc9HdarC2TVOwQkvohhst7wQZFQBK+yNCgdtn3
         1+alAxJoJ6GIvlIUToxFcly7VYhz6Xsvt1q/+DOu4rdb0UzpQ0K/qGGl9ZKjQg7S+Ky6
         lnDb/mrwbk4ewiRg+z8vDv4J+ycBUPFHPVpA2bwpNF3U7EczJYvERaagzcU0djrMFJh1
         iDk+81iMfwNyTSJcJkwwlBuyxIgy25PsnH2CXfgezyaOY5czx6WRG1JISWeOke2Nyb8r
         20+5uriv8uHepMzN8rsVdSoICOLzjs4dVSTNNDvZTlMvsCQE9mbqcPhQQ5Z0I4jKspg1
         o3Nw==
X-Forwarded-Encrypted: i=1; AL+hErHowNvkyOgjY3z7jLHFNraE2rkq+KqmrKpAksx343+ZimDC2BwkKOPUzp0Cy+VynwwaWbpaoOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z92+x3zI5vERQv9opuyla1cN4O7A0gfIhFYs+OMV9LDv0uSyFVL
	9EfGshaBNia9dCCtEDamJzKaACAVlaMwpFvZNCX/Xhvd15Bd6eZtSczkIBjhFhOUx2fQ2sbaIHX
	WfqNrRlZZ7A==
X-Gm-Gg: AYBFou1vgtYglQVfuZQrg92pMCy2W9DjUz3urBn0dedtw4DhnmbB6DDtf1G42CwwQcv
	f2aepS/mVd/AuXFEy9UeYC7QGd7XE1X8eITrsLZUEeeP6IcVHbuq45WWW9vO+G+HxQABbGDVupr
	Dq8i19LQzltHoYAZ94IGWRiu87svmud3G32tYcjGzKbanNK22lz6caNd0sLm05LS5/xM7MrRuNr
	iJ8SLLonguLpgHxhgRINWB17sP0K5XYRP88AU9D6Cc5ZRiy41oOaqNl41WjdYOBEOBPnNjli/Za
	ljKYdrCvmqgaJxmv8EXiw850XBlyoSa2bze4/8E6DY9yflsUgGG+N/yDJMMNR5BfQdRm1K3DAKA
	NujlS+WTeuA2iLTRXDGFBRw+4KDAEqvXv2FclU9/pvTgjeUjzudemxoxAYwCDOSgqF65qOQYjM4
	C4f4+6fPm4/vESq+iFfy64BL3t5wfXBW17smXY/xLZpv+UDtu9lH40EdookjzwE1Gm0INmmS5q+
	LiP1dHbYhJdbF5v8VVqGyr5W8TL9ddVHaiErb9tlA4HujTis3zJHn+VFO7enjhp01O99xcaDDw6
	MlqVu+xisfUu8465YATqQ3rM2R3AhRfgKq/QkSKE8r6LGgPshxB721YnW2MF0HjdhnhVBI9CSSe
	4Txs=
X-Received: by 2002:a17:907:3e0c:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c510e39ca9amr19244766b.41.1794942740432;
        Tue, 17 Nov 2026 11:12:20 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm30814a12.4.2026.11.17.11.12.19
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 11:12:19 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c505186727fso6336466b.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:12:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFm8tcTyGGWKrU+ZpdnMmeEcETp4SNyW6l7ZZeGLhBrKce+KC/1cc/jmyNWk4agFV1yEo+OONE=@vger.kernel.org
X-Received: by 2002:a17:907:d409:b0:c40:3a99:3f96 with SMTP id
 a640c23a62f3a-c510e162740mr19765066b.10.1794942739071; Tue, 17 Nov 2026
 11:12:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com> <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com>
In-Reply-To: <avyVwg-5ef-pXZkG@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 11:12:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
X-Gm-Features: AclHuK9dpUSJoar-8-Rd_ibx448sJ7TbrjnfHX7r-45ghAgtBLw1mawjEAbP-so
Message-ID: <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 09:58, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/17, Linus Torvalds wrote:
> >
> > So what we could do is to just make the pipe code open-code its own
> > wait event logic, and add its waiters at the head.
>
> perhaps... and we already have WQ_FLAG_PRIORITY, but we can't re-use it
> without more changes...

Ok, I looked at this, and it gets ugly, and I'd worry about the
unfairness. Yes, the unfairness probably helps throughput, but every
time we've doen that, it ends up being a starvation issue for some
case.

I think "ignore it - bad epoll actors get to use both broken pieces"
issue unless somebody comes up with something nicer.

             Linus
