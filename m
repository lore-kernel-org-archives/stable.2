Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936143C417E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204327; cv=none; b=J6qCv/SA2nkSGlP9QViqhyiUfKJFfPD//+5U9WG/xGgAojeMkY+VibbPsRg0j6LXh17YvR+iFH9rikJhedITvWAMqZNHjHK4CGbr1mFRCEB37rKKuA49NOZssjOVNdhWM4kBY7QcURUHCOiT2g2ZB9QbQFSneGsAqPFB3zvJ2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204327; c=relaxed/simple;
	bh=PEfg9/E5y1UFi3sIEh1+99lXZ/MgRXWyftWSdT02h3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMXwF+0YXmYscELkVMPT+zXbt7ClHCQZvxuX8M55fiugQk4ZpAsqtgLRmyHjRzUBBV+GExkTs42/1Me4zZenau/EATYwoycLp7k2u3IcIkWVUGT8+kiVLJaedVgWW1+aowEBkDCHyUviSB1ae3JP+MD/8oD1sPrDywykJk/C1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADIqg0r0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IcN1o4/b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADIqg0r0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IcN1o4/b"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cbfu2992200
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O0q7WRTscj9d++RUzX6zRMArlx5VJ2vmnVwOo85kg9g=; b=ADIqg0r0UmZFfIA2
	GbpbtZRizks2YNme7bRdSkrW/ikbhz70yXNFFQ4ZvC9+GE6miDx4I9cpVeQkMmv2
	I4gJsIDkLIQqX/Dy7S3+Aoze9l3Y9TM74thAjmQQOEZXaZ5veZCuNMy5fiC+KQDv
	5ylI4NzG8uAyFOpnQZG6NxJEfZHHt8lwg3Ckbj7u5uKN5N+GwNFoGlnLl//PtiZI
	HsytoI6OUx4T2CKXg9bNLgHcTj2i08PtUP3YQNhu0CSxBe9+vFrzPXLzju5mzNfX
	iw44vNFrEsLYpgOkoCeyfYK7sYGAZNxgHciB0o15ImGTZbS9uGuW7WjKHc48wrlT
	mC1YtA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729ufke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:45:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91574ad681eso823256485a.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782204324; x=1782809124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0q7WRTscj9d++RUzX6zRMArlx5VJ2vmnVwOo85kg9g=;
        b=IcN1o4/bSoiSLFIjJax2ewXtxgSGK8StJRhraPLwNBIJRvIZYBaYOfRZpvZevgHIAb
         Ir3jc/RHJNRQi18ncdutsVuWeqij0bRPdkey0tu8dmBMwXoIp5+f73mv/G2Ti6rSd0tC
         Dwwj6+qeBiDOOp7JjhcLyvKFmdTCd/lpajmvK21PT3/X0/usvvqPlr76wDDkAE33KPUn
         l+qHN6+4pn6YGeCd9mBkKeY2kETgV6xdIWCHJC9PtUpWFCAdeMd828DZmDYLaG327rQc
         HOhweYgOouGBaq2dS2JSTJ0W7E/btk/DLYrKKEefiHBtWphmEaC/cJ4KYVKB1wW2Zxyc
         LmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204324; x=1782809124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0q7WRTscj9d++RUzX6zRMArlx5VJ2vmnVwOo85kg9g=;
        b=qHquqLjjMaj1GflJEXsQoebUqfiUfp4iCE//N9idywpkC1sklBGc7ZWL1g0M2ltBJE
         QtKZuZ37vQSHCcp5mlKm2tDwVoOT4qZpIGsWLvI1E+4hEYqw8gFBnTATOwOdJoHbU289
         mu4rsh5J/+iJbdJVYNO6tMtU4A8MXvMP87R8o77AS3xrAB0TAax02Tgpub/b5dsqAz8o
         PR4c2jL/zYHYjHH1ThZ+B+NMk9D9Q9/w+s5j6Rz2sraKUr0LVPH7G+UVX36Sy+9JyttQ
         pc3QHPwe2dP9oY7O4GdXk5r//TpOKvhS3UL61ugxjp6wnDrtwK4kvPCEdXnlb8uSNYvP
         ZNVA==
X-Forwarded-Encrypted: i=1; AFNElJ8q3WJr+Lx6zJ0u41BNTJA/ffqJiSvcABdjfM1PNnUu8mO2rLjwz8iGyLHF4vcrFHFWMrqYxMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmFkwcEoKtEPuF3MRV7JTNnuRb4nCcpzMLhVUQFTf9ZgDfcqd
	DrO4/MOILgiiOUy5HrlVA05B8F5y4hvb7/zd7U2/v2Kadpk1FAXH5Dh/gRoiPSwsmupbj9Le9nr
	mGVzBxnEwG5eOvnKpZHud0nWs0OufKii/qXAGBMNECbCef6kKzb6TtRjAWnY=
