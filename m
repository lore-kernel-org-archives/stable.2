Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04F3612CF
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412876; cv=none; b=O51hbSS/bV9FJ6aBza3C+neW37D/p6ihgomg01qH0veV8FNbrnYwVt4uu9aodIcQYI5SzbxSpKZvJX3m7ly6XOfJTxBdesnfAf3UnsOwaTToPdDqSszKF6NP1v1iKYr/ULiPFd0a0pQMmSFcimVzk73eQyyX1bT7oDHzkBS9ePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412876; c=relaxed/simple;
	bh=v7LJnAu7y9CSe8I/im2BxF/SRbA91FcQWcmoQfZdh3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLZWOCmMrtU+IeuRzP0y+kfv6AuGPrwiNJJQbQxbQjxWCGKQqJ4H0v327sEmdFft6ditULU+jMSERSef36XksAqDZlhktzW7pxsej9sdV+6HT1br5agBqC5qOMfTkh2bBKD8QXIDJ7ubHV3T9hMAb9IiGquKy5MsdLGDZzsyZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=faft+BtX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zf+hB9+Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="faft+BtX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zf+hB9+Q"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJphQh1603077
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 22:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Idzlhue3W/MiDudz36WGyiI7d1evH1tZrrwWXspMl0=; b=faft+BtX2HE/IeW4
	lleeIq2SwP4EnIFne5+PZmNGRnOHhRqHrC7RY7FJ3YI67oy47EnFmq2SHVOFqNB5
	6Byqq8vXYBU5wXonHfdtl+XOkY/brzT4HJNtnhlw9llsCKKVyJfTen0UBAdOxs2J
	dxu7IGnhB9aOX5QIWW43Y0yiz5PX0tzaiXtVRZiCDm1VCX9GKgZqiArQkBMmRCK4
	B8zbK6U4AahzxT9Mnph5H9wnNPE5bfpaLp6Hfbx5lVKBP7igYEemW07KY3Jnyb+L
	LR+XxH2zuGKW4scv4TpxaTGNWZ6Gp8NYvWFNiJEU7IKR739ZOYOpbIFv1M2PktaW
	EYjoIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc1p3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 22:14:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7049fa552so102852a12.2
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784412873; x=1785017673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Idzlhue3W/MiDudz36WGyiI7d1evH1tZrrwWXspMl0=;
        b=Zf+hB9+QVOL3njqcRRqsHqTsbb0iCNlB41zPtWpiodMKTwhwUiQfhC3MkN0qWxbXNr
         c7Y7F3kECEGNjmD0qdkmj4AR0pnwXswOsQOgPaOJs5S8SdGKYOSy80rEBmvOmrVNoevR
         MhBVqmO1qhfwvxSZo6PzDUCpke4jBH1mJ7g2LNmPHs+T+FQMxFxLUcylhMXXYvFmRkem
         2vlOD9bNfMTZM/V4cKpF0jlmxxv4Qiu/ykWGYLONDug9cCrsBrtdj6DiECXK9OXaPnYp
         i8lmtNMC00uO7B9CtK4IDOBqDq0ILiQuzlIjbbl2IOdxK0zUpHDR7cYYVGiF05yXDiys
         hFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784412873; x=1785017673;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Idzlhue3W/MiDudz36WGyiI7d1evH1tZrrwWXspMl0=;
        b=UT59TVzTGtR9Idfj+GvrwvSb8lnB1EtClpFLbqid8DUP9hEowN6MqyCkIM0qwJzBQo
         PRvqPP4YYPRVmrCa6G+5Pgp7bjvqSBf8AeuTsWpxC9YPVYHWeQNOdFK8RPl6Ebms7ICT
         jx0be5BWWK8uG7OHo1HCwNor2nlDgXVyDw078SXUaKTcUL2VdpTxh5RDh3N+IWQW3748
         t80weVV59OL5z3JgwPgh5d1s9HA+aZ0LhDEib2uYgRwkXsz1XEnMtYtq2MrGQ/X0eXNJ
         BJ4rs+GSsh1x61SsRPN6Z+kzVIryDaqEpwI1NjfJ2a4FX1f136VnfnFoIp+GQB6FchfQ
         L6yQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMk0GhqJiTon1TwGknQcp84fEbuQLAyy74CnWtHfMRs5UiG7SLnpEbTGFx5AyZYnASqKnPG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jiC29pwZI1t/p0pPPjmoINKwStcUVRfOQg8I3Zt8pZKz6G2H
	TBhCXafkSFxFvuDONPiikCP5pA75nsuCaKq/+PbPYPo7JMvo6dY6ZH3AIZ3br2jPPSYaxZXzKMx
	cKXUF5P2Sg+HiDRbqs5zQbkcmB4gv9EDYxoRSdZlVa8k+7Qz/Ww6U3KvYaHoURw9ABv0=
