Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A042A15A
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299222; cv=none; b=PrbaKjkrBdGaHigAwiw/DSMGOL3nURyVyAddidvVXeIi/0AU5Lp0t9QXpGUinbT0hJR73wYlj5UDF37EDIdbYFeoVqKn0kuRgLpk1yq4x2kjeyaLtL/q6TWZnIt3pqJ9Y8hOFgQn5U2axcRp46gP6alx7F6u2VoR9UDQrEGkWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299222; c=relaxed/simple;
	bh=93ALLyGWsN51G7lcm8PzYm4i0+algZTmxo1Z2xbO/EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVsUJSKnwlB6+vHERYdjk+1e4eIB7oQymyHzguBjusDWjW6IUHYzWC7QuDfSeZckb84cNq6a2LTm5AR7NG4s4TAtX1dRioXuaTO2hWiH7FIcmXFFzkP1ZNH+fv+b/iTaJaZNXvYyBolSm1mPA5/uJrgfjAzffwL++gy6M0+l+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Txmp1rsd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D66ZeJDG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Txmp1rsd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D66ZeJDG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE874i2002525
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Qt1djWNsoZvxOfSlqVXOUPZ0wf3R2BBKcU7CUAFuzA=; b=Txmp1rsdZoSWW1/Y
	KW6n54vVyz6pydNVVY/UB74nBC8QG0A8gnkGuyLeQWoOLXZZQin8e3nbZ884kQuH
	9IC7dqH9n+rDvIIOFXLgrdvgg5mqQNCFsEawF09fNIjc2ZV18z3Y0cirDDCDa+X8
	d9aqe2QA4u9IqgHzIji3XeNh7WQTQVeztDQ3k0OrgqyL7wd8uBQRJLoVb/G7LIfE
	AIl29CQTAjtjYUJgpi6ZF0u/fa9fJCoL9pycf58dVmULT4DKkXzUtC6zyiZlqdGa
	Zfh5teKAhn83goIA1F2UY5VH+sRiuEiNI+HeXhhSNtkeeq/cnDiMUF0wfuHWWFJl
	6H5yJw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gst41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:40:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso11505703a12.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299218; x=1784904018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Qt1djWNsoZvxOfSlqVXOUPZ0wf3R2BBKcU7CUAFuzA=;
        b=D66ZeJDG56VqMhcJ5GeIEC0QYb1u5g+UfceMxitEP2jBBxOu1bKYHHsMxTtHHd4Ws4
         Co5hXJFTYEYx09Itzm34CunreNxNlracKcypwOJbNAkF+2mBwKjERnLGk5WFnRWc4RBP
         cBMW3Zgwc5/KE1FP/XeMBtBXWiheug4PQCu1+nBHoOLBHGc5AkXZp0VA/Mdl47GabzZe
         VXJKafFsQS93IrelYgF17zfOHuc3Uz3dudcqE3JzvGBP77390yItFJeBKZmNtW12cVzp
         hNNmVHHa8nLR1eC+jpcjtzRH1/jWveMiDCUZTvea8zdPK4pSrUOaWzF9Y+eOVREkyPlG
         IvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299218; x=1784904018;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qt1djWNsoZvxOfSlqVXOUPZ0wf3R2BBKcU7CUAFuzA=;
        b=kS5ccwrzdPSinsO7JJ3ve9S0HsAl3ooOD/ljfWCHbTCi75K5bZXs4EErrXWTBt5T3e
         m4SXGe+1kBhMX6l5k7bSCKJ+EILUYXcBsQc3h+Gb6/73tt5JuCLWs8C3apd46XykVaEL
         Alj9Uxru0Uv6OYjDO6RnH7YzfPMxsP+ClP4eYW2IOOTKy5+IN40wLIkt/QZGGlkK6ojS
         hd3b6Z0gliUHYSQYYd0qQfFEKKWm1KNqVMNzIS6uZDH8cmBNNPX2/I4OjfCESI/trOiR
         C2WqvNRDT13rcVqnWKIuyqjlJI+EKrDhJJSzRTd32nOpufKkLEALAQMinMkAKothUC4t
         wkzw==
