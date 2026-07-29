Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C13C37AF
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354554; cv=pass; b=WHj5w5/1rW2QjoK9tf8jlTQCp0pAc/chsZXF6FLBUlQZGfPKgS2JKQjqjQ1Kf7LExbFPbooCPnxnil045+SkFKgQlR6O+5CuJ2xXruADXQDXb9kTo5oYtoMJV2bwreLgkwfTIJOKJ1eJMrvuqJqng/OtZVfY31AClobnha5dvm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354554; c=relaxed/simple;
	bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoGYFU1uAAAUZWWenD/cpJmGFVCNfeeAXEWIWOF58OfpJdNrZM/amDQGrAcx1Tk2eViJlYU76chblIg2w2yPhliX2sZOhtg8EqR3VIETEvGzPrBgLOoZxbqsMud+TkBURPK8jfew8k2fHbL5VdBRBgRyIwH7rMYk0LG9KhzqL38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YK0H0xb1; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Ct0t1uRA; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YK0H0xb1";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Ct0t1uRA"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TJWBi23107601
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=; b=YK0H
	0xb1DPm9nCDpxbGpqgnswy4YgJeR3BrnGFAshAoVEcGsbUZp76B7dTTDLlwA336H
	r8R+amugj/dUWLx/0DXqETIwgtKrrZZ95h0j6q0abz3sZT5caDP7KVALCpee2Qr4
	uhEyVr0pc2Wvcjp9RwjNzzcGqe38ZcD/nEW+P7UiNNaxvP0Z5mDdGnhfwLu7hXc/
	NvpzLBpd5Wkrtl6Q33yxS4lpBjPRr+yvYUWHtfQpzAWJl0E2rviGI0PwFuO5AslD
	Z5O+3Zhr6qXNG24in8/OTW5yH/CzrvoePvA/wzI3D94//uPKj/wgga7iias7Zxr/
	effjiovKfg3ZLmTuVQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq6mcv9xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:49:03 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e92ddc199so28694487b3.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785354542; cv=none;
        d=google.com; s=arc-20260327;
        b=isYuLroz/iNyZsFj0/DmdpiDny+L67qqVb3+V8NLrXHVEofx/yuyq3E+s8/dMpzJbm
         FLYD8RfcLK0ukBfZ8qS0T8ZmKgbQeIrxFopxPKCAxDff9T1vZYolwroMiJ2UB3dRfZiP
         ISiReqUCDmjDAxBjanwb8jRVqpQWrHukPFY+dPXOVvKbhaYFh09K0tWRWQ+89Fd9oDdP
         fnn6WEHgsGFkhGpyCeEqY0sxvkOt9veI/xVoLhfAeau66yuk8hzuSOGA8esQLUQ0871V
         7p5/Js7UX+FjWoiUs5V8VEmIc1JTrItsHb0HlLfvkdYrRoy+rfEwD1uhKbIFhbT3qTVV
         CtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        fh=ysbpTMaxgR1vOScQGzxj2efINiM9yV82zVmGKcCf/EU=;
        b=jwlSVeQagCPWFWwx51A1kwaJjfgE9/V6UjseQuePkkE30kR410G9elAx9y4VKJ5vwJ
         2COFxF18IGyN4R60nfswr7Vktg/G9fE3T6S5/kvAO0lnusEIBTasjYzhAMoGGiLQ53Vk
         bPkkvcyoq+gMJ+QCQgbksG9ndPL1mj2d7Paz+rI7Ts2K4mZLHneIBsH9kWa4Kg7qffWY
         4TxX4WaklOLbj16sIoIuWBXzPCla902IoA339zMQKulztERrdhnd+fdkhg6GAdeqNAHm
         mW75jQITd2JnPKkjvMBpLWwRP7RS/ORiVKeCHDnZSwM14AmrPz7QaFmpILZnZB/S4tyy
         faQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785354542; x=1785959342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        b=Ct0t1uRAKmNEO6pU2WZjuhEiLI6pnLsHrBXITu9Y3sLBMtCqAKrLBKserQ1xNGkp3H
         qgEE1s8+hL89s8d8/Cwrdn/tVvwD2Dmd0/lAy54ADr7VSWlOQz6l1+dp7vJGPiXk7kly
         5nKFRfVqHmi5JBIn0BOTs5QnPf8usuSlD248mYEoCDgQXrRIHpOGu62+xOk2/Vjnt2U0
         f9AHmkGsflOWZfV8FlfY4v4ROwWPVUJXrlnKYYsavAnNSjs27J2rSAqjs7l3hql4QC48
         Q7UwkRq44+bu69v2Q/QX1aVCq2c9bMD9x7rhUacD7dKH+NTZOASip+2FLwmYiCILt+ti
         fJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354542; x=1785959342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        b=mVOTVkk0SrtI+eLquGDTk3o+ENnV7Zk8yW9ptINQ58SnOUSlNEFGT+66CZH/2T05BU
         2ns1czZO84VpwQbTwamVTWF0wjQ95Es278scUVYyhQzxiTBRUUfcIR/opTcBQOWW1YwT
         Y/lNhRZZFTbhIvp+XQmSY3oL2YU3+4Q1i5vQwegcvZZYgVSIoDnwUo+pK/54JBcx8xIH
         MxA9fbOND3KHluv/7k2noXdjHZJGo8WUzJqncUwC0VYcb0USkiRQYU7Iba9r9KjTVziu
         74xtxg5kNWF7Q64VVR6q/FmuQ0NPLxfURXs7hX+SIX7P2vKL0kwyTpg+7iNQDXP2bTBx
         xWjA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+0UrK7hakGQpfVFo8qTP6+UtdOyMaPRBaNJfQOZUTaxAP/yO4oDiY7r5uBMRGTUvEUys9LEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo76DHBTcC4C7MsUU4Hhp9xTY/AWIC8Zz9cpN5/wnBlJTY1Jqa
	NTI8PO9WcmFWOGLTDPktozEGKQAeuyfgWSJvDLixEsbiTNOgTj2bB87slml+67VBo+lvyYO+OZM
	RxFv+tSQekhzLgl2aQpv10xV/pnLg14R4PC3bbaWlWsaWwLXbDwWLz32mFyv/HqtVQ339G6cUAS
	J3stbepIETBlh6DXp1KUY5f7rEsgQSdgDv
