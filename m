Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628816;
	b=LdVJRuw1+mZzyhqK8WwckgPqig5svCdZnAjClMtuEefCQ3eAVpgaPMoCK8XXAZEcxHwc
	 2XG8s3ZoaTyR8rauOZxST/FjIxGr8alSVrrFR59SFhL8MwFRuProbg37Y8Wi9W2vX+/JH
	 1Cw47v5dOzia6XMSkL/4gPOFbCvFSLOZpmK+ask2YrAUZy+0srNiuuP/rujjweapnKKCy
	 jeOT8KE9UPOM+2gX1JFPqSSSA+2Yl0OpUBpOJ9guBLFgTdz+pbY3C5OneqzL8c0S1AnaE
	 B8lqmFs7lruwa6oEpQjHuPK3ZJnuFfzkWLokbdYrHO5yjg3LZLJxVyfhCQlyuJTAmrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=etOvMntf1nczIGIsJ4cq6agyr4snoYdtxO11Y4gBbfc=;
	b=WbQaq8RI5zZVwXhHCkNnSc03hzV0IeGmU6cJ7hlsEL/BDanZb+vDO6rcE1EH0gtE5YsE
	 QSRdSwd5mEeCvmytekh3wrO/Ze6j98oOHW9GwWCGswl4+8xLW20vFNp73di3nqt2rB2UW
	 XoAVyPClGalyEvgJQayWGH+A4yg/teafPTbO0g32yZ6I93l2OqqedfpraAzddsFOcDlG6
	 9YQttSmik4W1sublJ6fycyVwOHn734MO9oGXz90X7h1IBYua+P6D2GmSDTbvSwq5BJjLP
	 Q9VgMhPACUsLtuHCXLCAxlyCSFrQOwTQUpPuU1gddt7XmezKbNOa6qVegZ8RiVkspCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NSPfiE6x;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQ6JP0Q3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF9606A33E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03BF9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NSPfiE6x;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQ6JP0Q3
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpB0t3512195
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 14:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etOvMntf1nczIGIsJ4cq6agyr4snoYdtxO11Y4gBbfc=; b=NSPfiE6xDo/8ghGT
	6+PlD3PTv13crzBoIbAabwHN+sUM171Dsg0nNyn5WVfwt+FAcdD+TS8V3OFfYkJy
	eGBnFGmi6oe9vBGlWyuViw6kKM01FxVeB2sIY9rorxieaw4+yp0VENa3lh2NwTaz
	G8XE8qn2L/GfIw4rHpKDcikxHKxInEy9f7AHaUWnZ3fDGoivVY8/6d0qiR2OxX84
	5IEApv/Lqb+eZ6LJ452H4S0yDCKz+1BevqEP4qb8C5+JXZaF/GdHCCxlUiKy2Z8x
	mlyczYI61o5nzjLuwHbCL9qH4BGbBKRford8bYycfHwO+F9DDvbkV2erlr7kSLzL
	QaMCdA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrh6dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:13:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c3c370b17so5317208eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793628813; x=1794233613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etOvMntf1nczIGIsJ4cq6agyr4snoYdtxO11Y4gBbfc=;
        b=jQ6JP0Q3AT5LTg5mjngOu4+nnonZ3bu+jiRFUZQNCOEvz/ks4ba7E/UXm0DYj1kulD
         r7LNHjhw2ooyZ7BGtkna4LJoDjdcIrK6aHFhmkYL1i8sHPETl7hO6MtR/uxrpf4Gl0TX
         vs/ky0VmOWXCh17/lAjZMfZH4vPujucXhi28q2bip6hsF2FZ7kSGu8hijwTUZQ0n6n9X
         eGrcIWzmw+AS+flkmzyaiQgX4GBg+i8qzNPd3Yzm76hNVb/xyVYW1tW4HiMsW7Q+scYi
         N2YDeRdJMG++e4VdhqGKF1k+D1/NLKKelvfIO/U796ZOsw+ay3kbhmH8p93vVtSRDGNv
         FEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628813; x=1794233613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etOvMntf1nczIGIsJ4cq6agyr4snoYdtxO11Y4gBbfc=;
        b=at41BEej5HhAdMA4oPP3GvIBgUs53UPEocWyHiDripYSqvRNPxFcemnPOxmPKJzZMi
         XaewtMU77P6el4U6o5IQho0kARN186O2S4RAhvWn3XM9wO5ONxzVDdOY5z4jUkz3gtF+
         gmogIZ+FcCP1aoE0mgp+vdQG5LEDpAMcduw6DnhDkCEbzPbyy0Z464efhCk8MV59ms0m
         H0CZNsKQateIJMOVKuKGpGDck/Scjat8/pCX+2Al6WSIMgiPPSqoN79tJwIrhEJTZGDR
         EcJ4UU6RovxARL68seG/tO0baCOUJnpRbN/EXz+NRy3TPCJDRpJ6cCoR6r5DWCfIbBgW
         YIFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmfVSkrWC13uaehBvVEujL0P++YrhG5LHaWnBbC2Cq1sv5x6UT2jySZPJfU5Zv1vifkkvxnqU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aJhr/I9QFRaI5++9O91g05alOcpiwkaWCAIK32dszlo1BzU3G
	oxuQ7z0u9yD0VNNECrNdy+fXfGbu6T7JynlpgFmVusMqX5kg89GbtxD03BB1Q9tjnH5G3JAIBS1
	BMksq1PA5Uhxn/Q8rJ5b2GEWyMfhwB7/KDfPDKi+Ks81XtO/oIgyKPtgKpCg=
