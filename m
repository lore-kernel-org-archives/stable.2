Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076677;
	b=OGjvPdtjViao4cLqzJUwqE1SOz54ffc3COGAAh66WrNBnMLQGy9Cybw70+kJy2FYZDgH
	 lie3MPCxwjSCWXW0qd7Ywvb3G7oAexZFjoEMHURyGaHgt5KjRM50CUlt5mKb/y5D8Dr1w
	 n8tgt2oKXCk3ZVpfq98inM8QW6JZ52a+n7pyWlYpwfyWMt8D77rrXftDXN8gnnkabi9kt
	 i3RtPigfPOcn3zPrygTMPvBwqi5N/MFeo+2uC35VWtwtEmfBZM3K2ruONs4aMFYICxDWy
	 vd62kYzf1Q5aQsZQtYqv6PVcx8FWLFipF2hq1Aq3HX6+1YY84GUJ6+qrVXIcPavn5UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZizpUZVQzhsb5CtBv/UTg8HHKNryTN52kcnOFyzHuG0=;
	b=AgWi8MY7aCfMfHzfItfsqALLnb6WX/QGwe9/9TJIEt8Sry7iRT/GVHDxrBCOP7YCXhaP
	 GYGkftj1zz1Bj71Hs2ucWmv0HY1hy/uMyZV9UushQ4XI0p5RGxwcNJ9yZCEzTgMJwYHBu
	 A6+cVKi7Xo+2gsZuJ4ceqFo0eiCzOtDF8FyZJl49wZgYdcqm+IEnL9F1rGRGqfAwb7IVQ
	 64nuTKLAHDM/KYoaY/DENgNM1NiR/VBgBgJsUK2WblwbKQeOJfdtc6fGq/QFpCf9qCnC5
	 ugoHoKzz1kbNr/TgUf+jDxHgBz80mG8kPG3pgpcPefBgZGMwqjykHX3vgyM40Kw518A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="OC4v/Hmy";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FwwKZE9d;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4829606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4829606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OC4v/Hmy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FwwKZE9d
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6v4Su1962345
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZizpUZVQzhsb5CtBv/UTg8HHKNryTN52kcnOFyzHuG0=; b=OC4v/HmyKSQUQQop
	ubk/w8BDd6LIRUUUnHE3bxpBs/2jebgXtWe4qV+5KyTJ7+ERMzfkYrQ2Lxnq3EVg
	GjqSZW7SR7fKtp2VPaRlJOAg8kB57EVQ2mcLe+fPgRWddI3S9CQUtW1++kkDYloi
	U96lR/TyNNHhpZOb2ROqxfLQpbXk3ErAkYBGzh7TN5YDSMA2vkDlfnMQAidHCENq
	4xLXX+k0fsRe6EXbW38xEJ0L7rNEpa1SYVCUN8GM3B1XlFjxkA7Y9kCY0weN+aYV
	ByjEB0kZfhK/Iw4WorxXXjSR0p844vwcGotufZet5v6jWBkliM6Sh3IP2I2lmg4j
	tuCZIQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1gxcu8k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:24:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f32050e72so519629785a.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795076675; x=1795681475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZizpUZVQzhsb5CtBv/UTg8HHKNryTN52kcnOFyzHuG0=;
        b=FwwKZE9djN87gPmh2lCGysSsnzr4r+qU02qVsA9IM69qYy9FcZREe/HIjrnF3MfhtP
         9CePpij6LzFCchp0CaL3iigw9vjdJ3ch5IgZXzMJ8NPWUYX76uQI+h8QfB2Mf1zy0DGn
         24v/4e3r0xfroQiDMg4OjT+vMs2qbNtjwlvU2KE8AmiXII4LYUy/9TN2n2LD4omKhUpV
         1dKzfUtVxCPh614qIQbpFy2uio0XVx3zdtVaH1GC1NmEqaPxocNN0uXf/JjSe27d3Hw2
         fbRev0i379abO+1H9+Q8jp1zhgHsNbql5JN8E5QBbFpvmp9RndUIcPjnER60tIUIBsgc
         xXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076675; x=1795681475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZizpUZVQzhsb5CtBv/UTg8HHKNryTN52kcnOFyzHuG0=;
        b=TqAoduo1pqfTYvGl5ZGX4yJeDX0MfOnevebKR1ojrB3ppSWBM45tFMfrHLyKmtUIGY
         1GDFyt/SxwMez8JjFI8zizcmsXLqUwkNY/CFgG+G4vyb9T+O71YoSFo0BLJHFGfevoWP
         qn8EhO7pPM26BXOMJfrQ57IlqxBaDywqs1jmbiDR0BQB760cz+n+YUDrR4WxXMUJ2Eaa
         Aa+9sPYL8frNS9NxrjHM8IJ+QOzJsinPD1TrLnbyQ+AJ9cjt8g5Xc75txse8T+I0saUp
         ehlGLlMZ/oHNPVIxVJuddcxoUZQ3qMfKH27zksddJf8M2mhFuv2cKPR7ASs1Bx1VUUXh
         SbdA==