X-Gm-Gg: AfdE7ck1UqGDnKhYbRVJgjTlUqnVayrgFepr8Ol3BUXy4Ep9tvKjif5eDerxkHC2ZgH
	eFvoHKREoC/Jh/1Nc/DdHskI9Qi8zz0T2pIcbPmvpqjcfdxqcBowGd1m9fBP32w26VniciNUhXi
	95EKvelNGes8C1gaZwnlG8h2R00C7DRULxKH2VREnViIPm5GNcF41VUCHudvvkkpyXb2Fg57OTm
	hz0zIVt+NxDNH12K83hBcMgO020YvShtdgrR30ihdSPR+k0A1ay1KWSZrRTEvzE7W1sqh4+e68q
	wjpRDUFBj0cbeJgJbEl/AZdLVzuIOBDRCOIANZ2Edg9vZPhX6evgAzqioLP7X3tnh47ivNAb17N
	B/EDNVqYf9iIzvPArcJ9maBb8Ucr+N5/jvsPFxxw=
X-Received: by 2002:a05:620a:4481:b0:915:9051:ba2 with SMTP id af79cd13be357-92092450e6cmr2841998185a.49.1782204323752;
        Tue, 23 Jun 2026 01:45:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4481:b0:915:9051:ba2 with SMTP id af79cd13be357-92092450e6cmr2841994985a.49.1782204323304;
        Tue, 23 Jun 2026 01:45:23 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:ac73:5de7:b9d6:d9e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788547sm35622583f8f.18.2026.06.23.01.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:45:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: tegra: do not call pinctrl for GPIO direction
Date: Tue, 23 Jun 2026 10:45:18 +0200
Message-ID: <178220431330.7682.16070388780345614075.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619152439.1239561-1-runyu.xiao@seu.edu.cn>
References: <20260619152439.1239561-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfXyWACjikjLaHL
 p1VG6ICkN+iEwn2neZfG8eTLGVO0fFLARx7gsx3P0f0tn3y4EWEVJ8Do9xWosOYGwymxS50e85R
 KpYZy7U0dM7ypH4rOQJH04Jd68ZIzlU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX6rzrLUn5sDDe
 IP0Pk6KWTdYlam8DZyZHjWzg9uj1q8qMtrTD9HZKeeWwwYDjv50PDNJ8UTMawpunFhHPw+F91NI
 I2P6GBfJY+oqxfqVYRkVOe17dOu5s6jSHSmQfjBqM5J7hmkqQQHIo9TNYg8O6OlRUG4+DkNzri/
 7wY3VPyDv2BOHb/jwXQQcIveVq4y1lkaQu3/zj24p9lyqovpni8ZZ96ti/9cB32yJtAbghdiJa2
 0X4aXBnjt/lJIbI3P6xkW6ZSTu78yK90q2g80KqObRXxyZuuO3TTtdPi+iacjbcdAV6mtx8hkI7
 nU5fijhqNK5dUXcPFMQLskvymUf0oiWkKFuT+rQXaWYNrMIBX2mcpphnthVJgv4dakYXySa+6e8
 omOYNohT3UEeP5ipB4dNXJZaFC+Ov/mMmAllQ4zk4g0xpWtC1hey4VxWC1dxu7KlpzaxzrosNL+
 a71vW5M/sbOCakPRTAA==
X-Proofpoint-ORIG-GUID: qBYfGlQClkpDhpYSBXS7QLTEPdwGibro
X-Proofpoint-GUID: qBYfGlQClkpDhpYSBXS7QLTEPdwGibro
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a3a47a4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=DckfCgsgHaicydLOKuwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230070


On Fri, 19 Jun 2026 23:24:39 +0800, Runyu Xiao wrote:
> tegra_gpio_direction_input() and tegra_gpio_direction_output() already
> program the GPIO controller direction registers directly. The additional
> pinctrl_gpio_direction_input/output() calls do not add a Tegra pinctrl
> operation, because the Tegra pinmux ops provide GPIO request/free
> handling but no gpio_set_direction hook.
> 
> The extra call still enters the pinctrl core and takes pctldev->mutex.
> Shared GPIO users can call the direction path while holding their
> per-line spinlock, so this otherwise redundant pinctrl direction call can
> sleep in an atomic context.
> 
> [...]

Applied, thanks!

[1/1] gpio: tegra: do not call pinctrl for GPIO direction
      https://git.kernel.org/brgl/c/d3e91a95b2b0fc6336dbf3ec90d831a1654d2720

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
