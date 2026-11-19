Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076672;
	b=ZXah5b038CG4hYLgXmbkzkz92ZR1WOiTqWPXqFPecnVp6qX3YzFN9QhBz3bZL4G8jdNc
	 9fEC02J5ybbTyb39Pe9NLcgPb3cd7j4adQQlF0DRVmSJyNobtkwmIln/w8Ruq0iHzhl9z
	 rxp5uZwuGsZLeFHT3H9tDLdmGWSjFg5zVZLpLRF5BasoNewvvQzLVj9IiUTC0NS5wEdJn
	 RYBI2TP77OQpQOB3zamGuy17ai2BfCkHfQDUvtbK5eGi3Dx/bXtltwLIdpIX2gDFKThon
	 +CDNwChZhudqI+g4eeHNM5xyB4nTt5s9Z2xUieEE3SdXfIZ+ipPI2bKzvO/UgnIpbsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=w538saYmLFKkF/0b9eZpywTKwazCO0Kdn3yWVwLKeRw=;
	b=XBg2kXfA9z2JPhN1EXqmgHOv/gjCXcudbGJDAb913js1wgVA8hY0UDTUFLN8Km4ZwkeC
	 Ryi/CWNnCakkM0zEz/YFk6L7B/gK4rytVhwOkcOvGZQQZL1rsd3eGgP9nJC4JLOvqo5HQ
	 FtlM9JPsQe4dALWLZ0t9UqKv4SwJ8dmg4HoI8Dx1VxxIHiufkpMOz0/mAbFPP+gByxgss
	 C8XhEvfSj6cOU24tYBqhCnrwEGQAvpg/yQ/mj0g6dnDyuFIxEAsMsYnfdxQCF/YRl11OM
	 33YSEOTIPMNgjQtXadKBR1NuWkCPWK/yz+ohiaC6tQ9qLLVmpwJb4EqEaySUj813JNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GFPUAJtD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gJtEH9AW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AA606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B34AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GFPUAJtD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gJtEH9AW
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vG9x1681198
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w538saYmLFKkF/0b9eZpyw
	TKwazCO0Kdn3yWVwLKeRw=; b=GFPUAJtDEJZq9aOma9/LyjD/4w04prU95WAnkb
	QW0z0aubuzaOcxyWpK5vV+bn455SScwhfkBcpkkY6s4OqKO6f3J4f1b+96xCMuAw
	YpcurGcgoTuANMz9nBYIOiwWG1xq7D2H/Oqu7ueU9Q1doi7ZPNTVHnnnIEWjONqd
	pnVMoaGIEE/uoUSzKIHEJiwrMErPJLKkAkExaEtINmb7FjnVQ/6o7FgariW5sQj5
	TOOXCC1FRICXoDy1XIOnHm1yDQdmlOMQYpH/b4+NQ23GqWrrj0CLNr1Qe8nPYrmB
	hT1MiificuFCgqpiC7PWPOwxdn2joLkKTg7IiGDOKz24kuQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdcsrqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:24:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f32050e72so519608085a.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795076669; x=1795681469; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w538saYmLFKkF/0b9eZpywTKwazCO0Kdn3yWVwLKeRw=;
        b=gJtEH9AWkZbp0Wan1Y43NbJxS3ibBPbyC3qhFm7Y4iTogPo7GO0PEq1Ttup0iI/uNL
         m92lgZTQruV2UEOt++s+8A+ckwhBeCpCYPG2kyb1zcUHrrLzMtSxfaRhboBDn96kWbGV
         vmuSfDhPSNYPjNUVPNSt/8+m+iliN2fvgyJ61ymlVjBWcw8zi8peaAyUZpY0JJjoqcj2
         ahVlUFwFK/po5/bmzI9O2baYM82RyKXyuacAnKwqyFDEmqqMf6u5KzIu/msg/9AjFbU0
         GmjuImMsMRT7DsWMCskOlHkjvFbzxAHyFV1+Cwa+1Hi6A4Hj+eQ5UFCGKZjiqPQWAep1
         o8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076669; x=1795681469;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w538saYmLFKkF/0b9eZpywTKwazCO0Kdn3yWVwLKeRw=;
        b=H87VQ1d9YvInsgKMawXszBg75amLEzx3770ehXjM1kax45nM++0cPPM2Zk2vq5eUHH
         csuV4ciWxhg9Cyf4BRy8aZAfADJTxLAOhwLJuJyHwbpJHPilc+3Wn1A9HX0MJxqwTylX
         P0ctrtNhnjwpCPhMtNZm/1N02K9RzLaDRLlVQeHeko03gwUx9IrjaWhsQ4j4BaKte+IO
         tz0dx6pW2jfAOGCBAaBU8ZUi0dU9q4Ctg0C4ZC+JWmWjAJEa3p1pyLUT32vAw25biV2T
         9SEBGEwktkmikPW/6mIFANmrT5TZAhBl5dxuEBv96vgCWaRZmchDPgW24nnVHuVU+Vyv
         ceTA==
