Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C94749CA
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278241; cv=none; b=V0dKb5itl3Pz74cHMVwjaErzAw4O1hCCuVjtCbUZ1GpNsxqQO4DGtHOaTf1Gbta8bCmquu1fFCu2OYU0DNcdvFeRgna09snmIcsXYo6wqTPzl6kcKzQ8xGwWUycSfdhYDaUnkGBbQ5OEVtB+rN5tnZIgA0KEAnmazYzaNGzc9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278241; c=relaxed/simple;
	bh=mI+0OCmjkN8IPzMXzsKrgMBigNKPLjrQDoxW6AICHxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edDh92LV81Jt0ves5mllYg9cfY+q2rHTS3v1GaTA3Zgdq76ktPVFRrbCGcaQdmOL9drheyDf7viiIVn9It6YWehtGyWZpCZVm3qY0FBNr6cOe9wdjFsfaVGH4E7CkQ6EvxqPe5daRPsj3nL80R6gPdMFUaK6sbfV23eN9L/0Hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YyYgO54B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g3z966p2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YyYgO54B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3z966p2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8px42825350
	for <stable@vger.kernel.org>; Tue, 1 Sep 2026 15:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/OQCwLQW/6OFj9hLgRG5zobTrne+fl2iMm+qRPhRWc=; b=YyYgO54BuDL/0Tfn
	tH1YRwC1B6H3WYDkK1f5L1UDkYhlPijHEtr9bJ59EmTVT9hVimetw9nrcQgFuoL7
	wcVcFuhOIWnEXxCBW3nHVyBKnTHV/0HOpAWIc/MD24k6kYrjUQdpWYlzG3I/NKfG
	E6hWmVGm9xHbaGRLrZdypNuFvvHImUpzcCk1h+SkQF5SYzpC5zEMb++AFC3+tEHL
	p8Psntsu9KuEJkC6QbyRlnaT3Os1LHgnsbKgQXgRRlpmEd37n19vLEUuI8FRvv+Z
	ggF05gcfeNnpxAZXxQosTYSZ8tuvnUFB9CWtAlG2Tgkxb7+TCq5zmLnCjKMeMOVO
	0u04ow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7cbfas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Sep 2026 15:57:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e62e3459fso13654285a.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788278238; x=1788883038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x/OQCwLQW/6OFj9hLgRG5zobTrne+fl2iMm+qRPhRWc=;
        b=g3z966p2x5SiZPERWDgDDOAOQpE8A320wtu1Mc6NG6EdM5vOozsi3RPczaoJMHZtUS
         YZjQ7bP96kPscTdn6jzjeBW+juImT6385vLSrIJ2a039KYLAfvS97OWZWsZ8Sb+1j+C2
         icxFD3UUnGXh7uL8mVpkTl56n9Cl54kLj4gsi1XQsSDSSJQvuAdi26e8gDvv9NDlwlTa
         BrZV0dM0/lmibCyMSJ4PxscBA4EXWKEa9YFDSG65rf5x2uzhtUbp2yts2oScGme76FuG
         +Ge+qIdI8RmvAvhGYBZZ0uoGG1J6XOFXDEgIPCsoplsJ4GyMOtan3d5mAkjj3yENTVmQ
         D0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278238; x=1788883038;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/OQCwLQW/6OFj9hLgRG5zobTrne+fl2iMm+qRPhRWc=;
        b=QOCqNCPJEXW4Hshk1DArQrFmxEnlGN1iE76vCSJDTv/qyVFiG/mHuliz0RD2Nc53ob
         Yd2IW4VT891DOE0a3FSueYg0k+yrIRSmHMuZihdiYrPLlBwW/kxjSElteBO7D4uDUcLl
         se8iVVDeRaExnbbWaFohpqn5bD1JxCD+x3nnM8LuP4Q/QwAqYX5sVUd7BlVw3nloakWh
         fUfGcmeg47qnm+8Lo92GfQKejUsfwLYJd0UwktIcjenZl1EiDSlZG/TN16aTHyfUfwmY
         7pzuQYgC7b8Ndsvhkk+OZf+Z8UnsFeRulpw0CZ/FPCaIeth70wRdTzjggntJ91QfFQ9K
         FDJw==
X-Forwarded-Encrypted: i=1; AHgh+RrHzPS4xVzwQP0I630xd+pXbbrAW50KsvqtVhv8/tvVED+BEuizzl9FgWNtN6mHpgCY/jdVa1E=@vger.kernel.org
X-Gm-Message-State: AFuF++lqUJorThVtXhUdI5MdZ25xp7V8Ox9dwnqhNiPund+qrtmT4X0o
	Ko6Hx0j6xTInFTbJZp8eEs+7Pq8hUDAOZ9qX6ztXno8DG2oUtxGKOuTOoEvBdNPlJmaISuqmz5h
	nmNevWPnTsBmo64P3yDc7UHuZhp7PJ0AjdMSCSyMDI29Nt4nDVmy6T1ITKmA=
