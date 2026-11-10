Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302409;
	b=5YlRtXD7ck1ovmRN+Dm/JIVNTJL1NiKGqRdKHAo5OH4X4yVufDOytRfj0zW+cxbxHtse
	 s0PjV/zr9dEYpUR3zRKnCD1D7ZROlIgEsVJP4sh5g08h2HF3uA5pZj8Iezzvy3b+Fhtb8
	 4FhNl5KcpUR2j9YVjBDY57TBJDUustyjraDDDJqxX+X5c2ocYOyZQjS8RmAxrZMcbVgVd
	 fQSmQpPllm5C5p8y1t8SHzy1xlEGcdg4hf5TWE/gOTVeazUua7GFqOrTTI7v66nZ5+KSy
	 Erh5DALHwo2K/+0hHVT4fJwlTIDh5vQvlz07SiIDTrt8NmBbvrJwSd5kfB/H/2DeP3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302409;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=U0rF/YGsgU73kTjU8DxG6mhapC8dZnPAgQMhAUjM1sY=;
	b=yCZ+GDbwXq9IxciPuNcfPorMJsnKV13KE8MVxDGrvaBFt0cBCyIQfiV3nIBHATZjytni
	 +HfKJQE/MYtfWwyoKCD6FTu6gKQWis9WK4na5cfOjfMEQeNtZdBLnNHI+JXDQmhV3y3IN
	 9ePsNxtZTeE6RM2k3JReY9CrCJJdKz/GlSLd9XVf67mTMjONUj+iC40pmRk/mwIa5LmL4
	 bEgrNSBFHBVn4owzH/74YPQ3pIQEqCsN4EvqwpGBL3G10acXowSEniHxsH4mtz7uPsnRu
	 /JSUkFbNguJ13v31VXB1GBh77+B0DFeaijRelLcPYkM70O18KZ+45L8cncVQ0Wy+hJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dFivqpVf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TNTLlnuo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB6606C65F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADB6606C65F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dFivqpVf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TNTLlnuo
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l2fo1681021
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U0rF/YGsgU73kTjU8DxG6mhapC8dZnPAgQMhAUjM1sY=; b=dFivqpVf/nwF9r33
	JheznplMIhov4kqAzKCUHPewlN98uV+AJ26XJXZjH4WkeuAygv7cEpS5y4i67Gdk
	S+rRkSI7+px6qDQUfsq5AVwLGI5VvExErqUdKqd5j5a6Ms8tepxcwd5PNx9Ja4cZ
	Rsow1S9msWQq8fQMmtHzM03GANgclhDrK6qARpKixDYIs6uW4PtgvgIJhOgLCvX0
	sU+speKRrNwMMVp1qAK9jcL08rm3EtQrK5/UybN/Dk4i7OuGn9cvWMVjJ4inoHtj
	P1BUvuI6sDo31ffKUFnEgIuHiA7I6r1mhNIunyvtIL58eoveEGcjx3zCNubpJkoa
	dxyghA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkjh1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:20:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf7856ffso413692485a.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794302407; x=1794907207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U0rF/YGsgU73kTjU8DxG6mhapC8dZnPAgQMhAUjM1sY=;
        b=TNTLlnuo39/cRhCnr0X/J/bsYwdKq9vGzq2xuUHwzKtpJa1pre3/+ZIzxpAhzDAnPK
         IxQ/KCTq9eBwQGqvmoRGNqApeGT414oL0CXl0YH8cH3g2Ilr827JTytc1y4eHTqvVHtO
         AT5cCSQv0v01CtwYCR5KfTPblhbH2kDDUxVuoy4985SloQvV9T9UviYJ42HkuzKzZUzN
         e4YTvjNxnXVHguG5Unlwbza0Qf+c8Enq5MNMygAwK42SqH3Bj8oApAkVBSWHA95YBRy5
         bATvyLpcJUCnC/Tjo2REgAdb80bsUL1QcKalLravl1nKTL3h3o/A6rP42CjjacfrZy+s
         01eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302407; x=1794907207;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0rF/YGsgU73kTjU8DxG6mhapC8dZnPAgQMhAUjM1sY=;
        b=E2ANGyHcttDMzrfV+ZqgYxiCzMvhRICU3iJpYAxgsqkaujMIVCy2Lk7xl+gKT/V41b
         /xh1C2gV9dWe1AORtXh83tVny3ENdj0ZYV3AG18HPTaDq7Z39vn4zGP+nKgH0cU+y24i
         Zt2c5uJki+cceYi9ESeMnue+06zARe7bNiVvBGxs4Kg1wJ6DhL7tOSHD0YpUx5zIbq5R
         j5QOwqOEn9JtTkesZtrcENCRg2CeE+X45NFloJz1RunTWj9p2LlaTNWkgPhPG2twAs8F
         eQcOU/Sx8HszmPUpu87inWxtq1UlINjtq1R5Bv/U2sD6t49vH2YXHLNCanOofCj/B9TB
         Y0Sw==
