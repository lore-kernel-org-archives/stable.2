Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612582;
	b=u8AjsGnvcDY+aJoUXRYWL/S+VXMuVr862rom31/HkEGfer3ccYUVDtgrzDL3JbDJ1JFW
	 p1/DG6HLWmHeRMWk8Nq0qPNPV31oWm3JnQZznEQWds7MRg/qxNYJ33wSI70iCdTk+zwLO
	 Ldv5VotEX/JwhhckMIcnQsI7MxF+tcqzYhZrFfEVBgQxIL9ay4WgPq/caGxiav4QtKKZ8
	 fsrAgRWuy8KhyUdfKdYgpGyCMnOFVWOAF8+/bk2A2H6sfVDYfKocRMWrQ9KtLJuP+mmJs
	 SSOP8IDsFFSZU1x7l4hqTfgNf58GAObJHqEFNW23wG3+bbc9Q7h8OkvtqTRzUhOzB8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612582;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=89EGtrCdAoR6l+ecweYzP++OTOh+V/yp5mFZY6u3Czk=;
	b=ErbmxN/21TeuEMU2+k0ToQ3c8wVHwsWQoi9XPP833gj4AEXiZ7gUv+MWjxtT7/Ivy83z
	 G/kew+/fdBbhevKfe/bboJ1ErgMkAqoBelvgQxmWZv4hQhs84unxzAFWdAD3UjFRj93I9
	 897dkjaZT9ESTo72CAE6Z/ihXq9wfgwCgvKr9Rwa2YTtV851LJh5m9xJclX65qw6TYgVN
	 mOwlOg4a6Zm0xUKYMkjV/t0DbIeG+WBSKsNn+vhFskPyztV1MDxTV3Jun7/tUfhw8VCba
	 DYH+WgI2c3hzVEXz3K67xOJ8Ev7RlhQF6bc+raIznlj0LhRTZlH9KJ5FR5Pn7mJHw8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="l1G/73LQ";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="ivhqNUJ/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039B606A32E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6039B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l1G/73LQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ivhqNUJ/
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AQrd3440395
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 09:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89EGtrCdAoR6l+ecweYzP++OTOh+V/yp5mFZY6u3Czk=; b=l1G/73LQcGRmSUnO
	U8g2uH4q/i/X6dJsZbxfny/nj5qSQ7E5d/Hb41csjkojGkyMIVad2hgXswZ5yqsR
	ry3Wztcvc6Gsh/GGbYLHEBbSvqXnGK0h1WCcU7I1J9GLGveAU/JzzlPfAUGwLz7G
	e+x8nrKuvCXkxxy7FlaKZ4BotliNu/3/+spekyaH2GozaGUHsQOonXozu6Rn03V8
	Znnhgh7vDEeYpnL8+RoIZjLdyaQXEiwwiML8RC5wcj4ccfiunp6wl9S8+cwNTDjT
	rldgk/A7tuGiobm5D+SUeYaiPvgoJRoYzFD7YHwkZoJmvoQj/MHgtX1uYA6Lr7Ao
	Lshe7Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg201qah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:43:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso538099485a.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793612581; x=1794217381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89EGtrCdAoR6l+ecweYzP++OTOh+V/yp5mFZY6u3Czk=;
        b=ivhqNUJ/mSGC8BIFDiZz4qkI+K7xTVyqF+eNVifs4bHVcrRoB8hfUIwy5xuklzKD26
         Kx69d9mG8oyIdwNJPTBr5TjOVzlzgIJCUhC+uSnAXznpqQYWeIcXxdVJTrRWjFmOOsdc
         RHGQc6yd4jQ1jm9dC5v9xKh/XyGzzw6eRCoBPU1hkjCKQKDOF/FVFvk8Fd/AB1md9a7C
         QpGuOH19YwwwogeQsMPHDbJbYkbcN0m+EPT+7s/huqa6JimPe/0bpg9NCKUI+G+y4vyn
         uWGp0kSzeaPCqZPI1y/vGEks3bwaixYMpuW4byHhd0H6DUg4b5kEF4SYSELDmUEoRwy5
         BTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612581; x=1794217381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89EGtrCdAoR6l+ecweYzP++OTOh+V/yp5mFZY6u3Czk=;
        b=JF0FxV+QJvM6tOMXTYga8cTc/CWE4bqE0GQZgD33oMQM0fybgmGCGVDilThcjS5JXI
         cNWM+t9z2I4rtd3pZxU3jWLqHZFIsEg9rtiS2DDOm5sRsIwX3jvnFH3RDfx15Uqqhq3p
         XJcfS2L8JmxoFMOVSW1HyZ1aCD+9u9/rJBnJJygyV8wbVD2WbktN4Wde8lnP3QR8tjul
         DRenpDOtpHiaQbBt0HcuFz7y8hHLGw+X5uxVuBzpqAZq4amum8aadmfT8ptrrWwReRl9
         7DpRRpHZ47yWXUqI2Z+zb11DgqRHKBnCeCVztYb6GZEytPHvk/ZAddL4Ea/NUZnKAkMe
         lM5g==
