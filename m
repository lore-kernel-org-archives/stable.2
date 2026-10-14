Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEA53C3A3
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986429; cv=none; b=SlWgnovs9/9zTGQQBzkXf4pRT/EQJeSOVqYclvkYiuKcUb8quyXmkRv0qyazWDiwSMWvrbOpZ4jJn5AjZY/Hk7FonO8IeDkEbSbp11311YbZiS0EeYbiVECseC87a8VILTRZGDXIwKExQHaBssDaRI77vhlFSUOhijOu41uDu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986429; c=relaxed/simple;
	bh=Pxet30TRJQtNsCxEqkZUTERC6HZaIwRxrkW5u9k6X6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zba7+jZzsljLdNRutH5BL+rNgkt04UZjefnLCNJtlKbx2XQxq+qHXRAzK7DzWJ7U1OTK+qwn9YbBRCebTyvB8rwEic9cE4Jxq9ZZCIliqmVl032O8R+P1bYElGn7CBj0+FbE6splUUMnIf/uhfvGbE6Ib8oJQcW02LtA25sU4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TM88gY/S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CDXbxrKM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TM88gY/S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CDXbxrKM"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBMeBc3952049
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=; b=TM88gY/SAkuivGf5
	+yFWFP4405hUK4+veo6xqA8dkTVtPOBN96tlIMpYl66yC4OPDWEYnoW3ostFzXvP
	/QxUnuWc0oekyclc2OdhCRsz5NQpn2pHquNClmYxC8hHJI53iRycdoczS1lXAgZI
	8cRopjdlyX11Dhc+gxJTAmnlJTHA6Cp3dhZGg3sFugbI8Bejo2l7JRCnRlhG7hqS
	9RwcaRNDYCak+N0+yJF/bsoqIDwaXOAOkS1j44CS8KXp7UpUAFQdwmw5tRig80oR
	UJTomABLqeBTPY0zH4J+6r43Lbga/EYLgEjqPjknpgEBuU59+4pW3FR+37AKi2Bi
	l2Re3Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p1wx7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:00:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e834ff4d0so1128343985a.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791986418; x=1792591218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=;
        b=CDXbxrKMNIAdXZ03dLl+KTIi/Y254jbAGd42kPLuII6veiB/By9Vn/UkLtAChuPlfX
         Y94DXCIUe9JjBjEDugbjUd83Y/t9f4L2dnfiOkUVHkiB0pXQd1FInOQu7oU+cn8Mgt07
         adJOZSoKY2VKdfLowtb2Zr+FjzmPpmVv53pR4VBsyDJmYVKEf3N8BzJ1oz6+z5jvuJbz
         E/8TUljvVT042Eq6OD3OBz7Xvxhica7JcYjexxXetCV/IdxtOhpTrYuqOvAHrCup7AVT
         o2XhsyAgJBl1ANr8LR6Je8LLJpR+nBZjAZQYjsWXfxEV5Pc4HNTQrJHEtIlLsy3b6Ivd
         GGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986418; x=1792591218;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=;
        b=A0kQPvxB9krhjd1ykyy4EAN3XWhTNb0sj1LJ+O2EjfUjosKEVkdz32tkTLn88vwtCK
         u33+JDIw3ZnTO1UF09xNIMUtgo8LGX7gcs8arNvUEJA1CZHXw03qzUwpItGwqttUSJXx
         xq+/FtZKaTrT7/HpqjY6lPBhs5IpI+2b7tliuX1dnx0+uD6lZEJ/x/ppDuAAOCD7GLmc
         odSz4oGn64DCW/CtSQ+y3g8EQHYU9/72moIbrDKHqsIgEeMF6810Zk2x4xHs/H1hB3VL
         6raJ941BiBggIlfC6P5p/yWBA73gnw4vemPKSnltAZ71WuBuA9KAhnIbSOOYxZ7oELZW
         jVXg==
X-Forwarded-Encrypted: i=1; AKwUvBz6XErOX/H/Szqrb19sdXMdRbOuke5OMk6zZI+S/gxy5utU9MGd2F4ctlXwAnrdfWh7IPwNUx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1bdGHyaQaL2yBN6Lo/b/ZIgeYtXnxVs5Sf69ta01dws8i32yI
	+9aDmdv7Xwnic2TsH5ImC1/uX6W5Y8T4A+NToK3bJCU6P4SNeTv6wEGbmnnKekbvWVN2hsOaAo3
	rKjd9erZXtMg5GBtVZz7ubfziFvS8YhL6FfoKt4DHBy1f2+lah6KbjerwOSo=
