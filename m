Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910854;
	b=5iwDxqMEWw7T5hiv3WTr8WTHllbHt44hO2vRqnvxA5PlNI7mEvN0QoE4G/YZUYCROseR
	 SFJtDLiZEC1oKx+eAguXXYd9rt7CYPMviLQB/rjz5cjqYYIiNscvcvWg3PAHD90WUe2gV
	 2dUzK4crgvKz4uHnYQNta37M7rYhuYSIbc2wNi8naYyQPs6/Y5gsv7BAoNQ3Q2NHbxru/
	 qIuPQT1h30tAes+iHpCzXH9JUEtI51QNlEHtu1d3AaQXQGOV3hthgBkyfQ+ppGb1CvpS1
	 //Dg2s3o3n+siBp5YOQF4rgZeTAvh9LdU3vkDsHjJWCTyDN4ka4lpBd4co04o6vBOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910854;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ilGgLF8asMhieoRjJnaDA152krpezAwFlFx6D0TT66g=;
	b=LQiCfUDI7ivB5edjF3r6FYMBQ8MwyiqQGnIom/cgttd/kINIsSqlvOU7Yr5f1CRqJ70i
	 lheWbLyMlbyLJiO0WyurGT7tJiWq++rIVgjWSSZmNYtFTmVyOmf0S8QFVS6cZLujRAj7k
	 I8FA86EDiNoJNJUIwrywVa+R9V612kgWp1z62NmjC/GRqteNmhPSIJc4N6q12iKj2WKTd
	 gKY9vaVXNzZSCrxRYhWAqINh2gFZy9mnCSypAM9nWRniQJLjpVyzlwLOU8+wJkgOnptsk
	 jm5c6ekcACEiJOTkEgzikepWZQPKemudwbaqIio4Ejt66pyc0/wTiYZI23aVmYiACmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g94MOWNz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XjODMonJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DD606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E0DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g94MOWNz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XjODMonJ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH6f1GM2998618
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ilGgLF8asMhieoRjJnaDA152krpezAwFlFx6D0TT66g=; b=g94MOWNzth+xBunp
	hOmkSpvC0JgQ6l3J4MLRkj++1Aj3Iob5oQovsEtW/rMKc+iynR1k56o2ngfn1sH3
	vFQA08z5vD9negODGIgxfl+5WF3jA1PGgCUYTX+nSAmfit/62phKuKqcC6P7GE4e
	+MtQjH+dvKjOLYUUSLcKrkJsCXWEduS5SL+ZS4L2llzptj2ReP1OmQsCptlWS/54
	4q6Jz12yReAngkZgMpRZfEOsZPIp8KSJSYRAegwpWG371C9fooXkxEvbWqKJTwG4
	+CLaNS4Dra+DQm7j2s+3LVgeJsHDfFmAm1RG0T9ZVZVf+2yA1mp7+iHDPPrce5/b
	8vCRxQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve0w18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:20:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94967c6d4f4so291976685a.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794910852; x=1795515652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ilGgLF8asMhieoRjJnaDA152krpezAwFlFx6D0TT66g=;
        b=XjODMonJHXxpwmhfHq4jCOgmc+C0k0FJ/3tCgftZn7xoWqq5O7W1TMTD9y3lktpiHb
         qrqbkg66GQ/69oU7KRmgsTxj3zPEB7v3Coe/hL1h6Q6QvkOTNeSmfq34hmJR1BqT9URR
         d4qWJO7oZqPbqZkX03vUekMTwneoMpXkW1WyBHlOsDKwQQMR9eCiSGhwNQ5aO/gtLKgm
         XqJyy0salEvlvGVWTy6xaKmwYnQSOAzwDpTJRe7RDvrfb/vcMaQ1qkH2U7pe/1a3XjPg
         APZskAdmn7AM1+J/yJ6pqTs5CePLMQ65fY5FWE+QnLhMTImzMjVoI6FM1NQzY/6NB4Mb
         bDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794910852; x=1795515652;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilGgLF8asMhieoRjJnaDA152krpezAwFlFx6D0TT66g=;
        b=b6BPWKuhHFp4fUpE7D5CNyvbBenwcJUZ97KWiTk7ZWGLXU5rM63fEaEqqh+Gqhx4Wv
         mRQsaHg6x0pXy9u0SQXaNUKjqht3Hic2jzbZ2Lxgto4gQw5o5q9IXrN6zYIFFoFY4qDW
         0itnfUw5wxNYB/pRT56GeLf8MS/H0h02HV9qNAWdaMSys15/WGG/b8mXMslpZLm7PcXU
         bABy954FSNnyE2pRHvko7Rewevriit3NBd06kS7V9mp57R1EbCC5UjntJ6GvXW1ACIrj
         1U5ejOgYVUtX5JlYzVON5eQWLpl/16DZBWJQC+bYx10M7z3tLt6nI8HVv3E1DHkZONWC
         8VEw==
X-Forwarded-Encrypted: i=1; AL+hErFcLouOX9958xO9jLqcltIziH6KdRN/MlqI/S/gr9PIWy3w/S13FTaXdYomGbHTwzhTzIt4C5E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zuHw1OaEZrVp7Qv2wTf15GeyP8WrY56bbAhurKDrvuUz/MLup
	SaxT3jybEQ/i+/rj+KNRKpw8hX7JiF9SDhuiu1HPfl+O2B71vzp44+kOO7zcMZvdpMK1yPp4oKv
	JfEoo2Iw34mvFfydHpK8R77lTT5pe6M1bs2dn7OW4rEPzBxQ4mSylcKbLacI=
