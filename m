Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904096;
	b=g81PrHwD5KUvyBW+IREOC4kZjEUHtZaPf2MbYUCIwpu32TLdoeUp8kcq5eSOZDxkueR3
	 /bPY8KbOJby2yNBHTbpzGzKCcXAd6ZXIlIBwgUQT2Fyh9xOl67wTDIZp3iPZMBJQNdxVM
	 T73+9L0EjdREY4iopH0EFH2nHNg7DALPPHZP9i0+fDIbHLgsM2lRuxWVMFPcXJxutFF9e
	 dMiqahr8r/L/wSFwu3wNJulKLrl6Mws8aOox4o3u1JGwbfxRyWOXF/czgMWZpy0B0KDA/
	 C2hubGqOD+fJTnqq4V33q/Zb0yY2hjok0v9FDnpV+96HNKQ5A8Inz20fdMfPH7u8COw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904096;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=;
	b=IoXXp+1jCftiZzti0GrgK+AIBy/3qiieuwtSO5k2N4P6HNsqUGRTh3x5idjX5auTERnn
	 yBHBPkAlNvUqoSSjgZwhcjgDgxKuKFPa7gvqHOuFQiqyxfbu8jZrL8TvFuu6ezU+PXF2j
	 3iTRdGSFynlfvy+J3phqLPeFlJIPUK/a19QSN894R8v6sJcfJvUTCgHrkS43rcmMk9SzH
	 hd/IVmaAO2ZJ/8/7cQeM9kA37nWIpDRwbyeXT95hpWaHlQuDuFxsKgBfdr25/PAGmBfW0
	 DOEkM1P5XNRXyPa/zz8DQ1yFOayB4ARlCadJXJ79X8NTXQVP/lQxEf6PrLBmFUSnYVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lY8u1rIu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FE8BvPUZ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1260A2622
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF1260A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lY8u1rIu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FE8BvPUZ
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2a7vF3407575
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=; b=lY8u1rIuFDh9Qc3o
	G+xSp1V8wA3nByNZ1k6tyv2kz2nD8XND6JamyN7gIEKw5mzpYxQLmf4eNfr7n+sA
	NUKbd1XO7mEAbbqgNu3ShKRar//+Z3Dnk3iWRp6mLffgCfmhYNKLSFdYvsWe1FG1
	qB5trr5C4W8N46O+vKqkSGjpUlSYl+tYTF4jjZfCPSNfrER3f7QJI7xFJx8/QRSv
	APW92JALwbOHcuXIAxPKU6+wz1KCvuBr49A7zlIgYTUqn0cKLVda4XN1Eh/gp23n
	i/3SZHPYKhQhokvUAMx6GC34V8AaUVsh+FauPEGjNIi2gsocx5HbkTs0P/xvE4Tx
	+5qMbw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htj4wx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:28:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so442419885a.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794904091; x=1795508891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=;
        b=FE8BvPUZ1lntBS8FUpe1yu4RrrlBzlmCboRJYvqkvKQMEXJQr/ydR30WMwXn3LYYGY
         bUgtcBrwWU9BaLxOsrfdilQ0y81J3nFyHYx26VgH5ETdZnFq3FrLAD8k5jZActgaIZDc
         nNySXKYUqq7FbJudjMZGnkb/LZaVCnzWglezmJYaeyB6E3kJqpkjGatgNCHl7/JUl42k
         BrNB4A1MU5xx4HTV/LHT8zR/4xxZrz7QRPMoRBBrEHDex1hn0tOPIreBJSIhRtH5tn4j
         oVopHz+bpU0lqVmFc227r1vk+vtezNmtqPO/4DHsfsg6DjjAUvPsjJSHly91c9Al2qDJ
         3e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904091; x=1795508891;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=;
        b=kQGdKcQxiIQcY7ncHVYMicImKKbgt74A9I+X8Z2mSvrMb+hu+rkqaVeiwbaC1U027C
         J6jyy7CnP5lxcZdOnTIYTHkCGZAHTmf/7wK0iOjMSrMJvtbB2qFLIcYeL7fHHf8HaNKr
         hX3Tz6HAeBEONJzCIsbUqKBBTfSBd48WVtvvWdW1jFKMoK2oOBRg3UNjiocFQjiP+Qic
         bMPfGc9/IicEa9iBPD1aIqwZ5CoWxRt+HV4F03WutgzCa6QEBPRxGnqFfR2/kWxT+EtP
         U7YQATFgejfHswAJwZuGjh3uCscCWlrHnVGGDXKybnstWGAuxukOpXLHLf+aFSp+KTsg
         kliA==
