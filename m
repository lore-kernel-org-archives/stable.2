Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4753403E3
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167577; cv=none; b=qN63TjXijwvxezZ2j6kFVya8YQRCutQzvL6s6CH6b6BYZW0kyZkJCy8OsKK7EFT3KMAGqXra2va+5g+r3G1LFzdhxX8OHipJ+SJa9A3q2VvuGhUcTGcN1EJGjQo2thLqsmWNiQ28D0QfSywtX25Pt2bAHxt/nLSGa31W7l3XdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167577; c=relaxed/simple;
	bh=2ptsqUzh1G3mtl60EIsCWIOKDbdj3Zp7St1CjUKx+vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lq7iVZzrH6CZDeazl0arfRpMqg+iYRA6e57Je/JT25jIdWedUq22l4Ty5wyIRqfnLxhJK9A46/9vDOiR8D/PT8u3Bx6CMhBhyjxydHwUXZaU6B4LcelrSa6NZieBLVNiEXUF6ndmmwIbFgspld3woylOxsccApRgVNtqPO88Y6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dn6lPZvB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WxN6l/QA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dn6lPZvB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WxN6l/QA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbWsk3616442
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Mwi+L/Gmuhk1BHYUarpYFgWKSaL2RVV5ZgB5B76mRk=; b=Dn6lPZvBvB0CYGpp
	PK7LthTcz42F4nj8aBDfb3wx0nC/f1s91ZrGhYM6XpVUT1hCriuPRUaW/HnhiVC6
	2A558geTm42jC1gZ0bVxqkPPB76n6UGozJ1g8ilb1cbKngeAvoyCKvgTSG7Pe2ts
	fIcrzaFkF2GNl/nAHg7AFDlpGbt3piLQbdojuna33wRSqHwLwJ9mek80Ne5Bmkbj
	rDWbHqJX3JZymNgXrSuPmI3gEeIhyKS9R+aRaq9gusVTb+8fUVQ0iiaFJ2Yie9UR
	YPIsOxoUj5MwlKfGA5JNtJyxXViwylPqvJThkGGLD5y5loABPrjGbRov3qSzruHg
	q8NE1Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux864dvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:46:14 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97f18b9d6feso30963241.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790167574; x=1790772374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Mwi+L/Gmuhk1BHYUarpYFgWKSaL2RVV5ZgB5B76mRk=;
        b=WxN6l/QATc8zYPQyAjMcPtwx93wSDo2nAxdPli+izbM0rlfdrkj3ssEw1lxmhpBL+f
         iyctlHZPCjiWDLtlsBUy2JT8xePLWfBKfUfrbuRESyiD8684XFBAFjzWXgljy5aWEr/O
         D+dJQSE5BDBQTk+NcnU9G4ystweS6gXZExZIVMmDEmPexDF1pPCb67L/gl7/d2/ydm/Y
         9k/sKDBDz2Pyfi14F9gebWrCFCPq0zxOjuXkUqCImU1h3y9BdQgk8Do28OKkcMadG9Jf
         TRgwR92YB9kTH65OFcEyRTHI1LDAbm7dDsV1e7DkVbzZe479Tt+43OJ+4T2W38hfRz9u
         3PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167574; x=1790772374;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Mwi+L/Gmuhk1BHYUarpYFgWKSaL2RVV5ZgB5B76mRk=;
        b=PXHr/XuGHa0BuTHk+nrRES1xsc3oH3zCxgT/92SNzjwfcMF2vF2rx00D8mbmg2Z0fx
         HF0ZRFSlMmORdZm5Q8yMV8qzd+7BGk4Ic2K/xffGYU5qsIftno9orY9YtEpCAqQJPYPt
         HqzIb+ux5PXTIibmYSm9Wad/GculAgJg4jAl0bUE6IwwFS0Ohq2lgTajLChLKshLLUG9
         GYee8Blo3HSk+HZ9gM1s7M0EpeXEB8hkiExBlALSVdFGgLhPjy2gX0c8mXWTnUCJWnio
         Ljd2o/ox1UQgDqK4RMBTB2rgg77SdF7DVLIX+rV0HDLxfF/JQp7VbZLcSK1bTcWz/Sm3
         xUpw==
