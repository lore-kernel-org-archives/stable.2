Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD34AEBDA
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917051; cv=none; b=DF+VXKfHe2VsEamjZv2yqSZWns3ScV0cZPxPsWTuBV6EgkaLVFfmQ1DxNbgBU6Ov5048Z4tUk24OgT++Slgu+GFA6V00eMtvLA2ujkbdVJj4ThAcpoKNt9WiSxlE1OftVAaUpSwXSUg0881E2AswitxZ8vgIavYzT8v6tAvcyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917051; c=relaxed/simple;
	bh=kSGlsz4/kVX/O8qL2dH1ve++stecX3FGYtYzX2OQDNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN0/ShsuZApUgg/JCAtPiURoLpwKAYQ9K1S6m4GLeHnzZ4IODUNT+BkzgpQN1siv/qL874JyBTvDLFPQWtEZwpAfbUVnpkCZolV2J2hoYSv2uL3NuGYKlWgJa7EEQmYO6AVPNIRowKkM4bWPqg0ciY6K5nzIAIy8/fq1lZqE6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HxJc2XMJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F6NY2Miu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HxJc2XMJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F6NY2Miu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DHNLYh2332987
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TAJ3OilOPOsiftZNwjsnJ+TIz9YE9dQrowEOurHsbB8=; b=HxJc2XMJwqPJDmQu
	OZRAgDrOy+Gs9DZy4hksAW9MZDS9tQo22XwOT3Qr9mc3uO64t07R+IvzFHzyNo/X
	JejiIwF70nvPy+UCYOiIO6e/+Se8cSxNet2oY4z6QwWSYAIDVyIn8GbiQqRR0OMh
	IRuGVxemsg/iVlDQprHHXdDAiYgvz97zu5RXQZLM+HV/9AeNXI4RIor/GAFUn0J5
	EtB+c9YAuldzJ+iR3ieek+tiliykDYoz+jhrXEMJIlEq6igpUewlycfOeh/STaTq
	Mkg/TyqjXkoApj+QlxfyWpHDGG53KGhilHMQdklMqXzXAbph5DsZSgziSh3fX+Nf
	XDPNOg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s0hgd8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:44:08 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1665200f4c2so4600882c88.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791917047; x=1792521847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAJ3OilOPOsiftZNwjsnJ+TIz9YE9dQrowEOurHsbB8=;
        b=F6NY2MiuDYqfOTMX0vgKqcGzh3Lk5kQusstcQIAkGDvUh6PZoHRJvI+SAg8TbPHnf9
         Al2vHYJkke7WJ2jRsThyqtIPKZRtbKonWzfQwABt8fsAN32WK7sjN8sFEo+DODuVH3Ur
         KIuHOfdpK80uNaBPa6qZPwq6armrhmANliMfdPZ9Y7zHDyZomFfJgUJ4FErcNcoKQ1A7
         krzdRGzD142JfNO4V2ZJim1hi+LMWqgeZhUNhh5EFa/g0OT3XCoyTO6vATfsygn55F9q
         o1mxIHfRMoaHy1gjYH3cG2LDVCl8AbQpOzdJe/5xtdJrXquh6KC3T4kEHaHP7a+lVbMO
         /pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791917047; x=1792521847;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAJ3OilOPOsiftZNwjsnJ+TIz9YE9dQrowEOurHsbB8=;
        b=pIRS0331VCGiiLvuUBqp+0339it+AcqMP5rsQ8aW6lVlasFSw2C1tex19VRl4DoYWi
         Qof/T2sCAI0EdrVNJg56ejywhfQ4Jx7klGUMtuTK8yrEIdEMxGwfNkg3B2WQJ7mtqwt8
         bNVYP6ZLDZx3qV8SNeor8Bdn1ktOZjIa/urdXN0lma+9e36Vn2Pver/tUvM9Io8lUxEn
         Hvu1sk4qiJx+j+fH8P52JTTZnDJ87YlkJ2k/GUpRbMtcSEipXBhOY7ruWXYe7f+C+Js0
         OYiJi2MXbZqJUPCUClCVsfe6xK0UtA/9htJZUM3lH9piXgvmbcTM+fVeIhyQYmkI5lr+
         j1kQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4Lb6njZf9pBlmJyfOLOmQpijAGFZuXcavKL24EQ070THQoNDVua9GvCkH4c65/2a8Fihgpck=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY9xgTBAAoikahtR5RWnRYGOv7o6sy2I88prUsQM+ej710uzMv
	If7vLsPX4VvIQzP6OCEEB9f6nao0WYj8XHt/VFPtgCmD396LNJNI4yHJQjcuaz0QNo6ZwwobaGv
	wYyLnv4SgPhXXlv53CeYzxTFHI07QpewonqmzTGjO4DYlU0RfEsZkl7oTDgo=