X-Forwarded-Encrypted: i=1; AL+hErFz0NplOrzua3HHY/KjRWG++9nL0d1fItHTThcswR3woavELue4G2aHGXsW3UXomd0C2SKXDnw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P6kG52D+Q7POItd//zGIKY8tTszayES7qQtYuSoxGoJYyfC2S
	GtA1ZZYSHqianY6uEEwb4wgYS4JXvWJzy1K7z25dMP58F/LT1Y72MhlgXVRpIr9+UuVXCoK4ykm
	Jm5MDxTJDU38EcX+9DMLhFKi9M0aVlnVF1H++ucB0t+GMeBA0RWD1my5FONI=
X-Gm-Gg: AYBFou2Q0UnTTrOlFkUCMpoZg5G/ztK4hqnDPMQW82kAtsEKnXjI/KxKsMEy0PryiK6
	lY9frkIAsoshEXbwJRvxnF6eMZbe9fmz/74x3Lw5t+luYJu2ZGx418fvlclyK0az3i5cgVv14x3
	pGLL+b8roUJ2GloVrZ0l9BNI7F9+Bc/zEA6UfObuLtE1/gk0vZm+0Qd1MGxg3ebc9zncJaU73VC
	QQJsQ9wnvSNYuC915kljugEvZoAHkRg1UynIdwJagHDl2oyX/3QoJx3TDJkyJ6zXpCgJkLOfUTx
	e9d6OcPZqcmwY6hPY/G54LNDqkFbfbTIJ/4L+fRpYkxWvf7OWMW/h7t/XhlgomKOmy1Fy7timU8
	RPZeLD8v1s896/5MzX/arN/6u7XBg8vUjOxJkjfQfMgHlPYN71mXe2Lh11y2IX9X8ui2Z8f8xE8
	I=
X-Received: by 2002:a05:620a:690e:b0:949:6d95:f63a with SMTP id af79cd13be357-9496d95ffb1mr1337953385a.78.1794904091249;
        Tue, 17 Nov 2026 00:28:11 -0800 (PST)
X-Received: by 2002:a05:620a:690e:b0:949:6d95:f63a with SMTP id af79cd13be357-9496d95ffb1mr1337949785a.78.1794904090783;
        Tue, 17 Nov 2026 00:28:10 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a2ea918d24sm5393966f8f.54.2026.11.17.00.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:09 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: virtio: bound the line names block by its configured size
Date: Tue, 17 Nov 2026 09:28:08 +0100
Message-ID: <179490408585.15375.11644754395954645362.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfX97nMvoojxI88
 bV6MdbgMmQtNrX5Q5fwBkhBQmmQe9nY1rbJ0Ea3HEy+5VorCbPpAg/akBbnFQN0ooNu0MqaGcac
 ME+5uCgfrlhSFPT8Ne2w+Qeb5vDp46c=
X-Proofpoint-ORIG-GUID: 2ZMG0MbNXlB5xvEz7nt0jFBnjORY5ZgM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfX92+IquFMz0p3
 bx/ZPRwuPhpW66hNckFkP856DPIzYpTrSjAvfD3/b9kvTBn91zkKL4DiL6jitsP0n9qayKJN8DC
 FKxjRWxwEg0WXBzLIsadw/aCez+/OO8u0QQr77IMmQ2YuP02FHwLH94y4mjFHjG7Hr1+xaka1kU
 w5zir3I7OKWWjDr/nAbzNVT9UXJguWM8i9PE5TFGgNm64vI+ZT7uUJQ7WfuasjwKiIpV4hLBNA+
 oD5qvxvBmqEZ2qR+EiloWDSfDh0GnAM5/xEnTTe1kz6frT8s68G8mn63VEbJfRTtPuoYMfd7G8m
 bbg894Yipa6k8Rm2U34x7NwzbQMHdcg9V1e1MFhz+CAEmCW5cNChONffG3bnwo+MzuhHP/AOjJW
 yBePZLw4tczlZKet/m+UclaRfzLNU2iTBVnp+d9EoBlRnGJfNj7nOmh3zasvcOYsOQOubuMwefX
 1UW/upBtNYS3q/okFaQ==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afc101c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cV_xUt8ozR8xq277GC0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 2ZMG0MbNXlB5xvEz7nt0jFBnjORY5ZgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170033


On Thu, 05 Nov 2026 04:56:31 +0900, Lianjie Wang wrote:
> virtio_gpio_get_names() walks the line names that the device returns in
> a block of gpio_names_size bytes, which the driver ends with a NUL, and
> checks each name only after stepping past it. If the block holds fewer
> than ngpio names, the walk reaches the end of the block after the last
> name, and the next iteration starts strlen() at the byte after the
> allocation. With a block that holds one name for four lines, KASAN
> reports:
> 
> [...]

Applied, thanks!

[1/2] gpio: virtio: bound the line names block by its configured size
      https://git.kernel.org/brgl/c/74aee8e06277df39ec10ed043bae0ed5b7a83864
[2/2] gpio: virtio: compute the line names size in a size_t
      https://git.kernel.org/brgl/c/9e3032dc4d92e6214ae687b4c474de9270ce74a2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
