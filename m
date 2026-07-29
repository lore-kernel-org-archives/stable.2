Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623E3D7A18
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785359986; cv=none; b=oscybda6Fgr2Tt/QhQclZZt/uGv9H7xIsYmrDUf/1qeJEjVSu9eRKR7xfC5jCRmY+jTaWp3uPHlZ8GL30nKZ1rxfuhO8FL1KKQqqzPHIlQ2pWNQZsCu1UFu08pe7SrI3XHsaB+98269PAtElLUKIUCOZabRZAhcorJG/euhjiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785359986; c=relaxed/simple;
	bh=/MAiXAbQNLukFOvamzXuv5lJjwdh98FXvF7dya3cf8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CofY/RGjZSwTOyFyUX2h/O9bIEz1onpVi6AG4HSWU98credL3y0ly/qZHugsy2wMPnFuJ4BAUqQP5hA2locKsu5Iv1QXK1ilKARkIAiSNqsDkJSDMu1pXsrdLnyyrcqTnWrcjUNs/ji23zMNrytZUuFO0bAVFAzRYm8WOO+tOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kJq8jUPO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bTmRPFpU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kJq8jUPO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTmRPFpU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TL7JQF3224237
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wkr/IHbH/vmkP6F8QZmjiDF071+OEQwubDm18Vb8qFo=; b=kJq8jUPOh41Wutg/
	mB0hRRG0yHeTfgaI96Erp4IhZ1LWAuN8TST2hVvko/nMfHQqx5FAQymf2+j4AY+Q
	1yVfSmdL8iyPrNTWxhx2qEpY1Wp4VsQ/YmA9HdjhxC5PVWm4pWlwXy7h4Rw9E5J5
	dxJ4CCGG9Czj/nfkclzs4TbqsMT3Nhhs7I5upnkaODA24t5un3i/Nsn5P1JxutGq
	IKa7jjVHg4Z53GcbTil9ot2xFBQQg4jShvc2XEu5vfl0gK82obsUVsYt4+wZ7ZgR
	7CM4t4ljQLlIUzO6tl0KJ+6D4VAyLD+BJX6hwKJA/7mzV3/dUPRfT3Uv1Wg1COLJ
	41J7EQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqs5a019b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:19:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e04598adeso1149350b3a.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785359981; x=1785964781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wkr/IHbH/vmkP6F8QZmjiDF071+OEQwubDm18Vb8qFo=;
        b=bTmRPFpUVt3hrwmWJ6i6hBDpx2Vemx0Njs8bIlJ+6ZRpYifTNoFBV/dsA7RFqtoQdU
         4WdsDWT7z9dBVOHdEZup8AG5c7MNeBYy8bVXQPQeXf5Ni6YqAHLqz5jcfGDRbyWkcTZ/
         gLMJiUvlMAdDSbYseKHqj4L8sAQaaE6JfEHwoXS9fwk5W5SV7k+0AX+ggwrSz8IpPBpw
         yF0wizpGLVoXr6LrzRwedKnzFhUJXssgr0Ltlvsmz23pg5Yj9dOXEpiRtrbxmdU43rJ2
         59kJWNknIKhiy/fSxBEjdO3x5a9M9rFsxVPTlp4T4U7ktEhE0ABaZ4mUD+WshvPmI7kt
         8qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785359981; x=1785964781;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wkr/IHbH/vmkP6F8QZmjiDF071+OEQwubDm18Vb8qFo=;
        b=U7DHnN5T3oIEkZXmsrWN5LNugqSP4TKIv+8shzA8CK1M9y5El+Q2++BzcQOPvZRamK
         UCs9RQo7jYOnuSuPwsmL198Ww+hl7W+MF8RWl5Q3FoUQBbaQZoSZXOdaoCmwZBCrAyyt
         WNL8G4u+UQkx1JUo9/wgjocy3zdtgsv+8D4POqpzPyyGNetZawWU5YaVHMOxtPAr8Oxr
         G1bHqRWRea8rpP3u64g5DFge2aLRUwjZTr3bzs9bJWwmMMNKR6gRHDEZWScVKMf0TNCV
         30f5sR1AVUdH3JyGu8TMc/gDpRuSoawxLQgcgzdpVZC6q795O50LunCYqbbxY5PYniVL
         WNLA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0KlPJXal1a/Q3AeXBeDg2ekAtgh0Hkxagetn1EjSpMunYaX95lVTDOzi1nMYhlAuTRoYUYKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4DAEuU3N4EyaojYabGzyFguHol3KDWjI466Wf1dbbSOqivNI
	bdr1SFDzZgqplhOv+zcqNTLxIxJ45G3jgsDbNynkDqUzzrDW2FXBsvBSp9z0GGyj8rp7AoZvyNo
	w8byGppAlHKUchpCkGbed0vlJQTBH8hq7H0z7Mir49xujVA/NbgAYhgir6uI7nloqCpE=
