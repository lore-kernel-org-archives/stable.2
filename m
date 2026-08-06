Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397803DFC92
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008180; cv=none; b=qLUE55tHOBSyeZQfyIwERIZrGzSnseyMcmtj87bSQba6io+x2PfgiDXOzd0PmUm1N/nKpv066aZnp7GHCjP1OHXndTgw7nk2WMAFCuUcwUPZpZe/rTK4vei2o+oqHt1hHchqB4mBsWJyxKOzGp489Fl4DUA77rnXjIramvb9It8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008180; c=relaxed/simple;
	bh=dpY6Lb66UiiSVLUiNY/tDg0sHUc2lJJLguZEJbr1MoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C98x2lMAKQxzbDJeFdl8jS8RRoj8Dv2h7unZQnAQxrBSlZdXq0Zr/iK4Hb/TaNdgv6rWvDkfm/293yV/6Yu7msc+APIl8gymOTGsZTrjCGTsKrV3FNPoGSSb8sy8zdDhznVgo3r4WGXyRvZ3CBZDGB9k1KBaNBaXfYnwAxmsv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZ7bYg+J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AHHwx8bC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZ7bYg+J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AHHwx8bC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676946Gj1763679
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 09:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pqaJOMuddBQhzL/ghmNiBYFo
	sxA6nA8z5MJRgKzN+OQ=; b=hZ7bYg+J44WePbSRKs3FnHZFEgbIN/jkIDqJ8XQC
	+L08M/+kxTzNBjfrMG4Sy8404IJu57fv7SKb08ehY0Q14n0P1gowFrGTwkHXlfNv
	KxlFBdj/yd0kAV9a/U62UTrpHs49QIWX7TsbzxlDKhHkGR+GWTzgAx4ogVzK4Tg9
	lnOJ9Rck66Yn5duz94gHvJY4No1f3WWakYjmYZE+TisaVTX98JXKsxPpsX8pChGC
	Jw+NbTtnvR0GaZuSvdjx3nFw2nwOG+i5fH5nn9IFs7h3oIkATwxak3y6lne8xq4D
	ej+1YvK6FCJsGxjlRRC3NnUUcuwFKvNbDMN5IYra9SY+Jw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjud18kt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 09:22:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8b0a08d2so15146851cf.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786008177; x=1786612977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pqaJOMuddBQhzL/ghmNiBYFosxA6nA8z5MJRgKzN+OQ=;
        b=AHHwx8bCacVpVjVJwaL9lWDb5/zZR3+m3IacTstxDLcatAbYhjIcAZEUiQi8MT2WO7
         qwLXsZ1/aN4E1FTeUG/9UrYf0GSpbtAZeqbHeDpTUuvqJKhcYbOp7nL55yqdbIgUdPWv
         /q3q9ZJVghhtrBzmWmVa3O3o7xVdcAnskZfnwNNPvCUW3uHgm6y1XZRmqUi40VLxVndY
         PmriJviivJ0tMPiCMhQWzXp3AiNPPTE2p1aMQOlA360Fx3vGZFLwcF7vwgDFUzBtah3d
         jKaQigc5Ja8kwH262HU+BrTaKc5gIKcGeKo6MwxREJ2gokRP9sxFRwq0i2WVt0IL91nN
         qw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008177; x=1786612977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pqaJOMuddBQhzL/ghmNiBYFosxA6nA8z5MJRgKzN+OQ=;
        b=Tx5pUdbbPDQ6Xy2RNS8fvUwhiSXL9k7NqxEdkvGiakDqDPiDvE1TtB3NCnViPy/apN
         FZ5WKX09QqrqglBp4hksNwQrl5rbVUT+l8NqpkZtegsv3kJxofvgezVLl406g6iFXk3v
         9Zvpn7Bv2156DoQ5rvULzQm8cac//wz9Nx5l/Aj1jumVdV4RR9DGLgg+APdN342P5YVp
         iTAiawtc7bEkmTkzcxGhyoQp7X5EtkoGIERIerZ2UF8jcqHvvzkvpptSEKW/0Q+FYcfD
         57wtPVWN33atfge9IQp1U72ykcHtcjD0KYwOqwokNm1ogWphOlS62RoBaTdU31jluK4V
         1OZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5tJk/FUR9rTqvpe318xNBSJ8EJuMvbS10a+fYOKdHRKX1y3oeJriGbaO8akDi/BhXBtXNbIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLLLB8+dB0CiuSiwwgby7hftZzF3TVYUG6Qyjnb6LmVvAkd+4
	KEbDjslPpVIH4qy1SbXj/a3fqmB28b1arxk0xe4HMkvMunzGJ3JzMgGk3gIpE5iAy6z7DtkHnqB
	sQQXsuYaYPgC3C0k2aVnipei2HLNjQ0HbLxuJYuumXyFCFVZZ+5VqVk6w01U=
X-Gm-Gg: AR+sD13/Fb1Z4iTPXvQv9yJnqux1UOsVdrOOPLiw+3bcR6ml+NkB2SrVnXQeRzj0D5A
	MGYydFVXkh14kpYfyIbu7cP1GO8eTuFUP7q43T7RFHduXyVbf2/Mj4N44VwU3IVfy3JYCyxYSbx
	KKRGPkYypud7APSBr2grPDzunRAE2rfzXeB9sb6qGKB0zZnANVQ3CxxlFm1AGGVmAGc2rhgQb71
	EQQ9SbnLWagnNF6TxmQ8iILTZrQ0+ESxxfORUnNUU3dURqmHHAeYL+fetOb3icz/fNbUwb1snah
	fUy7Np6Y2J6wxGFqo+ntMxH+E0vRd2e4CCsxmaOy+T3Q71SSbDJ9bjNY9SGpkMq7QjLHH6/1idr
	W2YA0oa9kOFKmSWNqUrgBJ+vvE1YnzZwc5qnVrz+zk8rAb8BmJdtkvD/sLcSQw+1lcqemBsLEXE
	9SoNFt4KGN5Yc6ew==
