Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794896726;
	b=ThFEGy3TgntgkFyR6DXBjA2JLVUlEbzpeFjtrube71LcdQdhfNyE6Y0ycITPYyY8lp3P
	 xj8Be3hGz4kUIX9n9sbCGLPXhL8wCVoTMoUpzBiwLpopYKH/s7ARear6Y6B0CxntWVClZ
	 Ac3kT4m0OM3rslXomGcbOPyY4bdyLTXeykdgTdjkA3XLN1zlLOTlyVNzou9IdnQyGUqFa
	 W+actBI8Y54hpoGx/hIc9MPNnmbYid4p7+uyg9IHVcJRGsQjj6HPygirWMnBkW3lsK43J
	 xCTY/HLwXEITTwP0iv2cAcmczNh8ZM0kgfnRlJxYF+wZaLyCvHDxLqqHVsprxAQ+KFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896726;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=;
	b=CnvRsYWeOzeqSZiVhkwQ7UCKpYzfhASy3aFxycui+lifKX4Sytz42NWKKF1LnxLts8a3
	 4qGh+Ocw7Y/XcSl9+C7Kw3j+qWm163ue1tlT+sp9REavEBO4lCTAF6nae8uR7H9+ZIhZO
	 RHYrp29UDa5LxPmN1x15JgYot2cWFQbzeOlrQTOoHQtPIyPSrlkvUE0UYtD+S/1ldeyPh
	 dVSv+A9vedwU174UW6FiV3+pa/51VfBk3iMCg822d1PEnSEzKkvie6fRLT9+viWAypuME
	 309NmEfouF00NSCXK0nx+8offPrZu2PEhEFh8MDCOZiW9ribum+S8I9vuwk5h1REteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbyetD6M;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="PlRPIE/B";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5207606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5207606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbyetD6M;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PlRPIE/B
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2aIXL1800738
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=; b=gbyetD6M55TyiFm3
	+stp9xNsuzewD6E8kFAsyawp5FF072tq6NjzsIltJ7irOevxHhCSj+ZmW9ZZzb1l
	zrPvgKQ5RXuPXSd/JDUiT0ys6YqqDTbR61RHq2zPEi9tiOu+i3OQqyi1JDbVLg9d
	5HrxoW+p+U/eH3fdc0kHyW6cwWTJ6mqhlmpqLhxFWchN3xebtE4XHvRzZ7+AY4s2
	W3S/ajc0vQbZMgK+IXbts6rotjdK482j8fv55Tj0lnwTwoFsrJbpCKnKODVcP6kD
	u2HkI0ZdLdSuCYrqs0+ePH3GlwZRx11H7b9glala1Np7gOkLzJn9UMqkv8FFmM/9
	Z/AixA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y3dwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:25:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdd9fa2a558so4327505a12.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794896724; x=1795501524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=;
        b=PlRPIE/BlbSEjGRRF3p/sf5Gr75YyDeMBhFr7+iOMzhXqi8cpoVD8XJ3vFo2PInZLv
         rPyFt+mru5NGo4boxHxjr/oHKFXKr4YSROjz79eGjJAXc9AkTg456CHzAzROygmUT2mq
         JE9VCulQSn6afpm8P3BTUF3kMJZbyEWdNKVSK3l/c36uAj7ORHiS6UQODEwyhnlxzALR
         QdEbR0woB0ZMn79hgBRsUmjzDIX4h2tVlxx7XG7o227I6aaSfMajtOJaQ02KYWrsnLyb
         4eao2jFOzq4nH+q+jrTjtpPOAYuxdFFBz/9rp1d4sXW6muiF6eqiFcn0rRGcGmnxCXLJ
         ReKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794896724; x=1795501524;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=;
        b=SZZwBNDXDUs15HmOkOLB/MQ1KoORDeIUR7ZncufMcHYirC1ULdeA57GReZv05NlPlL
         +yGxEjbX5y46hVdC2Y4jvy+DV/9J2jA+zo/mzh0Hkuk2juQWOIU27hd2V07w0PuN4HIr
         0zykx7mWOo8V54594QRhr6553Y/R4Q1Cpa5V3IF1tFBrVb1uwUpUOfnRbm1gi70BYOqh
         gDZqFvb3tm0j8WlO2qZcMCLXa2qc1VjLteXMgeMpfMUOAi8/8B+5SD4QieoT2P9WLBA1
         LPobDBptm7dU8WVrBcls9zM6qPHY2BCZalWoGSq9fp9LGJnLNuWZT5ah+7spZklmFFur
         kJcA==
