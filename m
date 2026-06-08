Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027E3D3CEB
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938491; cv=none; b=DZU49YuafW33P/slHs+mHynIkkJKsZw77XdLMqoYvncGHBeUXMbujSEx5zv+PN5RWh8sS78UYm4A7ljK0Nead/D1emA9zPU2bHc1cZGh4EFB/OIFjW1gi6p0KHdl4OHwmtKvtCssCi8EBJ9L4ih2iecWz9FLNUR6tE1L9zRtqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938491; c=relaxed/simple;
	bh=nc1cmxpsgl3/es/BJBOVuqe0MVbXq9wQMoCkRBeSIuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHuKKRQCu/faokVQhyeDytDo7xQ9r1CWkLdY8tLRsUU/+YuhNPNUdBBNF3GHBWJ2bxnioiGQfhnvQQpj4TsN9PFbxZ4rxU0QO5SMXlM98U6RsmpoAAC8bQdRVPGx5/P7spuvRBa/UUZN9hmYHdipGG+8dOcyfI/KpXD5gtM8xWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=No7w/sbO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RnvbaKID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="No7w/sbO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RnvbaKID"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFTdi3934233
	for <stable@vger.kernel.org>; Mon, 8 Jun 2026 17:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9VWzrVKJ/7G/yNKAgeOFsr9jNdwkADnzd+yjssLBbFA=; b=No7w/sbO+TV262I2
	QQK9JQFlIHqWZUZKSlP+zmQmVIoE7o/neWttCkzgV2GW7vgPlg6TArlj0O+At03e
	SfOMk3pUG7PKsovrFq54kFOiIKD7i7PEP8DYuZpJNn6Oss2QEFPj7jmc4WtcFRSb
	c/D+wCOya27Pxca4uy3XbQ5U6Qqv6NiHRk4xGqIeE7tVCZpVHOnXzIY6IG7LNRrI
	T/AY8xR8D7B4TTKdXGi+zV9Vngw0zaYihmE6XLUU9T8W1prjCXi4OM9Dx6mR+Pu3
	8bJXdFjGoOrHqEz+BnMgTmNxxi4Zmiqx9dKXylTIJAbpdmMC9KUyLvkPcLVLk+tM
	gUYH4Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rsbcs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Jun 2026 17:08:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304e4636205so11115785eec.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780938488; x=1781543288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VWzrVKJ/7G/yNKAgeOFsr9jNdwkADnzd+yjssLBbFA=;
        b=RnvbaKIDMiGo/QWx5VQqGEXAJzoYtTyXLIsDdUtwSka3CAX66lWMW7KqQVVJARdex2
         Z+2T5W6IansviUjo585YOAb73mTASf+8Eucp870tMeH5XqJKiC5+NIOQRrqB0E1Wkfs8
         Ill3Mmy/yGnCjhk8rfnFZpzv8HuWnUIgKDjXSScwS5WvG0E7mi4g0vHLy+3W0hkh3MqS
         SKh2QuMJfq6vh7vvfLJWC8kE8QhmsML5Ozx4F+MKaePMA3CwUu6BmEXQBd+IlZQJZbWL
         jtEVUkojZOxf9saYdJzexySJN0a+C3S+gOhowSUM9VrI1Naso7F689VWW88RqZfo+VH+
         XxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938488; x=1781543288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VWzrVKJ/7G/yNKAgeOFsr9jNdwkADnzd+yjssLBbFA=;
        b=XkXRsG0sGk6PUESQGhxEhvdT5j3ZP0wDhQK0c0yzXhjrz2cXkUq5oF6pdXvScwMdxu
         jiORcRqp/ThMhqcHuxsDSmvEH1mJAgJvdLR3no3ES+ElT5t3X/T/j3nPPt4ZjpzU/Txc
         h5wMFGfNtN9+HvxPyh3YBn7WeZkVRltijxdmJ6wshPh7n4RkDLdJ4893UoEj4e8BjOcZ
         vVl9Bwa/W4lfesM9BgPbzVnZgsOkA6K7iLxUF67/BUgsBWdbI+PZ4uot48j2LPO1OqRL
         p61Lf+XIzBcqg3ZceZgHMIJwr+ExNHOJJDY37/ApDGM8iRSynYC/ELiQ7fFO+EVpgNHK
         +Rcg==
X-Forwarded-Encrypted: i=1; AFNElJ9x9MiEC8XAdM6HwHZkZbRBNUeR0JenXWO5hzQ+KoCzy1PcOr5sHj4uIpGW/ps7BRtIgdSP4Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzicEDFF7EqEmojpuBTDQg7Lne1M7uccRpDnGlPhFb64drzXJL
	/T1lVD7QYop34OtWpBZaf7ipyyghTcsVYiqdbviRyxgQea152Q5R91gHFpLi/fTZQPrRte9GPpZ
	vZaY9Yscxh+6Ym4MrWGPrRrTqbsfMTfQ16seHsM1ngLd+zJ2S7mpiI2xYyiw=
X-Gm-Gg: Acq92OEeFbF+k7nrAU0uO/iBTSi2MR2HTUSlFYYEDBZUDxQxAAaSZI+0wuZsKClbCul
	ILSPwbuoki0Y2NpwJGNVGbzp0zRPw7j2obLaz9uBTyVFv6ViD5a451lwDZoiiWXgWQS3QAIueHo
	xpKUmv6FVyTvZYjjAE1UZHjXpS7hzO1c8nzD5JiG2rXPP/qV6vokWqMNmtVBST4jVjOYUUSDqHJ
	sGBsWpUArI2DhdGAAK5SgE8mBK8z63Z5TdF5drWtmDJTx6MvrTZ+MX8tAkPqjPu6/m5f+ZL7/EO
	JgcVUBYAVZU8Gy9q0PMm9Q0kUm+zz8HIXIzJ4C/NfOM/HAIxEMhIt024hfS7YLyxRn/C+E0ZL3D
	9n4a4gj2i5P23jkehufILqmB7jaPe2/Kb2ymY/+rGEUnn2wQ2NWEYxeLxC3Tv0sRwOFDYr9aJBd
	iuxwuZVdKh7ATeWIaucFRlgm+n