X-Forwarded-Encrypted: i=1; AL+hErGVWE7J9tp9Oe7Qal9vzI7+yCk0Pq3dPKWGijZrtuvj4YBihLW6EoklplPW1BqEn+SaXED9WzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xfBdusGsIcwEDYM2vcNwgqGxaEf9cSRJvaw/wJY+4HRCVwOoK
	cCaBc2rOkT5oBmf1fI1pY4go5t4Kbk/wDLMQI3MmekSoUxA9/63s1T1cqldPY2SJjy23r/6mG29
	G9GuOjPE0Hu/F5NtiA5YwKst03jerIzxohsrqHu9No60RGyEcSN++GEqmjhc=
X-Gm-Gg: AYBFou3LgWbGT5saAgJDwwAza8iXLnYVvbCYtOaW827wScsIXueqTBKdJhZ5zgX9nm5
	mlsD2U1ZVueNUdBFr43TNyoA+ZNXtHBotricLj+k6fKADKSJCkGc9N8FcFz59jOEFxnEuH098lZ
	N3NOhtjqpfP1BJ9JYONW5uVWfv/90XFTX/1tEZMF7kdhZRZMWlkYuQKBJOdiuqytrK+MjvdR3Gl
	LprktIA90nEsWHEeNNVZj2m4DcQE3OB8qku/KCFxjutjOj9ib63vRSahMvoSQYOn0lhzzqBusjH
	T4JCu/oRPscChPFbAEL8TqwNOa062ogjf9o/yOBZPH4YlRkozPzbYjt0Z/QmdPUDKeRkBKrwqkj
	v+q0Ux9+g2lAWi2nf2Cu9Jh0ey76g/bquQI4n9J8uUk6P1xUXKDFUXHaPGLByKXl4UFXqFr8/pW
	xD4kfwnFxAwe9ifqPwWfiJHQgbZ/Go2AwmX+/DY4qLL27jbXGOJ9Gj0cKTbRfvQQ==
X-Received: by 2002:a05:620a:2988:b0:93e:bcbf:88 with SMTP id af79cd13be357-9479f1cce74mr339173785a.4.1794302406668;
        Tue, 10 Nov 2026 01:20:06 -0800 (PST)
X-Received: by 2002:a05:620a:2988:b0:93e:bcbf:88 with SMTP id af79cd13be357-9479f1cce74mr339170585a.4.1794302406191;
        Tue, 10 Nov 2026 01:20:06 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba35csm47266795e9.1.2026.11.10.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:20:05 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rosen Penev <rosenp@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
Date: Tue, 10 Nov 2026 10:20:03 +0100
Message-ID: <179430240150.6721.16840326534172400556.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109-gpio-mvebu-sleeping-while-atomic-v2-1-41f070421e70@oss.qualcomm.com>
References: <20261109-gpio-mvebu-sleeping-while-atomic-v2-1-41f070421e70@oss.qualcomm.com>
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
X-Proofpoint-GUID: 0e8oDnu-c5Q3tAdBMuvdzpYutYvSg5Zz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX0W7rM4KtdKjb
 yU3TTUMA5saIwMiPdKSZS0hgypQ3krwdBAlnT7UbfMO1MLaKGEncyr+M9kJn3Xj/p/RSWTmucg5
 nqwWRGDScQBVPeeJ80BWkffXjC9pN6c=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af2e1c7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=v8OVC4ajcfB9Cz4e_FwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 0e8oDnu-c5Q3tAdBMuvdzpYutYvSg5Zz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXx8SAGEghkbkm
 TvVsM0Ioq+yKAbnKySn8+ga53+OwkVGm/BQRgKGTQE9SBOp0cxAT3N9x2pKEWc9Tcw1/eDnrV8j
 1lVI3tiGncd5dPTLAUSd5nV9Ge5eXlp64mRPyg4Z8FkbOF4GexvOziBV1YQbvjGmdgk/y4cjSXR
 Bm6jx7X9KiBOUDJ7V7vWZjgG9XRkoi42cUanGc9QLHEKGphCLSe1g1taFo+vJZx6idh/ehNVa2a
 eOm46BKqrMSbALOm8rGbOaSHoyi3TixUwvrSne3p/OWqNg03/O0c3vwpy4w1CV8USDVjy5GygRo
 a4fUwDKcwNnxdXIe8P333lQ27lXezOpOFKBr1kAKcoePTN2ObVCO8OROGwqQ3v7RFafDmPZcZr6
 fOGJ8ZmyD9+OUoqrKJT8224gdJzkfsPzyMg3WNuKWCs2hoBmxeaM5bXpr1EyIhZuKW9kk9OQ/18
 ybPhXCwVmy2Hc+bQjUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037


On Mon, 09 Nov 2026 11:34:36 +0100, Bartosz Golaszewski wrote:
> mvebu_gpio_write_level_mask() is called with a raw spinlock taken but
> the underlying regmap uses a standard spinlock which can sleep on
> RT_PREEMPT kernels. Add the .use_raw_spinlock attribute to the
> appropriate regmap config.
> 
> 

Applied, thanks!

[1/1] gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()
      https://git.kernel.org/brgl/c/42269cdb3d3b46ba6e80f31d0e00d0bdcff1d8d4

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