X-Forwarded-Encrypted: i=1; AL+hErE9H8vPgwmjGRinr2hY6ywdOuGo/wsZRLV/5UCOflQq6I6doWzj/uA7TPSda4DQMkyFnE2apIQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+smECshYQiZsay/hChe+ym8VMxgRI1kO+KRak5ce6iXJFs69OR
	CPKY5v7YPoklNUa7tdx1rYo+RBmy0IyWnhk5HKgK7GpzMLPXeD5wD3URm+rIPu4LGu4y8bbAnsI
	LF3n/JsUrnhQEKtIt+T+hF/11V2L05sWGxRVL+ub4LKOtN1RYSbIBLUWxz26fWXverEINPg==
X-Gm-Gg: AYBFou0QDfxBNfyn3EWqkupV/lSO392AVH3QS5xpJMXrDXy2xHRyImU/gnHbTChM9F1
	WvtWO0KZqOMZNdwe3ajGmzkjZs4NWGhv2jy00fpwGLN1yMYyBVySAxWYzFk7HzGViK4q479DsTP
	oGO7DQUfmmD1vVXu3OtNMe8citLCeoP15gDjLFevfu+zqlzLwf+yVzjUEcpRrUuxRB2SOFQXnm6
	JsB/LSlbx4VNx7pWPt3iEEPLTi+C4Ik2XUlzfVbuqGTnZPJXQJwt1BQ3cJUlG7Umg3HJHLXUZHx
	Q1XQxxq7IeIoC+mcMlU+Ka1Q+0c7uXV09XKgAnmSS/J+dHJOYIwnzn43tOvOPuDP4x86nFIpu63
	zYe9dlWLFRSCoOuWorDrJF0m2YNY2OhQZ4hhAftUNMRe7mJFSH2euwaaw7rHfm1oVQy16HGmUa9
	XtaIC18p8mQ85WwmUJ77bUZ+kn4paRb4vR+svb
X-Received: by 2002:a05:620a:838a:b0:93f:571b:c72c with SMTP id af79cd13be357-949995d3f1cmr927290085a.46.1795076674699;
        Thu, 19 Nov 2026 00:24:34 -0800 (PST)
X-Received: by 2002:a05:620a:838a:b0:93f:571b:c72c with SMTP id af79cd13be357-949995d3f1cmr927287685a.46.1795076674249;
        Thu, 19 Nov 2026 00:24:34 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:24:33 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:03 +0800