X-Forwarded-Encrypted: i=1; AHgh+RqcHgtVJib7devSp0b2/BYrPK1LroMecV4/GmDvzZjCjsg3rHCOZdRApDmfE0LvmMUV5xLhnLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGD5Q191RBs638yJDwQNSO5uv+mSzDO/ueSnskC2l4IRbQrnbW
	R51qOv1nZlzGpK/VPmF4+E2wUib1318D4EBsswUGcZaxdklphXaiuyC8hrpUyIflSIi/cR+rn6G
	px46cOxU9Elg3DHRNDO0lRHp3C8+ClEyFn2u2j+T+3iwJBV19+VU7eef9HYQ=
X-Gm-Gg: AfdE7cltmy84Tnj2TKBws5skZXN1vqhOwWeKm98C3W2kYRNfLmPTT1Q2tx7QC2LFFm+
	oqZcPICw1Gg3pGoFlZrspHZfiA9gBBJREzf0I49aqwMHVpeXKntZTTP4Ox4kGzjVav+qx2o2g+l
	6kQzPXSbovaPwn/OSsf7zSsKEYaRNzyihZEf06DqOJATcO7DyvJspa9JPuArbVUmq2UDsWek7DK
	RgoMPBkUXre6Ox+wLyu1LnjrHMktx/3R9CUsHg6/WOsR+jhiBKUwu2TplFXtv205drXerjrLlTl
	ubQo+fVn9vKWcLu6Aw6XX9zDivCrpx2z26EwAAWIjFryy5ukgYJmuzzH0FN5w1SREP1yRc9Lksj
	LiKtffXZdyDbP+k6DdKSdbBFrfbH0qZS8QRJ9DXO9fvd0FscllkuY1qYdTg==
X-Received: by 2002:a05:6300:4047:b0:3ab:2fa:756c with SMTP id adf61e73a8af0-3c3ad795790mr3459119637.1.1784299217467;
        Fri, 17 Jul 2026 07:40:17 -0700 (PDT)
X-Received: by 2002:a05:6300:4047:b0:3ab:2fa:756c with SMTP id adf61e73a8af0-3c3ad795790mr3459059637.1.1784299216792;
        Fri, 17 Jul 2026 07:40:16 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm5852602c88.9.2026.07.17.07.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 07:40:16 -0700 (PDT)
Message-ID: <49600545-3e13-452c-8940-c3e775ac3856@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 07:40:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 ath-current] wifi: ath12k: convert scan timeout to
 wiphy delayed work
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jianhao Xu <jianhao.xu@seu.edu.cn>, stable@vger.kernel.org
References: <20260717025602.262916-1-runyu.xiao@seu.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260717025602.262916-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0OSBTYWx0ZWRfX1bj/zJ/Fzvqv
 wKYO9iv30+pD+Zl9gCGzMvviLS1zVv+x8H6TXDKlZe7FVBfGAksrrYMmuKt1tJhmGSMBSElzvzE
 lwsCcmGRYdXHe4WqYLmXVHPqLCL41Io=
X-Proofpoint-ORIG-GUID: 4G_r1rlmFVkjvNTMIEA5ePePniQQUmTG
X-Proofpoint-GUID: 4G_r1rlmFVkjvNTMIEA5ePePniQQUmTG
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a3ed2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8 a=IGpawK0pLUKNoA5DvegA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0OSBTYWx0ZWRfX9LXwzqnk+/6p
 WuvSJmYl4BEmgAGUmkEzn1R2DA3eQeAcvdZpkhKD6jgRiF3h0e3eiTHfgAso+m/abSl5bPd1V8f
 bDavsM+FHBrRfDNiUu3+dvhYIFzrywHsRk7rLkFRftEs0YnWgCvd9DJTLawweLcsV4bGVqPwVHc
 dh4zhwqGjI4lTaDD1o8lhO5PBljrLKxOSJ4ZcZ8RQm8Gr6YiDtVvvHXSyaZZ9lAnE49nMTGZdh/
 Drn+HRl9RJ6z8ZkSwkZ+r5Yr5oJeZyCtLBaj+//GBvwA6ErzRT2YMhnwiVtbGS8bT/Cfi1vVxDt
 zPlwYUm1qryFAPxjAlSQs9Rkdiwvu0wIotpx8U5R/FWz0mgPzZVoToyWO/zBb3gUn2gR7aQgDCW
 Bs7Ey2n07JlPzTvE1QluUnL0SA2vszDkf01juoa43fN1MU8VlmSRVUxwMXQJNxjAsgpbe0zQA3r
 Y2O/9myV75VwiaLUsWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170149

