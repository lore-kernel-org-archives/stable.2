Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387957;
	b=udnOxNI4u6Ya0/oABuT/HV8FL5cL0rDU3lGkX5s7bfgqU74KLvJ/HFT1EjJNdl6u67an
	 TycTloq1CysJtobwxlav5ePFxtDq+nY07NjIarVE0r9IbRNkmZUf0/41uZjukBa7ZIHqo
	 M3AbgMfdONRIiZLyVIbDNOjCXmoGFlnXmXzjODF20DcoHxR2/4ojnFFv/+5rcNqKu3Pb0
	 k0Ti8ESGoJLSON1MUgVxwk7oUvU9cVu7LL1/mi9jf15i5ZA5nLKu3PfrduV1tFC744phN
	 VaNIBF9Z/9DZxUGRTBGYhwZ8M4ju2tlmGaP1B/1h8PkeZK8BGlFveSC3GiUD5czfZ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387957;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6tNaRTlQhtagN9ATdJGn+dy+DRH69mokAHtAJWySBto=;
	b=ggDmw3D1Fv2MjCsaUPgB7NDPWBAQbWgdPh+bbg5ITi7R8MIbMZdtMJ2LZFBEbi+v+1I3
	 YaTk2U3luDNc8AFwb7U861GtVzTQ1VqNiyTUNS/6JmUsVORxyBhDQAnUBs7mNSQlK5W6h
	 f4enbUtE4RzMqAHYkZTxY1POczMn3J24Bsn5dlFwNH0C8D1/nfiJs/6PViqrBHaAqq/ej
	 4zXGYze4e6INNxLu1G1zrcgFbvMHwEGy17wmyxdPR6cYLxjXdAxmXJKpWhbUz0TU8Iypx
	 euOHX3uB4QJntYCy06+gsQ1U2EOhxRSx1NpwshHRaLor9+eexdKr30s0NTQBTsJDNtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WBhWkviA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z0Cz1Fe4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78124606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78124606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WBhWkviA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z0Cz1Fe4
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KKtX2350837
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6tNaRTlQhtagN9ATdJGn+d
	y+DRH69mokAHtAJWySBto=; b=WBhWkviAF0rSOQc2+96Ex06+/L+nd/Ty29AUcQ
	z+6INBjLNQIX87OFOrR3cKS53X++j7X2LwPY+JEt2fLI99clyUcKCjRKf0+8w53x
	IC2DU4w6NMeIHFdqXbLmWSx8aSl90cTfiXC0mgIEicvIcp+bxEkwwRgpJ61uz1Yk
	7BlWSTao/7JxLYVZdPNLu0dOAQ5Cf9opkhyWZHBglTlCDFpQpmoy5hYu9TcIM82H
	svArs3HE09/qn37KMcb5ex90A6VPtWheLEDriwO7V38jMIh+BIj/ApPktL083Lof
	ncWIHT1ORux1bhBQc/nsfxMeo9trvhYq5YOu6srT7ozEjLdQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp1sdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:05:55 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1a71dd190b0so1039830c88.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794387955; x=1794992755; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6tNaRTlQhtagN9ATdJGn+dy+DRH69mokAHtAJWySBto=;
        b=Z0Cz1Fe4h5p3vq33CwEvEMP/tU4mt2JAbyd7znWMbUdhpMM/UlafBrymiZXns7C8Wk
         nKCTvFaVGjK/g9AQ4Y6Xu+NGUazHZp0nELcGW5MzEOD9M0sK6HqCyRu/GAtMhIDDKfUo
         T9Alf3mFZk2hRvc8x34hzIyb1OuIvdSgZOs/vFYjnRKX1s/zjzqQGLk51wtwqKIpu16F
         /o5vzOU9j1zNg3vGM8di5QmlY8s+l5Pn9jp/5qQWCjCvTiXOlIQbjjtErOpC/zkA3XYw
         xOOFDAfK+QQOkPBo1elLLoDhgYpUJHDxzYYIUlDOOu0Jd0nmuytC7LybrMHTGm9exM5V
         W47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387955; x=1794992755;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6tNaRTlQhtagN9ATdJGn+dy+DRH69mokAHtAJWySBto=;
        b=g3i9v15K1yRh2g0Y55ltDNnXxIRDAY0446FMYMGdCk9M8CNRWpPcjErPfKBVo5Zvgj
         phF/B0JO7K+Y60GgNRNz9g3npyGy2JNvesJspax2dUmyYLDRbwlDa9f2PsczOcuqrTIv
         ERBkXxl2VAD/AecO8z3a05x7g9ZqWdWWDU6qTHyuNvJTsoe+XJ2yIhRMs6YV5BFw0d/+
         8t7BYTvKYehO6QgbgE5FidXaGq7D3ahrCx5zCH6di4I3QrWOBTo+AdvDWIxHWdPvt71P
         BeKm0zZe/5HNnPe6Lh9AZUcp86n7b5lA+S2pj/NJlEqWingmYJeLqdCUOuESpiQbX3mp
         nsvg==
