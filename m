Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABB3B14B1
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023835; cv=none; b=oJw9XdeXWSiCNZ7oAmgecWioe7eKdChjVgqo/DDp3Sqc0abPPFeb5Ne59TxkRieftTdi2o1k98PGj8hQ2Q2t/+49d9/Q17WMI9bG0XoCUQpwUbNFrbfOiCLYG+c5VbgClglFF7OduxR/LBeJ4/tavfmh8Zut57up0i1YOCna6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023835; c=relaxed/simple;
	bh=m5K55rZTH6dKovu1gmAY39GkI5KStW8T7WINe/+PX7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JyV9M1rhOZqrneB+UJ6ED55B65FNuJy/3sSwOzGcBulvTNJL6ejCGJF6Dut8DlX/dS4nkVLZ2qaCC2Sk5UyJRYuzGDbkchkqtIx2BYLzbNRD0jbhPC9YvmcFKiVEw6b8wDMQ+CReTTt8edTjVL8xiycUlBnjYMKzsaFlGrEhPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OpWHOwpr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBOzTHhB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OpWHOwpr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBOzTHhB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659GPCl03207964
	for <stable@vger.kernel.org>; Tue, 9 Jun 2026 16:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4APQVPv5UexJleRwUKeTyD/FNVUJhVermq4vMsM+NpE=; b=OpWHOwprrxOj/oee
	8Qtn8B4DU1eBMJYuAEIiW7HH1wyUIRFdyOaNO/gikX2O72Pa7EjGWJ/2uQKy0OF3
	+NbwjZMvptK04gRgGNXa5YvQKBfHdi/cufxLt5yn/8MvjA9M6ij1tckjo/k9Ljn0
	qylcGNBetW6FOErjXMEfz8XrPOJUsdoXvHLocUKd5Yp3NtRHnZ2JRVfZFhXg/0kr
	pE/YihJ6NVN9v9oP79Vp5dMJPreioHYv/4RYSvIKQ2binsYtzbSBNtd01A8lKaF2
	xXVIrzm80qFNEhqn2QAxjYHVpDWVydRF3FZdHnCVRzCxRx6HXxHKJYUmp8U18dgh
	AhhwIQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt2d8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 09 Jun 2026 16:50:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85dcdbe502so3804760a12.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781023832; x=1781628632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4APQVPv5UexJleRwUKeTyD/FNVUJhVermq4vMsM+NpE=;
        b=LBOzTHhB7FCPqo0S99nunZglSY+Zfqh2ML2GSZXfDG0Hw6zefZWpZyJ4iotjS7yL2n
         kB4NMnwlJKFgJYlIYFTIq/NP7uGYjtyb2x3drVFt+diu9c78Rpw0pdLqATIKfRP7h6Vk
         vdS+v8SkXFXHHKUjWTft/0rXvgBRKAqNxnq9eN9KdXB39I5s6yeN02Hp+iKDKOa+tcJH
         dGYjQXclSkn1vnpZqkkFKc9TwupkqFaU/H1XpKSmgqqHff9LhCZFO0WmmGI2TF8px7rl
         HVZMveC2PeJsV1wA1qcDPBu78mOVuTFNFuDXY+MHDtUU9I9jufWYfXL/sobqQRPN+L9o
         RaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023832; x=1781628632;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4APQVPv5UexJleRwUKeTyD/FNVUJhVermq4vMsM+NpE=;
        b=QqNuOIu508utTq3hd9Hz3IxxSkFbYMUTvcyu2iDAh7rDSgCpO4br81CAlVfxEwhiZO
         Nav6O98x539AIaOm14/Ek7r2l9r14wCHmUUjMAr+VtAStcpWkDDpc3tyW7ENYqDw9V5t
         fw1D2Y/cOfjr0gi/I/HpbAiPomocd2zSGyb5hyqld1VHakMWb4trDqdjYpANe+u15CU/
         Oe8GfiVkYjVnyX3DCi5DM5KxFfYttlCarL7TYdoG1BAMuqDsfaX486kYmGQlrZwsUEpQ
         4DDRa8v84WG2L7hnjOKJTpzb7aHxEc21LymW7W0n/M6vkBMwQ4nxqBGdJrcbZ9ra9tcr
         K1WA==
X-Forwarded-Encrypted: i=1; AFNElJ+RiulFB5+qNBj0NMJj1b7iYS9S4E1BFzBgdAH3LVhVqcnOUw0y4X0VIn9bee4T8XIndw4kgSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Bkm7aUNT+KogJXg7kaRILmJmWtx2xEzdk5Wddm5YCBoBMw2V
	Pm61KE2zmL3WZjy/UwuI+HTdzbKjAbB58TxIqZ60O4P2vDUMS7CdkxBWPQG4YkCOn9APWIH2GvN
	9bzsSKwsm6PT1BHM7Wtupcm1dHcBlC6dqoWC7DPVIJjp0td/UNj8qLvkvi+3xnh49BNY=
