Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992672;
	b=ybWhJUrgr29RPhAN1Vcf9xFOmx4C5+bshZLTmgZtSlQICOb3nCgrVYg6yM4wQkxr7nIs
	 o5jzWSzEKL1iEiNPgf+3l3NUFvVAUNW9gCf4izUuf7KvL34x9zZFm6r66tli5e7xfgQz7
	 P4asrHtEYM/0Qvysx39abax9AKvX/HEgzm+uKa9s2+jSAm7EeGUNMLefmBZFpv52YBdwE
	 55zQW1k359ULQyf/7rheeFWhn7xICvTpufQ80AOxL9OS5I2+OgE00JaIRauZ2ghcMQOlK
	 dOw3XZ+gEvWuql/czH7MkVTT/hJs6bYTEGaPLVubFWjRMOut0emXC+rEHqie+277gyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pWiYTS5xlZMJkO9ffGbPW6SlUMuEk+RahN2CrYFfdU8=;
	b=AMt4X2Z2ApiOPS9Ygo0DOr/FzdrY+h2bXw0p+WAXjr+1aEAPJa/4B3JUF6lahrqKceMU
	 uSNWgG0sC5YdVyUuPWEB6exAYdolMP4KAPbkLetdKnaujGPaAvmoGgCEpaoA4A3fZEMl/
	 CM1KCYprvwrXPmCmXhLg+FunPMKkm83Ea+DMFkx3iBrZt75JNoTMRc2a3IgtK9sKky818
	 +u66UNNVDywsfSF+lVhdMtDBFiHJuKu3QzP3rNoKgpyuJ+BzJJ5PubiparFNzPdWDkh3L
	 At3fUjA69MyyHB3mEYiQmgxLIwZjvs5s+O7FXQ2I7EJBvwC3fmqI579IN284Cw7hBCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PKLEFtZ3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iWRsRuil;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF8606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BAF8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PKLEFtZ3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iWRsRuil
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b1k62206202
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pWiYTS5xlZMJkO9ffGbPW6SlUMuEk+RahN2CrYFfdU8=; b=PKLEFtZ3m5ovf/FK
	FiMSaP+eiXFmhzCrPKaLjzAX0H5Tx3jcBhuuNeQFH7I6DQwxw6WUsAdQrpz0fads
	LQt8mip8M/jYaKXP44NZYvkSS67p17+vFnjbsF6UpToEh1OcVRjRMdiZ4hmLvoMj
	hLWexFGoDUWXyLWBjI+s9iRPLgVwf/0XufgOS4scare6NtemRj2NCYUfF6dabvrR
	GWIOfwfB7pntWVMPQsUWA2cPVj7nsQ6EijXoZPBWQZOjbb890yonUUVAWvM+OKTA
	xV2X81H2C5N0PB8g2BuIXcep/le4omOlFjDxF83QvzZ/QdPZncvq6g/cu66ng2p/
	kyRKCQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrumvq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea71803effso28251045ad.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792992669; x=1793597469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWiYTS5xlZMJkO9ffGbPW6SlUMuEk+RahN2CrYFfdU8=;
        b=iWRsRuilFU0X2s4Py3ViXHhdw9EUmt/dEwtrzCEarvP9V1k9NsfUQSMKWCL1UO7or5
         VAu7k4UCMyZMTNOG2Dg6Y0hvT1PBUO5/QHODYHIQO7t0VO2dMRMKdHanqfNSwYOmxAA3
         EDSU6wqxH94CXStiqrnWWCgZOOpB3vHS9co3UrwWhwcnpb3ATjs112iImaq9jthEDo9l
         /0p6YfhvRL+qjCs4ZEuRxFcJzOiptph310KyvIdY9DVi7nqVlxCxEzwBMztxp0ADMde8
         kd2y7x5Z7FHjTT/ZMQgvXOdFuk7pt0NsGLQxHDzXZ2u9AHU9mbhdVUGeGIrS5vu1JWJz
         EEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992669; x=1793597469;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWiYTS5xlZMJkO9ffGbPW6SlUMuEk+RahN2CrYFfdU8=;
        b=tH/0sf4ZZAvIFgOeRgfTlspC6kFABAjcx9rC3A/MhvfDGFn4nvKhs0Dhixy0a1t5jB
         IuIbKNwYNAoVc388B6VofJZodnFsmuwZzeyPAY4OdT90IcgjSWxgfZEcrHosnIFW3TNg
         oqVC+gVWtE2tbp+LYuvbr/UrnaG8NfjlKL3ZMcxk4+iZ4+Dw7fXamz7vuck0xXVjcPXA
         DJMDssO14lK/CS6Hhgmd5lFm4FpWF8iHXXzVnxr1TauDqfxO5AdjEYaes6ee9RkbZUZJ
         aMhjnoWJEIbn4ZV+DS/aLa1AlivxTal/Y0A5qzG5NXhMDlSptA0+pyRouwdfehckho5W
         6cng==
