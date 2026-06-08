Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA3390CBF
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903841; cv=none; b=h3PzX+TD5G93GX8Ad1b1JUdfC2+4w9Dy2DC9RSgi/rObRe+uFhkZqUHObOs0fXaOIQNDKXfemlYMpk6yWKMJ6uZropOFeZD1FKlkgmhamD5hGe1Fles69MFcXcKDcUE2g3nWYQA/mmFbHt7YkMGbULVoICFTCE0CiB6yrW4HkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903841; c=relaxed/simple;
	bh=OLbqaMw3Aqu7QeHcuZZflowEL27vVtAncYyeTSxawO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge2ppIQOXrOY9N+UiPYaLsd6AAUp100Oa1CejI9TPxWqdzTqkkF/eOsaxTbb0VbRxbDorH4lPIS/vQ8OVkjLZ9UN7x4Jjh97hhSmsVluU9AeXGLnmQIR2QPPFhyikDDjzaRQAQEooJLn/Brtq+WnV5Pik5Yg8lH1JE76AARo71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OnDbjHp/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ap90dUQX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OnDbjHp/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ap90dUQX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Otsv2384520
	for <stable@vger.kernel.org>; Mon, 8 Jun 2026 07:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NOB6PzJKBKCAB9iTakZfR6X+
	Qsh3+zB9I23qh+8RjR0=; b=OnDbjHp/k4F3OTgAI2di9svMWYMvsGfuj2JuJpkN
	ApcmStw6/dloyNqntXpNN9/P04dJVNfVQZ8NgjeF23a8k/uZ3uqnRxoJxrAfObxD
	8CHPLb5Gdk5ziBPR7RTnKlUSbt3pAvUDuYmS4oVVpodCD4UbtrTrgH4BTFunM/fD
	KVuHmMWQoN4aIGWJS8zxRprcbWXx4AudQTJx62xAhN8H5YTaTwRjvN5kH4jdiRo+
	q0KdilzY1+8pCtgifgu9e0lOQweukGZmKoUhnDjGdIrM60YQ8Vxk5Y/GcQfZ8gYd
	rjffU7AW9BDkJXVzlNQQ8V2ORPxyZ+TF9dm7YBr/WJL4yg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1ee4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Jun 2026 07:30:39 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6cfd441619aso1559134137.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780903838; x=1781508638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NOB6PzJKBKCAB9iTakZfR6X+Qsh3+zB9I23qh+8RjR0=;
        b=Ap90dUQXcl4j74ZoGiBadJTWjYSljzpexr/YEYMpwZJ6FgDDnKf6ks0ST8Ij8h7Frs
         N2O+2ftr3/V8r/lxDkncCOvdnNzFJaMUuVE2hmU9CRIQ/jGq8jpm3b3xrx1/liRRNVD9
         A1I/WqJsBYEvaoLHjEpRwA7/OSGdITED7Pu5DfbtN7o9BVA0rdTAH5TWilcBPV6MeFqw
         XcePP/ouitqrUKF7tvDFITJm9Cm4RUXPU3aGZQw/l65MKBum1h+pECM7ttrZU/PUBJZ8
         zI2PG/GEPW+t41EI5FqzV8iN/MbPSWapOXCHuHiKj6vHIFq5mm+NLkpgnt7ivhLz/7QJ
         A8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780903838; x=1781508638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOB6PzJKBKCAB9iTakZfR6X+Qsh3+zB9I23qh+8RjR0=;
        b=HTFyipF41gwtiK5czmqByO8wBKhjbCPk2NWHW/B8lyqSEQ2isKrn4HTLhovy/LN0os
         JsblfaGF+AT8FpRh4xpYjO/AvfSBP27Emdb3MSjLudMnynvHbfZbCDTQkmB2KAlQK/eg
         g6cTr7/c2tDNDb1BVJ4IAJZteyxonSv6G4r7SjAqwAazfDh4TssDkhP3ZJ4bwVGujZsC
         jZ/THyTcCklBwcLGu13bq9SlM9A/LkdTS/tZ762ys69ovjX4vTADmOe3HaAg296IDLqc
         hfxO2QelsChWKl0Ak+lSEJYAZ5kOUFkUuf0IdOxyneSDAPEIRxmSD/5IOjdDN99YZuOx
         VSeA==
X-Forwarded-Encrypted: i=1; AFNElJ+rlWY68Z1VYMPhsgPlJYFuS0S1zYQWoip4hsSV1vMYFwnmNwxMFh+Qtj0QPfCQ0kUyLwz1at8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGwl78VqoYVp7nCiemFDm7MUZpWGx7mI2FCmaimwU/lQX7w96
	BprBL2+lLi4z0tG2ZIGLDkdeatXdgncY2cbZAGRiyfnQ7Vn/q7yuKs5vnhlCQh7Fe+316rio0J6
	lWJJf0CXiu6AS3xL4cW15iN7ngG0lbZN5V5uENe0CfxoJi4Pn6bUG9GLt4c8=