On 7/16/2026 7:56 PM, Runyu Xiao wrote:
> ath12k_mac_op_stop() is called with the wiphy mutex held and calls
> ath12k_mac_stop(), which cancels ar->scan.timeout. The timeout worker

you are missing a very important detail, namely it is a synchronous cancel

> also takes the wiphy mutex before aborting the scan, so synchronously
> cancelling it from the stop path can deadlock if the worker has started
> and is waiting for the same mutex.
> 
> Do not drop the wiphy mutex inside the mac80211 stop callback. Convert

What does this mean? Where are we currently dropping the wiphy mutex?

You should describe the patch in terms of the current code, not in terms of
any prior versions of your patch.

> ar->scan.timeout to wiphy_delayed_work instead, so the timeout callback
> runs in wiphy work context with the wiphy mutex held. This matches the
> locking model used by the scan vdev cleanup work and lets stop/cancel
> paths use wiphy_delayed_work_cancel() while they already hold the wiphy
> mutex.
> 
> The old scan-finish path could cancel the delayed work directly from WMI

what is "old"? There is the current code and the new proposed code.

> event context. With wiphy_delayed_work that cancellation must happen from
> wiphy context, so keep it in scan.vdev_clean_wk. Mark scans whose cleanup
> work has been queued so a timeout work item that was already queued before
> cleanup runs does not abort a scan that is already finishing.

My AI review agent thinks this logic is unnecessary, but I haven't looked at
this in detail.

"summary": "finish_queued flag is a redundant substitute for
wiphy_delayed_work_cancel: __ath12k_mac_scan_finish is always called under
wiphy lock, making direct cancellation safe",

"failure_scenario": "Every caller of __ath12k_mac_scan_finish holds the wiphy
lock (directly or via wiphy_work dispatch), so wiphy_delayed_work_cancel could
be called there directly — as the old cancel_delayed_work was. The new
finish_queued flag instead defers suppression to the timeout work itself.
Since ath12k_scan_abort already has an explicit ATH12K_SCAN_IDLE bail-out path
(line 5232) with a comment covering the timeout-vs-completion race, the
finish_queued guard in ath12k_scan_timeout_work provides no additional safety.
The cost is 8 reset sites (lines 5337, 5624, 5681, 5775, 10971, 13969, 14012,
15061) where a future error path that forgets the reset leaves
finish_queued=true, silently suppressing the next legitimate timeout abort and
leaving the driver wedged in SCAN_RUNNING with no recovery."
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> Changes in v3:
>   - Convert scan.timeout to wiphy_delayed_work instead of dropping the
>     mac80211-owned wiphy lock in ath12k_mac_op_stop().
>   - Cancel the timeout from scan.vdev_clean_wk to preserve the
>     scan-finish cancellation from wiphy context.
>   - Add scan.finish_queued so an already queued timeout work item does not
>     abort a scan that has already queued its cleanup work.
> 
> Changes in v2:
>   - Rebase on ath.git ath-current.
>   - Use ath-current subject tag as requested.
>   - Move the synchronous scan timeout drain out of the locked stop path
>     instead of adding it in the wrong start-path context.
>   - Update Fixes to the ath12k commit that introduced the stop-time
>     scan.timeout drain.

FWIW I'd suggest looking into using the 'b4' tool for future contributions.
It will help you with patch history, including providing links to the prior
versions

https://b4.docs.kernel.org/en/latest/#for-developers

