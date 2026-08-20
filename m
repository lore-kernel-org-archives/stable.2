Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B93750DC
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201072; cv=none; b=hJs7sGe85skbsDMbhqBZt+TZBhyaDWPoSE+3WqEiHcSR1Po49ziDXtcB1OR1b4vhGaW12gihuR0pWQRmfDQqzKT9F7UfgRnBMWPTMVh3AJ/ntoLr8Q8qRbJZaaKxJ2P0QvDQfjf4GtAahs0qAdemNg1lG9SEez/aLQ97drYTVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201072; c=relaxed/simple;
	bh=Tm7ushPO3+o0tFF8ecTjKX3feR6JwGsZGq1xnLwN6k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWI5fZ4b0eCruq93dnnSYxPQ8j70ox0LRjVcDpXEbUMPSX9dCS/w9TflILquDE9+BVzj0XCoBslJZqoowGBIT2tSmJ3i9Sam24r3Mhp4WzbYU7aG++DOx4v2JsS83irn8XPbuJlhSv1NL01DqNmMdbD1PdtOekLQa17wbb9lZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oqg64kbl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SKhUR220; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oqg64kbl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKhUR220"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JL7iWn1439049
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4YowyjfOG9pQiJVkE66VCvqOZqFDnt2tLDraq/jeeko=; b=Oqg64kblkgDE9hM+
	5R3gEXL6b2PwZeH7sTYv+rflEPuOfHtuPlgqgtIlyTidJd7zDARS8qKhipyqQ37S
	/A1W24mvxmALJ7exMbU6+CdVsb+8KcTawjYrKtZ3o2k3XqnNfjNIRs/ilOfC01oE
	1t9a22Kr4jdj+L6NdPUMnrEpzPxgkr35MxZ0n+PNhjEloqePxZKk8Yp9/AnI6rj0
	GS3X+MYoI/qkjXskgFPVVrT1veiqgl5L/UCrwf3B1PgKmLJQx+oI0u57Ef7raNZq
	g0RdqqUGQbTRF7lgO7+dqpWrwrushcA+yjeMdlKBM9h8zr1utauJTs19h5n6imS0
	APeQ0g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa3mas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:44:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3954def0191so3303210a91.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 21:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787201069; x=1787805869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YowyjfOG9pQiJVkE66VCvqOZqFDnt2tLDraq/jeeko=;
        b=SKhUR220CxSNiGD/BkdoZ+fzXM+h6o1UTEUp1e+G0JxLfAh31f4efntqiJvymI5S4C
         1fBKYfE5nLmKoTrk8DRsnBXPNd2ZEeyxlq5BqPZCGsXY+JMXxU/Wy0mNqRA3twU5bMU7
         RcQ6kcM/KzHV+19pWsmzyLT81EGg74GDe8cHwG67Xei/m2KCcoNho1nE49XnFrG0uSRp
         j6aSTGZx7A24q6loVj23xeFqh6v0gfeqkUkN4dAu+8SHrmwRR0C9VOaw81rvU2MNUnOz
         w1PzzzXDHokDOWyCX33EhERydPzYEATe+eFRwkMh6biN2lCmRSFKi2U4b+td7qZ6HbYS
         o4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787201069; x=1787805869;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YowyjfOG9pQiJVkE66VCvqOZqFDnt2tLDraq/jeeko=;
        b=kze2lFAzGmnjz55m2Yz/iKzOXn90iAVDqSk6pm4p6h8diIF03843M3zK/ehP65E6Zt
         dfWPJNm/M3RBTtI1ZCE8QrlsbCG57NEVmwg5MDFdSNdfyI9XgCoW7QNkcXQyw4Ep+iOS
         oJ4sI4dAAosGVayaX689YBftnzUM/tqELs/prekfz6mKJSFaBO36SZbnXTg1Xr7vwD5n
         ktc559PDowGhKXDCuaRc+ymGpbkcsLaNPI0zrE02uhXtN5icJ06YDn0EgpmcyXomr7UR
         tteOVzo/b+C+jm0ttVgFfBYRm/+tob9zO9cllSIcrHz3Y2PwqpoK731/6ERFeuchDe82
         7GJw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5GJUhOi8o6yQvdCmU8hxUlOlx6njMw1J37r0+iM5OrV7/NBXW2CbfBgcfrh1RALAnNHnzB6M=@vger.kernel.org
X-Gm-Message-State: AFuF++l6/sjO23nUSnHKvWeowr56dCSniUYJYTYsBoPrI0W8WAQk8YO6
	r3/4PPwctrRw7XpKcJedyeuYzFsOo9YAJnSJLmvthH0JzOwtSqLPxz+Shc0xg2AytD68MwfbGkn
	5EgrFd7y0skp2igg8MEYTHOQxA/A/0SD4raC3bXU5cmSsRQQo+/kP839Zie0=
