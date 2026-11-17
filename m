Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936954;
	b=u2ialN9a/8Nr7qz3t89xfWFQn6vO7wmI9Q9lAZsjzx2iSreEl7wLhlwCO6r7j35gBUBU
	 sEWm2YMZrVANb3CW+mfM6PGXa0qZIXrOmOcJC/n0GBE2KYpayE44+c2TNsKgdWE+Ch4E1
	 KPUnbxA23Y4wVpy8gnkF4wDGOUseYGo7aczHmXqoUYhK9Ov841haDAxYPfsiKNUB67es3
	 ycdg0yPEl1kk58Xk1AL73hsi1/1h6Jc/k/VVglCy9nJVD6xXa8bMTM4+yjm5g/bZRxWQa
	 FSJ7K6eoBMRHNywNwiba2A8UygpsF/5ge7OKvxa2JDoX+iNv8I/ooKpQDmFTEfC8oNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Op8k0rbkFHjlj5Xpq160zqvss+WGLpfkmyU9f5oGVbI=;
	b=L8kf4QmNn2d8njuvK4DCUoCrsZjdlhiTg2U9UrLoYaNtYwspjQg9wR4Fn/cBHQsRR6pm
	 9Upzag4JqLVpEVqjAcqlSk3oeg9HL3++xnIuPuOxqQhWg4DAWHbFLuYoVMtnnC/ypXtaF
	 jW0CnBRhGbUPis96Wah/puWNv/+HwJZsq8BfFYRFoyhwOjyobcnlzKGOr8k6dlXRGr0AJ
	 aQZsmCVlnpg1VWPhmD/nddAxIYvcb09GFyXaOPegZKVmWWRtr7zGf2mU2IshpWrIYwkzS
	 4E87Wz8su+AQc351gcaYyrycIKNgaoxwGlXAKQCEH/rNsE0v3DcHBWf/VEIz3ceX0pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=GYkqYS7+;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F288606A880
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F288606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=GYkqYS7+
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c510a28688dso62286366b.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794936953; x=1795541753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Op8k0rbkFHjlj5Xpq160zqvss+WGLpfkmyU9f5oGVbI=;
        b=GYkqYS7+qddbn1BW1NZRytgtrl4D1vUws7T07/wlLoy2o7iiXGmQ+A5929tl4XfKcW
         ovqDhChQybLqo1SlhY0DcPJFuI7BU44wIr2ieruUVKD76ypdT5pdz1Cp09sI6wsVJ9NI
         tE9631JmWKs4AgQj7B6LI9p5kwajtufu1FGHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936953; x=1795541753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Op8k0rbkFHjlj5Xpq160zqvss+WGLpfkmyU9f5oGVbI=;
        b=F7+AFEn0xmqa9g/18ugNguFMaNVy7HNLNpRDr4OkkiepKbmgSNCTYB4qPV7O/1erPy
         Z5NFPQznBd1jvrnslLx9ayR0jaIUyDqvt0IYQ1B6VlNnkiLX5Q2c8e64LW+2cSDUA6V3
         Wb7rKzDI6ANjZo5svWtk13U584g6t49yCAFhmy6P0f5f21++tx2mW7woxd2laP8cKk5V
         a0/LVxu/0Dcdq9JxhlQyt7L+chPZMQQ528R03om8Mm7v6eGmfAJ5FFiP45nke36CC1Fs
         fySIOZRNXsDKC8/da8SWGVQv4Jd3hpxYLkDeL4chidTjihBewtKPUIFYjj+1LrDoP9ZU
         FKRA==
X-Forwarded-Encrypted: i=1; AL+hErHEbmiM3bc+DwZ+rnQ444cCyHS67aa/FDzLD8u9rgkHmuI1Pu1w9+xu0pq/bh6KRN7fog80EYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a6rVUCnnLam2UAGCStiK4xygLgkCEOSNyBz/3AsngFd9gj8LH
	cRQhCD5zPc+/8/+6tnrjwlDRO5mG75Xc9GbpwbJ6vbxaHS0aN+HJHv81gTYcpvu5AD6I//6dHbk
	cWPMOXEDKHA==