X-Gm-Gg: AYBFou3zEDfBnYsiTAEe+4Nzdqkgam4AIGD8deXOMdEOF0txbwMV9NR2+usuSaPFqdx
	WixahtvlwvNWA58BXbQVKCRMYED6ydTye7C9ZoxDxKoqUcHaHcSBWYi+fbrKqFFdj1UDCimDLw4
	+eNjtUUPyw7nVHZxHSwyhEAdU73I2kR/WWyieKy8pr25QAuOmYMF4E2atrm41rGVoSkKURBV2u9
	oNvD7Uyl4R2NIKuVxGS07MZP/x+QYp334aPBH78ktMr6C/G2QGuJ0vYy+vADBkw7QeUJS+2J5OO
	uJl0GcuABiSQ6cF9Eh8WG8OeOBljFceGI3og+cAZZataE2+nOU5s5spRi6bylt/vPslhHrjseUk
	oTLsZaUNIo7zPUHIOx6ArwTXXjC/O+rQTzwhXaqzD0csplYKRtP1SP+9zNVTCP1vSxtr2ohqB9s
	VxPj0AlQ==
X-Received: by 2002:a05:693c:2802:b0:36a:1008:5815 with SMTP id 5a478bee46e88-36a4220407bmr14614541eec.5.1793628813288;
        Mon, 02 Nov 2026 06:13:33 -0800 (PST)
X-Received: by 2002:a05:693c:2802:b0:36a:1008:5815 with SMTP id 5a478bee46e88-36a4220407bmr14614496eec.5.1793628812636;
        Mon, 02 Nov 2026 06:13:32 -0800 (PST)
Received: from [10.204.101.201] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm44416221eec.22.2026.11.02.06.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:13:32 -0800 (PST)
Message-ID: <97033b9f-8fb2-4571-847e-7ccab661b93b@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 19:43:27 +0530
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
Subject: Re: [PATCH] media: iris: fix ltr count rc_type validity check in gen2
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261029-gen2_ltr_fix-v1-1-6d5518d59b9c@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261029-gen2_ltr_fix-v1-1-6d5518d59b9c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae89a8d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=PxXcNx1syzcY5Y30yX8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: YSow_a4aa83KRgVZchUnvnT0wvKP_QZl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX7k+2vHZXWOEC
 EtfqJqbB8SXZVyO+cSOZmU0kXnYn77pTF7NIPpTocq+grpkIDEXKTHaNorBqvLsm2YegPWMfYY7
 8bzVAeq4N4AFhL++XA0u3hZUi91xFvU=
X-Proofpoint-ORIG-GUID: YSow_a4aa83KRgVZchUnvnT0wvKP_QZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX5FlTuiECc22I
 8T6GI5NFTC0d63YyfW6e+lh4cr8bme1bEPOLdplFDOq+dsCGy2n6ddCwJ4LZIaG7jKLzl6PQTBO
 WPByCFJJJtHacBXqk8iPa12l76tfBBtMNMpRwXi8Y2r0kBveBPuYesQsTSkQX7+KkdCCgsV5esd
 TIEJiLs73hYIeyQKZeucTggEnBxDkBjBQ89hHbG5Gds1Q1WcC3R8+9fCK14+J2duAXCPJ7jJlI3
 x/f9Cb16mfXUZ3oG0428aYItIIJ9OEyFj6N7HOGaxfwx7MDLX5MiDA49XOPzEmfXy3Cjv1eQE7V
 0+DjQsJ8UnKk1JdoKDeM6ijVeboO2kM5lPYvTHDr29DEgptbLTulyy3OK8B6vUTjd8rwbqYGF+M
 7SMKUqyZBEv25iiY7ERQkioegDknqamU90/D6cVcsBja429xSMELo9g28HE49TpUhd85YWzQx8+
 3biX6JQIZIhp9M52zcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020056



On 10/29/2026 8:42 AM, Wangao Wang wrote:
> The condition was inverted: CBR_VFR, CBR_CFR and RC_OFF are the valid
> rc_types for LTR, so reject anything that does NOT match these types.
> 
> Fixes: 6870381285b8 ("media: qcom: iris: Add Long-Term Reference support for encoder")
> Signed-off-by: Wangao Wang<wangao.wang@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_ctrls.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