X-Gm-Gg: AR+sD11RBH0AfGFplfn5bc5AI64D5mt23p76ubqysIukDTo4l0m8Gj2J9M0HjNi0pNH
	HFdjGVvZwCqnEOkySey6WEGL5Ib1DnuymkYkDzYyF5f7CuEQtL9mb9E/CzoSCQ6nj5oprVzBnnh
	MmAJr0+9LPDopYUZxfkansKHZNw41Z9mR+bHwiZjSEI/ietzcYF09IcW/S
X-Received: by 2002:a05:690c:4d84:b0:81e:d91c:29af with SMTP id 00721157ae682-81fb5e5db0emr1654737b3.70.1785354542378;
        Wed, 29 Jul 2026 12:49:02 -0700 (PDT)
X-Received: by 2002:a05:690c:4d84:b0:81e:d91c:29af with SMTP id
 00721157ae682-81fb5e5db0emr1654567b3.70.1785354541887; Wed, 29 Jul 2026
 12:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home> <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
 <20260729133232.1e6c79eb@gandalf.local.home> <CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
 <20260729154541.0099cb14@gandalf.local.home>
In-Reply-To: <20260729154541.0099cb14@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 15:48:50 -0400
X-Gm-Features: AUfX_mwF7DC0oGaTu80DDaK_FjjbvMjtCRB7Zz3uBteLMCWzuxKcaF0VD4WX16M
Message-ID: <CAOu3gNj=Ev+gW82_K1LFhjDWrmJ5CXGU26P6Mb8kEZrbGaMdqQ@mail.gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX1wxXqSOb3Gol
 FUJyr9CpBVkiwiWAaONwppX0WMAtv505Smqr2hLzAAcDaol5Yn0j4GDvOZPEevtshVUVyItbSKT
 aT/5oL6mCRhl99bZU7x5iyonB9P2fxcoKg+q3N06PAnrL9Y2m2hN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX2KkSZiYnnJ8B
 JBVDrWr6E3VYtaPo9iBOMvL/X3cc4y1fnxPYcSI+xh1q/2S3VdkajrX+K15J4pjEcQv3aJ8xnTv
 3Gq67G96OliBflJ0E462AxNvZc82x8ZUxmoDj1tTIyAWegF7fO5/0RZH1rkOlxw9LeGfugUlHqy
 oC5E+ZzLSn4pRkNBJkGB4IZEu/+atRUgAUNGdLfftY5ffmGMB19wCZrSNPO3Fy2ypZ5o7NSDtGi
 IzIsdZjUaFCQ0DLyScyfWXG2XoaEAxAEo6lFJC5416DWhwbbV5X/z+1Tmk93EkuffzoxlSCFVo6
 ZhoXGEv7Tnbgmp7yDBq8s8tjuXxWfhKedK1bTuvfPLWxdLqVPOK5zdRJ451Ma/Yz9/XRAHAeoh7
 A9xvadiWvgQMsUyM5+wJjtLjkCnfHqCdToaPLeXlAoXqgdNVJC9voVWYRmFN6ccD5ZgMu1ThTgd
 pn+EcjewWYDDAPQjhmg==
X-Proofpoint-GUID: 748TCE0VcqgpdVUXY_5f4otki46BDnXo
X-Authority-Analysis: v=2.4 cv=UOPt2ify c=1 sm=1 tr=0 ts=6a6a592f cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=jHs7IjXvhldTIRZNGaAA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 748TCE0VcqgpdVUXY_5f4otki46BDnXo
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290152

On Wed, Jul 29, 2026 at 3:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 29 Jul 2026 14:20:17 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Should I also clean up the entire PERMANENT flag logic we now have and
> > drop the flag itself?
>
> No, because we may need it in the unlikely case that we need to revert th=
e
> disabling of ftrace_enabled code.
>
> After so many years, we can drop that flag if nobody complains.
>
> -- Steve

Got you.
Will do.

Andrey