X-Gm-Gg: Acq92OGJbpp6hN0kQGVnw/5SvsCeIOV9AUacLQBTP1V1qV+gy2/hD2548eZIQn9cIVn
	zSi6QcKvlLLicizK4bSHYrz4C0DotQsvCawVNCyIHcH6UErMXvFZNHQRiXZd2vrLXKbty5ihTTE
	U6whe0p1KkLa8y1x0PyseHylrgUzHPcCt4wpPiSfiab9kk/wTB+wr/LrW8M1peIYdzi6UCnMR4t
	Guhk8uyM8Qz2pcvN8G0iKwM181vS62E3GxdG+avNsx/qzx6k9omHk6ovTkl5Q8WTk5lWqJKYfp4
	DZNttRhc+odW3LsfTzAtxnBSe7eDfiKqP0VmSNHdLeVzEZgWTMNSYOBfc/5JnSSAyuxsYl4LEt7
	5wgHxIO2Nnfk39KXKD+WTSn4FIhUxaH2K7PhLaLwfOe7FbXalw7AgGRKPAqJy7f0iFRDzV5Jo8g
	CUlS5Wn6SxnWYVTfh4uBdMSjsuzEEXRltuQ68w20J7HLTWXg==
X-Received: by 2002:a05:6102:32c3:b0:639:3b08:d64c with SMTP id ada2fe7eead31-6fef353f3a7mr6149008137.13.1780903838252;
        Mon, 08 Jun 2026 00:30:38 -0700 (PDT)
X-Received: by 2002:a05:6102:32c3:b0:639:3b08:d64c with SMTP id ada2fe7eead31-6fef353f3a7mr6149007137.13.1780903837833;
        Mon, 08 Jun 2026 00:30:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b904207sm3590321e87.32.2026.06.08.00.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:30:36 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:30:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: take fl->lock when moving mmaps on
 interrupted invoke
Message-ID: <jjfpssvbbhbpxcx5z3p7r7wcowcokscqfjh2jmbqgmjra3ibp5@a5fxebdiwqhr>
References: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2NyBTYWx0ZWRfXyXPZ0OeydjXd
 heGHT6QoFNcXJVmW4ZoP03UDHF+CmRQgai3Xt5bhuFCaEPeA/AIObtWbPulCfbJdPPukdrX0tzB
 0kvCt9OwyYPrT+TOuLLA5w+rRyAjBblR6ULuSy60zR4ppqeRhQuB9rWpM/dDkB2bQFdQP/kxtZE
 PeglS0ymnm22gyg1AgL5eJhdaOLG64UsrtqPuzQrDmNw6eBlwCOxQjfMp0ZOeM7PMETLFB27xC6
 PlZ7iDuztPcntJRNM/q9woMNDeVRsQ+0trTboTXhyec1JRj1BrmIXM9lK3jZ6laN8AFgD6aVu/O
 8AZgQtkRKK3U/YmlGs+dAHvqJhnKHNBVzOukvu+wFIZ2JoqnKSiIq1OaF24zbj2ijW4xH+gblIG
 0ocSHQNKLl9KoPgHqoBavC1Wu0CSZCMewXU2lGupiLKc5aQALHU90/YaGkJLiYmAyXlZ27bhY/o
 BogVwLsI/8pKwpyv5HA==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a266f9f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=2y4kR7mgpDsC-dX1eGkA:9
 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: jQMrQdONufwk1K5an1FO8x3-zJ1XKyyY
X-Proofpoint-GUID: jQMrQdONufwk1K5an1FO8x3-zJ1XKyyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080067

On Tue, Jun 02, 2026 at 01:29:58PM +0800, Junrui Luo wrote:
> When an invoke is interrupted by a signal,
> wait_for_completion_interruptible() returns -ERESTARTSYS and
> fastrpc_internal_invoke() moves every buffer from fl->mmaps onto
> cctx->invoke_interrupted_mmaps. This list_del()/list_add_tail() walk
> runs without holding fl->lock, the lock that serialises fl->mmaps in
> fastrpc_req_mmap() and fastrpc_req_munmap() everywhere else.
> 
> Take fl->lock around the move, matching every other fl->mmaps accessor.
> 
> Fixes: 76e8e4ace1ed ("misc: fastrpc: Safekeep mmaps on interrupted invoke")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/misc/fastrpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
