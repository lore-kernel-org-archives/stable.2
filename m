Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699684;
	b=3YYOK01Yt7wnT5/7BXnlTy04ebfo1TtxfmdRL7kkV6EXKay7FZfao0ERxX+GRIuFtNmJ
	 1wYMuDXZvGYm58UCyHtBJCcuWlUWnHFBA7lTUt6zK//0DaYjm2Lexx//Zdq4jmpxUUXX9
	 DBfHRtu+564sTddLy1Wtw9sHtz58guWRSQVgmFAiG70HS+Yo4gq+7GkXrFeGUTSJMA5Db
	 rG6Iiwj6Ja8IdjQa7HuaO+0uim4/ulw5nNEkOqHPlSOpS+/3wvxRfUeqav6hGYXj5kjZ2
	 rZkZgTe+hmsNtsYNIAPQ6fED/hrXuyDmr5jRniyS7IIFV93d9J3tMLtKO2iChgy8npg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699684;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MlP1q3VZQzMJWxzzvYQLQv+zuzEymMrz2V7pNvd5GA8=;
	b=WFX1uVcl8Ojcn9ouSk5uYZvJZHQsAwpkmYPDExeki4+1noo1QotpSHbLW2mMwgumHQNh
	 U713UVYT/vPgx01cZM/St1f9glIRhmP1z6bwkpC2Qf7qQ4zHjU+DVM/g1W4p4VTHdh9+d
	 IRbOPWH6Ec2nEakkDRwcGOo7X7K4oTQ4JJzbXf8C0CHXCeiB8OP2zRxO0n1v33khUEamS
	 tpWx8IzwJaTE6qx30v0JMg+PPeuxoTD7GF3QVhVndQ6XBaoFZmElSz67jeJGV/cPwBink
	 W4arakRa3QQQAyFV6BXtwWeu5IWF70OFQ78usyE+QKxr600HcF0VLKq1l97wP6gBNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fpCO823S;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJM31CaU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE400606EEA4
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE400606EEA4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fpCO823S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJM31CaU
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37plL0470803
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 09:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MlP1q3VZQzMJWxzzvYQLQv+z
	uzEymMrz2V7pNvd5GA8=; b=fpCO823S32g/4N/mDAHnZYtkrLuTEeHpslQYwUZ/
	0xJKZh2WSWxgEV1KXXtn+QGzIzJaSXjmEwfXOgcmdqGpiyCvUZ6V5Rhr/dF01sDB
	IgI7oWryKEE1obMccTAQvR4uyR4XN1+52edoTQQbuWNgDBnAwyfkKxSmeJ4sIGJM
	xRqoWqICgoMvMWf8QSSJEheO2AmZK+KLLoSTHbGc5MtuclgIFOUFT6WyQmUXD6wz
	klh44eKpTODAeI+OuJ4KjdhFTnzMbGSGJ2Kf2bfOuEHuo5zLu1E7WyDjguema3/b
	MTgg7VUk21N2xwyUAgsRkJnvlsWPERsfQI/UuCwC8XAeyQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq081u4ad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:54:43 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc01d48a1bso432481137.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793699682; x=1794304482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MlP1q3VZQzMJWxzzvYQLQv+zuzEymMrz2V7pNvd5GA8=;
        b=ZJM31CaUQt1CYhSIs6qQpS6MiodNNi+hnp73uLmctfkN8zcJjbHFCbC6Zd5dBNRZmP
         aH5LN6ZOlkuyzXa9tIQGFgN0j5HanJ+HK7ITIxrPMIo6rk9t3+z3ajk97VGe6Ie8mFj6
         iE/wCFbc/I3Z0Lm1TlQ4mGKwNM1TAfSamp+mvW63uD0UvBv5VOD+fT3xNksDtUHFGaA6
         0RMmVCRjBPaa+5iB452WZI7gfmr7xp7L2IqjOXsseznleSYN/o7Uc3wUvrH2N0Hi82HW
         2llMdbJMaZm9IlPH5ZvUYh1Na7KZ4sBSk1iRoHeAn/Ti8t8jaN2lVEoXFr8TZrZJwx93
         I7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699682; x=1794304482;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MlP1q3VZQzMJWxzzvYQLQv+zuzEymMrz2V7pNvd5GA8=;
        b=TawBIcmO6VrCAsGxdm0sxZ6TF2j4sn89GwEcoArjH6GGRq0kHteaycBzYJ5jY1KMJ0
         wu0Hls1hwNm+OvHpvCxRTiIizXsY2OFJGmYnIEbwaWxLTLasqJqKGQBGrH4vyJr+Mqj5
         y7aEN3Tqjgptuo1x5S6nVShQw0hogaGZIkO1Umg7dIe4JvXppGXcX5hq1r2U/qfSq7EH
         ryIYxH7pus7acK6hWywKdEOWxaoDsEfCKyxI2u8xN0SGSh+irHBp0/zX4AZqhaOBhRO+
         WfLipVLritmUX05WPyVWFv+MsJyU38cWqAByZKbHxLrgbCUAyg3n0UPpoR/38o4Bysya
         XiCA==
