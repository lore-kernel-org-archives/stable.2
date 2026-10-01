Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0E522EFF
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867864; cv=none; b=VFjlZ9f1gJIkNtNyCYkS63qSmjwYWuFykxyD03oOMG+FxdQHxhlxTQHGimKl5Xhma1L1PCQUN02HGzZDRTKb0DRFNInsVmRqB8a9ycvYrJWcNXj3HmHLa5MvelxSouJ9q+7KRJRjvvVsX2YAqEiGfe/kaf+AST3JDylVCsFlYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867864; c=relaxed/simple;
	bh=Jv7XpT22GYduEgLAavg2+f2r41gSeYiJxQFNlACWjho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b2Jyz7wsSpzAN1vtP8LCtPlI0IdACmDd0p6dHH233adIbcdtlesX4l+H31CEOGGMaP+iCSclqwdLRPqccvXWQNJ//BtQ889mCQJWNdd62ihsD/dztOHWgQUreBLdpgEQTR2WCwkS9iynCRKL1vhzcoLNzWk9KxtGzkwDtpt2B3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fsjzC7SJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ORwuMUO7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsjzC7SJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORwuMUO7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691Dj7KT2188702
	for <stable@vger.kernel.org>; Thu, 1 Oct 2026 15:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eLCI/6H15oIylqRpunV3IA
	j51AK5yquTP03R8RLF0SI=; b=fsjzC7SJpqURnXg4DoHL8DaN/og3WomcFjPJeW
	R+Ijmi/ffrV7aTmESJRpBy/df3kDaiE0yl/2FIJi0ZB8QTXJpy3mAaeciCJ8mRSH
	50zchIh8T8WT3ecUWdorwbF8BC3G/NgJqwQgtcs5OWWjZxwDZzjVsM3fNGS864Pd
	SEmTbHkCA62MZdSJyRnP+l0/vnc9NtOILpJQydaQX3lP05uk7RiI/2IH1XaXdmgp
	B/FxwmApU09ujv+IwXt85QZHzjHJCCX4642VanbUwQ3RowtMM42NjNApDYjhhObZ
	yb78P0rGiXi0dGQSa9whg5gCwdDmimp44YtGtX5ESof/ARMg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pjcpm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 01 Oct 2026 15:17:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34ef0362d95so281745eec.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790867860; x=1791472660; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eLCI/6H15oIylqRpunV3IAj51AK5yquTP03R8RLF0SI=;
        b=ORwuMUO7z2QsmM0kAOFg9DmOLrn6Hf2WzZdAtPKTSmGxLnYe2xHQvkXZ8e0YrolkIa
         BbnRY8uK2wEy9tkreDVDKK/G1i0lis/PWL/qy+GwHBpgVTdTbI1WbazlRX47qt+i0lfG
         S3cQpvkM8w5DyLiHpGxR0ZVRIG/fu0bji7hzR+fk68iPl5+y8aoKB4wGv/7NuKVcjoi1
         2vwGc3wRU9s9v1AaU7kbV2KDJ5jkIRLGuiD86IT0G8jpVSPOJuhAODsq+LWCBzlIfzyq
         4f+SMtIXuhl6RnDWrtv9ENo4KKkhfrJ2uyb1MENTqDRbfn+tkK8YIRhYN+zEgEbrYYjA
         7Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867860; x=1791472660;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eLCI/6H15oIylqRpunV3IAj51AK5yquTP03R8RLF0SI=;
        b=dQvMOUJZeOPvKvOj2m4IPC/mT4tIGv+NlJgMUkuqevkCTDwA1JZGoJI8rEFFK+0xVx
         57SgPYGzEuONZXp0XG7Ty+RBcWx4pCwHMPBLrkYNQSWn0HP5ajzUnxdQmTNT/nGo5+gu
         7kXfgVhTpDJ89pZIdD5HHYI86NMCBmwyiBkq7L1HeavCpt9hvf7Ulfyo7QnaRzCRqUx9
         Sbi+xfOYg2Bw/agsLKdLtn2PZQvQNkF8M6tLx90dXdlVxSEAYp/TmIC5AglOGKegECek
         D9UHsdLADiIl3+nHn2fmnzL1EFkflpOOqDT/lHdtDIiE2a1vdmbyg/BpDEnKdCTakebY
         nL8g==