X-Gm-Gg: Acq92OFZFpMaepeVNTX7MW4Ee3UVxWQ/5UlS0sjqWLUOsctYTTs4ufw6s0eAgit9Quq
	lXfqPzew1WCRrdtSW54vZy6OWj1dmN/HHw3vTHGe1KpUHcEL8E69og+D9mh684S+75DwVE++o5P
	gFN6X5wECZPPaHnitOcWo/mYE24M9IfnOExBgnH0p2z/+1OXcX00r2LXIZPL9xenYE/wtg6gHWm
	B9/vESO1R/rxqCfvWkkQH+XFHdvpJx7HuBswvwM+WhJpgFFSkgRJMcjXkYxHW/bTNZbNYM7p9Kc
	Jvjrft2eKjiNIz/INdaRSBkwY84XJMPPx8KTCBKsQRpHvPE+DsG9/wvaW2OwEkhPG6URqVLkYQc
	9OEVAowkRYcRqpCC7coMBFHMqfCHXBAo=
X-Received: by 2002:a05:6a00:1ad1:b0:842:4387:34c0 with SMTP id d2e1a72fcca58-842b0f1e8abmr22235205b3a.5.1781023831670;
        Tue, 09 Jun 2026 09:50:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ad1:b0:842:4387:34c0 with SMTP id d2e1a72fcca58-842b0f1e8abmr22235170b3a.5.1781023831127;
        Tue, 09 Jun 2026 09:50:31 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm21310593b3a.33.2026.06.09.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:50:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20260521174617.17692-1-mani@kernel.org>
References: <20260521174617.17692-1-mani@kernel.org>
Subject: Re: [PATCH v2] PCI: mediatek: Fix IRQ domain leak when port fails
 to enable
Message-Id: <178102382633.15301.10190757934266235538.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 22:20:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: p1RLS0xbX2ZE2ewjLhhJtG7AH0p5Jg1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1OSBTYWx0ZWRfX8S8GF4CwnHfO
 j9vzaOC9bpvI+IVreVPW3Y+rCJXusSOZLszrAoRCEuBd/9m1TeONyZAYxjQmcVMU1slcGy7Cd55
 7SWvG+yRPUlFNhbR0jWuI/Tghh0ExVozCY/gaDlPf7b3fB0imiclUzqaNOTVBJo00HopjOwBbPu
 KDmWQYY5er2K1J8zLfTn3KZotcSZeI1y8FVlLKrFoYFpwJ64fGH3KYQc6gsJ9Tj0AJET4kNKRA6
 tf4ItA2Ht0Br/GJ1b5hylIpkohRV9nc8q7PLO48wd/DIHzRrjtp/+QCWm0sxGISnD1EioPYjl5H
 Ghkl0OrEcjg5UwfsLHEQZqM5o1MWljhLOihxv7AdmlirypjemH280TdKO5lG7laeFHA5pPyc64X
 WQgPXHv+Y7mOAL+Ha5gbDgKaG4d3MV6kDDvFbyHd0q9muxjAJjZnUU6GhipNjEN46UFlCcIzj6p
 MRXYK1ksJzWX1CF3VSA==
X-Proofpoint-GUID: p1RLS0xbX2ZE2ewjLhhJtG7AH0p5Jg1w
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a284458 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=mJkhQync_lts4CGhekwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090159


On Thu, 21 May 2026 23:16:17 +0530, Manivannan Sadhasivam wrote:
> When mtk_pcie_enable_port() fails, mtk_pcie_port_free() removes the port
> from pcie->ports and frees the port structure. However, the IRQ domains set
> up earlier by mtk_pcie_init_irq_domain() are never freed.
> 
> Fix this by refactoring mtk_pcie_irq_teardown() into a per-port helper,
> mtk_pcie_irq_teardown_port(), and calling it from mtk_pcie_setup() when
> mtk_pcie_enable_port() fails. Since the IRQ teardown must only happen in
> the probe error path (during resume, child devices may have active MSI
> mappings and the NOIRQ context prohibits sleeping locks),
> mtk_pcie_enable_port() is changed to return an error code so callers can
> distinguish the two paths and act accordingly.
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek: Fix IRQ domain leak when port fails to enable
      commit: f865a57896bd92d7662eb2818d8f48872e2cbbc7

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

