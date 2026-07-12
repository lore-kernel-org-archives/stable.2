Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B826ACC
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783817163; cv=none; b=bR5CcGVBKw6191LICvk3A77hOo8vQsM1vMNUNxQDnwcpxWoXi6qRWff+Lb1k9OTqvFsMpQdTFluLk3lZM0XalugP8Ws4Etu8ewj/Vr3pmutE4JYiOCJDCRuI3kdQKw/frPPzJ8kwqBh+926rqmcmn3eDjRDXrqvNEqfvxiQkFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783817163; c=relaxed/simple;
	bh=exKrWSzeT1zMMDmBW1lsCVuCxYzfXeBz+wkkJ6+4Yu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpG1rEaVlRS2yYCVKdiQFOAi7d5NOgGsGA5kZL19kdt5VPZ5qM+VmA0ksHwMMGy8dHKemkddwYN7a4/zAUaGf3DqzV613w8wZCPsr+e3InlC7uJP9R/5qU29B6Kz2T//DR5yM3wovc6wtSXjbUwvmvOeBJ+t+Qt5/YgTU1KS1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSGCjccE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dw9UejNL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSGCjccE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dw9UejNL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66C0XdA91169958
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 00:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7gHjJ+2EaBeAOmvl0GqD5pQer6kwe0Xbvrh4dq2IQao=; b=VSGCjccEVbj3T4eJ
	+evFqZxaqyow154y/NfprEXiEr+O9rpH58vf++RFDafoeyXyPjyyj9Ag4i3SocXv
	AfrFZIZwOOSnkarYjj4/sEWylp32XfF1WHQMo5on/Ga/7TAeBQP8AMTHZzTu8MYK
	rObZsOmF7x9KzRoVucG4U45Sb63AAXt64QqRcCOoTOlZJaRBvhVRnK1ve9wn1mc/
	691OsU5fSQFszxi+OfFytCIzYcqlO7JG6WMe6t66Z3YzmgOLa+qqRP7ni/u9RVXI
	4zAK2VlXBzt+/1PVlzGxVRTYCz2l3oKEegbnhExsgi5D6m3SkuQfd+SdZLbt2v5l
	xPNMzg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hhx4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 00:46:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce870a060so38860605ad.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783817159; x=1784421959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7gHjJ+2EaBeAOmvl0GqD5pQer6kwe0Xbvrh4dq2IQao=;
        b=dw9UejNLMjwfknAx5ZoAyKTtUS1V9ZplY2H/Kw86HwKcRMJaL0EkPe0v+mM1O52Ovm
         6HPvBtYPM2WHLS1EHYK05nCZ8vpH1jIkZJZq4nBcmK0U6hVNU9hU+jnzHlZ6yl6CQXhK
         wW/60YkPvRq+zmYAgTVgHEkMu3WRh4nouj1VGn5nWG3hNWORaHNSsjFapJ1QM8fyelFt
         Xv8c3xbg2yLu3tQLvRtDk/bYcvqEHm2NSJrVY2faKdgB4pkho6LM+zif7hiEFFErBdDm
         mk1sI3eJcLZZ0yIRIrbvdScsuaJG7hYvwhAmF71wQPFGeX3y2ztqGRWJFr39WMM12j18
         2yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783817159; x=1784421959;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gHjJ+2EaBeAOmvl0GqD5pQer6kwe0Xbvrh4dq2IQao=;
        b=NPkmFeyOZllh4rr/Znix9rWWh510/1P9ziA/ArZyPyRdZKwKEyBnIVVQtprWgBCqAY
         i5RpyTGxnslx47TOoAnK8KGcKsvr4+fjSw6+aPuPt8KbbOUvqNhimDxP8bR5zq/xfSkg
         Bw6yvdyZ7WKHf+U/TYTWlLMxO87+N+vd8IpG0e0fi69DSAfCD8e6VlZ+1ndcDpY+iRnn
         UDKoitjUBWPIfg6P1m9bWy2VVjTl/ZnbKQlgaZT6n3AibpYnT9N+6tKg5jaimFH6XD+j
         2IN+taU+zIf13/eza9+zegrvshR9xsPwcMUXx40f+cw5VRWn3qt1AguSyRG0twCW+s1L
         j2xw==