X-Forwarded-Encrypted: i=1; AKwUvBwQOKtat/o622omjXOBttxD+joUC2/Yv9M+wLFUTJoqHQ/zqIsqj9auKEHr22DPtlyek4UMheM=@vger.kernel.org
X-Gm-Message-State: AFuF++ljxt5AZt2PwhFu89SfCUqFP+cTZ0DKLqGIuzBT9aQjzOCE/IqR
	iAgQ60agEpe8oXqFqleU7XPuLGCTFWxxgFQ7gdHxh6TkM8QoCg/HO0iA/z5GrhbBz5+aZNaiv0Z
	0jxHRNCzB5AVpGKV6h3d5UfR0ydMeLv7MeTJSN+u93ZSZoA8pmm9gJg/WbMeLQWAw6r0=
X-Gm-Gg: AYBFou1JAzaqttPEA7j5XqBRKtBntlh23smsKN4EatR1dlAwYF4fPYt+2gs4Fn2gEwe
	NYA/ozDzNe/4KbVRiLiuVTTukfwYAhylLicBJDAsm+hxVzGLs9ijSdKc4tEmnMRmtUW4/FIcHv5
	dwCICbBJAxzOCk5N1L9J+BNF3MWlFaf+wXTTzqLiuhFDGcneMBGdtrvRurVIj4ABgrS82PtlbMQ
	Jrxlm7YO3mLiZkAK7RV8uQyB12D9mlk3vqMnQ5MDmY7W15ZrPpYKqYSsRS2yzlIM6d2W3WVurJI
	K/1h7oxOFcFy4fGo68phOdd520mXOTfmpl5DgMbRRT/mndL5RIDV2MTwotjcVA21O04L4TCmdAa
	u+swk+gXxv9aEtlzlqMqk5emaJcvhMFdBOA==
X-Received: by 2002:a05:7022:eb54:10b0:143:2973:3240 with SMTP id a92af1059eb24-14d32be0677mr5242579c88.29.1790867859383;
        Thu, 01 Oct 2026 08:17:39 -0700 (PDT)
X-Received: by 2002:a05:7022:eb54:10b0:143:2973:3240 with SMTP id a92af1059eb24-14d32be0677mr5242517c88.29.1790867858560;
        Thu, 01 Oct 2026 08:17:38 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f246d32d2sm115700c88.1.2026.10.01.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:17:37 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v4 0/6] media: iris: add support for kaanapali platform
Date: Thu, 01 Oct 2026 20:47:20 +0530
Message-Id: <20261001-kaanapali-iris-v4-0-642f9ac5e699@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJ5vmoC/yWNa2rDMBCEr2L0uwrSSlZlU0rvUUJYS+t0qV+RY
 lMIuXtlh4WBGWa/eYhMiSmLtnqIRBtnnqdi7Fslwg9OV5IcixegwCkNTv4iTrjgwJITZwlNH7W
 3BD1ZUZ6WRD3/HcDv88snuq2Fe3+FYqSc8eC21ceBbQp2W9YLz+O464aXMh0Hnq5yq6WSygAEr
 GPQKnzNOZ9uKw6htE9FPvfZDjPJPeF7W7kAofP7WRNBO+xq23Tu3aOK3hsdrNG1ISXOz+c/NlR
 RUQEBAAA=
