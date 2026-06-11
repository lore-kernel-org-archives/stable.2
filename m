Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E8376465
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168697; cv=none; b=uNEGJBE4zOWCj0o5FD8ffVPG6h0ooN6wbkOwp4/B+UJshe5eWYt1F6+ZPH/vi46gMIwnSGZJwur1VY3hTguftg8acWoOwRM0pwuW27y1S//l2NZj+OEEql26fG1dRgJo1HLr3O1sFgYW3DcBDcVoHm7OFCUhijyFCDmZTdpuMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168697; c=relaxed/simple;
	bh=Ah7Hp7ftJHUPWtLQZ0o+NHG8g+aUB0BccvnJf0PTTVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoWdteRKwhT3hf8cAmbhz6HpilXGB0JDiJtIoKpm9abamyOW8YQU/SANWYUcyXVh4HIbnvxi/lcKmwxMxKR2kxmsVTzzQx/OUGsswgN4qIAcRo1iPTw56Ietrrm677cIYfvIL4mfZ+MTEDTmytcy1gVYZ4Q2vAnGHqenYs5YnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcH+PdUQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dPNQeGhz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcH+PdUQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dPNQeGhz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GEHs3724538
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	42ytVJQyLSNNdfS3jOnCdpT27ZxKZp4RInVBR5BAPyY=; b=GcH+PdUQYWcC35Tn
	4/cw48A6pCYIIrrLVRliK1ncR5ScUg2SJiV3W1X9JcJNeioridAgQBiZkWK9T2gt
	Ax3JO8tf1mIDXdXx9d/8dqFCcZmoPsHdBafeeBxiojm/nED+uMIAPW6uBo72qWG7
	J74/qMV6VqbpnYSXqoj1Tn6qY/j8evBVdNVt05muRfQ/gtm7hAP+A3Ib+9PMdL5Z
	rAv7aHXObo7bBozu8nrUorD7Iq5JMfiA3AsTb++oL8EUOSCcIzbfzrppXHswPIav
	2DJ7atJYa3TUr2ToMEPZrqZJsyds2JTuSjM4hmdxd4xdSgH7T2iYdFLVs+n4pfQW
	oRwqPA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6vajhh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:04:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5177b12d7bbso14426081cf.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781168694; x=1781773494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42ytVJQyLSNNdfS3jOnCdpT27ZxKZp4RInVBR5BAPyY=;
        b=dPNQeGhz5gb0rphKRglGqAqpVRZQ5KeOZx1Mi+q2NcRCuVlFIA5bAGybUqM9ieM0zd
         1SsrMpSdhesEax5ydNWj2Vu+bWDHQpygcguKrZx3ysWeaVfHm1ruiXzneEBBmFT7F+Gr
         PqJjP7swQNy2GBGKRbiyPHByxpG9+A1FyHqYP5eSe5AFJiQN/C/OV+r7OmeseuR0ESGy
         5++1Qjzo3Bw1BuyEw99KRJNqTIJISWVtDPjS6AFUgBCBQntKiwR83zVjpGgttPPgyVOK
         k0aed6kSGx0Oy4UU89yOJEc9kiNROpEAYOs+njIQYYhfV6S3WLBMFFHk6UsBmCwNU9zc
         K3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168694; x=1781773494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42ytVJQyLSNNdfS3jOnCdpT27ZxKZp4RInVBR5BAPyY=;
        b=E4Kib88WCWtzDPUqVJdw6sH3/h/DkCagLkrN5cibFXCszl/n/gZ052hhtmiDHeIEgY
         SykgT9+0ioYxxnVq1T4ojvucvuLLeBIBJFXpPPfxgGHWUijRMlmkI+HdysZ8dVvmvIIB
         NXEuFvpmP/we5SOeEddw0QmVlYSqVuoJTmeCDL1wtLyZJ05y7wYZiZZnSzkAz1Ot1LSs
         TqjOGqkQNG7frQLIvqqgtiF3MIx4mHsCHl6FxvZWuk8XxP7lMEHbswNZeNQHEBZRGJDN
         QS4Pb2ufcPmf/MmnhAFirl6SSYLHPHib+WWwdVi154CuyLHlny9t/u//dwBfZ+3ZLnTi
         4Qbg==
X-Forwarded-Encrypted: i=1; AFNElJ/yvc0gd34C05fTsvKStKpyigElfRWQ1dmHyTtXpkF+8CPAIee6yS6QvMxNFXH5H/4PPxO0Q14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbdoV/QcqxZQc8KTo+tGx6ETrDALo4OQzzFlJTMmeMp1ufYD8
	fl2Vcm0qZ2MJRYoUraZivKc4LzrhM35xtncwZuCcKh6U+Eop+d83/jC35quzxF3gAJiRbckwTdA
	nbGNbCh6GWarOzss9xlsc9mI9rInX9PfTW4ld+sYhvei2tOL8/Q7JpwJdxf0=
