Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD94A13BE
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971903; cv=none; b=ndDgiTDgCuYe6FuoFthNnab+b2prKe5jp+aGjLwGgyN2TnJnuOz9YjwX0B0E0V8ZtGXHbqyXCyeoa1RlR2DeS2gXRRSUlY/DhCZbAhE+vsm7Aw7lwUGcejP9h9xdCE2+GvCg8DSjHN+3eqNVfd6utnm4NxKBcqkJMT7arzkgkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971903; c=relaxed/simple;
	bh=QRF1ppEabvf/Jh35Rw2YAMaC3v5QUSgiHFDdxHpxbkE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rtp+A2tFbUFwJaU2IevzHW0llCmP7p6ROUTvPY06Bzaiqtgbgg8KoAljbBfEytif2v3u3CimrVrHwEBsCCNO5kg8/3/xUvlZGkCmwA64ma7rQXzv8sj9JGXpzBnnRuwd0MbDMWHiMYxOVKuJnw2vZOM+R03smQOmaQyRGXmLBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2BJ0SjB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jc0rRYV9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2BJ0SjB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jc0rRYV9"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9eB2Z3696121
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/G+DzcLKPK/Sj5Hw9eJXYwgew9ReSZ4k3cWf6CS+x4Q=; b=m2BJ0SjBVLkB8+nk
	mU3Q714fqH3TC9lBW3FDuODeuavFXB6xnS8Hd2Qjh784rNKgbSw7dyGqJp/L+uGk
	iRZO7LA85T3q/U9+91enKIcZsgyOMdF8fbSD0D4r46FL+E4lFfEOxT5Bd72dkZFB
	oq72Ra4jiojnHroJ1cYr1otgxNf9U68dWwkruULdiOQ8QYD9QTGYdt0v5QtVxqw1
	zxHzLep5SBhrpj3+aoDumtwt6XaxH9Uip/PVcuoD9RPzzPLWtoXR6w8N8fmgsknl
	NZ/CtmMW5kiGszak9N46nUdIGO5iUhn+UOBEN85io4sSvP/UFeewVQuZUrUtVAlc
	nF1DBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aeg2ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:58:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so786537085a.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791971900; x=1792576700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/G+DzcLKPK/Sj5Hw9eJXYwgew9ReSZ4k3cWf6CS+x4Q=;
        b=jc0rRYV9aMLQ8LHq012MneanIvECscolySU6azG0Q43R5gc7gDB58ehLwiIcOZjcEw
         jw86efzuXoolbElMDDxqNrJGZtwTvjQjqlTtt8xzD4wjRcD40w66g8juoMCq4y/t9siq
         4N4pDrN7tL9RmZM6IdKBKdz2pjCEDcMCl6OrHEQjO/DSptwpHeNm7uRKhn/JNf9QnVYf
         /8+6yyFQMogFKwXfo6gHaAU+fOEWs7s5unX6/vNYM2OfDz+lDagTuBSXoCwJfGyqnV85
         aOHuGy7xeUhiiqs3hBVcAioVavzkaaN5ZYPcx+ZEoW90fjsmPcC7obgyFjsqQxdu/bCl
         mH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971900; x=1792576700;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/G+DzcLKPK/Sj5Hw9eJXYwgew9ReSZ4k3cWf6CS+x4Q=;
        b=F5+mik5d6+nB/QcnAEfmlU/9zWSH17lqkEzyzfJrAT4gu1mHIJLnLtgkTE29meFQz4
         w8XDsnkRY4nLrGmAfcqm/uc+9Ic7xs+Osd34cMLKxjROojQSlIex4sO1ywhDko4UDG6l
         0rGgz/MTRNTw8K8DFp2DTnyzYVde+PqNVRoYf9eqIzR2qJnrqvF3BUIRAPfIHa/m4OqN
         45AgeIdDJ2qQg6O8xmnKmyF+MEnVWzaHyKAeeVbmP8iosmN2TzvkmJmicwwkBVA+J3Mg
         W7pzJVLTAtFyzPhfHcesAKYLqUodCibn6StIH85dXa7on+TMaiFYGNJ1rs/vU8SAGbJ4
         nhAg==