X-Received: by 2002:a05:7300:572a:b0:304:aca:35c5 with SMTP id 5a478bee46e88-3077b22c938mr8036369eec.23.1780938487939;
        Mon, 08 Jun 2026 10:08:07 -0700 (PDT)
X-Received: by 2002:a05:7300:572a:b0:304:aca:35c5 with SMTP id 5a478bee46e88-3077b22c938mr8036332eec.23.1780938487252;
        Mon, 08 Jun 2026 10:08:07 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df3b234sm22856903eec.23.2026.06.08.10.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:08:06 -0700 (PDT)
Message-ID: <973da9e9-3851-4e00-85d4-28140c039127@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:08:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath12k: fix NULL pointer dereference in rhash table
 destroy
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604071032.659009-1-jtornosm@redhat.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260604071032.659009-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: S9KLENl91ORaqbBgT7a8ujBHUTpnq3dg
X-Proofpoint-ORIG-GUID: S9KLENl91ORaqbBgT7a8ujBHUTpnq3dg
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26f6f8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=jrdOLSfvXqH_YxhRKEcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfX2j4K7hWDNldY
 S7Zn18IxnHfzXntRsuKlxdmIWnsgU/d3zek43OCNIQavSL/mLZs4DpUb3m7Z5XTkd5vGP6wySeB
 3QY/M0k745aZ2MwRywjPzmLbSjzGQuYZbhIYwMLePrLiG1OU8Foay0BwnPjOFUdChqLokPAQvBI
 NuZEex5hQpmB31LJt2B0vaN3yL9GaHjbE730Jp9zBhfLMdTrW4Z8lIjtoOvuGvXSj4NNmMj7zBf
 56soHFU04C9wFdZv7T+cXSDvOtEFLECwpuAgcf7sRpQjII2Y7NyN/nguPAXZvJO4KzY7miksJst
 iVj9vYYJoibWJae6Ff/037bn3OhP9jZV2qLkG8C7pq4UtvhTwj3hVxHUfAGQQXO3P7puMAUKsiK
 P3IzlGy6rkI32sNhgfx+IS+iXA2DT50Pa4ENLovqX93tPjUVRu64A1IZUVe+l2tsNQUk8Ne2fia
 WYAJ/n0xtNM3GN7TWTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080162

On 6/4/2026 12:10 AM, Jose Ignacio Tornos Martinez wrote:
> When unbinding the ath12k driver, kernel NULL pointer dereferences
> occur in irq_work_sync() called from rhashtable_destroy().
> 
> Two hash tables are affected:
> 1. ath12k_link_sta hash table in ath12k_base
> 2. ath12k_dp_link_peer hash table in ath12k_dp
> 
> The issue happens because the destroy functions are called unconditionally
> in cleanup paths, but the hash tables are only initialized late in their
> respective init functions. If the device was never fully started or if the
> init functions failed before initializing the hash tables, the pointers
> will be NULL. The issues are always reproducible from a VM because the MSI
> addressing initialization is failing.

My preference would be to fix the logic so that the deinit is symmetric with
init, and if any stage of init fails, it should unwind whatever init occurred
up to that point. So this patch seems to be a bandage instead of an engineered
fix.

But I'll let the Qualcomm engineering team give their opinion.

> 
> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>  RIP: irq_work_sync+0x1e/0x70
>  rhashtable_destroy+0x12/0x60
>  ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>  ath12k_core_stop+0xe/0x80 [ath12k]
>  ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>  ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>  RIP: irq_work_sync+0x1e/0x70
>  rhashtable_destroy+0x12/0x60
>  ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>  ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>  ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>  ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Fix this by adding NULL checks before calling rhashtable_destroy() in
> both destroy functions.
> 
> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_peer.c | 5 +++++
>  drivers/net/wireless/ath/ath12k/peer.c    | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
> index a1100782d45e..38045564e223 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_peer.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
> @@ -275,9 +275,14 @@ int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp)
>  void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp)
>  {
>  	mutex_lock(&dp->link_peer_rhash_tbl_lock);
> +	if (!dp->rhead_peer_addr)
> +		goto unlock;

not a fan of this pattern.
if we go with a bandaid solution then i'd want to use guard(mutex) so that
there isn't a need for a cleanup goto -- we could just return like the patch below

> +
>  	rhashtable_destroy(dp->rhead_peer_addr);
>  	kfree(dp->rhead_peer_addr);
>  	dp->rhead_peer_addr = NULL;
> +
> +unlock:
>  	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
>  }
>  
> diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
> index 2e875176baaa..80fee2ce68f1 100644
> --- a/drivers/net/wireless/ath/ath12k/peer.c
> +++ b/drivers/net/wireless/ath/ath12k/peer.c
> @@ -444,6 +444,9 @@ int ath12k_link_sta_rhash_tbl_init(struct ath12k_base *ab)
>  
>  void ath12k_link_sta_rhash_tbl_destroy(struct ath12k_base *ab)
>  {
> +	if (!ab->rhead_sta_addr)
> +		return;
> +
>  	rhashtable_destroy(ab->rhead_sta_addr);
>  	kfree(ab->rhead_sta_addr);
>  	ab->rhead_sta_addr = NULL;