X-Gm-Gg: AYBFou0GuB7I4jIFbLX2FYSCb9/RXs7TvGBb56ES04CMv++BQPXEd1hI70/1dlQ49Xf
	WLQ94f/NIRG99cIgM+muyacUQCsgZgl18Z35kjNnJBbDj3bAnCilFpbTaJ7KnkVax1TGIpLJ/VM
	lMedvDxP8KthoBc67W2TPlFvkoFpQOKYC/TuQgBFwCX55rtbnya8IpoDVtjIo3trH+1aOrq396r
	djbS+Ric9Px8usIZQXVDOsvAmiB36BjKciuXBKGfQt81EBbW3skVXqKpwOFccgxeyZnfpANwAv7
	XYiBBs1X/ZnQIWBTtuE9lKXX1RnIDx83dfjFFnh0beY1FjHRvqPbHzI8DyTawFj54Z20wg3SYMf
	wbLiwongjzhWrMt/grhV17aZYsNTFalfWxzL+2bUIWLfpTEEEO5D7gMLot5/N9cjfpts1J3mkQ1
	zbztsCk/ltOmFmbcCEdXV4M9cPOX5UrpQzwrtvD06rSpw52umA0s2Kpwib7v0QU1hOjg==
X-Received: by 2002:a05:620a:460d:b0:93e:4ede:8976 with SMTP id af79cd13be357-93ebd224c25mr2846061985a.26.1791986417263;
        Wed, 14 Oct 2026 07:00:17 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:93e:4ede:8976 with SMTP id af79cd13be357-93ebd224c25mr2846046985a.26.1791986416149;
        Wed, 14 Oct 2026 07:00:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3b3836547bsm73203366b.13.2026.10.14.07.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:00:15 -0700 (PDT)
Message-ID: <a8d28d1a-5bc4-49a2-8437-18d1ae9d4f51@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:00:14 +0200
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
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>, Charis Stratakis <c.stratakis@proton.me>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        regressions@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org>
 <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
 <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
 <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
 <20261013210609.8117-1-aliamemis@disroot.org>
 <ab5c5ae1-1bfd-4fe4-adef-fb64b5b3dfbb@oss.qualcomm.com>
 <20261014133218.94357-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133218.94357-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfXy4EY8d0eTAKI
 WoOw8rKMMg09m2G4rZv+CErC8NFZd+eUeiyGTfJotseB9Pr4c7+FdLBDJGemzm5DBgT2t8d4+kq
 IWBSVL18f0kWn3Eev9YAniIqVosLNT0=
X-Proofpoint-ORIG-GUID: yljoHOjSm8sZBhXzzpk4S1SESDJP4DiM
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf8af3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=uisTf_hR4FytVPXRX4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfX5LHmuS/0TZMr
 XfOxPtTE2RZK5zV0CSS9cViwYuhPzHm/QMkULj4st4TTVi+YW3zfPBn1k6i42V9Bp3LrNLycXwm
 QkgcaLGQAyy/YegyNlV4kWbGmN1EUxx2GLRCo6bVKTubgWA2ITN/pNloX7lFLepG5dNRYZ7QcAE
 c11cwa7WM4h9h6Nfbca8w9n/E1LDGhwU3cwQ1eesAW5stPWjtq2HBhrFFXicj1eGrfT2UpLMZfz
 oH/avTeKXkiXSHLuyGlgaChIfZLXz/FDNikmuXIge8V3Ld0ekIn4W0i/ufRmyOA+TWK5I5YreJV
 didlUITNB644tfRU4dr244PX/MFFzapp10SeBHcOS1FryQ6MtrVZYQX+56VSJ4yDsf79Dp2hKKv
 hsN87OD/I10cYT3rDRqGkL87i1rp48Vmqqbpzqmt7BVVEhVWKUiRP6/0/DODlBVAcjQTTLfNldC
 WoFAk50xgSb0RZBZD0Q==
X-Proofpoint-GUID: yljoHOjSm8sZBhXzzpk4S1SESDJP4DiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140055

Hi,

On 14-Oct-26 15:32, Ali Ahmet Memiş wrote:
> On Wed, Oct 14, 2026 at 12:01:55PM +0200, johannes.goede@oss.qualcomm.com wrote:
>> Can you post a patch series for the code you've for this now ?
> 
> Posted: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/
> 
>> Note I guess you're using LLM to help you with this, that is fine,
>> but can you please manually shorten the commit messages of the patches
>> a bit if they were written by LLM?
> 
> No LLM used here, I just thought the race needed some explanation.  

That is fair, sometimes it can be hard to find the balance between
including enough information and keeping things short and sweet.

> I kept the series short.

Much appreciated, thx.

Regards,

Hans