X-Forwarded-Encrypted: i=1; AL+hErEvNn4NfoDtwUVYo0dvrd7sg5lcU+466gA0nUWXRWlv5Q3XA1PyzJid6+oFYZYaayEh5NZVpfQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P5eJ/DOGi8RWJjZKZnMgP8FznOQpTJVd9t9JCE+MCCLXMRgoJ
	dx0WYVOGA86bLqzQvmdX4ODiC5kVQzKBAOHpRvv+N1L8WfgnIZEvcbyXbdqRZl5PXW8Nh9LRFHa
	zNiCZBc7VnXqpxPTzeL6SdDITEl89WsbCjXX6OAIG6t5h7Le+XvxwcxmeLhg=
X-Gm-Gg: AZFdTZdFAhpG5RCCr0pI65rSFHeojLe2ufox2Z4R9pG8hu48be9NWfEJanXaszKEET0
	fayzs/5QAjbgiJKA6vcSUNLRX7IvJ65CrygQBwu5m+dkGaH3NmS7AupurrTu9cs87ing+UwvRSw
	06rHeGw2p04ZCvcig2JEJvmPBmw8Ue/hBxcNfNFFsslTZhBIEX4eeuD7fYxTcXCKRM272Z1p34s
	JyozXXhEQRedQ1v9RpMxAb3olrkJHps0/fV2cExI17YCXyfKXDLSP6N62wNEuwTroOwFAXj4qjp
	0Efgvub6eEiq+8TsWII0VUKjajdkaJYChw6nCXE3oteEfMO3LqYFA2xdB/dXvVDqPStvzWxO+aW
	ja2T3X2gPsHhmLiKtsMSTBCn2csVosapNfegbi09HynXFzpGwZb5hJxWBZdmd+1NTOHWLHIhVyV
	Bxcpk=
X-Received: by 2002:a17:90b:3f8e:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3b1b0b5f193mr11585557a91.66.1794896723993;
        Mon, 16 Nov 2026 22:25:23 -0800 (PST)
X-Received: by 2002:a17:90b:3f8e:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3b1b0b5f193mr11585546a91.66.1794896723403;
        Mon, 16 Nov 2026 22:25:23 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abebf1aesm2512101a91.16.2026.11.16.22.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 22:25:22 -0800 (PST)
Message-ID: <2a4f99e9-4b51-42c5-9852-8747bf8f1a14@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 11:55:17 +0530
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
Subject: Re: [PATCH v2 2/2] ufs: ufs-qcom: Enable ICE before enabling crypto
 support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
References: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
 <20261112-qcom_ice_pm_enable-v2-2-177e454d6f22@oss.qualcomm.com>
 <20261113040820.GE1742@sol>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20261113040820.GE1742@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u3lNzN4_EpY3o9UNpDEoYfBc4kIRQzY_
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afbf354 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=x_L3ctan3gn5YDiFMPYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: u3lNzN4_EpY3o9UNpDEoYfBc4kIRQzY_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfX32UcWtT8PBOx
 QnjzbhKpWXRNg54FGwfEdYfHK03R9BJUqX0E5PjM9sqAWlU+oqdocWQYtPyYtwCQz8JF6lB1me7
 EXUWw3p7WPvgu7UDVHlFHIIR6iiIVgo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfX7jEWhJMFowM/
 rpG73gj/UfvzrT09t3h41d85U4jd7ipaG6A3eihs4YI0t6omCoJt5CY5Xe8m+7sj+72ygVSXkSh
 4TYgj9ck2U9t08r9wxvQsPrFfzp0KCTRPj+j8EXfJdKx9cOsLjR0pstkZlGi1HGjbZwRkUk6sUD
 kmlWAvNiSk3eN0x2mJbHN3UAoE2wAcRF/YaMwkctqvKFT2dIv/XbsTbJZ5NQION/FO6F7ahW2W+
 MSMH3r6HeCxGDSb0NIoX56goHm3OhQlODybUOrbib6WWVfdazbZHriN4j+ApJnC3PiCBnZt9rGZ
 hAo5ngscT9l23yAc+jdjq8Q7+k9YWXAtpcOMtQVZvPhiVLpJSWuSb8H7PJg6PXQh8KI0teZ7d+e
 IhcHkFtjQe8OmmHIGnit+IkJwoWQf4FUapKsjXrKiasZxjNzpxqPMUXu0xWVFbD3+dmETChydLH
 LzTI5uLdZx2vyMq+caA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170025

