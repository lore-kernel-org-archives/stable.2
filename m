Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958936B93F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237271; cv=none; b=N0Pv55koWIwI+goC1Exo1Zz327qq9jtbA7MhOz/GcmwXdH53aNNZ5v5suFcP9eRCpN9hOBamtO/11X3u4fB5Ob4q3olkqNBX3dZFJWhNo5ayr+rESIertMmVFPModDJYbyAm2jHHcbNHmRR5zTKrw0+ugGG9o1J8AK7R4Mf3S64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237271; c=relaxed/simple;
	bh=qIVQNmetZ+9Je80JhKTUBN/bhZyc0umpRAFBQGCaHVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDn/0aDXHBhxrztyzxXT+P+n6Ngr2H5/sFs3gqGnmj/stnBD73Bz69KBFJwRvavXfsZ8imAdMXAZPELM0BTg6s+rM7wihBRQxcmEzmUsdqv2zmIkIy4KEJJRauza97vLgyta0UOTP7hVEj1I6a5xp2p0YzK8GaK8asLdcaoGFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dN4hVNRq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YVFMFZxo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dN4hVNRq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YVFMFZxo"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7dB53987792
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XkA5jKWJFPeAwLC7LOJ512QuTujwvvBJ6DDWfb5DnVU=; b=dN4hVNRqec/PQpy4
	7L0NoWIJ0JbZCd8Yi+gSH5Ju6Qbiz7IXjY2czlkv3viRipvnpEHNRCyijT0MY7bF
	MXlFsZKJ080KCQW5Vap7jv6NarqbPartTA6o8nz+daKxcTnhhqKaROxeOioc6a35
	Iveu1m5rmbZXybof22ZN5yP6j9vQ648WZqrNVgweyy1vKwRzVxLAu932ocIivN0M
	y2NUmExpDLdu2LDwMIXIRtQ98twGfF+V5KCeUyMU9pCXuPln3c9BUJnVbi/et6O+
	C5A4x4LQ03kvlFr/t8eUebFn7I49phP9Rl/EJaf64X7h43/FADLER7I5R8sajkOd
	jGCOXA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg894px-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:47:49 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-744e789f00fso88918137.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787237268; x=1787842068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkA5jKWJFPeAwLC7LOJ512QuTujwvvBJ6DDWfb5DnVU=;
        b=YVFMFZxoU0EciQ9GN67W/NaZ7QgwkCwgdYN/JEVIcb2Cbf5aGdb/b/ppgzSwZ/lD+b
         aybdn5DPAii+i0l+B47Q92C/IiSWa97YmESsoxeprq67NrCwWR+3yVG7kvSsk/CeynVe
         E6D/dJkjXScoHgPbeVRaF773K8ikDMA8UfdoE3IEGD+4MtPFqEneifkBL+WKqDzfSoaC
         JTykqAjYpfQavrhfasmjAp8VW6JWsn+R+yDgN/VWKFoBFLQbQFCH0MZi6sL5mwYkmceG
         iRAK78VDImkcjbZYg5wBNqp1FlujstfJ0Zt0b4Up57paYhCCyKKY/YiSXSHexcLn9Jz4
         mhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787237268; x=1787842068;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkA5jKWJFPeAwLC7LOJ512QuTujwvvBJ6DDWfb5DnVU=;
        b=ex/jkcER5uI9a/pTu0CMLGCd2j/CpFE+ZEkrEjVdTSILPU9CLQs2dxY8c20QPv0vhk
         TQpBhe7Fm+KlFz6V/8eNf1xJoAomEo5KLgEBomLxAelCHhPmGyx22hogrytT6MNlWXuG
         f5IKhFmcVFmf9bslxLeeuYqboemyDrzllnM+TmOwkUHtYH9NAD7Wkb/gc0YcZYswMeYR
         x+KBtH8EOcTSyQoGD/am3taIKBYzQLM8az7dhY5bT0agzuHgxy4oabCr9HdUEqT3sTRd
         b5+N4oEFTYoH8drVQfs08512OSATLORk/JHO3PsncjKJLbHvhZSHT/SL8NPPUElQxZOE
         g8tg==
X-Forwarded-Encrypted: i=1; AHgh+RpgBbProV73mnelkLippd7XTjGI4qUaPYTnfPhMoQb2ppBilTnua47l1rReWO+yNoiVCp5DfJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSxr/y4J+2nXoRv88sAu24Q5OooT6x5PaVm/lRc32Y6PnaphZ
	2FkMEeoq6Szzz1SQmo4NRu0aOVpNzUb67Z1xKxOUQkbwEsGimlQ++Dm7vDNayfTb9u+lqtLg2LZ
	YsrDB4Z0vWytC2MYCAknnc5oG8ZwOf7WIf4Vb75YJHAHFNty3PrOfuneZW/M=
