Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540931F986
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857738; cv=none; b=lhnXjvI0qzFgxGAAqAe//wahcqZ7d+eKeJDr6VT9kB0HwQQXY0Qi1YqDK3L+4Wb3+QsK45+oOLTvbpujTGpranOlx+qIVjE2rLFHshGifpSIkyRUqHisdKvj1hGhaXRWpMP1cwnpl6Q1poysXsWK1ZucwygP3IO2qkC7cCsUQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857738; c=relaxed/simple;
	bh=dXYL09udpZGlmeEtYkW5pfuwxpM/XXs97rRTP2AfWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOrVUrv+7SnmuOgdSZpl81c72TpmrBdKZneweFd5tyqivVH9b6jDmnVBojO9vXLTxDjQhmyflv7mffdFdUmrA+A8duNYpT4/jF76K8yvvkPsdTtCv7EgO4gP3cP6kSuHpMvSd7wdISMrs62q3ZwAPHFUiSqhay0Fq+paTekklkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kG5ijOQr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eOBuGGHX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kG5ijOQr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eOBuGGHX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xNmH1062184
	for <stable@vger.kernel.org>; Thu, 1 Oct 2026 12:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9WInQ6TGJlF0IbIU9ZSYlxJslOJO6BnvCO552rLSGEs=; b=kG5ijOQrlrhh7EmI
	KcBeswqUG33eMQXt9Urzc4ZpQPUm+BFG57j6i/h4wFMXGL6yx5IHJ0qXWOoOEOZj
	Eai7VEN5IlufjtAdYM/NeKImPwsOiRq6xiZtkZZpzzTgsdHlRkCcHX/yuLsKoNJU
	PyVL1uvSKJigzxh3Mh+ZsTEVeJ1usepFbMG8oR9tEEmQj6Jkq4zuGImwJWii0eU3
	zVIndBdrOxKUxKUY7zjOHdBmJG7rcmA6U2oVD8fJZev0+xHJAIK/C2Hv/d4BE/AX
	tNVuwK9P/zhyTC3lF21a006aUr8AjexhYH7o9XhKgQDJEsN2kolnGkBiGdP8w35G
	dQkAnQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvuthh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 01 Oct 2026 12:28:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb98809caso122973785a.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790857734; x=1791462534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WInQ6TGJlF0IbIU9ZSYlxJslOJO6BnvCO552rLSGEs=;
        b=eOBuGGHX9Y+v+e5TDcMzypsFyriA0RmLH7P07SMwPN9cI4RiDEHk7NVTxp0OKD2kJC
         eIlA6H2BsWoNRKzxAlkhOqqe35jWOoeeVpFs38OXp/oSUoXtZPY3PBnO0Jokp70AEKMs
         geVwV2fXFCN8WUskVAnTgs/2hN/52AIlEEdSPN3aJh1rpYFcRR9CpUMbPZP10ZklKHDc
         EJSNESbJVexxwAs3sXecjyR5PBMXgsyP7kuK42/2w5OYdJxGse/HJmzAqwu0KlNAk2IN
         v3cc7WvmahYOtNqnxVQiFhYvGOMJXuVuihIg4hKezXRQ4Kc7EDoKN+Spu2jOJlNhm0gK
         P/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790857734; x=1791462534;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WInQ6TGJlF0IbIU9ZSYlxJslOJO6BnvCO552rLSGEs=;
        b=BdNFd0kEYUPTEQST1P0H/yijk+5fOZuz0cOvBS4yG5GKlroOpsvSpwgVwQIsD/c+Um
         zgHDGYBYx6Ri58kfpSen/zZMiSMdIeoRup3tHD7KDdtuYuViRNxyEaNQZ5Ehc/0WHjWA
         ZPz1feqVs2i6mkCFCaG5IkNllGsZKxpjRyYFcavDUlOemC+uQczzl0abkMYMKTxfs8DM
         iwA81iGESQ4iWfbOPlT+8u1wVAiBijvUdeGK94jkSoQpsjx5deSHNqaFPukLdDWUSo7R
         gSYPdzy4JzVa+LNKkpu8UnVPvjmWsPOlJpX5dDvfCzD2AhdOBMtcMjA/QV8rIyEIv/zT
         1caQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5OLNvIx0FIsNaeMNRhOcdegwfx+ZdUmeyA9xaXZVkhowWTGS8j06gxjN90pS0SkC2khcegvo=@vger.kernel.org
X-Gm-Message-State: AFuF++mX/QSMBIYUC8qrmXcwW9+2yyQzqd4d3+flS0FLj4i/apEob28X
	PaFiUBXztfmCBFoXvm2oKZdCmOmq4GvPGWolsHC5Ob8rRBeXhbirgx8BwpZ0IS9qk4FiV4x/iSb
	1Jc2oTbx0EK6gojlORjqx5fmougmBACQ0XzPZ1JRf8fSqe1Sb3bQ1Q0RnRiEzk9QH/3I=
