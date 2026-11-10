Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286602;
	b=M3xtBUaSgV0nu9XNyIlRVQZ/+s8NjM9STzL3vJUKnTSXDfrQ7yTZgteaIZUmG48AzVqV
	 zNbD7uD5gbSsYVoBRGAlIFGPh4AcWH27/bOlC8iMudJKil29knWSO7hSpE8rDl4ZDlNI0
	 gOYnUhv5v9TP1BhDBaoJaOMl4/at9cZFdrAuoHU5NKPvTkyHw34O8ftfUTa4FsspeTY02
	 cVZjl/dN49EhMwJaXiNaTEX5QsFpddt1zOdVuPJ19uyrOG10EofljQ8MJQ/ZtieIn9sU/
	 fy44T4TYI6xKfGTnAJTsA14JHHS0+OrDVAnGxL4n8aCMWw8KVQfS8ZN12YiqLcxcwbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286602;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=P6Y+aoye58GSy/RtUsdIHqeQ6t8AB5Kg2/I8hWyeTr8=;
	b=GWgAICQzXbPJjXXVLJFYTKjfqOfaHdnopMgX709BPEcYXg2UPWbW1/kjK6ghs/i3pfCn
	 jYk08JxaPCYV0S3ZgRG7FCW9YHqpCd5daJI1ryCW7c7QBBbZEmpgdl4rJCwH5FoM6Ts7O
	 RMYhWKhxVhzNDSLluk/NTfQpgxCXOvcR/tCvuvGBfFOxyCLv6sXsCutwaSZgfvKyqHlDE
	 ++ftdmBgvcuXlsKwuvTPT//E4rHYxhDj9eGtwJSXZwo6xruavqiNhM8qNEPCI041TubJi
	 Z7LjldLhNxdmoREzuGW7lsH9c9eCSuWv0AHIhLBLA7p5j1uLd2cV/tAMZhDygTA3ysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0vcv+m5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISJwrhHS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3E60A380E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F3E60A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0vcv+m5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISJwrhHS
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4A5Mr2275468
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P6Y+aoye58GSy/RtUsdIHqeQ6t8AB5Kg2/I8hWyeTr8=; b=P0vcv+m5pfx1xDjE
	lsrCqPqc8XkT51nv4FEt9oVH+azDZLLZ3/BbMVHcBX0OKY3SVjfxsjhpJ59qXvh8
	wsNUXGjfPKDFXdZ3OcWklsV0MTOAmH6eI3PftlQXWTr440oiALhm0zYJPp5qblRe
	eCqZ6+Uw/eYIinx92VieZs229VGubIAZDI/jfLPkWb6ktKlKFEdboLu74AP5p1y9
	uPzmmJ5C89bupaRFmpg03PFttCPzyAZsnX6JAAgZ00PWf9vvoGu3r2xIQrjhuin2
	Jsc35FJwgvTaPJveu+lkRmsLe0+94z2J0MRGD4h3TUQbWz1YtO3Sw4rlhG4WSXjc
	4vvPBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5bh2b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:56:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf6c528aso294221485a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794286600; x=1794891400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6Y+aoye58GSy/RtUsdIHqeQ6t8AB5Kg2/I8hWyeTr8=;
        b=ISJwrhHSg6qCgJqUFmx070K4Ub2O8Uq4pMtKtZFqNthi8sZ8U6o391h0Z1peVoq1/H
         QDZJ9Sp3KHVa9dyMBFPZ9/gUTKjHDPYies8uWXvt4lWtGC+gJ9M3o/d2j6jdtXQhLef9
         wv0xQX+5B/W084XvYwN6V3s2/66GyXi1kAmdgQS6oKkwGYzIsul3zdqUY8he25Zn4Kq1
         q6eeRiWL2KBEUl1lzR/dOrtR88ynAw5LAZQDLQLEknTkk3uBdsiPcAf6OUWeeBR7w150
         cSrkM9mkEOu6oGnQ4iBsIWWA1uPEC/sXbaada177swBAWayjr9rUwy/kMDoHrAHvJXnc
         /hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286600; x=1794891400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6Y+aoye58GSy/RtUsdIHqeQ6t8AB5Kg2/I8hWyeTr8=;
        b=qWic7P3rx9tnUJ79kmEJ2piq23AAO41HbwT5b/ACME6WRyqjoUStKGkpirIKAxCb86
         FpMyRrUJfQXCgmDEEro9wD+v7Y9cbPGYH0d2Dqgmd1QQ4aaBEaxCYzmMlZ5ArH2V7OwU
         bHvfpJlLuyH/5pZSu/ehfcvQwpBi+rdFUdkTsexRWLa2g705APMjHZsspS+AGiW2teOS
         nFH6vAX58X9+E52kzmKTcHWQ7VzgenW2pne6TbleHWhWi8cj19dRIRe2r4aUL7vP72Ly
         rRhPzr+LzXyP9Ps8wAdR8r8d3GbZbWPm3Pf5akcVrmQu6xlDl/leKeWxWrtCSMsEaBJF
         0mCA==
