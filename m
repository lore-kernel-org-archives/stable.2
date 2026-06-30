Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4A3E316E
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805737; cv=none; b=DxrClrZXcraksIXhWh564z6CRGX4Xx584c50T7iKhFMZAKPqp6L6CDOzxH6J+6TdJI1qzflBAzEAR5q4GNu9BrpVdcjtVvnIeiT8N+hZ/8Ss6BuhGoxEp7IxlATAfiV8Sbw+ocNIbMf9RiYwg+pCTWjLYobF+rXpnqYnACKUoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805737; c=relaxed/simple;
	bh=FVsTp1W5wAMou7tfbvT3MvGOwJ4atyI0HNj0OMdGxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwNJeE/LtPLqs9yrtBA52/aGbWF/mIMz7IBDJWpAZmlJIItyBLibysVp8zatUJGmW9cFzorchxwscPlexaBGDDcggB17QLkjzZLOH6hMflWZhDv/++YbTaSty5/UHoxVZf+be28ib0UXXXmjCUUVUnLSL8/LUfCg02GjnDOTK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BL8ASBoN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EV5m5dmj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BL8ASBoN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EV5m5dmj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CItT1055974
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i0OvYj2FpZ08KKJOnjskaUMgl/M91qfEsZGOL3FKGXw=; b=BL8ASBoNxXkoZNfg
	EXNJyjI4C6QaS5sbxsb4KFOBDEYR7Yos+njfcuxtrpjyJwJxcZldsWC8sc8JGsvM
	xrKDs5i4ldXb6o6YQ6c5iceyIjZxmDlfk6CGFD4NRpzwq1r33F8M3KGWoMD0B+Ia
	XPZk6ncR5TI8JqJd9p/YoZANgdNEsmKC+Mw79smAzP/cGvjHg9k0uq/Pyi3TsRaD
	YfNsYL497k70BrnmQj/v60H98yOYaLbRBbahcSkvvaNTdG7lwXg1mqvLpi/7yyeB
	h4FQd4p2xFjGSoDrJS6cDva37pADTpHQN04AfSg1ERnvCupeQA9H/rcpcKudHm0d
	KM7gUg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f46860x1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:48:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e52306621so311845085a.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782805732; x=1783410532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0OvYj2FpZ08KKJOnjskaUMgl/M91qfEsZGOL3FKGXw=;
        b=EV5m5dmjJvyskzsNGvvuOqXqqNLT8s4NB1tzZGXplUQWphn9Nz6Y3cZu+wRLlUGSKA
         aQKua7ec5+h5Wq+z8LipuAUZsllcY/xa0iIpxiRqGxjryCiLNsHr4vga+5BidNBnvP5r
         zYHXGlCydQk/UH5AZHEk33tVXHdsyoNDj7qv//ArxheISElS56xKXxdlo2gYXNIj9RUY
         EAw4p3Qo0QlVW7cc983HP80ga1EAVU3wRFljrkZe9xZt6v5Z+oL90xaiZU4D8JgeemD1
         fbQbHq67nfZPeSE2NXjksifBGa6bxlzf15GEU9CJN3mhFhwjpW4KMB090ZRgRz6wsvDL
         JwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805732; x=1783410532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0OvYj2FpZ08KKJOnjskaUMgl/M91qfEsZGOL3FKGXw=;
        b=chsZKpOrM9oax4ALODjIgNCkxtbWQ0T4rn+ryX2WjuevFcRgnvSUGzIus/IewoO4sF
         J/Et/s7yZHTULwUbBBY2eR6mFoW4n7USOT/VB2uzAol4d2UgFL4AJK3/nnMIiJustUXf
         Nq9IS73KXUUeU5fRm+T+FPNrxc/P/S3bCSYiZdBxll+hyrk1B6NhIMoeXkr2wac8yYJm
         SZYdXMQ359l0vgXf+DzIIiSUyA+RS88nKr3vdb0buNYYX8cwNSUOGNCOjHfT9KZExLtX
         yIcwPaqU57TtBs1CzHA48qZHdaeUpebVyIp742JNCl2RShfzlvfjOS1WrvwVaEed1t5m
         aLYw==
X-Forwarded-Encrypted: i=1; AFNElJ/EB2JjcgfMLaMT7qQ1jMVmSsX5sFObk+Sn7RtwckUibyDmqnaoUrwaERTU9gpd4KnOoZX2U6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrF7dOUtcHz4KWKvnU41K97hjIgiQyHrJLxRfVib5+s0pRmZ1
	vGRJLdEBdVpAIUr/BILm6U/M63IjrLlANk4kwBT9YS+4WgdJv6NRKMgQ2+jHQCyKtYHLUrSD7wp
	l4yqA3j8YIl2NOAeNOPPLKzu+hvaeF3Q4+6xgtoWWm8I5OLyLGLqK4N/8Wi0=
