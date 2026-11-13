Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566202;
	b=A9x1d5GEBEm6kr7hwKC6U9QF9zoG0xhz/dDqcfPuIxDwnHsFFfX7Q8zm0uy9Ag4behli
	 RG8JphdQa/0ejETfhTqmwuBoaHxyrkMThvsa7M40ql3HU0fCibs6asM52Kt6z8yN0wBZ5
	 /wBQijtJypVAkiJ033l1lnQiKUW+9Bd+N/mHgN1ztP/4YkYNUIONJiC/RF/Bl1d4fJRwZ
	 mtQKrYVvu7uNfzVICk5QlRRERUbCgJhqVbawGX8BL7uuOCy/c6RtEhDQZ9nsv1TbfRTjG
	 x9HGaJ/ZHdPraIh6uZF7nycAffFvctdnMSgyf7UiUA2BcLw3v55KN3LJdIu7vLCSuOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566202;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TgEeUGxKovhjdSPgMfNKjzv/ECDclmpQx77zq+F5dDo=;
	b=N5JJ7ZNGF+Kpvv+5k08xcikiFwC2Xb71+2onKC0yIgTfHaMOeiwH3wBpsEug+ST9iHW8
	 iFsVApRXxR294D2k4rdnjs/RNvtMHGaO+2RZMB5OA8OcxTS6dhvXTjdcvyVZ2G8YxMkAK
	 ZPSqIdLp+DzfGXiOQI2ANoRF/yIQyz/lbmU96WVaZwX1jErTHn0gUAs8kdkyHj3iMa7vW
	 ph8Y91xDC3AhKd/nvtbOGrHjh7X3GhHhxbARRLtqhxzEiMIlqkEy0aAk91/MQ5hiSyKST
	 LqlWt9aICjgHDJmDUC9faHgVHbpoPqZ2LqLNyB/mmfu0DZRKBodJAMc3EkekgZpjspg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="j/7a+IS9";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PiowsmQP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CA606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 921CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j/7a+IS9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PiowsmQP
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VNIE2515782
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TgEeUGxKovhjdSPgMfNKjzv/ECDclmpQx77zq+F5dDo=; b=j/7a+IS9KtkitUm0
	U1+X/l8qLCEiqyzcHkRHohx/+V27/pOSHXufcbXOhYb5Cf7aY+kXWoXo+DkuYTn4
	kJVAz3LQb4zZwjCPgcUI2gQaQlZin/pVm159XZfcLdxAvzwbA8NyRRwF7rMtc9aI
	c+a+z6iqpLG9LofmYUb1XrKptwnvCFNnogv8cbKWWSh1k6nwe9K78yOifiIB4Q6l
	Rr8FordHS8ZGSndNN6Re8C0bCG/zF0k4MYoXyKJD2mE7+sEiavJHeUYV5OKBHhmp
	zffdhLnUtLiKpmCDlhUur1VHCHmOKjG/GOpub3B143sCNUs1bS3vevYmVvu+4QJb
	QdHLtQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bbmvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:36:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so170964985a.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794566200; x=1795171000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TgEeUGxKovhjdSPgMfNKjzv/ECDclmpQx77zq+F5dDo=;
        b=PiowsmQPFtDtr70+mcK7MuRPkYINj/1HEbrIjya8GuriBX7J4N6U4aKLnALQaKNnOd
         PFkf0amdCH3/U3VL0wg2iZ7bfvEuz3NqwbNoCQryp5wE6RXgjQqfJqWS9Pt+m3LWUl6c
         i0tRWRqZGbict+OXi4OIDtDdpw0tCL8QuSsGB+FG/W8d5pysc9rwEe3B6G2FIo69lUYG
         GdX9kYO2LEO3Z/sUQmdoc4u7Zte1zjPvLrcL517WOKcpJvfHWL2oDlskjN9iGDnWtx7U
         RX12fMtoPRcw5uMl1WRdkkOQ+08ng3OfGjKMxSCLHnV1LmxAsBFpUb9NH8fnXRJdmqT9
         Qz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794566200; x=1795171000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgEeUGxKovhjdSPgMfNKjzv/ECDclmpQx77zq+F5dDo=;
        b=HIelQ6CCrogre9vFPJucEJ7cOqw9TI3yktrJ8urMjGIt+L7EuBRI5CFqmdU2wT0SuN
         9FrXmQMPGhLxxtjPGjegTAYGMHOMkt8bLjKsSsQfqaqQFbTZYj2TjUQdpgyV6t60PjAJ
         x/w5wqJnGRblmTQwY1f2vrKY3Y2m2Jg9LALNe2gHcmt78axqiFH+ghkN00VoY/QkoXE5
         kVQyIQXsjRIQ9WnIRmxPuWjehcvdO78NPF7ntIhcG2t+T/C8vbPE2iNKj9946vpVlFO+
         cEoaSNp7fXFyHOGZ9Lh7bUMhY/445YrGKNJT2Zh7Xd2k1enF5Fq3AStYWk5Lmf86331v
         yjIQ==