X-Forwarded-Encrypted: i=1; AKwUvBzJVr43XXDNgkQMPqP3n9bDv1V49rHOLFWb/bQ7Dl9uCdO6my4RVFqBtUOooS0JfVVc56XUEQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcuzAk2FreecEkm1/3VedH4Gag8vprx0r9ZtJgGJiHLGsesEI4
	WzWVzX1aVvqToGjda8U1/Mmt07kEnuiDzF25dKrC1Bfzi3nmxFEZslvVRxdeYN06ArY+nC/V0qU
	kngRWAhCEwnCF6RM09ySNJ3qERdyJ1YV9z90iAkv55VYfMkXditgj1hzBdb4=
X-Gm-Gg: AYBFou1bWTdopWp4qKuIktiZhE1TFNc1AG4o1RXvKGI+6TyB1WzD6fRfmkVsIZv26YG
	1J40pypm2FvIiMsDQLxg1mWkBjcMvEeu4Dmg/hXhJxnGIY0t9CluJxeZNRzVnBYs22wPNHLUt7j
	Fc/wj0P+s3MsSigPuUTFz3roDjMeKDauVNgqLK6NXNxMQPNmQsgnQqr9hIwJhvxmmel6dbJnfGr
	Pi86+pPs3VJT+zUIsSmzHy7rYJzB5YR0FDJgKSpcf6wfwFYIGjjUAqNyHxN0I/D+ubIFQ8QTvIs
	Gl/Nmv8qxIPLS3Dbm8wFcSdi68T8MEzbh00Cktv1ZyNTPnrrjWbHfaq19NRbBAQSed4DBYOLTH+
	9UQBra73T7nzIZJAHS46JJ25wObj2lFQhfdenBoNZemA2hRMJuiN61L16F5DajGvTVcDLvfVYxi
	wB
X-Received: by 2002:a05:620a:2627:b0:93c:c7c6:90b5 with SMTP id af79cd13be357-944214cb3b8mr1490954485a.9.1793612580591;
        Mon, 02 Nov 2026 01:43:00 -0800 (PST)
X-Received: by 2002:a05:620a:2627:b0:93c:c7c6:90b5 with SMTP id af79cd13be357-944214cb3b8mr1490952285a.9.1793612580149;
        Mon, 02 Nov 2026 01:43:00 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b725b8sm19124292f8f.20.2026.11.02.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:42:59 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: sa1100: defer GPIO chip registration to postcore_initcall
Date: Mon,  2 Nov 2026 10:42:57 +0100
Message-ID: <179361257407.49840.3441048970024202305.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029-sa1100-swnode-fix-v1-1-112f4d83d191@gmail.com>
References: <20261029-sa1100-swnode-fix-v1-1-112f4d83d191@gmail.com>
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
X-Proofpoint-GUID: Zuzi_6nviSVyXb2QLJkd7WXj45abyUmJ
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae85b25 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c9_QNTXIi0YaEdUqp3IA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Zuzi_6nviSVyXb2QLJkd7WXj45abyUmJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX+yQra3O8APvg
 eXTiM2bJS8Ld4Pb4DVjwTAXf1ABVqJH4dV8xm0uRyPAl0PYwEj+AyKQ5nya5WzDTUa2HNQ9oNLw
 Be9CrcdzQiTtXKdBSkHObHyjgnOG5Ji4JWnO5q4f91EAMv5J2BRZnVTmDvb9ARvmMOCz2su22fx
 CgtfXpVWGgBcBY/cf/WIh42L9oJSi0u50lziUMHVBff+yHaXFwq1j8gSpjgErTBWwzuOcRl45uu
 tImhgmZmHd/RK0Dp6xhZ6rwdr5Y5u+Pyy1H0dnNnSyua3vhl5H7kzLxO0KGaDX2pgSKR1XtfAvX
 0M7cqIyUaaBDywAQ3SZPoZ+rLoDZI9RWHkHsLywrD+NPrUrgXyEoy1pkNf+Z5J2bjHJlZcVJGlU
 T+jdr0vshZk0bJHV5om91mkzS2A2EMuDmOa7CU4a5tApaAaKAF5bMKJ4CV/75dmO7Qx3gg2lQ2w
 /zPefkJ4N1aLRMXuiVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXyhBZRuE6pUb9
 rJDyYDHsst1KXnCDKRx92CRaTIwx35Ah0fb7HoTMPLzaoXQEvG8eYW7T4PSHiZJK0qq7vTdlbLk
 YVJHKQirPc53dmfHtYjQzG0jbZf9lvY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020038


On Thu, 29 Oct 2026 11:58:15 -0700, Dmitry Torokhov wrote:
> Registering the software node and the GPIO chip for the SA-1100 GPIO
> controller during early IRQ initialization causes boot hangs on
> SA-1100 platforms because the software node subsystem has not yet
> been initialized. At that early boot stage, attempting to register
> software nodes dereferences a NULL kset pointer before console or
> driver model initialization.
> 
> [...]

Applied, thanks!

[1/1] gpio: sa1100: defer GPIO chip registration to postcore_initcall
      https://git.kernel.org/brgl/c/32c89e32b3fef2ee0aa5c4d0b0fb089bb20b3223

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