X-Gm-Gg: AfdE7cnlyDW+V7phT3DzcCjOk/4f0M8WPS/EuFEy9i1HlWrxjWAA7c7oOZu7QFlQQPI
	/LN23xgi9rzje30gSgilSo5VYVMk8QvN+RFJdUrZx9ms9zmB9uosfbZGHG8iNcIcOqukjRNuioX
	/cziszyU0IpMWSnkFBY1Ezr4B7JZywIGWWOjMkyP4lUPu2MeGCjoB1LGhGLxwyZE43NMSzLmWln
	0BquJDOpfWOt5T31nnVWt5oTvwj56W701L2BI9qwi0jxDUaLfliDzYGIq66r6IekxOtOc2R5Q3M
	oPXMqx55ld1iYok3miQZcdjOv4KSTasPwEhcoURyt7ubP6qFSvbElToymqsaqhzgEWJbY22Cx54
	IUgo+BlSwMFXaWuR3Im1HMCyWy+GoQIcabii2ydQ=
X-Received: by 2002:a05:620a:40d0:b0:915:cda5:2803 with SMTP id af79cd13be357-92e627eba1emr490886585a.56.1782805732097;
        Tue, 30 Jun 2026 00:48:52 -0700 (PDT)
X-Received: by 2002:a05:620a:40d0:b0:915:cda5:2803 with SMTP id af79cd13be357-92e627eba1emr490884285a.56.1782805731685;
        Tue, 30 Jun 2026 00:48:51 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:a2d4:ac8b:bb21:2661])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c65f67sm53224605e9.3.2026.06.30.00.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:48:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Henning Schild <henning.schild@siemens.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Paul Louvel <paul.louvel@bootlin.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio-f7188x: Add support for NCT6126D version B
Date: Tue, 30 Jun 2026 09:48:47 +0200
Message-ID: <178280572474.5897.16083467528991834203.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629-gpio-f7188x-nct6126d-version-b-v1-1-a06226c02a2d@bootlin.com>
References: <20260629-gpio-f7188x-nct6126d-version-b-v1-1-a06226c02a2d@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hyIqVcMachrBE6-Yc9z279D0lQX-Rd48
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA2OCBTYWx0ZWRfXxeR1NT3+/dBH
 hQCRzBhUpVGtnmOSA97aF3r4aczfMyNqj/IqgexTezNDRto58bv1SrmS+wexHsGE0zg+4ErF/U7
 abQQZ249HCwAKRhq2dHd2UhHhp/VVg6/CjhfA47tBYvT8JeDsZ0P9Gp86S1SjIpB3tkUWUp/Nhn
 QprVv3a5zrf2KwzUMiiMZxaw+4OBhntMaSOlJ+wLfF5QiNApVU1NZOikhwmNRVGOAyj5QuKWObe
 cXDyk5CBc8riiyW7TkGVku67qN7fUdetOxGuYB45eSG1jD+RXo4O9TlyLK/E8pAHVE8W8+GT/kf
 PaL518mraWeF6A9Vkytjd2naO+CIMgSLdcIHy+1CDw+3b8PUTqk2YaXyZw1U/iUqK1G0a4jpLCC
 gq1pXPjr+xRvzoZx4M7hruJtAKU1aJcNjFNDs70S9VNYFPXo0nKmi5lv+tKTttFKG7KkZ2JcJnO
 i/i14ZvMB45qa5LIaGw==
X-Proofpoint-GUID: hyIqVcMachrBE6-Yc9z279D0lQX-Rd48
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a4374e4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pvbJ51eCTVabp2qf0xoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA2OCBTYWx0ZWRfX3jZP+6iwY/H4
 AgDjkFSLMm7TG9766iYUX4rJZvV7wD8/P+G8GpVA/2UfDY8V7hz4fdtoT0ACYYIzrnNK7s55wTw
 PgoWVLMtMZDxaIP31jWqErhnoFWA/VI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300068


On Mon, 29 Jun 2026 16:07:02 +0200, Paul Louvel wrote:
> The Nuvoton NCT6126D Super-I/O is available in two hardware revisions.
> According to the manufacturer datasheet revision 2.4, version A reports
> chip ID 0xD283, while version B reports chip ID 0xD284.
> 
> The driver currently only recognizes only the version A ID. Version B
> only contains hardware fixes unrelated to the GPIO functionality, so it
> can be supported by simply adding its chip ID without any other driver
> changes.
> 
> [...]

Applied, thanks!

[1/1] gpio-f7188x: Add support for NCT6126D version B
      https://git.kernel.org/brgl/c/9a6c0b6ea12746d50cf53d59a7e05fd83f974bda

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
