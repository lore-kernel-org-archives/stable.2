Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46D48124F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153263; cv=none; b=ZhrSRYKYZsmmWQgbrRsj3iGiQOR0qoT7vORLmh37oUwdfdrPjmniOMFPplk6l/Lf35vn8KV9i+6qJg4Si3xFYM6N/WiGUDyecWWWF1rKnnXnizQSO22fOyWrTGFXnoNQ4C7LzaWOfTXIxX9LI329fLRpzjqiBvUoLoR0tRZs6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153263; c=relaxed/simple;
	bh=siZDHvxx3lSLS+5j62sQIDeXqihgS66odMFsdkJQn1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOA/iZvWybFOb0FVCZ+qOzLdEz4TKbFn39zUo1hPlL+BzPLnTHYuUBi1A2LYAUGwL+tOZ5kVLAaJf7kG6hQZKbIBaIznlgE6Rvi7MIJe3w+T48AxtXPRs3HbOW0ZqaqxY3Yh2QFNugRYbDfP35CwKUquLEavPXxvUuKzhhDJzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGMP3D99; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RM6RBeI1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGMP3D99";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RM6RBeI1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbMBJ067610
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	21gp0vnnQuVr4hwP1gh+KbecThhCGO62g+zyyggXrP8=; b=GGMP3D99kmrzvDWC
	X+V4qVixkFVSmUZa3sDKVGZXq0zU6zl7lrfz9n7+v7XNphreTXFGjtcPXRK5EwBd
	+8b5U3S+jDj7QFd58VyPQSuPw3/PRwgzAqwdPNtmOWWTLMb+8LAcpnryw8+9Ez0d
	v/iXjSKFwupJmBg0cV54+vBsIfghZPvtFWs3GbYgygyvrdztneuHKBpeemDhfJdE
	yfeG1rQ0+qDLMfvn+Hu6S6tvErWwZmxdrXobIcfDhxz0WckIdtnhVwIhoiKkk7X/
	bmYSjWFDgaCbtihwsp8yCq6ltlGzp1fDs0pyQsX9u7aiLF4kpBeRh9F585M47iyy
	nKfsMQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e5d0ajy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:27:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93494b1e35cso23444785a.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787153259; x=1787758059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21gp0vnnQuVr4hwP1gh+KbecThhCGO62g+zyyggXrP8=;
        b=RM6RBeI1eFTTWnLRTZk5kckExsqZ0z/QbxAKQyBmAGsiX7EyC0FOEKSSjDiQXIaFcL
         TIYwVNxZRIlUA2JuGPgwvKfmbRQJsUlg+KhJP0XeX5WoWlGqrQZCIQJ/ZpJ0e4mI89yn
         5vrhQVrmI8Aw/x5xxXp/dfrVrSk2BLdOlEQ17/QB8uZlg6lqKGbOoqD6YSJ40JYjufrW
         ioX+TXlhpTCrb19ncaYd7r5at+fIGWj5RmNucjEYFiOjW4HoJb/u4eQfsnGCko8RVKtZ
         zaX7wtPvxJQVtgpf4/99Mahjo2OIvkjChGRbakSK6UR/Ox8hzPu7FF+cP7IXdRbwkXJt
         vUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153259; x=1787758059;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21gp0vnnQuVr4hwP1gh+KbecThhCGO62g+zyyggXrP8=;
        b=f0pPgqj65DvMTKHxywXytnmjV+E7CX2O5eOK2qS3VXqoIfzrQoxTaD6LErbD5ADo0a
         /gf5+2fCKPVBG4T9pjGayVfEMFac4m836E0CdcKCdyZZxz2tv/phLv4xmS6dV/gbIld7
         Gydf5mptm8gxgm58SPJy5cRfdAX/sKlvjfrgHFuIIhgBHA6NlfaqJXSrsr7Ki3kxJqz7
         bi4ZAJ65TsKZaW9Lb16H6HzNw74kcaW21NuXt4YsIDiwm+Gk2wHA7HEjwEMxvl0SEzOC
         ScFC1CkS9QD2z9mFKlPc//lgsWkM15xqektYAkxIReTczBVE65gUD45rYqKihKY4luDB
         +bbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2b7fVnBTO/VD/4aDnM7B6O1XMRiA+5AkqzY8AdJ1N7syka4L8/2gGCTTU0T34YsjX0Nis3qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+g2V1ngrnSvqZxX9YRPeo8WWqjBKzmJEhyXgAHu8RTSudWhj
	M+3ZMm7VzTeyPyB60o7Q2pZNDjy3pZr60VVAusAA1fU1wEmJQ0uqa/VSzwO4XvMuXjTePsYHynj
	sP/di0KqQK/QY3cezCD5/QKS1xHwIIJjs0el13CtZtGMe5Jbh0hoEB1QwYLk=
