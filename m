Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9A2798EA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337252; cv=pass; b=G+qyRwuXDa4EQLlGCOxixdIfxcm0jvDx7vhdgflfUV10uhunpnmf8D6nMVg/z8etcETqrDsO/l+1ayMCR6yWPScV+CSYCJct96lt6NNK36PzPNnFJZTb4ip/1CmOwsXOKZAV9pKsc8vtW0NjfqZJjqsHJgLpfK8W3HiasYWO0R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337252; c=relaxed/simple;
	bh=WoRDoEi0VL1vigksALz/83dPkS3F5vPYjkl8rzXgfkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+XITs7tuhCCqJbD2862vDB2s80ZMi5qlUZ571ikHEfT+y3EKRSCXYnUu1e3pK8WF/OiZcZ/VYqIPLeOcXMCelJ/ev672/mPNAJ6ioKZv8JZM/bR16oJMxRzNa35ZPZQazJoUHBz0XPtDOCGuCmg+pwOyevZyjNGaturadELKpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=McQ1nMx8; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Qu6l3/39; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="McQ1nMx8";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Qu6l3/39"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TE1QQ1030869
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=; b=McQ1
	nMx8M7wPOjuOLAkLDA6WuHxFcrcAStnEaL9XPowHaB61V31/WItQ/KdjBYstRpwK
	P+O5TLQc91sUMJSjuMaWZyc8qd1Aeg3A7MrBzuKtAkVZ9D2TEjrYp75iz3jQDOja
	WFnbMcZOrkrsE4DyxHhfuFuY6UhCfcM9qYgnJBF5r88ZTN1MSo+1YXmC8nwwX6ud
	fyvDRcg+iKR2WyvT8SjElYxyjfR9i80ynYuEp4yEzjRI44b5nuM3wy6zlupaiH5Y
	eslsUCM8lDphmgvIYrnuVGF0Jb4CsfC8FFNXl8wPmf/x5yjgfL3pdJtA2FWBQRUG
	vw9r71nevvUHAXnFvw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq1eem708-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:00:46 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-80ee3cb097eso19091427b3.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785337245; cv=none;
        d=google.com; s=arc-20260327;
        b=XgyG7cj8ctPVFGfVbNEhb5ao51eGD9vuiIqa0X2tDZf+bL0kdaadHnPC3AK9tx67Ow
         FqzPv6u2anM4DrEvYRtTrbdsR898AP42Q4fEXezwRciysylsY46PTYpXULoO3ufptex0
         H1rWxvTSC2MRQie1Q6FPms3RCpF7+xIAfaaeBpNGNULYaYmbgKp7jpA5KfJbD0rWEjl3
         JiotrigSz54N8Kei2wjtrim7uiyiJ9EL0XIffV3LQCP7vZcNQ+BSQoAwpbAEa2gOKGEh
         xLzlkeXdIe3T8h487CFjZRegkPySYFXRiXYhU0aC+6uuQjQRlnWPz8FuX5eNo2FOxFyv
         dsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        fh=Xy43D/8NxJg2qV8fUZuZ2/0s4iVmhiyCVxM2X/bclDI=;
        b=D1Zglk2cALDVnJGW0no9aGhpYlQwkdVR544Gi47Igoyj4ShaEvOA9UgKzWYERAKvCe
         nZt8AjCO5W7j0HxNSsioxzQBsYuxi00jLi/f86PHgod7Y+TL4a+7Tb1n8hutYxaiD5Na
         sQwz132wkbz/+Y7FDATQbfHP8ocRDjqaI0xUO553f2YI22yMRZPS0gYavCZ3my9v7sps
         5hJG2mnMntEOTxx9Zq5HfDSVkoVqgH+DMDzDDxhOa9RhbXpZUPb90M7oSlTvA69fP3a4
         8c1wQazVVku4z68Lg8MrUgLbdNQg13TiwAwXNZBR8WApPndLo/WOui4Jz28AJirBkvq5
         4naQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785337245; x=1785942045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        b=Qu6l3/39lMzxJJwhCPtNM7+PJrnRNx9fGchVjQ8CO1nXJ8xU0GTdoX2eEqLrH1jhKX
         HsLF7/xYVtIhsfDcEj+BRLLzyTYnSdQ7gQFUdCmm1Ej8WiX71HjOL0aQeRrUOFHGQGVc
         VRnPqgbHsU8YLgDA5lE+B0ws1GWGDQxK9qHRUCczMtBltukfh4RMHuUqt/JCYka559nU
         AH2efMfwSTik167uU4KvhBoTLhtDkZq8k9TWfUreYDKe6QeCKIDsqfoS/7PTEdeKz2qV
         +BfOPLza6P92ZD/ecn1znUfqKYMMSmlja18J7XMzOHGjC8pVdo0BGOvnctbLSfOpr8Eh
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337245; x=1785942045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        b=dSzvhEksu2116HHHUid3t/gIQ8YOblTES2jBitezvPyZlsM+tG50d3CPTJ56p3f7fA
         P1SMsLhPRAg6gqI3eU5lCBKQI40+H22pjNltBGKtKLO7Eoxx3oZ5XDdxLthX7Jw22a3R
         /bCcsD2VI/znQaThaghFUBQjFFZBCx+FyGx99F5UAxeDprbkTXJTUgkjM6NvdVZq6T0r
         aGwzb9Sh5uFgUMD3IdI0WsC9Gbv2TH+75ZD1fTdI7kUzF14GXZNedJhlxPyjkthuEwuk
         O0/uhHLJwn2Rn9y3f2iKXWiiqTc/qa41v7Xi5eaJOaXlb5okyKsuOSrrKNsP8enTecE3
         sVvg==
