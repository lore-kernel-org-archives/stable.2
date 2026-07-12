Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50946376BDE
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783900015; cv=none; b=favZoBZ2JnX95Pa4ISuPJGcayh8LuXQdRboWj1N892qF2TEKOnNFc8RRJ5KjiPA74ot1Nt108oaEIoBe1WWZLY1rAUWjja+LyflJUbOaw5V/QVCduyaScqrhfT332+AL1mtkog9PZMTL5DX5t0MYENgPic+6pLBhd5beQhZwj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783900015; c=relaxed/simple;
	bh=rcSVXBa40Hk8wRjirs7IHACX8e3iJayHF7bJVStLKls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDr+4A6fZnSFn+rawiRYDrqLwf+yvQlw8UJbRBpRKzHABK/rsIAd8HABOCXDQtkAsRkU3u06bOmG/kgi5nEN9YLpaUY5ILoc9hPh9/y+Oc0NTz87QXwk4furJQ1j48wxaBJeTDl7aXxdESrw6tDW7g3pqnIZDQxGOlk+p5ODujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5kYly1o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BQLebwVT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5kYly1o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQLebwVT"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CNUDCC3768751
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 23:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JYV1vviYmvv18rlHbpJk8khcLhfX/RfZkk0vj4YXymk=; b=B5kYly1otcGPDCYb
	8q7zTMc8iglLa6qIZzyq0FTbqvDGRoThhUCgzX2IbYCnWMaZTu0/fOXLUVZhw8Wx
	Upy7BoOdu6dTgbEEWcujNgoPFl1UiRmXlB1uO4XyVVyU/Gf2HDzmHYtMqjVqa0I9
	JbC+98CTnFA+lcphysAsmKlBDkJaHaqRxBhb7zZo4fWYqOlGPouag2bAD8F8nU9v
	noXF296oGLIqzffKCiuNl7ExY4aLakK3QHSyZ92NdGiYMYMGmsy7r4re+9lA5wGG
	1CbhWyN3JTC11GyOs7MxVYL2OdnGjkMsIspp1aKBhIw26ZqZjSBYIXYXC0fbU6gG
	h2iieQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf483kxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 23:46:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f39a46efd9so41786866d6.1
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783900012; x=1784504812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JYV1vviYmvv18rlHbpJk8khcLhfX/RfZkk0vj4YXymk=;
        b=BQLebwVT9vzv+aAxiewBIsJ38246qBelJw6EGhx5qM5cOkdEXz91AKO+1JyWe5I23h
         uOwfSg5LiM0PSV4UhaNYOS8ZwemyW54f/jXYfutjAbTYUco5P9Uklx+4R2vWJsSfN71Q
         09zID6wRIiBn0SzBK0wfIe53kkJqfaik68DClHIa2LLXIzqcGRpIh8CjPWtIdxfkwXpY
         fzgkfMM3F16O3R+h/PPQGMH9xQICMWQyZ3UgDlWwjpbOo9M9gNLT4dgyONwIN/htH5eB
         NxuotFT1tnLdxGkf19ZOBbDndIw4ADvoKYUnTiivy/i83bpkRpsJ4GR4TrTgyCEqZIVJ
         s7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783900012; x=1784504812;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYV1vviYmvv18rlHbpJk8khcLhfX/RfZkk0vj4YXymk=;
        b=jNT8h4ZQ2DPSXSGE+p41FdgPzqcHNZkgrgj23V6/7q/vBtdCLBLDjuu8+EDfmwDBDm
         TlA7e+tkuqDnA6y/mA8ujtU2iXfxGz9gfoZwQyT5TFX9WTnU5IuiPUAf2+tdPHQaoIo/
         7/rfUmoTMGAMyXiRJbHrsj7czrl8ddjt51ppGGY7wXhk/ZNLSZOJZZ8pkqIbJszlSkBK
         C0xB9J6NcNmGv7qxlKy01o0Bt7aPpjI+rgCYT6fmFFPC/aXq0iCNdUjT+2iOfqO1E9yE
         Kjqt+6qNPb71NXmDNn5lV5oH84dvQ1cxTIp9SDlPkCsELC7qRqDRDGzZ2Z2YPHZJ+1kk
         2lMA==
X-Forwarded-Encrypted: i=1; AHgh+RrAPo+EYmWcKP4An7e54kkwXv22jw9pH/W6kinDlZA9C5mrU5brP0b70N9Lsra4Fkt0w2qqHfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww25cEJ3fP2Hv2IRgKVWh3Kov5/m19tA00s/9ItMSJXiVismLw
	LqQqdObr33gchq9S2wvcDx0eJg+Ocd9gZ34k1n3gYdhu/gCzqIrv6rjLohe7uUXo9NIZKadBwjN
	mAi7lpQYu6OaCFzaaKrUj5lIhl6Qe1v2YpWt6GhCARdpia1n0qfGYxmr/3tQ=