X-Gm-Gg: AR+sD13e5KDpflBqScHaemulkKlAxNHLf9Fl3lqlgMIoc9bchV2XBXAEzXjo+e+su1M
	E7q6OOUOQBqbqBTkLXr79yX2ZCxpGHZk6tLyifVY5GclCzyR/F8YBjyQOc5FuTnbv9GdazrrVSV
	hQr7AEHs3yQYuZMSzg91zL4zaOe5tcJ395ZeiknwQu4lPd/h8yxEVzqNKC5GivsvkwWERBkGwnE
	o5A77Q0/GTc/rCh3YY9PStdHCHI7ndBTTwwbX3Ng1gJRudahDcthmCCvvjvcT68yiZQoiE5m34n
	ijtJFNhadRdrkrELU6EfhayNz2VYhEl3yEcKteinRbn0643JISv9cPWTXpzxTDHLu34x/Vmpk5N
	K6zOfJ99DOZNbp51kjHrdMqQvIigjmMmX6UUoS5C+N9PIviWWldW1MA==
X-Received: by 2002:a05:6300:2288:b0:3c0:9c19:b275 with SMTP id adf61e73a8af0-3c8ba6550f3mr9253702637.67.1785359981416;
        Wed, 29 Jul 2026 14:19:41 -0700 (PDT)
X-Received: by 2002:a05:6300:2288:b0:3c0:9c19:b275 with SMTP id adf61e73a8af0-3c8ba6550f3mr9253685637.67.1785359980956;
        Wed, 29 Jul 2026 14:19:40 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504927a7bsm14864812eec.0.2026.07.29.14.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 14:19:40 -0700 (PDT)
Message-ID: <19305f3f-7567-48d3-a0b2-6597fdc3c314@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 15:19:38 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/qaic: fix GEM object refcount leak in
 qaic_attach_slice_bo_ioctl
To: WenTao Liang <vulab@iscas.ac.cn>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, carl.vanderlip@oss.qualcomm.com,
        ogabbay@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20260628115119.44215-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260628115119.44215-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE2MCBTYWx0ZWRfX3mnLD7TU8NBI
 hjGZ30aPPSrs8lRhmXVDFw9mcjLD/l/Guybk6V4qovn52ejykVfrUsIx3JhyJEqUWYYjDTve8wF
 FvunoO1upvf25t4MOJmIAd3UnxyNmLqS2mj3P/eoMeHr/I++GFxb0ccQCzm/hJ8mWCWkxU7lBwN
 65HBf1hbwUNMqOMd9Af6r0+XqW1a7Oy5uOkd3XeEsS6glDDCvyW5n5Xcl+jTv8PaFfhOKWNATIB
 Pj2ioUTQ1wMvsR9g5VtnupExzKHUMFKNt6rTZJYpnAv3VcnQvrTrIu/L05J8qF/fBYOcpKQD6g2
 trvcYI3cJm9eb7ZJ3yNrErACAuns8/F74J6ha7165t2ebtSX5dUefEm/ZI0T+XMpcOwCFOum1fp
 bpy+zzSk0q6DF+JRMPE2+94o1BPcXRRVKyPUyVMAl6Tti2jJcBvLtbeVFYlQYhPtGVTGGK+8I+m
 cB0VbY3ACuPjBmFVBSw==
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a6a6e6e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=mPBHZ_2hYfeim0CFHOkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: OpprOFNNper860T7zUru1R3KCB-l5L_6
X-Proofpoint-GUID: OpprOFNNper860T7zUru1R3KCB-l5L_6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE2MCBTYWx0ZWRfX2YLhrwThOPft
 YVllTz+7yXXyE/rFvZs1mbE+wo9rIBKzMgJkJMFl3vAtWZ6C0Pk91M37Cn4rJi+MDPiZ3ZgBe/x
 cnW/fRbftU5VMpTAN94lpzGYi4df6Cs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_08,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290160

On 6/28/2026 5:51 AM, WenTao Liang wrote:
> drm_gem_object_lookup() acquires a GEM object reference on success. All
> error paths correctly release it via put_bo, but the success path returns
> without calling drm_gem_object_put(obj). Since list_add_tail does not
> transfer ownership, the GEM object reference is permanently leaked on
> each successful call.

NACK.

put() is specifically not called in the success case as data structures 
which depend on the BO are not released until detach_slice_bo(), which 
happens to be where the corresponding put() is.  It is also not possible 
to successfully call attach_slice() more than once without a 
corresponding detach_slice_bo().

The get() and put() operations for the concerned paths are currently 
balanced, but this patch will actually introduce an unbalanced state 
(extra put() operations).

As far as the impact of not having this patch per the commit text 
(memory leak) I'm aware of many memory stress tests, yet I recall no 
reports of memory leaks from attach_slice().  You will need to provide 
proof, from actual testing, that this is an issue.

> Suggested-by: Greg KH <gregkh@linuxfoundation.org>

This tag seems wrong, as there was nothing I can find on V1 in Lore 
which indicates this tag is appropriate.

> Fixes: 75af0a585af9 ("accel/qaic: Grab ch_lock during QAIC_ATTACH_SLICE_BO")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Fix patch format based on reviewer feedback
> ---
>   drivers/accel/qaic/qaic_data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> index 1e4c579d2725..b17df7bf565d 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -1084,6 +1084,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
>   
>   	bo->sliced = true;
>   	list_add_tail(&bo->bo_list, &bo->dbc->bo_lists);
> +	drm_gem_object_put(obj);
>   	srcu_read_unlock(&dbc->ch_lock, rcu_id);
>   	mutex_unlock(&bo->lock);
>   	kfree(slice_ent);

