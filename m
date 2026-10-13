Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44D485924
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869013; cv=none; b=rpyqZBdNwUnm1PDCGJZTbnubfN/AYp9Yoltb6paZbOEu2NhdB7tsIJV/0eyie7aqu5kWjeT3pW0HyhS4Kg393RU5806G7jjiWfT4px6azLd1blnRlkenYOZagyjCr1uYJXByGnldID9EeZd/WPXQ5AmejweBAqHtiM2bXg4NhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869013; c=relaxed/simple;
	bh=JVx6dpEccQaMA7CMCfXA3s10a4YXdLEp+SKGvRudmng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn9mic0sxoq8jxnI/nQ4DpzBIKP/PjHEHDcQCO6rZBoo/AF0nGpQFvrWRqtfOJ/QMBxkIIPW7Z5EyoInyyr66ofjDP3a4HcYO9+dPAGm5hsedTu9MRwr1SSAhf/Pqa4SmddHpH4/JalUtBHt+1ixxg9EtmTWvrZdZbEkNdlGwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UecfDA5h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZNrcCrj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UecfDA5h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZNrcCrj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D21Gmr3752760
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/SZN17hFW4GC9KUw1ogcVV38VClSXT6eMgRXyiGOLGY=; b=UecfDA5h0NXv0cGv
	x2XEaFlRXrOoK+82wOwqjLVebQ8tclsDFd3EW0P9rQ9SOaJbDgxN3+BQ8jrfV+uK
	lZNYZ+Wk0WQU/CI/dJLjUEhWwlM23hr4ul1KcF++WkLqEASlUluVxx9ima3e4GHV
	2EaLtBr6uP1Wc5xAowGZLct1AiilGHovkwWvS9P4Xa963xz5WbHE4GtKjbnXtSUE
	C9nvI5eefGMS9l5bpy8KVGSzdPVb0ME+vv7/l/l68Lu5o3zIqHilAmk97V2MaA3G
	Kv9OZW9lACSuS9pLUcJi7tcJv+Q174w9TRRLI7JFmTprljWdKMD6N4eOhNTgTj4Z
	UMyHPQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h940w2bmg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:23:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so1701276eec.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 22:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791869010; x=1792473810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SZN17hFW4GC9KUw1ogcVV38VClSXT6eMgRXyiGOLGY=;
        b=hZNrcCrjFZ3ajE3ZqT6UGf0l5kzAf3dWxr7HWR7rvGV6Gpspz4jYGsiwvp4ItsVrLV
         NiO1Vbj9lT3ol5TrlUSR/U/ppiqpwj0xSGu8+i+sGws6tVh4gTBlhdl9tJcvr3yfM/CF
         /MlYLs4sjiCa95KIWRD3rWusDGaRELd1HZ+CWUDjwfRqlOjRkXTplh+MjZGUSTCkGZ68
         MQKE7dFOMf2xriYaGWjHfZT/pOb74AY7doG444Jom5fqDyz3q91g6bFPNYaObaFKIW7i
         DEQ6qiLxgjWSHcXOtx0iiuE5OdqiDqNhFLQI4rZQuSsHd4aYuBOQAx2lzGrehhozzdGv
         wJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869010; x=1792473810;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SZN17hFW4GC9KUw1ogcVV38VClSXT6eMgRXyiGOLGY=;
        b=pebWyN3T8rnSSEZ7jh6L9JdzfWv8qe+VpOIwNDhQpVTIXKvE/oaKTvOWlEoZbAZXfQ
         Ym4/iDzV1dj1k1EdEWuTqrm3FGv3r+69+7MD98+zWmIm8oT3RL0sOyLFQ2AHoZ54i2c2
         gigzLIP+VfSrl8v3lC8gSaEku/X2H4OmJpk/TFxqIq5dCm0nAemPxpRME3EK4fsPdPL/
         Y65/AaatJ/6N4w1lxQl8uhzjBUTT2E5WpH4Bo9pRCyhUaYZpxt7sek4G6b5ZI3ZlmGAF
         C3ihwgor6amL0v6X/6I3Y/IsHWOwBvsxPEFCn1TicmzfImNHIcj5b2+DFOiLA2uqYqIY
         2JnQ==
X-Forwarded-Encrypted: i=1; AKwUvByZRqRhqEWdqHF8vHNfJnXDjQSnZCZ3IIpUwQJtcPbD684yrGlDZ/uAzkew57CzL6NrfQf7rK0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFrTdc9zI2uvf00IcvkzyHjHrNOwh9Z3C1RxATlNywJ61zXrhb
	3OtiOmoqaJU0PkaNP4sv2fdq2mRNZ3oiKC0gpqMBgAaaqt7HgDi9tgpeIKgAgYxLq6DlC7S1YxT
	/lHjUsGErFerwEofej9C5l+oi7hLqWcRj3m5vqXnpicBmFpn3EvJ40Ek2K1Q=
