Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835667;
	b=xzlyx3d/oeL8UhuyFGjOhd/8px/T5DT2qtD6oo76/6sdLc7S8ID2JY3XpM8wKbonP7de
	 HYzCeCMYuhlWKY8AGTYpDDbq7rnSkiAR67vjlyYUiR4N+DSn5bX4w6kSP/T7DjQa2XWI3
	 vlNhoahkuoepsDb2u4xSL6IVi7kNApWbSHvPwtMHxIk4wpATuyz99BdOeR36e/vfy9FT5
	 V8qV0d5Ue/u8GWhT4Exw0Ars3GIVXg9reSDdEQjNUBdlYjCubadqUiU+8lvvpNnobpUT7
	 YJL2dCfpVjnO28Roq6qLwfY02pcnlE7/RJOxMyhJFKpMihuLRowdbGxS2ieFOcBfOBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835667;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GP+lNZ04x6U/6g+BRd/Rsoxc8+T29rvyx0Ll9LTUk3U=;
	b=DeWiuBoWvsJNS0XiUShoe49UqbrGCEWV4Ao/X+kP01m+O/XaLkhRo/mgK9aAp+c+o6EL
	 iqr16wPur5KrLx9Lh1BDUuC9XGYY1ZSZazr/m3eOhjPNYHTfqJFwtCKp49jpcy7U2+167
	 gUK4R80UmKTlhFXgurGlIaDkRoxgWDQmzgM3cpS7zFcFNLgSbde28pxFwM05iq4YIaWty
	 LjwAxyR1T1WoSH2yKepEjskjZ8KofkCljI6gHW4j6MFB0QqPzXyFVVfyRze+YpOCyx83n
	 opGRWWR5bGqiKgEqy3AANu6aq7IMuQJgmXnz1b80iBgmjSUcBxJzN5beGDzTXi6a8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="krIi/Ql8";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OyUQUD4W;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17526606A32F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17526606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=krIi/Ql8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OyUQUD4W
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC0wgk1688288
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GP+lNZ04x6U/6g+BRd/Rsoxc8+T29rvyx0Ll9LTUk3U=; b=krIi/Ql8sMszVbX7
	fCG6Fpa+7p+PDJ9pS6lR2Q1ua+4J70nniWw/DgYTyblXIMJfMqUfnLfT/O3Gofcf
	bXveXpfIA9BVwWz33uS+McfT77rYFGDNu8p8wwHBBPlQr5r5DAZ+CGnk/btSbqba
	uGEGmXa3fTo/E+5c8U6Nyz+l53jFVLFLoyoeQJNjkAkSMql+0cPhAjwfgcfB+ttT
	K2xNk9M4HnoZpibl37iKrPt1De1dLOreEiCDBLcwE8IxCg4L5qZ6A6xFzJbcvzgc
	h6We6rBKqoJYW0g0xZAXx1v3l0tW7cPtFM4H8ZcDkV3uENiyoZaHBZGnkOhMKpt5
	BEaOKg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc2b39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:46 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-85f37d25fa3so4064208a34.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794835665; x=1795440465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GP+lNZ04x6U/6g+BRd/Rsoxc8+T29rvyx0Ll9LTUk3U=;
        b=OyUQUD4WZ3ZBXQwYHepFAprV29OSUOoZWsA/ZgQz5U+WF5mxiUIeFA8MqbDPY7W+54
         C/5hlAnz7EWooeNIqyZ1YKAgjGURCbGl3BdApBIibj+lD3V9l5VvlXDrkU0tLHA9Ue/G
         FxTRShLlD8BBkETca/B7rR8WGG4ePtW87RR0F45LxmcoVI/Xzp3HCpsPC4733TStqBm2
         b3nXVPKFrgaH8SAG2JFpOXUHxur2kHvH2dm5iP71Z0NyUG1Sz12/xefYKLq01FeA79ep
         jOH/UYZhcNnmmy2WlepE/lNwpv0H+7Gq7Zk8A22o3Lvdm4LCy6geu6MeNAFlFZh5timk
         x0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835665; x=1795440465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GP+lNZ04x6U/6g+BRd/Rsoxc8+T29rvyx0Ll9LTUk3U=;
        b=CfMsPvLzOSaN4auJI/NxfrgAjI3ZsHt6FN47bl9OKl09sifpymnmnlGTO8NlLq/dpU
         UO8TBwiTJe1wW9mKUnUpLhB4CYTz7I3Z5rzMNuVHD1/35rba3/ifb2jyO2/YFw+QA7vW
         MIfx3Fk2dyIuWETAC9vckpklj2ZG77ivhcRYHIo1IX6CxH5FJxdhvlhC0dAm1zs3OosI
         NoPynZ4xzuowoYQ0RPJycQUcQRm82qdkAyBeF4lhnQVrK+x/E1bpGWz1O+ALeLHhIIaB
         iz+mmPitUB3ItIj3duPOYfg3/hHhdQCsEcwodIUjEqeIz92m+N9cXm4uNoREIZaJ0N5V
         ECkA==
X-Forwarded-Encrypted: i=1; AL+hErHmN18dvaIZZFONNKd+esedW95qASkV601pIemo2uUFpb+SdFZcfZ4fDXFrw7k5qYuUSeC4jdc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CSW/qYye81NGwyE54qtb0JagfIcJJHu2SY1BvUDQ9ms8uxqv9
	m+dJmnAhPn5WKRPLXjb7KBjQrTDTV31yhyFxgjYcd9dH2Bdlx8IV/xx8WWKl05Jh7f/AHnl9S5o
	1bV3T0D12EQHCauefCOAFrNYxhwOvrQrzWsGqPsQmjKJLERt5xlq0tEa3KwAJ7O4eGFU=
