Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180142;
	b=r5BqMFWX0LFaxFbjMEkjU070nFDXIf9XKEUdzyfQxu6PwNlNKgOUQfJycOUjvZaIX5D9
	 fxE6UfGmsvQAqHWndFOyBez32ShG0GbWRC+UE9E2eNbfp9Rl5EMHtJKbn6jjUhQBJT90X
	 3SGPlSmF//3tDyKGRWc0YKQ1ikY8zU9O/qLHdujcx1+yTXWnus941BBtVf1EmB5zNYcZE
	 sa6D3buZoKW6AAYIlhR0iYFwf2JUlT/DmTU1Hr1vVzaWd0XzZHmXvV6Uowy4O6PRgVTth
	 XuV6ELgRZiuc6DBYZgSiW1wXX3fEwbyFMjCA+FcP89WhNhneh+EioM/Hc4Ve+1wo6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180142;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=O7UFyGc7kgg/xP65U47Z0ECqHDvtGybh3bypLow4PPw=;
	b=tbxoSHOpN+WeqmNdKEKZ6ZP/HZ+UE1/nO/9pDYx1rL/wkHLWBRYf1z65GVKUu+dM56K8
	 XPMVQlASXctMXhOXE0gRxsEaPPalaJNKU+Dvmma/wHIxnryK7uxBUQM0Er5MpxhTfAm7F
	 YJii1IOZQ+RSK+mS0/L/orMrcPOpJTRp2/WHmyohGo9N9RrIy+unNJ1wkHiqOIwCFRTDl
	 GtrjxZaLyxE3uutcDyNkuR+GIPB1cbd5MrLpAzioTHICQsqV16odfsvyJp0Tr3cV6vsrG
	 TWDlW/9WFiVx43LuVpS7o4dfQT5n4gSYd7uYX6uuZeKKppLSF65t8OX5Hf8RouSCr4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ldPlcGE0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJaC9kV5;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA96606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCA96606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ldPlcGE0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJaC9kV5
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K8Ai253383
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O7UFyGc7kgg/xP65U47Z0ECqHDvtGybh3bypLow4PPw=; b=ldPlcGE0hlHPeHPP
	QJsuYuWJOSr1QAAkv9stM42AGaYcrar0p3Wj8m8+Vj+MunnwUcro37aZ/XgXQcq7
	lGk8u0R3ntPAuRuPr1asbLLMGf8OFvizMn7uilvZWWGHR0BEK82XQODY14/tM+km
	bSuX2pTt3ki9I6ubtu06bghbBUxPQr26tgVt0bzXHlbCd2hCFxikGiMw91ZWMns7
	7DJGZB0CW8tmbvqjvFfm3GM8VWkJha07wu30iEqSx1F0K5+HUnfMGXy3oJqhOaeJ
	e9t6ZaC+9HjalTiNd9xTOGsUa61WxjZ9rmCRxz5Lu/GgvDT4Ea5SE6GA265As6FA
	L0XZNQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be1sm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:35:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb71b1443so146142885a.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793180140; x=1793784940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O7UFyGc7kgg/xP65U47Z0ECqHDvtGybh3bypLow4PPw=;
        b=cJaC9kV55QEKY6PR6dYpYmWriW3VmcASsEsDUP+1uDHmUt+jf9r99Lp2ItoNOAvyDI
         gRn2LOdI7nNrG0gC3kuZRxKmfdxSEMJfRh/Ycc4tihw5SLBICuLb+gwJNa9SdAuUvlM1
         4VaK7XZpsEB9brGzyapIMCSQO0Y6Ct4sH+lWXnkjoH/YskK4LBQCWQsUu0HIrGb3mjHu
         KaGbNUe9bTllLA9zx9NyF7lGqPgWZ01m/j6Y6W5MvIoWSv7Jm9Knc5xxWcEvKcXfOnM/
         lqvDi6J/rtfn2ImyNcbgiMUxHe5XHFhAQLRY6eCgP9BVlgcfQmvPOoNth89GNUdMt/hK
         68yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180140; x=1793784940;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7UFyGc7kgg/xP65U47Z0ECqHDvtGybh3bypLow4PPw=;
        b=aSAsuwVjveTv6WplADZ145n20KtmZPOtqnhtOjbGNDZFTUvLRLt6grzJbi+3ngpELO
         cC7hWCW5TP+L3ayUh/QSdQolIv8t4Rve38xccvTv6AG4oSYOUUzgNJ03nPOzLqco6o3w
         lsuLEX65Q+6hdn4Kw2fzMwiECepFnS2zsn6l0I8cwCSJYzzqvJJma8Kq7ilZ92ef1G/L
         WIuql/VKJfRHmcmH84bp2lom48q/Cve7EyyexufGRvBKevtxbN4FZJoC3IxFLyjVlRF7
         QJ+/uQ6Yw/SRXSBcgqh67JqxA4vX0bfVC8PxlBC5I8HZtwEpK41qof0xdXlpJfG+7zT2
         18vQ==