X-Forwarded-Encrypted: i=1; AL+hErF8s8s5Ud0MOKuhF0mH3RQt7PqkUsSEqr8A51OxTF4m7C7ltrVx8iJAzGliqnwzw4i3TbWu1KY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QhZAC7ZVAvHs72M2+YVWdIXtwbO+f7KRKViNtaU0bdiW7DbrE
	wwESvzgyHOpDihAx4pTcRvPORdM+gojR/s6I0XvX1pqfC+hYeWt1hPzlhC6dJyIOFI6QMw/HIwx
	i6L3/HkGSZPfchKz9EQS2NtukoGnjo1s4Rt0WY+7corWdSAK/KdqcA1pjXxngi0myLUfksw==
X-Gm-Gg: AYBFou2nR5BF3IyoJ2hE3+BJs5+1RoSuQfp+j80xWx3bsFVsloo4VhswBBg69e/SIyU
	UBSRrFWIkEp4eDMCrtwvKziu7ULoNjKdF/ozrLxnWsR4Fbf4u/LawjT56jW6RgJk3ekrT3ut19D
	4n/CjzXVjdUoR7iYFivgGodb+YMNgxQGuVpkSiFm8vDEPr0dzYFJzs+cPdi3jcZbJ2nNxD7D2Mo
	22rqIgXtR2InDNgfw/tK5iHQ5SyFwGE4pSVwEdaCH0iFQhoK9GCsgA4+f01zowskAKmU5X1j7iD
	Qxi9iCVFmfuy9J/Eyd7l3JV4QEOhSkyLq404XPfyPSQs6cgVhtqI0vP+m2JQFIncvn/F1DU5DnT
	LXjDo9opa06O8Yh2qpwH37VsKegZ6CSRnoFmiFFZKk6KEjel0n+itxvr7EVCE28Jg/e9ThqybSr
	VplJ0RBRBXrYukB0AT2Qdkayujaf6kF8juDz8g
X-Received: by 2002:a05:620a:2b85:b0:947:1d0a:c8b5 with SMTP id af79cd13be357-949995ecc9dmr916274485a.54.1795076669049;
        Thu, 19 Nov 2026 00:24:29 -0800 (PST)
X-Received: by 2002:a05:620a:2b85:b0:947:1d0a:c8b5 with SMTP id af79cd13be357-949995ecc9dmr916270685a.54.1795076668433;
        Thu, 19 Nov 2026 00:24:28 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:24:27 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v9 00/29] drm/msm/dp: Add MST support for MSM chipsets
Date: Thu, 19 Nov 2026 16:24:02 +0800
Message-Id: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACiy/moC/3XQUWvDIBAH8K8SfJ5FvdNoKWPfY+xB42UVlqaNa
 dgo/e4zKay0ax9UTvDn/+7EMg2JMltXJzbQlHLqd6VwLxVrtn73STzFUjMllBEoBe9yx+O+HCM
 HLUEEQzZYZOXBfqA2fS/Y+8elHuhwLOZ4uWTBZ+JN33VpXFfKQB0iNUKD9kogNtGCoOCdrx0YM
 FpGJxBmuqOc/RJmXW3mLFIo5Nt95Gk4cJpoN2Y+WS64IXLoqPZg8a3PeXU4+q/5y1XZXtmca5v
 y2A8/S88TLsEetTdh4YISWtpIvqx/3KJN+ioY5W4EXQQZrVWlEalafCKYq2BB3gimCI2TEXQ0b
 XDPMtRXwd1lqIuAwUqsQVpN9RPB/glS3s1hHmsUKNoAEINuHwjn8/kXfwfAw0sCAAA=
