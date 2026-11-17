Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904240;
	b=IuTx5dJ2RGtXdIfVaobwvnU2TddgIe30wBqyCCVYvcSVIC7K2lxnHCjMt1XE5YLCTTSG
	 eylzqMT7Q+D2E71b7KDLXF7diwHY+ODtXt2Ma9CVJYzSLQJMwRZm2I1CGdL8O4VJa85wk
	 Mcst6Gcly9yZUPOxH5aFMHLbHI2kTjbdZUjl7CyP0wwxwKl7+YgWEyzY3AY9dbsdG2SFR
	 pEYGVDt1A9XOi7w82cl8zOKB+svWxgBofJTr5UorGHGQEzYRMdFTPeX/xNRj4kqqQExMo
	 k2391KccRrID1ZE8FFKQlQBhlXKeN41Mfe+y5qoG3tmG76zuO8lC9A7ksyg/HbG6wmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904240;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=T7SrH+SEDGI5Pc/DX3J27OAmA1Ya6DTNGVrVgDEbF6A=;
	b=agCr5yuqWZNMs2MtjhCO/1YSjS+OnsZcgtMTjpAmPMlesmNyv798r8q/CfEyXF/B8Y3R
	 PkO9fpU6gOPrs5Gc+we5FlPLE7UACy48B+jazqZZL2bmzCMQWU6o7GOPam8nFTMreM6fB
	 KHW5j8VVyfBLMFPIgjhbVp4HGTtOlvu6YpSLL3oxqlQ/0QOkErhdUJsiwHSNw6XT6HRIv
	 gfPi4eqjL4AorzDYRztWpI7fghNVYa88mEe5Jhls5EsBkh3WYCU6cS8PU2y9HBwC70X27
	 qeDfRUbuwDtuEMnH4rgOnQeKzOddShxTXcMfdqSg5vfK/5EDhZNpl6fYOv38pSwP3VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fqQZYNU+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KlMrQhfH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EDB606A89A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EDB606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fqQZYNU+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KlMrQhfH
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH8LvcJ200079
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T7SrH+SEDGI5Pc/DX3J27OAmA1Ya6DTNGVrVgDEbF6A=; b=fqQZYNU+uHYsiI4o
	vor7DxZHKVjMV4jjY+IramvoLpXUV/f83JZUPMGeqshMPuZZjdLb72CR7DNUtI97
	qBwR/W6dG3inCQh0uE5zmbee4Hf6GiGz/so0f8yB0TImdcZfBxrmyQga7fwk07Bh
	Gi0ks6mKdT71FhPNG4/JJif12NxtXVqxJLzvkjiNcAhwjSKnoH5xO6WHNgyYUwUf
	Zp5yyH7Io0nvlyokdO6we7NVeNHtvt198knfjTtsJO9qc6ZieqSv2hWn8dFsDsOO
	4uHCQHzLsD1JAEbwMVk2wptMvEgSCgJOY1RvfTh3qJ5AjnjCFroUAFZeoR03WVbU
	pPi/YQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038mbt9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:30:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f3969a2a7so674525685a.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794904238; x=1795509038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T7SrH+SEDGI5Pc/DX3J27OAmA1Ya6DTNGVrVgDEbF6A=;
        b=KlMrQhfHXPqO6zXT2hBEZcPCZZn9chd2T78TrmvQFcQfqwqbI3cZtynqO34gIgt6A7
         LeJH+vZ9zf6EujS0Y5HfZBF7WI3LRCsX/upkhIqBzUBxxk2xYaiQTY6NTeKzzkC4+yjd
         N8YSAZZuL+n7nOPclqwLPssRfcT0Cqam/x5xHNaCYQb43N4SQFK/yAsybxkNn0RejUla
         gGaMKbVT3JIzkg2F29UMxYcnCpM1eJqAWK/WMkOQolO3qPsiGtk7jSTDjxYqWLu6fmPR
         lzqPyTElZG2w7xW0SPR53ecYCTaVH7E8TmJB4zSwO/J0BUHqfjEirEm3fH8wdHs3oHZB
         NXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904238; x=1795509038;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7SrH+SEDGI5Pc/DX3J27OAmA1Ya6DTNGVrVgDEbF6A=;
        b=QYmihJzo6Am/HmyVY81Xv/90cWh58PSkMWJVdPybOVXiV4U1pS/ItL7HKw6Jex6/ng
         4sBwtpO3tjThNvh5usSdoZ0uIAC0/2K3ZbhfrkOVNsQWE2L3cO/KP/KQp681MujtvuqR
         l0QiotLmw3m8OeO/DrVg1ejwmjJ70U5e7uk6CS54W3Pho158bZf79ZwpvGgF7hf79/S8
         IyeksLd5keF7mTTH1SfGcSkhM0Ee3G90IA/NKXFcMgOr6URyYkQtYnJmdcvZX7PTV+9J
         SJGO/ZrXw1ULuYMrBCLOQIt9Co2w1yWyVF41LnEOM0yg1bTcU2HSNSXwMhVFIsrhEmhb
         SLEg==