X-Gm-Gg: AR+sD10sQr/J+uiXNJWwEHxaGIm3jx9V7WQc/J1g44Ale42FiRmACHd0dSmLERMrfE3
	YebspuK2D/R4U81BT6qFgnHfkufItAH7FMfu0WgKo0Xe1mPIXl6ubh9KFnybng3rwR+lRQ+XkuO
	+j9Y/6HAYGo4DIFd+jDmihu3Ssa0Wf8yD4122C3M841wB1SpKu1Ev98uMjVSck4IwkNGH7/pk55
	Lk4JKuYHMnlMYDn2BzHGSP07t/2oJlY8SiaLL1EntGR/8Yl6hP2EfI5ZVMECbV4Acgi8BcQyZO0
	q7wnQ7uv5JFAm9BFR+pk6OwUByDnSc2+hlg6Nxl0axo9OhQgoy4aiIyljCxkMWvuPa4fEBX/mOs
	yuCw3b+HoQDDut6Hu5M2In+Se
X-Received: by 2002:a05:620a:2809:b0:933:9bf:cc73 with SMTP id af79cd13be357-9371e7313fcmr351349085a.3.1787153259325;
        Wed, 19 Aug 2026 08:27:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2809:b0:933:9bf:cc73 with SMTP id af79cd13be357-9371e7313fcmr351345785a.3.1787153258725;
        Wed, 19 Aug 2026 08:27:38 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c3bbsm987608a12.24.2026.08.19.08.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 08:27:37 -0700 (PDT)
Message-ID: <000076bd-b3fd-42dc-bd43-96ee9492a638@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 17:27:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair
 functions
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij
 <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260819152356.904023-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260819152356.904023-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEyMCBTYWx0ZWRfXzaoeHDhY5eQU
 Vfg5D/3/ghfleHwN+tt/cw+Dr5jKkch58XUZp8wj7WMLDJlySpV0J6dejgXKip02p95O5FpWTFl
 1LoYSF2vsxB4P5sLL6iqpah5Ll0+4PwP7dhTHY5CrGeifqfAlrFmnMZ7a557DweBDNkGaSmCM26
 oPmI+Fr1DphMCTh96BCKt2jExNMaAPsgpNY848jn5crJ8tdMsDvO7AyRmCdsVfcyl2umHC86CNa
 8GbiFQL3kUDFEKxW8ekFsv9vrqUAlOwcMRlFwptSJGMV7mp4vSl4TCBqxU9PTd8JzmZQtaEPGYY
 ms7Zcq7oRGvIr9z1Mk1JliRBlU6kVNZmKZwta4YG746xpDAojES/hKhK8mOwenlbgu+P1c/1f2F
 8zsByGKSmHzaM1QTdddKFrPUG9I9OLIVXXGcema+kjXdX7/VN0rIDTESBnMLuJr1kIpzPK9OLDk
 w5SFJHG4oNqWU+WclQA==
X-Authority-Analysis: v=2.4 cv=cuOrVV4i c=1 sm=1 tr=0 ts=6a85cb6c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=9ngJe6dVrqvN9JGSoxUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: AgbyQL_ZAWAizrDupZ9gjM2W7KEHzFdV
X-Proofpoint-GUID: AgbyQL_ZAWAizrDupZ9gjM2W7KEHzFdV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEyMCBTYWx0ZWRfX2NwNGfNt+5rL
 fWdd7VSL1qYZb1MU1EwV1A1+71R1IUkPW6FtlyGl3Waz7bBXbBXgFY6BsuB7m9jl5069mi3yV+0
 1AV0EfMHx70BLZvT8QICP3hxnbCMpY8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190120

On 8/19/26 5:23 PM, Shawn Guo wrote:
> QUP1 SE2 and SE3 pack all four of their lanes pair-wise onto only two
> pins each: lanes 0/1 (I2C SDA/SCL) at mux value 2 and lanes 2/3 (UART
> TX/RX) at mux value 1, on gpio127/gpio128 and gpio129/gpio130
> respectively.

[...]

> +	msm_mux_qup1_se2_01,

other drivers where this is necessary stick an 'l' before the
lane indices, e.g. se2_l2, let's keep this 

The bindings change must be separate

Konrad