X-Change-ID: 20260410-msm-dp-mst-35130b6e8b84
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Joonhoe Kim <26rote@gmail.com>, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=15225;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=QcoWzdol2YEJ6TwNavNmYnG+UA/0AacQTzPPdO7fbsc=;
 b=YkIyqvF2KUnLFHDmFjxIqoY8LMMWFVJeZsJXGxcA81IC8nBGxpGzlNW00WAr7aRBe2EcOQ63e
 PBy1Q+citXbC/F2JwuDwSjHMg2uxxxG5QrL66dqKjHm3PrZGweFN4Um
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: LBndfrmxawxA4T49kRAH470wvgV0appb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXznsIYpLdf7Fd
 PMRoVMmerJGTt67bWcF25AyhIzC91OH0rgXTjmbbqgacyAb6A6mRcfIzMmQpeeJXIR6JP02Nn5Y
 yTe3gFaoPfEwC2p5LCFL8v7DMNUFdz4=
X-Proofpoint-GUID: LBndfrmxawxA4T49kRAH470wvgV0appb
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afeb23e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=z_i5WFFK-8ga3zmfCq4A:9
 a=pog74ck2hQlt4hhh:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5QyKl34Hsu8m
 F3+Q1HfHLSgRxTyJfHMUpJDLhL0Zh9x4D7jHXsIZ9OTsSACXrsnkWVqDrOBTpTdLnZ8PvVndkRZ
 /0bp2SYXzzT2mjeuK5bD5nm+7Co5D6qc6GhBCYo+dmNBfqkyK3h4ndKCa92oKQ4J9hcovR7+oRZ
 IviPbOFNRMe6rkW8Ouopc6Nqwgwc+owzcaUifW9Fd0NA/I4RBJKvnti+wFJWcrTfTgmy4+dv0qv
 +p60CceLfV9vVCKk+PNhsWIIgoDksGlnypHbuOkbWkchPv3OG1AWorsdvlAf7jtn5dCL6Ivhy6V
 5ukpu+6BhGZY+3AtK8NsiQSRG8bquLt0E8UzEs2Yb+NrEAmHwAxkBA+JK8j7dRi9ncokJRm6gSl
 XBq1r8ap9LEdRan6aWIvAgqnWI46tBFJlufnCD3xd1UbslEc7MQncMswNKCJ3owaXlJG25uc272
 MNYHMniCdhfun70hrIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033

Add support for Multi-stream transport for MSM chipsets that allow
a single instance of DP controller to send multiple streams.

This series has been validated on sa8775p ride platform using multiple
MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.

With 4x4K monitors, due to lack of layer mixers that combination will not
work but this can be supported as well after some rework on the DPU side.

In addition, SST was re-validated with all these changes to ensure there
were no regressions.

This series depends on Dmitry's "drm: handle IRQ_HPD events correctly"
series [1], which adds the IRQ_HPD propagation infrastructure required
for Type-C MST support.

Overall, the patch series has been organized in the following way:

1) MST controller support (patches 01-07): low-level additions for
multi-stream operation — ACT/VCPF packet transmission, payload slot
allocation, and mainlink MST mode.
2) Driver refactors (patches 08-11): replace the power_on flag with a
per-stream bitmask, factor out panel-accepting bridge helpers, and
introduce link_ready for explicit link-level state tracking.
3) MST DRM infrastructure (patches 12-18): new dp_mst_drm module for
topology management, DPU per-stream encoder support, and atomic
stream enable/disable handling.
4) SST/MST connector state and HPD fixes (patches 19-29): SST/MST
connector state management, HPD event routing through the MST
manager, per-stream bpp selection, and Type-C retimer guard.

Note:
- Validation for this series has been done on the latest linux-next on
LeMans (sa8775p) and Glymur, covering both FB console and Weston.
Type-C MST has been validated on Glymur with MST dongles.
- AI review comments on patch 13 and subsequent patches will be
reviewed and addressed in the next revision of this series.

[1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/

---
Changes in v9:
- Patch 02: Turn off the pixel clock if sending ACT or waiting for video ready fails.[Dmitry]
- Patch 07: Drop the unused DP_MAX_TIME_SLOTS define.[Dmitry]
- Patch 10: Fix the debug message printed when the link is already disabled.[Dmitry]
- Link to v8: https://lore.kernel.org/r/20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com

Changes in v8:
- Rebased onto linux-next-20261102; dropped patches 01-07 of v7.
- Dropped patch 32/35 of v7 since it not needed.
- Renamed the controller's mst_active to mst_mode so that it no longer
  shadows struct msm_dp::mst_active).
