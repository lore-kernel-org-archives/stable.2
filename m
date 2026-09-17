Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE63A5449
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638718; cv=none; b=DN2aW+n2IVoHLUReYZKEG0Kp4bLOsVb2iZ89bQzrPf/Kuvi2A9xrcYlpv92mdndG7Vp1a+f6WoHxACtHQNU8bwvZtSk0rBdZbXAh+EuijT5/YsHkNv4SlG1npoyT3fkEDuUh2qArmeT83YptRob3705tTLKLe93VeI5RKaV4o94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638718; c=relaxed/simple;
	bh=9dI6DB1nFlmSg6xfpztBajLroSCF+JLr20XiIWhZRvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofKDQ2c7EYEDyusU4LA+zbYp2ZUUaVil9NpvMJky6C9IkmTT8NpvEtl41f7apdmBu3AXYNT/P1FT1dCu60PeK7gOnC4PaVWU8c9dhMrrDtdsTInsQh+aWdepn7pYVfuIfqGUBdFCUIIwUNnhspekAcd9cqtwl7ifKmRPMtkgxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVipXOq/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FEeMTOGy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVipXOq/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FEeMTOGy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aNmG1699720
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O3S827YcS2T8v900TfM9zh39iRTg/vCLOksDludBz8E=; b=TVipXOq/3nlgGJmA
	fm+jqyhdgRMwNQ8iJT41ZyVQGZVHT4i9FleLLaC6Tr+uAYfkuY+i6sKbBQ94fS+l
	zTA+K6WbcWI3RIA6Z0paB/5Q208ma1qUJyqehGKPn9JSw1GGLSK0PKzyW+k3CCHs
	iCoBIhufAQtUN9XL1HgCd8Zvv05KQckArAecQ54aTZJP3nA2Y0fbzh3moPp1uRWO
	HJXDPOgTPBVsUK6Cmfjul8dJyNtOsF0xAHWZYQLKgKHNLnc2RKPAF+D9V27+8Tss
	JW96W4/tJMVX/Fadw43EpWCxLHkhIaUZLG1IBhdI10viHCCU/UGkulOicM4y2EE4
	88q8Rw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxaybvsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:51:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so113475385a.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789638704; x=1790243504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O3S827YcS2T8v900TfM9zh39iRTg/vCLOksDludBz8E=;
        b=FEeMTOGyeFP3wMcBhQ6O03N6uiMUMOP+bl8SWLAJ22sv1RFz04s3j11ZZk+LebSqlr
         vDHwZC7KNPPx/N5AhSZd+pYPmRS+HRyII54o3kI/HDvxQfOnmiGTUlv1To2Yd7ElRPnZ
         D5ANbOKjZBxQMlydKl6gsoxEYqJjotqU/w20yXpuZZ4zFcPWjn3JRn4o7kgzvWmmDvdm
         IMwdnGVa9ZnVQHbZrYL+3/l1A2pekcdkGl87sybB9zzMFO72vXdUFP8jDHZJ7OCtZXzj
         zSKc5vSfzxkfS7GUC9nARbQ4fTf5Eidp2JDFW6iSVzdzQMV3Tv9YQmkpiyKa63Ja/T33
         T4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789638704; x=1790243504;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3S827YcS2T8v900TfM9zh39iRTg/vCLOksDludBz8E=;
        b=h1AMhEu5M7vsIHOfDCjepnzbqmJAdkbyf71WsKVg69r/57MIs3JgAsAyZn9AY476GN
         U/1yguZStkqYY35BndW6kZ5Ab+m+p6UHlRWeliodixggPVNA8rc0vnhi1wlUrBfGbCoC
         KX1PgMtp+5RVlui41ze19urkftP+qReyWTVt+6QhU5XQ9JF1AFVKWd2NazOZhS7UUH6g
         J1fTenzwGCioxy0Nm8a27rnyQQxXYeuMFpLJyBJGBAzxEDutVcwIi2VmBXEm5hC+Qfer
         bcq6lkgCR8C3yx1T+oU6Oqn6sWldXUYIgnga8QQtcMYSJuFNUek9wZGz6uI9Wt5ls7N6
         tjSA==
X-Forwarded-Encrypted: i=1; AKwUvBwb3sUiudYYDHW/GrDZGRKWfQgfX9vcKbef6sHgHEXZQqBqTKrnwfjglDAeelmYiBDWGywPXVA=@vger.kernel.org
X-Gm-Message-State: AFuF++ky2IcgijUhwm5sna1LG32bdPr+4o/m1boO3ZRtsjcsQuCFe38E
	2/oZRcfhKX7ePGjwdeaeTOXk8qEehpzqtjASgRvq2IkpMWsKM9L4UPkFe49DY0jgebi057Wu5gL
	IJL3BPpDmxaoo09DC2axVsIwZwd5aPW/KFP/PTk5t8cW+CyqOrhvGbOcQ5MY=
