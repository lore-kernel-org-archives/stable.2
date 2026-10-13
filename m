Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB514F7CC9
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898578; cv=none; b=OV2nZRfSfxTQETY8iOlgP5SW2Tz47J3xrwQNSkl6u+oZ1x2zF/gq43d++tjaZ/KILthJN9fjtVWHDRNDsQ1EkXX7v5xqsXJcVk8ZgPjjMWBANlGZMKli5ESpIxzwq3WdNNCT+KZdoWx+GNLhchMobBbWvWpKnsFZD5X8ado5khg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898578; c=relaxed/simple;
	bh=Lgk9ryxB4wlwUpPpSqjkNiShbk84CUmjVZpN3Z805q8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tx3Agm90N0UTI437UvbW6/ERlWtcq5ufLSmNcAf0OCNcfMQNOCycfZlxwyHxXRVo+aIjd3gxiYarlmsHepIjPay55WLBo89Yc0hlnkUw/5mbO7pocTfdyj/SPY7AP8V7JaAYR/cUOve3rQmNN0dh4yroQMAluVPEiTxXZ7UKeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EnpB4CIG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWxCrU/0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EnpB4CIG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWxCrU/0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Pxmp3907367
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XHPs2aSg7qSq8sMw0lMTSM9cUyOJg6fhbZjMyvCBsuk=; b=EnpB4CIGyiyHOCa/
	WJm8PKkFr7sbTbIFH25UjbupMh8sqKOQHk2Euz9Su4u859F3Dt18GjHbaFbXe49g
	pqkvtglbzqJ7X4BZd3Qsm55k685ADZXtLuv17lARW9VdbbUwFZz1M7oPeTisU+AA
	VlMNvpBgQaVpvhRdWdpYY4bSZSBTJheXZMXdyNprtO39lbNtEgpO86k053vRr6EV
	Xf88FwqlkYpYtR0LqdEW1JNg1Zv23mPV1y4aqpd4sSWPQ8PvonXXgzFyrCUZpLPd
	QhvqN4dkFd7qBP0s7qMWAsj5ztTv58e2Ikkajdkgns/QoPiRUTxJ5Kz1gqiHuh+d
	RKsowg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqusu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:36:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc359d9easo505891185a.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791898575; x=1792503375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XHPs2aSg7qSq8sMw0lMTSM9cUyOJg6fhbZjMyvCBsuk=;
        b=GWxCrU/05w7AD857SvT8dlB6WVAfiPmwBpoyQWl+4qDpxUqiNCCaJfnxE0fC0Pg0Qt
         4+TNpMhE0yoghwSpkOq/uick3D69XbiqPIKtiOl7etTctEqC+i/Pnci5zGxJ8xIhBmX4
         HU2lMe8bjX/soF5umjIFIGxPpr/AUn8044c8O/kIc4kjdkcnc2BA2OYB92rbNH0F+1as
         SBxYUVlxpRf+4taICqgRzlS9gijD63WAXNB9pJ127iKgl/viuzL9+LOq/lPgf83gEG4O
         KfG4oDRrY9Wv7XIX3Ws8IC6cwH/mB5Zj0pQRN34x40FVhQSbusfcHokkpXkoeLHIsyFM
         i2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898575; x=1792503375;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHPs2aSg7qSq8sMw0lMTSM9cUyOJg6fhbZjMyvCBsuk=;
        b=Q95wGb59Fp5IV5OlKOzNxDbF6Cu1VjWo77E1+QHs7QS+X/5TWkMHKNgdPT7TfzxIkF
         04eV8Rtl8/4tX5KzlpwQGHtr9FnlCPMhBeH0oZbB8RduyVHklOm6C2rU9UvjqTRevuFi
         9o92AcEdDCJzowSOquYN3q3CigZOHjSHNd8uxj6QgVAt3GoeFfudNPa+RBaoBKHfdYiW
         Ycvibcc3wA7zKdtQltjXtAJW32uaK4x4xVObg7vJP94UbAkPLr0lWtsN8/m+TMqxNID8
         Dc9TM0oiCVlN/Z3cFMyrYqBTpRSQcxyqXYM6Zy2l4DkF1E9RjeJwJBmlHUg+tPD7M3wq
         T9Iw==