X-Forwarded-Encrypted: i=1; AL+hErHdjhte1JItTKlOPqgBzmIltBn3A+jrGxQktTarQlHqOjhmoD1SjjB50FFvXlzXkjxg9v2FENg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vhAQzjow/JmycJCIe0Buc21ge82V8dp4E45jlnh19KBXyKxUw
	iO6tQkTdW8ChpiLX2+/vEzJJJL0t2bU45T+CLh/9RP0JQSP5epG05LqVlYUJQTQqz/xJrBm2PDU
	rCzItIl0WKHXt1mcUA9GfUiPTceVprwh49LeAxMaoCeYXya7Lvk7aeDKQnHE=
X-Gm-Gg: AYBFou30Bg9g5FyOK6gIpEg7jRSKHDNVm2KLjuaFxS8LfOjRCljnMWf/Fvh2y2g97DB
	dLqVNuwmHq6ILrYP2y6W4Ak574eJLQJlShcEsIqYf3Ff528rNtX/vclYfy+BWZe5OCBEdYolJ1u
	4e918pcQB4Bv2cCAAaX9muAB58wVJt3VxyxjBYdUgOsvX828IkR4zCAn0z/Ip41yMjDjuckY+zv
	iAOWVHbRULQa+kOASZaW7PePC261O8xNkNZ+ieH1QKZT7EAiQmfsvbEpkd8scTzAOpzUzdn0ynx
	YkPTvt9MTzR3AqYx8khFvqF/+tC+Vlat3xufFKONyoJyU7Fbs0l0NU0E4TTdHh0OiijS1ASGW7W
	u+q65/s6Z89TVdXvuw5x7OJxnuUAJGpqM3PJffEwosua5pwBzSIuGhVowRytMd50uZyfzo5fV/j
	IbvjhGuw==
X-Received: by 2002:a05:7023:d0d:b0:199:7dff:f9cc with SMTP id a92af1059eb24-1b3c034acd9mr1967591c88.42.1794387954918;
        Wed, 11 Nov 2026 01:05:54 -0800 (PST)
X-Received: by 2002:a05:7023:d0d:b0:199:7dff:f9cc with SMTP id a92af1059eb24-1b3c034acd9mr1967555c88.42.1794387954095;
        Wed, 11 Nov 2026 01:05:54 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm16915277c88.11.2026.11.11.01.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:05:53 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v2 0/3] media: qcom: iris: Fix IRQ synchronization during
 power-off
Date: Wed, 11 Nov 2026 14:35:13 +0530
Message-Id: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkv9GoC/3WNywqDMBBFf0Vm3UgSfNSu+h/FRaKTmqJGMyoV8
 d8bLV12M3CYc+/dgNBbJLhFG3hcLFnXB5CXCKpG9U9ktg4MkstMcJ4wY9+stqR0G15+ZKQMtis
 TqZYmF/LKuYYQHjwG8yx+lF+mWb+wmo62w2gsTc6v5/IiDu83kv8bWQTjLEnzJDOFKmSNd0cUj
 7NqK9d1cThQ7vv+AXt+7ZLVAAAA