X-Forwarded-Encrypted: i=1; AL+hErFU7j8JwGEI5LiKaNMetsF/n0zdJjDsGbpEY92LCq2zK0w1wSQDW/xAfpQD6Bc0YtO6FvEE5Q0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jqhu1FdAs9oc0ZD6+XBP6tdpWJR4MXesIlEEaU126qJyAqCCb
	9QZN4a1BQxNLm6dMI0NKv8VbSTH+kYpNKBRiiyoMJOBT4QnEF5CoKTP1vxbMsuVO26Odg8xN93g
	xU4PiSgutczm07qpOlciRnrkndlqWTsitmdTp7nW17W2H1GOhp3AZoOU3W1I=
X-Gm-Gg: AYBFou0jqI8oAqsYF+yF3HYcoVZJnyJVpScmbQ6g8iDKhAdVwLQ/qs4dNFyQbsZ45Lx
	KH15KZ1Naen1ZNBD5Rc2X3D7BTaDeA8cDTEs+E4j0jWZwppOXfLNM06UTzOcUbPV5szS1VQIpsI
	3756IJl7IZpEMM0XlAnslWo8KeDbikhNRGtXHGjBIe3V6x2PCK1NR9GCr32TC8dPzCAm3R/4mOq
	u/xalZyrOfA4f05TsNX+A91syF8QRBXI+gqES26d+ovv8CS5IrrOKENyD9G8c5937CMx21DI45r
	v38d8fDHf2JXw+Jmtd5uo8UWxDWbpUsHFJKSrM+EHMXcNg/AlfDgx4ODc9GWbclrMN+wWPpxnDo
	6xwr0RHnFxy+8ARGyq+NafYMrlYcWmmKFmwhzARGFL9TxdApFJX8ibZIwzkUvoITQjcd5SwF/Rm
	+OVpHf8DvpIb+Mj53YAezoH5Ipr71xe8EaDc96
X-Received: by 2002:a05:620a:4048:b0:944:12d5:fd45 with SMTP id af79cd13be357-9479f40d32fmr264143685a.70.1794286600249;
        Mon, 09 Nov 2026 20:56:40 -0800 (PST)
X-Received: by 2002:a05:620a:4048:b0:944:12d5:fd45 with SMTP id af79cd13be357-9479f40d32fmr264140685a.70.1794286599709;
        Mon, 09 Nov 2026 20:56:39 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:56:39 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:47 +0800
