Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323C2931C4
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988442; cv=none; b=YRl4yHoTWz/bfspeTKnaky1CE/kSM1yPo2/K5ZuccBOoQeinAPAcWpkTc+Qz28jr8068qdraf4/Uz0JrW1rZQYoDgAG3NMQj8uoViTE+v5Efgshd8vbt/C6yYXeeZpJ2Mur3V28Qcv+Gnfrl9Afr75QGNxo2GvtC8csc9ngsBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988442; c=relaxed/simple;
	bh=C26BeGFu/zSKb6Hmjy5a7QFJNXyiI8Hp3QSh5M2tmN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV9kdOAH2I7ZpXLtRna7prvQ5KpY5wziI1heGiq0npFzvP6sluaAPAxvmlF7xS9U3fZoeBaJHvZpPTZtlPZuli2QQY5yyFPAMg5wAyj90QorFeOi6bKCo2z0oa5xVzodIcTQFo1MZtXUXtTvFUOuVCm7kGkHh0p3XUTOKJXPdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hr1roGXG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LGUa2GvD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hr1roGXG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LGUa2GvD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692NfNmt1958809
	for <stable@vger.kernel.org>; Sat, 3 Oct 2026 00:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ylCuDOkn6CBYsIUnQC9b4yfcmzAwShqIqn5wRMueEQ=; b=Hr1roGXGGuK/2Ys3
	PgGl76KQG1zOxNLlVCnQ2ynxWrck/9kbFwDuLrXbMEb2JZ3P+GkDVCVtD6GPC9NV
	vRDCRvrluqIPbORvCQxCvHC9ZIONz2Oqfer6oJkeA1wqpf6y0jhSoqCNv0v8VyOh
	T2nkJSA2gffkn2OOJgRLO+bWvv+mFCZ0A7f0AuuIXi0hEisowMdToreBElclx/mC
	sm2+HM55xwM4X5FpHniNXskbax88saef40RNKwGDLuCb66h7ISmvIh2ZGyjLkAcJ
	wiOf3SqvhKfw2zihY3tHz0NLdY4OsuFdKaEx4vmYm3hiHvk17GiJRffhwbapdLEE
	WdorOA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2j0ks55x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 03 Oct 2026 00:47:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so14771285a.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790988431; x=1791593231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ylCuDOkn6CBYsIUnQC9b4yfcmzAwShqIqn5wRMueEQ=;
        b=LGUa2GvD72FKvgsKvqchBf0wsO1+3gElYK/o2NhtcSyo0eKd8D42y/6xmSvVJTfDH4
         XTNZj2PaU3EbdBPcZopHsvPAJ7SQ54hY4n+tFxEbdjmo2pF38m39QEu5UpRF06Ix+sSR
         XmWI6s//SCU72w+V8aN+mn6H90KieRMggBve62G3VDJX5l+gKYlWKoCAX776aKZxZF1C
         CF5yIJw0Y1lEIYYbXCXgWNarIY2A2u/Plb0FDTwk9MIhFsKNkOA5EkeY0qdnDNjjvxF5
         ekWOE+tXYrgRS/bN12fEDTeL2FeT+7cnAZ3+NfTMQYvxHfVCdTowpKnYoZVnJKKT/zTF
         skKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988431; x=1791593231;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ylCuDOkn6CBYsIUnQC9b4yfcmzAwShqIqn5wRMueEQ=;
        b=jE3MJjtFkpH+egHIPi7A6r1rMpp3FkWksC0H1Cvwd1EugBjwCWlBT8nuU/0lAToVE/
         vm9/I/6EGW7nbU5D4kNUDGXSeZ7KNprMX5dEATV6/LOLQEKRcLUbqvo5+c4fP74D6kyN
         RCUCpgpv208eO242qALGvMSKy4AKuWrdTj+OUgp4fJXn9DDoRrRjaS+VdiZ/dAh7uRAf
         zajcwcwFXa93/5uHIaK7fFmIDpbtYHSZzkah+pyrV2N4kPxriTTic/HtFLVemN4SNGOJ
         0rB9yfUSvvGfi6g87STD/fjZUev+AiJ0CCP2TClR4QKNJf769sJlTzpX4G/1EjqRQUkS
         n/fw==
X-Forwarded-Encrypted: i=1; AKwUvByGJxq9NFOjyuITHSoZoZaQt/+WV1nDp7rJdnWjFnjw7Q3E9ADB879H3cyD+QAx5xnqbeNqePI=@vger.kernel.org
X-Gm-Message-State: AFuF++kGf/B05LdnDHw34YnX3koRXYdF1WkYACn3BQ2vdhl+ryoNDVkb
	tLcYPtJqZPIWch7ZGeJ21Li92Ote//dyBBPt2dynn5rh7qV6RdK4JUGl4JlRLzATs1QuPvy094D
	HQmfAcYCOJ0E8YPeKYnwLrcqw+m6wMHgkt1oXWL3KUL4f2/hifpPS2Y04M2w=
