Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E74A13BC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349249; cv=pass; b=Wi4ifmAjdSq2wicjQc9Wcu4MRQEfgui2bjjKSZ8vEBzOhPI3eNb1hqPqBybRMm0S0tcyH7svlLEonnwHlEXEoGwai8k8xfrgBHblcYU/zQ/LyGB2hw5Lvo3CK308o+3lasgJww90FEdLWvp++jkk9qhtQa1wA9+UD6jL7loBYdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349249; c=relaxed/simple;
	bh=n4u6Lkyyb3K0KXlI8hsKysRf1EtEUR4qmTh5L+rzGD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2btz0VkjCKsW/pFiI5buutk9cAby6vmB3JkQZZAm79OgAqI7ohGb+nYABttD1LA+9+TSUPaNITaVolhXB1Pis59yYsj5HuTWCZZ0ZGRpEgOLE8buf9/aPUOlJgP0WIbAfPYjctFwuWIkaA396LoUO8yZzq2wM+9zxyRGkUU1gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=iHY8BRF0; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Seqce8dK; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="iHY8BRF0";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Seqce8dK"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66THGgl42812598
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=; b=iHY8
	BRF02H3ThfZf4HVBVFgcPMlLqm5MGMZ/VZQjSZBartJjCLg5o3zKCU5pw7m7TrEw
	9VsI3Vy/NUmtyVwR3vZpdSUIehqLxpvOyZwYBeBD/h4BcSPl4p8/dQ6iwoy+vdae
	7yXAkfVZvzLvZXDQTgjV8oGyZl+5A6wspnTXis57RqgBPs6AVOWXuqsBj5xAiIMl
	bsaVMPcPMCIhjJSmO3Ba/WZ8pKzJ4fTq9J1HawGG4ILIgjY8VeylAEv80pPLsDRX
	rNWKBmbO/wyvivi/YzVQPIwjHE3kLPmXylMyhJKMYNOdrXaTnxU68x8B06cT7QVK
	WMH3m8LPZ+VMJvJiiA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq6mcuuj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:20:31 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81eedabbefcso42393747b3.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785349231; cv=none;
        d=google.com; s=arc-20260327;
        b=W+FOk7nf/roUfVsAm8R2+KKO8X/bj29It0dLxqoxXozQMEjmi/CC5Gy3TC9GfS7Z3F
         rTMyRdJaJ97VDNx3QJdIAjnXWtoP9GuYtCxEfyy33w42An+f7FRqxY2eeGEulKrVlENs
         pTW31gu0dwY+rY3SCirfh8qooAeYyfBMYr58/YiMj4uRfA8fVBL5OPWTWFWCwT3H6T48
         xj4q96uoI9Fge3hRrqSwD9oHYFB92HJStl/qQ1tF/rcICsw7OF8bpDmW39vqqonq6awD
         Hqyzr7Y4PoOqMEVlSTBEdjdAB5VbI2GYiyjk/OojxTsMLc+6Zc+tficHSgRpv/SYxil1
         ffNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        fh=iDXONiQmF6x9kP6DzpDoGHrDgM8AKE1JA8MFOMvoiFI=;
        b=cCEA36d48UatzJMjqPocTBPUaRClcFPlkSjpoMfuVoP/2WtXc+bGlaN+UBrEhbpmjb
         eRNLU+x3UdnrNC8WbJ6KX5noeaJ3I6HBJnkkvzF98UI4VIvjvOK8PoulLLvLvz8vrQC5
         qMbkijEpaHShLd33sRcXAldXrmY2KEgbeyV/dDWvsbOOKlnW67yGTpIYTxHO/McZOFAc
         xtayQZmjAm0RwYILTI2FTj62FizpmNnsd4dJ1PiSo2snp+lAtOIKrhcxis2A1TJKAtob
         SZb8sMbSmAGjksVgXHIY6PL4nFAieAHPVhYcsNeEf6IgnACLifKjE4kTXWJbuA11avGi
         MlUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785349231; x=1785954031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        b=Seqce8dK1T1KrK1jY26btQ3NXgi3a/+1e44dJBu0R9V8vxn7LBGN6DRCzawL/mVzsH
         W+KD4ZBS7AJBN1J+c9Z+zRbOssWFG+EGb0hjcZOIE/hXpPeWwvzGq8uYKQGdlSPS02OH
         XojDu0BjyfM7G7kGexnIFXXNusHsecPJatK5oEaLO+wm1PcgbBZ0pPATsrdt9TBASNZL
         NDFUgFt59QWrPVN8ATChrnd8hARdx8oI6+Fi5u0fLNjmMbTajSOkASH8R7Csykinnzfa
         IlbQ5bIACf5vQNR1zGu8IP0WpcxrQenoYyqvGLakcyYrppzPJ6jIFGuiPvJmve2Jb0E/
         gwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349231; x=1785954031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        b=llRFbkBQyy1OhWbJUEXDChQje6boVUDevNgGQfsSD+gBGhGnsBL6Xtbcah+UDBFgfc
         EGUlorJirOMZUADhzF4BgSdO5FD57PeVJgyXaS35rmjFaAV/YBiRHzm/5CNPdHnMoGdT
         yhSYRlp1MrD62SBQcmJvugN0qfs47ph4diYqWq9uBBxABf9VfzL5YpViL+tG4B+cWm6s
         1VhUdJVFDICcpeztNb5oREsxdhEDCD1NjhLmY+Wwm+wbJpelQSRxFYTTCtxqPUzs7j4g
         y1rlzsAGEqt0VScKAZ155SHja/Jd2/Mw16VUhGkrRQM4QnEu8EKCDajTr7aXxLMtQwJ0
         z7Zw==
