Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9043B1ED7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434104; cv=none; b=hCHu+8vurtpQKffxeiLWgFTbG/KzIa2Cw2AVxCUTHlVfKxtbTJCc6SAmh+ePv4oOeBxvwloIS8FHc963N7FHNr2V5JsD+sCt8mIXBzCcxjXNWWxXzN983NMW1cHP+q9sXJIPRJN7OnPlebK6TzTNHDT6ZTlDD0ZeedsyOpxCVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434104; c=relaxed/simple;
	bh=iPCNerosbo4Jfg+IQoZoErtJ5EEDm9uiWHnZRdO1/hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv3aK5WglO3c3w/xGA10Xho3PxWhdvsDmK5sbtRiOlgadhkb2sKhV1edfQUhmA8SmBiXCp6kIa5JnBTLHcOZjRF/9t1YqJrYnWvO8ZIoSIVBajVY8TZKryBtamVEOYO0qwVgiqi5n7LZThMyH+xYfcFJVKaJzDQtE7XD1p5QGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lb9XuRrm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=asQfxqNz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lb9XuRrm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="asQfxqNz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AHDgr327131
	for <stable@vger.kernel.org>; Thu, 3 Sep 2026 11:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lz0OEqSGbW8F7CVDGnfMLcxZ7fyADNJyjt3Y6EUKNBY=; b=lb9XuRrmltfl6Z79
	AA4xBVmMbJ53trlzoA8ZhpUnXj83wUkuEgnL04xypF4ugEBxbdx4jgghjzdJuERT
	B2XBm1SCP7d8A51+SU/RSYhlhXMJNZH3W4O25QA1ZCsS9WRzS+LmKWhtye1xJkH0
	Hl3FeLoKXssQRqYyC2/on1JVFJO6g88E2RH2LPE0eQta3NngYPBgUmCe6rISI1xN
	imcn59H6o2DZJjd0JbrlKLY1g7ca+PzRhGju+V/VaYkTBELa2E6XNGI6iGFjNrOk
	f5hziLodyYWkUNDN6HRSQAcPNpcgN0q8o1B5rpxATeBTGSUlqyL43YxHkKpaYkAu
	FV/u2Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekgxdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 03 Sep 2026 11:15:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9394ad7f64aso436693785a.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788434101; x=1789038901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lz0OEqSGbW8F7CVDGnfMLcxZ7fyADNJyjt3Y6EUKNBY=;
        b=asQfxqNz9ReIdBjPWifM2xaX4avffEPawu6kLi1cxUMHXrtfupE2U49uZdQH/I2ZbN
         k4Y+BfRUJRZ+JMhLtf0d9l9lcmrSIiEt6+y3DRwXv/KjxZxdTMAjVUVS3imBSnJPcUKN
         3wMQLC2OWa8E0M4iAxZuEvy7dVehTARk2sxZ5pVJrtsLHBemEzIPtauekVvIOOPaKF6Y
         pUiEF3/msLtKd6Hc3fpG2v4/WzfroV8PhV5hYzsNSYe8N4IERxPx5+8hQme16mWXLxb5
         b2gV0qhf1/zhiBVHuIW7qHHId0+qFgzgdGObNGp19+pgP5LmJBZk52xGty4Rkw2HLF/+
         5KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788434101; x=1789038901;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lz0OEqSGbW8F7CVDGnfMLcxZ7fyADNJyjt3Y6EUKNBY=;
        b=hpadgMWf2EJ6RqEVBFqG8TIgyuN+vja4QEolceleuLgUtW9sK336msGFBWn6AKhF2P
         w/YYkv//Trl+lcmDvTznRIU6Ku5B3FSBvMr9Un+gjkH1Tt03+9rNSoUxzvN1mNvvkLGn
         erzOcaHXhmIbEmNIL9TAwD4tdTnzSMD6dDLD7xKtZQepLEgLcUCuivcMfzPa/rdrSODH
         XwH9UA4zgzjXh0WnnFqCEJAHVklh/YfpnEZb3yH5UHzLeEvX2UF0cMpoeJE2fx5IdG+z
         dkKD8u6ULc7tFFLMFrUbQXU3aHrJT+PvpejNzXZNEfhGWbSZrPgAXulmoLFXlrMv78s4
         IK7w==
X-Gm-Message-State: AFuF++lxq2hkpMvvaUP9hIAjgZgzAbml4THs2VXwU5B6dOHRemAfA0C7
	wQtiVslg+R/jvQw0WU3UIGMdw71qzb+92tLOhKPEnD/GPFhq4wiJM6lSaG1j2rXsi7VaFOD9hdI
	Gw+Vn4D+EjtJGoXnmQZzNBDiaA7S2WdqlkCpi1jIhRd58dqoAzgWiXoeqOR4=
