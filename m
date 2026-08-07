Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F83E638E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097071; cv=none; b=fFRaL+omtwbseBDgRj1RkPhBOKsBsIcOZk5XN6o52JMDkTs079WVqe7LXn9azLcDj2CDK8qnBufc3e0OfnY2hkMQNVWxuXvbPYKbcK74+1bQtXGpFMUa3jVraatq+3KdB1LeV25E6uFVB40LNtoNxs+6adr3c0paMNt49o4UutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097071; c=relaxed/simple;
	bh=xhgVrtv9v5004X1ifYjA+OL0Il8RwnH/5Fz0sxrdmDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDSl1+FvK2FRozY74bXpGbBWQ0DGRYwqtx4X1yXORVhYvFPk3Sx2G9Lp57FcVUY6WQkewITTJxn9rLrKvbZ4dvMQdQkHrHsqZNBaks2Qv6VNMTOnB7WwKGskuzL7gdIZO49R4TPWbs1j+AZp/9f3WhwH/VtFxBEoKaZhz63YSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m6x1H5TP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZMnPTysN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6x1H5TP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZMnPTysN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777csOj3829298
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 10:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2YxO6sel+FdiQvLcLCoi7QI7
	s/XcbqboOjuQsSWxzbo=; b=m6x1H5TPbr5tbPWMCuCM1oJgJLOm3X0XyoGXZKRt
	PvjhnccAt8+O3pnzRaIWa646yN8Nlo+bYb1LcEiC6GTY5NEilaACuTSfRT1l45Xj
	pFG34VRTNcrr5Sj/eWojsfNf1nUgWEUFk2pSKKyNIpDZB8gXAexS7RFo9Mq4HeYb
	GF+vZa7mZJze+TaXJaSZ+Z9RhTrCJyFYSAZFfLFweNx8B2LVQuDa7NAO1ehpwN8A
	6utXbRZHwB/dld6nuybPZMV/El7Q6LKHis6SBqiWySjQUKMItgLKIG5dbIE7ag5z
	ULLG/5Cd4wxapnNosFpmziBTboZQW8U8U+cojzSo7RzQRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gufb8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 10:04:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52b4f6ac06aso50741361cf.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786097063; x=1786701863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2YxO6sel+FdiQvLcLCoi7QI7s/XcbqboOjuQsSWxzbo=;
        b=ZMnPTysNDt9EN3JchTWrDWCRSH/e9Bk5pdccO5sjYzr5IB1fV7we5u9CS2cj5osSsw
         Hs44+T9m88E8tFyV3kb7BqziU2g4cM1huVKHkZBYRIy4Vm0o5cxHCsSVIiEglsJgRAiT
         u1JUxNcWphKpV9qZSfAbDkfXSpYiM3+2IMtl9N+SJ2w1L5orpEFhNdJBPfrqCUwTehsV
         eO9/j3eg4h5jpLbXJKo6N9qgdR5V9hO9Vc7G1YI4jYYz5vyEAXg8aB95iDqLJAiEv4pk
         2GwDVmfkT9/iApzBzCSBw3VLaKwDcE2JqOJCjZZ6LWMHsltb1xCp5GC7efgZx7zTfSlu
         mNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097063; x=1786701863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YxO6sel+FdiQvLcLCoi7QI7s/XcbqboOjuQsSWxzbo=;
        b=gabXgqe0gq/L2Mx5cKm8/vJ2OuDV3fKMuAmp1FFwOgDXVg3vBB9rBxDHioxuRGY6FW
         /W523Vr8kYFzUA608triaLuIJ3XOiebL1L52gKQuGJPbl/KAYnzej2m37VU6JE+odh8o
         w4FEMGzHDnccS+g1tJNh5U1glhGopzfAZJN7vnKOdEHPt7hDuBe/u7afigYnrEkU5XaJ
         NJybjdl0N1gIoPazZvXXjSrKYm7hC4eX4HWW+7uWxk8VMpn2qCmUX1tFsEYkISmd2S/B
         oAEedBy9YajKobwIzWPwVaIuCWezn1+q2ea9RJHE938kivotQ9fCCqQ6zmBoCf/EwFbM
         4MIw==
X-Forwarded-Encrypted: i=1; AHgh+RptRvh1Q6nxbqn+sP4m8Z7aLSXYFCTAkzm69p0dhoIuU2VbbFUZEXL01PaKMnHR2WleNdVeQP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzasw6Hy4Kl/W589jJXbYqjcY6BXf2/HT4qoWc1PPp/307b108l
	SfsI0amiJTSIjBoFGSuqVVN7ezs7nRpxOmBgI842u438qo/+/EF/hm1/WW4gFRd4QR4dLrP2/Mr
	vR0y8AFqO5cEmAHqP+HWpNDQvSzlrca0vA9ODOU8lbG4zGnDlkXRFGUlNpx8=
