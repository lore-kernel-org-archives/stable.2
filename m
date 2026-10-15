Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672043D5660
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075607; cv=none; b=McCsnGekNtYzYrWRoKmRRKd/dHYgikAkWDjyTGC2l6fHS2kOUJOxcVrTReaMGIcs12Zlz/YfxupqoBCs8NUt0NLqYnmZu5xR2ca8jr8hPrgv9C50p8x0RE/xB8j7wFnY+dWCfqhjEb/0xrrAOj8GoKnoDWqMSrtYobzhupuE1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075607; c=relaxed/simple;
	bh=NHgIRIYeSxxBM4Z2O/FYMoXHETZQ8rwvjZE3GOfWUQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OlbjhPc1Fczb4haYgoOjUFSCCoY5prKN3VmqeHyQ9Lf2ySIuO8JfAFnTDQysxK0C2f80Stw7jCnINVYuLQaR7z4HTbifB4vpxKE8rwjSjAFnn43WMg5bOXKWnhgrFzrie8KOxCkyysFWl52Ee265TN+oTu2HGA1CNng8FiLU5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqmVQKLG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfzU72e1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqmVQKLG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfzU72e1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jRek2662625
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u/nlLAyrIY971jI97tgUiI
	dOKUIdrmUXPoG94AIgOqI=; b=EqmVQKLG6kmBa3f0f+xOOJQCVN3EpYtnoes67G
	oiup/ZJJhnXDxfxd4OqlkzX0k79nVGrC1Fr7F7VvtfBbyhbS5HtKHq/7xgMnDejk
	P2k9Ya9ao0hl+z8xOwR+panrEL5/tMh6D5GgczradBvJAJPD8Q8Z7AOBkI9sd2sR
	XOcDFj54Mi0WTI4PU0MDRqpJZ6wwvJeej5itid90GhT0njk3qEp+sJJD/JPncXQH
	5saLnS22rO7/WbrtyHSwFVXqNeoFENL1dJSyA59/4fPzzYkJ5ceAwo28FQqcM3OA
	jv2O+8ut3eORaJWLFAzhgS6KPX88+ani+Me7Z+mlR3P++J3Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda2km1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:46:45 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e94989d97aso1463169e0c.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792075605; x=1792680405; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u/nlLAyrIY971jI97tgUiIdOKUIdrmUXPoG94AIgOqI=;
        b=FfzU72e1K+60r9rkq9PYarah3lDNB7z1ymuxU5DQzsaWsr7/pgncPQ5Gv0s+rmk1n1
         DtxuHHi5NvBFQcrRTSmdavN3Mi5rQ0+29DDE+OYIVigeyglUXXOt+yk/oHWClsbpzgMF
         I52ft4U06TOC4nDZ1A53BKb4rtmZv2d2VpchhBZfTjx5yz0gTkASpXEzowwrrNFV31BU
         o/LpbAE28w4wnwX/uJWZ+kfz9Y1VoaEVXmjhB17VnqUboJjY7f/895tSr3VuVyutyTOi
         6gdi7pX03yLqW7SwKo6LUKyuJid4TMN+lf+9yl1aH8xgtlQWVRxYGMpLBQtW0sdlLNiV
         Lrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075605; x=1792680405;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u/nlLAyrIY971jI97tgUiIdOKUIdrmUXPoG94AIgOqI=;
        b=Gnbhh2SrMXJJiLoSovcZxnHMwiHZddhR/1M5RxW/Y+xXImWpyHnAoMa76IaPyNsl4R
         c2kfyXK9/1EZUpfrMPZqX9TSB8siLGnUoD3ZDahxiYrUdiin+hFM6v1fL4l0RRBsjfrs
         yAwGE3G2cKUjl6fKShQHVVvtskiLADd1wlla7U7kgbkcCuztCTrLXGW4IVVGLWeHB3Ck
         UdPDbgry8KW2khHasryxqWciea7NKfFoMyyJixlCYx1o+K72vvemgQr0YlgDSc6YzfGr
         aZhgOy2FjbpW4gNTPe7Ro1g1jl4IKaWRhGtEpkAp5MKuWMcXVpr9ApVvxcEWAjiolZND
         RWLA==
X-Forwarded-Encrypted: i=1; AKwUvBwWaoi4N5wUuB4sfVnqS+ljimtECZzGmMNTDH6gekghPLyQlniVcHcEVxnCs5uuK6zJIkQ90Ig=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkkiS8RgLTSDIHkfy+XYtAqoEsUHMsYdSVXf8+HMuAov/aw/yl
	ibPu4XfdOpLEf2u+FasWEQ6ZHJpe4QOk+LYH5VwZUr6/MtWLTFXxJtED4dktFq7y4k7qIDiOpnk
	rinX8fNdQ1eKvsHULwQ4LSGsKvJpotqqfsWuQt/OYFc2PpT2BzWJ4woSBWIY=
X-Gm-Gg: AYBFou3e2EnD24zqfY/VVI6sqZrRM224mSwQWlMdgY9TIou2alXS2ZZIw/lbfxfRALs
	3SkeGKSz4kthCT23JVJQCffZw6WiKEUUlR/Uy5vhEdkRW5DcVf11p5Dl8uRIpP8jo9v8ITpidNi
	SYOFs20wNqRMlIAGIYGrzlowTk6lhdPINB4/cwJ+KoH0kyLEeuB/Y2APwJfaN55w2qGXOWnIA+P
	JMGRhXye33aZd9cilgCDfk08Hz7POWUDIJ1eKzPFy9kEtW0qUT5HY7U4JoxuDTGC9DRP2A7LOqu
	RBEE6fiZjcWcMT9hV+ewBkvy/Dp/lsyaVV1ttP3B9bOOuqad96A6RI+Ba0QsXRwtbogZbo9rBiv
	8YG3jbamU0iaTUKVoR9gyDgLjLsA5
