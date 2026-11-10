Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302434;
	b=OK4vAZ7C9dgaRXY12y1FJc5F3gofKds/nNSVK/qDHPFzYGAsVmgRI5dk6kCqZqeUVuVi
	 37byMAw0Eu5ZPUciTFv8DT1ewZYoJPtlxc+3O9Z1QQQ3PeOqiRpEUjn3DGmUDnl1E7Fwr
	 xRBIPnD1qM/lNZow5nMUAFK5F8qpNTgepJljbSwVki32oDqkyEFXGceq/0VYAlDHks4jq
	 wXosSf8c66DRUGyx5N81TDbAn84tE4CV0tdl6/OtIAKtfv02zYtpBmPDxiMWgzEB0ADSV
	 jFXLU2AYuUTJTb0y6hFEEDGKGOMvB/KpprTRpBByIuhGQHj3SW4bkx50Yh2Di4OyUEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302434;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gZQw57RehtWmejjEg4uC9nGAwlmTjZh7csJ2dxc7a6o=;
	b=cBo2Hv4aY0DuyJbPPO7/eVjTuk07CORSGUS9eeAK+Sb1BoDybEx9fT7RL0nUi1na8HM9
	 q3Z25RZ8Al/VMwvKphj/7tun4eE9/5halduJLtQMANZbrXhoMJ4zv6aFXI5Pw7IapGlJt
	 3oOvFY7AKNHzaEh9AbXkIvCROZU9iXU6r3WScTbpJjEZgc7NqC3nBEjjJKeCHnsu+owYX
	 SAn5CmePIZcjN2sUcQCFwSMTAtqvBUWefDeKJUlQrkUNxzd8/Cas+bEep0sBhC9oPDZ5U
	 u2SEd+lBPeTHiVrIb9wlZdO5t45MJObNgaYO0whuLPnXzRKPxzod6PU1BUePfIBS5aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WKaZIXrJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="XFQC/C5y";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE5607D59E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71DE5607D59E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WKaZIXrJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XFQC/C5y
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7lBEw3392478
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gZQw57RehtWmejjEg4uC9nGAwlmTjZh7csJ2dxc7a6o=; b=WKaZIXrJWWr+SioL
	g+HhtruzxhNcwbnvhTfd49Bs+V/aknUU6SQSPT1ZAmpwMDK0GAIM/yV081f7OP6e
	/WyJct3aQt5rOFe+gWGQ8go4RahDElA3LRl+tNXkbXa6vuWEVjYMy5o8SeucWi+d
	GdwbecxgZxIUM8CpcrEkfEXdKpFFDLLvnxZyqJDgLDw1cR1lE2e15AN7kIuQba+y
	9/D3J31G2xIl8vv7DdHY6VgM1fjFDOhtpjEtO1hsPm5RE6pLDfJRI0ONMWBS7ypw
	U7ajerg9PyrByOvwCPvzDUO2OqqYx+8kc/JY95oFBJfwI8NrCqPIMv96n4Dek6iV
	7XbKew==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg2s9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:20:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf6c528aso327095185a.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794302433; x=1794907233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gZQw57RehtWmejjEg4uC9nGAwlmTjZh7csJ2dxc7a6o=;
        b=XFQC/C5ykZreMMovwQYN/dzO7bpOI0wif6JrucGKYajzlaaINUqx3IoWWUklZ+TrZh
         PoE0WnVhoU0M3ygRVTyW2JxsA84dAY7mXnZmamhhxLLsV8+KD926gKN3XfZ9Jm7QuCeI
         t3sYOKOTI+DhTS+2FmeNfv07s3GKu17cDjuF9nknfcpX5c3tvl8vqlCFitmLUm/gMAl8
         nJg1wCgcAOQ/wZIa1rZ685b9Q9ZUgAzsoxVt39wZ84jbDr/ZXX4cuFiJuS/B4UpkzhY8
         RNrACpMbSZrC+ORUUpOJ6jBUZ03jejQdIzHTAuIHhhG9p2SWkiiqY0XV8lLwxDyGnItb
         oVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302433; x=1794907233;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZQw57RehtWmejjEg4uC9nGAwlmTjZh7csJ2dxc7a6o=;
        b=vsyY6s8jrwv7kP40OpEN787nCYfW5YGwn0KEkfbofnBlFTTTUsH9LlvpgW3wn4I47v
         zqs0r99aPkyPyCyqgzJD5ZvU48WjRy1EQyTbusNwVM/cSRlhrlV2JsXJwzzwY3mp3sXe
         9Pzm5AXAMOPqW3jCmcGVhlztXmNEwIjknWOY6aCU4IZX/lb17iRWeFLZ8k14WaiYA5ie
         0rxVB2CNDE+e3syKXfcRYzFr1aHlG1eEWS/9QaUBqfEzI3kMb8djJptpgzHf2lzM50AL
         xhq2DkNbPgj1bXdGFqXuzb9TVKvzVFuXbN7Eiai4EZQW0uCuDv9Z252K34OarLysteKL
         NLHg==
