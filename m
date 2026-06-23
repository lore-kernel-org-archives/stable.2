Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947830C359
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196613; cv=none; b=fUDhfAjBzQrhBWtM3l2jkkj6/zsjciW9oxH9u9eKDyjGxc90GfxMa3GelqkcPd7zZoImHDa/ZfgnUVDMnT0OXPIdQlMRyhptGPI4qG8lO4KRRxaZsxs9ks/sQmT/TxmVTFewbSSEfVriQK1tqG2xbmkKbcICr6boQYqKUcIiiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196613; c=relaxed/simple;
	bh=HvfT3V4qHXX4Q3TEtA3xjNzmOuZFUM0FjS2LbCWUzvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oml3X/mZqt55WaoUl7rfLEbGl0zp3DkLJ09J6lEgH95/51ZDEBAkISmc3jy663eNg5PQf+YnvBNEHR4bkfCEZaCYVJiFPjEJ+wW5SXXmCEWXUxXV3OYQUDh02NWNcA/7IcqNoSvbMAF2QM02OuNjx47vfBL60Xbq252R21tdZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QoSYddcl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ADwYCom+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QoSYddcl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADwYCom+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0hhWP3880233
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d9/AbN3a7F22nio8mD/H32qBZ/8mBjgv27wzLG2E0Xs=; b=QoSYddclNH2b5vSx
	T3bUfNOkQdN7KyXCNuvnC4H2C9DB6KZpqvsU1GMb78VMlATWScg4d2Fsui5d/hwS
	HCIOU5Jt2OxKSNgvtdWkaDWHpNLfgE+Mxc09dQ4vITp0G7OyB+lRS4oM/6hZbJxu
	RDFlqbi5l3OHwoh40MiSSPjcSZnh/rEug2WVWFeIgSZWsmwvZIqtrh/g00g/jDZj
	ezDP+pvIfV6Kaoq2ukGkQA083OsbmMjoND530aHlliGg6IzRH5Vlm+WIPCqPqj20
	WjAE8CqOzAmuCCe9PenqJ3Bg8dNjMhZJ4I+2EPsfRv8CcfDZX8bxCD1RcAd/Cz3n
	8BGI0w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn3arb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:36:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8422b544a4bso3445436b3a.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782196610; x=1782801410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9/AbN3a7F22nio8mD/H32qBZ/8mBjgv27wzLG2E0Xs=;
        b=ADwYCom+hXyrtI1vB7uPfHcKhDa3NG5TXxqQCau9J6PyHHtkxo+t7LjH3I43ye6Bd1
         4RqlrvL3JSaKaoH3OMY/mWxYBhl6CGLMJQSwhQgtMSuYTBLDZF67BNkr1jFH0r9lHg7c
         d2OMtlTM0cIFsR3XxgEPgx+p4KML6hC3PqvaBZvZU+rlm8+gB4k/5l7LJlRE7SrpYxFi
         pA09lGJADA47PkpQ4UBw0e1ie2/e0zWvSEijkqrCXJVB+K9XIxKO++RLGTnoUgDEmGIM
         xELjzl+YAcTmDlzMtJLIPcTieSe6qQ4MqbWhs4HM33dld4URDHhvv92mQPLDeV4jQP6U
         /HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196610; x=1782801410;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9/AbN3a7F22nio8mD/H32qBZ/8mBjgv27wzLG2E0Xs=;
        b=MpG3KMGZ+WOAklMYj90V+jICSlOHRy94j+QIpMkmCz6u/xZ2ZNT2kmLH+HHu0KhDFg
         brMazcNlwFRb1Wvz3FmOOrxCxbwpOH4ad9p3WuWI5ydE1j7ZbyCtR8CO4b9rsv1ghPs+
         hqzZMWDb/YM8TGurQzVK+m4uBZwwL67gOGC4s8Twd3vguwDeD6CJoPaM2TxMgsczZNjY
         rqVcXNnIdz5nuDVRIgv3KNq7X3a4iiMTMhzi8gr2jkwpymf2c+sa5FOIlcITuUkfTbHT
         fbW0hvkzzTC7Z4yxjSbhwsmgW9Z1NmT19nfuIJwRgWdW3p/NBjrwB1kROsfRYvhNOnC/
         9oyw==
X-Forwarded-Encrypted: i=1; AFNElJ/Hfbj/mvxr+1Il3NERTWlZDOrI/rp+d8KY6IuZKFWYZf0CwbTuV5cJURNR/lsoUE5WTf3RNHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8iqCHWPJp8cyIhIcJxZ2E8RQ62Nr3LBtW25j91ZBN5rej9gG
	CcMc8RfuIFjTSMe1EdfKsIrzL1fObjEOV0qlgfUx0CwnYxehT3PL5gG91jbcV5ZlBknP4ZUBHCi
	AByKA+IOWOITcRLKlb3qlAqs0WWy5t7XmYqU9BoL5No5UFdKZE4Ojqf2NBwQ=