X-Gm-Gg: AR+sD10On25Xe14IRFon2owmHYegfRUN0KAvVeDVPseEZLgFREGVlxwXvHJ+dIgoRzp
	2ozbtFj8uzXDhpX7ZS1jsVt+wz4cI2oZCheHEZPMEsLaNSibGXmxQQ+1kO1tc9Lb6ZdEqQneTl/
	IjIbcRWIY9Sk9Q/iVOO3SVtKPbHKd9WwbjX0RxTi4k4Bd+jQ9CJ+vsdJ9iEPsukmtg4dC2yQaxJ
	fYJkRAl01h8/XkDy6wNXzoK79+rVtY8LASJCLQTkH7nu1Ro1ZVy5pape+o2qET+QD4Ll1/q4SlZ
	5HH6qklWLxzv+AXsM7So3dJQfvaGCyM5D/fiN+1Pt7yAhlQH7/MClbwt6cGH0A/PtKPioU5DwwS
	1dNf+oHISeYwwVgJ12OVynm/zIw==
X-Received: by 2002:a05:620a:4009:b0:939:4b31:4669 with SMTP id af79cd13be357-9394b314723mr951627685a.29.1788278237990;
        Tue, 01 Sep 2026 08:57:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:939:4b31:4669 with SMTP id af79cd13be357-9394b314723mr951619585a.29.1788278237413;
        Tue, 01 Sep 2026 08:57:17 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:fd4:cb20:f8d2:dc94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d6eafesm5366057f8f.24.2026.09.01.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:57:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Daniel Drake <dan@reactivated.net>,
        Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: of: don't mark hog nodes OF_POPULATED before a chip is found
Date: Tue,  1 Sep 2026 17:57:13 +0200
Message-ID: <178827822449.38953.11000538311935272937.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260815-gpiolib-of-hog-flag-leak-v1-1-6126aac5f6f3@nexthop.ai>
References: <20260815-gpiolib-of-hog-flag-leak-v1-1-6126aac5f6f3@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OcyoyBTY c=1 sm=1 tr=0 ts=6a96f5df cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fwK54NpjPF0WMB8fScoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: nlIsrRBTkiGz7JbVJArow19Ii_uc0Q3c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0MSBTYWx0ZWRfX2FkvI1BNsRfD
 +oEQgk8PcbOxZu5j5NQiKFilJG/NDnMUKzkoXFUA6JiOUC/v69cgvxX0secZTutroR0NFkvh6yN
 oI94H7ESUHxTrDAfiQ37M1bRkct9Okg=
X-Proofpoint-GUID: nlIsrRBTkiGz7JbVJArow19Ii_uc0Q3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0MSBTYWx0ZWRfX5+vYyWdTsCVe
 spQjbDwWikNVYXiLDXAiQVfxKJ10aSPv6yr0OhcJwFeiIZA2Bjy0aO72HwKcfsXVCCNqFAG9qAV
 TyS8OB1eOVTFJOAm+79kl1GtFwNb3oH6g/ka1WzmJqp06xK3p10Ga4j+UK5/S4NquAEHeBJVM3U
 rLkOAywX2w3lglFWOT+hIgLgawCzD/0URuN05FQKMyD+IIvcLoeojYlEzu+ruPu0sPCaeIali7U
 BzR43lxH/o+WBpY82uqZwybmAOQ8vzWj6AK8+xYev0X0L7yrpZniFfAYUxv6hi3DqrXCGw2OeiO
 MhWnfkWbmvUFVKypdp7WYij9JajNhKcnKhhFqiTyKwxHhacdEJUA2mZZ3KA3rODRsB/S2yoM4g5
 d4UbOR2XFq9YQkt//w3YAXzVpXJcMQnBcfScKz6qQCWSbvZz2aECDhWAbscaS/QkTCo44DXPXg2
 0TuXKjxJEqxlO3YixMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010141


On Sat, 15 Aug 2026 13:44:19 -0700, Abdurrahman Hussain wrote:
> When a gpio-hog node is attached by a device-tree overlay before its
> parent GPIO chip has been registered, of_gpio_notify() sets
> OF_POPULATED on the node via of_node_test_and_set_flag() and only then
> discovers that there is no gpio_device for the parent, returning
> NOTIFY_DONE without clearing the flag.
> 
> Since gpiochip_hog_lines() skips any hog child whose of_node carries
> OF_POPULATED, the leaked flag makes the hog silently ignored when the
> chip is registered later. Applying an overlay containing both a GPIO
> controller node and its hog children - and populating devices only
> after the overlay apply completes - hits this on every boot; the hog
> is only applied if the chip driver is unbound (which clears the flag
> in the remove path) and rebound.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: of: don't mark hog nodes OF_POPULATED before a chip is found
      https://git.kernel.org/brgl/c/1f1d0812f6a8ab8e6f709c599f137c99646512cc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