Subject: [PATCH v9 01/29] drm/msm/dp: skip sink requests while the mainlink
 clocks are off
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
Message-Id: <20261119-msm-dp-mst-v9-1-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=3144;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=2XTNsl8lmVUl+PZmxcq8gZzokrje4+P8fvNMDoxxIAo=;
 b=m8DovmvBxfsp/x5F3vUoLSaBfCNBQ8QCKr+XM1XWqDYYy90o70kCJXWDe25/sicszbL8FwV+2
 Sdmb5IADIXiDnQsUO1dY5FzR0ouQrzO71s02lyoHaIb6R55HbfatwEd
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=LZapeTfi c=1 sm=1 tr=0 ts=6afeb243 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gFHGZmHKE-3D3zYqEJ4A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: pgpZJ43estMtxWhOtqZ1gC37Il7x_VQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXxYJ2AganQDMl
 7c1SYAFwLFOE4SFnSnx05EQfteHy5mZ2G8PQZzWvXCRyIDU1KONT1umN4tcYl7BiU9qcAnWPBST
 AFs8WyI1eAxpoU8zcCw09DL6YOs0kOQuABo1Pyxi34GrOWN3r4n2vW8R9i6Dajirp1CiCLWp2K2
 Fz2nG+5QNNITWMuAKy478bdIXIWHIBhIVRKbSNUXKq6/mzUNhY7Bw9VRFXI9JOXtb9+qYxVGJDG
 jssnV3i8aqAgGHoSS6MYQQonwmic55ZBbDpSZCPQX1mYYOJsB1RDHr/6+cvhu5QlB5W6G7czZKx
 XyWechbbmQsVAENBvTigThpmKtKbfqCmcgu87QrbIQbg87GM9Wss+oWCs3CV7YPZOYTi0yixkx7
 YIwrcrZhKKEmj1E+zvfbzBq4wEl6Wg8QdA5iFZaZxZZrZhu81zVfTNnhmpeyEQGeJPB8+ts0az7
 nMvaYKyYTMBm7YhP6xA==
X-Proofpoint-GUID: pgpZJ43estMtxWhOtqZ1gC37Il7x_VQC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5Jb7ffqfCBye
 8Fx4N7axAukthU4xsfxaPpC3jtknE17gehio0trnYZrvkLgH9FDlnluN5f2DtQ4QfT+q6zOUdHE
 tmIP3Y/jYPmmR40VFBkgxGVCfhs/m/A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033

msm_dp_ctrl_handle_sink_request() programs REG_DP_STATE_CTRL from all
three of its branches:

  DP_TEST_LINK_PHY_TEST_PATTERN -> msm_dp_ctrl_process_phy_test_request()
                                   -> msm_dp_ctrl_off_link()
  DP_LINK_STATUS_UPDATED        -> msm_dp_ctrl_link_maintenance()
                                   -> msm_dp_ctrl_push_idle()
  DP_TEST_LINK_TRAINING         -> msm_dp_ctrl_link_maintenance()
                                   -> msm_dp_ctrl_push_idle()

That register lives in the mainlink clock domain, and nothing on the
IRQ_HPD path guarantees those clocks are running. Disabling the
boot-time mode for the first modeset from userspace turns the link
clocks off. The sink answers the link going down with an IRQ_HPD
carrying DP_LINK_STATUS_UPDATED (DPCD 0x204 = 0x80), and handling it
walks straight into a write to an unclocked register block:

  [    4.572532] [drm:msm_dp_ctrl_off_link] disable
  [    4.573756] [drm:msm_dp_ctrl_link_clk_disable] disabled link clocks
  [    4.823194] [drm:msm_dp_link_process_request] sink request=0x80
  [    4.823199] [drm:msm_dp_bridge_hpd_notify] 128

The board hung on 3 of 3 boots with a 5120x2160 SST sink attached over
USB-C. On the hung boot captured with drm.debug=0x100 the printk ring
ends at that last line, the drm_dbg_dp() immediately before
msm_dp_ctrl_handle_sink_request(). In the RAM dumps CPU0 is still
running pmic_glink_altmode_worker, holding the bridge chain mutex taken
by drm_bridge_connector_hpd_notify(), and ctrl->link_clks_on is false.

Bail out when the mainlink clocks are off. All three branches need them
running to do anything useful, so gating the function entry costs
nothing: the first one resets the controller, which its own comment
notes "will need DP link related clocks to be running", and the other
two retrain the link.

Everything else reachable from the IRQ_HPD path - the MST ESI handling,
msm_dp_display_process_hpd_high() and the video pattern test response -
only talks to the sink over AUX and keeps working as before.

Reported-by: Joonhoe Kim <26rote@gmail.com>
Closes: https://lore.kernel.org/all/20261108011501.4466-1-26rote@gmail.com/
Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index abd3dcdad03c..32d4d5743eb3 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2321,6 +2321,12 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (!ctrl->link_clks_on) {
+		drm_dbg_dp(ctrl->drm_dev, "link clocks off, skipping sink request\n");
+		return;
+	}
+
 	sink_request = ctrl->link->sink_request;
 
 	if (sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {

-- 
2.43.0