X-Gm-Gg: AYBFou1TOEjtSHbpujn3to4IeWvTQr0nQFu8G77uOgznMFCcDLsU5WLxf5yesQtR2bu
	A74zznY+vip4K69rZKlZ24BXo8DCyl71OkeNO0txjOD/IAy6eI09hu3NdCpWUf3RH+JRDNWPykk
	SnxONmrynrLe2XyoPxWrmM26q+mMO0x/iTg6xCrA6hsWPbRxjgyhKBUdJZQ982S7OIcb7yLys/M
	bsH5aCcj616tjUBDF1bC0Sq3oV9CzkVYAzAWK1e/QrSz+GKtyjQ+CLsWWPfWtcMg/W5iRELxmVT
	57LOnshxqjG7PQd0hIcfS5QcKcyx15KZUY8zXeSsnE4803bWIGuwvfWq/H4kE5tpGn39v3zDBmC
	Br2TjnTdJE6/wOVJ6575pt+CwSJI9
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id af79cd13be357-93960ef3c8amr1369344985a.24.1788434101496;
        Thu, 03 Sep 2026 04:15:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id af79cd13be357-93960ef3c8amr1369305585a.24.1788434098304;
        Thu, 03 Sep 2026 04:14:58 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5dadddsm73748635e9.9.2026.09.03.04.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 04:14:57 -0700 (PDT)
Message-ID: <34a028aa-d17a-4a59-bd1e-26ea784a8401@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 13:14:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: Fix setting completely bogus rate for byte
 clock
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kavan Smith <kavansmith82@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: l8RiJopDXCrZFqm1235ZMUlUbRs6BUdl
X-Proofpoint-GUID: l8RiJopDXCrZFqm1235ZMUlUbRs6BUdl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5NyBTYWx0ZWRfX10TrQ2fK6dM9
 GL6NpJ4O9yuIptek52cK5LBpqc1ZjIpZQdTSLlOs2eAXye5KNoJU4qdeaXr6R18P4w1XVCeBQ4l
 5APivAUUvZjOMzqAWgiD4dGztgknqmGNVqZefVXXlY1H/bibnWZqLhln0JG6d/k7hJn7G98UCcS
 iDiNLmGVHZBbMQUYjuLLgN9I1eOapgbCHqC+GUtnXwOcpDXOWR91DdROsXnJhOQgafLCnZ0UqQE
 KdyU/P/gavG/MX++dm5acrLYIA6NZE9EUVM8sdhXZzy0a5FQYaHlulhwCsNr1kdoYqpwCfsriyE
 dEnKRC77A5svstfP+vZNZ2Now7UHo6RPEAbuCmr5fWd5UalR5otz0ecv6aiSLbUD6VqJEU9jqSy
 Dz+WyZiq1yufyee6BSCNrWc3KGDhVbfLKDOhTn2D6NtLE63WBxZ0VVnGt/aLivLC+6QUqwawTQq
 G9HWqXBSIv64RdrhpNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5NyBTYWx0ZWRfX1eUfcEqetCpN
 FLD0kgnQ9Hyc+pzUpfFWlf/SebtjmsUWGsVAHGJi16B9hX/BmBy8UV1cecRPjCSFpRSsfD+ZBET
 QUAxRiVmUok2cdfLLTtueYQufunT/AI=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a9956b6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rFN8pUq9rjxbytSTOF8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030097

On 03/09/2026 12:47, Krzysztof Kozlowski wrote:
> Revert commit 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to
> the PLL-achievable value") because it is absolutely untested on newer
> hardware and obviously wrong: it rounds the byte clock when the byte
> clock is not parented properly, so the rounded rate (used later to
> actually set byte clock rate) is 19.2 MHz.
> 
> This broke DSI display on Eliza and probably SM8750, Kaanapali and many
> other new devices:
> 
> [    3.164727] dsi_link_clk_set_rate_6g: Failed to set rate pixel clk, -22
> [    3.164729] msm_dsi_host_power_on: failed to enable link clocks. ret=-22
> [    3.164733] dsi_mgr_bridge_power_on: power on host 0 failed, -22
> [    3.164760] msm_dsi ae94000.dsi: Power on failed: -22
> 
> Fixes: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
> Cc: stable@vger.kernel.org

Actually this was pointed out to me, so:

Reported-by: Abel Vesa <abel.vesa@oss.qualcomm.com>


Best regards,
Krzysztof