X-Gm-Gg: AYBFou1qKDIeHgnkv2JSgVwMFBhhhzdaH/2bkiHZRCKAxxuPh5+FXFK18M13g9wTjgI
	1g7K7ukuX6XVV0mV7u4DknmnP29ILZKZo+I7oagkoXj3oFCDxkLS9i0+W/6H4AkRinmydvLlAlM
	wte7yaSbyZ0fscDmWurf0hOYYg2IZQcSoJnUODI2HK4geQKllF+uUfA0PxEmIojD8CYwvDd98gN
	T9O0AoH8cvpVtdx5Equ3YhO/kxS8hHaXIzIwFJ/SwS0riBysPZDpGi7udCfoZLUHbIEx98VlXBY
	vYdKwpSGQIAQsJc2rk4l2PpQs4BmukTdqcDmK2qlVLkMZrWkg1GGzKVEoBzOXXc3dWOrtpGPwsU
	aFy5gmUIfBvP2Zg06EezpxtnhPlyOPNd/lUV85QhIjlFl5WuIqi2FbPTxWepsOBlAfy3RPMoreQ
	OrJI26BVk=
X-Received: by 2002:a05:6830:4122:b0:862:ca2e:918a with SMTP id 46e09a7af769-862ca2e9f54mr2358104a34.19.1794835665549;
        Mon, 16 Nov 2026 05:27:45 -0800 (PST)
X-Received: by 2002:a05:6830:4122:b0:862:ca2e:918a with SMTP id 46e09a7af769-862ca2e9f54mr2358089a34.19.1794835665172;
        Mon, 16 Nov 2026 05:27:45 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628813346esm10012527a34.17.2026.11.16.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:27:44 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:57:30 +0530
Subject: [PATCH v3 1/2] misc: fastrpc: fix NULL rpdev dereference when
 session alloc fails
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
Message-Id: <20261116-fastrpc-probe-fixes-v3-1-3cd56d9d9a93@oss.qualcomm.com>
References: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
In-Reply-To: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
        stable@vger.kernel.org, Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835655; l=2528;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=qyOzQilXYkBjF32YjLtPldFWtQAux35R3zlEUXH0auc=;
 b=7J0qerE1hXz8b3V5kFX1tH1Jt/6ibT2/D4UYtCOjUErGCE32WTbul+JYEwMX0JUyV4JyKlOFX
 M2h3cgjAW8lAm3VZGgRjSu8RhE7pj15Nn06HKnmejmpcV40KriI56Fr
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX5GIGLUtW7AQx
 vvUtPF+kT2eOVTz+cl8adyyz1jDaRrCjW6LYQPMW8FDj2V3o9xHdBzvdqL/+FQn9OVa2xpETzjW
 +ksoyQApyTRq/gRZmXd2g0NJFPUq6IM=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afb04d2 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HPkHAgnwbDoOiCnvmVMA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: dyUwODU1iZSACd_rx69Y4NdW-Dp62MNY
X-Proofpoint-GUID: dyUwODU1iZSACd_rx69Y4NdW-Dp62MNY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX99Omdbuj1oxQ
 zPVA7tc3dozdcV1wHbSJGGrVTUJTs/jrtjArhICM6VQD0JpL4gdC3jefQUIBEKHh/GLuvccvWSZ
 717z+LTRlCxivpXewZDKkewIKNZ5cbzlFs4lkRBI+ntSSB4na9YWAfvV4yyw1nqpyq6CSiHfo56
 8FQLrdLy8+Utg/7bUZaSAYahXS7157t7EJ8TT6wpLiXhwCnUByWR1D/mVvtLE+isTWf8I+23EME
 6VGDYnT7PX8JnVVHslVFPmQUgxOAk9tDKsP2wxkO354V779nDgd3Pl/RAfxX8+WIqQKhKo1aJC2
 KvbkHX0Ts5J717eaqWXkKwKRDE5wbOCxhFkGUkl7be/x56CO5S2FNE5Plu4pwZhdaXaaTC+8GHR
 qt168rkZF8s8SfN48DeocMajyzpggrf3lTCDeeFjhppX+C4lc6awwjOhGpsnk6YeSjFEalltfeT
 JtGJKMPIN8xymURtM4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160053

When a fastrpc client process dies abnormally without closing its file
descriptor, fastrpc_device_release() is never called and the compute-cb
session slot is never freed. The abnormal client death on the DSP side
triggers a glink channel teardown which propagates up through the rpmsg
bus and calls fastrpc_rpmsg_remove().

fastrpc_rpmsg_remove() nulls cctx->rpdev before calling
misc_deregister(). If a concurrent open() enters fastrpc_device_open()
in this window and fastrpc_session_alloc() returns NULL (sessions
exhausted by the leaked slot), the error path dereferences
cctx->rpdev->dev causing a NULL pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : fastrpc_device_open+0x1b8/0x258 [fastrpc]
  Call trace:
   fastrpc_device_open+0x1b8/0x258 [fastrpc] (P)
   misc_open+0xd8/0x1a0

Fix by moving misc_deregister() before rpdev = NULL. misc_open() and
misc_deregister() both take misc_mtx, so misc_deregister() will either
block until fastrpc_device_open() completes or prevent new opens from
entering it entirely.

Fixes: 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is available")
Cc: stable@vger.kernel.org
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cdc2627bdaf2..da0b2333a3ca 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2675,6 +2675,12 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
@@ -2682,12 +2688,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (cctx->fdevice)
-		misc_deregister(&cctx->fdevice->miscdev);
-
-	if (cctx->secure_fdevice)
-		misc_deregister(&cctx->secure_fdevice->miscdev);
-
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 

-- 
2.34.1

