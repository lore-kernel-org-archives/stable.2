Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807032;
	b=M4Noa4AlxDyKzBTceQqaM81JFlVfYxsUQBc7aIYn0GnhqGqh3xC0uBS8b/i6ghfp0I3o
	 6SoLHc5gufhIUWtcPT30V5mOrWaoMXk/GCgqkNnjVe4f+FTsVuExQVx/8QCk3pHJPevsk
	 ER/JKgjeRjca8QycZ8uIHBU+lqhV0jqZ7QpC6MqflH1HtOsu/AiWyzX5a6MMAvGPSePoe
	 zBK84Hy8X24hVSbwVlxi89FIFUkGFrxhnruSTsCukoOx6faXoGQJNLxH+oaHd5Wtmhvey
	 ui96dA7YJL1RZCfGc3K5F92KSr20t2W0nEJ0M4DjAGbaETFnLaHTCphWTk0fPr3d3aA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UZrB/X8fytlaHPkClRgCuTJNsvMfYV/hLg3NLdrS2hs=;
	b=sSoB4Xb1sTzkUfxX/jR02o5e0lOTwRPreAQswdojfQkcQPC+QAgaQsV6pTq3OnTipflV
	 r5L0wC0wPakK4I1bo+kyq95K2cHiAXjrGmLiQtsdHwH3Rc6mTaPancVsK0QNU15TwTtVs
	 TYm/cRfnda8RlfMNPQ8r79nxB8FhKJjHMXxZyChfOL0jBaPXxsgG0XdG//FLeje4Qd8QK
	 2iWezP3n78IYSJyO2d/9CY47H3DAB+ewbRrYo+UAluQQErkyYPjs7qhCqqw+pI4F+g5AP
	 y9ZQCM7pC/rYqU7ygghRS7cHiYoJf2B88mqGzWoLXkl11x/eZCGgdiMOtSIsBmg7nfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=fLSljIxA;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=cY3nvhTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71533606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71533606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=fLSljIxA;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=cY3nvhTJ
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4F7V3G138928
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 15:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=UZrB/X8fytlaHPkClRgCuTJNsvMfYV/hLg3NLdrS2hs=; b=fLSl
	jIxAkl14wVTyWaozGslLqf6KXVAVCJyAgl8Kj/70qw6x0oWyXAhR/XDJBS/P/pOb
	xmldL2ExI6JxG0OH66b2xO4Pzv8D05Dd4cw+v9buCwLYl0pK7Ve804X4nBW/xeIW
	QSmHzokQEY0ZMChRllV3ay7CfbDcRq07PxYbi5QNzu326uZ+ma5Q1tcD9wmCYRT6
	kp4DMyioiURlEvOljAMOkaaOOgxc8VrMMhpprJhPmxB/+WOA1T9RtEVV1tu2ArXk
	YgcwAnGFtPR1dSudyVHZ1P8/lI8iTdvgWl6mVrVvMzWv5Zkl4cvzWYJCypZOcHH4
	0hV8p7S6cYbxEcReQg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hqths2hhc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:43:50 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0bf2140b7so13425007b3.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793807029; cv=none;
        d=google.com; s=arc-20260327;
        b=nRv37WtzFVJCQz5YS2ZJYG855ZwWY3noOSDEh3pO52LhMt22eM1778OwQAtkEf08U4
         6yc7huHdWSFqjf7T15N8lN3Lh7X5wk+wb9BcqAvxJ8O5F669hDBd9/UCFR4F3Krq++L9
         0QU5YjCPlamPzDIoMCpf6S4pr9T7xhzkE1vDVSrGSnR1xcvco0a0gum+m3cbvjxJdQrW
         HfQn8TlQ6PSweFIsR/sn4HcXJyjr9AFq0AwlNJhl/9d06yz9D7r/bUUesf425AZrNTlp
         k6a1OUjbCrma90dt57jWWLYDaREGc/TKxozWc+63fWCjvQ8Kn2ft/WNuoThJ9hgGkm43
         PNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UZrB/X8fytlaHPkClRgCuTJNsvMfYV/hLg3NLdrS2hs=;
        fh=Aiufc48Pg5t40AHsnNOj32gTvKej6yNOe0jh6uJeZfU=;
        b=NMUHlK6BdXJ+NMTpo2jF4cEaH2uo8e26N0m75i2MJgMFucpSvHRrjdeyzhy4n72MJ8
         arA9TrBFIG5WWvzi7UE/BrU/zt4YvxqtOBCpG2dpb2Lan5o5BI516ErjQBTLYtpsiibx
         cUoat6ZUN5VlVigT8iCccmCUTFzeS09Ea9Pt9DNxksrrbmAapec7F3LLbpa4yFZ273WJ
         Eo+4sBICWvK37qr/IhYI0GxIC9280E+OmBHZ0XdXlGIq2EZ12lNQyqsLH0kVnOHRMCJn
         HtXR6gVkXfgC4jfdClWaF6G7ug49uRA3RkOyiQjdYuIwZMPNERsabGjdBXIwTqsqx8+0
         zPmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793807029; x=1794411829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UZrB/X8fytlaHPkClRgCuTJNsvMfYV/hLg3NLdrS2hs=;
        b=cY3nvhTJ5nHJQektWLH8s8XzAcuB/DfAO42jwao+O6nXqWNv9lkU0EtHP9K+b3we76
         7/hiTadJ/z/1gdXHGUQugHrAm3ck1RMZd2wfuViKl2kJMScfyyB/76lVpUxP5ecS9BJQ
         NZ+LKO9mxQnaBhcdYk+kJk7Hp2nXMIKKcjQRhzn+ZR+iITPHCe9itgXobCLeo+KIm9Wq
         5MgM0srDZh9DNB0SE0mU+UL9NoEc8cAEll7vLZuA0xhItrfeLyiKlnQ/OVcXxg078dhp
         3AVSZCpg6io7JTJs1AT9ydo5O0YsZxFV8LOt/4HKCex2XtXIkHfyEhcgUAPfYqEQEwSv
         Z90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793807029; x=1794411829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZrB/X8fytlaHPkClRgCuTJNsvMfYV/hLg3NLdrS2hs=;
        b=Vcsk9kpP8cS6rYIQXluKNZS1Yh7tYI9ZXs8qKQqWqrKipuOTz6vf7rRbh7tNeDW2vH
         esg71AFX8sQNXPhD3b3eMAKIhPzn1eyJTYNStF3joWfSYJIFNFdbYDifW30Lj9HxC7Zr
         hAVUiLttb0VDB/p6lcpZKneDfXjjdNZjZBKLaNkgMdRa3ruWnZGO3HVwpAKXNrOMEwqA
         T9E39ugK/LsV7J1WBkkaZrDWy27PC2/rKhy26FS+knzUiw0whM1+gmdHdQU8IRrQenXJ
         MGZGBq5QXlAJRipNJ7jCqmup97bpkx5BdeNWfvTecOsW07LHZel2WU2kjEtu9pcnqBRU
         MCPQ==