X-Gm-Gg: AYBFou1IPK0y+J1nHZUoe7dWGeZb9jSvkDkkzRNK9cOT5SCnqiSFaBrQ/7Hs0zLsyLK
	ngjo1KAnuoN6n4Itxg0ZmfrKGqrMmfv/tltCZpQ0zFam2sk8mvTfyvLpVDHIL7hg66PJjpxhzsd
	FD9Ttcdahs9Kc/acYy4pSZwOU/6hApPUWJhyhsodR+nWHW8CUoqXz9daJ0UjtRL/Z0d1HGd42WS
	uUIEbQ4GjNRHlORrbtDzfJQYP1hcCG42sXQBS7d6EQmX6pOCCt8lBqHL3UuU5FaOlC2efhOXz/L
	MjY9X+3hGjOm77XP8BJDsxf+lTS3A4W8fhCn0qJTKXBqybl5kgVvzD6ejhJb5ynzN0aM+O7N8k5
	ZOTT4eqHhdgk7vmrG95Dq+FQgpIY=
X-Received: by 2002:a05:620a:370a:b0:93c:b47b:26f with SMTP id af79cd13be357-93cb47b0cd1mr567072085a.49.1790857733776;
        Thu, 01 Oct 2026 05:28:53 -0700 (PDT)
X-Received: by 2002:a05:620a:370a:b0:93c:b47b:26f with SMTP id af79cd13be357-93cb47b0cd1mr567068185a.49.1790857733295;
        Thu, 01 Oct 2026 05:28:53 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068bd8c9sm5915602f8f.2.2026.10.01.05.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:28:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linusw@kernel.org, brgl@kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, songl@zju.edu.cn
Subject: Re: [PATCH v3] gpio: mpsse: fix race when arming the IRQ poll worker
Date: Thu,  1 Oct 2026 14:28:50 +0200
Message-ID: <179085772818.11030.1529408482067612830.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929093646.18419-1-fanwu01@zju.edu.cn>
References: <20260929093646.18419-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _UzYDa3Z-Lnnmp_zGGIzXuVepp9ZiyQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0OSBTYWx0ZWRfX5BTcvZURTtLl
 t+KCZobgbT53CiHB9lgVPhuI8/2ajTm1Ot9PPP5+mLI56+dWMCgmlpqd4rWPZWfGzortmC4rxnw
 hIqkj6vv8U/D4PFAqmuVXhSnFKGmY8aSkjo/swgCcnFfgwuE8Q7LxqSaQFILa7pt+3ECvUDxvMV
 NdgFRXDl6//aNGCQdMS7uvEsZeBBrpfPpBilyWxuG8c/UAx9MV5mRZFR2bjvDgbJfK///jHDCG0
 /HERadVUbWfxzgWRe1g89ZRd2avdF7b8wtAA56vFDUXUHf/pw0NqwpUt0PDSE008f1JbH6/75D9
 OKzwknc8lENF4gwynoaSpg7n1quR9ZagbSKhdL+Fk0sPZ20J7de7YqtY0DmaNd5s6gztYgm1FM/
 tecQvszzhYzk3d9mUaYC4drA15KL90nVm3/efwb/2kugeZXwf4VaRsVFFeHL8uQ9k46dfjwdMe2
 6Df8TMD3bbCyo0/7gBQ==
X-Proofpoint-GUID: _UzYDa3Z-Lnnmp_zGGIzXuVepp9ZiyQ-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0OSBTYWx0ZWRfX1/AWPW4oRYre
 zoUJbC7V13HqOj4Bnx5x/egvkfkiqaW0fFYVC+5S3r9RjIJn7GjO0qXSQKb+kbHKM5e8FoMppm1
 d1MabLYVShg1UFJUSxnQstITXZsPPig=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abe5206 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KvT2gXNad9s2oUHfL34A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010049


On Tue, 29 Sep 2026 09:36:46 +0000, Fan Wu wrote:
> gpio_mpsse_irq_enable() arms the poll worker before publishing it:
> schedule_work() runs before the worker is added to priv->workers. If
> gpio_mpsse_disconnect() walks the list in that window it misses the
> worker, and once disconnect returns, the USB core frees mpsse_priv
> while the orphaned gpio_mpsse_poll() work keeps accessing it, causing
> a use-after-free.
> 
> [...]

Applied, thanks!

[1/1] gpio: mpsse: fix race when arming the IRQ poll worker
      https://git.kernel.org/brgl/c/7efa1a1953cd6b20b23a3524d5b4b81789c6ef25

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
