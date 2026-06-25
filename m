Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14733CFF5E
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382947; cv=none; b=n6YK/XB2sdxwZCzOdOHV8qLbXXH0hEgVep7wBlz26FDEKYtjiny5eBIiL5PikYItqErbBI5xiEmx51mflJK53PTsV1LVWALW0dwa/uPuqG1fthnKcC2vbettvVyD4WcQLf6vHVzXTdiEP8rSimm3YNdEg9Se6lP2zehZgz45+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382947; c=relaxed/simple;
	bh=PUd3wa1z9wVw46F6JNtqqyfzu6JtX0osRRT07M2mB0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFYusKbQBCpnSc0woF/NZpBGMOO+/7xUxisNCIT2K09R4t7EKquH1zrKh+3RwllAw/OXFHwXGtitlXvEoP+jfzvu9aTgX7aOTxXTC90s6QfBdztBz8TLiQo85zX7+7mO2Ka7ZleXDVHteTryp4spKUx+XuqQ7mEQ63rl8+ZeCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j6+gUzc5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WEAjm5QY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6+gUzc5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WEAjm5QY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9jwgr1371493
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QKsIEUrVK0G2nIoOCPG0vvWvJmYCsY+ovNi5/n5tMP8=; b=j6+gUzc5lXVSNUD0
	kXlMVtHC3fQPq0lxjmNUrXWVdBZPIs0itBiyQKGlKjBDFlDUikU024C/H8o93ELN
	VU6p4ZAA7/Jinjj0EizNoSl8bwVUz1gxSt5oQjruMXn3Du2/jHc5wyXnlwx2Cww6
	rDmEvEygNI4jWAxY6ioh6CcVw/Ex3i31gHnixifCEwUfKvNQNF0eNBjztQMPpfpB
	35MhHxYzxZNnqPCfGFt75MFA8uVPmblxQKRWONU1+ycunVZ0gdwPhMUPVLLlkGa2
	eSSDN8RxAKTUI83o7awTdcnw7ihfjnlTfnN3mOli3d7UR6BlBwZ1gAPyAWGyAXKa
	5D0Ohw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv0r3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:22:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ddb0711609so9376146d6.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782382944; x=1782987744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKsIEUrVK0G2nIoOCPG0vvWvJmYCsY+ovNi5/n5tMP8=;
        b=WEAjm5QYwAz2E2R6nX7AE5zq3nTqdpBFbpmUX9jmjyBmRb3JLKNGQBmovyWxgBHbgv
         RDmKcgITR91zQZPs+17TSF4G83SW4hEVPFXT9O531bOPx/pFWPFKDnusF56zrTlALLwi
         rNNMjtFcTTTCSNrNZ/KbAC9/Vu34TYCOIDGki7RG2+58X8mdjpWUAThSgoFL7Si1svUG
         upMt/0ujhMD5goO0F49nZ1FS7cJ/X4zhjVU7rEVc70Hvy25iZ/L2Mr4e1l4N7LhDEkSp
         VqSwG4dPof3QumgDE0974luqjusnjme/aNG6bNFxiOEz4g2t1dwES6eV7iYHB9XlWYxY
         TNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782382944; x=1782987744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKsIEUrVK0G2nIoOCPG0vvWvJmYCsY+ovNi5/n5tMP8=;
        b=FSs+oc5qDuHUtuZNGCtkOtUuxXCfCHDBZ7EmN8eI7MvJVnil0OFzQBVP+4qZkmBqKE
         oRnUHhAcCz/Tgb83XxxTQAAijgKDA0an7Ny8wOUT5UCskAXK5xnTkgAOZ4KHBqHxEMyh
         ckQ/S5vx+PId6FImegubZMSQGUSKdBoHBeLm4EGZA71y8kB0Iwr9X5bWTO5ndNVu0OBN
         4sL83fFTc55psm9CU7VZtTBxyzn5+TJmInKoY4h8I2A6+66fkOwc2obNSL7YtRA2Vfp6
         lHDon/Bhg0EuIkr4+HQFWEnmD61JSwx9VRwK/rjhgQIfMj+QpuVjRwIwO8Xm+w2OteJ2
         vXbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DCYpjbihXRqmcfMad7Fq7Ww4cTCn5bkcyTpWJFzbrBqjmFQA33klRbs0+M4Y1g2f1BTqZutI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOG9DwblAf08mOe8qI6FP5oYK9nMQB7Az6Wp1lTyAgoewBEBwb
	F4Tnufz5FNNcnC/iQAvWqhNVf/l/X6sPpe5bKl2+JSTPSL2L4nAxQ8hQPv2cb+soF5fHifFDHVS
	VJfTpL0m9JtkxR03fXOpIAP6pXL2hHM0Aw203AKGOcTUuBdTneyDfw41QVHk=