X-Gm-Gg: AR+sD10qX82Hivyfjj3KoEQV4mBMk2+Dr7CSsirl0PWbDNM5OtgCT53uqZTDYo6tWOp
	SMY35wr0tn52v7Eu6v6Tx0/FXQ2UPYIzW9wg2r5jq7z7waRXCOr5ppDQLAdF3WxP4IvvbvbU8BP
	ZqvZ0fAfLi9R4wqTxrExzcbbyZwy3HEJcRENcfF0vP05hK8pBOQglBg/eQXe3DawAdf37734wyL
	CQeX8U4lmUxhOCyO9gr0KmiZoZYtZUogR0tzq3rNnKvxJ59fKs9iin5xrDCUWtf5LhfCF69IuEB
	R/Hn0lIT4XbZdrFnXnYpVWzQCQjmJrLs0xiqAR7D/g7LuR6eWy9OULc0ajBxNeE3/fS/tWvmwU7
	C3UD/VXweE1ngJMqtqtnUV5yB3kZnMVXcpcH7SeE3+dDcYO5k7Us8gIKxRVFGWihru/rH1hHoBD
	XpIrX3z8MkaoUCWA==
X-Received: by 2002:a05:622a:2448:b0:51c:1117:c79 with SMTP id d75a77b69052e-52d0b193284mr99587251cf.24.1786097062695;
        Fri, 07 Aug 2026 03:04:22 -0700 (PDT)
X-Received: by 2002:a05:622a:2448:b0:51c:1117:c79 with SMTP id d75a77b69052e-52d0b193284mr99586611cf.24.1786097062306;
        Fri, 07 Aug 2026 03:04:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fdda977d7sm2327021fa.10.2026.08.07.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:04:21 -0700 (PDT)
Date: Fri, 7 Aug 2026 13:04:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yifei Gao <gyf161023@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix use-after-free in
 fastrpc_map_attach() error path
Message-ID: <sy7253wbth3wlaqibiu62oddtc2o2vg33ybqjfrkqef33jydrb@os6cwxvhrqdt>
References: <20260806235056.456341-1-gyf161023@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806235056.456341-1-gyf161023@gmail.com>
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a75ada7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=CgArLu3JlFgy8oRInKUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: YiTf2vMC5d06YuP79Ej6oNBQ_XAoFNIr
X-Proofpoint-ORIG-GUID: YiTf2vMC5d06YuP79Ej6oNBQ_XAoFNIr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NiBTYWx0ZWRfX/w1rTPZ6sm1S
 tjwatLkjkZW/gCcW+ZtY5jc39I+OQ/wFjRpG6agyOWa3kmaIljxGP/MyDjAV8powInJWP/akkVH
 C4DTVNxrFcSxqOVBu8aGxjUyYQ/jhQY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NiBTYWx0ZWRfX1zAVEUiJJ2qd
 mmNhRxfqwoMSKG4iHRU0nHjUJ7rbIWW3dWHXcXk8/YGxp1ObIpwq+gQsXvn9SG9jA2xMQvqeiS0
 qKiS4/6fsN4z1hYsbfLTMx4SkAyoUFWR1Yoq0qGwa2pqHNDCCKFguP1507vIbrWOFtzgwpCmPSL
 C6Zay+nDJc4283jD6UgSLalP6jCYUxoq84SkYjFOhoLNiWlkGbQ+Voxk27y92pclaB1eMN2El9o
 E13PnU+D13n7S9dUzOch9cW3OS9sPgznDQxOMH6si0ZyJ8gsiMHa9+g4Kv8zsmxCB9wIXwIkf6r
 ADt9ZCvtd4ag62xRsnb0xfkLFPoHigLT8jzQxlzmwrcjcYSZcWYpZO/mkDOODWaddfo/A3wcEQ0
 Q9HwfjpUHxDDGq2829NLsDh1UOj7rZTy6Y1c8qDcM2sCvx0raSXcnH/rpIWKF3JYWxYk/KRZlc1
 Ag7irR6yaeCthV7/uwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070076

On Thu, Aug 06, 2026 at 11:50:54PM +0000, Yifei Gao wrote:
> map->table is set right after the attachment is mapped, before the
> len > map->size check. When that check fails and jumps to map_err, the
> error path manually calls dma_buf_detach() and dma_buf_put(), then falls
> through to fastrpc_map_put() -> fastrpc_free_map().
> 
> Since map->table is still non-NULL, fastrpc_free_map() repeats the
> cleanup: dma_buf_unmap_attachment_unlocked() dereferences the map->attach
> already freed by dma_buf_detach() (use-after-free read), and a second
> dma_buf_put() drops an extra reference on map->buf. As the exporting fd is
> typically still held by userspace, this imbalance can later lead to
> premature destruction of the dma_buf and a use-after-free.
> 
> The branch is reachable by an unprivileged process via
> FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
> requested length, before any DSP invocation.
> 
> Clear map->table in the map_err path so the fastrpc_map_put() fallthrough
> does not operate on the already released attachment and buffer.
> 
> Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d..d6be951d5538 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -915,6 +915,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>  
>  map_err:
>  	dma_buf_detach(map->buf, map->attach);
> +	map->table = NULL;

This way it will skip dma_buf_unmap_attachment_unlocked() in
fastrpc_map_free(), which is not nice.

>  attach_err:
>  	dma_buf_put(map->buf);
>  get_err:
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
