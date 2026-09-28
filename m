Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732264E780E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609212; cv=none; b=DTrx3iCq1kcoJucoIweXqRqsABb/zhCb67EFULWq8fakYFqu9qUD008Kpt0drKE9Bp0Kvn63SplwCrtn1tSeGpGMsr+KJdGeXW9MBq8bWROSi8M1X1vxfMiMac/hxTz/W2XEwFuSpDDCaJ5Pbi4a767HeEe76OA0oiLDeAWNg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609212; c=relaxed/simple;
	bh=Dqvg11DbnRk2zmgrSPsi4PFkVSfCPoWkfkc4MJ1gLCo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IEkMWWtnB71MVJQXgnDKYfGega8m9duaOoPnSClKi7IpMF4ksaRS0Apum0+ZxIz10fEQHZbUt2pyEqZbKSi7ha42uTDxqdO0GedJYWIFGsBIPv4KHXmq1vYsly+xQ+01dHuJR5hJeeGaLahve+CuL4ELtqhkH77FCC7Y0ZxWSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZk2SS0k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dEIX/txS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZk2SS0k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dEIX/txS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEdxUT2755871
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m8I30bmzEkxiQOSTZb9FMgwhTXv2mfHqXd7wNca/new=; b=TZk2SS0kMHDhtF02
	OPKyXa+8okiuK2ku1qWwqBsXl0AdMf8weR0x1G+vghoQU656fkU7lOqVVniW2mLP
	y9yb4kv8vws+RjZsMGrw7XDEzeXfJM+Kmy+vpj2ET96R5m1m7fXRAwyuRkbIR/zG
	7T/9b5GHV8tJJMZOsaqrvkY0+Uu1pIKofpaWpWwVhxeWaB0enRK4f4Dmx1yaUVyF
	z3LkHrbjcQfmOmK/uWSXBull1HOGP9nxEsww8JMAs6padNyFMmkMa6M2RIG6xCOm
	Wm49G6JzrOw5dYkeVbzcKIysm92XuQ4z1B7auX5VbY5C+ZQqZnOHsYdsrIL7mHJQ
	ixkxeA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubj8ry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:26:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3282d5302ffso5429758eec.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790609209; x=1791214009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8I30bmzEkxiQOSTZb9FMgwhTXv2mfHqXd7wNca/new=;
        b=dEIX/txSxwv4GZSbql+eM3cz8j9Zp51w1zmT9HOaqzOgkci+8IHakER+Zx62h/Vhtx
         Oj9oUxgJxqHzU+eW3UTClyo+wZUHI9jdDuTrDeoEhKzk4fY/gjAbIR1xYGdf8/eIrGc+
         pq5POMOSZUfzcQ+G6MpoVwllDGRtSojItPp5gaqc3iEHAcHi4o6mg8X1eVh7lSNDnEI0
         qLNKSpsImxH6uci/+8olJVF+iBckuwWPtXZ897hhdXgA/a8KVlgxxwLNC03mogWuIooE
         2h0szj1Du3KHGtkpU+zdWpCm+TB3U+L+ih+PN6Himy9ncWtg6q2y9cneSGLbfilXcoBt
         VQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609209; x=1791214009;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8I30bmzEkxiQOSTZb9FMgwhTXv2mfHqXd7wNca/new=;
        b=GvmAzbUZCrG/a4ZPnLPZGkfed13R5IbKlabhCIB7z3vInHWNY6g4ZdyPoygvEdLx/D
         KsahMzheqPEZYyz40fdyPGM8gvx5p8M/leJGo4DJFQyCNybBaSrWHvR6m8eeB56VZmVY
         XnB+xrk4RbZondehNrldeRBI3GajWZRDOZEhEEw0Ay3u8GNxWR5VPTSEza5ciWBlFLLx
         Vd8Y+UQx8rlk1h4mpZSUogPh8/k77HW+yJhV8xLZwTpehlYP4oz/npt9+KFO6UntifM/
         qUq/6aMuw7gR9DJuUZSh7Q/4rMxQHLmR8v0ak46pq0gyKHQaUWgv4/gcxgoBgAdYKqQD
         NH2A==
