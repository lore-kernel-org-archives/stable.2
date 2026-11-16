Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824577;
	b=xpQeMZ0XTGkEsWd1Kjo4ew9wLJ9Y+VeegO3uEOqE9aSwEYrI4Yusf/pMDhs7qc6hraLT
	 kay2a70pc8t7FZh2eRq6K7aIQPoOP3Td6OB8a+TPJsIRo7d6sz379xW3PH+apCtutvd69
	 T9D2VqkyG1CRze2oLIyp3rMjj+yQeJKJ4AAMFLQIXtNqBoFjJ3fb07ctNbA6/oDdFokWn
	 zu/ODgllFZins147moLzCAIaRDk/4tSPS2Te6slWhtLD3zCdkI85UfxgtUeg3KF4sAWpH
	 Wikr6KRIJ/BZlmh5rWPvyp/hfMSRX3gfAaV+eR1k4d0v88PEL/h7O3DrV+87LlJtc3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824577;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mY/m8G6R6uAHiT5Kg97RYzOdiA/Zxk6otIa5uzGPv1E=;
	b=YLFpSaZrgH2/HRAKmlnIw9t5VDDswaQ3YBGklKfVvezwLM2V+9jKhSeLqNBBNBN88LX4
	 ropQhJiPXsdvedNvFINtFkeH8DyM8a8lTvNWy5dX0LyCVHHfsyRATgiHU7HjLURGtLMI7
	 ZGCGM8s+Seim3CAqd3uYKhIkLM5QPbnL39DJYmTWLVdDFhCH/JkE1XjlcUdb2Q4qbbax1
	 oL0lHnVab//hYPH526XWVwm1MDav4T4toQKXI9KSrBzKKBjRNZip2P4FRiPKfriVIBmEN
	 yOsq7tjKcsORBXMvsiYqhZLi5znqO5Kg+Uld69ddbzx3SolJBOCma0U78OA7D0IWPiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="g/kJjfDe";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RmYtdGIr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283DE606A33F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 283DE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g/kJjfDe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RmYtdGIr
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7evxn1895557
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mY/m8G6R6uAHiT5Kg97RYzOdiA/Zxk6otIa5uzGPv1E=; b=g/kJjfDeQWvOqeQA
	QDBJoKbsX/HjzL2fA2ke7wlJ8QXcVy47tfVjC+zxDA8mqPSWo4h84bh+0ymht1xT
	nDJZiML1lsQFMvoGdmds09kxUNDqL3MJxNbyZlqoq//Qfm55BBhdc3MskIfVbhhf
	VIOUAmDv6gx00nU8MVMXW+9MfMhieDlmjadt6CeaWFvMN4d8o187BTjibUzI/YR7
	9LxHWbTjZqz3tYb0Amrn9PMf7ylzAdGME5Hy8D0gUNez83hjvneMvX97nOv0c38J
	qy1qkUII6ZO7I9UGbXtc0CmCuEWmBccv3Qs6fFq6xctORyAr7PclXxb1twri61dV
	0q+f1g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdwxcc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:22:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0e00d7cc2so2995908a91.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824576; x=1795429376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mY/m8G6R6uAHiT5Kg97RYzOdiA/Zxk6otIa5uzGPv1E=;
        b=RmYtdGIrvCADu0wtCCMqAM3dp6zaLBGJ96EnuENI8TvLyV5s2xdUvmv1sFC2TkMlSA
         teLNQnaMae9H5DxrFrCPY4LQDyWvZh8r7SI3rxm69UpzZXK0yxzQclUgi1nt+a+W5aeM
         39jQtZhIlPY86mNVR6qHq0Bcpb8GDNzzRphljG8v38VqHa72Sovnno8u4Wvf09oOWvIF
         d4Rv2r8KEc7teCPYWXBDU9fQckvcrcCUAbseqy97l3a1IlOpywAyK3hQEuLLvlZ+4paN
         U8O1kurUqPNuyoMCwV31TJYtFWWaH7G2fosrQH41Ug4BU0QoTsFJvQl8xFOhXAi10Xov
         Dq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824576; x=1795429376;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mY/m8G6R6uAHiT5Kg97RYzOdiA/Zxk6otIa5uzGPv1E=;
        b=psW6D59BfvNpn8fw4dUoJcloKUQV+YH+cy00fYH9mlhsLzE0UsPaHDySp+7gSS7J1y
         lsra+USN0sBtpvqDG8aLTBlzvEEkfWrkoGLHhswCP0LKNLPtUaFG/1f/QkLx3Ef/5gr5
         QyP15KwST/POjilmSPFfOgpq1vup3KwSf0kJ09HqNzqi+tKrlqumZPFK5PLCGJBPdlKI
         txBwOghk+SkCWEQULvsSitF7pdS0WMAlxwWs4IBRhLvVnPq/bJDwFpeW/cz6+T68DvdS
         5v4fd+4FaSCal2swaiCxKTf+rOct1Tm24Eauv0Qx7KR/8R9yJVRtNbfNQEQTfLSgj+wz
         l3+Q==