X-Forwarded-Encrypted: i=1; AKwUvBzTX8JjTfOT2y+bOGnDpZ8AanVIQ6f+xAkuMSDA3XB+2VrV/PuuHZ1NIDa1ktC3qgaNIPWBs6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ2TDtJinOqT8BfA08FJDzV4OjrgdPoiwlebpdvThZEHk5v12m
	N9Qv0/OrMZ16au9NlQzCoxSG4oxCtCrjcKSOb55EG6ss3YGBt9v7CnjQpGMdhEDV2m55Tjucwwz
	RgCUbFijutyMqMpd903RIMHB6MBmRSoBuveGUmE31rvoC/02pcgT7XuLJ4jw=
X-Gm-Gg: AYBFou1sd1wduMz/s6uLzbFDREvnSgMBQQNIIUBu67eInc9k7yOzWfHz3LTGVqLNyi7
	FKQExtFZtRFdiDJEzjW+tlDEws7gKvcoODa7Ockx3eqSX5s4nCBIT6TxYhhumgUYOTJJD8eUO5J
	J5M7T6gPdWGGYuZ4ko1qp8ct2VAfnexi5mqO0i04kS3mprZndx9++sI1KDv4q3IOcUtJWYpCsHy
	1oGA9tiYElCPLfzNn4+J6Z3/tG1abYV28Gqp0LvXzSu0x1R8muUWAziKFl44hSokePOq8v/YHWs
	UlhOVfT5QXNStDhTqqzFarzna8l9g49Z8sMf1CYKIVhn8ZbB6eaE+43U/qNdUBfoIFd5fqkHM6Y
	cUOar+ET7jG29bSdyj7aQ3IO9NKLi9wulnn2MfgbCI//Hu5SFkMM27U/erx6AQltXXmtdAYQXyX
	1PUSAb7j9ZGOvBVhiCkUvifI11hSE+yFCxbx5qOOv+VfaUWpRNYfzs1AKTnNNeenUTnA==
X-Received: by 2002:a05:620a:198d:b0:93c:72d2:ccc0 with SMTP id af79cd13be357-93ebd1b7168mr2353686185a.17.1791971899990;
        Wed, 14 Oct 2026 02:58:19 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:93c:72d2:ccc0 with SMTP id af79cd13be357-93ebd1b7168mr2353683285a.17.1791971899387;
        Wed, 14 Oct 2026 02:58:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c338d5b170fsm461989866b.75.2026.10.14.02.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:58:18 -0700 (PDT)
Message-ID: <b64b8092-93d7-4873-a55f-422b8e70cc04@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:58:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the
 complete callback
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, regressions@lists.linux.dev,
        Mark Pearson <mpearson-lenovo@squebb.ca>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org>
 <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
 <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
 <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TrmM5M0uj978qeQ-pSabIdKbm5jrMHkh
X-Proofpoint-GUID: TrmM5M0uj978qeQ-pSabIdKbm5jrMHkh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzOSBTYWx0ZWRfX9u+XlR/U2yd5
 vBn6KKN/+wop5fwliBSUeMcmujzDKpjgvOEYwtvOhs4cAzT4Az/bsesJEvuXfFZ6qLEKP9/+sVr
 Z1+Cnov5GfI5jMlfFhvdOyftBL+HTnc=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acf523c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZT-_DgOL5kLWaA04cYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzOSBTYWx0ZWRfX+KX5Huu79O4N
 LDaCY+JkWWHUq12s1VdW5ee7OglzMIyRGud7S5g5rM3bgycKg758vXHWNZLMc+bHzkad2vGqibp
 XJT6hwAWYYaq5JBvR5ARZYfQg/DdE70VVdgD3ot8hcsyyG1xzmT7+/2bmxPafB5PX/imio9ldtm
 /0/aWxUIcg/n+3aKRNIeDv86vB9+zqi+PIY1dUqpOnBbM+okmx7t0ZkWNwZaLeFpkjuz0a6TwNl
 YlNq5+CyHxoCDLNQmkgIwCqC2ItEJBPpaSD2/aZqCCzAuqcYZOC21SY6BhnntjmeFlRpeosf/TI
 XuAiXgTn+wT1DzgYU8d4EmZvheW7tt/SXt6TeHR7l81VEss3CG3xnzaSTxT3nWVQiN/fxMvkeXY
 /ddjrOxAMljUqiRtxb9143jkPeKxTPAOzXyj8VdD1xJQAMIOb/1Y/tUg3fCTlHMcOQ6KYiKk1eZ
 VbXz66jdbt+tZQfPp/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140039

Hi Rafael,