X-Forwarded-Encrypted: i=1; AKwUvBwCTvhPIjVOacTYLxBnJ18rssR09d8+I/qimMcjro91u3oZMD+9uFwB+bFGG240rwVQh5ntUNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI37v50TiE3vonyqUE0DVuM/+Z1RzfO4CBjy1FIz3g1FiNvsRVO
	+b7aK0NMfxDNlwgpDKTL/HyynaLxrOIFumMN/u7f6ouWfZR4g+S99oPiZw0RCyTpxfmei057qiV
	Cx6Vp1t6OiD9AJV+Eg9APiPSdmEbRZFW76IBbZ6j/CJTVt/E+37fujomj2gc=
X-Gm-Gg: AYBFou0uRR1t0aAj2Mns+ll/1AXIz8CZnLOL25knk/YfUbn7cIuvc7X/the0DCoQaSK
	tdaAqJhYFNo0y/+Km6qeyJNETXLgY5PEtkqCua30EkBfYfUNB7lRfC/sHQ5B2aFSxtQsRjxNsT9
	z948KjhXNMkSCNFOwqRCU4uR0SQ/WeVhQc9/GZ5DPopDG/ANyIDWB6wI2yrHe5+vS4ZKq93t1SH
	UVdXW3j65gJ/sE+L0qMHCilxmNfF6HsOKT3lzfm6g5VuTupm6xzRXZ8/7w27fqlwyqZy2K5CPIY
	kE1iw5UoGbxCi45eewYctRtZ0U3f9C10mZ8nMDgkEa41iSBY2J0W49FLWMNh06EDVi1+FeAHrU2
	ME8EYmY9BCymIFQ6ij2lXJeBhFhO6SuiDzkj4L7jP9wo=
X-Received: by 2002:a05:693c:87c9:20b0:347:a3d9:dfa3 with SMTP id 5a478bee46e88-347a3e9232dmr2971505eec.7.1790609207793;
        Mon, 28 Sep 2026 08:26:47 -0700 (PDT)
X-Received: by 2002:a05:693c:87c9:20b0:347:a3d9:dfa3 with SMTP id 5a478bee46e88-347a3e9232dmr2971437eec.7.1790609206721;
        Mon, 28 Sep 2026 08:26:46 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.80.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm31407404eec.6.2026.09.28.08.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:26:46 -0700 (PDT)
Message-ID: <3cd93e83-6103-457a-8879-bef8521bef9e@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 20:56:41 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath12k: order hw group devices by WSI index
To: Benoit Masson <benoitm@perenite.com>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        stable@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20260927012314.34857-1-yahoo@perenite.com>
Content-Language: en-US
In-Reply-To: <20260927012314.34857-1-yahoo@perenite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RPXYm2V8rwLKLY7CBoaYjIWLw_wNQEx0
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba8739 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=kllYWVK2JqQtNyhMtAlpJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=LV5C8B2hAAAA:8 a=VlrtaSc80NQl5BrU7SEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=uiVh3g-rw18WZz7NjXbe:22
X-Proofpoint-ORIG-GUID: RPXYm2V8rwLKLY7CBoaYjIWLw_wNQEx0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfXxisXYceDNT37
 CRi9iD55F5eK1R9rjfuDL6R1h2rcF+SuXe2PcguXjb0TLN9kcGO2LsssI4EqL4HfbhfF0i5hPH/
 TDGfsKGJJqxkg070Vb8JQvCDlvDJYGn7oQ2gk9cmqzfZ/X8CW3TXG60CombQ5ROy5s9FkUsSv/5
 sWLsPkDTshvTzFO2E1G9phi+F8E5zyPsNDQBipVZv6odbAJWtG/8ovRJi/Ywwoc8z3B5bzjWUjR
 aFGWGYfjB2FVrTBXnA30zs5N+qEEzVC0TVCRuuz7XAxfFIEfJamPBiMtGKuQUppfFH8ki34M75m
 MpLJWMhaWl3FxqocunWeFyB5naQA0QMeVfBQ4AFlG0KUin8s+CgcDbFwidCKh5le8ErFpJpR1GV
 KzUfDe89X8LgsgmlaL2alEjv4E4fEiE7p3fWauYEW0Oc0CQDDA7eCQPb8yLyuopLD0TJ/Y+enWY
 LLeDZmbySkNzULKlPRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX9G/colucbQHO
 WtR8EINvfYbZsXMgqXyLOnMM27/cXLI292n4QkX2sD1uWj0WPzRJBGQIQZQPsRiecExd8jBhKIA
 HhQjLKwkD658lJW+V0kBErHguizOJMM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280061