X-Forwarded-Encrypted: i=1; AHgh+RqhjNHgi9v0NuneaHtL0TkOiTgJ0lJiHM9Z3SOx8Ag6mpAeTRxGDmQDrSXs9HUBspwds8cpERY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqyvXJg0lSW8jOXsc+7N0h9qxUfv4Nsfv6sOno5IPDa1mE+7Z
	R+LCzwMXhH47gOoJKuGLIN9+UM1jmQOIyFCgFiqOHtd+G7Zu7GdbjCkBGGCr3qZQwE3ySEbRDpw
	N9XB1Wy+Q8iKolP01yDNjLnmNf8TNQ1SfUIzNmzunHH4Xf5932FAALgbSwZ6tab5ZtYMl7W8n2n
	tZLm5UJo4Lrl1U2q15msy9B7Z6+o/P7CWS
X-Gm-Gg: AR+sD12BVHfWLUEO7aevgp+aN1JgGfNM2gUgKa5gsV3PO2qidIsJ6o1aLDf72OqYN36
	Ddylskw6K/YJ9gMgrVZwvoHZQHV2gby/AYOs/3pwnuCpQ2mThCxWGpDrMTE9l6ybKhDGVHFgLAl
	zaxzrCoOI4sJP/mbWuVN51hSlIPhvkfBGdMqBrIsDD87TxRzw+PmmCWRsc
X-Received: by 2002:a05:690c:9b08:b0:806:5a1c:d892 with SMTP id 00721157ae682-81f99362200mr38160677b3.47.1785349230823;
        Wed, 29 Jul 2026 11:20:30 -0700 (PDT)
X-Received: by 2002:a05:690c:9b08:b0:806:5a1c:d892 with SMTP id
 00721157ae682-81f99362200mr38160237b3.47.1785349230082; Wed, 29 Jul 2026
 11:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home> <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
 <20260729133232.1e6c79eb@gandalf.local.home>
In-Reply-To: <20260729133232.1e6c79eb@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 14:20:17 -0400
X-Gm-Features: AUfX_mylfstO_nr2YAMR0KtoaEUkuyIT32SLYOev--K7OVQlRoslcyNqTeL-jhE
Message-ID: <CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
        davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfX+vqlrJKnHPsT
 VuoFAMbvEoQEA+1b4cyN0u8rSUu1uig4WOHDTWbI0jVGRXiANFhI1Bh+m5bETdvDsEPav79BQ5B
 b3vjL2HH3Iv6CmkRBJQwfgVmDvKIbaS/I525h1KLYyHj+wVmVBkP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfXzi+zHNSTm3EY
 Ybq+GtnfGJtWWmLBscg2T+KEZ1ppx0P/fWDUe9gWfBRtUUUUSW11yIJITaU9jdsUldD3jaKi0Vd
 iu+CBFxa4/9eaoeZtYiFnh5YsQJSivmasQS26f8FROLalsj0Vs8wpgMDFLAfRFCwz0gjw6b5Aja
 wpdwWm+1OfQprciXsYBcc9QjEpMjeGJYhMQtq7mR6hkQmZrOvB6/IVg8sI5q2AHwRf2tm7UgUHQ
 pxRsnycdLHQuUWNJRJ8zsRs2E71r5pt72pgOYj9gDSKjLAnMoRgVtGDs3UU0Nac8Po4VkckqqY8
 EJD62+aXJpLrVTmVjVzroR1b2Kf5Ajm9d7y49a/TDRqw5pcPwLSGZKm/SUQO0soIySntg/1YByQ
 ktC4+TZ6Q6PCSJj9f+tvf2iPcTpYHyIL03TYVjuEjtMLWy5L6hujJWvho7/qTTkh92xEa3ZO6XF
 ntfGycWyeb7Vejrn5Vw==
