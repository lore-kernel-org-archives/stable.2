Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AA26ED59
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919944; cv=pass; b=c2dpcLsnlC9ivdzgbd5UViH28vQjJ6at796rPTPcU9deNVZGGVTaoSDwbOA9KFCjyZ8bY11rM3CFQpi8q5Pl3JHZzM84tpuFtPmxPoLGAl4itdwL1h/CVV2lzGZGWp+A1hfBzlYldOhyt58no3+dbuu2m5y8AoSLuUysJcA/ttk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919944; c=relaxed/simple;
	bh=j6DXQFZPqoJxKT6AqBIKO6CcGnuuFezI7MlEPU5EqfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdMpBclVQLva7zX9R6WWy+JgTw4ZRONLj1Jh/pVX3R2c8ao7gE+RRnw+QedFcQSIfwyz5XU8aBs83hoVL4kmcE8lhb84n9VrhTuxrMv7Ow8kjeRn8J5aXb8vA+P+TXyvYfeERPTlPxMcWMDD/dOKO+v74PS2W3v+Jmb3izmc2e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9NQDysY; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9NQDysY"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c1372f84dso4009791cf.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 01:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785919941; cv=none;
        d=google.com; s=arc-20260327;
        b=J+ktlEM/GfZ2Z3hfICBfx4wMt6VudQWsXvjEFnOWnqSZ3Hp15RLrGHwk6er0PDPJjO
         kibs/2x50wxiEYFNQBS/XEqjOxH87XBM03RSZBYlDz/qXCQtZyrT8f5IAub0Kt/CxeMQ
         v9kC18OKZosyQHTSvZovt1uQXqWcNe3+7xUrNhDhQFFUFbdInJR9bCVT+yHuVvLJx2Dr
         Bw4J4efYg+jNRLT8Hj4xlf39JzZrI2MHGSxEG3bgTrC310M5It3KdAQ667vZsvszcrtS
         QZCdhs9MBEh+1LbisPJ7ZpgolaE0EtKA7dCR/yQA4z0LF+w/c1Xwb0MU64Vz7BBm0fv/
         FTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        fh=GBJ/zq4VzcqPFjaxOv9IIuqDg6Gmfmh0kfMm7gxNfRA=;
        b=oL3JVib9ni7LZNFfROoLEIBFWXVhfBDbO4xUThPid3qErR/dUH4cGq+K9ccNZMiQQo
         nzLZk97JuhMjdizAlh9UDJk7KglBeToej7Y6rUb/lZHmlvuoDrSqMbaQnRZSf2Tqhiu8
         H44pXTUnWmn20WWUqI2RQc/NIoqeFITC+oYEM+b7tcrlQ1pQ2n+G5JrvQJ8ggyZrPpMJ
         1903kaVTzscU9oWS+I6ftXmCzuO2GvAegcvO8XpiwhCcSbpzjZ5JnjDejfvI7hMxIqmL
         uELA8kuqvQttgDyb5mctgLiktHNXRCpk+LqxmhTvrHDAr9XGdSWZ9N8/7uW1D7xxtABU
         kp7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785919941; x=1786524741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        b=c9NQDysYwMbQ0WI27HcXuTZraau/G/TH7mbu/OARtSRdKbogjhRT5fqr/Y9G+QU0/z
         Rymkq8035w6WyzCap+lbbT/K74k7GACfwj2oDjDxlYZE6Eksf12kudTbRS6yUbjlScWC
         G2W5SiS4L/y5sz0z+Y3I/maVauZUr4RDBfedQPAAuW7Aj2Ud9zXvIQeirC4urNbgq+4I
         vQSM+pJTPjVBgeAw9VtUZ4BJfZp2LlelED51yyRxw+N7ECEnh54NAHNhEJtDEvYNMgwb
         ka5G01gTOiG/2+NmQaCMgRkvp1ytf+A3mYSvG5A+BqryWDqrJjSpwOtUUsRhNa8euk1Y
         prWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919941; x=1786524741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        b=H8aBQeK/psbLPk7N6+nnG8ztpcS5lmrrNLrR3+sQg9QNOwZuB5wR9ictQlcXk1341R
         0xOgPJ8M1e3ZowrGN1ndCQKusMJF3G64XH7lgCcqY/lGEb23gEjZ1Ww+NJx5XS8VjvTV
         QDF9UlMdd39rZ0JmvTo+8yrJyDFnm1eV7di2RH9aoluJUYDNDK627is9/VCn688Vcqrb
         6XoXsGtI8/ebJnnDWGq4YxJ3y++ACHFAZNMnTxH0b1xBZA/n6OQETzLejnTUmybxyyDI
         ciDkTQSituohmQhO68QqdOzZVC7nhPCNnB3foQf6Rak+ul2nXzL5SBDdcqE7/ac8HmzV
         IWow==
X-Forwarded-Encrypted: i=1; AHgh+RqbtScivTNrORbs31+jicoPNhYkMwTftB3f5C6aYhPCpLxioW6ZLrgsQIzV7bb1KzHdz57M7o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlxaosBZpDeyDqe4QJIREd4Yf0vDsk4TuSgk4W6Vq6tEnUh0+
	sMqns2auEryp91eCxvm+QJknwbuGMg8qPcVf+mQV2L9qPnxlm0mVjkbcF/4K1YjLnxoqkkhAoBN
	obQ3aMeVYixOgIz3KGZRkN0SUJb/r5B4=