X-Gm-Gg: AYBFou2bukvdRMfANMxKRL17SWhi4rPd+5+rGcDK8HbdpL0s1SLjXAnQUFChnhRPZA8
	WWEBj2/cu46nt2HLAYrsCr6V0b4uDZ3vNbMFc6GFpf7Wq9hHuFbvXLXLG3y0VZAwD5BK9e5lezA
	EsrSVhVsjJ8j2LjECtsg/0taKrwOMv8vPpF72+I6cABvMK3d1JfEyBXGAsOPC4WukWzAiBG1HiB
	XyZ6h0OCA3poNcZGoKFCy+hOqWbJNUVgFNmvANRmjYUfRwa/1svK89j0w2U4NJ12NyIBKt59kLP
	Amf3y859eg4iLM7fj0UvrCoFiQ7uHCjreQatyx01QRxkTuZCHHoxgp7fqzBWRJH/+deNHKCcKBM
	5vRfssp85ArpsWjcqXjdfAcU+mTMlokZQkOcfh6B4
X-Received: by 2002:a05:693c:87c4:10b0:356:4b46:9393 with SMTP id 5a478bee46e88-3564b46940amr13288195eec.24.1791869010089;
        Mon, 12 Oct 2026 22:23:30 -0700 (PDT)
X-Received: by 2002:a05:693c:87c4:10b0:356:4b46:9393 with SMTP id 5a478bee46e88-3564b46940amr13288167eec.24.1791869009486;
        Mon, 12 Oct 2026 22:23:29 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm44915106eec.3.2026.10.12.22.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 22:23:29 -0700 (PDT)
Message-ID: <657ebc48-0faa-46cf-9cac-7fd06b2547c9@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:53:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: assign device id from the WSI index
To: Benoit Masson <yahoo@perenite.com>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        stable@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20260928213322.98949-1-yahoo@perenite.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260928213322.98949-1-yahoo@perenite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: N8neYY7k4LkFsQ2JjbdB17lxyzyPUmd8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXyPqe0lU1rwDm
 Hhlt/9ERj/MCsA+3G/5s0Vml1SxW9j/xAuXn9opVs6kw6OhGJLiZTxj69+kegUKeedeHgO90ZYE
 eFYPDEesC7gCJ4udoBjHoEBWP27PfSADadIX8haHMIq+F0Cmbc88BQddR1ge0/HA3esPvnHacWo
 6JOAqgpqXsbts2qXnQx90gYLZ1YAp25D0e7hlQATAdlbKKbbC09aSTFWl3Jaj1cclbtI8dk98SC
 /Ku4mgWv12sPKhg9+rvQy7t/qXoF2956v6uPYh10xZwkYCnBhDzp8Kmk9AU5Fx2OVfnVXNWH5c+
 jbGe+r+oVCuIELOF2dOs8ueNtN5DWfu0rfXioID9cXxXgPMTMS977oYkUAL/4rD9acQcc7EwK5L
 WZcL8IJ7JedHxwxu3+jY/53071txaxznL5EMMO0r09YToaI+n6b2shBSyTIbR3iX7XJ9zrdF3ha
 sc0c54UAJDjboqU+/6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX/5t7B/fty7E7
 VOhLH6X70QXGemnpxj6BnSIMhm3oxjo8E1v9g9muNuJJyClkgZNM4WIzlM0BI+LRaE+4xlHfIi2
 +qzbtc/SHAT/yV2D35b8CMJteZj1eWo=
X-Authority-Analysis: v=2.4 cv=ftZJ914f c=1 sm=1 tr=0 ts=6acdc053 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LV5C8B2hAAAA:8 a=33sO1Vo68oqyLtPrM3MA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=uiVh3g-rw18WZz7NjXbe:22
X-Proofpoint-ORIG-GUID: N8neYY7k4LkFsQ2JjbdB17lxyzyPUmd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021

On 9/29/2026 3:03 AM, Benoit Masson wrote:
> Devices of a hardware group are added to ag->ab[] in PCI probe
> completion order (ab->device_id = ag->num_probed++), which is not
> stable across boots. The wiphy radio array is built from ag->ab[] and
> the wiphy device is taken from its first entry, so the wiphy sysfs
> path and the mapping of radio indices to bands change on every boot.
> 
> Persisted wireless configurations reference radios by index (e.g.
> OpenWrt/hostapd "radio0"), so such a configuration attaches to a
> random band at each boot. This affects any multi-chip group with
> single-band radios, e.g. TP-Link Archer BE800 (three QCN9274/QCN9224
> radios in one group).
> 
> Store each ab in ag->ab[] at its wsi_info.index, which is derived from
> the device tree WSI ring and is therefore deterministic.
> ag->num_probed remains the group device counter. The unassign path is
> unchanged, it already indexes ag->ab[] by ab->device_id.
> 
> Suggested-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
> Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
> Cc: stable@vger.kernel.org # 6.14+
> Signed-off-by: Benoit Masson <yahoo@perenite.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