X-Gm-Gg: Acq92OGz+vAjbrhUip4n87dWFgbL3CIqTNmMwdfBTMQWnwVSj7SPHOOOK1lEfbh60ym
	CdC/CW1glQ1/E/EHZhTI9HNof2Pl5KkDxmXqVwTZRPZU52F+AC8q2Vj7PlcOUavfuz57mBfwqve
	QXtOgLs+zLZjFnBORw4WzqiWMT+MyTIF0rf6kLYxFhs0vAIptjyPa7v8hgj5XHh7giLdOarHY6c
	z1hxsEhqY7kVRKTYB0/7bFWRtUaH8/XRHrpGiSqXT4Njr4j8z839TS8lZtrLRwUKuReeHKMPQTN
	RS3l40SnxcR6Mj2DenVlIoR5jbsYKfJkoSesXo3tYGagcDi7dW/ALMeZvTqXbkl1+LCPQP3JSFw
	7IW+TKBe/i3xDbwguAfkAQHa/ZwiO2r2uiSAJ7CxQZ2uiDzVq0ASr5x6B
X-Received: by 2002:a05:622a:89:b0:50e:5cc1:1de9 with SMTP id d75a77b69052e-517ee27fe16mr16804971cf.7.1781168694208;
        Thu, 11 Jun 2026 02:04:54 -0700 (PDT)
X-Received: by 2002:a05:622a:89:b0:50e:5cc1:1de9 with SMTP id d75a77b69052e-517ee27fe16mr16804711cf.7.1781168693670;
        Thu, 11 Jun 2026 02:04:53 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb668c9f4sm35813866b.56.2026.06.11.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:04:52 -0700 (PDT)
Message-ID: <1cc052aa-8274-4560-886d-2b821715aa0d@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 11:04:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] regulator: qcom-refgen: correct the regulator type
 to CURRENT
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260611-ipq9650_refgen-v2-0-d96a91d5b99e@oss.qualcomm.com>
 <20260611-ipq9650_refgen-v2-1-d96a91d5b99e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260611-ipq9650_refgen-v2-1-d96a91d5b99e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TowHeu1eNLpODjhaCuzLjJwJ6c7fkQV4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA4OSBTYWx0ZWRfXxfudvaUT3cTY
 CQHtPVW7JCMs+Dj2cXwgl/m4pb0F0RAQ9LQOrvBGynYKdf7TWFxvP+1vorXkA+BvFx75PBgjBdW
 vN3CzRcxzBTwvC186gV4QvuQiRVj5Ko=
X-Proofpoint-GUID: TowHeu1eNLpODjhaCuzLjJwJ6c7fkQV4
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a7a37 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NMBPdCelTQKdMlTKoVgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA4OSBTYWx0ZWRfX0Ubi8VLr8uz1
 UGO84dtVnit3fmP74cJ56daZoxksODV6n+GwydVdpVeg1OctFD1BY4gJsol5unkDSzP8opYrEdx
 3dq9T6TluKb4ozNBqq+BffizTJSylInBmFCkfAVM2ZEq4tHdds6NLel1L6nqwoUfTAo6odOjSer
 /BSARJ/ctt9ci2j09IRp17wpiEfc8/C279viUQF0EDF8Z5DIrVcKz8NQstUsu2NGEV+Lyy5Z5oC
 iM4Ubr9ixXAdJUpx7iSaCIXsCJ4d2w00KfKf0sgyqiLTOW3GhlVrQ10N4yOTnYannEWDWTrQk7t
 IJmby4Rsrp5LEV7PnoRik48Pdabi7aNJ+Ix33WZU2WOqbmvUOpr/Uoo7fu+Q/MTrWcO1iYSxJoA
 TfoRKxoEKtxnzqoRiY5b09ItgmjlT7tuabFTEnp1WYm2W0MEoRFO6FpzymUjlxfop8mXeq139Vw
 EPOKCHEDv4guC3M/Ncw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110089

On 6/11/26 11:03 AM, Kathiravan Thirumoorthy wrote:
> As per the REFGEN IP team, this block supplies the reference current to
> the PHYs in the SoC. So, correct the regulator type to REGULATOR_CURRENT
> to match with the HW behavior.
> 
> Fixes: 7cbfbe237960 ("regulator: Introduce Qualcomm REFGEN regulator driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