X-Forwarded-Encrypted: i=1; AL+hErFN5yl30oxNL2BAS5liL12CswcWQEbvcsF6lTwIJgw7X4KA13abwxoXMf8vtI9vlVIZZrpSfgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+99Wo9BgTtVb/d3jR6SKadTlgV5FoMPyFV3HOZB+XVAS9rKgvJ
	HHKnZUsrvNd3Hv02eUBs8eWOf0hYQG10XV+Bdg4L4M5colrGA1jYvIjnObssloviDlK+R0UDzAx
	kFiaAFWV5qjb5yTEAdCx971139hQRAlV5/Fen4yM9dtw7OkllBozrBgjp6ss=
X-Gm-Gg: AZFdTZeiY/TItFXE3Z1mJCWgRMpmH4zt2VnnWiEBRgK0p2+R8jXcBiiiCMTSxPeW1HD
	8/v4N2BG4//tlTd6LfpVdp7os6a1KUIPPS4kvTIm1rzttJPB3rFBtYFmkHaFjWvOUWzL5zZ7BSD
	uueZ/ufatCT1uChog/xPvb8AMUfpJOdXgvcZOEi8dh6uDVEeKbB/e4MqbdE+M+wU5apbxGx6nb1
	2mIU8VgmKn1+siJD4f+4GF2UkCNH5Ut1Jsq7iMpHHvuPb6Zt+BWxSvpZzONrjjnr+j8yiNWIUop
	AcoE0l2iWQSUhuelqbDW94QpNtWAFxW4A5qqtfScM3k/SGQeBzzGzBIspQOftINCST0PAIkdtXg
	X6tiuswmryKpwNmKiHniqaU7gHXDe/+/kWJPZUatjRMGV9MRaD9kVvsaVHU+6u7Zby0sJieoiug
	HFdx1XUg==
X-Received: by 2002:a17:90a:c88b:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3b1b0ba890emr10201785a91.59.1794824575761;
        Mon, 16 Nov 2026 02:22:55 -0800 (PST)
X-Received: by 2002:a17:90a:c88b:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3b1b0ba890emr10201753a91.59.1794824575285;
        Mon, 16 Nov 2026 02:22:55 -0800 (PST)
Received: from [10.219.57.214] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f497sm21311203a91.8.2026.11.16.02.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:22:54 -0800 (PST)
Message-ID: <9472b028-d2f4-4007-a824-048dd1146099@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 15:52:49 +0530
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
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
To: Srinivas Kandagatla <srini@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
 <6648f693-ca76-4edd-99ff-9fd60e71fd15@kernel.org>
Content-Language: en-US
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
In-Reply-To: <6648f693-ca76-4edd-99ff-9fd60e71fd15@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afad980 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Xv27ygMx39hFiU9I0NgA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MSBTYWx0ZWRfXwWNyl1c5s3I/
 UjWeHD+Lz7X7WZUoiHh1pTlJbZ3QferFfQHx05iBiPRT/L88qO3sS9eEn4ceg1R1Vf+kmQEYJNd
 +gmtq3dnDCVFF9CasmShuGAoZnViYMc=
X-Proofpoint-ORIG-GUID: v5Quv04LduGfAvrlekYLftnQSzM_7PDK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MSBTYWx0ZWRfX5mIcFNHATMy8
 bRjy4EgdNIaIIzqQ8D+f3AK3NMjrb6YrPpK3RchjlByBQL+hfnAoClrU5TWAspiaJ7kWZgV4N2/
 IZuC6u3lZF2jrTb9Ngx4Ppw3QqFM7etwGT3rTcEW0ahqUZb6wffaXm6kip/g3UPhVD4xkUZlHLu
 ZpryXUFHIuqoljZMPRQdr5lQi2k1jTxezQCNDdC5yjC37IOkE3Qx8z+rd/6GeiBnOOc/0E3uYog
 kFFKKQmvpWtowh2XfqqZB1ifxDQ+mqU9180AWkMav8yCeZedVJVjeF0Fo+endAa1VM0fyKRkWUS
 Ch6hrbLPyWD/BTFqWDl7crxE6WczB7rpzIk7n9SYFbjQLtz7yGlRSYGG1QY9UqZMmA847iovYVs
 8fN2Bm0I5eMyDDknaNCCjhYpQ32vZVHhCMCYapR7LnPiQFLhyx21pIFtZCAVPsloCItrxIXM4s3
 nJgrLAYA7xUMxw0r2iw==
X-Proofpoint-GUID: v5Quv04LduGfAvrlekYLftnQSzM_7PDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160041



On 11/16/2026 3:50 PM, Srinivas Kandagatla wrote:
> 
> 
> On 10/22/26 10:08 AM, Vinayak Katoch wrote:
>> ---
>> base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
>> change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6
>> prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v6
>> prerequisite-patch-id: c8b4a3873f9cf0d69beff0f608933ae83faa4c47
>> prerequisite-patch-id: 05d9299adf4184e0e56d97dc063ab5bf227cc5a5
>> prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024
> This series is fixes and why is depending on enhacement patches? It
> makes it very hard to pull fixes when you add dependencies to new
> features or enhancement, Fixes should be independent and cleanly apply
> on linux0-next
> 
> --srini

Sure, will drop the dependencies in next version.