X-Forwarded-Encrypted: i=1; AL+hErHQh+klG7jMxgKxVjndWYzeo+rGN/pVgDbk58ucVtqogpHHVC3hBWNc0G7w+oern4zdY90kUwU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N7e/KC0eD26jKsFlcNqUVq1SF/3XKx46zfPUn46eZD2LlnRhp
	8+muOUtEu7y0Shq6ml8Ff7EDHZHwh51/t5HHjXNBoEdeOfD9wpKg/Ds0O5nfJtmpNbg3R1btWm/
	EjktAKmH3q/df10cCAcakgdYhMMsyNUiZaIW8EGdV40Yb60FdTfw1N/xLrF4=
X-Gm-Gg: AYBFou3bPA7canaXrrmkdoH5SeJhLp7RPCDDv4C2Jz/mx/pUf6JHlwNVR9IPsnMJFmM
	oiFVgUCNwWyQwsxr/EHVUE8k5demQC0snHArGuYy3dVJEMRsoB2yiT4da1XE2nlflWSftCh1ll9
	kLvOqHIAdUYNUK16bv8UGQ32GxXeFE8onNAJ2lyjezgdca4O4pW8l+Ce1lzA1EZPx3TVQSmty2L
	7IT8ezEZFlU38Li3YM5b65r0jndP1iOs3rvj1IAmQAfgpCw7WgmTq6PuCNQe/5R6UY2e6DcBkL9
	VEP/qCWBH7e08nDNXNGeC78KFoSphPSrMquc35Jo8WQLepGgcalMAPPKGsBSpDbkRSuzFiUp5Gq
	h7RZU7aFreT3BSfTRRhTrnvKT8nHfQAdCXgb6IS3MsiZvT9dRXELVGLg0F+RZHQsapQQhraBZOi
	3B
X-Received: by 2002:a05:620a:6290:b0:93b:d79a:c45f with SMTP id af79cd13be357-9494bc2f497mr335809885a.55.1794566199809;
        Fri, 13 Nov 2026 02:36:39 -0800 (PST)
X-Received: by 2002:a05:620a:6290:b0:93b:d79a:c45f with SMTP id af79cd13be357-9494bc2f497mr335807185a.55.1794566199260;
        Fri, 13 Nov 2026 02:36:39 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d22394esm4672388f8f.3.2026.11.13.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:36:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 0/5] gpiolib: improve concurrent access to the flags field of struct gpio_desc
Date: Fri, 13 Nov 2026 11:36:36 +0100
Message-ID: <179456619466.14668.6243591882039671593.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
References: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af6e838 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EyKgIFjRM3FL70iytX0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Iqop9ThaJUWRgMSIMnkD8Olnm9uLKQhy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfX7vW8BQ0qVOBN
 KjXIbsA0YG3kaJbxWMAMmkKOLQOU5gTxVtcZVYAX5On29N3XG55Hz5WSaEZFnQbxlgO8I+X0Aay
 qRkx3ReOVsnIQKXCezVCPzcdALdpXJOsNXczjZpLWpGUi5vV9+csGU/CVRbMF8rOFSj6nudf86e
 nchu3mPa/misCWD32Go78vbdD4DuJdJ5rZ7+t3+sFKTnSbZi++wN8z0m0Yu+KzIVf0jtzQffHy0
 mARWbnhoHeiqjEt18WLmtINyXBx5FFP67XDXg+t0KLihjMO1fAnxx85SIWCpAWnbHzcxzoaIxlz
 S4GY40tWRnwi0raLtjBhMCZq+XZuFCo3DnElEqAHMklJdc7vgFntAEcERX/PVRLyMTTxB4r7Pri
 5X96Li2MwGz8etvYfovIsPyHdTAQPjXSK2E9jghXc+H1O1rS6AwzV+saq1vYlY1/uTlA8tS+L6c
 7y2jPUxiH0IfjXBF8KA==
X-Proofpoint-ORIG-GUID: Iqop9ThaJUWRgMSIMnkD8Olnm9uLKQhy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfX47EVaimZPKIt
 S3dCLwbMaxeAGFQBNt7hqkorZTOr+ONys91UWKl+u5+KMYvfKAAIVuCHDsYHbTljJkNxydC0wOk
 FBn5CJ4kISf1KUwkelgLbWXmIXq6RqE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130042


On Tue, 10 Nov 2026 14:47:00 +0100, Bartosz Golaszewski wrote:
> This is a follow-up to our discussion[1] about desc->flags and possible
> races with users who don't/can't synchronize with other means.
> 
> It's an attempt to use try_cmpxchg() to update only the required flags
> atomically where needed + minor fixes using atomic variants of bitops
> where it makes sense.
> 
> [...]

Applied, thanks!

[1/5] gpiolib: don't overwrite the entire flags field in gpiod_get_direction()
      https://git.kernel.org/brgl/c/8ed87a9adf48703b5729f9d020eb15fa79ffb099
[2/5] gpio: shared: use atomic set_bit() for descriptor flags
      https://git.kernel.org/brgl/c/7d1d799d6251bc8cd1d5cfc881b0c09060b6b90d
[3/5] gpiolib: clear debounce period before the "requested" flag
      https://git.kernel.org/brgl/c/8509d643ffb7be508568c696c9fe45eb1f84c33c
[4/5] gpiolib: don't overwrite the entire flags field in gpiod_free_commit()
      https://git.kernel.org/brgl/c/63d7aedf6add8a24415af4c010588f63fa7296ab
[5/5] gpio: cdev: don't overwrite the whole flags field when configuring lines
      https://git.kernel.org/brgl/c/fa8bc4aa06674e78a4ee702966419aa4fdd8dc94

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