X-Forwarded-Encrypted: i=1; AL+hErGL29uaiq7BEj28aDbe7bgJ6kwWwlLLivMc9T0KQ137GKLMRTBjaVnu6e+OOxVhFfuAkNGvJ14=@vger.kernel.org
X-Gm-Message-State: APuU4Z80FDeHAAzYKVv4vYPv6iXng+b28ECu5CAGQI6T6Tz9Xzmuzt30
	XKm59blJ9cMA03wq7N/MnNJnDXICwqQu7pFq2vps7u4zRSHy+lIl6mZa+mFVhWf17bu4W3vAnrc
	/zSYevYxR9Mw3SSsycjjV3y2NfUpwI35RWRz3GnfqYb4hCb54z5gclxJys40=
X-Gm-Gg: AYBFou1d5YRCLOXG5QfS+PUNMb2v19RZzkS6hTL7YbsoIEDxWJrZwuyHZNEkdTJG+OM
	IYfjBsyYq5RaruUy9+EX6t0TvqQmR2RoXkgYtRiGJuhS01B4rR/V35QKg0CjrEBOvCCR1IOP2Js
	jshNIQAJRrfLw4rtkuue1nysLHK4LsvfVFdIkpgOe7rO2Gb1TE1OgMilP07QcSYxuJk+tt8zV33
	wlWt03niuFgcnprU2mpTB2NJJFv0MKMTP0bRCWrCA+1w1HE6eHR5wWjs02NFimtNtAb1SX0eKx1
	oBN1sAWfJprvD6clvDZbUG5P022xbO4h6nhe1VBBPnp9VjzzF2ozSnYUc+3MSCnNKYPY/fQN10I
	WCwUr7wOmH9xcbi8jh6noBXVoGXXrWLyyuswkxNbRm5xlitdnIqHKuCL8FwlhKLfyyjYv0cgXNN
	s=
X-Received: by 2002:a05:620a:4493:b0:949:816f:cff5 with SMTP id af79cd13be357-949816fd1b1mr727764785a.4.1794904237951;
        Tue, 17 Nov 2026 00:30:37 -0800 (PST)
X-Received: by 2002:a05:620a:4493:b0:949:816f:cff5 with SMTP id af79cd13be357-949816fd1b1mr727759685a.4.1794904237455;
        Tue, 17 Nov 2026 00:30:37 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60da0a03sm21613010f8f.53.2026.11.17.00.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:30:36 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linusw@kernel.org, brgl@kernel.org, davem@davemloft.net, asmaa@nvidia.com,
        David Thompson <davthompson@nvidia.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] gpio: mlxbf2: Disable interrupts around the chip lock in direction ops
Date: Tue, 17 Nov 2026 09:30:34 +0100
Message-ID: <179490423029.15574.4911642575575429380.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113184444.3431-1-davthompson@nvidia.com>
References: <20261113184444.3431-1-davthompson@nvidia.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfXydHc1u6dfyp6
 RmxlZoTKrj85RBhtkbF7elpleOl+UWu9O9Cuu92gPVpbMUEA3KpM0pZN1sfhxmKNokW6USqF9ml
 +TjNSMqb+iBaQRKeEGmnO+HmDqB76BUdKRNuxCMAmvkbHAm0T3t48dnrAvFcccOxYtkTdw06/tI
 UP+AVnWyh1Wg2vkVWjcqoXQSamYqrkE+HIuLI99/1BuKU64NytZcfbUj2Xi+EOSxHJU7xd6QtBy
 XslEHk59e75f0dXTNWpnuQ/YbNKT49XFLRp7zcuXvBvAYeUo8SOn/RC2EEninoW/MPdWwzPTBXq
 eytFt60RywFXYHKl2nCnWl0MHhbr9et7h+PsYJjRED2N1ukBgNjUWIU92C0lCd/CtWuqkylHB8t
 VYczwr0hr9w276mG/xD9u/xxJZYT29v6LIhkeT1k69KJRaO9mcKXc/3HoUnQBAh/lhEkaFVAqBE
 4as0SqUfCj3Wt2X11YA==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afc10ae cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q209iurod-_B6gZumggA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: kcM3OMhX7mGSA9QBTwwY3RR7CW2akOsm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfX4Tl2l2n5cpbx
 1tAoksZ1K8datyHm4bRBr1vTmaGhwFaskWHZ65b8p58SVqKrU/jMJAJH5urcvuhqLwBzw33HImd
 Og2Ja8Xx8Y5NbJk3AbBZxlSKa7WGvek=
X-Proofpoint-GUID: kcM3OMhX7mGSA9QBTwwY3RR7CW2akOsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170033


On Fri, 13 Nov 2026 13:44:44 -0500, David Thompson wrote:
> mlxbf2_gpio_lock_acquire() takes the generic GPIO chip lock with
> gpio_generic_chip_lock(), a plain raw_spin_lock() that leaves
> interrupts enabled. The same lock is also taken with the irqsave
> variant by the IRQ callbacks (irq_set_type, irq_enable, irq_disable),
> which run with the IRQ descriptor lock held.
> 
> This creates a possible deadlock that lockdep reports as an IRQ lock
> inversion:
> 
> [...]

Applied, thanks!

[1/1] gpio: mlxbf2: Disable interrupts around the chip lock in direction ops
      https://git.kernel.org/brgl/c/f95bdff1d53471159e3c7112c5de4f6240772521

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