X-Gm-Gg: AfdE7clWlpYB3Btm2xeBiWgZh4CSm3UO+dJvSfMtpq29TYeSvvMbWfYRQkXs4hi2MSB
	Tn99sBqnlVkj0VZuFy9jYQHZ9OX6UnSDhvcDgYu2whEw21fBC5LYH6Wfn6h+cPzohPEzPvbmITZ
	9MrVAbOfZipM4O5SXOqxaBDC8mgWXdLTs6R7UyuyebX2gKTAwCwyDaYoAIzvZHnDBD+g73lGuyy
	MwAvqNQeyel+mXYG9h8sjcOrap2x6EdKVPLKKqJ0oAHYCHh7ow8TmCdbbrQQslAzG3Py1HArTI6
	JtQhN+KiH+I/AeEZGnwfbkPzqxu+y0x2eUrXfBQUcIAy1aIfqsAaKHFjsTC7XDx1Sm0h/1HTSVn
	kaYIjPbxYJhyi8Rlcnp8G9nXz1NQjmu9bK5Jgjdykew2I15mwnuA=
X-Received: by 2002:a05:6a00:3d56:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845625b56fcmr13936140b3a.41.1782196609769;
        Mon, 22 Jun 2026 23:36:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d56:b0:842:7476:2376 with SMTP id d2e1a72fcca58-845625b56fcmr13936106b3a.41.1782196609327;
        Mon, 22 Jun 2026 23:36:49 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c2d9sm13066301b3a.6.2026.06.22.23.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:36:48 -0700 (PDT)
Message-ID: <89700bcd-150a-4730-a7f3-fb4ea2228689@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:06:42 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
To: Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, kvalo@qca.qualcomm.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oIZPli46zWOBZ9h9Pkb4YQoudGhNFxEh
X-Proofpoint-ORIG-GUID: oIZPli46zWOBZ9h9Pkb4YQoudGhNFxEh
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a3a2982 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=SGTO9LZbqZ65YKTLchMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX8QuQkgYn7WRS
 kcehRzlHxA2P5irdMTfjUQdx9s7/ZkjmsZ173oiCN7Hj3zk6+9qFckYiveF0Xpno3p6n1amPl18
 pyd+kRwoWaVR4Q6a7o2u3T/bnXuPVXU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX9J+zSxsSH7m6
 zLcjpkv0jVMEP2mWOwP8yd/7dlNQLwteyCJ6Wtu6P6Ej81fDfrhvin0PkIo2rIbcZ1c+NbJuhuQ
 mQcw9B0PqaMInFuuEG963OEMnLP6ohZkAn06/U74CK6HZUcNyXINuctiIrTAAJlmmph+CKpxwRw
 4bBljBSOMIubp2f4MwY3lM8k8OIdIyWLS7QXnkBt313I3A2hW6lfQXa2quomWX0PiKJX0l1e/UG
 jTMgLRLdNRfdHTfEtp8RtZkai4yiDamHzK0/gwwF3NvJYd8047BGABUfQCqo5PGZTw6Jwg5HLDw
 jTKdEfI6rjIscESG8q72Bl2aqy7l0BMSLQo0tgZwwYu+Wuq9KnPr+q4wxiChcxfmrhWT+r4+zPT
 l+AQqHTDBDaAoOPYG15HHHtpJPrUTIQSydWK69M360LuQtQC0FP13DXEEtDocf/d/tQN0b5ImGD
 PcfbvrXwk1CuVTCqPGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230051

On 2/7/2026 12:22 AM, Daniel Hodges wrote:
> The aggr_reset_state() function uses timer_delete() (non-synchronous)
> for the aggregation timer before proceeding to delete TID state and
> before the structure is freed by callers like aggr_module_destroy().
> 
> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
> is called, the callback will continue to access aggr_conn fields like
> rx_tid[] and stat[] which may be freed immediately after by
> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
> 
> Additionally, the timer callback can re-arm itself via mod_timer() while
> aggr_reset_state() is running, creating a more complex race condition.
> 
> Use timer_delete_sync() instead to ensure any running timer callback
> has completed before returning.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>   drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
> index c3b06b515c4f..25ff5dec221c 100644
> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>   		return;
>   
>   	if (aggr_conn->timer_scheduled) {
> -		timer_delete(&aggr_conn->timer);
> +		timer_delete_sync(&aggr_conn->timer);
>   		aggr_conn->timer_scheduled = false;
>   	}
>   

I am not familiar with ath6kl either, but while looking through the code,

aggr_reset_state() still calls timer_delete_sync() only when
aggr_conn->timer_scheduled is true. However aggr_timeout() clears
timer_scheduled near the beginning of the callback, before it walks
aggr_conn->rx_tid[] and updates aggr_conn->stat[].

So aggr_reset_state() can observe timer_scheduled == false while the
timer callback is still running, skip timer_delete_sync(), and then 
delete the TID state / allow aggr_conn to be freed. That still leaves 
the UAF window open.

I think timer_delete_sync() should be called unconditionally after the
aggr_conn NULL check, and timer_scheduled can then be cleared afterwards.


--
Ramesh
