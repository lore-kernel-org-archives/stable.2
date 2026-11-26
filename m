Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675404;
	b=Y3lBI1ZcUTJf487/qlax8L3gRlOrIZMBDALuT7XG2sk6gBxuuGC6en/tjvwSC6zYks7c
	 zxnmdpSxbJYDHqxyQwcWUxfGLJEi5zWx7i5M6oJejFWdP+Bu4HGE5HROcOwEPlr+JJ5jK
	 xX4g/f3UHTqdBiBggm+k8u3xAcuUsQ14nhx/ERAF2S0+esUhsU39P1+8sOfKQErVQ2U10
	 S/AewVG38wLpyUZGeqjRUnuVoJdg4076xLR4JmgBKFKoi6+8q4tuvFD/hthBqhR7kWrRT
	 YRio58aIGaScLbVzBLKXJE7PqDCZjn3EgSsIfWthbKLQ1vQmiVk+aXJRqJSt0yoA2WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6VuaqvZnXbuCtA6VHala2pXt+UVChb1skPG+1z4T5f4=;
	b=vZS0R4q4HJu5voiiY+VKHtklTYR+ZiLiN4dE3eZgBjcpmDNcGbfQTn+o5YJJLR3U5Gg9
	 HWrGbDoiI5dIUC+zkoyyiOCMVP5VNHShpXgReoIAqkn6ft10MAeSvwACHgDxbrGaPeHIn
	 nqepsZ7huxobQcxXdFl5E2XgUOV+hBbZnyS0uysLJmXx9HvQFuuPpBdmefOcyrcdNCAcl
	 qQjxlZqQsc7iBULJZXDWGBv5bcuiWcUJ7eoPgXkix0bdE2evL+5PCxkgGMniP/TG7dboC
	 UsfLk2u5QBYs8XEzDQRwMt2o/lR3H6W80+giCX5cEoWgIfA/PsSF0CnHwYTqZ3k+LyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHWVXjL+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D49606A32C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D49606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHWVXjL+
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so66820531fa.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795675403; cv=none;
        d=google.com; s=arc-20260327;
        b=oKTyC4MRMofnNU9HvZ8wO7QE2m99ZEwuXyHgKh8bADVNdQjHC3hibRMZo7A9v14SRV
         QZPYwIqOImCUfi2azb1GOlPJC+fUy1KW6vojEJphlb2uh36i1oMd8Sf2pRS++LrZAHHJ
         7ztzUWuHV/0KcNKk2iVhIT2E1Iss5hpK3pwA9e8XOLko31a8xUQAKyJpp2Zth6LoApVg
         IrYKfPuutR0b3TwvKIdypcF+8YkJenVkcdVcWj2qjlxx66UcdawiFJUIpIAjN1Oiwf09
         utxMPyzvaozXZ8LT1wXO4UEzQeYYC9XY33iBlRNok0/Ebfd1LwzYxfdY357/zjF0fhJy
         JsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6VuaqvZnXbuCtA6VHala2pXt+UVChb1skPG+1z4T5f4=;
        fh=VFu6e9b52dC13AjLCq7GMQF9VE/NH7iB7yCaDdP48Ps=;
        b=reGfBM6BLXZVpQLttq0vpBUhWPDFHlfQ3c3jd/C+b2UBUK2Ctmai3T+Kwwm/XAL2ul
         Gepy/eeVtabgWDLfOYTItwxQ3YpmGyKoUym29JoGUtW9/6hSq+yjtJLuvI0twJKaPv9Q
         wb/dCnDa2CPzNQvxOpk9MnOO606KuF9bf1HBbfd3HtXt1IhQ7vFXYE6OJuLPPZ5U4gZF
         8dojPCv7dQ9cD+Z3/Sw2t39+bLbQ+LwPyEJgUQDQE7GqQgK5B9bCfo+ABpnc1jA33dUZ
         B5C2cSMwfZt5qPhW3SJYgNMJACxB5aPi/7CgdGEn1o+6/zGVuTpT64u0R/ewV+cAetUl
         pSqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795675403; x=1796280203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6VuaqvZnXbuCtA6VHala2pXt+UVChb1skPG+1z4T5f4=;
        b=MHWVXjL+97ToX3qIYXibaqn2KtaLw+lEseirA3sMfROPNaJkTEg7ZHAEWl2hpfNL5g
         aO+tEb7TaSSoJXwlFt5Mv3BP0fNRk63J+ukzLE8AaFjVg+hjpsdKkafJZ2II1a4oiUZz
         N44Ok2sZev6vm2UkKLDQZ0nuFJvdhpWJumAuIKnLlMAOW+ol8hBbg+IBXVdfweb0WoZU
         kVApehamv6WkvQf72zz6gK+Z6uW8PQay72VrtwqLAXZztmOurbAP2DomnIcxmsp5Znnq
         CV2kgHlwU8v4Vo4lNpZvNh18hag55ulfsV9mSVSw/oDcrSzcw5Pa/urUv0z544d+kncw
         YoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675403; x=1796280203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VuaqvZnXbuCtA6VHala2pXt+UVChb1skPG+1z4T5f4=;
        b=YvwYgqwzh8AMqZPr3/QxEt++Jj4pbRKpRgHabcFH00jlHM2Fbie74Cue6mTPADXQP3
         AH3xh2UIfzgK/sUoVumhu5N1zX4kl3l6XJvnUdXWw0c3tpte2NTo79XahzOMqROAk/PJ
         kzxHWNv9JDxviEnMlAretSClhMV+AC4dTv1E/BfJ90mzlgsQZO8fLqTYmU/GBsd9K8j0
         qjjRsySmXeOAvsXqe8EVYhydKULXZqR/tBXcnXIZ7XM2bjibzQLarhbfEEOQ+S6Zfo8g
         zApH87iE1wPAmJv2cM5XB/9VO182g0rip7l4xyxzaa3622Kb3aKBE0MO9Ugdga5Qh1bY
         mWxA==
