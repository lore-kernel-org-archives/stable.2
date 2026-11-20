Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178454;
	b=V+h9nsXYUGE7heu9icQOQ6gEaaD5OiAL8EEId+YYx/Rx0lGkm/Js1TDdSZczn9Q53cB4
	 MxMuS2v4fAdciMxIMvAObjQpvQy2/E1W2E2S3UhAY+yQtM7LR7gL9t5ZArbxYySMOZHFu
	 ubuANOFlWHQ7Z3uISV/rAIYjEdFjnVRrjg3NRFqmXKiDs1Utxy4KO3q106//hJjhXSW1J
	 OcUrtx6y3gjuTVnFKmRFkCjVywdQTiSvq8CQoKiiVsnmwculhEOja1C7kWKuPU7dooLbc
	 tiq0q2BITMFWRXv3peb/zFm8HFRkuifY5IFfE+TDrp3Lp6nwdOIihu39fvLnqxhD9CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178454;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YzbM14+AVErrnq1KBUQqneQO2pb1kMeONOhiFQwSLds=;
	b=OTAGYdNqZoqGmm4OCqwEDKJImL4K93MrnVrLx5V5VIpEm7/eIVl/ei54bGYQ0R8LkvuE
	 rIjDNMNx469fQWTizOpRnFtj/PR+/OAO0zIcfWOd35d35wBNTxrV1BqJ4DsPcGTqx1wlt
	 ibbII4VUtwNM01s4iYJdBYGvpx43W2UYCvmzXa7RVrJ+EsbLVVjax/rqI82RpGZJlNa4o
	 ancE3J4787K0JQ5QaAz2WBhxJBGPSKcYq6YFkKoWAaoL9R2oXcrZogkfv0qwAwHknqETN
	 Fk89IXYDO+y3Gie9xMebXlS+kEUEZWCiRMx27XcBZsyZos2VO0rb764aYFifFsfq6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XBxjmaAK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJnKocLV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAB606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BAB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XBxjmaAK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJnKocLV
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk0go2155246
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzbM14+AVErrnq1KBUQqneQO2pb1kMeONOhiFQwSLds=; b=XBxjmaAKzcY5UscK
	5YD4LSx69w+xCTAdSAr9bYg5ti7fg6Ha3cav6oQeGTaO5APW1wq050lAb7FTHKgf
	snUBdfsNTGm6DzcGkpLNyi/Lwd4qebVXpIO/9HSr4MaWiCNN+nT5ffOL/x+rCTXs
	p2K2zJdr83g7BC+TYJfP2mshHR11GaZaCF63LMu/A7MUCyE6i4SEQYByH30XEAqg
	BpwRh8K/ZHF1wjx/mBvX+2sacp3L9DV2lJmmtGwpElOAW5gt0+uaZQHZ0gzHo+3v
	YEXgRJF8L+t3xB2G9wHpG+T4J5gsL02XPaY0tTwAl4SR7wG/HJ7qKjHJk1PrrbRa
	INUEJw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2f4yhxtx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:40:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-949b0d322fcso160418385a.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178451; x=1795783251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YzbM14+AVErrnq1KBUQqneQO2pb1kMeONOhiFQwSLds=;
        b=TJnKocLVeU+LkqTAJDdSmp7HlO6ZrVVOSy9A9YjHbhGw7smjKhmtijpNMtCQw4yQv2
         D+04BVf40w8JNzisPisc+qX3DJtF5kaHOYK7A6l+JrupeEp7RJrc9g6skPi4L1f+M6Kk
         gLwMjEPyd0Xsdg4pP6yu8z1xsj1QzJbpx97IyYLiDlmVLqEasAAa1hqTpmg89W57OAXi
         YYDEt2a+GGGZtgENeYTgVtSXhFYmp0jBeI4qSGArtK8xYt8FYVqdt/KDIJFe5BD+bQjE
         nHruhlL+GH77Y22cHzCSKv9woo1qcp5kXftP/uzfEHL4Yq+vAJxjMYsJSmt1Aaa0idDp
         nimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178451; x=1795783251;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzbM14+AVErrnq1KBUQqneQO2pb1kMeONOhiFQwSLds=;
        b=aWe982HXW9Wo5+AiQrqkdyrih1lyS9213467dPibfB/d4psmuypyGqw6h0e9w95Gal
         AI7lUBN090KL3U2RioLMB3DirtzWXpn1MMuohbW5KLgBemb/Si1IJi3BMaiTIXj4rlRw
         ucldSCGGQ4e+HQErSNvsSoNc/j4sGjaIlluhtnjA7eZi6thApCiw1VyPzBt3hn0ZDoob
         Hm1Ew1dGic5fEefA2sfj1KE64VF7Yh+m/0syYeGqbB85gogS/ZUN298okjsaojmr4+ET
         6llj8B/NUmXmbNnq0YYwCrg0ARTpYEzLPE/HG0Im/ulJ1cLdRCmyg3Somi0+BrTyUfH3
         C4Wg==