- Dropped the driver-side slot bookkeeping; the MST helpers now pass a
  msm_dp_mst_slot_info table built from the topology state (patches 07,
  09, 18).
- Patch 01 (new): Skip sink requests while the mainlink clocks are off.
- Patch 02: Use DIV_ROUND_UP_ULL() for the 64-bit division in the ACT
  wait time.
- Patch 06: Mask the STATUS5/STATUS7 reads down to their own interrupt
  bits.
- Patch 07: Take the slot table from the caller; simplify the rate
  governor's fixed-point rounding. Rewrite commit message.
- Patch 08: Replace active_stream_cnt with active_stream_mask so that a
  single stream can be queried.
- Patch 09: Thread the slot table through the helpers; key the disable
  guard on the stream's own bit.
- Patch 10: Release the runtime PM reference on every prepare_link()
  failure path, and check sink_count before taking it.
- Patch 12: Skip the MST manager cleanup when dpu_kms->dev is NULL after
  an early probe failure.
- Patch 13: Use the DP controller's own device for runtime PM; return
  early when MST is not active.
- Patch 18: Report enable failures and stop the stream enable sequence;
  collect the payload slots of all streams.
- Patch 19: Read the old connector status in the same critical section
  as detect().
- Patch 20: Drop the explanatory comment.
- Patch 21: Drop the plug guard in msm_dp_hpd_plug_handle(); hpd v8 has
  a stronger one.
- Patch 23: Check for MST before taking plugged_lock.
- Patch 27: Drop the hunk that handled plug before IRQ_HPD, now done by
  hpd v8; retitle accordingly.
- Patch 28 (new): Select the MST stream bpp during the atomic check
  instead of failing the modeset.
- Link to v7: https://lore.kernel.org/r/20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com

Changes in v7:
- Rebased onto linux-next-20260918.
- Incorporate Type-C IRQ_HPD support: new patches 33-35 handle IRQ_HPD
  events from Type-C controllers.
- Patch 02: Rewrite commit message.
- Patch 05: Handle optional pixel resources without spurious errors and
  track each register block's size separately.
- Patch 07: Use optional-resource mapping for MST2/MST3 registers.
- Patch 12: Handle stream 2/3 VCPF completion through STATUS7 and reuse
  the existing idle helper for SST.
- Patch 15: Preserve the disable guard and adapt it to active_stream_cnt.
- Patch 18: Add explicit MST manager cleanup during KMS teardown.
- Patch 23 (new): Move link capabilities from msm_dp_panel to msm_dp_link.
- Patch 24: Propagate enable errors, update remaining payload slots on
  removal, skip disable hardware operations after disconnect, and use
  shared link capabilities.
- Patch 25 (new): drm/bridge_connector: suppress hotplug for IRQ_HPD
  without status changes.
- Patch 26 (new): drm/bridge_connector: avoid detect-based HPD
  notifications for DisplayPort.
- Patch 27: Route IRQ_HPD through bridge events, drain pending ESI
  events, and synchronize the IRQ before manager destruction.
- Patch 30: Use shared link capabilities and explicitly check for MST.
- Patch 31: Preserve SST operation for SST-sideband-only sinks.
- Patch 33 (new): Fix threaded HPD handler not woken on controller IRQ;
  Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling"); Cc: stable.
- Patch 34 (new): Order IRQ HPD handling: process plug before IRQ_HPD;
  discard IRQ_HPD on unplug.
- Patch 35 (new): soc: qcom: pmic-glink-altmode: skip retimer reset on
  DP IRQ when state is unchanged.
- Link to v6: https://lore.kernel.org/r/20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com

Changes in v6:
- Rebased onto linux-next 20260828; drop already-merged prerequisite
  cleanup patches.
- Reordered patches for better logical flow.
- Patch 01: Also move power_on=false into display_unprepare.
- Patch 02 (new): Split from old patch 04.
- Patch 03 (new): Split from old patch 04.
- Patch 04: Squash num_pixel_clks into this patch.
- Patch 05: Use loop for snapshot; skip inactive streams before adding.
- Patch 06 (new): Split register definitions out of old patch 04.
- Patch 07: Rewrite old patch 04; replace stream_id special-casing
  with transparent msm_dp_read/write_link() helpers.