X-Gm-Gg: AfdE7cm5Xh+aZNmyzE+I1U8eG2f6QNOujOqs9nR5+x9Awrijt4+KrSqEM32yL7dT7bW
	YRJM1wZ3HMxLyO9WBKEpRvjlUyrO1cK/YHjb0pdYsAOxkg2jzdvyxNnp045YbL/ZKCHphYm5SJI
	fdqS8/vKIA8JVi822/P+ier24eoNoKbrqkJKe/v/2wvXRd6rHHiG9R5ZLuVfjFR3CzW/j3zq9Tb
	cjZZOlswpGDLuBVdgNqaaxATm2XgLO9QTRCpjdo2C+3spDV9z0FXfkUkIVdNB97RhmPqiOAimZa
	i3FO9ZYGUXvlvCAO3lBkWzA9gwhXS5elPwHRREeTOhVCVM0Be9nAIsTgnoSggVzZIN/GkQRuZUg
	+N70JEYPotqGFA4K9TlLQy5K7cS1O58xxdkE=
X-Received: by 2002:ac8:5f83:0:b0:50d:a92e:fead with SMTP id d75a77b69052e-51a728014a8mr13182671cf.3.1782382944038;
        Thu, 25 Jun 2026 03:22:24 -0700 (PDT)
X-Received: by 2002:ac8:5f83:0:b0:50d:a92e:fead with SMTP id d75a77b69052e-51a728014a8mr13182371cf.3.1782382943539;
        Thu, 25 Jun 2026 03:22:23 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fb8dc641sm152400166b.0.2026.06.25.03.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:22:22 -0700 (PDT)
Message-ID: <df35362a-aa97-4cea-a18f-2bb8b2a320d9@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 12:22:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3d0161 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9YL1cksPtRnqhRk4DJMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4OCBTYWx0ZWRfX06HNjCzF4pLf
 fCcbxWnihVxRyokMsQpAHDmIGuyUj5QY4Sq2iqdAPzVdeKDVHxv9dCgnhah8fNdDulpa4p+AyuJ
 IHQaCD35uVlVSHzf2g13R8a7n571bKc=
X-Proofpoint-ORIG-GUID: PolPUI336sT0Cv7X54-Gpl2bx6SPKuQf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4OCBTYWx0ZWRfX+6RkAoEIjt9v
 IzI6GASs9qQaBGsHO685HAZu2IAU/itjvNj7L6JjsJiN59GB89mq9EcVYDdE/Go4ndHOhiSaEsq
 2qMGb9kuL5QDV7s9WeHEvuzQP80YPmQ8w91a50u4OjGpgCXPIc0DDMfNz5QDp2V/1a1HZHuclU8
 4NnKe3qMWGNeAt0w5wCfH05mjbaP29eF6RNLqVuxF3EdH2IFKLozLdF1fIMlX4H677Dn1Arqfyo
 UqMUxSGcD+R6IWMYhxEUraOIT1ivOfVSFIuHjzLqq1nufLG8wo0CDMxS8o3pJQ6UMEdpND3zbwo
 wqTaS7wZIULNmOUv7NGLN0NdeKRpnMHNCqKjwAyEUpHcCWTjyOs1lBlWnVTx5pte/8Wen8bQJul
 8AHF9u5DrvEuDezwgzRQLyXqzg00lBjCv8wPs32FXWzI28tJtikKFIYVMaybrMClCmTiP4XVswV
 LuTSF/rYN0JenNMVF2g==
X-Proofpoint-GUID: PolPUI336sT0Cv7X54-Gpl2bx6SPKuQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250088

On 6/25/26 11:42 AM, Wenmeng Liu wrote:
> cci_resume() unconditionally calls cci_resume_runtime() regardless of
> the runtime PM state.
> 
> If the device is already runtime-suspended before system suspend,
> the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
> As a result, pm_request_autosuspend() does not arm the timer,
> leaving the clock permanently enabled.
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