X-Gm-Gg: AYBFou3O87r54VGcRL5h3N5GVu1TpK/DChZLP2YiIhO5W8hryUPvoQ55go3kn+rOK7S
	CPpWEuYPWAXfE23YXCNOjC24n8dxUwlta2hzh/Kpdaa44QVflYUewv2YYlhYkOP/RcXhHcRkgDO
	Awm/88pJfTsheU1lTPM6P7hTOMRg74XuUFDBgcOL5lbSZDmoRUBlX+oWA2kBEVG5PYdX2pMRxVe
	jjTbwGGK1Mj/xMZQUj9s99sKM9Lf1oeRHmja5nGJEC0qmUEpGGUUweDqQM1+UBXZPBeBfOeUp02
	tL7ZpBY/TxlU0lgGkHM6VNvBK36c2fpQjOPDVfQGZCdzO4BLavwlE9Yjy/wuyKKJUsrBzhv5oQg
	DVVzF2VDbYeikylQoxD9usbps+Bw=
X-Received: by 2002:a05:620a:40d4:b0:939:d762:e2d8 with SMTP id af79cd13be357-93bb789cc9cmr802500685a.31.1789638704465;
        Thu, 17 Sep 2026 02:51:44 -0700 (PDT)
X-Received: by 2002:a05:620a:40d4:b0:939:d762:e2d8 with SMTP id af79cd13be357-93bb789cc9cmr802498485a.31.1789638704099;
        Thu, 17 Sep 2026 02:51:44 -0700 (PDT)
Received: from brgl-qcom.local ([90.161.207.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbfd935cfsm27089605e9.0.2026.09.17.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:51:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: brgl@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        ckeepax@opensource.wolfsonmicro.com, linusw@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: arizona: Fix runtime PM leak in arizona_gpio_direction_out()
Date: Thu, 17 Sep 2026 11:51:40 +0200
Message-ID: <178963869732.7792.14538092386135912538.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916094701.2007509-1-vulab@iscas.ac.cn>
References: <20260916094701.2007509-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzNSBTYWx0ZWRfX7SYTMOv0UvKW
 17UXcfJRR9aas/LUTDaEuW6BDvuOlEt6FSPuKmrZu72dcNYOQeke8HOJs474+OwVu7cRA8Bplu+
 pR2cFMUEiRBE7DDGm8YRu7Fj6c7QGmCWcKqJD2qJkaldhym2wqMmVdsSJAE56WH/U/TMyX5VOoQ
 6B19iQfRIGC9LYvLxljH7+Yci9N5DM2vSVqzz7h7sqssIzqMcF+7HgzaQjyMchz1tGMOoR/UG1+
 SXCGK327OgnwLOB5zFBDyZPxhxyT9AaHyD1SorLgX3+YnWJrrqxoZA3U5HHwVvXppA68IqL+6BL
 Cd5iC6zh8GwlGWusHWb6VpZKLPOmPDZovDbG+swEsjhoZuONcI7hKybIGvGFyd3Xr9B/VlcV11T
 85f7KyFNvJNsY15q7FhQkrZWmofLuOyMN2A/D6I282Sx67wIRcRB3ad05Vv0H/HxRidPEGsK4LA
 MLVeFtQtfKai5atQ9fA==
X-Proofpoint-GUID: OyHXVwGGHsoIjCSbkPo1PkxTAAVn3jpe
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aabb831 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=BQ2oiuy6hHN+kKmom1QVvA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7NPxJkk6BdN3bhC987UA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: OyHXVwGGHsoIjCSbkPo1PkxTAAVn3jpe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzNSBTYWx0ZWRfX2X8AuOm9cZgz
 xrAuOCNghaPDfxnfZPSt2qX4S0/P4TDPRaASszRTYddhoYVBzDKam8s5n+2qSKKlBjrohCMO2rK
 pZhIMXyzZfEeQMYDCZNK9C8iKMm/kfc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170135


On Wed, 16 Sep 2026 09:47:01 +0000, Wentao Liang wrote:
> Switching a persistent GPIO line from input to output acquires a
> runtime PM reference on the parent device, but if the subsequent
> regmap_update_bits() fails the reference is never dropped and no later
> direction_in() can balance it since the direction was never changed.
> Drop the reference on the update failure path.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: arizona: Fix runtime PM leak in arizona_gpio_direction_out()
      https://git.kernel.org/brgl/c/e9d810279f84b30738f7790c0ed15f8dd5b9024a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