On 13-11-2026 09:38, Eric Biggers wrote:
> On Thu, Nov 12, 2026 at 06:48:18PM +0530, Kuldeep Singh wrote:
>> ufs-qcom currently exposes UFS crypto profile and sets UFSHCD_CAP_CRYPTO
>> before enabling ICE. This leaves a window where blk-crypto can issue
>> keyslot programming calls before ufs-qcom has explicitly enabled ICE.
> 
> Please be more specific about what actually goes wrong, and why.  During
> probe, the crypto profile hasn't actually been registered with the block
> layer yet.  So the above seems inaccurate.  Likewise in the MMC patch.

Seems i explained problem in cover letter and didn't mention here.
Please refer here:
https://lore.kernel.org/linux-arm-msm/20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com/

Actual bug got reported in storage drivers after introducing runtime PM
in ice.

In UFS probe, setting UFSHCD_CAP_CRYPTO enables the crypto profile and
let blk-crypto layer send key programming calls(i.e
qcom_ice_program_key() in ice.c) even before UFS get ice handle (i.e
qcom_ice_enable).

OTOH, with no runtime PM in ice, clocks are remain voted after probe
too. When key program call comes from blk-crypto(qcom_ice_program_key),
it calls qcom_ice_writel(ice, 0x0, QCOM_ICE_REG_CRYPTOCFG(slot)); and
works fine as it's clocked register access.

With runtime PM in ice, clocks are voted off after probe and now same
sequence(ufs-probe -> key program call -> qcom_ice_enable) introduces
kernel panic as it's *unclocked* register access in ICE. That's why it's
important to enable ice instance in UFS before blk-crypto trigger any
key program call and hence moved qcom_ice_enable in probe.

Same sequence applies to MMC.

Though the issue reported once runtime PM in ICE got enabled, it's
actually persistent always and ideally UFS should not assume ice clock
cycle and get the instance early.

> 
>>  static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>>  {
>> @@ -188,6 +190,12 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>>  
>>  	host->ice = ice;
>>  
>> +	err = qcom_ice_enable(host->ice);
> 
> Use the 'ice' local variable.

Ack.

> 
>> @@ -636,12 +645,15 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>>  		 * is initialized.
>>  		 */
>>  		err = ufs_qcom_enable_lane_clks(host);
>> +		if (err)
>> +			return err;
>> +
>> +		err = ufs_qcom_ice_enable(host);
>>  		break;
>>  	case POST_CHANGE:
>>  		/* check if UFS PHY moved from DISABLED to HIBERN8 */
>>  		err = ufs_qcom_check_hibern8(hba);
>>  		ufs_qcom_enable_hw_clk_gating(hba);
>> -		ufs_qcom_ice_enable(host);
>>  		ufs_qcom_config_ice_allocator(host);
>>  		break;
> 
> Needs an explanation for why ufs_qcom_config_ice_allocator() and
> ufs_qcom_ice_enable() need to be called at different times.
I didn't get any issue if we enable ice in POST_CHANGE, I added as good
to have change so as to make ice available at earliest.
As no issue observed, I am planning to drop the change.

-- 
Regards
Kuldeep