- Patch 08: Fix REG_DP_MST_ACT register placement.
- Patch 13: Drop defensive start_slot bounds check; rename
  channel_alloc -> update_timeslot.
- Patch 14: Guard link training with active_stream_cnt == 0.
- Patch 16: Add locking annotation; group link_ready with status
  variables.
- Patch 17: Drop redundant stream_id >= DP_STREAM_MAX check.
- Patch 18: Consolidate msm_dp_mst_attach_encoder() and
  msm_dp_get_mst_max_stream() definition, declaration, and usage
  into this patch.
- Patch 19 (new): Split connector/topology callbacks out of old
  patch 23+24.
- Patch 20 (new): Split dpu_encoder_get_intf() refactor out of old
  patch 21.
- Patch 21: Squash stream_id condition; reorder before MST encoder
  patch.
- Patch 22: Use thin wrappers instead of renaming/exporting core
  dpu_encoder functions; use suggested for-loop style.
- Patch 23 (new): Split atomic stream enable/disable/check out of
  old patch 23.
- Patch 24: Add hpd_irq_lock; use %*ph for ESI debug prints.
- Patch 26: Defer SST-disconnect-on-MST-cap to new patches 28-29
  to avoid bisect breakage.
- Patch 27: Add comment for clear-before-write DPCD sequence.
- Patch 28 (new): Split from old patch 14; handle boot-with-cable
  SST bridge detection.
- Patch 29 (new): Handle SST connector status when MST is enabled.
- Link to v5: https://lore.kernel.org/r/20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com

Changes in v5(fix comments from V4):
- Dropped early refactoring patches (v4 01-12); restructured as
  "move link-level teardown", "factor out _helper variants", etc.
- Dropped v4 39/39 (platform MST stream list); use DT pixel-clock
  count instead per Dmitry's request.
- Patch 02: Remove artificial max-stream limitation check.
  unify register naming (REG_DP1 vs MMSS_DP1).
- Patch 05: Calculate ACT wait time dynamically from mode parameters
  instead of hardcoded 20 ms.
- Patch 08: Replace start-slot loop with direct math; fix commit message.
- Patch 09: Add locking annotation "Must be called with
  msm_dp_mst::mst_lock held" to msm_dp_ctrl_push_vcpf().
- Patch 17: Rename prepared flag to link_ready.
- Patch 22: Move drm_dp_mst_atomic_check() call into msm_atomic.c.
- Patch 23: Replace bridge-based MST DRM model with encoder-based
  approach; remove redundant bridge layer between encoder and connector.
- Patch 24: Add drm_edid_free(); add FIXME for bpp negotiation.
- Patch 25: Use dp->plugged flag instead of link status for MST plug path routing.
- Link to v4: https://lore.kernel.org/r/20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com

Changes in v4:
- Fixed most comments from V3.
- Rebase onto HPD refactor V5.
- Fixed casing/formatting issues, for example: "mst".
- Drop .mode_set() and set_mode in .atomic_enable().
- Rewrite commit messages that are unclear.
- Use the same API for MST link and SST link writes.
- Use the new drm_dp_dpcd_read_byte() / drm_dp_dpcd_write_byte() interfaces.
- Remove some unnecessary payload fields from the MST bridge.
- Remove some defensive NULL pointer checks.
- Reworked the patch order to make the series easier to follow.
- Add support for more platforms.
- Link to v3: https://lore.kernel.org/r/20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com

Changes in v3: Fixed review comments from Dmitry
- Fixed lots of comments from series V1/V2.
- Rebased onto next-20250808.
- Rebased onto Jessica's HPD-refactor branch.
- Fixed formatting issues in commit messages under changes.
- Removed unnecessary one-line wrappers.
- Relocated MST-related .atomic_check() calls to their appropriate positions.
- Removed the logic related to slot checking in .mode_valid().
- Link to v2: https://lore.kernel.org/r/20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com