X-Gm-Gg: AYBFou2pMOFwORUSzPVXh7XgLNTT2iwLUS+GxPb/ezZlAJQWHoFpCnR8UWWJJ+pOhFC
	gzp8aBWh43yky1zGrzsbs+uhAxQJfoUxx6OgR7eKg0Uo2lnXLiEbZF6rXv+k8jcbHo2Z1TmTu1P
	3udGDIRmeUww++g4/ntoN9aA/vSWGjpwkdlsFtkUaj5f7QmXrBrihq7NkKEcjO/6I2u+tSJwSXs
	lHg6k3DPJZCnKiNlvfe6W2eYUO+NW+4AbX9dYFKj15arxkrxoHGMHhxvQd58RbndXOrRQsm3WhX
	mKGPze9t7kud1Ufb71m9S4xEnwboC05E+txyGiCJhtdc2V14nLhbdB0qX1xXMuLZscJonnaaAcH
	qhF2AhbwWdF0jDIoZMwAYKYy8DZ2itSbule6w8Ewoi9DWtqczHQtdplw4gyKl6ZQ7+AL4wN2d9S
	FLMdn4uHkXL9jj
X-Received: by 2002:a05:620a:8804:b0:93c:612e:9b51 with SMTP id af79cd13be357-93cf18a7807mr872504985a.55.1790988430600;
        Fri, 02 Oct 2026 17:47:10 -0700 (PDT)
X-Received: by 2002:a05:620a:8804:b0:93c:612e:9b51 with SMTP id af79cd13be357-93cf18a7807mr872501985a.55.1790988430151;
        Fri, 02 Oct 2026 17:47:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:47:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Date: Sat,  3 Oct 2026 03:46:56 +0300
Message-ID: <179098834065.3641559.5174851000778073981.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX/EvUQ9SyQCVz
 Hylb6DTwfn0AkkkgG7cMkswwYk8/j2et7o4GfC/+8IimXqYWJ2/WdQWGV2y7sZVFiizf+Hzk2YV
 38EF0zjXAbMPYDZDTrjssGdrDDJIjYsTAOpbR6DqaBLRaRhxjUAtnP2cAA+PS7y+vjs5l1j3D0p
 PnwEJuC4sN6lfL80tn/d+MJXFbuufTOhCMB6wvrSeD2JNk865csrhQNaeiX8f3QHws5kcYa7Xlx
 OfZTgec9gvesMEIGIg5nEIkupWxPbZSAJ6IGyyxd7WpWdPd+Q2f0WAI1LjPiQdkUkmArjMypdwQ
 DRNpPvzbPn1L+EqNDzDjByVqRe1q/Qqy78hI0wAuClMQ+RZ9wAR3upv41tnjNSu0NglOblV4yOG
 CgPVWv5OVopnfskNyTaxf98oNndI6Sl/hlqtYFSUSnWeZ973HRNy5t6gUDQGH9YeXi25qWIlD9j
 rcf1QFLeWdB1XwNRUiw==
X-Proofpoint-GUID: _rNutepEYmH-YxCJld5YdlkBLnWeR1qM
X-Authority-Analysis: v=2.4 cv=Z8B5j3RA c=1 sm=1 tr=0 ts=6ac0508f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=NtFGmenAaefONujONKUA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX/yBZX7ceiwOX
 SxKtQnDaTCO0ZK41D0LZGuh9mlKiH07QomJBuDB2yECZFM5+4q+bDH4LvyRpsP+shpqnVev0oOq
 8WdqDX36rQxIsAcHephSYm+i4jHh7A0=
X-Proofpoint-ORIG-GUID: _rNutepEYmH-YxCJld5YdlkBLnWeR1qM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002

On Tue, 29 Sep 2026 12:25:24 +0800, Yongxing Mou wrote:
> Add support for Multi-stream transport for MSM chipsets that allow
> a single instance of DP controller to send multiple streams.
> 
> This series has been validated on sa8775p ride platform using multiple
> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
> 
> With 4x4K monitors, due to lack of layer mixers that combination will not
> work but this can be supported as well after some rework on the DPU side.
> 
> [...]

Applied to ttt, thanks!

[01/35] drm/msm/dp: move link-level teardown from display_disable to display_unprepare
        https://gitlab.freedesktop.org/lumag/msm/-/commit/1bda647ce61b
[02/35] drm/msm/dp: Pass panel to msm_dp_ctrl_config_msa()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/642a8c954d4c
[03/35] drm/msm/dp: drop redundant config_ctrl_link() from msm_dp_ctrl_on_stream()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/9582ac3ad673
[04/35] drm/msm/dp: introduce stream_id for each DP panel
        https://gitlab.freedesktop.org/lumag/msm/-/commit/ac12c30bc556
[05/35] drm/msm/dp: add support for programming p1/p2/p3 register blocks
        https://gitlab.freedesktop.org/lumag/msm/-/commit/90bc95ebb04d
[06/35] drm/msm/dp: add MST stream register definitions
        https://gitlab.freedesktop.org/lumag/msm/-/commit/cb821ad0df17
[07/35] drm/msm/dp: add stream-aware link register accessors
        https://gitlab.freedesktop.org/lumag/msm/-/commit/5e4a3f7b2620

Best regards,
-- 
With best wishes
Dmitry