X-Forwarded-Encrypted: i=1; AKwUvBzwhL+kwCd8g/P2mcSs9i0wZX86E/nlx2d8PIHYOvxs+NeLJrPFnto2XMSo69j5kiQCROrbwy8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DuOPosbNMkvTDK6KtTKHwTaiUVDZKtii0qsK+gr/K6k7ijexz
	L+KxE643H6zeXq1R4mdsIjtXCYJkm0Nd1FNFjBCbSikTBmqQhU4eO9fFCwW957520rMUsKudj9x
	fZ9B3q5nNF3Z/DYDs4oUMlcNuyipH1LYCmBROnrElm6ZUcmZGzo/y1MQ7aDw=
X-Gm-Gg: AYBFou2zfecIG8/MdWkKnq973/QTKA7Sn2qJV5Rflv4o+MBQDJdi6vwuTEZjQRtqbA3
	TCHhDABVQoK3lzG75QZ08Dd2JK9z+zWIMPSBSOFN0HdZGrgDOEkv5hPO9hlN54beDPSnl/4FUTC
	mnbM60o2wYU0NXrG4u/nTreBiz8/fSbekdm/4gSUkuXeAQhCCP9HT+W4nub9ulP8nSbX1OA2ZFs
	SHzewDeIUPoELjrGa68IVltpBQUjDJOcEZpTUSQXdxCLPhIjnIJ+XZ5SbGllpqrmpgDNGKoJmsq
	jiVLf8yMdAKpIRXI/5zpuYFcYqWWrjK6ZUcflvs6/vJmCijC32MjyPYpIvljAZxgaM6BYiX9NUc
	hlyGT4rsL3TICbfsytcLMVrODjtkZMW0vpBZewp4E6oFbWQOZLjS1IDxClNXPNBg=
X-Received: by 2002:a05:6102:a217:20b0:7d0:5add:637 with SMTP id ada2fe7eead31-7d05add135amr2794499137.19.1793699681815;
        Tue, 03 Nov 2026 01:54:41 -0800 (PST)
X-Received: by 2002:a05:6102:a217:20b0:7d0:5add:637 with SMTP id ada2fe7eead31-7d05add135amr2794494137.19.1793699681192;
        Tue, 03 Nov 2026 01:54:41 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm25815616f8f.55.2026.11.03.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:54:40 -0800 (PST)
Date: Tue, 3 Nov 2026 11:54:39 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Fix the L value of Zonda PLLs
 with a negative alpha
Message-ID: <gvcpvbyzxrgo52iu5ba2s4sri4wovte7w6pss2zuqtiptemy7f@5k45zx3uih4a>
References: <20261103-clk-qcom-zonda-l-value-v1-1-9c271ef29155@oss.qualcomm.com>
 <b8d60bb8-7000-4f9f-abff-02f596e1bee4@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d60bb8-7000-4f9f-abff-02f596e1bee4@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfX5K1671K4glEq
 Bgzl/tCdW2f3/yShu8DUySWEL8vezvn28cl4nYrCkWCeH0sx/DKBvIJIjS4N52JLXEyWRd5ZrRJ
 HgKXlnavz31pN/wbHghJrUcoU401GBE=
X-Proofpoint-ORIG-GUID: FmDCNg1alm7il70EpRbvfEDBqhv4EIVC
X-Authority-Analysis: v=2.4 cv=F73C5ahN c=1 sm=1 tr=0 ts=6ae9af63 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=U0MhLFlXrxXVFuOl:21 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UVt8oCwF8lmOR23gQuMA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: FmDCNg1alm7il70EpRbvfEDBqhv4EIVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfX83jgUbCOBygy
 yy8N9AujyEVeJUWfEPfRhtNIIc73RtcnI+kWlDTsyfz9exwTat3qmcttbjr1xZgV4CsXJpp0nAJ
 29LQeTpTTGuafACVhwQNsCUf1Zz3rb1qAp1eInJYnyWA4TOiZVue9B1BCuOBwKmZ5AsDjJDh0oZ
 mTDixr7dnHrjzThMALcSIVtHn7XOBSrhRqGASdFBZ95A6WeFkrsql9mbTp9npT5zKWMYPl51f3T
 n6jRWziqWz063crrZ/HTyiChk/lxd4E+xNwykiWaV7GN4GE06GQ7R2+T2UZOK7K+DEVjtvZtUWr
 z3u3HTjqqiXRNbiGO3k1B2tbEJ8VpWw41tTjUUm5BFd4MrRqelGiKTVyWEA6j4eZ/6zORzLI367
 XNJbWAVZXds0O90TBMdDA0KgLSL9XKMCcAhSuY9HTPQBML8K53d7vC81xQGocl3tvu2/9S+30rf
 QFeQg5vkzZgmzunGspA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030039

On 26-11-03 10:49:34, Konrad Dybcio wrote:
> On 11/3/26 10:48 AM, Abel Vesa wrote:
> > The alpha value of the Zonda PLLs is signed, so for a rate with a
> > fractional part of one half or more, clk_zonda_pll_set_rate() programs
> > L as the integer part rounded up, through zonda_pll_adjust_l_val().
> > 
> > Since commit a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the
> > zonda_pll_adjust_l_val()"), that function adds the rounding to the
> > requested rate instead of to its quotient by the parent rate, so such a
> > rate change writes the rate in Hz, truncated to 32 bits, into the L
> > register.
> > 
> > Use the quotient again.
> > 
> > Fixes: a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> > Prepared with help from an LLM-based assistant.
> > ---
> 
> https://lore.kernel.org/linux-arm-msm/20261027-nords_dprx-v3-1-5d98b2c6c263@oss.qualcomm.com/
> 
> Konrad

Thanks. I missed that one.