X-Gm-Gg: AYBFou1GFs9pnY9zbvxnBruvp48twsn/vDdYIfMpzUjcp+wxYWkWR4lm3ovDIT8a35+
	ZDK6Q6BxntBEsZYUfGm5sUNt59YyYFDY9OIAlgilP80/RKYTNTvqx8y+kg9uNzIl3MTcI+bhyUy
	9ziO5MGFfFbkhN/P0lxSnUmGwHjt7Dj1Cd0WSvIZd6p47WUXxCH2i6i/M1Yzi9D72T1J4St79rC
	Lx9bydA2BcNEQUHwJ+icsi0O/sIMrijGnDcMZ2D9EJijsJRlnA2129JTlape1dtkA0QWn4Vb7FO
	2nACObe19OCAqjv4O2mBQY8yV/j4KIZYSZfgd6Uh8S8UyD9/EIVpRZgrJBYakhf8krduzTbBLUo
	mLefiQ/0InxQUW537a1s5WIRSDLTLVptpDbnQ17yw2UFKCx6bq2PP6+uzw9ap4K1dMxChcPmMpL
	W0a/mOsQFcoNulwYcukHZu/csgjqMHBaLAMRpbBOTuJhaLRfWH2lvZHSfbMxKftTrcsIHmEoAxl
	ZA3pAopesMoHcDCqXqh9CplivK47CITZh/Ps6qB1HuHkMXheEcl0cfEB2+XdBzs3C/xBc+MZaln
	AV/tfz1/uT7ouK/oYtsrlSnhrCFHJH1w5G4djo/bIL0cuLmi1gm0OUmxd3JqM0/f3uY2WWyhHG8
	9UxI=
X-Received: by 2002:a17:906:9fc4:b0:c49:b952:5425 with SMTP id a640c23a62f3a-c509654726bmr1202002766b.45.1794936952943;
        Tue, 17 Nov 2026 09:35:52 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cb340fdsm6142766b.76.2026.11.17.09.35.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 09:35:52 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4682977f9aso707233866b.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHXLKltdnnyU8g4oJ168PBugP0Eotf4YwdQf/S1Tp3tAjXrTT1EN2/GS4DwOJBbyJdSEXRK0bs=@vger.kernel.org
X-Received: by 2002:a17:906:5642:b0:c50:d92b:6f40 with SMTP id
 a640c23a62f3a-c50d92b78d9mr526182466b.20.1794936951190; Tue, 17 Nov 2026
 09:35:51 -0800 (PST)
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
 <avyODoFhZ_M7YDU5@redhat.com>
In-Reply-To: <avyODoFhZ_M7YDU5@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 09:35:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
X-Gm-Features: AclHuK_5gKon9D6gpxIEpwE3Nt5zs6NVA-jEDB-muz-aO1jPRcXkbqK0yG36EEs
Message-ID: <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026 at 09:25, Oleg Nesterov <oleg@redhat.com> wrote:
>
> So. Do you agree that we can "ignore" this report from Mani for now?

I think we can ignore it, but I also have a cunning plan.

Normally, exclusive wait events always go at the tail of the wait
queue. We do that mainly because we want to wake all non-exclusive
ones first, and because it's fair.

But pipes don't *have* non-exclusive waiters (ignoring the splice
case, which waits for space, and if there are readers or writes that
would take the space we don't care).

So what we could do is to just make the pipe code open-code its own
wait event logic, and add its waiters at the head.

Voil=C3=A0 - we never even care about epoll braindamage.

Yes, that makes pipes unfair in that new readers get preference over
old readers, and maybe that's not great. It might affect things like
the make jobserver. I'd expect it would probably improve throughput -
new waiters are hot waiters - but it's most definitely worth
mentioning.

It won't fix the "EPOLL edge triggered braindamage", where old
applications asked for edge triggered things and actually wanted level
triggers. But it should solve *this* issue.

Hmm?

Let me stew on this a bit.

           Linus