On 13-Oct-26 19:20, Rafael J. Wysocki (Intel) wrote:
> Hi Hans,
> 
> On Tue, Oct 13, 2026 at 3:36 PM <johannes.goede@oss.qualcomm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 13-Oct-26 13:58, Rafael J. Wysocki (Intel) wrote:
>>> On Tue, Oct 13, 2026 at 11:33 AM <johannes.goede@oss.qualcomm.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 13-Oct-26 00:46, Ali Ahmet Memiş wrote:
>>>>> Since commit d33e89d12295 ("thermal: core: Suspend thermal zones later
>>>>> and resume them earlier"), thermal zones are resumed from dpm_complete(),
>>>>> before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
>>>>> ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches the EC
>>>>> page selector (HIID) without taking the BATM mutex used by the battery
>>>>> methods. ACPICA releases the interpreter lock around EC accesses
>>>>
>>>> I'm wondering if this "ACPICA releases the interpreter lock around EC
>>>> accesses" is not the real problem here.
>>>
>>> Yes, it most likely is.
>>>
>>> What actually happens is that ACPICA drops the interpreter lock and
>>> the namespace lock in several cases listed in the
>>> acpi_ex_exit_interpreter() documentation comment, the majority of
>>> which involve having to wait.
>>>
>>> The bottom line though is that the interpreter and namespace locks
>>> cannot be expected to be held throughout AML evaluation because it is
>>> not known in advance if any of the cases in question will appear.
>>>
>>>> Recently I've learned / heard
>>>> from a trusted source that Windows ACPI subsystem is very much single
>>>> threaded. So it is nice that ACPI has these mutexes and other stuff
>>>> to support multi-threading but as long as Windows ACPI interpreter is
>>>> not multi-threaded I think we may need to consider to copy Windows
>>>> behavior.
>>>
>>> This is also my conclusion, at least to some extent.
>>>
>>> The problem with it though is that in some cases parallel evaluation
>>> of AML is actually useful.  For example, say two PCI devices are
>>> powered up at the same time and AML waits for each of them.  The async
>>> suspend/resume aligns those waits to take place simultaneously instead
>>> of serializing them which allows some time to be saved.
>>>
>>>> So maybe the EC accesses should keep the interpreter lock locked during
>>>> EC accesses.
>>>
>>> The problem here is that it is hard to say in advance whether or not
>>> _BIX or _BST will access the EC and whether or not that will clash
>>> with _TMP evaluation for a seemingly unrelated thermal zone.
>>>
>>>> And even go further and maybe we need to introduce a big-acpi-lock,
>>>> which I guess the interpreter lock more or less is? And just serialize
>>>> all ACPI accesses since most ACPI tables clearly do not handle
>>>> multi-threaded access to ACPI methods well ?
>>>
>>> I would be inclined to do so except for device power management
>>> methods, that is _ON, _OFF, and _PSx, that are not the problematic
>>> ones, at least as far as I know.
>>
>> That sounds like a reasonable compromise which should fix both
>> this case as well as help with bko221065 .
>>
>>>> Another example of multi-threaded ACPI calls causing problems is:
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=221065
>>>
>>> Right.
>>>
>>> So I guess the idea would be to add locking to acpi_evaluate_object()?
>>
>> Yes that seems like a nice single point of entry to do this where
>> all the various helpers eventually end up.
> 
> That, of course, would require updating ACPICA code and I'm not sure
> if doing it upstream is useful.  For example, if some hosts already
> use locking around acpi_evaluate_object(), this modification won't
> help them and it will certainly be a change in behavior.
> 
> This means that we'll likely end up with a Linux-specific divergence
> from the upstream which can be lived with, but it won't be nice.

Ah, I see.

>>> An alternative might be to introduce an "exclusive" variant of
>>> acpi_evaluate_object() with built-in locking and use it in the cases
>>> that are known-problematic.
>>
>> So here we have _TMP and _BIX / _BST and in bko221065 we have
>> a bunch of again batteyr methods + UCSI racing. I'm afraid if
>> we add something like acpi_evaluate_object_exclusive() we'll end
>> up eventually using that almost everywhere.
> 
> While I think that your concern is valid, this can be done without
> touching the ACPICA code at all.

Not needing to touch ACPICA is a valid concern. So I agree lets go
with a wrapper for paths which we know need to be serialized for now.

And then add that around the battery methods + _TMP + UCSI methods
for starters I guess ?

###

Should we also stop releasing the interpreter lock in the EC code?

All these things (battery, _TMP, UCSI) seem to have in common that
they might talk to the EC in some cases?

Where as e.g. your powering-up of PCI slots example is unlikely to
talk to the EC ?

Regards,

Hans