X-Change-ID: 20260126-kaanapali-iris-29fd184e2fe4
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790867851; l=18028;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=Jv7XpT22GYduEgLAavg2+f2r41gSeYiJxQFNlACWjho=;
 b=MV6cMK9ePrQQO+p5tJovIVdjf3fj87K9gh8YbTu1JT4npB8p7YX9GY42/kwSM2GsIonhWnX3S
 XAXfNR+3niVAoqVs+PQ59vA8TVRRv832WESkRTDimrivvJNpWXyZG5Y
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abe7994 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=apL-334RAAAA:8 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=cS29Iae8hRQUOWnX22oA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=eWIHaOtA_ULHaMmHwLHW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: _IxgVsuOwA2SXbdS7mx1HisElgcsYaV_
X-Proofpoint-ORIG-GUID: _IxgVsuOwA2SXbdS7mx1HisElgcsYaV_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX9JqPP4lbG5u3
 CrzzozQ8hDfPCnLttPUf7MhUlgytPDhCmABjN33sOSkb5vdj1Lt86vVY1YPznhRrlpkl/VwKCa+
 6swyIC9uRhLhd6ukGhmaH1sNA52YhdM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX4EdiXpX7HUfk
 dULr9gV1HiaJQatdzjWBcvf99JWzwKWmaaf8rOCy0cuAo7iyUN+Th+GoOVlPSJzvYmQ/sDrO76H
 4gwfRHpKcXQ0cwOdnGkZU+RRwAXGy2hr+zlSjyzONFxkMCodWtBilb0FRF456CnycTIfhf+nuLv
 g0Qn7i6AeNHFbuIvZhzfcE/VllRpFb1GMI4WAkwH5ypxfMo9LWb15hOn6epUDcAmRo2UNW5aPNT
 j/TC4waKaAUav42mAXUZzOINY8XgYB2uVyQ3ajfpwPjoJbh97mzHWK+IMstzeKGTUzpRS8S6YwE
 teLNONP49r2FGzA48/8x+N2IZX2K10GJqkRR/T2wKfKSvDFZbHFx3UCiPMasfskjwhWbRJV95Xw
 2WqcXzN/WdjSIAyLhioSVX1M8iCrED+7ZpbLaAdNSsS5Gj5EUONM7xWlKYYwXSmykGGZsd0vRYL
 7Bp35+lQTBQ/q3hWRWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010060

Qualcomm kaanapali platform have a newer generation of video IP iris4.
The hardware have evolved mostly with respect to higher number of power
domains as well as multiple clock sources.

Following are the compliance and functional validation reports.
v4l2-compliance 1.33.0-5506, 64 bits, 64-bit time_t
v4l2-compliance SHA: 91dda32e4cc9 2026-09-28 07:58:16

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Decoder
        Bus info         : platform:2000000.video-codec:de
        Driver version   : 7.3.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Decoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 12 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (select, REQBUFS): OK
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (epoll, REQBUFS): OK
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (select, CREATE_BUFS): OK
the input file is smaller than 7077888 bytes
        Video Capture Multiplanar: Captured 465 buffers
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
                warn: v4l2-test-buffers.cpp(2220): Cannot test DMABUF, specify --expbuf-device
        test DMABUF (select): OK (Not Supported)

Total for iris_driver device /dev/video0: 55, Succeeded: 55, Failed: 0, Warnings: 1

v4l2-compliance 1.33.0-5506, 64 bits, 64-bit time_t
v4l2-compliance SHA: 91dda32e4cc9 2026-09-28 07:58:16

Compliance test for iris_driver device /dev/video1:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Encoder
        Bus info         : platform:2000000.video-codec:en
        Driver version   : 7.3.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Encoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video1 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 65 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, CREATE_BUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
                warn: v4l2-test-buffers.cpp(2220): Cannot test DMABUF, specify --expbuf-device
        test DMABUF (select): OK (Not Supported)

Total for iris_driver device /dev/video1: 55, Succeeded: 55, Failed: 0, Warnings: 1

Fluster test report:

