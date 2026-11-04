Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793813544;
	b=sBDWxJzsW99ZyGNnmwk3g8pyrd1Ffslzs72sDVTiumBqj8mIJctpnrZuZxLC+RNyTOqh
	 3T7C7AQrSc+qZTS3i9s49Dn4HKyvyDiYipH2fPuKkvZfRbpoK/yQYf3JN65+j1+EQKXWA
	 UcytR6o4YwSNXPpITiBF33QSbc8qvpJQLaVLa4SHC6K5nz6ZY2HgKh/JMhDMBiAVnwbG6
	 0bu5x5ltan1t8y85gPIPpA5iWMabzL40lz2NlyVH8mJkWwpFA/4C6F2vYDP8LcO0DUfap
	 OA60MnJFHQh2S3DQV95EN4xp1VOlHuPljSx9K+L5nMwbSZ7NNDWYKYsHXrLNTxN1XQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813544;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=z6UdjSgjbr16sAlbbQelmPR/UDi+lF9pcyf3UzsJqGM=;
	b=QRgNqc+zigc7Xle1m9h8ldffUsis4P+AvHpSyF2FhDG17fNxsEc/J/pJgWdJ3JZ1BTfx
	 w4xNf5TKKuCFg4NwtvxDMewaIBeDbCtPvcX6ODI47+THuLiYGFNL8NP0XYNG6R6Y2KDn7
	 W2gowVNIITV1z652HC/aWNtfg2Pom30pUoba4GKzrmI0DkOzfHhUi3Aby/jSKSx1Pfqht
	 ZgJCgXIszQ21Y8gJPEBA0KbOQD6WbII0YsrJCgIFvpsIvJkXT//aNdKmhTHCnURPXYpGa
	 omM7tV+voQcn8fTRHn2vSaxVSibJHyEGkYll/3V4yB7XGEuT9LR4ioTafmKm+uSF84g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Dt5VSvdo;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=GSheZoLC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D9606B903
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB9D9606B903
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Dt5VSvdo;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=GSheZoLC
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4HP6fV2651911
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 17:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=z6UdjSgjbr16sAlbbQelmPR/UDi+lF9pcyf3UzsJqGM=; b=Dt5V
	Svdo3ZOk234vAPUiBRwrrcFA/qNuc+boivf9NVmCZiCP2S2fQpr6AjiRAPGEgcw4
	O1z7d7GAcu9huRyrKn4mihZmP8E0RTQG8lEmSO9t4hi2LtQGLZs9sokg8Hbw6UfO
	mWbKBufmtt+nDau9UYX1dkrFVUyOyoMYaOdDpjCQzcb3VC7LbnVh3Rv7KGw+5HOo
	G7dnUoFXXODkL10Q6kDiE3SyLci/QWQzVhEru95xJOWb2AwDRwc5jUjyJsQBl1uP
	scTpwuoeVPi6OonzPaice7iDQTiihKvA5tiHkzmptOKzcZfTkLQs4XH/9rP17jq4
	mDsannNg9AcGuXeCtQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hqqbkbhx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 17:32:22 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67686ccd1b6so1639310d50.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 09:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793813542; cv=none;
        d=google.com; s=arc-20260327;
        b=QpMFFdIh4fwR2guHUGVVhWRfcVw7Zc00qqnZPiMCj6BP57tqRg/WbhpKKwg4h7noQC
         vGjGZ9GvAmGWxbDlSTbCTmmZb1CXtAsEZeJ0Dzj9iO01fIyShkwvxmq8/4XRMVZH4YZn
         XpUaQ+Ek7ZYigvda/FK8KPMnFZD/zsMcUtvDcpoY2WfWmIvEX/b3BbewAss40S4cblXI
         +qTcHn3WpsSsE2YiWxOPcQIB1IkWrmJ7jEx0FdC4tZX4ZWUx/ho2RNtPzb0tuHPPulkp
         Ut6P/2Yn+MJoNGzSIbv+SVdX4NpM7bqd5TgHe7s4d00ECasg+yYs4NGrrf3KMR9jeYyg
         c83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z6UdjSgjbr16sAlbbQelmPR/UDi+lF9pcyf3UzsJqGM=;
        fh=Aiufc48Pg5t40AHsnNOj32gTvKej6yNOe0jh6uJeZfU=;
        b=NUfl9fJehLyqAJqVdZFVqh2xN9F5YHa0bhGKqmf9VXHR9u2FwKb7ehDXRAX0tl+O4g
         N7V/DXsVWfEF1YC0XhBJua4XrUkHcQbnwGjGVSTFILdkBoW2nWZ846GxwVtw7wcW/c0K
         ZUyYis6bQn/4dv37lF2cGVOUd5Rps/RTwrDznWU2SO1c3qNgp/1FWKWG2K0tf9ZSh00e
         Ad6S0/39EX5GUuC9gfhKTAXhGDGllZ8d3IBTG+vedAoj0jtpuR3GxSxOZdR2IYLE+5Oi
         onPxXtH71HqNoCToIoTJxdP4hmauGiS4LYeRTT5Rx2w3YpDbm98Bvd3TDRf1duMOrjQN
         qvPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793813542; x=1794418342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6UdjSgjbr16sAlbbQelmPR/UDi+lF9pcyf3UzsJqGM=;
        b=GSheZoLCnRLop9YjiRiWuLtaZ54mSmKaHXGynJjKoCXQAWvhQbAn8pBy/m2ZCrrEoD
         b4HCuOrGWuojpnluZbHC5OLrtoTKK99QAhNLAL4o6KOW3pLhbDNS9kc1iZO3Ng3ptDRk
         WDrr0iqhmoRlWbTCxIx6E899EEFpnch4SJi2QNoG/SJ9habUfWRq8jCn73XsmoALMZqa
         PXNxfEkGt1enTdmiuXg74VTRBgw7WdYIa8i+A2yUfMJbY3DoTDd0TWe+imrIfiW3MSjc
         pamX/PIZMPeqMv7wrZRSlp2DcLmc6bagVX/nFhXQ+6P5v9MUOh+bsBp3px0BHXYt4DmH
         PMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813542; x=1794418342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6UdjSgjbr16sAlbbQelmPR/UDi+lF9pcyf3UzsJqGM=;
        b=Wk03fqTyKwuoi79fBscEUiIG9rzseyJ351GfajXV7OeMGuQd70RBCB6Y7AVVkYEbar
         dy9RtB+D2mTgcquyw0/A44aAh7zZ2wBg4UleW40O0hMTJEepivMkSkr6TOgsj3jZmz9u
         J0I/y3k2jGJX+yVJQ/GNI+A0jHSSfy9KfDQWbYR2ohPAFqlyr1A/n82WdhYHAusFg0X/
         5jtNLORLihEPf57nTkKU+SmqSAzl4dlNo51lenpT19lQDK/sQ19jQLtupPPZhyaXuYGy
         vYuud8Q51qzZhA67l/JX1EofNJ5K6t2jsDIDP+UCTLiq7xsycxeCRpoLRmtwl+3iGAwc
         IvjQ==