X-Gm-Gg: AR+sD10/U3V+82REzfTWBut2ni9EWdp+HRHj8EESMXVim8wJ7kZyMB3A+2B0vcObpIM
	ru0JtJWLbql+33VLNrAH+ddn+2Es7Udsm/RJgVQPIkWqrryWz7RjfHM0x90ggpeZMdwwpUUip7D
	HF+sdG46nWnvSEmyXtqA5WizkTsRZMamC+N+/l/T45V/knA4AT6TeM6witUVv//cwSjRV0jMFqo
	OzPI4kZXJnAu8dmxWsAqakCA9EacvHNhYFlfSXxWK87pnFbvNAgsIpvrRsLSNW+pTSM98LyveQx
	upS1O7O/zbemAgUo8UUklCsGwOFk7Sv/LamtMF/p1PNzs9fHRRzNKTUqZeNk6BkDHf8/y7RWGcD
	hz+HKlHz3VDy36bihtK0C3p2u
X-Received: by 2002:a05:6102:404:b0:778:30ee:f44a with SMTP id ada2fe7eead31-77830eef735mr1453140137.0.1787237268350;
        Thu, 20 Aug 2026 07:47:48 -0700 (PDT)
X-Received: by 2002:a05:6102:404:b0:778:30ee:f44a with SMTP id ada2fe7eead31-77830eef735mr1453123137.0.1787237267726;
        Thu, 20 Aug 2026 07:47:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478854400sm1327959e87.6.2026.08.20.07.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 07:47:46 -0700 (PDT)
Message-ID: <87650994-df88-45b1-9793-038af024d27e@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:47:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] soc: qcom: geni-se: Fix write to read-only
 firmware buffer
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260820-fix-write-to-read-only-firmware-buffer-v2-0-7badcdc455fe@oss.qualcomm.com>
 <20260820-fix-write-to-read-only-firmware-buffer-v2-4-7badcdc455fe@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260820-fix-write-to-read-only-firmware-buffer-v2-4-7badcdc455fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExMSBTYWx0ZWRfX1fF4oMDgAVZC
 oI0ez/iktTlW3A0bmN0A6SxOtEpO47PyC7DZVTHuYoVnkOvoDBWaYbpHK6yf5GVtC+g1myET0PU
 /s+CwtTk4hsz2z39IbXrLOKl3VyvRck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExMSBTYWx0ZWRfX+y//oxZwesou
 EA3eba04itPK0E41vhiIpCYTZX20/5NM0A6ZVjnYNCDZ23fm72LX06tyVQQG0oKaJO+zJU7P0cA
 vjb22B1H+G0dtDEodkTzPJWUsaMvHyDc3Qcznd4WjAe5B4r81dJy/fPBi/+Z2PfEqd1eUoxUUi3
 JULobxBiHQX5ALPOdlGitOzK98DaM2/nVVXCEMi6yBOs3tJ4ZotJT15wkl4N4UQjO3AR0RrFUY+
 jM+ViFhIMiRqNHe2C8/y8zr23cpWCyAI8HgWtBlLGN5xK6IUih6+67yloEIvW57Maxp4pXlroI6
 mod9UcS6vnrEFu45w3zVBC4xql8A3zisgKG1zjKPFGR0RGVE7e+ruU9L/ROLmunIhBbPISrh/Jo
 NFskGP8NSf14eUeLgouykfXAESij9JM6scdHuvhrWRiWfirUr7vvhU8lWgPPg8yBJOQ/8OI3rQu
 96xke4HgDLBgCKKAExQ==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a871395 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u9qNNwF8Ye741BRZN9kA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: ZmPASx3rClhIR84yeqDnXPJC1IIwUZng
X-Proofpoint-ORIG-GUID: ZmPASx3rClhIR84yeqDnXPJC1IIwUZng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200111

On 8/20/26 4:31 PM, Viken Dadhaniya wrote:
> geni_find_protocol_fw() casts fw->data to a non-const struct se_fw_hdr
> pointer and writes back the rounded-up fw_size value:
> 
>         sefw->fw_size_in_items = cpu_to_le16(fw_size);
> 
> The firmware subsystem maps the firmware blob read-only. Writing through
> the cast pointer causes a level-3 permission fault on AArch64 and
> crashes the kernel during driver probe.
> 
> The write-back is no longer necessary: the previous commit propagates

"the previous commit" is discouraged because it's not guaranteed they
land together

> the rounded size to the caller via fw_size_out. Remove the write-back
> and make sefw (and the hdr pointer in the caller) const-correct.
> 
> Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

apart from that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
