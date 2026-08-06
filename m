Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59961421227
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053151; cv=pass; b=FVchDMhgPddNoLtINJIPlDIsPMgORIvCIVtLqErxUOzWzIQARQPp4QXwDj/9Mtmc3mQ0y1up+39HuCV9N/n6feukeONgIXOvLgbmhnnbKRHcr1liFxkBcGkI8kAXTxpLluah0wiMreZOWE01gb4Fvmg0qC7U3Lui5peeCwQr8S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053151; c=relaxed/simple;
	bh=4j27c3ITXpBErSHQ7ijBlE2exB417P5mbmq8l9SQNdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/vZDm3ouOOdNnwNfE0izj66YnF07o6w9EJIU5AJ1p4wjviQkYWBKP1heWACtex9tnKI3plEhg7C4hx7lgNINLh3EbuUtSpjw3Et54+RURPAjYpDNlOwHFG/YXMqrRPNVUNNBhgh0JKataKYRsu13NBrOse6WyPNui6K2CEJojM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=EpeLMTVH; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=IG55PzML; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="EpeLMTVH";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="IG55PzML"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Kfl7S791582
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 21:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=; b=EpeL
	MTVHcxv76x1tW4kL6f0PWpDMX88pkGsCejHUiuCnq8z0xx8/3XgnQAU3IJt1F+8M
	dlF9iyMhSAqOLCD20RtoY2tYQaO0B/nGwS/ij6wLJ/JG0q4kd0JvPqCa+g5o3fN1
	PgtR8LsQ1hOLOsCNu6+TIqPh6YE+jQkRX9Ss3t1m1gVsWbIxXiIIgUdUAuf9lp47
	EWeUwFGewzkFtjI7p2IW1wTefeFIK4SJ5HDdA7/Jbo0oyC4YAJ/x1Lvr//tE3I47
	UiqVQlqgiUwwNQa0GEAvER8A4Shw7DvDm1pOnSZVOkAfRsb3DVYgHcmvS92dPX8/
	++RT6gGHJs2reTHbzA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fv69t8qux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 21:52:29 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81cb01c07b2so45731957b3.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 14:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786053148; cv=none;
        d=google.com; s=arc-20260327;
        b=eAH1EcnJ5o87Mq7yGx4YBpAGMR6ZjgdQV7h6sVUqz63ip13l8hvPTHvdsWRun06ExH
         6Zz7S/fBKXB31A0ChlOyaX+3oV8FXKwNnjhU2VGSxI8U3rpGAQgpMhO11vzWgH4dkZI9
         y+/Rm5TD4WZE/4/hdQuKD8GFJX2hUecCdTEb0rg/DeLO85vLlMiFjR0rAyky26cm/AQr
         uO8ykTM/ImY1+qS4j2TcPEONw+soK3FRMq68tYAIAmclxiZ1/qGxwJvRq6Jz8lezlnsy
         6SkRPXF+OuRialz/c+pTGOiFJYZBLmxhJRM3RoZak0MRnrB+2mxM5ESyFU2xqCWW3UXO
         LHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        fh=sj0SM2OwPJPTPGZaJHj6PmL2wIsoOAL2RjZrThMguao=;
        b=JyZ4MCFM01l+my3T7/fLXsn7ijrNniX7ubUxRi0jEiDj4ql5Hlvid8OfhZ6DJfN091
         yrN0cqPtyylMDw07lLLYbIKClCaojDdQaQD8JPCAmtcb2OHnOtF3QdhZaxsdYqMXAXkL
         NRYt7jRvcjK67TEIJ/TZxgFxyXyWE4vAK53JolX4R/dqjZTX+9l0BqTwtv3QSZTNPwlq
         ef7vb9GnghwCRojK2buQSHsZNt9V+tTD0+DjVzuxfxCKyrwzIaNuX4dPOZ8AzYHctQAt
         D9w90jYDTHe+Su7WPOqCJ0SGCDze2Q4fChDxXbVwtSbFrVho7RUoTQ7Ov1IVe89dYBWb
         16Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786053148; x=1786657948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=IG55PzMLLNCYWzhBq+cwUO8E5Of/wmqPJPmzTS/rAITe0mS1DjeD0Kbq0pUL86flIL
         mM25R62hSyAn/KkErAQTQ4RBXpFKtQmPlMDK7tv+tNksUA95j0a1M2x3NMXFulv0Dab3
         Dq3hIyDdxswH3aa2vR9XXgzXs3MEpYgtuVq38MKvsOGmZLMiltu8h3Goz5WbIm/9yQ8T
         Vz0AxXRbUpRUqTxvF1c7hnZitkUbt9TA37aIIgMkwbvUjHLy+lOecqNo95cmS7opkDuh
         pf4TfGlwHpDWNoc22BJC+HOX2dz6V03YoinhUMq/aEmUkmdm80HcaW3nmreO9cXUWTBV
         ESiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786053148; x=1786657948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=VhRyx3uCNH4+zLaMqDJAXIg93y1qmncMUMcBWnd1P1q/thD/skz6zXMKnhRFIqjh9p
         oTk7AhIiBViYiavhMiFP5lbJJZ8c5IuJ33RcZHdAUeZ9mQI7A2O3X+d6N9P7Vtg79fWQ
         Kc6DW4kF4H/E4VILpcEKy+a411PBG8yjjVZ97oWBcTD7DmFBkPp7qv76L3B1g56JBvga
         rmFGmEBnplQpUx0Ab81Foaj9nU3AFlYTAmqzdCJKSmnEcK/7INRDqljGdg2M+fdWhH2X
         MaxzA5FRKkPFBTFDouyztoT5RnaBs5xvjI+2rZyekNSmO9nh54ZxQC+6QEQtHVRlMJqB
         gPnw==