> 
>  drivers/net/wireless/ath/ath12k/core.c |  2 +-
>  drivers/net/wireless/ath/ath12k/core.h |  3 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 50 ++++++++++++++++++--------
>  3 files changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 742d4fd1b598..95673d3be9da 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1463,7 +1463,7 @@ void ath12k_core_halt(struct ath12k *ar)
>  
>  	ath12k_mac_scan_finish(ar);
>  	ath12k_mac_peer_cleanup_all(ar);
> -	cancel_delayed_work_sync(&ar->scan.timeout);
> +	wiphy_delayed_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.timeout);
>  	cancel_work_sync(&ar->regd_update_work);
>  	cancel_work_sync(&ar->regd_channel_update_work);
>  	cancel_work_sync(&ab->rfkill_work);
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index fc5127b5c1a3..b6fd5e9dfdb7 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -635,11 +635,12 @@ struct ath12k {
>  		struct completion started;
>  		struct completion completed;
>  		struct completion on_channel;
> -		struct delayed_work timeout;
> +		struct wiphy_delayed_work timeout;
>  		enum ath12k_scan_state state;
>  		bool is_roc;
>  		int roc_freq;
>  		bool roc_notify;
> +		bool finish_queued;
>  		struct wiphy_work vdev_clean_wk;
>  		struct ath12k_link_vif *arvif;
>  	} scan;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 51c4df32e716..f53df8d4c808 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5162,7 +5162,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
>  			ieee80211_remain_on_channel_expired(hw);
>  		fallthrough;
>  	case ATH12K_SCAN_STARTING:
> -		cancel_delayed_work(&ar->scan.timeout);
> +		ar->scan.finish_queued = true;
>  		complete_all(&ar->scan.completed);
>  		wiphy_work_queue(ar->ah->hw->wiphy, &ar->scan.vdev_clean_wk);
>  		break;
> @@ -5254,14 +5254,23 @@ static void ath12k_scan_abort(struct ath12k *ar)
>  	spin_unlock_bh(&ar->data_lock);
>  }
>  
> -static void ath12k_scan_timeout_work(struct work_struct *work)
> +static void ath12k_scan_timeout_work(struct wiphy *wiphy,
> +				     struct wiphy_work *work)
>  {
> -	struct ath12k *ar = container_of(work, struct ath12k,
> -					 scan.timeout.work);
> +	struct wiphy_delayed_work *dwork;
> +	struct ath12k *ar;
> +
> +	dwork = container_of(work, struct wiphy_delayed_work, work);
> +	ar = container_of(dwork, struct ath12k, scan.timeout);
> +
> +	spin_lock_bh(&ar->data_lock);
> +	if (ar->scan.finish_queued) {
> +		spin_unlock_bh(&ar->data_lock);
> +		return;
> +	}
> +	spin_unlock_bh(&ar->data_lock);

if the flag is necessary, all of that could become:
	scoped_guard(spinlock_bh, &ar->data_lock)
		if (ar->scan.finish_queued)
			return;

>  
> -	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
>  	ath12k_scan_abort(ar);
> -	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
>  }
>  
>  static void ath12k_mac_scan_send_complete(struct ath12k *ar,
> @@ -5292,6 +5301,8 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
>  
>  	arvif = ar->scan.arvif;
>  
> +	wiphy_delayed_work_cancel(wiphy, &ar->scan.timeout);
> +
>  	/* The scan vdev has already been deleted. This can occur when a
>  	 * new scan request is made on the same vif with a different
>  	 * frequency, causing the scan arvif to move from one radio to
> @@ -5323,6 +5334,7 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
>  	}
>  
>  	ar->scan.state = ATH12K_SCAN_IDLE;
> +	ar->scan.finish_queued = false;
>  	ar->scan_channel = NULL;
>  	ar->scan.roc_freq = 0;
>  	spin_unlock_bh(&ar->data_lock);
> @@ -5609,6 +5621,7 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>  		reinit_completion(&ar->scan.completed);
>  		ar->scan.state = ATH12K_SCAN_STARTING;
>  		ar->scan.is_roc = false;
> +		ar->scan.finish_queued = false;
>  		ar->scan.arvif = arvif;
>  		ret = 0;
>  		break;
> @@ -5665,6 +5678,7 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>  
>  		spin_lock_bh(&ar->data_lock);
>  		ar->scan.state = ATH12K_SCAN_IDLE;
> +		ar->scan.finish_queued = false;
>  		spin_unlock_bh(&ar->data_lock);
>  		goto exit;
>  	}
> @@ -5672,9 +5686,10 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac scan started");
>  
>  	/* Add a margin to account for event/command processing */
> -	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
> -				     msecs_to_jiffies(arg->max_scan_time +
> -						      ATH12K_MAC_SCAN_TIMEOUT_MSECS));
> +	wiphy_delayed_work_queue(ath12k_ar_to_hw(ar)->wiphy,
> +				 &ar->scan.timeout,
> +				 msecs_to_jiffies(arg->max_scan_time +
> +						  ATH12K_MAC_SCAN_TIMEOUT_MSECS));
>  
>  exit:
>  	if (arg) {
> @@ -5757,6 +5772,7 @@ int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>  				spin_lock_bh(&ar->data_lock);
>  				ar->scan.arvif = NULL;
>  				ar->scan.state = ATH12K_SCAN_IDLE;
> +				ar->scan.finish_queued = false;
>  				ar->scan_channel = NULL;
>  				ar->scan.roc_freq = 0;
>  				spin_unlock_bh(&ar->data_lock);
> @@ -5792,7 +5808,7 @@ void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>  
>  		ath12k_scan_abort(ar);
>  
> -		cancel_delayed_work_sync(&ar->scan.timeout);
> +		wiphy_delayed_work_cancel(hw->wiphy, &ar->scan.timeout);
>  	}
>  }
>  EXPORT_SYMBOL(ath12k_mac_op_cancel_hw_scan);
> @@ -9935,7 +9951,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
>  
>  	clear_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
>  
> -	cancel_delayed_work_sync(&ar->scan.timeout);
> +	wiphy_delayed_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.timeout);
>  	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
>  	cancel_work_sync(&ar->regd_channel_update_work);
>  	cancel_work_sync(&ar->regd_update_work);
> @@ -10962,6 +10978,7 @@ void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
>  			}
>  
>  			ar->scan.state = ATH12K_SCAN_IDLE;
> +			ar->scan.finish_queued = false;
>  			ar->scan_channel = NULL;
>  			ar->scan.roc_freq = 0;
>  			spin_unlock_bh(&ar->data_lock);
> @@ -13876,7 +13893,7 @@ int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
>  
>  	ath12k_scan_abort(ar);
>  
> -	cancel_delayed_work_sync(&ar->scan.timeout);
> +	wiphy_delayed_work_cancel(hw->wiphy, &ar->scan.timeout);
>  	wiphy_work_flush(hw->wiphy, &ar->scan.vdev_clean_wk);
>  
>  	return 0;
> @@ -13956,6 +13973,7 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>  		reinit_completion(&ar->scan.on_channel);
>  		ar->scan.state = ATH12K_SCAN_STARTING;
>  		ar->scan.is_roc = true;
> +		ar->scan.finish_queued = false;
>  		ar->scan.arvif = arvif;
>  		ar->scan.roc_freq = chan->center_freq;
>  		ar->scan.roc_notify = true;
> @@ -13998,6 +14016,7 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>  
>  		spin_lock_bh(&ar->data_lock);
>  		ar->scan.state = ATH12K_SCAN_IDLE;
> +		ar->scan.finish_queued = false;
>  		spin_unlock_bh(&ar->data_lock);
>  		return ret;
>  	}
> @@ -14011,8 +14030,8 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>  		return -ETIMEDOUT;
>  	}
>  
> -	ieee80211_queue_delayed_work(hw, &ar->scan.timeout,
> -				     msecs_to_jiffies(duration));
> +	wiphy_delayed_work_queue(hw->wiphy, &ar->scan.timeout,
> +				 msecs_to_jiffies(duration));
>  
>  	return 0;
>  }
> @@ -15052,6 +15071,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
>  	ar->num_tx_chains = hweight32(pdev->cap.tx_chain_mask);
>  	ar->num_rx_chains = hweight32(pdev->cap.rx_chain_mask);
>  	ar->scan.arvif = NULL;
> +	ar->scan.finish_queued = false;
>  	ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
>  
>  	spin_lock_init(&ar->data_lock);
> @@ -15077,7 +15097,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
>  	ar->thermal.temperature = 0;
>  	ar->thermal.hwmon_dev = NULL;
>  
> -	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
> +	wiphy_delayed_work_init(&ar->scan.timeout, ath12k_scan_timeout_work);
>  	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
>  	INIT_WORK(&ar->regd_channel_update_work, ath12k_regd_update_chan_list_work);
>  	INIT_LIST_HEAD(&ar->regd_channel_update_queue);