X-Gm-Gg: AfdE7ckViHnuaxBpSfjo7KvLA1FkwcTqGQ7SX3RpP9PaVa3jbRf9WGRtNzcd9SeyLJ8
	pPbQu2mRUlNyQcNUgO50oXUc8180sIaP1dPh/g4odz5ci6dV2ChcYP4HCAC3IgQoPr1q3MAFGy8
	DupTthK2Yz338vYJpHn38Za2yrAiLV9C23HrGtfXL2ynVVguty9RW2gSmvZHlCjoDvtjNxuqO89
	K3j7wQVjFBQpK8dOVcWwbOQUxb6g4wwyb1VuvGm7wWynEcuAsHvjo7IkjK0lP/ZLM96ls2pexoR
	U+M3q4OLE+1vMW6Voj2HHmDc88336U8FxrgDc2qoDDyfYaZBRbYQB2y6Cb6QTyYl3AJdJVOdVq0
	DKkbCdh3IDKDIwHGr
X-Received: by 2002:a05:6a00:1486:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-84c2957cd43mr8463630b3a.76.1784412872808;
        Sat, 18 Jul 2026 15:14:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:1486:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-84c2957cd43mr8463611b3a.76.1784412872269;
        Sat, 18 Jul 2026 15:14:32 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc33easm3367836b3a.13.2026.07.18.15.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:14:31 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:14:25 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        rajat.khandelwal@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: mpl115: Fix runtime PM cleanup on probe
 failure
Message-ID: <20260718231414.07ead912@jic23-huawei>
In-Reply-To: <20260718061909.428476-1-pengcan@kylinos.cn>
References: <20260718061909.428476-1-pengcan@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzMyBTYWx0ZWRfX6R13LNw9wqzC
 maXfWo/eHqERtVAWwHb0YY6IO78JdhLbFcdf9ReU8KdF6RsGosFTaYAaidvmhxalElQQtDfkq6n
 SdDQLlYrB0CfV30WFclcKoZ3+fqaZRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzMyBTYWx0ZWRfX04eV9Yz9CTUw
 d802ld9y7A5VtGsV5+o6CpRvtw42Qvc4q3FXQIdtPDQKIYbXyxt2jkz3N/4CMiaQCgT1S50i3kv
 LcwGxhazYlxDyP/vOMbcehcBb90u8ls2ugsBm9MhdwzsM9vxEenyE7tZlTzm1jMCNnjRS8V11fp
 bYmqN85h3awM2u1zT4aoqHpoRFSnCVaGU8OPDII0iGiUXu/wjmA3zKmDH8Tm4ARakrwerzaw7x+
 iiwXAwJR+HBk0zl/8T3erzcRBcyB0IlUNxZ0t6COpIjxSP+TggD2u20jP5+nUvcdJ9IKVLrrkmV
 BMO9TRf3uoWZkYcVgdl2V5j76aiVjCjyq1xW94L6CsctqsHllm9BLWrtD0r1uvNC2JvSz3pa24S
 SZKkiUNKirqthbSXsjjsYBkjGfy3FYOSzxHMyffkybUXmc8k6OVqLyt1N79Ap5OeiSerXuNKNFw
 QctY4FzqXXMjg08whkw==
X-Proofpoint-ORIG-GUID: -VT0SaonlyDr5wy4CIK8Swm8_G1ESL_8
X-Proofpoint-GUID: -VT0SaonlyDr5wy4CIK8Swm8_G1ESL_8
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5bfac9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=-D4sB8j93cQFzHUrTu0A:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180233

On Sat, 18 Jul 2026 14:19:09 +0800
Can Peng <pengcan@kylinos.cn> wrote:

> mpl115_probe() enables runtime PM when a shutdown GPIO is present and
> then returns the result of devm_iio_device_register(). If registration
> fails, runtime PM remains enabled and autosuspend remains selected.
> 
> The same unmanaged runtime PM state is also left behind on driver
> unbind, as the IIO device registration is managed but the runtime PM
> setup is not.
> 
> Use devm_pm_runtime_enable() so runtime PM is disabled automatically
> on probe failure and driver unbind. Also unwind the initial
> pm_runtime_get_noresume() reference if setting up runtime PM fails
> before the matching put.
> 
> Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
Hi Can Peng,

A similar code pattern came up recently based as bold claim from sashiko
that autosuspend won't kick in if we don't do a get / put pair.

Turned out not to be true.  If no one touches the runtime pm counts
and turns runtime pm on, then this line:
https://elixir.bootlin.com/linux/v7.1.3/source/drivers/base/dd.c#L872
becomes relevant.    That ends up calling auto suspend.
Please chase through this call sequence just in case we got it wrong!

Hence I believe this is a simplification change that can be made here.

> ---
>  drivers/iio/pressure/mpl115.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 16e112b796ba..9e77b76bd1fa 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -204,8 +204,17 @@ int mpl115_probe(struct device *dev, const char *name,
>  	if (data->shutdown) {
>  		/* Enable runtime PM */
>  		pm_runtime_get_noresume(dev);
Drop this get_noresume()

> -		pm_runtime_set_active(dev);
> -		pm_runtime_enable(dev);
> +		ret = pm_runtime_set_active(dev);
> +		if (ret) {
> +			pm_runtime_put_noidle(dev);
No need for the put here
> +			return ret;
> +		}
> +
> +		ret = devm_pm_runtime_enable(dev);
> +		if (ret) {
> +			pm_runtime_put_noidle(dev);
or here.

The switch to devm_pm_runtime_enable() and error checks all look good
to me.

> +			return ret;
> +		}
>  
>  		/*
>  		 * As the device takes 3 ms to come up with a fresh

and the pm_runtime_put() at end of this block

We don't mind if auto runtime suspend happens a tiny bit later.

