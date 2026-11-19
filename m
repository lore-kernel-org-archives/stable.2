Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084431;
	b=puo4xtTuJWIt6dbS6kmCmFm6ol4IHCmB+4yNAJNLs66Pio/ci1ImZVhvNpJWuDGPNPwe
	 MJDwVLJsvD7qLuJD6OWVfGFsFqcuOdzMU9MBfyk3Ci2uyzSbE1VBo6JuGET7Sp1ojKlsc
	 BA3exAQossDSIISXlSMvPVWA9PFjFtEDel3bgF0Qc7Dvh20ZsI9E+NqNxN1y6IdlIstCC
	 /Llwa8HdYfOq7X+pplpy39NpTlLnZhD53GHgBrh03x3lBDLvG9Rvubqq4ljlXAa+zXZHR
	 8AlgqnBop3jriRNCSL76W3R8zdg59kA0YxWi/vXRc+dwQ5a0QWYWVEL8fGVLnSkiY6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084431;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uxj9G2DBZGFLAUE461TexgAskHHLjFFTuDuVsBzMPys=;
	b=CNSFdjY3FFmfz9HVo9ugRDdsI1DZ1xu2HBjU1bBTxnvqDAmq2IUKhl4cctmRn/vg3QL3
	 njinUChsKm9od5Vb64xNYgdS34vKKc0x4I8ZDbeXxRia+f1mMQDGMnYyTe3SnMP/YaVHx
	 Q/GL0/OJCPcV2+R9/QEj4/jIM9fNAXn1IbhIEToAITarx0YZx3Y2dCbRPzdNIWt4EFCaT
	 2lwEy95nz8NBKEgu2zCeCAXh9964c5gQlQv1vt+PnFe6uk+qzU/tDivGe10a7jdwo5pXV
	 CH7M0TLHrzif0+/Ygy1H/U3cImONwewQVJxKogAlB1PV9QevY4BISo47fK7FCl0GDMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLuR3he1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MRT0f1t1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD21606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD21606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLuR3he1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MRT0f1t1
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9uM4k3077205
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uxj9G2DBZGFLAUE461TexgAskHHLjFFTuDuVsBzMPys=; b=TLuR3he1ZZ3ZjY5V
	FM4KRNbjaZnRyvGc0UQLSAu8I18Miye/m4MVs5zDYG1tHqnV9tdwcSCt5zBEJgFp
	BvXsh3NNFCmtXegKLa6ZwXJnXeX7rF0SXbfxlKcpsSecyQZKt+UVmf1JuwPtmkUZ
	lt35uOB69mpEk3RLy191ZIu0MmLt1n3VAaTYeAfzTOfQ6j0PE5IH3xC1PFfa3d8v
	KUcLzybiubGderaM9+TvudKpedcIdzB+1mb6Db1GxLdZ5rPxv2weRw6MNdnPhEFz
	JaIFu8qDeQJhBFBpRo8611YhGTViLOBpjQ70QrhrBbPzIsm6O6k+0efWdP2/+H2Q
	zcnBiQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx18528-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:33:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-55cc3c32e15so23455771cf.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795084429; x=1795689229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uxj9G2DBZGFLAUE461TexgAskHHLjFFTuDuVsBzMPys=;
        b=MRT0f1t1DZppPM5NtRI+sKNYABDZJA5A6qbwTtA4wXMuCayy6ns10YcqDR1lBOb1b0
         dkNLZndJau31GwoYnsnh/sF8lmd90Bp52n/mT3qKpfdJK3JXf2x0pX1FnpPa27EFbnKI
         mFMmy9awh1wfI+K1EEnqkP956FtiFrJS3I2VAk2xN2vyXosmDvzbIKKbcxZrnmX3fK01
         xIY6x+ZI3VyA13M+808ZNdfB5eabeL8oH5uwCzGZak+cT1AoRNI4zRI/76Enyyonqlhe
         YY1ijrZCU1t0d9vugoGbgCWC4KGIJLEOTUfqlisP82LpxMQbwn7pKB1M313UBFnmzRSI
         KfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084429; x=1795689229;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uxj9G2DBZGFLAUE461TexgAskHHLjFFTuDuVsBzMPys=;
        b=kKTLc4+MNQgW3xQQvVEybvyHNB+LneLFeADhGkWXFurYciryOcFm9NYuqndf+Sn1aj
         I7pKkkPrUbHtlMnC8H3ZRdzlO2c63SnGbFdiQxFqpAM8v616kQv5N6Jo6rYCSSicF2G5
         M3pU7Xm1IT3rEoE26zFZdESnra/866cXYxdGl+apqR9xvxOT+QsLoyTPXaMi66KAq288
         GxWMfMIwBnOjWQIAhHJgCV2r54JAtFLzYDT5YQm+IStqVmMI3WQAgAuQggMqJiu4spho
         FNT7jmLRHrkk/ZWP3Nc6pWZpf7fj9145+3V1RpKPFe/6p7NO1eEJPh+xyctsPB9duwd3
         bgsw==
X-Forwarded-Encrypted: i=1; AL+hErFwQhxpWvk5HvLhk/zeEmqzs9rbCRtSbSMcl2ECQSRMwKlM3R1y+VNW2pomWbogg4lQ6yDT1x8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VQtaigWw7vH7Md8XzaZtlVvnud0IdlMpnl4J6OxM1wGq/RR+x
	XQUGo03fWEzuVkc91ui0C/vX6F+EdxLgjpxoY7D2/NIAAAwCezDuaMvOmSGG1Y2TP/KmiFAjyO9
	axMoVajefXfhl36kim/gdW5o6UxMlTdOujrA4kun9L+etXYwasgpPyTWz65NroZOZJkQ=