X-Forwarded-Encrypted: i=1; AKwUvByavaxzeVmaeK+uOIRfThm8SziMSjptgo0SuzLR0lIkQ3WEncIH7ufN9WCdeJJvC6y6t5Km7B8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl5GdmmG2sXP219BlQL6JnX2RtoKX/LbziH88teeYi/Vh5yK9F
	fjdCo6ZeYq31BiYb16MtsxuGvbESnNJ/MpkJtJm1opGcdC8OTql2228LlkgzxLihhx8oP398Tcl
	tLtId5+tgoHY25r6MwuGek3k40TlVIDQZMRUvbRxWpBFu9/g0bxn4Syjc27LWAadig6s=
X-Gm-Gg: AYBFou0l6uQ5iPykJ4OlFsY9OzmhAUjT4LwCx0gJmunJFIKJ6FLhP2KTQRgqrc6hXft
	xsSSv8wqO+TCkqZii7PQGKlyPafUBIQIoPz1YYL/PH7iToj5GQ9/kAf6CtLFhXjAcFfz63ej2O3
	mPEa3hJBd4JWv0flC9EAO4/sMaejlu8/2LSgL6wKn66Y+cybdoeSphYGZdn74tVVKUqyxRXXm6D
	KFtikmXo/382dM4hJZ41wbpgUIJ0a1zMGC+9DcwQRUJeF3ymiTLVmZz5/zlj8ASr18anXTU9xct
	6md1IDCzdEs44HZ6dXEyBJbgEzindDADv8jHmesglAFcqpNohQ8SUEBAe6J0EfiskGCiwwa90PE
	iKljDAPd3UV7j8HavourprcPjXdf2qpPFQFQ0xPdnkS+fe/0bVnuSZJgr6ZA9NRfH9tbvdc/sI+
	iYG3Oar2xXJ+M4T1gf7lGixaSwmrQcpwFgs34+i7DYhQ5G8HvrLR6Lrn/RjHGjl1uw/A==
X-Received: by 2002:a05:620a:3705:b0:93e:4ede:893c with SMTP id af79cd13be357-93ebd1dff48mr1978373785a.14.1791898574723;
        Tue, 13 Oct 2026 06:36:14 -0700 (PDT)
X-Received: by 2002:a05:620a:3705:b0:93e:4ede:893c with SMTP id af79cd13be357-93ebd1dff48mr1978366785a.14.1791898574001;
        Tue, 13 Oct 2026 06:36:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b1c27f0f3esm2632349a12.27.2026.10.13.06.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:36:13 -0700 (PDT)
Message-ID: <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:36:11 +0200
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
Content-Language: en-US, nl
In-Reply-To: <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX55ZwJXhHA0W+
 295UrN9M4XU4efvzgrPOd5o1pXkHiNWqn8yJU4iUNNZKBzCklYakWuqS3sFlWYF/SUaluz2xrwH
 B2MKR8jLQAeMDZ4v23rl1TqZS3Wy6ZhEcFtjJ2rHCXjmeTKMsxRvNQMnmUNF508AEVr3tLj3qwb
 xV6p7rS75OMytNtVZLIadu7yPhE0tnM3LdWu03WbXZtIT0QqXz+pj6iW75iYdOvgMDMiP5MEbKZ
 YIO3sjmN+8O11B/dpO4BMn70VNS/tFEkZblhlZSu6BEdLV7+oambrcGjeN+H3urfnEsR8HwNZ+C
 vgLBxBZk3E+kJW5Tk/+2uEUji6rjAv21v6elBELxPsUCemjtYTXixdLQTXvHHn2NE7kOBcwfBdv
 +xoc4EE3ohaJUZ1QmsdnvqMAqmStlJ3wcFhrstyZagKTYL9S28UcoBO58L3gXyGnkZPPfa6XW/P
 LpdtJ4CfVNKRe6/JHSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX3J0AlLs/4Z3Y
 krOJ3fM9pl+j7N3MhHPRFGKNPCoFpTJdbqxARrnMiHr/TeH4ZDy+T8srWlyEq3ynl+D7YtXvzZR
 e1o+Ew5VdnMXBGVY/mHTcHWGWPrVZY8=