X-Forwarded-Encrypted: i=1; AHgh+Ro69cucUxSyPy5Q1ozyYHCzTP7l4O5X8WKrTK/+n5sjTZemnYTWiYz6X+bbUdpqxYgLAPodau0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/DftSF+nl7TmmLt1QiA2RdrZj+/wtHDinXL47wwHpdVUKzAX
	aNsDqGisGz+VzITwGZE+hcPJr0qrgJZ/e44U0EwLlHFfUoTdVUf/XeLLUTeVJIxYk6UaThzsXth
	PIUrlcXttgUYGU5YtwK7s8vreouoAo8M4PAfATwwwN/TMlJKiCbn90K/IapQ=
X-Gm-Gg: AfdE7ckWWHUD1VkQyzeq2cv6GVt306sUNeYYsyOSZ39gxqFlMXOAPuKAgkXcbTTb3Ze
	uRk1V1vvo+aqUWqp4Y78/FXN3LbaZ9z6sf7dt25J00fHfFSatQVAgmhz+Y87uLARbSgllAhiJML
	pE6Vg+BcJQDIFawAsMISbMiA0IDENP/cwkhISVFOYYykfR3EJF/tU9L12H/JoKwP6kM+7UQkheE
	jI4VvJW8HUunb6Jh8TkKGCnIfxz/ZONs5c+D++hl9MLMg6lgU6BGaLyyvDS4CEmm+E7aM5k+Rmq
	5OgHwQrmkmA04V2XMd6LGMnns4dPfza1JSlhlypuzM3yjfJllVYWqp77O6+rB6OaRtSJjJs9kwF
	U9NB4BTVqeLC8/d3+0dJ6O3nPbSY=
X-Received: by 2002:a17:902:d98b:b0:2ca:75b1:e1e5 with SMTP id d9443c01a7336-2ce9e79f444mr43780855ad.4.1783817159391;
        Sat, 11 Jul 2026 17:45:59 -0700 (PDT)
X-Received: by 2002:a17:902:d98b:b0:2ca:75b1:e1e5 with SMTP id d9443c01a7336-2ce9e79f444mr43780685ad.4.1783817158937;
        Sat, 11 Jul 2026 17:45:58 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1ecfesm79279595ad.47.2026.07.11.17.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 17:45:58 -0700 (PDT)
Date: Sun, 12 Jul 2026 01:45:54 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ariana Lazar
 <ariana.lazar@microchip.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: add missing 'select REGMAP_I2C'
 to Kconfig
Message-ID: <20260712014554.0032a06c@jic23-huawei>
In-Reply-To: <20260708-add-missing-regmap-dac-v1-1-e5925fb1fe23@gmail.com>
References: <20260708-add-missing-regmap-dac-v1-1-e5925fb1fe23@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vyS0_UPy1c9GxF4xVLsUNekEGp09zEpe
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a52e3c8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=j3typ809paJY_mESA6MA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: vyS0_UPy1c9GxF4xVLsUNekEGp09zEpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDAwNCBTYWx0ZWRfX4ZN+vYgFTLBM
 A43hh+BQlgrFlLMQW/iKj9I9wIQjpyPVlwJg87d8GQdEdS1hHTT4S/aqKnHXy/zgaRP4SQ1zBLZ
 rBKvw51RiGtkoIklWyoOKoXp/JpaL7YhbjbF6V6def7/nrIVHILj+Hn23AV2fRMuAfNqIw4czd9
 fOtF/SjsTgA8v9oC7URh3dIj2+i1zg/iimAgidX+AhcuRYhXIucst1ejUFIsqEO7FQagLOeseOV
 kMQKK1Q4S/6cYZGdcbhp+lFmXqbeiz81LniduOEatjMLNBF5Z1M0Ka6LrBbhPrcMpBpaHdsEZan
 vy2UxFDHtdxcc3nO2GXZh17jJ41WQMefHEzmPp4uqq1eZlmbYWAlx+rwTukTfVx/UNfYHb2nC+0
 tIH6C8vbzqcgl+BcmlzU+piaZ1xM6rgvgfhQlui3u7lnsox1FW/qFTBi67ff3UFviYSlE8NYAss
 BETAnpSOMuSsCmqMWkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDAwNCBTYWx0ZWRfX6ofCgvM1i7Cn
 ENnxCR/BXEqPfqcX9wX4YL82ieVgFFY4vjZYq0Gh25kugcvzc6Aw98zFdu790y2K+0JPcT7OW+j
 zwRovoEQRTf5nkJjas/JN3xsHkfUBeU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120004

On Wed, 08 Jul 2026 21:50:28 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The Kconfig entry for the MCP47FEB02 is missing a 'select REGMAP_I2C',
> causing build failures.
> 
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