X-Gm-Gg: AYBFou1bqELMA3el1QdcZZInbr5k1LKdLtnbTF6ln2f5OE8OLXP/rfomuNLRbvwgsV9
	cfecWht03JoMlXdZAZMiwklhvAUDUj5UJ4LQ8SyhBEoAsuRMx2KMHba0c2hFFM78E3BsvJwu7nR
	riOQiiP3jxpLLJvI7CJ3brsCOksSJysmSYeZAb4NC5ljMNa1Mph+n5L00sOrlDfKaUg8jX4ceb7
	BZ1pN6CEBvvpGGkfTkRviYamRxxkHQQmMDHlPGiYE/3xhOD177+5cj5/gTTqOlXEJVWcOj8Bgz+
	nQ3bRnlOHM8EKS+NHz61ExKZUqnNizG4ygVsg9C8ITcQvl/2TxHETtlLCWmFSHIf90V90o2ggJg
	yz+XPwCmORpvS7qIaOPb8iDqU6ROJIvDlIv5tcviMSya/4zFdfg==
X-Received: by 2002:a05:701b:4588:20b0:156:3684:96d4 with SMTP id a92af1059eb24-16a5cac06f7mr19510303c88.25.1791917047285;
        Tue, 13 Oct 2026 11:44:07 -0700 (PDT)
X-Received: by 2002:a05:701b:4588:20b0:156:3684:96d4 with SMTP id a92af1059eb24-16a5cac06f7mr19510270c88.25.1791917046694;
        Tue, 13 Oct 2026 11:44:06 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16997c21ff3sm40087467c88.2.2026.10.13.11.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 11:44:06 -0700 (PDT)
Message-ID: <1fc34b15-f762-4ae0-ab3b-735d750b7581@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:44:05 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Cancel Sahara read data work on removal
To: Myeonghun Pak <mhun512@gmail.com>, Oded Gabbay <ogabbay@kernel.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
References: <20260917192512.56205-1-mhun512@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260917192512.56205-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GL+dgeNK c=1 sm=1 tr=0 ts=6ace7bf8 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M-qdFEnyM_m4QQ1dQMsA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: 0tzd132mIdabA0x_nCWv_TEihN_xCFXJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfXwvoaBh1qb34C
 8ZPDb7Z9hr+RptItCWA2u1QqUS4dnFitQrIQS+5tXojjM+al14KzRexcmUmhh6uEJ29gykgl4R6
 ZMMlDhjDCoz4ufNR/+dHEmXoejmXJeg=
X-Proofpoint-GUID: 0tzd132mIdabA0x_nCWv_TEihN_xCFXJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfX4+0OYFaOSR23
 wWee8uwa1kgT9jM+BPK30pkuRAimjhE4VUdUTliJ84FzBjSCiMWqAPfMhdKM0BPUnBicx//qk6B
 osLaPvNhICKfyu2jAXokzbO5vJWjNNSUrNnYD+c6KZnmAV/48pz+q3pB9Ejy8rVI83P9hmU6q4+
 lxYulj1A1UU/P4fDtTOsFqveJ9l3D6ENf9vHgMGIHF4kKPgqa76ENDY1Q9DOnhjAR1oPp5wajy+
 h0SrHRSiFKT7MJv2ZzRMywB7CYaH/31w+gRKQ0Gx7EBMnTvHELqvkzFMDa33Tk8zzVdNa47AOjg
 5NvW94kvbiUVxbDfecM8HXvdDmzrAX15BBMb3+GDQqlcL59IYVZTQ/cJ+OHRnrsk2jSTYZZfTPd
 z+4IEEIeAc6jo5uPQEk3mfO9E+v6+T0ZEpCNTZKYN+fwEDICTaHoA00SDZdspwje81FtRfZqA29
 +zObCYAJrV3XFaNHYYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130074

On 9/17/2026 1:25 PM, Myeonghun Pak wrote:
> Sahara removal cancels fw_work and dump_work, but leaves read_data_work
> pending or running. The latter accesses the firmware and the device-managed
> context and transfer buffer, which are released during removal.
> 
> Cancel read_data_work after fw_work, which can schedule it, and before
> releasing the firmware. The MHI core suspends and resets the channels
> before invoking the driver's remove callback.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code. The same omission was also reported by the
> Sashiko bot while reviewing the Sahara relocation series.
> 
> Fixes: 7fb19ea1ec6a ("accel/qaic: Support the new READ_DATA implementation")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260701105055.8D4371F00A3A@smtp.kernel.org/
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Pushed to drm-misc-next

-Jeff