X-Forwarded-Encrypted: i=1; AHgh+Rov/73Fz8C90wuRZKLbXKdNHl9QskhLDIhBEBrYgV78db7VqBF1y7zzBvZluctdC1tdE5jql0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hkzi94LhAWvX4O3E/qwRJxHLmsny8qN8ST6VcpD1ljbJMHh6
	Z3NzEJYQMc3viOXGirbLnvQTh8bT6fzIQ+H9zTBSOzHu7GsPNM+Yh/3UucQc7C8uYftJJA0+ysD
	tUGqp4iomrmoA0vt4K8tN9cFx27BMAnvTf2NmFfQUIRGq0nRnv8RRzvbkpg10IOhR+dFc178X0h
	JS6lVRnz+pske92r2shRY39aNLlivygFSYqCKRnJEK
X-Gm-Gg: AR+sD10QamUQj7PKsiLqSe+2d4TGf4umZHyjfFNPIw3w1x+opFDd0MwvjOM55M8z8Hw
	17X5tbT75YDZa+lXxXj5/9P4TBUWgHOHZLGQxkv9uO8qa+og/JTYU5b1lm3SPa0LFmD4HL7q3n6
	spXJ/vcqNdH+ZzDbBhDSnkkQRf4PphBvr2iQZhUMcJYhAWxrqmsWMqKJLplQ==
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id 956f58d0204a3-66ac2e29103mr3422588d50.8.1786053148524;
        Thu, 06 Aug 2026 14:52:28 -0700 (PDT)
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id
 956f58d0204a3-66ac2e29103mr3422536d50.8.1786053147864; Thu, 06 Aug 2026
 14:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com> <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
In-Reply-To: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 17:52:16 -0400
X-Gm-Features: AUfX_mxi9cOXXsF6mNBrlNENbUcZVrExzFYiYnyltoL6hOluHOkwQ37RLslPbyA
Message-ID: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QYJWeMbv c=1 sm=1 tr=0 ts=6a75021d cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8
 a=VIIMA12v6iqWkxtvh5QA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: 3-5ZbsRK5wawCNrFgb3cKmz0cTTxt8RH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfX2teh8F/3LSUk
 Z5gpOWb8Pgyq8LjRKPI1wvbiEReRpT5hentuHJoA9ImDU1HECGwwagOnROSgTGCLxYRERm/CjWh
 oNxelbv17bcaeupXPILSWfyrDZ/6n9AIle99mh6bFRmGEtr8JMbiO53SNjKumbSwFFUj4RuEOe2
 akmsfd8DJeUGI1TDSUBPMtmJHm9paGH8w0gSmXvb4EQG1II3vr5GukvNLTzilp+sFiK+fey7u6n
 zv02jmXsoLRX/BP0zzdl5Ow8NycwtuczBlQIiE0fi8ammuMLF3FMLQK7gBDeOKTQCHGlOjmLRjd
 KS0rBNTMDYgeZw80Eb3OFajfjbOYXAhmU8JABrAWDvsWQHjKcxguS//B7Fua96O+FkeZrABiNPO
 sRgMaBC1XUQOZq3199QkW1ZO8u22xQJ0jBYKApX51VmWaKgouKiSKiyAL3fbceY4eH0xxr/MfWu
 CfdKfhfQLERvXw7xpkA==
X-Proofpoint-ORIG-GUID: 3-5ZbsRK5wawCNrFgb3cKmz0cTTxt8RH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfX7spehzIGvbIz
 62fueDyaWhpKYCTX6FWH31VFw9UdkJchkt9/KrCr0bi7YlHJ9r5tZecttq2O5wLBC8xrB7msED2
 wW8RpZX/y1tmIe89ec/1FBvirI03tLKMz9rE6Z5Nm7zy1/H9hCkn
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060171

On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > callers rely on ftrace always being on). Refuse the write instead of
> > leaving it in an inconsistent "disables some, not all" state: return
> > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > unaffected.
> >
> > Update the docs to note the deprecation up front.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
>
> Sashiko's comments make sense. Other than those:
>

The bot has 2 comments.

In my opinion, the test-breaking comment is wrong as he looked
strictly at this patch w/o reviewing the follow-up live patch testing
changes which update the tests to avoid breaks.

The cleanup comment is valid but since we aren't sure if we'll need to
revert this change later if it breaks userspace in some unseen way, I
wonder how extensive the cleanup should be? Steven, can you advise
please ?

Andrey

> Acked-by: Song Liu <song@kernel.org>
>
> > ---
> >  Documentation/trace/ftrace.rst |  5 ++++
> >  kernel/trace/ftrace.c          | 43 +++++-----------------------------
> >  2 files changed, 11 insertions(+), 37 deletions(-)
> >