X-Gm-Gg: AfdE7clr5VV5IRkVQa8weOX/hwyVkjHYvm0unoqhYf2yhjezaOG8QH8KjXYBcSba9NY
	2evIuzu3DNqdb4b+99EoUAF1+qCQ8VYiCm74fn8aiKUfdsJ6lhJ9JIJTKCgeeQv+rhXuFJVEg/g
	eDzBXcp/DvEv9SMO3B8VuN2SLu2J7o/mWw943IZazhfobub61/2amUK1OXuKo+YST+sSFjAjQ+0
	RAbboyhmRC4Xp4ptj5cNVYzJXQ+n3avGHDB56Rw18uCBR7mw4QVQ0UifrMMs8LXcia43y/4x7La
	1zHg2EjluRMawlrPTNDdrOkqAO2hYZowAt3yNybeEyPONXTrp7fmeHJo5BpkL7oAvqSumMFVgvB
	3Ee/A7m1VKddzgXBwN0MY1drNucCC8QRzEPXX1b+BUa4S0dqxxIhPFxFVlavs+oDaXdzBUN9WaW
	t5UPBCA6EcFCgI06r/4LOa51Qt
X-Received: by 2002:a05:622a:4089:b0:51c:8556:55f0 with SMTP id d75a77b69052e-51caa173e38mr122326771cf.34.1783900012667;
        Sun, 12 Jul 2026 16:46:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4089:b0:51c:8556:55f0 with SMTP id d75a77b69052e-51caa173e38mr122326611cf.34.1783900012272;
        Sun, 12 Jul 2026 16:46:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caaf40esm2371357e87.71.2026.07.12.16.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 16:46:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: quic_abhinavk@quicinc.com, Rob Clark <robin.clark@oss.qualcomm.com>,
        Kavan Smith <kavansmith82@gmail.com>
Cc: sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value
Date: Mon, 13 Jul 2026 02:46:40 +0300
Message-ID: <178389962794.1434604.86942707756896992.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707013240.681012-1-kavansmith82@gmail.com>
References: <20260707013240.681012-1-kavansmith82@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX0EAhvzTKfGjU
 qIyCH8ncWprS7xeUsuVE9VAZjsuw2fb9Pf6ooA60HoOew7/xpdmVD9lkcKPzuVBBZLs7d2PbWdk
 aSaMQAeHRIzy/OVr73us9wsazEfSAns=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a54276d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=TRR5xVq1x4uEjgd2TI8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfXxKYPek24Ue1C
 7DjyxRgvC1zYST/VW7lIjgQFduk0/hdOewOyximqD8kVZGwbvxyFELcZG7cNc8jgk5wovtHznrU
 bNYjH45xp886Zxi+LN9D1Af5qBKygeEwTB6H5/gkZYK0B97CWaT/KpgfphVlgEUyZe6Jrzc1PAi
 xGZPGJgxv8gLxb2xo0W0dqoiwcc8sw/H8ria/LmENX0h9gfe74+E081S5BQq4XSF4rjABQmN7j5
 w5kJvxXA5WUaSsmTEkfNpvAgfaE35J+VYxdVeuCajLuwyUOsyn9AMjEj04VDoud9V3E4kVHC2b5
 Nozc8ZupMFYrQ+pmOq+3I+Kp48LMPRGG9jzwFhLcZeHqojDPcwjEJ8IjcOvcxERUoJhvX+35oK4
 +gwxUD2fm7zsENx5OoyfiorM/2kg4cRgYnBePgbhho5N9VqXR9/eZQOVy2bZLqftceh3VJ8V7Q7
 Ouj9r0iIIid4dV6ThOw==
X-Proofpoint-GUID: f1L-sLiheTJY9hyI3ya-RYLOJVaTLmuV
X-Proofpoint-ORIG-GUID: f1L-sLiheTJY9hyI3ya-RYLOJVaTLmuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120257

On Mon, 06 Jul 2026 18:32:40 -0700, Kavan Smith wrote:
> MSM8916 runtime DSI commands still go through
> msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
> enabling the link clocks. That is fine in principle, but on DSI 6G the
> requested byte clock rate often does not exactly match the DSI PHY PLL's
> realizable rate. For example, the driver can request 56250000 Hz while the
> PLL actually runs at 56246337 Hz.
> 
> [...]

Applied to msm-fixes, thanks!

[1/1] drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6cd33b6f4155

Best regards,
-- 
With best wishes
Dmitry