Subject: [PATCH v8 26/29] drm/msm/dp: wake threaded handler for HPD IRQs
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
Message-Id: <20261110-msm-dp-mst-v8-26-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=3017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=efENb0T/HAWReiK8VywYdb+gt3ssVoPh2n6XPte/XmY=;
 b=Ur5Nhx/DGjPp3ZgGzpb0eWbz69nrQ2sT4U9Zg/FswAAARtvvYYWk6sG/feiHhEo9PX/70XEGp
 9fZ6g1ik4zuByLl58BUOuR8idqjAgNovSbHxGaaR/geKf4D7D4ZQTdk
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: auSPKfXogIy_oaDlAbI5GqNu3AhSDXqi
X-Proofpoint-GUID: auSPKfXogIy_oaDlAbI5GqNu3AhSDXqi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXxuLBuB4osLJ0
 aA8kWlLsgGVgSp+Bjm/I2lr1iDIzU/TA36MQrc0pAKn4kEYvAxHhskLYa20eO2is+a58USuUC6A
 N/gDUgkNdc240qHHUtAN0io0X7QBVn0=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af2a408 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rr3H4PImTD0NAioKu5AA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX1nEuYIWU0BTF
 R8BQfdMNfyqGwNNoWQLBe9A6W2Yd77pEDnWrdS4ao59+h6DbZm3lEpzKxmSxsHPWE3dGjnvzyJe
 tw5Zp1kptr2pC+NyGOd6yRjg8/T2zUPq8mCQwK2lfMcEz8UdcrxUvMD6eUnPEI7bi7OwvkA/GKA
 LORUl3zPpvGvprJjM5aOpSTtxGHrcsOK22vFNLH0uLp0TQdpVh04Q4y+HbFFLu13ETg3xKpFQky
 acrKbqb8b4kydndkqZGHeS8/sEWr8Y7l7SmOvF6HXuulNe0iTks7Im01Ms5/b6rArsRUNo1KM6n
 IEV1+yAHOgCdUinrjiO2BX8XzsPXQvEX0aWfjzF4sDcZUZ38ABKUMw7wDjfntITvbPAXt4WKdCB
 CVMf2qCGmyJ07NzMiWFe1qznUquUQt2gCA5O7vbVfCNLsP48jbkCseAjAtJsD1Zwb9EpHJNvumn
 f3Qn8twDHDEtTU+GdcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019

The primary IRQ handler latches HPD status for the threaded handler
before servicing DP controller interrupts.

When an HPD interrupt was pending, the handler set its return value to
IRQ_WAKE_THREAD and then ORed it with msm_dp_ctrl_isr()'s return value.
If the controller ISR returned IRQ_HANDLED, the primary handler returned
IRQ_HANDLED | IRQ_WAKE_THREAD instead.

The IRQ core wakes an action's thread only when its primary handler
returns IRQ_WAKE_THREAD exactly. In that case, the HPD status was latched
for the threaded handler, but the handler itself was not woken.

Return IRQ_WAKE_THREAD directly whenever an unmasked HPD interrupt is
pending, after servicing controller interrupts in hardirq context, while
retaining the existing IRQ_HANDLED fallback for non-HPD interrupts.

Also report STATUS2 interrupts as handled. msm_dp_ctrl_get_interrupt()
acknowledges every pending STATUS2 source, including sources that need no
additional action, so they must not be reported as IRQ_NONE.

Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 3 +++
 drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 82fb3ae750f4..5623693d9242 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3018,6 +3018,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	isr = msm_dp_ctrl_get_interrupt(ctrl);
+	/* All status2 sources are ACKed by msm_dp_ctrl_get_interrupt(). */
+	if (isr & DP_INTERRUPT_STATUS2)
+		ret = IRQ_HANDLED;
 
 	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
 		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8ea3d258a98f..40b2f6e120cf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1091,23 +1091,24 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 	u32 hpd_isr_status;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_HANDLED;
+	bool hpd_irq_pending;
 
 	hpd_isr_status = msm_dp_aux_get_hpd_intr_status(dp->aux);
+	hpd_irq_pending = hpd_isr_status & DP_DP_HPD_INT_MASK;
 
-	if (hpd_isr_status & 0x0F) {
+	if (hpd_irq_pending) {
 		drm_dbg_dp(dp->drm_dev, "type=%d isr=0x%x\n",
 			dp->msm_dp_display.connector_type, hpd_isr_status);
 
 		spin_lock_irqsave(&dp->irq_thread_lock, flags);
 		dp->hpd_isr_status |= hpd_isr_status;
-		ret = IRQ_WAKE_THREAD;
 		spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
 	}
 
 	/* DP controller isr */
 	ret |= msm_dp_ctrl_isr(dp->ctrl, dp->panel);
 
-	return ret;
+	return hpd_irq_pending ? IRQ_WAKE_THREAD : ret;
 }
 
 static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)

-- 
2.43.0