X-Gm-Gg: AR+sD11nU29hFSfEO67t5Fd5brVe/h3APQhwTHHKe7F4E5SFs8We/bCSd/t/2DvmVPY
	olyr6gUk0ShvvLphGu2NoDRTC70ZKr2sKkGhAF/llT+tDd4g5uC+2Nwo/WfngKwOYstVbSUWXub
	ZxY3s3aHTNahmlkPjdpfE+xGYtlD8S+o4nAPIGbvRXZRVizRtrzhMMpCujtY7+I8EbnzH35pU6Y
	0skVI6/bwtLelXX7dSbRT+wWLWeUga50oj1JeUpm8lyzCq9X/BZe9NKSB5UYl4fF4u2SGeM0Klg
	OSD2+5YaSj4PgTs9a5cvjtQvTZRB2bs84R2xCjkJH2rHRoSuVXWSc1QOGsaYx56Bj6d6tuC5ctR
	2RLI=
X-Received: by 2002:a05:622a:1e12:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52ce5ff11acmr52330181cf.17.1785919941452; Wed, 05 Aug 2026
 01:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804095051.715355-1-david.lee@trailofbits.com> <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
In-Reply-To: <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Wed, 5 Aug 2026 01:52:10 -0700
X-Gm-Features: AUfX_mx8a4ogrmDGIJBdqb1hUA7WGigHW93m5FaPqnH_UvGOCPhqWGAgYlL8EvI
Message-ID: <CAPuPA7KZhv39w=nCG71WBLOcPRrrpb=CvDdVcnCRbfu+z9ZELg@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: hold msk reference when cloning request sockets
To: Matthieu Baerts <matttbe@kernel.org>, Kyle Zeng <kylebot@openai.com>, 
	David Lee <david.lee@trailofbits.com>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, geliang@kernel.org, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ren Wei <n05ec@lzu.edu.cn>, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com, 
	Vega <vega@nebusec.ai>, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:00=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi David, Kyle,
>
> (+cc Vega's people)
>
> On 04/08/2026 11:50, David Lee wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > An MP_JOIN request owns the reference stored in subflow_req->msk.
> > inet_reqsk_clone() byte-copies that pointer when migrating a request,
> > but does not acquire a reference for the clone.  The original and clone=
d
> > request destructors can consequently drop the same reference, leaving
> > one request with a dangling msk pointer.
> >
> > Let cloned MPTCP requests take their own msk reference.  The source
> > request still owns its reference while it is being cloned, so sock_hold=
()
> > is safe.  The clone's normal destructor balances the new reference on
> > both successful and failed migration paths.
> >
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
>
> Thank you for this patch. It looks like it is similar to this one sent a
> few months ago, but where changes have been requested:
>
>   https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.177840=
4619.git.caoruide123@gmail.com
>
> Do you mind checking what they did, and explaining the different approach=
, please?
>
> It seems there are two issues the Vega's team tried to solve: one with
> MP_JOIN requests (what you are trying to fix here) and with MP_CAPABLE.
> For me, it is fine to split that in two patches. I also don't mind who
> is writing the final patch(es), as long as credits are given. If you,
> David/Kyle, are doing that, it might be OK to add a:
>
>   Reported-by: Vega <vega@nebusec.ai>
>   Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53=
f.1778404619.git.caoruide123@gmail.com
>
> @Vega's team: OK with that? Or are you actively working on a v3?

We seem to have lost track of this patch, and we sincerely apologize.

Our patch addresses two issues: one involving MP_JOIN requests and the
other involving MP_CAPABLE.

I reviewed Kyle and David=E2=80=99s fix for the MP_JOIN issue, and it looks
reasonable to me.

Ruide and I also do not have a preference regarding whose patch is accepted=
.

If David/Kyle' patch is accepted, please add:

Reported-by: Vega <vega@nebusec.ai>
Reported-by: Ruide Cao <caoruide123@gmail.com>
Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.17=
78404619.git.caoruide123@gmail.com

Btw, Kyle and David, would you be open to collaborating with us on
Linux kernel patches? Over the past few months, our team has fixed
more than 100 high-severity vulnerabilities in the kernel. We=E2=80=99ve
learned a great deal from maintainers=E2=80=99 feedback and have built up
extensive experience. We=E2=80=99d love to help improve kernel security whi=
le
minimizing the burden on maintainers as much as possible.

>
> One last thing: it looks like your patch is conflicting with this one:
>
>   https://lore.kernel.org/netdev/20260803061739.134737-1-jiayuan.chen@lin=
ux.dev/
>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Co-developed-by: David Lee <david.lee@trailofbits.com>
> > Signed-off-by: David Lee <david.lee@trailofbits.com>
> > ---
> > Bug found and triaged by OpenAI Security Research and
> > validated by Trail of Bits.
> >
> > Trail of Bits has a reproducer for this bug that triggers a
> > KASAN use-after-free and can share if needed.
>
> I think it would be good to include the (decoded) KASAN warning in the
> commit message. Regarding the reproducer, if it is with packetdrill, I
> think it is always useful to share it. For others, don't hesitate to
> share it to the same people: it can help better understanding the issue.
> Maybe remove the mailing list when doing that if it is security related?
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