X-Forwarded-Encrypted: i=1; AL+hErEGGUx+Q0t7KnmNTSuH9Wi2qw9ZDMpxYYos+xZA66Vz/o2BF5vxvaxYCj+bhqeItHKRGHDs8R4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W09VM6CoyE/CdbKSZLWXwRaFJy8x6Gx9sPMxQZJjzcX9ivgBU
	RRmP1r6E3HaiR1zfoXQuc2nbaimXukvprRuifc3VWM/WHq+860qn1yY2PHA9cm2xCl41w8/LMsI
	brBsfGGaebqH07NBY05wLD0f+B1ipaGBkRUWX2fj4LLqOBG27z3jgYLZFYR8=
X-Gm-Gg: AYBFou2LIp8O5OxFLL7N009+W+FBuaf+OEEToAJX7A/XWwK5VFej15V0SZdQEkh0mSJ
	zlSRBptIbZ1sw1YyMgH38OU5Zpev8n4okiI24xtZJHQogK3HJCgU054waEtDMxXQH4Qx8EdvmjG
	b7nSpPrgDV/DLRXUwZDlgo7fJf7yOhMNzYx055BoRy57V31QktN4ANGxoSphOfoslYrutKiphMF
	pCDtUsAwUhbXnyDBLeq7US01+slZenPhO4Lm2A3OgbCjwL7pZHE8hwHSC4g4aMxg07Rj1++LTO6
	W6RKUD4rtvlR5s+HAKvecPsr/htAnxf4L7vkmQLWKoP+UlAMeczFtGfcGpIHQfpH8lBIH6/HJP7
	nUrx0nSQdDzwqffm1FvOINY/4/qNnYLdFbyfyoPAezVIYLwsK7dv4JekTITz1W3iMnPF4L7HwkS
	VeYqKtdZsjsnJlD1lo4Jl2letF3n2ttI+3tMCbGcLV9b2jiZaps0C5y0UVhmN9RQ==
X-Received: by 2002:a05:620a:199a:b0:93f:265a:c609 with SMTP id af79cd13be357-9479f40bf87mr313748585a.69.1794302432752;
        Tue, 10 Nov 2026 01:20:32 -0800 (PST)
X-Received: by 2002:a05:620a:199a:b0:93f:265a:c609 with SMTP id af79cd13be357-9479f40bf87mr313746185a.69.1794302432401;
        Tue, 10 Nov 2026 01:20:32 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm55209975e9.5.2026.11.10.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:20:31 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: virtuser: fix interrupt leak and UAF
Date: Tue, 10 Nov 2026 10:20:29 +0100
Message-ID: <179430242703.6893.16466062017492438837.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106-gpio-virtuser-irq-uaf-leak-v1-1-ce9772d8ad0d@oss.qualcomm.com>
References: <20261106-gpio-virtuser-irq-uaf-leak-v1-1-ce9772d8ad0d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX7U9zS3hL4R2J
 UWnOCLni07BIW+pC+Q1Z1rkgGoCLnbDaXPfw2i/NbqYgkbd/2sP1ehPgwAybfNWh2jEBKEfpSTf
 PI2GoU61G8veRcYuvdWyFA5UK2vflEzkyn14qf1xokrd5euto5HozlI0GfgzNgseh8oht20SagQ
 yEfiif7LBj9PW0scvGBNxB7bQ1V9nbZj6vgwiZ9XpoxmdYpHtjfTXEwICVsBIj2DLxn9IbUZvnr
 v+qk3ad+RGzEw7x0n7fG6dHh92R6Ep19h0MRU01lZtXWFNqutyq36ISR6hjuCoCeQ1yrNeR31TG
 G+ARABgGRMef0eDTPBjvcMyoRnQVVwZKRRVFcSoTB9dScvARKoOLRq6THaHOJ0Gn3yr92PaWbZP
 mfbT86IfJVgiz+EOaHZ1LwRs8wplpU1zbpDvIVv/YhzWQRkadULvZ+nEv3/XOfi4EsOLacJ/1me
 kKLY1TALADHVCoNvplw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX00ti+l3Ib5Eb
 wVQcw45vh9rQ0uIAHc7GPurNQk5iS3MShXqpUy57lNgs04mGP8jrViwmYcPV/raI23ZNBs0vVmg
 7ZdmBQWP4JHposwTDb217mxcmYLz5Ws=
X-Proofpoint-GUID: oOLFscetbijWn9VY7byGvJDSTtlEksTa
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2e1e1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-0yr5wKWe5apWyn0pTYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: oOLFscetbijWn9VY7byGvJDSTtlEksTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100037


On Fri, 06 Nov 2026 16:33:45 +0100, Bartosz Golaszewski wrote:
> When configuring interrupt handlers for GPIOs requested by virtual
> users, we never verify if an interrupt has been previously requested and
> just leak it if it was.
> 
> We also never free the interrupts at device unbind. This is both a leak
> and a potential UAF bug.
> 
> [...]

Applied, thanks!

[1/1] gpio: virtuser: fix interrupt leak and UAF
      https://git.kernel.org/brgl/c/24cafd9580627f9f066296f4a6ce1b282a3f425d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