X-Received: by 2002:a05:6122:1828:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5e91f46ca9amr6094214e0c.5.1792075604412;
        Thu, 15 Oct 2026 07:46:44 -0700 (PDT)
X-Received: by 2002:a05:6122:1828:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5e91f46ca9amr6094164e0c.5.1792075603775;
        Thu, 15 Oct 2026 07:46:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm86840625e9.10.2026.10.15.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/3] driver core: fix unbalanced reference counting for
 software nodes
Date: Thu, 15 Oct 2026 16:46:21 +0200
Message-Id: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3n0GoC/x3MQQqDMBBG4avIrB0wogF7ldJFNH90QCYlEW0R7
 25w+S3eOykjCTK9qpMSdskStcDUFU2L0xksvpjaprWmMT3nQ6MHe+yscZPw59GtTicwbOhtGAf
 X2YFK/00I8nve78913cqYpxFrAAAA
X-Change-ID: 20261015-swnode-dev-notify-balance-e6f56fb9a469
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Eduardo Ruiz Duarte <toorandom@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NHgIRIYeSxxBM4Z2O/FYMoXHETZQ8rwvjZE3GOfWUQc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0OdGNQea/ZaQSE8NoGK5ssTDV3i6Yf8dWQp6K
 pyopKVXJwiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatDnRgAKCRAFnS7L/zaE
 w6x3D/4uzSSogfkEUqLZ2YYdjMOaAL7tIC5eATXPw7a/Wemsnjuwdv5Su5A9tLJXIKi5WY74Xeg
 95BMcLZR8h0F3aLL31c103khzaSKRvRqUo5EZHjjxVNiOwwu32B0khfs4gnD+ikiV3Tw5m0k2KW
 pzktdOuPz00z8akz6CAhuU5DwkFPIZXFeGEekgGZ2jJaF2oTnTUWQ7kod3JMbDCCsWScirMNWx8
 a9mCXPuZlgqAPvYZxS1rrBPkbjiXW5qbxbwz0k3JfmSIMi9dtunW4Aye5RDFDeXMVOAiCN4BQzT
 ciTcVp8j33yP6bT7XQpNvheuBYSiXtK2TDepKwXktsZxGa5e6rVNUnanFRogVpG1e1p7TqWle3P
 KhA6YfLPiLqRDSBnpAJeMeYMf8QjyBXSpLCawPbyHXBxxKgu55IEy7dlgGLqhtmCrb2DIDH9DhO
 vYyBtg1sHWDFvDxR+5nNYCFf2g3WepcqVybJAyl3mXwBlV3zmIyMjF6yAeYC8Uc0x9yXBK+XbAu
 /qf6NDR40SfsL4mJY51ylo1f7g6s+RHpGHY/CMa9ssAxYFeDKsv4rIZTw72LLXeRsICx/65Durt
 /pX6f/rfQxFr7614teLoIrqaSRA6FcCgjpAP3OAkBgAHsEL2hb+luTtDxCwItitOzMpZeTKC65Y
 zxwsOX1iKlAMNNw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfXyYD7mGhALxlB
 lc6bHq6kWXhgTdR/N6nCcvOCnPGSN94aEIt8gtxVWoQw59FSTUH5qFWV1eFIqvflbCK+TCrV4Hq
 bRtWR4wmWvv1nXYOVBhTjm/U2EnyuQ4=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad0e755 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=kTkK-H-Q3wn9DOHkRvoA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: au5EOh7TISLoswXV3CSPi6uNafl-PMkN
X-Proofpoint-ORIG-GUID: au5EOh7TISLoswXV3CSPi6uNafl-PMkN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX7iFtOjs9HazI
 tUsd3KLcnPpizBxdqvX+QkJshq4bzmfhli+dL5IJ6e/PAJZcEJmqYuVeQYsM1AnnGOEzjVhIn42
 +X7mIk7VolNt1HaoBjdjRQlrV0Oh522YnyqyOEgFnW26pOUsQwTHD84F4qcoGmDO/tgwveXkyf9
 5aUD7aqqASFZCeJNa80JxRI00Wt+4WqxJMKhTCbAphWbnSSfaTUw/xj5sTAPrkKUBSSy4JLUbNT
 2fZ9l0XCdqI5LgdPdIxRoOvJTiggeEFhXClrDVqtFOXwJ/RB/QCJq7j+u+mpTgLC06czm6NsiWL
 BZPuUptrn8qRrXsWKw55H+pXKNnewnNHu5jJMzFI52jJ8LHIteGxa+FA39QdnCRi+ghztnhZSP9
 yWH90Rkr1Y4MqiM5oEgSpR01tVW7JWu5z7E6txYvvz3HEjssbj4RTRnihUGvYhoflv4T/rb1vUW
 AkmwV1kRMCM3Z37w/tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150058

Eduardo reported an issue with reference underflow when setting a
software node with set_secondary_fwnode() and then repeatedly destroying
and re-creating a device. This is caused by the fact that
software_node_notify() takes a reference to the software node which is
unconditionally dropped in software_node_notify_remove(). However the
software node can be assigned after device_add() so the latter should
only do it if it was bumped by the former.

This series proposes a fix in driver core. The first two patches extend
the device flag API with a new accessor and value. The third is the
actual fix in swnode.c and should be backported to stable (along the
first two as dependencies).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (3):
      driver core: provide a test-and-clear device flag accessor
      driver core: provide new device flag - DEV_FLAG_SWNODE_NOTIFIER
      software node: fix unbalanced reference counting

 drivers/base/swnode.c  |  5 ++++-
 include/linux/device.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20261015-swnode-dev-notify-balance-e6f56fb9a469

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