X-Change-ID: 20261004-fix-disable-irq-safely-15b2f712800b
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org,
        Joonhoe Kim <26rote@gmail.com>, Birk Skyum <birk.skyum@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794387948; l=2331;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=RJLA/B8vERsCEECkiEYsGsg+UkPdUdj8qywWgY13ar8=;
 b=0Jl55PFZ4C3O4LFvNjVV0FTA56cdv5MeL7kOoTf/Ojuri9vYEvO6tYPR6L1tZAAa7Gfix+Jux
 s6EnPDaThPaDtng2JNv40d3qRbGXKTz+C7R3RpPtp8ZE/8gUBR/h/U3
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfXz/d/O+hfR/ut
 rUIdmZiobZrW+Rn/iYQsKJxFmDaDqocSacVhSzPlgHSZodxS7zCTjdP5gueZRPhF4qithZ9cWjv
 KbkKyrfYHb+7HeVFNQz+LTILJZRTLq6KEQDEQf1pvc3Ke54JJkDudV039XgGYHpwsSdRE83pDrc
 hAfj9onlbK1ggOG9dvvuhgC4PJbfnJAs9moIh6JpX86JWv+O4OvxMs8TpywEsvuGccar0LDJzP+
 APfhrQnVk45W2qzUNFUYHF2yEXFTgtILjPjkxfM3/wLN27hV1slvkXo/bY/uVGL62jeKIgfbZuL
 An0ZN5+MK1s5ZHmxXVEAgvFWVq+BbFC1iyktmp/YwAqfOMMNEdLupLIshITZwmJ/1YuSBaajV5E
 3khQO/ESStsmXLrnaBbPgEFShJ84Ifuh6r1SmKiOIqRhOuniqjuV3A+QNlNGvD8sLh9qKF8F+mE
 QO7DYeY7WIAbR5s9yDw==
X-Proofpoint-GUID: utB52HF5suEISJOGVwG-SSiuSnzFoBtq
X-Proofpoint-ORIG-GUID: utB52HF5suEISJOGVwG-SSiuSnzFoBtq
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af42ff3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=dB-pHhy3aynsDHbeDQ0A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX0y+ry8OWKwPQ
 4+XS+84ZO+Xa9w4Sj9cy4b0r2QGn9NwOueJurw07HQ5AV7O70oebrnSa58kiMK6sErHsydwum6b
 iN+5VCse6BNkQHpVY/8td7frk/NnaPc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110036

Commit b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during
power-off") changed the VPU power-off sequence to use disable_irq()
instead of disable_irq_nosync(). This was intended to wait for any
queued threaded IRQ handler to finish before gating VPU power.

However, iris_vpu_power_off() is called with core->lock held, and the
threaded IRQ handler (iris_hfi_isr_handler()) takes this same lock as
its first action. If the handler is queued when power-off begins,
disable_irq() blocks waiting for the handler, while the handler blocks
waiting for core->lock. This results in a deadlock.

This series reverts the commit that introduced the deadlock and
reintroduces the hardware protection safely.

The fix drops core->lock before calling disable_irq(), allowing the
pending ISR to acquire the lock and run to completion. To prevent race
conditions from concurrent power-off callers during this unlocked
window, an irq_disabling flag and a waitqueue are introduced to
serialize operations. Finally, disable_irq() is called before the
hardware is powered down, ensuring a safe hardware state.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v2:
- Added new patch to handle the irq depth
- Link to v1: https://patch.msgid.link/20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com

---
Vishnu Reddy (3):
      Revert "media: qcom: iris: use disable_irq() during power-off"
      media: qcom: iris: Wait for threaded IRQ completion during power-off
      media: qcom: iris: Fix IRQ disable depth imbalance on watchdog interrupt

 drivers/media/platform/qcom/iris/iris_core.c       | 10 +++++-----
 drivers/media/platform/qcom/iris/iris_core.h       |  7 +++++++
 drivers/media/platform/qcom/iris/iris_hfi_common.c |  6 +++++-
 drivers/media/platform/qcom/iris/iris_probe.c      |  9 +++++----
 drivers/media/platform/qcom/iris/iris_resources.c  | 16 ++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h  |  2 ++
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 19 ++++++++++++++++---
 7 files changed, 56 insertions(+), 13 deletions(-)
---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261004-fix-disable-irq-safely-15b2f712800b

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