X-Forwarded-Encrypted: i=1; AL+hErFZV38dG2ZGDFjCcjiyASltOaMteKwWUFfEIrkQVfAZnCSu1N/WK9XbM5hZutcbrWnKTOOadlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jNlGD+TlojQTidgjY3f1x0Auge7+mtvmcsvb3fAEkigDjpqp0
	1m9GN9jG4d8HOIdkHQtLZIHtI80RSXpFPpSi2HydR88WOVJJCS/nWFb1oXC7Tj4I1PlkQ9wRupG
	s29ILLEWyZI4VV6rD12gEQOEzfTBlEv90nDGfRoTqtBaaWInE2OyFc/CPldY=
X-Gm-Gg: AYBFou02JJk6YxJWswcUw54jD1lMbF/uJLs96zqcJk6SgaaeM9u7i2qxtH7Ug5UhrGz
	aHt1q32XTL0wKScwlDSSA4pzK6YhwK0Oyx7vmkLBGQaXafU0r9mKbTYjdQzR27Zyf96A3rezdwJ
	deks3BCUHq8XgmpCMa1SplVwyQ3e2uGYKp+q5SXhF7xu1vqLmfZNdwguwHmQId9G3DlRic2s9nW
	5A4S5U6e0G3ePkMr3RyWFgJfD/+XQlivA54K7hErwvnkUXTH4tLr2XITUW5XiSprvKhfhNGqrSA
	geyISMW7AM3W/nRnHBi6kdb9eRnohj5MmYD/QnD5UeigeI+io3fN2I+ZSEqUJxpYq85QmKcn8RS
	56YKjfE+oz2lBhqIfv2VGyNf5BFoCWjNy4qvZMga9eKPFuuzV3HUQ8E90hRcE9ldrAEjQsQjCU+
	Q=
X-Received: by 2002:a05:620a:1992:b0:949:743e:9149 with SMTP id af79cd13be357-949ba8239bdmr475452885a.6.1795178451487;
        Fri, 20 Nov 2026 04:40:51 -0800 (PST)
X-Received: by 2002:a05:620a:1992:b0:949:743e:9149 with SMTP id af79cd13be357-949ba8239bdmr475449185a.6.1795178451020;
        Fri, 20 Nov 2026 04:40:51 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm4234481f8f.35.2026.11.20.04.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:40:50 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: fix incorrect pull-up reporting
Date: Fri, 20 Nov 2026 13:40:46 +0100
Message-ID: <179517844379.14049.11659157399777710304.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113-qcom-pinctrl-msm-i2c-pull-up-v1-1-0eaf5c154441@oss.qualcomm.com>
References: <20261113-qcom-pinctrl-msm-i2c-pull-up-v1-1-0eaf5c154441@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zs54uN7G c=1 sm=1 tr=0 ts=6b003fd4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4VXmX0JWTMGhj3x2HrsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX6LgY3qgNiJKd
 lkWk+COAOhQxfmQBMejA3XREjyBoz1XdcOa9a/I2EA/N691mEUSA5KR2r554FFxwQ7JVIr2UMCX
 IpTzuLHkN3N+TTHX8YlsdfoAXovJ9cJzitzC697vJTlCE0sVuvll2xS0kGSy5UxNt/ugCM+Pj//
 PI1vy0ZuliO7zwG7foNoEWqeLWHMVV2/JZvpczy4T66/slNLSiT6hzADVaSfncfKNWD9oSAXBAB
 Jhq27qn3+AAAzMWnwKeAEkOC7Bimq4VG9Xh8hgcVn/WIzagXVoqqAhrrskPRfltCb8c/LEaPWHD
 436yFBvuaL2ECdenn3T5PswX/61UABzRxD/BuSDDWJujABC0rbz2OiCBsS1Pkisj6E9TcGM0d4r
 Symp+P8NxK9WwoGHdW95wPp6qlQaW6QSw7B6x32kCltKu8firYotzmtfiwgCZpPhwsvF5dT2p8N
 Ns5M/80afnD8Qp4stdw==
X-Proofpoint-GUID: C2uNLN_HVRrsv7xOb_aPBvxI4a0BZI1p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXxXmpf/wzDsc8
 s7TnE2/Bm6gIkD6K2j8OGi/BTrjw+OLMYojpN/ytS1vRvLwl/plEGjGGWNNsABZ7dwBRPvo/GWl
 9PZSPY1HkT5EiJ9PSTJWGZI46cmJQ1E=
X-Proofpoint-ORIG-GUID: C2uNLN_HVRrsv7xOb_aPBvxI4a0BZI1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200050


On Fri, 13 Nov 2026 17:11:27 +0100, Bartosz Golaszewski wrote:
> In msm_config_group_get(), querying the PIN_CONFIG_BIAS_PULL_UP parameter
> on non-I2C pins incorrectly reports a strong I2C pull-up bias when the
> hardware is configured as PULL_UP or PULL_DOWN. For non-i2c pins,
> g->i2c_pull_bit is 0 and the condition is always true because BIT(0) is
> 1.
> 
> Check if the pull bit is non-zero before comparing it against arg and
> match exactly what's written in msm_config_group_set().
> 
> [...]

Applied, thanks!

[1/1] pinctrl: qcom: fix incorrect pull-up reporting
      https://git.kernel.org/brgl/c/590058e6f640a79ea0ad114cd4213a4e4df27d07

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