X-Forwarded-Encrypted: i=1; AKwUvBwGaYExNaC9OBuZyz73sLcSzOKazy6gFYT61rYEkAAaeNBe0TgwA5d9zd+XT2lCeNOQuEpu17I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLdmoS+jrHrVxTD7Nwn4V/W2iIU9EQWFjXHY2w70BsBeqwSQuP
	unf1wMgvARfxUCFdTrvJp7e4SWZ6oSO2Au5iqz1xVRxbvL4hRIGM/93i5n/Iem+hqe8skNj6q0K
	AMUz0eebWn0pd2n0XFKjxZ01/y72aKh69HB5KjQv9w9P/st+2ikiS4pDHdxH8RRJY9l7Cfg==
X-Gm-Gg: AYBFou1XHbXzmis/CoNwJI8REyOSBF+hu3vXgmVU2jwGt8xrxp4DK1pzRkgJzctcNS0
	kToTKxeBcs9Rzal27TIdVjwc2+1B7F6ux7z3Fgb4i4I7QH7xq98EsUeaazJDGel7YBfC2m/KP2f
	7Lae8THFESChUkyfDXJ0AVEH7o8r80JfTMOfuqbkfhmBKrQJ/0CVx50vmn/NuoJnoyp3vYUm1m8
	Xnhrbim8VLpQl5KgnzoRlMMKI5dw1J0PJ6T9kRQpowCWdCTX2OmZ1UXYpYjh/v94aLehZSLWQbQ
	usbJZsphCIM69LctIyyF8Pyr3Vu7/yDk2TXb0BWJ743Cau9x+xElqd/5/DIVZ17F9gjt1VJzxHo
	lCsd1C8dJWNo6oYhOd+9KpOpULp62Ig==
X-Received: by 2002:a17:903:2d1:b0:2e9:9522:ed3b with SMTP id d9443c01a7336-2ea9c84b245mr45565945ad.70.1792992669209;
        Sun, 25 Oct 2026 22:31:09 -0700 (PDT)
X-Received: by 2002:a17:903:2d1:b0:2e9:9522:ed3b with SMTP id d9443c01a7336-2ea9c84b245mr45565785ad.70.1792992668719;
        Sun, 25 Oct 2026 22:31:08 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1dfee1sm11134745ad.64.2026.10.25.22.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 22:31:08 -0700 (PDT)
Message-ID: <5a761083-d031-4792-9471-93d013abc45b@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:03 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: lemans: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXwtKY7MHHdd2d
 sg5iw0oELXHh96tIWUF2JMyW+eJaUh1fa/mywPflW512/e8qd+XiNMXGX1ZfO8A3Cl+SV4IemJe
 6vomr4MAYY38iBXuRFhjJnMWtK7gdm3QnaKrApPe5ZS2+4xtDZ17NAXoestAIP1LVLqPDk8TSFu
 OcAZwnjlySFIy4DR6pd9E8phLFUNStOyNBTUD1EvzocmyKkNn+sLGJOf8YPOiez8S2A1g6ycnRW
 wTkY3uIRt3o3iXNhBJiS4OHd4IugWzko/41LjOsFxTWJIBTR4nRIT1JVhiYbr+BK2Npz9c8twO7
 vHftVyJo8WNjHtgy6xbX2KRjrLTQg/74gKYav7P0v+xcUlhMMf8rI5LC3+woNXpKU4ZG+Za1eIy
 Qkg9nUXqIpMxtqY/OV73SzAxuWn2HA9KfeZQD7C4uhZnj1BiY2UpwAoLIxEBo1xjRasxPAd/Og9
 chDSsaxujpSZofFkUyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXw8ob/HuKrRjr
 cdNl5vEa2qGS/QmfXnz7QeUvc5SInRD0SVOS/MkioRUmyruObPEuKe8XI9AqhH0+rvpaYCR0xgd
 1D5T3wHC722Lwto2kr5SJ7qcIDhoOxI=
X-Proofpoint-ORIG-GUID: lGs96vgEEa3FYZBDalTLXmHWO1PezA3E
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adee59e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fOTrkZ0PMPD3N0poT60A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: lGs96vgEEa3FYZBDalTLXmHWO1PezA3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260021

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from Lemans device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