X-Forwarded-Encrypted: i=1; AKwUvBxHY5fWv58KNPC5NDSkA/02UXa58/8gAa3rCO/Ti0ctYLC73ulHI7VUhn0IxqiCsWake4Z5tdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lN0eFGq1N4nHlxM/XBvE3rB4tkEjDjOpmT5pT6IUR5qb4deCqy
	GiYtJ9t6SySVB/4d5nUTAl+3eCuouZ/yoVuGqvcorFSLD520xBAHiPJtW6azbE6xucdRdVdmcp9
	FK0MHpx+f/V3uIP557E+N1K1BvOcHewyvsNFBSifuE6BOhV6MF5hagpHV2LA=
X-Gm-Gg: AYBFou2BdwlwWZHk0vxcKHP8a4XK7XVn2zg00HOdgRcltu2XAJyztyIRpLh+n2sRkSV
	FdYNIDIKPBsSCW83A3Yp6oVN3zk1TAmY4U3Ze2z/dohE5I9FZEGMJH1VDzOkhR7BpWPNPXjhzpD
	jmO6jxqFR11WCt40rpQZGEhFBSjfD1yPz6SyB6BELWLajAyRffLcQmcjMmyLhrpB9tMOdaIy4v8
	GM7iYS2TAozXWZbK5f2HGLUhpSha+kKxNHWDUxUKqt7eXnGljQuqjtsdLg+vhwY1NLfe3IWlk37
	qzGER1LspCp8z7uG/+gdkCAvJ1Tzm8lAiHjXCVgWPefzKnN0QGYZixDDK4Ku4aogu6EhnGqsmjO
	Z5r3FnUwDDPQIIlwQZ946VQ==
X-Received: by 2002:a05:6102:e08:b0:7ae:546e:4ca with SMTP id ada2fe7eead31-7ae546e088emr430772137.3.1790167573936;
        Wed, 23 Sep 2026 05:46:13 -0700 (PDT)
X-Received: by 2002:a05:6102:e08:b0:7ae:546e:4ca with SMTP id ada2fe7eead31-7ae546e088emr430753137.3.1790167573414;
        Wed, 23 Sep 2026 05:46:13 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5524sm113601366b.21.2026.09.23.05.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 05:46:12 -0700 (PDT)
Message-ID: <7431ceec-62dc-4dcb-baa4-9ec41392e72c@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:46:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845-xiaomi-beryllium: Extend the
 xbl_mem region
To: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        Petr Hodina <petr.hodina@protonmail.com>
Cc: Konrad Dybcio <konradybcio@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260916-sdm845-xbl-mem-v1-0-6e3c88507997@ixit.cz>
 <20260916-sdm845-xbl-mem-v1-1-6e3c88507997@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260916-sdm845-xbl-mem-v1-1-6e3c88507997@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uzjc62CjpckjzYM6vfYCa0a0T_hUGaeT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX4pCYd3FdE+zS
 QcRPjuHV+nEVVGvAYjNWAjsvOdOQbEiSorKi3DPKZHIRD0m4P71mBXpX9ZLnxQzUMhcsDp2fpnG
 JXRG3GhWlgNtQwTRI41rkR4cpCR+QHI=
X-Proofpoint-ORIG-GUID: uzjc62CjpckjzYM6vfYCa0a0T_hUGaeT
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab3ca16 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fZxPOWFe8h4dJMscNt8A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfXy7fmxEfTTrwn
 BnXkBW6w3BMODBSOqVsziVer5Lls6xz2R7OiqYONKOc681TI94hGLrXaKGVviVjNe6xVszDBg91
 6AHzUHk6aeN3ivseMFtCg2+k5OUW7nCpeZICDCqXONq+ZM0uE62EEytlZ1VyhZaVI5TbKDb6QJg
 Wl6ZFkE1kTXWj0XC5ip080h1Jwz2/Ty9iFaCDY/qO0PCGQSMGOj1mdh9xNlA0ppEZ8/SI1Bcs6m
 REtQe6gjKU6BvHni4Fig6FCSHcFSUEoNj+JIspQcjFEK624uAcRnEz2/OobHdFH5k4V8wNez4aE
 VAcB4+E/gPLTllw+/FWypPJFu2NFYm0hMRYgEpYBLigPlhZrMeaTftL9Y6XN9H1phOfV+UtKje6
 b4mzp0wANc08ynvSe14eBDQxXD/QYivCSGslAqOo5vynSNzKprm8UN9UBmbKqME1OE4BsYxq0CY
 2SeqWqnV5IsXD/XEPjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230050

On 9/16/26 12:25 AM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Xiaomi's Oreo-era tree still had the CAF 1 MiB region, the 2 MiB version
> arrived with the Pie import. This isn't a board-layout quirk, it tracks
> the firmware. The later XBL wants one extra MiB below the old region.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