X-Forwarded-Encrypted: i=1; AL+hErH0+xHdQ+RniJL/hn39PJ4UUDXIfk1lYHKjPEUQ1pLV5lu3ihuWOo24K9vBx6rsYOQdwvhgz+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zLpQ4owMLJkftCujfOnfHOfKBenMSsPw/jMj7lDNRyg0ygAO+
	d4m1EfR6y2ZRAB8wMxu7HXao7Z6i1FyWlyaiM2gc2POoSGn9v2H5cJQTtmKtQMuI3Q72NRUr0gH
	xDAbyQDM0TeUm7g+TnTNOUrPbldLxbPg=
X-Gm-Gg: AZFdTZdiGEHWSpy4L9+H2uMevNsMKWDoo1lfiFiVZohB/ZG8FYz9wWINm3YUwLdmm6/
	zTLeWBWej/f6RxHACRzfyio/eF4XCe/R5rL+AUJWD9Q9SDbJ+5DGaowJeHiy7UANBmv3WQApyA3
	OQTIc47eXOSL7/U5Ql7HHGW3fBbUwQjiKQ8K6lsz6Kfwdnco5tp1qy4etnMRS6RxP+N6Y9HzOdZ
	LJUoZpp68aVHUV5UwUNJbBkTkfTiZiAH+0JSDGTrEDZtLpt28g0PLkb61W8S6wD/mFVAHRQnl/P
	okY0mqq7zjsMFYHurYnRRSwEv8fKBWQXyybSviX/RrwTNHQQfj3zV2HBI0rd3qkjdz9JEtJKY4u
	T5FhsS7dtRfM7iOF8pRZDUifsppoS953h7M6JMvU8JMvAQh6GmJg4yaw8HpDIqfKqjp/2KQ==
X-Received: by 2002:a2e:bea2:0:b0:3a9:9c1f:1b9e with SMTP id
 38308e7fff4ca-3ae7f9b08dbmr66942221fa.4.1795675402448; Wed, 25 Nov 2026
 22:43:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125143821.729802100@linuxfoundation.org> <20261125143830.189554233@linuxfoundation.org>
 <0782adf7-20af-45a3-a09b-2a34c76afbac@kernel.org> <2026112640-recite-tipping-891f@gregkh>
In-Reply-To: <2026112640-recite-tipping-891f@gregkh>
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Date: Thu, 26 Nov 2026 12:42:59 +0600
X-Gm-Features: Aa3M54ouDePqYZg9dGf0okJ2sElAYrlc0EtcH7b3FGYFv1E4s2easyFvl4Kr9d4
Message-ID: <CAFj_507cGXSjDw6kRmatZhVo9k1LdzGxLd6rCVwZ1pV_VKutew@mail.gmail.com>
Subject: Re: [PATCH 7.3 0361/1005] sched_ext: Reset task fields on exit of an
 SCX_TASK_READY task
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jiri for reporting and thanks Greg for taking care of the
stable backport!

On Thu, Nov 26, 2026 at 12:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 26, 2026 at 07:19:47AM +0100, Jiri Slaby wrote:
> > On 25. 11. 26, 15:28, Greg Kroah-Hartman wrote:
> > > 7.3-stable review patch.  If anyone has any objections, please let me=
 know.
> > >
> > > ------------------
> > >
> > > From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
> > >
> > > [ Upstream commit 564405c424f49d70b13debe7fe5b550234ad6b84 ]
> > ...
> > > --- a/kernel/sched/ext/ext.c
> > > +++ b/kernel/sched/ext/ext.c
> > > @@ -4198,6 +4198,7 @@ void __scx_disable_and_exit_task(struct scx_sch=
ed *sch, struct task_struct *p)
> > >             args.cancelled =3D true;
> > >             break;
> > >     case SCX_TASK_READY:
> > > +           scx_reset_task_fields(task_rq(p), p);
> >
> > This fails to build:
> > ../kernel/sched/ext/ext.c:4223:17: error: implicit declaration of funct=
ion
> > =E2=80=98scx_reset_task_fields=E2=80=99; did you mean =E2=80=98scx_set_=
task_sched=E2=80=99?
>
> Ugh, I wonder why this code never hits my build tests...  Thanks for
> this, and the other report, I'll fix these up after my coffee kicks in
> and push out some -rc2 releases...
>
> greg k-h