X-Gm-Gg: AYBFou2U2sO7a4fpO5hkolzOsWumW2sfq7E56JfZt4EiwHdtA+ie0yCMRacrOSWIKbb
	livAK9yi9OY8+NP2sOYoXIdA+ruLjScqFE5uYt966dlBR5/GPwzEFyYIikPivpJVd0HmTyiVun8
	4nWbmhW/5xQKiRl6D4+mNji1FDZHDoV37F483JZKiBSpLhPv7Aq5mNR37NtM4kKIpPdbXr6DEsz
	aZJQZ5cdH6jOKc4NERn5KLoYxVG4CWRwYgOtTuWdz6d2GpoB4a528yIM21+4yDUM6YmJSounspn
	wVnhvG9gbehNOCigoPV5ga1AibZPGyVYHdmXgiqLLVxQ+U9rLuHwWMH3wGe7uAuGy6PGJJWrMBY
	PDr8WgnEChnDyPpX2hCUn++KmSoQFVSxHZbRkd0iqkSSou2W23BNwCL6QZPmwCqF+dO51Rk85P3
	E=
X-Received: by 2002:a05:622a:17c8:b0:536:622d:6932 with SMTP id d75a77b69052e-55d5a58f8e9mr86938741cf.23.1795084428620;
        Thu, 19 Nov 2026 02:33:48 -0800 (PST)
X-Received: by 2002:a05:622a:17c8:b0:536:622d:6932 with SMTP id d75a77b69052e-55d5a58f8e9mr86938591cf.23.1795084428199;
        Thu, 19 Nov 2026 02:33:48 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm31004775e9.6.2026.11.19.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:33:47 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Hyunjung Ko <hj351016@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Mary Strodl <mstrodl@csh.rit.edu>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: mpsse: reject bulk-in endpoints smaller than 3 bytes
Date: Thu, 19 Nov 2026 11:33:45 +0100
Message-ID: <179508442284.48856.17227214993153041326.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117104110.240112-1-hj351016@gmail.com>
References: <20261117104110.240112-1-hj351016@gmail.com>
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
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6afed08d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eCiaqhuiOIoeic38RQAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: gcJMrmymhum9z6slvT87eOVD4u0zaKOc
X-Proofpoint-GUID: gcJMrmymhum9z6slvT87eOVD4u0zaKOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX5rAcQtCcU1fJ
 dTWz2hnJD9UCMdD/7nHGPsvSret6ngR0TzCdfLBOzDgPVsZzUt0YG776AXDrWhAZlDDAiSWwa7z
 1rytJ030BUMeWQ24UE3PPuJ5AaXSB2BuD+UdWYxtIqCUHjpvD4pag2uwZ/sIXp3rgiZ/U7FFd2g
 yH+fZF5ct+y115kuna2AZGmdN24PbQtTWDBZRQbl819BzzfdJfY+znYRfE+Tx7RvpZG4H11uMid
 1Ek9bxN0us4IVsI3jwwmUSwnIMtigiVa0E2sNSWnhfN/opQThmFvKk//QeXeovH8JX5PhTRcdtw
 TBiChtKoYtKu5CMsVkDcfB3CaU8bpc3a7hdu/wi0u1kyeiIEEinwj48ELA9ZaPlrvCpI8eU38iL
 j25b9o7vKTkNs7p2vCq4h2cgZ1c2FmZQFoydjHJ37KGzBv0Dyfgoww7r4LmmE42oQDdMxsdZWfi
 1HA1Nl1IISsgKlk4hAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfXzDj3ldF5rAeT
 /j+6YITAmlupeZsXRzBUMLqT1jJjdzVNSInjmf7BHG4mX2bLj3mobuJzyiGz3zLqtioTnCatZTC
 V9nU0E9iMtPpAWF8gGoYgJBuYQBYUhU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190041


On Tue, 17 Nov 2026 19:41:10 +0900, Hyunjung Ko wrote:
> mpsse_read() reads min(len + 2, wMaxPacketSize) bytes and then copies
> len_actual - 2 bytes to the caller. A device that declares a bulk-in
> endpoint with wMaxPacketSize 1 completes the read with len_actual 1, so
> the copy length becomes -1 and memcpy() runs far past the one byte
> buffer on the caller's stack and past bulk_in_buf:
> 
>   memcpy: detected buffer overflow: 18446744073709551615 byte write of buffer size 1
>   WARNING: lib/string_helpers.c:1036 at __fortify_report+0x6e/0xc0
>   Call Trace:
>    __fortify_panic+0xd/0x10
>    gpio_mpsse_get_multiple+0x767/0x780
>    gpio_mpsse_gpio_get+0xa2/0xf0
>    gpiod_get_raw_value_commit+0xf8/0x1f0
>    gpiod_get_value_cansleep+0x1e/0xa0
>    value_show+0x42/0x90
> 
> [...]

Applied, thanks!

[1/1] gpio: mpsse: reject bulk-in endpoints smaller than 3 bytes
      https://git.kernel.org/brgl/c/f94f85f82e042c89a1e64ed3ff1d591a2bccfa7b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