X-Proofpoint-GUID: MeMJ2skDhaYyKJle2zAtWEIkoiniGbvX
X-Authority-Analysis: v=2.4 cv=UOPt2ify c=1 sm=1 tr=0 ts=6a6a446f cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=meVymXHHAAAA:8 a=Z4Rwk6OoAAAA:8
 a=LEQXHG-ZodL2_mGlm5IA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=2JgSa4NbpEOStq-L5dxp:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: MeMJ2skDhaYyKJle2zAtWEIkoiniGbvX
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290141

On Wed, Jul 29, 2026 at 1:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 29 Jul 2026 08:47:33 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Wed, 29 Jul 2026 at 08:31, Steven Rostedt <rostedt@goodmis.org> wrot=
e:
> > >
> > > > > Honestly, I would love to get rid of it as today ftrace has prove=
n to be
> > > > > rather stable. But as it is a user space ABI, I'm not sure what w=
ill break
> > > > > if we do. I wonder if we just make it a nop, and print a message =
to dmesg
> > > > > saying:
> > > > >
> > > > >   "ftrace_enabled no longer does anything. Please report if you n=
eed it to."
> > > > >
> > > > > ?
> > > >
> > > > Thanks Steven, if you and/or other community members would approve =
such
> > > > approach I would happily do this instead for a few reasons -
> > >
> > > It's actually if Linus is OK with this approach.
> >
> > The rule is always the same, and I don't understand why there's any
> > discussion about it because it's been stated a million times: we can
> > try to make any ABI changes at all, and what matters is whether it
> > breaks somebodys setup.
> >
> > If people rely on old behavior, it can't change. And if people don't,
> > nobody cares. It really is that simple. That is literally the
> > DEFINITION of "don't break user space".
>
> That's basically what I said. I was just restating it and not asking if I
> was correct. I added you more for the below information you added.
>
> >
> > Whether something is user-*VISIBLE* in theory is entirely immaterial
> > except in the sense of "be careful, this needs testing and may have to
> > be reverted". So user-visibility isn't a "don't do it", it's a "do it
> > carefully, and knowing that you may have to revert immediately if
> > somebody complains".
>
> Totally agree.
>
> >
> > So changing user-visible things is potentially a lot of wasted effort,
> > and needs loving care and follow-up.
> >
> > So everybody should typically avoid changing user-visible things
> > because it's potentially painful and developer-intensive, but not
> > because it can't be done.
> >
> > All that matters is whether real user workloads regress.
> >
> > And please make sure that any changed behaviour is really obvious, so
> > that people don't spend lots of time chasing down *why* something
> > broke. A kernel printk is generally way too subtle - and no, the
> > tracing "make the printk extra ugly with crazy ASCII barfics" model is
> > not an improvement.
> >
> > It might be better to actually return an error to user space so that
> > users can see that setting ftrace_enabled to zero failed and it would
> > show up in user logs. kernel developers may think that kernel logs are
> > important, but users seldom even think about them. Of course, that can
> > then cause even worse regressions, so there's a balance here.
> >
> > End result: don't do user visible changes unless you really really
> > care. And then you spend the extra effort.
>
> Honestly, I don't know of any tooling that would use this kill-switch or
> any reason to do so. For live kernel patching and for BPF, it doesn't eve=
n
> work. Hasn't for some time. It's now a "kill some ftrace but not all".
>
> Hence, again, the switch itself is rather useless.
>
> It now is starting to cause a burden, as there's internal code depending =
on
> ftrace functionality to always be working and can cause some nasty
> undefined behavior if someone were to set that kill switch to zero. The
> solution is to either play whack-a-mole and make sure all those use cases
> have the PERMANENT flag set so the kill-switch does not affect them. Or w=
e
> simply disable the kill-switch.
>
> But I like your idea about it returning -ENOSUP if someone tries to set i=
t
> to zero. Doing that and the printk should let people know why it didn't
> work if they do care.
>
> And yes, we need to be ready to revert it if someone does come back and s=
ay
> their tooling broke because of it.
>
> Andrey, care to make a patch to do that?
>
> Have setting it to zero return -ENOSUP and print a message saying:
>
>  "The ftrace_enabled file is deprecated and no longer disables ftrace"
>
> -- Steve

Gladly! As BPF users we can attest that this switch causes pain and
handling complications.

Should I also clean up the entire PERMANENT flag logic we now have and
drop the flag itself?

Thanks,
Andrey