77/135 while testing JVT-AVC_V1 with
GStreamer-H.264-V4L2-Gst1.0.JVT-AVC_V1

The failing tests are:
- 52 test vectors failed due to interlaced clips: Interlaced decoding is
not supported.
- cabac_mot_fld0_full
- cabac_mot_mbaff0_full
- cabac_mot_picaff0_full
- CABREF3_Sand_D
- CAFI1_SVA_C
- CAMA1_Sony_C
- CAMA1_TOSHIBA_B
- cama1_vtc_c
- cama2_vtc_b
- CAMA3_Sand_E
- cama3_vtc_b
- CAMACI3_Sony_C
- CAMANL1_TOSHIBA_B
- CAMANL2_TOSHIBA_B
- CAMANL3_Sand_E
- CAMASL3_Sony_B
- CAMP_MOT_MBAFF_L30
- CAMP_MOT_MBAFF_L31
- CANLMA2_Sony_C
- CANLMA3_Sony_C
- CAPA1_TOSHIBA_B
- CAPAMA3_Sand_F
- cavlc_mot_fld0_full_B
- cavlc_mot_mbaff0_full_B
- cavlc_mot_picaff0_full_B
- CVCANLMA2_Sony_C
- CVFI1_Sony_D
- CVFI1_SVA_C
- CVFI2_Sony_H
- CVFI2_SVA_C
- CVMA1_Sony_D
- CVMA1_TOSHIBA_B
- CVMANL1_TOSHIBA_B
- CVMANL2_TOSHIBA_B
- CVMAPAQP3_Sony_E
- CVMAQP2_Sony_G
- CVMAQP3_Sony_D
- CVMP_MOT_FLD_L30_B
- CVNLFI1_Sony_C
- CVNLFI2_Sony_H
- CVPA1_TOSHIBA_B
- FI1_Sony_E
- MR6_BT_B
- MR7_BT_B
- MR8_BT_B
- MR9_BT_B
- Sharp_MP_Field_1_B
- Sharp_MP_Field_2_B
- Sharp_MP_Field_3_B
- Sharp_MP_PAFF_1r2
- Sharp_MP_PAFF_2r
- CVMP_MOT_FRM_L31_B

3 test case failed due to unsupported bitstream.
num_slice_groups_minus1 greater than zero is not supported.
- FM1_BT_B
- FM1_FT_E
- FM2_SVA_C

2 test case failed because SP_SLICE type is not supported.
- SP1_BT_A
- sp2_bt_b

1 test case failed due to unsupported profile.
- BA3_SVA_C

140/147 testcases passed while testing JCT-VC-HEVC_V1 with
GStreamer-H.265-V4L2-Gst1.0

1 test case failed due to unsupported bitstream.
- TSUNEQBD_A_MAIN10_Technicolor_2

4 testcase failed due to unsupported resolution.
- PICSIZE_A_Bossen_1
- PICSIZE_B_Bossen_1
- WPP_D_ericsson_MAIN10_2
- WPP_D_ericsson_MAIN_2

2 testcase failed due to CRC mismatch.
- VPSSPSPPS_A_MainConcept_1
This fails with software decoder as well. Earlier discussion on this
here https://lore.kernel.org/all/63ca375440c4ff2f55ea0aa4e19458f775552d88.camel@ndufresne.ca/

- RAP_A_docomo_6
This was discussed on bug
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4392
Based on above discussion, the initial error frames need to be safely
dropped in the firmware or driver side. Client does not have the
required logic to drop them even if marked as error.
Discussion ongoing with video firmware team on a way to handle such
case. Note that the issue is not specific to kaanapali, and its there on
all platforms.

