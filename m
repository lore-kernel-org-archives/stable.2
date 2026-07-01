Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F552431E68
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938839; cv=none; b=b/srxrmsawwquRrxrIGn2Vq3VqesmMFXwjfde2fGnPV7vBO0hTfow76jrGu8dnw8HCQ6Nlj2YoXAzGmi8IohOCDdY7aYjzOovHH7Lzqcp7qXH56EbkVPFSRt0pFwLsHmhE3qprOvWftNBAbujUMbgO8iRHOLGg0byXDzI1Piozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938839; c=relaxed/simple;
	bh=MdFcTJqT3Oi297lElfbEEF7NLj+JnAFX4C8wEhg0xQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYGMHUTXtyoXH1b51sAEIURZzoxfw+Uc6LK4820Fs5OQl/GVWuqGRoNsiZb6zhITjOqQwEzJMUYmVSlZhWqUAbVg1sGyv+x5CQ1w9jPuFtaDBb9yNURq+QWEMqHAYhsklw8bQ1ect7SaBfinUhqCCe/yAs61KuorbxkvaaDR4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aw9X705Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ScD5HsHB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aw9X705Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ScD5HsHB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661HQ7Eo1776967
	for <stable@vger.kernel.org>; Wed, 1 Jul 2026 20:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/sttupdXtbOiw7pCs/wPsIB8AemcBxmj8NduVtxbWo=; b=aw9X705Qo1L6Ovd/
	eTeVF8FpPTtf3BQE+Q7lP+lp8yz/Yb9mqBTJtzUaJ5WAtjnunqIXASyncLXDhZAb
	uq8fll7/5pE58S3z0+eXMzIEEP3E4mIicZqYWQQIy1HyUW8nIjLmSnsIoDPcscb1
	k356hU2sz/qc7Li5RhKZVCuSPF15BPUColrEIkofStXUrG9wpaWnDpLv+Y3XWvsA
	tT9r4ACcG2yjTTuTNxNnh41IhYMkgDek0kyfLf/c6lAwi1/aC94cVGdNLWSf+JZG
	1nJlzp3fJC3vtDnFFkuystsmp4qlNQMOIOHz4BmSoNUTKNGZ2/cZHA7xZqnk8bb4
	Sz4ytw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f579rrugd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Jul 2026 20:47:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so1347704a12.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782938836; x=1783543636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/sttupdXtbOiw7pCs/wPsIB8AemcBxmj8NduVtxbWo=;
        b=ScD5HsHBV1iC2dEmcz5YO8LyyCVx2hJWdX+9jlWi/8KdV9BTt8642uEH5SEON8AcWE
         b5YQN/9ZhOoETKqHh20zPAfcU9NU3VSC0wr8kvQandj0kVtwlugpOnibKchFnm5fSD5B
         mlPLgxjpq34znKSPPdwXVk3e9m3skp/HJ8P4/DzCf3iNpReD+lfHBYOnfrOE+cUQzVTh
         b6BAy26PoNpuzUXRyC8Ji86yzYfdja21C3Fyc3j00X4OBV0x5MA30QBkgdc0hmyz6/60
         A1OPallgS7R97gnVBLkctNf/1DYmOjO6o1c7SsBlBB14jp0bhkeeT4AFktWOHsZav9Kb
         KD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938836; x=1783543636;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/sttupdXtbOiw7pCs/wPsIB8AemcBxmj8NduVtxbWo=;
        b=Kmoml+rpjuPVT3h5G6Ii8W7IDLmov6evpQ26mDcT4p8za5lIGRr8XqotYBVxRLsUpr
         v6Z+rFxH4HXUeH0CQ83RdSCwtxdaU7xihfjslVEbmKZF0b6ydhA27sFj+u/2nHV9qQum
         h1BbvjsQY810kSbPQTHmVJxsUaL4I/iZA/rabmGoNtV2H4+0wSShbT/oN776+9DXHj8e
         +mhDhh2JNC+JT+FdIYAUGgoCeo4YXqL9rPXZbqLWEEDeaDPVFNE2rRxyblRJakzoXkfX
         pF1jjLsuqC+tFoKuLyD59dE/Tg0p4+tbcY6/6GGXMKCYZnc9/mkIUx/XnagyU+GqKDpl
         wYWg==
X-Forwarded-Encrypted: i=1; AFNElJ8v8BFhh2kwBjzH7PSKSMXE/olIVuJQM9WvGuo7opQnYforR2cIDUKyvIfHpsBhoOhKsUfxDTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrOpBYBlbDIlBww3fZUL+eCpC1JP22Se1APyN2A365Ml7om1k
	QN2ouiInnGiT0+b4q9f2ugjrwkK6OJu3NGeY4iXzawBZ8aS0SQUvgylVCSC+F6M1WVES6BmGXSB
	VsZrY0zlhKnVoaafBQ4RFFEDLaTFFIXErGckmWGTT7r5vrhZeDh9WskT/Wgs=