X-Gm-Message-State: APuU4Z/pwGvb0fMDms03Q1e29sNqpa/wO8PnUA1UuAiWj8tbvkpFSC8Z
	zoGaaH1nD94UZjlXyA08zcqfRfmXT7IGM7hLk38Up6k0ne5Vw0fPGSsqWR8CBWAN9083UnJ0Dq+
	BHSaM/l5W+CJx43rODFRK1ml3GCEyJTlR2fRbI4KfXwDwvvUoOc8LCklvUrGjNgBe9xeaGFil3u
	0Yb8tauyjzbDwBLy03NjQHCN3ILGBtqG8k
X-Gm-Gg: AYBFou2+42nfO5T1Yq77qMfBElulQrjGcw1w50LufMFCbts3piaAFeIBoQS4Qh3QGMp
	/nYK8ClwXRM1Lm98XLj0fYTgaxajwgGd1EvN3z+8puk2pStjGeIU9p4ev8c+3L2VytlI8BxUIfi
	WtZKte00XnrS0AnxJX3LoBnAMucLekS9lDge2Lg7OtMqOqJDvPRFC+xU4iFg==
X-Received: by 2002:a05:690e:144d:b0:67b:f249:5820 with SMTP id 956f58d0204a3-67bf259a5dfmr1510267d50.41.1793807029577;
        Wed, 04 Nov 2026 07:43:49 -0800 (PST)