X-Forwarded-Encrypted: i=1; AHgh+RqJj0GxSGOhG3HOM5cd37mRvINFeaR0r1qNsGCRTHcOAucTKD30vHqngdCbuLZrzqkJWI4uZ/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAgIRokMt7l4Lg0lI/H0XJFB27WXG8xxJtKYDlJLrX/oalv3N
	A37TEWZ+458dau8mu30oZFj2J+Zks1ujFkfP8g9vOBjBLdx9b/w/E6kwBODRjpPgFFVGNkuHKly
	H5gmSf5dpgSKrAz+hGKooxLf+XkxOOABStOiEpwB7IrG7XL3vuf9pfls3a2IcuiTYN/1x3YODTD
	Wu+b6dO7UJDZDK8SlRxehkxVm6376Hde2t
X-Gm-Gg: AR+sD10U8adH+OegZlwj5XBVart4GBnhMfF2O8qyyR0KGXWxukEHlyNmWRi+vGDl506
	KS6sjg2nlAN5oBtOX0Wsmi8ytn2U79LZMkSCN67kIWysDPhOrS+gH4Zdz0PtdF+35RypgMjSFSJ
	P2e6w77G34xlE3md29rlaY75ndLmL81PZOxqVr0PIuK5pXc6A7AwfHDUGM
X-Received: by 2002:a05:690c:6a85:b0:7fe:1413:f6b7 with SMTP id 00721157ae682-81f993340e2mr37633057b3.48.1785337245003;
        Wed, 29 Jul 2026 08:00:45 -0700 (PDT)
X-Received: by 2002:a05:690c:6a85:b0:7fe:1413:f6b7 with SMTP id
 00721157ae682-81f993340e2mr37631177b3.48.1785337242714; Wed, 29 Jul 2026
 08:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com> <20260729104114.04298a48@gandalf.local.home>