X-Forwarded-Encrypted: i=1; AKwUvByRdsdfZCeH2bOlB6mRkLNl2asgLuvUesktllM3pCDSTK3SVN6KlI8hYTzgAoplz55ARyrUzyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0ZUROp+PCWFeaEhLQUMbnHQQD0RDPOuvX7sHSx1IgANC70EQm
	81Ea6EYMX7jVbePbXB7r80dSNBOk272abaFMb+zqo08VkTh19NnkbqKU9OYCC4iY/WUR15Ph7R7
	9qZIe684rSKDuzy+kqHWG15aTf+xQA2jmUhm6GEmuFo/0iYaHn248Ydy29AQ=
X-Gm-Gg: AYBFou2z57F6AwewKtmR1swZhdzxhz0iep5HU2UR0wd2q6aQL+zQbdEpEZq/PHLy2av
	OdGw9xpPFXcQjY6jeqaMLTgOZjE733nRRJ6BFP2UykdwYCk+tqJzMNqWepCVOmEdNivoVR4WSro
	My7Ff9oFKVQI+NvEls9a8OzMRdAmTNVyO6QFXK3bmcpFVlhbhsZlfrtXViNkJUYswDkDSb1+k8h
	Y4k8WDxTfpWhCgldOZHJa0npZG+wraLTRZ0Yc9Jcgx2z6PwVDA5f1hermId/OdPKePvb9aGrFiU
	3n0k28CN+pJ1sjiU6pReT+3B5OY/nJjoWYsWwTy+e6cggGpIqOEMGy6lPoXcJUgMMUjNcry+xMc
	yS1KpsP1iGM4wsCnaJouv8eHnp0xPvFb3jYfaW9HymUWC1p6KIkS9iXEZ8/US5v7u3oiAYIfO1z
	1s
X-Received: by 2002:a05:620a:838d:b0:93e:f4f4:346 with SMTP id af79cd13be357-94408a96a06mr192968685a.39.1793180140018;
        Wed, 28 Oct 2026 02:35:40 -0700 (PDT)
X-Received: by 2002:a05:620a:838d:b0:93e:f4f4:346 with SMTP id af79cd13be357-94408a96a06mr192964485a.39.1793180139398;
        Wed, 28 Oct 2026 02:35:39 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece13aasm25490073f8f.58.2026.10.28.02.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:35:38 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guangshuo Li <lgs201920130244@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: brcmstb: fix UAF after IRQ domain setup failure
Date: Wed, 28 Oct 2026 10:35:36 +0100
Message-ID: <179318013455.11588.11130360473129768323.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026115227.41779-1-lgs201920130244@gmail.com>
References: <20261026115227.41779-1-lgs201920130244@gmail.com>
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
X-Proofpoint-ORIG-GUID: yilyq0uQg9jq9sJB9h4rx-A6A4gO0sao
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae1c1ec cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=IDcPP8y_D6MSDcTJfBEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX9J6tyou2zo2f
 mjmkrSdAxPz+rlHICj0rv5nyHIe444JUTlqiEPnYLdWrviJimlnCwc1aqGJFxOQM2KzKl7cNBUw
 yeyODAY1kWh7FZe+S8vC0yIV5U+1eZc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX7c4alGZXyUtP
 7V9gIo3VXXiQL3/8BnKDB1uv88L3oqgmbonkY6IhQusD1IWDI/orHJ1GuIO+AjdvmZMxyNH0w01
 i36FeCf0wgtwjozGA2uZUD4+FSZV8PB5N0/kaXzc/WS8GaTCk/VZNhQYavhYsl7PtSFeFvdJ3A8
 4oBqyXOcUvTYz83tzU0qTNCzwedeCEVGh95ikABmFAeWVZGMkUd8CFCgMgJJLZE739bTUCN1XFe
 FwtH3eawxPBeXITcvh7wYzI0XO6zALRbRQ6GqRsy/Rrlxwt3rmpC7HCUEW1Xn+XGL4weAgz79EZ
 oCRs2rvx3oBfW6cq2nam5UXaL0up6eB238BOYaDwa6J7VFB8+QHJguYd1rl7dS3d5Ir92XDKh8b
 +OvWKDIBCh8Ux+AzUjtpXcow4oPrOZsuBJuTP5nQhQdNj/toiQg7ymKMVlIGOJUNqp2KEMn65aZ
 7YWviTyL4uTr4fWn+ug==
X-Proofpoint-GUID: yilyq0uQg9jq9sJB9h4rx-A6A4gO0sao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280038


On Mon, 26 Oct 2026 19:52:26 +0800, Guangshuo Li wrote:
> When devm_request_irq() fails in brcmstb_gpio_irq_setup(), the error
> path removes the IRQ domain but leaves priv->irq_domain non-NULL.
> 
> The probe error path subsequently calls brcmstb_gpio_remove(), which
> checks priv->irq_domain and attempts to access the already-freed
> domain through irq_find_mapping(). It also attempts to remove the
> domain again, resulting in a use-after-free and potentially further
> memory corruption.
> 
> [...]

Applied, thanks!

[1/1] gpio: brcmstb: fix UAF after IRQ domain setup failure
      https://git.kernel.org/brgl/c/baa14758afb3e2828de1f76511edc1de50216f39

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