On 9/27/2026 6:53 AM, Benoit Masson wrote:
> On multi-chip (WSI/MLO) platforms the devices of a hardware group are
> added to ag->ab[] in PCI probe completion order (ab->device_id =
> ag->num_probed++). PCI probe is asynchronous, so the order in which the
> chips complete firmware bring-up is not stable across boots.
> 
> ath12k_mac_allocate() builds the wiphy radio array directly from
> ag->ab[], and takes the wiphy device from the first entry. As a result
> both the wiphy sysfs path and the mapping of radio indices to bands
> change from boot to boot on boards such as the TP-Link Archer BE800,
> which has three single-band QCN9274/QCN9224 radios in one group. A
> persisted hostapd configuration that pins radio0 to a band then attaches
> to a random band.
> 
> Order the devices used to build pdev_map[] by ab->wsi_info.index, which
> is derived deterministically from the device tree WSI ring and the
> qcom,wsi-controller node. ath12k already uses wsi_info.index as the
> canonical per-device index for the firmware link IDs in
> ath12k_host_cap_hw_link_id_init().
> 
> Note that ag->ab[] itself is left untouched: the unassign path indexes it
> by ab->device_id, which is the probe-order id.
> 
> Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
> Cc: stable@vger.kernel.org # 6.14+
> Signed-off-by: Benoit Masson <yahoo@perenite.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 99bf5cf..6505255 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -15444,6 +15444,7 @@ static void ath12k_mac_set_device_defaults(struct ath12k_base *ab)
>   int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>   {
>   	struct ath12k_pdev_map pdev_map[ATH12K_GROUP_MAX_RADIO];
> +	struct ath12k_base *ab_order[ATH12K_MAX_DEVICES] = {};
>   	int mac_id, device_id, total_radio, num_hw;
>   	struct ath12k_base *ab;
>   	struct ath12k_hw *ah;
> @@ -15467,6 +15468,21 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>   	if (WARN_ON(total_radio > ATH12K_GROUP_MAX_RADIO))
>   		return -ENOSPC;
>   
> +	/*
> +	 * Order the devices deterministically by WSI index instead of PCI
> +	 * probe completion order, so that the wiphy and the radio index to
> +	 * band mapping do not change from boot to boot.
> +	 */
> +	for (i = 0; i < ag->num_devices; i++) {
> +		ab = ag->ab[i];
> +		if (!ab)
> +			continue;
> +		if (WARN_ON(ab->wsi_info.index >= ATH12K_MAX_DEVICES))
> +			return -EINVAL;
> +
> +		ab_order[ab->wsi_info.index] = ab;


Maintaining the ab/ar ordering in ah based on the WSI index feels like 
the wrong layer. The WSI index is a property of a device's position in 
the group (ag) based on DT.

Did we consider placing ab into ag->ab[] deterministically based on 
wsi_info.index? Do you foresee any issues with that?

something like below in ath12k_core_hw_group_assign(),

-       ab->device_id = ag->num_probed++;
+       ag->num_probed++;
+       ab->device_id = wsi->index;
         ag->ab[ab->device_id] = ab;

If that works, ath12k_mac_allocate() wouldn't need the new ab_order[] 
array at all. It could simply iterate over ag->ab[i] directly.


> +	}
> +
>   	/* All pdev get combined and register as single wiphy based on
>   	 * hardware group which participate in multi-link operation else
>   	 * each pdev get register separately.
> @@ -15483,12 +15499,12 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>   	mac_id = 0;
>   	for (i = 0; i < num_hw; i++) {
>   		for (j = 0; j < radio_per_hw; j++) {
> -			if (device_id >= ag->num_devices || !ag->ab[device_id]) {
> +			if (device_id >= ag->num_devices || !ab_order[device_id]) {
>   				ret = -ENOSPC;
>   				goto err;
>   			}
>   
> -			ab = ag->ab[device_id];
> +			ab = ab_order[device_id];
>   
>   			/*
>   			 * the assumption is all devices within an ah


-- 
Ramesh