In-Reply-To: <20260729104114.04298a48@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 11:00:31 -0400
X-Gm-Features: AUfX_mxePSJcFU2kU3VYl-YapXlBxTsM8pdNfueUNu8RCOjDR26LSYERFFJr5l8
Message-ID: <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, jolsa@kernel.org,
        naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com,
        mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXwTYkGmVI3LW+
 WzSHDLH1wqAU/FBSZo+803AvBgEbznXJ7fXRsJtpJkT3sJpy80NuHOTxcnUqtnjRlLNSx2hbsGW
 Elijo2Ia/I7fbB7IYkfaVUiGUsXxiHEC2xzB4zK5rCDR6q4JQZVx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX+vBMmiBfRjNu
 YwlAuTyRUkS80dzm3GLLMMEWGgI1yPw3/zU7Q2b/m6d+4WzZ/E+3xtngW3H8wx30UUzfc7vFt7S
 LXANCjNr7GgBM6kSxkWpIrmdpNVdKL3tWbQYA7jtpmVr2y6qmFsm6hCkRqww1g2YnEVQ5EQOVIy
 LIm5Ml+GktAQ209jCPQwf1vNuGkyHWrOkVz65Q0LTdeFvi/vnFMaPXAhwydEH++Nz+FmIdu4Q9n
 Zm2sKr43pM0SBuarKPrT6W1wFrgZdUJ9IFsqlH9PV2YKADPY8cwKT3TSTHj8WabS8/pgVrBXSHx
 CfJNZVrZfuU9PHzzVBJQN4iO9Bugp3ojXFLaj3SR9k+PnM5CiyjstdEt2vMxOpIz4xbWi7nyERZ
 UvIg4RfJl00wNj5/U+HIqjg+CZsRnA==
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a6a159e cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=FNDBzpQLrQZLHPu8S4MA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: OzwWyMe8iX6_4QIwbqyVswz2bVOOO3HM
X-Proofpoint-ORIG-GUID: OzwWyMe8iX6_4QIwbqyVswz2bVOOO3HM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607290121

,

On Wed, Jul 29, 2026 at 10:40=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 28 Jul 2026 20:59:56 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > This fixes a long-standing issue: kernel.ftrace_enabled=3D0 silently
> > disables BPF trampolines (fentry/fexit) and ftrace-based
> > kprobes/kretprobes. The write succeeds, the hook stops firing with no
> > error, and re-enabling silently restores it. Livepatch already solved
> > this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
> > ftrace while a permanent ops is registered and refuses to register
> > one while ftrace is disabled[1].
>
> The /proc/sys/kernel/ftrace_enabled was added as a "safety kill switch"
> back when ftrace was first added to the kernel. It's addition was namely
> there because live runtime modification of kernel code was new and we wer=
e
> worried about how stable it could be.
>
> Honestly, I would love to get rid of it as today ftrace has proven to be
> rather stable. But as it is a user space ABI, I'm not sure what will brea=
k
> if we do. I wonder if we just make it a nop, and print a message to dmesg
> saying:
>
>   "ftrace_enabled no longer does anything. Please report if you need it t=
o."
>
> ?

Thanks Steven, if you and/or other community members would approve such
approach I would happily do this instead for a few reasons -

1) Seems like the more correct course of action if idneed this switch
effectively became obsolete in usage instead of piling extra logic to work
around it.

2) As I mentioned in the end of the cover letter, I believe for some cases
such as fsessions/ksessions and multi opts retprobes, this patchset is
not effective and the issue will persist, requiring a more complicated solu=
tion
for them anyway if we want watertight resilience.

If you approve this - I can try what you suggested, this would include
making the
knob a NOP with a message, dropping the FTRACE_OPS_FL_PERMANENT
flag and reverting/cleaning what's possible from the original livepatch pat=
chset
that dealt with this issue [1]

One question is what the correct set of tests to run in such a case
would be to verify
we didn't break anything. For this patchset I ran BPF and livepatch
selftest suites, but
I wonder what else would need to be run.

CC Miroslav for Livepatch.

Thanks,
Andrey

[1] - https://lore.kernel.org/all/20191016113316.13415-1-mbenes@suse.cz/T/#=
u

>
> >
> > For trampolines this restores a historical property: from 2019-2022
> > they shared one global direct_ops, marked permanent the same
> > way[2].It was later lost as a side effect of the 2022
> > per-trampoline-ops split (patch 1's Fixes tag) and never
> > restored.[3][4] Kprobes never carried this protection at all, so
> > for them that is long-standing issue rather than a regression.
> >
> > Patch 1: trampolines. Patch 2: classic kprobes/kretprobes. Patch 3:
> > a selftest covering both directions for all four hook types.
> >
> > P.S
> > I initially implemented a per-record opt-in flag[5], but dropped it
> > as over-engineering once I saw the original blanket restriction.
> >
> > P.P.S
> > Open question: kprobe.multi/kretprobe.multi/kprobe.session
> > (fprobe-backed) aren't covered -- return-capturing fprobes share the
> > function-graph tracer's subops manager with unrelated tracers, so
> > marking it permanent needs a different, per-record approach. Perhaps
> > something along the lines of [5].
>
> Honestly, I would like to start deprecating that kill switch.
>
> For the series:
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve
