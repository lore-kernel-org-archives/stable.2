Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC44734EF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547800; cv=none; b=Lcb86KkmPqT+PQdolpshpPTh6Gr/1ReuSg3OAqMeXAZ2lW4Gef+GMMRsiJtG15JTaw7JGDSGw0nG1o3fL/mNoyDhTiTYqfD/gchaZsmfQI2/rWZvLrcZ/NPoiNAdgH8DNgJq/S8Ozxs8/nSC6kQ9+/2qc9yy7o15eC43jrt2eAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547800; c=relaxed/simple;
	bh=lIEZs0GXeegRirjBJiyGpN1Dtj48BN3h/g0mb2XBdw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwUGEEhYOGD+mS/2rCysulWfucBwNttuXwGms+41o2HbDe4tEiv2B0exE2kjHW4T01fdGgHcYuvFzOJrbCEq0TWYjZ1P4dATJ/iqjY94GUSlq61pGZsQ/mEmuRot8SSk/7qPmA79qTFGzRf9I86nQFhl3nEU6CIp0MO5Mqt+fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y+dKOipo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/gxnlOi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+dKOipo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/gxnlOi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G68dIu1730459
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z55uKb5eMnBqg/aAKyYCFAjbxpK+j/u+vm1xXas9DMM=; b=Y+dKOipo864fhB8M
	jm8ERbC7LkWwAXIklZ5bccaAx0rX7KJTIN/zZFgvneDnjhAJw4PGDqKGw5y5XzYD
	+89Ozsa3nhsdhaPLTMyvx5W3m8PUq0QtI7AU3q0et+vEqw/5MeJ93um2mRNvK4p0
	sL8TrYfxXZ3Oj4GjNonBQmSK6hkcUXGZ0Ewxqiu5LZ9QWCpQkS84isarrgvcRk5U
	mmWsWZ9Us/TNUdt27aQfz1mJ46p8JGvz3MeuYCqTdIiAfBFdS9m4xeV2ILx675Uo
	yJvZ43Iwi36uWcOCkXicLQUDQzwTOuy34fjOXmibqzXG8dwnGbB4lvX3U6K7qRyC
	/xYVnQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqkv7h1pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:36:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530d522a20dso13962961cf.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789547797; x=1790152597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z55uKb5eMnBqg/aAKyYCFAjbxpK+j/u+vm1xXas9DMM=;
        b=a/gxnlOimezpNm7VGXcSBXgKkFZVxj2zv18yONN3t0D5dCj0mOgZEwlqdNHHAk1Ndu
         0yKQawqCc3FV8p3ky1AY99RqLByKmotpkw4FUik35adeE5feX2FdwzkMMNAJGof0VuUA
         lMtLiLAWRXKU/9SJFZdgXVhlxb9t9380UC3lI2WmCrFDNjEMGjAPQuIL4tfwnAthbgxf
         nVP6JQ9tTALJIgrOTyptLdnGFnuTGrLVh3C5YQBz2bhLHqJYuVeKC7MuiIascHUmFf0t
         yi+GnN5XRegWGNoyRNsxn7MLRU26fr2S8GaTf/OoyEJzQV4YPpaNHiVDsPAQYE2XRuTE
         KAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789547797; x=1790152597;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z55uKb5eMnBqg/aAKyYCFAjbxpK+j/u+vm1xXas9DMM=;
        b=Vl+xWzWE9SSKN6dUTFAeBgJ0RVY2/5W2Yg6pTm37YxdS4vLxmy7S3IN+ZNuXEGvGaf
         t6l+gKpD0jyoJ3ksbdxq5ih9jOD1+In1DISoV8OWqfa3sJSvBsMBkR5idn6yeJqv0XU6
         jMz8tkiCFCfd9uhDk5QW/u8DedAQXCzrTS/hWv3KfBEMwJd7CEY6SEoSqlRXlHiYFZIu
         RHaBvekwSOMQDN8LAFsJeReb+It5MkOAlo9pTidW+dGJlj2JQSi9b+yb1gWBqOcnOZ+H
         p9iuxLquJHYuuosjNfoeVDYDdNv0DGXOTIKnVCLhz/Qz5cJP5FrsPPESkyHsIKGT7A88
         gIkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcT6pix1nJU7x7EYbB64UQrFBE+6jLVPGJR4597fAAUrMUQWpJv6ajRCYyO06HCXYskyKYNik=@vger.kernel.org
X-Gm-Message-State: AFuF++mIHto3igYi06BehfnLAZMqNeo7fvzFLNP2XYiRvPVqBLsymaOY
	GCBxgYwsCmVAKoa2jtMlNsgugN5l9InpkIdm8lryeUl5Y+SauoDkTfXuc2qlq8oMMi1+KGwBkgu
	GL41rusqWWRs7YYg2tZrM9+5dCNpDR/C7mptKxKJBqHfevsvSOQuoyR/n8GC23MqPyNU=