235/305 testcases passed while testing VP9-TEST-VECTORS with GStreamer-VP9-V4L2-Gst1.0
64 testcases failed due to unsupported resolution
- vp90-2-02-size-08x08.webm
- vp90-2-02-size-08x10.webm
- vp90-2-02-size-08x16.webm
- vp90-2-02-size-08x18.webm
- vp90-2-02-size-08x32.webm
- vp90-2-02-size-08x34.webm
- vp90-2-02-size-08x64.webm
- vp90-2-02-size-08x66.webm
- vp90-2-02-size-10x08.webm
- vp90-2-02-size-10x10.webm
- vp90-2-02-size-10x16.webm
- vp90-2-02-size-10x18.webm
- vp90-2-02-size-10x32.webm
- vp90-2-02-size-10x34.webm
- vp90-2-02-size-10x64.webm
- vp90-2-02-size-10x66.webm
- vp90-2-02-size-16x08.webm
- vp90-2-02-size-16x10.webm
- vp90-2-02-size-16x16.webm
- vp90-2-02-size-16x18.webm
- vp90-2-02-size-16x32.webm
- vp90-2-02-size-16x34.webm
- vp90-2-02-size-16x64.webm
- vp90-2-02-size-16x66.webm
- vp90-2-02-size-18x08.webm
- vp90-2-02-size-18x10.webm
- vp90-2-02-size-18x16.webm
- vp90-2-02-size-18x18.webm
- vp90-2-02-size-18x32.webm
- vp90-2-02-size-18x34.webm
- vp90-2-02-size-18x64.webm
- vp90-2-02-size-18x66.webm
- vp90-2-02-size-32x08.webm
- vp90-2-02-size-32x10.webm
- vp90-2-02-size-32x16.webm
- vp90-2-02-size-32x18.webm
- vp90-2-02-size-32x32.webm
- vp90-2-02-size-32x34.webm
- vp90-2-02-size-32x64.webm
- vp90-2-02-size-32x66.webm
- vp90-2-02-size-34x08.webm
- vp90-2-02-size-34x10.webm
- vp90-2-02-size-34x16.webm
- vp90-2-02-size-34x18.webm
- vp90-2-02-size-34x32.webm
- vp90-2-02-size-34x34.webm
- vp90-2-02-size-34x64.webm
- vp90-2-02-size-34x66.webm
- vp90-2-02-size-64x08.webm
- vp90-2-02-size-64x10.webm
- vp90-2-02-size-64x16.webm
- vp90-2-02-size-64x18.webm
- vp90-2-02-size-64x32.webm
- vp90-2-02-size-64x34.webm
- vp90-2-02-size-64x64.webm
- vp90-2-02-size-64x66.webm
- vp90-2-02-size-66x08.webm
- vp90-2-02-size-66x10.webm
- vp90-2-02-size-66x16.webm
- vp90-2-02-size-66x18.webm
- vp90-2-02-size-66x32.webm
- vp90-2-02-size-66x34.webm
- vp90-2-02-size-66x64.webm
- vp90-2-02-size-66x66.webm

2 testcases failed due to unsupported format.
- vp91-2-04-yuv422.webm
- vp91-2-04-yuv444.webm

2 testcase failed due to unsupported resolution after DRC.
- vp90-2-21-resize_inter_320x180_5_1-2.webm
- vp90-2-21-resize_inter_320x180_7_1-2.webm

1 testcase failed with CRC mismatch.
- vp90-2-22-svc_1280x720_3.ivf
Discussion ongoing with firmware team on how to handle this case. This
is not specific to kaanapali, and its there on all platforms.

