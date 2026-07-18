Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAF347BDC
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784389052; cv=pass; b=pSKBV/gJ4AlvR9GzoyWM3/cMP4urCPo1a3teWaMiDne4auD82y4eU9R2Ud3wDB8pN0Zx56uhNLlgDiBZGhlBKTD7YU5CgO3vf2ngt81OUIvXK++0Ke+oFXzqz3iQ14A7NSema6OtyHeSUSinckGb1yq7z4SMPzH91zL/vPgdvbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784389052; c=relaxed/simple;
	bh=8q9GYD/lAL64yUjeA2of+S9sTZwekNJaVI/5mr/D5p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7k9559gK2aUAmjdsYp0yNEpXX5sVB3t5ZciXsB06XxMzXpi2Sk0Op85CFTXJpIWIupK4JjmpqJrcTM+ASE4QY8cXRxLsv5iE4dWxmFrz46Eg6F/gokg6FVk3A22PH7CWMd/PlOpbzfFsGk64fBIVreYFzT0bbal/iB0CvU5ABc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdYR3exq; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdYR3exq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e592da74so1092356466b.1
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 08:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784389049; cv=none;
        d=google.com; s=arc-20260327;
        b=ESWn+yaFAmBNLpVTTE0m2PzaqcqohdZFKx85laBMkNTLFoX+k92r01hhph6CuZCldv
         n/xFTuq4UHtfan6tV5W2W8D5onqKC0DlR1WnYFV9OarY0IWUT3vJt91hoUe9siJji2CX
         VrETiu0YOvtfAuf3bTnPcjoHVIWQyhJ2zQgrRDdHI0WV5PqtErladzaFKSVn69L3nEqt
         z54WXuGfMBJQx5I1qVGHHF/CbvtvjKjaxmMVYPQKU/LpyL4kymW2prDYPyQYnhufMJ+3
         q8lEwifOSUobApADS3G+O4schbXOOiVJaCO5Q0q9GfQblAQrbRo47dWtlyLe1HbebDYf
         N/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMtr2YSHKkLXYqQpb4DNu0VnAILOar5SjOOBJHrEIGQ=;
        fh=Cfh9YUQix79Nb8AOc1kw9/nQ7bIuuh4lvJdFId7zNNE=;
        b=ovZSyx71Ecu3N8BfOKMVQ0KEbuMckK3auS4vzDOA9QvSMdnNJSYbT8smygrOFgVVcw
         QUOiuSvMhzmzV09yFY+F3nf8XMQs6HTfEuwClUYAImDnM5mtXo8PLVO1MlvkB9gJBF2+
         lFOKcluLpimJADRo2rs+KwjHrWcbi+RNWxD/mcf6bJK9uHIqIUtcXtyRQopo9CRVReZV
         uFo7TvG20FZ9EbCWLmn/pXncywHVF7fK4yuGFPvfkwW7ycEWSfmMt9IIK8g7fKucmhx2
         XitTLlfppwpqU9pxgyPa73Q5jPV4T1d33Tk0Jor3Q/AY0zh0Fp8Dz1zBQTAtaq9feWmQ
         qt8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784389049; x=1784993849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vMtr2YSHKkLXYqQpb4DNu0VnAILOar5SjOOBJHrEIGQ=;
        b=QdYR3exqA6zwzu5xv6v6Wf9doH85+FSbHvJLJXsRwewobs0FQermgFAYMNmfcT+rMF
         bEdHmAHt+U5a9Z2lQL84NX3pQ/wK7q1PRMeyB1V6W5R4eVcDStAxZ1IDGMpoX1hMLdS3
         pNXgyu7wp2PgnncDEBCHtIvznsTtOSTiXMTKr2kZraRuEGYoJLX6327b/5LqKPbUQ8cN
         2tkyUO3k9ekZ9UUZ/pT6qxxB8DOFqiE6urXXTIa1epPBXbHt8U14KgnJ3tge1R6EZb9r
         Ctt1yVO8mKfgBsfJEdJkugTliRt2sOXDR9jh7MvirSMbDZOEkBkvvbynmabUdCUKfXSd
         Ghdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784389049; x=1784993849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMtr2YSHKkLXYqQpb4DNu0VnAILOar5SjOOBJHrEIGQ=;
        b=SFy1XDjevdi43tc9RFYV2Ip2wm+5C6ezzl7hELjjQUo6NnZc2frRo15DvmX9BoBavx
         Hc4SkgpkExvweiMM5AJ5PpAgjJJhCnKYkyZT2gqItHI1sq+HiorUuvmY5g64XdcTlWk2
         QkxqI0M47YQU5gcQN643/5egm10yev7SqT1c1ckiZjxyK/tSUiXl892tLzNDHcPulBum
         k79Uo/lJw9iippOCL954Rx46JlzhgosWJK27IqQfGllfK1xTr4Wngj4cEn7A9nJm2TPW
         ido4Lb1Z+wQw4UbnjATnyJURRllHk8PRZmIK95E9Kcnw5ZE9UN52PZc0pBfWCROYDJ1P
         eT/A==