X-Proofpoint-ORIG-GUID: 7xglrBIIREH3zu6SZDJvuwunOs6HY4__
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6ace33cf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MZlWtUBn__QG1sgtjpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 7xglrBIIREH3zu6SZDJvuwunOs6HY4__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130054

Hi Rafael,

On 13-Oct-26 13:58, Rafael J. Wysocki (Intel) wrote:
> On Tue, Oct 13, 2026 at 11:33 AM <johannes.goede@oss.qualcomm.com> wrote:
>>
>> Hi,
>>
>> On 13-Oct-26 00:46, Ali Ahmet Memiş wrote:
>>> Since commit d33e89d12295 ("thermal: core: Suspend thermal zones later
>>> and resume them earlier"), thermal zones are resumed from dpm_complete(),
>>> before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
>>> ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches the EC
>>> page selector (HIID) without taking the BATM mutex used by the battery
>>> methods. ACPICA releases the interpreter lock around EC accesses
>>
>> I'm wondering if this "ACPICA releases the interpreter lock around EC
>> accesses" is not the real problem here.
> 
> Yes, it most likely is.
> 
> What actually happens is that ACPICA drops the interpreter lock and
> the namespace lock in several cases listed in the
> acpi_ex_exit_interpreter() documentation comment, the majority of
> which involve having to wait.
> 
> The bottom line though is that the interpreter and namespace locks
> cannot be expected to be held throughout AML evaluation because it is
> not known in advance if any of the cases in question will appear.
> 
>> Recently I've learned / heard
>> from a trusted source that Windows ACPI subsystem is very much single
>> threaded. So it is nice that ACPI has these mutexes and other stuff
>> to support multi-threading but as long as Windows ACPI interpreter is
>> not multi-threaded I think we may need to consider to copy Windows
>> behavior.
> 
> This is also my conclusion, at least to some extent.
> 
> The problem with it though is that in some cases parallel evaluation
> of AML is actually useful.  For example, say two PCI devices are
> powered up at the same time and AML waits for each of them.  The async
> suspend/resume aligns those waits to take place simultaneously instead
> of serializing them which allows some time to be saved.
> 
>> So maybe the EC accesses should keep the interpreter lock locked during
>> EC accesses.
> 
> The problem here is that it is hard to say in advance whether or not
> _BIX or _BST will access the EC and whether or not that will clash
> with _TMP evaluation for a seemingly unrelated thermal zone.
> 
>> And even go further and maybe we need to introduce a big-acpi-lock,
>> which I guess the interpreter lock more or less is? And just serialize
>> all ACPI accesses since most ACPI tables clearly do not handle
>> multi-threaded access to ACPI methods well ?
> 
> I would be inclined to do so except for device power management
> methods, that is _ON, _OFF, and _PSx, that are not the problematic
> ones, at least as far as I know.

That sounds like a reasonable compromise which should fix both
this case as well as help with bko221065 .

>> Another example of multi-threaded ACPI calls causing problems is:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=221065
> 
> Right.
> 
> So I guess the idea would be to add locking to acpi_evaluate_object()?

Yes that seems like a nice single point of entry to do this where
all the various helpers eventually end up.

> An alternative might be to introduce an "exclusive" variant of
> acpi_evaluate_object() with built-in locking and use it in the cases
> that are known-problematic.

So here we have _TMP and _BIX / _BST and in bko221065 we have
a bunch of again batteyr methods + UCSI racing. I'm afraid if
we add something like acpi_evaluate_object_exclusive() we'll end
up eventually using that almost everywhere.

Maybe do things the other way around and serializing all the calls
by default and adding an acpi_evaluate_object_unlocked() to be used
in cases where we want the speedup of multi-threading like
the _ON, _OFF and _PSx you mentioned above ?

Regards,

Hans