1 testcase failed due to unsupported stream.
- vp90-2-16-intra-only.webm

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v4:
- Migrated to subnode approach from iommu-map.
- Drop the separate vpu bus as it is not needed with subnodes.
- Drop the patch (#2/7) which was applied.
- Updated buffer calculation to pass 10bit fluster test cases.
- Moved data definitions from headers to source (Krzysztof)
- Link to v3: https://lore.kernel.org/r/20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com

Changes in v3:
- Added description for each item in iommu-map property (Dmitry)
- Dropped definition of iommu-types (Krzysztof)
- Renamed file to qcom,kaanapali-iris.h (Krzysztof)
- Updated function id from hex to integer (Krzysztof)
- Moved the struct to facilitate individual patch compilation
  (Krzysztof)
- Fixed copyright by dropping the year (Dmitry)
- Updated struct in platform data as const by moving the context bank
  devices to core struct (Dmitry)
- Simplified logic to get context banks by array indices (Dmitry)
- Dropped BUF_HFI_QUEUE, instead get the device directly from prefixed
  region (Dmitry)
- Link to v2: https://lore.kernel.org/r/20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com

Changes in v2:
- Described iommu map in a better way in binding (Dmitry, Krzysztof)
- Defined the function IDs as ABI instead of hardcode numbers (Dmitry)
- Added iris vpu bus and configured callback for dma_configure (Robin)
- Remove parsing of iommu-map from driver (Robin)
- Fixed fluster issues by adding H265 line buffer calculation for vpu4
- Dropped iommu patches #2 and #3 from this series. Those would be
posted separately (Bryan)

- Link to v1: https://lore.kernel.org/r/20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com

---
Vikash Garodia (6):
      media: iris: wait for vpu NoC to enter low power during power off
      media: dt-bindings: qcom-kaanapali-iris: Add kaanapali video codec binding
      media: iris: add iris4 specific H265 line buffer calculation
      media: iris: add platform data for kaanapali
      arm64: dts: qcom: kaanapali: add iris video node
      arm64: dts: qcom: kaanapali-mtp: enable iris video node on mtp board

 .../bindings/media/qcom,kaanapali-iris.yaml        | 227 +++++++++++++++++++++
 .../bindings/media/qcom,sm8550-iris.yaml           |   6 +
 .../bindings/media/qcom,sm8750-iris.yaml           |   6 +
 .../bindings/media/qcom,venus-common.yaml          |  11 +-
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts         |   6 +
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 142 +++++++++++++
 drivers/media/platform/qcom/iris/Makefile          |   2 +
 .../platform/qcom/iris/iris_platform_common.h      |   4 +
 .../platform/qcom/iris/iris_platform_kaanapali.c   |  58 ++++++
 .../platform/qcom/iris/iris_platform_kaanapali.h   |  15 ++
 .../media/platform/qcom/iris/iris_platform_vpu4x.c |  66 ++++++
 drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
 drivers/media/platform/qcom/iris/iris_vpu4x.c      |   4 +
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c |  59 +++++-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h |  16 ++
 15 files changed, 620 insertions(+), 6 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260126-kaanapali-iris-29fd184e2fe4
prerequisite-message-id: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
prerequisite-patch-id: e1330b5a848460d14cd6574877fcf607d269d9a1
prerequisite-patch-id: 20d099e89443a097b9ec5b297f0129d9874ca54b
prerequisite-patch-id: 2a36ab03d78d8e9c19c900e203b05739a9fd1123
prerequisite-patch-id: eecfd66a55b8f2b7b2fc7d76d815facca0489d00
prerequisite-patch-id: bb9ca73889bfca249029efb854fb1634a4360b5c
prerequisite-patch-id: 9e71460e2d5f1e4e2993819f4d9fa27c076946f1
prerequisite-patch-id: a2b127d41c7133ea30721a72eca01333334844f7
prerequisite-patch-id: e34741f76b6919db19236ead27c966b789736e66
prerequisite-patch-id: 359d24229ad496633892e70b1cf88c2d88dfad24
prerequisite-patch-id: 6e2e9069cb620143aa305b7b29b8b1982dd0648b
prerequisite-patch-id: 3e5fe6ef2271be5263a4bf7ffbd77b0996037b27
prerequisite-patch-id: e051524017c9f39f8593fb9d2e982e6a4c39fb35
prerequisite-patch-id: 1b4863f7a7f3a8390c825d76805e8e99de97a2a7

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