X-Forwarded-Encrypted: i=1; AHgh+RqG5+qyhAQz2kldIeF0nMyx3qJ34zBlsWzhNnWQ6thX8sPECcewOYK07L9N2ZMZb5HMgTHV/jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziO5Pm7UcSpw7uwhR8nAy7MUetKjynaMWxF8iN8hC1L0HUsQYw
	3S9dllEy7JOg1eDEaJedj/4fXD1sI47phwcoyOcsWox4vnpZbGfS5twSRU6B1MyBW3uT/qOz/om
	0Rx7K/Jxcco02kMgJwLlk8T+VGY7aVVY=
X-Gm-Gg: AfdE7cmt2TT03+e+F4JLSJW5BDPyJQfSZEvMDrt1uR7sd5C+PbOmxkgYHIozW4uXlOQ
	ZJRmyoswCCs7s5S/GG4uvHWdhbK3N+zNJEoheEvpLcd68Ni1jkDhkYpIoPE2ZEpN0kfQ1xN0POe
	q9I9rYzwlvtgjMcubi2QtjugNBvjQDLDjxwIwzM85aIbhaGJM8aAn82nQ/IDgWbmRnmQR6AVOUA
	ku2VtyLB50znNyv33gbhzXcpvlvMuFwfg2nkq9RsvbV8RnQfBPfmY+QWxlR4SHk7O8evUTZVCZg
	MQ9NkRVM7iBZKpw4iQ==
X-Received: by 2002:a17:907:3e1d:b0:c12:34ed:e100 with SMTP id
 a640c23a62f3a-c16b489328cmr334631366b.62.1784389048592; Sat, 18 Jul 2026
 08:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718032000.9184-1-blbllhy@gmail.com> <20260718032000.9184-2-blbllhy@gmail.com>
 <alt9fbrO1WlJg-Jh@redhat.com>
In-Reply-To: <alt9fbrO1WlJg-Jh@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 18 Jul 2026 17:37:15 +0200
X-Gm-Features: AUfX_mxOEnWQNXFH215_GJeoBrgx3PWRM5QXGxP2DhTJ6_M1xiOoE-wKdzIzUcs
Message-ID: <CAGudoHEMhAfDf8c0P89yEkaVgC6c=Q822-6OFzgG82v+SHvkvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, brauner@kernel.org, akpm@linux-foundation.org, 
	jack@suse.cz, avagin@gmail.com, ptikhomirov@virtuozzo.com, include@grrlz.net, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 3:20=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/17, Cen Zhang (Microsoft) wrote:
> >
> >  int kill_cad_pid(int sig, int priv)
> >  {
> > -     return kill_pid(cad_pid, sig, priv);
> > +     struct pid *pid;
> > +     int ret;
> > +
> > +     rcu_read_lock();
> > +     pid =3D get_pid(rcu_dereference(cad_pid));
> > +     rcu_read_unlock();
> > +
> > +     ret =3D kill_pid(pid, sig, priv);
> > +     put_pid(pid);
>
> Hmm. Why do we need get/put_pid() ? I think that
>
>         rcu_read_lock();
>         ret =3D kill_pid(rcu_dereference(cad_pid), sig, priv);
>         rcu_read_unlock();
>
>         return ret;
>
> should work just fine?
>

I suggested taking the ref as a future-proofing measure to *not*
impose any requirements on kill_pid.

Admittedly when responding to v1 I blindly assumed pid is always
rcu-freed, my bad.

Given the arcane nature of the proc file at hand and 0 performance
concerns, I think the easiest way out is to give it a spinlock to
protect access to cad_pid as opposed to trying to play any rcu and
lockless games.

The separate patch which deinlines kill_cad_pid should be folded into
the actual fix, no point having 2 patches for this one.