X-Gm-Gg: AYBFou1xV2DxKI0ZzeMm/0OKx6cOXPphJ2SY1RaGS/vToLDhq4oLnE/VpmJAqj+sC7S
	JzMbt3cteF2zn3C541Yy//OQEeP2mzeHGbx6DO/ACPHqMVS2q6pQj6Iw/n2N+d0fMIYICWFuwwO
	U27Es559QqiMN8+elvJhbhIydgbd2HzZ1pvyrhkiBHooWf6AMAsSstNcK8OgVxq621hOJ8QNanu
	ZceKB1rHYe8JpkepvC4Mk/mJnCI2ZAj41+akDupQgqyts7vjdqX4kASlv4xfbPZJBGRpXibb7pT
	HSkm6LxthfiXGDoHsvuHk+af3wPFWsJQzefn4bY9605LMmWdB6HpXOJRrKUnD9UYrCd66sj8T+9
	hQsQai1oceSFwKLW1QyQBQw==
X-Received: by 2002:a05:6214:4884:b0:90e:9aba:f095 with SMTP id 6a1803df08f44-9123d90af10mr26229826d6.5.1789547796889;
        Wed, 16 Sep 2026 01:36:36 -0700 (PDT)
X-Received: by 2002:a05:6214:4884:b0:90e:9aba:f095 with SMTP id 6a1803df08f44-9123d90af10mr26229526d6.5.1789547796463;
        Wed, 16 Sep 2026 01:36:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de48af2asm89705466b.26.2026.09.16.01.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 01:36:35 -0700 (PDT)
Message-ID: <7f812c3a-c933-4d43-98de-f4862bd042dd@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:36:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()
To: Andi Shyti <andi.shyti@kernel.org>, Liu Zhenlong <dragonliu2018@gmail.com>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260815140931.53297-1-dragonliu2018@gmail.com>
 <20260818175750.4205-1-dragonliu2018@gmail.com>
 <aqpNxZvYu8pDCchC@zenone.zhora.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aqpNxZvYu8pDCchC@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kNvcUpuZo71RC439K8r8CT5hiz25cacc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExMSBTYWx0ZWRfXwu9bqV6xwMJt
 LMMkXWRywaIP6NjqeqwWRUiruP0rwKrXo5YOAmtX+a7gpV1rE2Mf6Qo5fJVGAcA1z/i63UxWye/
 Vfs0tsaTHGSE738y+TwLOiQ1b3p8e3CUOeITcUCQaY9rp3VOZSfmr1y/+thN+s1LYoo4A3yRNp0
 WwwVg0RTDZprGNNmryMSaAL9VWuDqXuGwZynzFfqorZzPWKm/oRFyeJ1cPUC4ugUwwGbnf6P+iL
 Pqn2sYzoyDsBoYEY+gED0ioX99dddbUcGuK5Rj8l7WuJiY0o85YhTMaaKWHShx5ul8PxGM8ZQMR
 RsBgbndGol5FHvJ0lIwbrcHGsVgAZ5VlX8FWRXoowHf6cnwCFaYyzgcvdB2Q9zd/O76t3x6kUHR
 oRg1ocuK6KrpSi62de8VuIk/MLstfCxHeEpaqojbs5UgWDijgif5cTJ5+3ZiP43CMiDr75dCQQ1
 hY/NX9IVpCZ7wGEybLg==
X-Authority-Analysis: v=2.4 cv=eKmGH3p1 c=1 sm=1 tr=0 ts=6aaa5515 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7-2GvdTY6LjJ1SSQjosA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExMSBTYWx0ZWRfX7sP70tmeBqe6
 2hWT+f70+QVB5tLuIsdmMQGxFv2LoEcdhfmo+dbhWNQfEpPXIsu/PdxOiXyLzlX/OG6RTo8p4ND
 3O9yMWzH3PwIkFSOKBZuv4ZEhCthdT4=
X-Proofpoint-GUID: kNvcUpuZo71RC439K8r8CT5hiz25cacc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160111

On 9/16/26 10:06 AM, Andi Shyti wrote:
> Hi Liu,
> 
> On Wed, Aug 19, 2026 at 01:57:50AM +0800, Liu Zhenlong wrote:
>> The of_node_put() matching of_node_get() runs after i2c_del_adapter(),
>> whose trailing memset() zeroes adap->dev and thus adap->dev.of_node,
>> making the put a no-op and leaking the node on every adapter removal
>> and error cleanup.
>>
>> Use a devm action: the pointer is captured at registration, out of
>> reach of that memset(), and devres runs the put once on probe failure
>> and detach, replacing the three manual of_node_put() calls.  The
>> setup loop uses the scoped iterator form so the child node is released
>> automatically if devm_add_action_or_reset() fails mid-loop.
>>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
> 
> pushed to i2c/i2c-fixes.
> 
> Please, next time don't send patches as --in-reply-to.
> 
> We should train LLM's not to take much freedom as to send the
> next versions in the same threads.

The process is well documented, but the LLMs don't really seem
to care about the current chain of:

README.md: 
  find "Who are you / * AI Coding Assistant"
  go to the "AI Coding Assistant" paragraph
  read the link to "Documentation/process/coding-assistants.rst"
coding-assistants.rst:
  read the links to process docs
  read the whole file

Might be because we have no AGENTS.md/CLAUDE.md which the tools
look at by default. But it's not guaranteed that it'd be a
panaceum either

Konrad