Changes in v2: Fixed review comments from Dmitry
- Rebase on top of next-20250606
- Add all 4 streams pixel clks support and MST2/MST3 Link clk support
- Address the formatting issues mentioned in the review comments
- Drop the cache of msm_dp_panel->drm_edid cached
- Remove the one-line wrapper funtion and redundant conditional check
- Fixed the commit messgae descriptions of some patches
- Reordered the patches and renamed some functions and variables
- Link to v1: https://lore.kernel.org/all/20241205-dp_mst-v1-0-f
8618d42a99a@quicinc.com/

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

---
Abhinav Kumar (13):
      drm/msm/dp: add support to send ACT packets for MST
      drm/msm/dp: add support to enable MST in mainlink control
      drm/msm/dp: no need to update tu calculation for mst
      drm/msm/dp: always program MST_FIFO_CONSTANT_FILL for MST use cases
      drm/msm/dp: add support for sending VCPF packets in DP controller
      drm/msm/dp: add support for MST channel slot allocation
      drm/msm/dp: replace power_on with active_stream_mask
      drm/msm/dp: factor out _helper variants of bridge ops accepting a panel
      drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel
      drm/msm/dp: add HPD callback for dp MST
      drm/msm/dp: mark the SST bridge disconnected when mst is active
      drm/msm/dp: enable MST on capable sinks
      drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is present

Yongxing Mou (16):
      drm/msm/dp: skip sink requests while the mainlink clocks are off
      drm/msm/dp: add link_ready to manage link-level operations
      drm/msm/dp: introduce dp_mst_drm module
      drm/msm/dp: add MST connector creation and topology callbacks
      drm/msm/dpu: pass msm_display_info to dpu_encoder_get_intf()
      drm/msm/dpu: use stream_id to select MST interfaces
      drm/msm/dpu: add per-stream MST encoders
      drm/msm/dp: move link capabilities to dp_link
      drm/msm/dp: add atomic stream handling for MST
      drm/bridge_connector: suppress hotplug for IRQ_HPD without status changes
      drm/bridge_connector: avoid detect-based HPD notifications for DisplayPort
      drm/msm/dp: wire MST helpers into atomic check and commit paths
      drm/msm/dp: wake threaded handler for HPD IRQs
      drm/msm/dp: ignore IRQ HPD latched together with an unplug
      drm/msm/dp: select MST stream bpp during atomic check
      soc: qcom: pmic-glink-altmode: skip retimer reset on DP IRQ

 drivers/gpu/drm/display/drm_bridge_connector.c |  23 +-
 drivers/gpu/drm/msm/Makefile                   |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c    |  51 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |  37 +-
 drivers/gpu/drm/msm/dp/dp_audio.c              |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c               | 325 +++++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h               |   9 +-
 drivers/gpu/drm/msm/dp/dp_debug.c              |   6 +-
 drivers/gpu/drm/msm/dp/dp_display.c            | 388 ++++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h            |  27 +-
 drivers/gpu/drm/msm/dp/dp_link.h               |   2 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c            | 679 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h            |  18 +
 drivers/gpu/drm/msm/dp/dp_panel.c              |  34 +-
 drivers/gpu/drm/msm/dp/dp_panel.h              |  10 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                |  17 +
 drivers/gpu/drm/msm/msm_atomic.c               |  14 +-
 drivers/gpu/drm/msm/msm_drv.h                  |  47 ++
 drivers/gpu/drm/msm/msm_kms.c                  |   1 +
 drivers/soc/qcom/pmic_glink_altmode.c          |  38 +-
 21 files changed, 1603 insertions(+), 130 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20260410-msm-dp-mst-35130b6e8b84
prerequisite-message-id: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
prerequisite-patch-id: 38205d2013335920df343c240fa0afc17b987763
prerequisite-patch-id: 358e5f35d442041b88e52d8e39a564a053a0f990
prerequisite-patch-id: 9860b9acb12b1c2652e4e9f4860968a2ca3361f0
prerequisite-patch-id: 53486e695198f785401740f7f4372bdf335fb620
prerequisite-patch-id: c8e551a07553f7dc107063a1dbec1d415184f97b
prerequisite-patch-id: 1a6251919897ca5e8b12a63774a833fd8460c67a
prerequisite-patch-id: 846ab694795c6bec123d1dc46d7a53097bf594bf
prerequisite-patch-id: 2a058aa8309016f424b1d4ca19a9b20e92f4d8b6
prerequisite-patch-id: 76ea1ecf4e1d83ce2e5730aa36ed1a4524f15e56

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