X-Gm-Message-State: APuU4Z9ql6QejHp1i/tJFxKg6ACwa4kH4GoOOA4Usn/z9B6H+vxoK7c0
	m1EqZKfnauZ5PBMBjIVXCqOVOXJtnv9V/4ScJgPdLwvYYlYpNosyfy2bdw5J48CD1zQqQYusnUC
	djV54J5t1Ef2XUKsLVaAEAXspIIKiouejlTKAYM8sfZ1ju0/5QdxSs5DCcaC7jr7c5eZUtJY62w
	UvE8OAzFshujzW8ZopG/0RBo0gLGRSX/J3
X-Gm-Gg: AYBFou3sagO7R/zuiFNeBXn5Wl2HXnT0TZknvl4Ms9pZyZGuferi3Hp4Dv22dP2of+I
	fm20DjVHWGMNWFb/OgePxepOApTv13dCdMDTr3e3qroxNPRdCHNvki7ugTyURrRPTzQfEDIOvtW
	5YzOKlX0EMZUFzt0zhBT2E0rLi188rnBWlCHO+f87Zl3mdYU7PwJNKfDyIYQ==
X-Received: by 2002:a05:690e:1094:10b0:67a:5135:1495 with SMTP id 956f58d0204a3-67ba4c920c9mr8214615d50.9.1793813542071;
        Wed, 04 Nov 2026 09:32:22 -0800 (PST)