X-Received: by 2002:a05:690e:144d:b0:67b:f249:5820 with SMTP id
 956f58d0204a3-67bf259a5dfmr1510259d50.41.1793807029056; Wed, 04 Nov 2026
 07:43:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
 <20260820182015.4272b7a4@fedora> <CAOu3gNgv91dq8jLShteRWphrSgNWQ1o1dkNxRr577ez7pMuv6g@mail.gmail.com>
 <20261104083903.0d7cdb06@gandalf.local.home>
In-Reply-To: <20261104083903.0d7cdb06@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 4 Nov 2026 10:43:37 -0500
X-Gm-Features: AclHuK-GzGaSMqWmXOhCGZrUgluo223XGW2okEANRweuImUmkPWzhv2fiSeOqs8
Message-ID: <CAOu3gNiggAdifeAUpycoO-zGKb0k2-nZqWrtDXMXm_HXT8L1Vw@mail.gmail.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable switch
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        sashal@kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
        Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfXyDcF5Km83kwq
 hpTnJwDP7N5nXT7PTyEi/zwxIiPSl95q2QnxhiU3HNUFgsQD4tOJb669ZOwPcxslAi1L2pO06Wz
 GrPjWmZZUFofGl22+FZ8Fm+QBh9DSuAaBDs7M7iFgwgcUnD/9VRB
X-Proofpoint-GUID: 9urCiQXYEeaNHAK4kgX8epmn1sIdJ2a8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfXwQdsXcoGd8kH
 Emnqgu9/jCn/mcwXq7pkI2qSe6YjVBLWw6QPybsAnrNwlOMgDmzhNjEIbJILwlPbNvPHQvGGlkI
 7Cpr0emogD5snDYna0fg5Uhsl4JUqx9DnKHka1aRrgzk9TO/mmvZbXHh2Wfvgg9+U2CDmlmXtXG
 vS4cYmOglFF3OJYxiQHOx9gEB/iTENW6EpDr9a7ifZ5uOQE4zwsLpkNHpOzlbfNqBEE4HYmICSx
 ngvzjKb7+XEMBfKQtxppLfgJpvcrGFnQU440ki/wf37bRPGnomkXqywVT8MZuB61Hg+dh9IafQ2
 /WCKFmlY9hX1VnCn4GI031eL2y7B2eSRMHpY0H95gwKQsp6RJMYXkdFXX95xi7IdygLpXZhVRqe
 aE3eBl86xn5pYfPgzeUHIjtDJCk+ld2YwSZrl4Ek20gksN+2L/WswxhZSMskA+FY+X2If/TOz1l
 gA7/uFfFj0gDHsxqBLA==
X-Authority-Analysis: v=2.4 cv=CIC/zhrD c=1 sm=1 tr=0 ts=6aeb52b6 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=BsxYfD___z3CQAnts2gA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 9urCiQXYEeaNHAK4kgX8epmn1sIdJ2a8
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11956
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040062

On Wed, Nov 4, 2026 at 8:39=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 3 Nov 2026 21:51:42 -0500
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Hi Steve, coming back to this topic (sorry it took me a while - other
> > work related stuff kept me busy). Are you still willing to accept  [1]
> >  upstream ? If yes, can you also please clarify why only the first 2
> > patches and not the third, selftest patch?
>
> I was thinking for backporting purposes. The selftest patch is fine, but
> not something that needs to be backported.
>
> -- Steve

Ok, so just to clear my own confusion: do we want to directly present
this to stable as a backport fixing a bug, or go through merge to
mainline first and then only backport? If we do want to take it into
mainline then I think the selftest patch is beneficial especially
because Jiri found some case that breaks there that needs furhter
invistigation [1].

Andrey

[1] - https://lore.kernel.org/all/amn-vbX6AitcIcC0@krava/