X-Gm-Gg: AfdE7clR1yknBgIoHoJdTOh7Gm7Z6ulkcLQ6UW6v10dZQUKOKfS1hCXYNAHYMrasln1
	STMBLhJPVn7vVubFoEWHtqKl9RwTXEqbey/yUCVWEjupVHw1t7hSxWv55BYKoJqoRMJNrZ+/JXV
	G/vQfGJ8MiWdkGGJ0MtvC2es5CSqXcRGwp2kbbFX9x4RGDkZqUqtOKUMAe/9Eo6nE91rEiPt1vj
	bLTeXPGNhckLEwaB6H1hjCCy5O8VluHQXjTUOqVoFRBFQhl7UoieeFFWAiaUILHPQX2kv3vEkyG
	DlQApOv7QE3Il+HJNQK7prbQgzvGs/pEgcLYVY3d2s7mPi3qXt8PugeVwq/NilgfWa4f/feCXy6
	8l39jn2U/xzDNFsFeHkXIl7zSfePCm79aNCEFPTcvgtlzs96n6xfOt+y6D460ewfVNRHs
X-Received: by 2002:a05:6a21:516:b0:3b4:c9d5:cd5b with SMTP id adf61e73a8af0-3bfed1bb842mr3860117637.13.1782938836063;
        Wed, 01 Jul 2026 13:47:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:516:b0:3b4:c9d5:cd5b with SMTP id adf61e73a8af0-3bfed1bb842mr3860091637.13.1782938835597;
        Wed, 01 Jul 2026 13:47:15 -0700 (PDT)
Received: from [192.168.1.11] (222.sub-97-215-84.myvzw.com. [97.215.84.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc544sm1299199eec.25.2026.07.01.13.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 13:47:14 -0700 (PDT)
Message-ID: <152d4362-c45d-4d9d-af5b-d1c8d3d04e96@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:47:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath12k: avoid flushing scan work under the
 wiphy lock
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, jjohnson@kernel.org
Cc: kvalo@kernel.org, quic_kangyang@quicinc.com,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
        stable@vger.kernel.org
References: <20260612032701.1619188-1-runyu.xiao@seu.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260612032701.1619188-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXwPoEHuCH8iWR
 y4YFt7GJQKykfCIHoa6oVrNbXeZOyNN0l67pyGx7FI0VPHqX3O1XNJqk84sbX6UeFCdP0NmCCXD
 75pNP6F6RenibX15NIrmP0ykPc5J8RTffzqBGjMKaEwck5fXr7Gz/AJ1rEDtXs7Klob+PxQtXpD
 0ZnBzPDDaT+CVGb4QFVe5lwEkc+gblcrvotCKlZsgJwN9TIWn6K7XCF8R4T5/wbE5wijhEb/PW/
 DHCb8s30jaFQ717yb1lvRTdh6WmYIGPpErCO0+kMWSUGfSn9lazra6cTnDPpjdwm3hh3eMaDIMQ
 Ju1KPC5rjtxpHmmWGDEHtFKNpjYR6zPCWh8Mr/DfExK4nf4dfFOmTE666PxBOgUdd5gQjJwCbDJ
 g9gWt5iPQmLSIPxbLQR5YUBuKnSuTZqDblNnCBg9fcc9eowlAniUSz7dkCWbm5F/s0Gqnd2JfAj
 Df1n0H9C9p3xdDwqpww==
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a457cd5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=i4k25I72rCCN9bAAQd7+Jg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=gSjTWOtbipEii6uOW_0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 0I4H5DLxUdgJbt7aFjkxuGbazar4IlXa
X-Proofpoint-ORIG-GUID: 0I4H5DLxUdgJbt7aFjkxuGbazar4IlXa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXxJfvwlqEbcbi
 v8vMJP23CU07XcrVxkRpflJTfXDSMYEM1iE1cX37fcGepGcAgUdDIF2IIlrZhvgvUTeoCY6Dc/9
 3iLXX1bWANH8eDzKGvzaQseYEGr2NXA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222

On 6/11/2026 8:27 PM, Runyu Xiao wrote:
> ath12k_mac_op_stop() is entered with the wiphy mutex already held.  It
> then takes ah->hw_mutex and ath12k_mac_stop() synchronously cancels the
> scan.timeout delayed work.  The timeout worker grabs the same wiphy lock
> before it aborts the scan, so stop can deadlock against the pending
> worker.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> The grounded PoC kept the ath12k_mac_op_stop() -> ath12k_mac_stop() ->
> cancel_delayed_work_sync(&ar->scan.timeout) path and the
> ath12k_scan_timeout_work() -> wiphy_lock() edge.  Lockdep reported:
> 
>   WARNING: possible circular locking dependency detected
>   ath12k_scan_timeout_work+0x25/0x42 [vuln_msv]
>   __cancel_work_timer
>   *** DEADLOCK ***
> 
> Drain scan.timeout before re-entering the stop path under the wiphy lock
> and leave the rest of ath12k_mac_stop() unchanged.
> 
> Fixes: 2830bc9e784f ("wifi: ath12k: implement remain on channel for P2P mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

This patch does not apply against the current ath.git tree, please rebase.
tag ath-current instead of wireless when you post v2

/jeff