X-Received: by 2002:a05:690e:1094:10b0:67a:5135:1495 with SMTP id
 956f58d0204a3-67ba4c920c9mr8214603d50.9.1793813541589; Wed, 04 Nov 2026
 09:32:21 -0800 (PST)
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
 <20261104083903.0d7cdb06@gandalf.local.home> <CAOu3gNiggAdifeAUpycoO-zGKb0k2-nZqWrtDXMXm_HXT8L1Vw@mail.gmail.com>
 <20261104123019.1f7ed0c1@gandalf.local.home>
In-Reply-To: <20261104123019.1f7ed0c1@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 4 Nov 2026 12:32:08 -0500
X-Gm-Features: AclHuK_-69KjMoOSHW4wwXVML8A0zelAY3elpFWlsz3dr-SY1maaekOdI5v5GvM
Message-ID: <CAOu3gNiOGxC7fhjz=tVnmrR-rofVzLy5R4VbV8Wsv7nrNwQ63g@mail.gmail.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable switch
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        sashal@kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
        Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: W7D0lA2ONfA_FoDGav-h_LsgVFqRtb_P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2OSBTYWx0ZWRfX4sAd/yIWcDzV
 LuWbiSe8rTYhKnPE8YekEzH093HLvH43an2I7R/9VZULrsvYf2r+XHDjBpzrsJIJB3swRh2n5Kh
 eJ/wd6MhNp8Mbld1FrdtEpy0tnQFjj4pid6VOdMknrkpFw33E5ZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2OSBTYWx0ZWRfX2K7Gxx1gmLEY
 mWkrRCWcv63GrFNRYCBARPNJmNdYTlMz3oOw77vMvoD+sQpYe73Aw4fZtCA+a/kM1VkTT+8V/2A
 SogJfB+c9uY93C5QJlFLh7U0d3CpUAd9LZYJXp/diG/p3SEiCjePrWvcWXuro2MwhJtqmYuPybr
 /uHlgNJROVNyx5YRX5IaQYOnUSQpx6warwMLrB6Y0sbDWG5avPXJ8crS5YZ6NRIyU0G9Vzm/RHe
 85gs94uwp/UKTDpd0+r81XET1lm4VP8p1MUD0XF7J3LcPwlQPB4kUJS5yr9tJXgdp+uL4yWBvpc
 SMk38VjLR0dNbFyWb5J47yRf8SPDfzeOaW1POhDUwsBIUT8p/MBsSs7yCUhgOwHAGcWrnKYEIQX
 lPN0ihbY2dE9n2n3dFUDFXf7yKueELCVViaJDdst0mNPB/3II7c0/3Xq0JEpzadHN7lZmxTTlga
 hykhC3S1opHrmnb+PrA==
X-Proofpoint-ORIG-GUID: W7D0lA2ONfA_FoDGav-h_LsgVFqRtb_P
X-Authority-Analysis: v=2.4 cv=ffI4WEQF c=1 sm=1 tr=0 ts=6aeb6c26 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=GCXdLZfFv8EKBZhKOxZ5:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=BUuy5GciqE4qPaj0_dUA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11956
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040069

On Wed, Nov 4, 2026 at 12:30=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 4 Nov 2026 10:43:37 -0500
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Ok, so just to clear my own confusion: do we want to directly present
> > this to stable as a backport fixing a bug, or go through merge to
> > mainline first and then only backport? If we do want to take it into
> > mainline then I think the selftest patch is beneficial especially
> > because Jiri found some case that breaks there that needs furhter
> > invistigation [1].
>
> It has to go to mainline before going to stable. I'm fine either way for
> the selftest as that's really up to the bpf maintainers.
>
> -- Steve

I will work on the failure Jiri reported and then will submit a V2 of
the original.

Thanks,
Andrey