X-Gm-Gg: AR+sD13Fk6X1pixn4AZolT4A/OWr1NxR1ZlTjkuX5n1xGLpOUosPwWgIgegYR5CcUZy
	vdYmrXax0yZnx31Hkh5nae8S26c0OOHPEAY/BUj3UGX3MtEeeANv3SaiJ5HR7K1S7M6C+lctg8Q
	+QOgnceuQD8JMfIgY0ISu+slT/vU2dXFRmPLXPkFRY1T/8vuHfdxRxabJEMrMtYRYeUqIIkM2RD
	YPB/oEisH15FiHlAVKB+m95WgMgcmFLqmFu6CDhPrXScu8kTl74XWf9EfH6GZbFMvrWgk3YecYF
	nLzZBhaQRTThsZOzVvkM65elgsBtXFOUBFWS/MnpzpDuQn3apZ7/hyus3Afj4VJrvw7RsmP4yeU
	/s1c+V4QvgRCDgM4+lb4d0ssRCgLx5A==
X-Received: by 2002:a17:90b:2f06:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3958108a0f9mr19146121a91.9.1787201069216;
        Wed, 19 Aug 2026 21:44:29 -0700 (PDT)
X-Received: by 2002:a17:90b:2f06:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3958108a0f9mr19146062a91.9.1787201068747;
        Wed, 19 Aug 2026 21:44:28 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef7a0easm14338932eec.12.2026.08.19.21.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 21:44:28 -0700 (PDT)
Message-ID: <bf82477a-22c3-45d9-8e0d-ffd4f054b5b3@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:14:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: fix double-free in fastrpc_map_attach()
 error path
To: Yifei Gao <gyf161023@gmail.com>, Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260806235056.456341-1-gyf161023@gmail.com>
 <20260811225102.1077841-1-gyf161023@gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260811225102.1077841-1-gyf161023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a86862e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GpFdYKwLFXUddJV2vI0A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ZHUbHIz5RE2svOUxI2H2lqzIYh1tFlhw
X-Proofpoint-ORIG-GUID: ZHUbHIz5RE2svOUxI2H2lqzIYh1tFlhw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzMSBTYWx0ZWRfXx/mEUDNKdTUg
 flkwloMr3WcmxhEbbKTxExoEah753iKxxuyKsSxYf0dh+ZVfTeRljerjesJdCbAXcKGCuNSm7Bd
 iHaY7/5PIVkUcNgQQCDB5QmykuOCNV0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzMSBTYWx0ZWRfXzQ04u8fKM+5U
 YPWVIQH7jx697tMyYg1V0xIMDInV4oOrr+ea/PZ2VBm1hAxIABk+RkXYiBjnAgSidvZ3OmYwB+M
 YkIo/dy8vxqSw3kN53UawrOGpE6r0U0uPHCKISMN9RsjFVzLVzCMRhoyKnTz2EbhSLG+R9Ttz6q
 X1ejcbQx6F6Y+4+lBdifwAY/EAlOnyh4D9hQkwQXIxNOsJSVpZoyPFiGv3O2X74TfA8I8tgK0qC
 NQORTJpIoW2hE7dlLJORwVtC4Zhx7y3hVIw6I8wP9pxSwJdGkv3jKjSxv10YnmI59W2MQT+M/W6
 1dps2rUCyY6o2Q2Uq7+lomvOgN1skdTIKwSDydcp5dMfTgky4JMR4K55gbXW7k0YO7KQ0XB498P
 3NGqiTFdTOgwvc8/fPEsSSmKOPJezuWgEB0/LzPvcVkv6HujE4HfmTC86ijtEOH7gLzVrfluAEb
 +lRIHKgDLsUShJ9QV9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200031

On 12-08-2026 04:21, Yifei Gao wrote:
> map->table is assigned right after dma_buf_map_attachment_unlocked()
> succeeds. The two failure checks that follow, the len > map->size test
> and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
> jump to map_err with map->table already set.
> 
> map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
> through to fastrpc_map_put(). Since that change the error path tail is
> fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
> unmaps, detaches and puts the dma-buf whenever map->table is set.
> The two operations therefore run twice: the second dma_buf_put() drops an
> extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
> dereferences the map->attach already freed by the manual dma_buf_detach().
> kref_init() sets the refcount to 1 with no intervening get, so the final
> fastrpc_map_put() frees the map synchronously and the redundant cleanup is
> deterministic.
> 
> The len > map->size branch is reachable by an unprivileged process via
> FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
> requested length, before any DSP invocation.
> 
> Route both map->table-is-set failure branches to get_err instead of
> map_err, so fastrpc_free_map() is the single owner of the
> unmap/detach/put sequence. map_err is retained for the
> dma_buf_map_attachment_unlocked() failure, which is reached with
> map->table still NULL and an attachment that fastrpc_free_map() will not
> clean up, so its dma_buf_detach()/dma_buf_put() must still run manually.
> 
> Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