X-Gm-Gg: AYBFou25WIFe/M3xNX5dVUzWwoSPRCr/l02UCoDGWwFDFXy2hccW98EdJbR76rV5q0l
	2KpGo8DzpYw8nv7HLkzXQWrVrVqbfJLm7j7AUj6j0ZjjyI2MaXXprqQpQ30HYkhFBsHQKExyUQl
	X25n9PeGb97teWPEryavbHzUCEJAxJdviX6LQGCTAwo8uKcuEGRl8JpTYYMCV4un4KyVi1fnR16
	q7sG0IF1hTsFadiM7sZHPYUCwqVlpzTras4RLzH0y3YvtBQGAnO2ILTKWSch6ybMmKeZWgFq9u/
	BAFrtwxS9iZ0TEy41xIb+83ZFfF8K8E1scVA+g+mPFshn6rIvKn+4iU+mYfw77duWIcVX+sVdmv
	03P4R4zRJdKTpKYmn2Z5dt/OwC8iGj4BMA9OudTTjMRcbg8dJQQtfXsBx6lEZHjDKYK2ynkaVSK
	Y=
X-Received: by 2002:a05:620a:4592:b0:93e:e2ec:3bf with SMTP id af79cd13be357-9494bcc9ef9mr2151887285a.78.1794910852024;
        Tue, 17 Nov 2026 02:20:52 -0800 (PST)
X-Received: by 2002:a05:620a:4592:b0:93e:e2ec:3bf with SMTP id af79cd13be357-9494bcc9ef9mr2151884985a.78.1794910851460;
        Tue, 17 Nov 2026 02:20:51 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783854cesm90386485e9.1.2026.11.17.02.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:20:50 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Lixu Zhang <lixu.zhang@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Haotian Zhang <vulab@iscas.ac.cn>,
        Alexandre Becholey <alex@becholey.ch>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: ljca: Validate the pin index of interrupt events
Date: Tue, 17 Nov 2026 11:20:48 +0100
Message-ID: <179491079451.28213.15188778805240746031.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113144432.1354180-1-alex@becholey.ch>
References: <20261113144432.1354180-1-alex@becholey.ch>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX6+Pz/mZ1J44V
 /v3y5UTYkYeKZ8DRSEHYjLiTBRvleXxvWc9GMhat9rHfq0bWomhxRvSK88bZrJYh4avPzbP38+C
 OUKDJtQzRU1LNR/S+YVKLSJHBX7N+8Q=
X-Proofpoint-GUID: Fk8woe0zwTmao4J37yLF2XPLhiogALy8
X-Proofpoint-ORIG-GUID: Fk8woe0zwTmao4J37yLF2XPLhiogALy8
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc2a85 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tYqXyjVJoe5DErGjTNgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX9tDJqY6uNwwH
 mtIDzVi1r4ko9SnFwY1PHH8qqqecGbGmABqcS6cE5jmMlElIZ4kQXioKrH4AcqxbYFKFZYYtb2l
 fiUIOXopoqitwrRY9yrgOJmUuBuoQJQfEYeSDvtoUe8uKqtTDHvqZoV8TY8gvAWomjkO5Y9dT91
 UqfrOo1xXg5TkpEhcDS7rgkBLYKw/rAK3h36wmO2uy26V1Ge3l4HuznLqTVsE1nR7JzGr+ozprJ
 nriNLRJcCpCW9GkRWiaQ0oH0AbHBIAcvIMURThB1qoXdJJGSNRda8WVgDHlegXOmBbziJhtk7Bv
 pK7+SULWTGx2aNaBugWjTZTMi6Xrn6ozzrNPVKgR9Psr7/kS4PqxI4fglIMu3fsHCQVexYqlBB8
 gWxSfWRBggCRtviwqjaGtVI4w+IvF7CaUPdhPwKAtrx8Ed3nPr3wJ25mn4J7JAlahTPFtjZbXCN
 hIHUbNOAhNRKnDhSwnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170041


On Fri, 13 Nov 2026 14:44:58 +0000, Alexandre Becholey wrote:
> ljca_gpio_event_cb() takes the pin index of every item in a GPIO
> interrupt event from the device and passes it to set_bit() on the
> reenable_irqs bitmap, which is only LJCA_MAX_GPIO_NUM (64) bits long.
> The index is a u8, so a malfunctioning or malicious device can set
> bits past the end of the bitmap, in the members that follow it in
> struct ljca_gpio_dev: the output_enabled bitmap, the connect_mode
> pointer and the irq_lock mutex. connect_mode is later dereferenced and
> written to by ljca_gpio_set_config() and ljca_irq_set_type(), so the
> device can flip bits of a kernel pointer that is then used for a write.
> 
> [...]

If you have an LLM write the commit messages, please ask it to be more concise,
half the stuff in this commit message is just slop.

Applied, thanks!

[1/1] gpio: ljca: Validate the pin index of interrupt events
      https://git.kernel.org/brgl/c/e6e2181c6920ff59ded349a100f80cf85d074601

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