X-Received: by 2002:a05:622a:4811:b0:51c:22c5:daee with SMTP id d75a77b69052e-52ce6133c6bmr146671511cf.29.1786008177280;
        Thu, 06 Aug 2026 02:22:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4811:b0:51c:22c5:daee with SMTP id d75a77b69052e-52ce6133c6bmr146671171cf.29.1786008176819;
        Thu, 06 Aug 2026 02:22:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fb9a51048sm14086691fa.36.2026.08.06.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:22:55 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:22:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context
 bank subnodes to common schema
Message-ID: <zqpgl3esozn4dgnm7remmwmquxasyc4qpyh3fgcdfblmn2xe3g@vhp5umdahvmi>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <20260805-dark-voracious-jacamar-6aae4c@quoll>
 <7a546bc6-a2b4-457d-ac27-05fc1cfe17f5@kernel.org>
 <m4rccl6zsdzmkzntc3njv3uczcppva3passjr5ukmru5q6rylx@wlwha7ydttfp>
 <163c24ba-6b78-44bb-afe9-3dcbb4d47475@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163c24ba-6b78-44bb-afe9-3dcbb4d47475@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3MiBTYWx0ZWRfXyK0zQWN3HGlk
 uGseRAdEcC/eOvGq762GDqOhtvPQM8unc4SMWOaXGNR/MgNs+1RJ/733LMrJ+/MqXnIqt5Wnyt+
 v8R0jbjI2Z83/Bqz7YrsTKlzNonMUQnPYZwINRPFJgs5HczzZlhwBwEO/7V8i6QiyOZXlXSGOK4
 Lb+1kHkoHGSih6GsGkVFg1qARpwEUcWv083LX1/uPK/rCFC0/shug8xxeG1xfbLKrATVKD5lRCB
 Thljp5ILuox3PnrfiDwbh0kn5EfG/GhOumSUO1zSq6TX4jqOjayC0WLArmfWBots78CuX+YVLDm
 AJW/t6lrUgbDXJIjjdV4RP3wrhjN1HkUcg3HoSfRjW6Dj1RiY5Dbn16PGCloCvh7A/Y+xwcexvJ
 nnitWHcnaBbs8z+tFPh43GyxU1J6VGdzxIJqFQiHR1qPSRy2PQfuR+FSkQweb1TTUOaQXbOHrg2
 AJqtEYKdDy87UgWXfFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3MiBTYWx0ZWRfX9IEAE1W4yD21
 LLTMq07+0qyxIAQ2ayFkxzuOD1/do5jXYgGMDeyBNVsZeENL+Xjb/9sQiX1KM+HArtcmOcQJcbv
 PHmrff2Rw5UbXLTY35SqRL78YpFpGBM=
X-Proofpoint-GUID: JjrzScg_GR9EKxr9Olpnqpc_vag9V7Hy
X-Proofpoint-ORIG-GUID: JjrzScg_GR9EKxr9Olpnqpc_vag9V7Hy
X-Authority-Analysis: v=2.4 cv=DeInbPtW c=1 sm=1 tr=0 ts=6a745272 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=4vcYjQK5CgZr8qocVmwA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060072

On Thu, Aug 06, 2026 at 11:11:09AM +0200, Krzysztof Kozlowski wrote:
> On 06/08/2026 10:46, Dmitry Baryshkov wrote:
> > 
> >> dma-ranges tell how this bus - so venus/iris - performs DMA translation
> >> in respective to parent. Address/size-cells are obviously also needed if
> >> this is a bus with addressing.
> >>
> >> But there are no children with addressing, thus what sort of bus would
> >> it be?
> >>
> >> It looks to me that having here both:
> >> 1. dma-ranges + address/size-cells
> >> 2. children without bus addressing
> >> is some sort of abuse of the DT syntax. It is allowed, but does not
> >> really represent hardware.
> >>
> >> IOW, dma-ranges alone feels okay, although unusual, and it states proper
> >> DMA translation for this bus. If you add address/size-cells, it means
> >> this bus HAS addressing and thus YOU MUST use addressing.
> >>
> >> If my understanding is correct, then solution would be to add addressing
> >> to the children (so unit address and "reg" property) or drop
> >> address/size-cells as Rob pointed out. [1]
> > 
> > Doesn't dma-ranges require address/size cells? In the end, how can you
> 
> I think it does not require, at least how I understood the DT spec,
> unless you provide actual addresses to the property.
> 
> IOW, this requires address/size-cells:
> 	dma-ranges = <0 0 0 0 0x10 0>;
> 
> > specify the DMA address if the device doesn't have addressing at all (or
> > MMIO-style addressing)?
> 
> Yeah, that's why having here children without bus addressing is
> confusing. I would interpret it that, children are not on MMIO bus, thus
> the venus/iris is some sort of proprietary bus with no mapping between
> parent MMIO and children nodes.
> 
> If there is no mapping, then we do not have 'ranges' property. But I
> could imagine that such no-mapping bus still provides access to system RAM?
> 
> Actually this feels like a huge stretch, so I tend to think that the
> only reasonable option is to have children with MMIO, which would make
> it explicit: Venus/iris is a bus which provides translation of both MMIO
> and DMA addresses to the parent.

But there are no separate addresses for those subnodes. Would you prefer
them to duplicate the addresses of the parent node? Or would the
'ranges' be enough?

Or, thinking about it, if Venus / Iris have 32-bit addressing, then
dma-range should probably define the limited DMA range.

-- 
With best wishes
Dmitry
