Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827A4BCAD6
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786064; cv=none; b=dzvFA1dwx3kJf3CxRxiTciQWfZXxwGEe7+k+3ih6/zWKtAfogxd6TzgZuHhEdZ2u2x3luhjJMWa9PTEb9MGEXuNhnE5nCTeb9qPhWTq8ACX/CiC1hrfUWMclGfW54thhnE0jzh3BdIT6c2chAUQ4QnO7rzQBZ55KzqXg6ez/+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786064; c=relaxed/simple;
	bh=yhhU2Xo1HHomz5Uesadm2LHNkZ1Ed1iZL1EHcx6SGho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/qgjXgwZoEmkOvm1fysF08+9QsVJ4CNnxE9ODOAnnSawgGiqnyI+t+cndncsjqX9leatNlBAl0LDHkRxYd5DT+RbzAocnl+4nifZBJn0q1WIRI4D46H4SGWsNmhok3dc1IJwaj44WD18B892w7Jvt+C687oXOPlpQP2AxlNKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UB+lkARR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aVzVl9MV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UB+lkARR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aVzVl9MV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AmmjV2651969
	for <stable@vger.kernel.org>; Mon, 7 Sep 2026 13:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ywUruZg+R8a1lUYV8BGnIItve+PwkWpsyPFMDteRsLk=; b=UB+lkARREkDBMKC0
	NviQrMGhrf6qxwQ0kJkpeGOK0gyFBtu5bEZB80GNB99VMGPpr0d/zCRJ6gVPycD6
	dd2zUFwXYd+FgzEcd5zQ3KfOPc0uAMl+kdZ3BF3aMaJK9pbcnKIiUCxnDhvWKQ2c
	FsNO3y0stzSUe30zxk/z0JyG1j8N+Jefe31DeqHKJZZtF+zMcGCzkJIlbSrNLx4h
	dVklD1Yh19CImWCqB6MQiggJKerJIDwD+fB7kV/JfE7J93Btyr+PEoJFhiDL7aN3
	CNGvDBtCN7HCwCfouC+H3PQ1OKQtigVcymAzY6VeVZw+CuGmOo2G9m8pdYgkNJ9g
	Gt3cRw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty0qfr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 07 Sep 2026 13:00:39 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78bb7517525so199769137.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788786039; x=1789390839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ywUruZg+R8a1lUYV8BGnIItve+PwkWpsyPFMDteRsLk=;
        b=aVzVl9MVi/t+sctYuortDMNOGtCk+pfdHRPHMLjk1Z2vVsRTobQEjAclf5w0QGKUUN
         UKnCbP3xVU7skKrPvAwb3CWmbvMO0YrrA2RDUo4z8M0YoIBiTPkn/Uj07ega6IZvhtdS
         BJ1V9GjRq+JScRBU7WXiHzfUCEvHCAOWrFNxlJd8dKg99c3qACxh8JUHCMa4smUTnGcT
         C3uLfGla3YKQkWiu9+vLkaFh4uOiPJ0g+fAH0+0iWqjIqrzzUmEFjzuKXeTWlx/H0VN0
         WOm1x/zcIHaDzqyPW9KiE6omPLyL6Lugzm3zu4SpKUW6VcNwk2uzPcUQ7Rm06SZgomkH
         5w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786039; x=1789390839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywUruZg+R8a1lUYV8BGnIItve+PwkWpsyPFMDteRsLk=;
        b=C5MRJCSsckJIjE1lp7hN2AovMjsES+/pWrTSfDW83uvOximTkS0iDfP9N0UCQMMxvT
         psZcgl1bS/bmkxYlM/KdONND/dyNpi8zcP//QBeG4wj+AMQUZb5+x6BiJK3ZGtenBgoM
         f1ngH+d12tsXVUnY/P5epV/keC1RGLhP1uIT13C9oLp4vuPD321rr2m4Bv/vvDE0sAf4
         A8R3SuYu2OG/VPKA0dYaZHsYHyzMN95kDmJQ0KHQMOC/GvaxtikPrLpJEnTZO3kwFTM1
         UCtPoTTMHz08vf2kPOjXnW9VtKRcS6wGL6CiMyDOLq2UVQVQSDM+MYIXlC0GopfhayZ7
         v3LA==
X-Forwarded-Encrypted: i=1; AKwUvByKY8cyD4wjWCuAipkjUeUo6nNurT2Wd+Npd06GCPRyIRS8PIuHdiqTDGqpVD1yyD/pZ1JPO9g=@vger.kernel.org
X-Gm-Message-State: AFuF++l+RNu9pW5RgXL4PUD+JqDO4EYypS+YyLdLKO2f3yt+xKBjPBW6
	qd00wSNmuECcZ1uQwoGqX8rR/lX1vZTONEGjen0x7LpFsBdulvf9Hve4Z9zz/JgmpsraYauV3HG
	OZIaZCUdZ/7nS9p3PU2UCp7E+5hTiJ+lzhlc+64/Vv8D9vueaYzNhvFCzFfY=
X-Gm-Gg: AYBFou36I7nc1d6YvKhcv7rblBsLyLh6o9S6Y/M1TJPiFwRRViz5ijA/Vo/NX5l3m7e
	/95V8kVYoubcgXcSXY4PoeUDtsAn0BN11Ejv3oVlAbK/gazr1xXaCJqnHOc49WFgyUbj/+LxV4D
	G4/jC8WEeF4LXgKLWqi0gzS7OpC5yx/3Jc+XjmRkrd6wdKH4+eZemewTIOZsg3rwtEtC8W2kUdJ
	tGK/Q8ssSy0Hvc+12MsOUHEITgMWvzdejahhnbPkd1QqDo6lXTCJ+euonxTD3TJfYsHQB5yXPnm
	Y44+rdPK9hE+9O9IE2FNh9+1Ya0ZJqc7ZJQ/sD9/21fQYwrkyJVOEHmUOtLKPtrM5g9d5jcZ0e2
	ySCin7u0hCTFVQYWoTxzX1n0=
X-Received: by 2002:a05:6102:8093:b0:779:5049:87b2 with SMTP id ada2fe7eead31-78a4a42c1a5mr7069233137.0.1788786038987;
        Mon, 07 Sep 2026 06:00:38 -0700 (PDT)
X-Received: by 2002:a05:6102:8093:b0:779:5049:87b2 with SMTP id ada2fe7eead31-78a4a42c1a5mr7069209137.0.1788786038488;
        Mon, 07 Sep 2026 06:00:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:00:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:17 +0200
Subject: [PATCH v2 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup
 order in post_disable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-3-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yhhU2Xo1HHomz5Uesadm2LHNkZ1Ed1iZL1EHcx6SGho=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVm9n6dtVYfAPmpBWbc0P+7KtDPbjgKRiO2g
 f4xFQpu2UKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZgAKCRDBN2bmhouD
 1765D/9gKq/3TyVo1ZvMaJQhsBKEKzFGivfDq9Tvk5dBvKhTnupclkca5zjjzVs2+6xsrH+ebOc
 UaKECIR8jCV8y4oLCYPrBb04t5QEuywEKLav4f8RuzYc1psWyNlISEKFLf1MQI5tlLStM11UTvV
 gUhfCfCC5R2osFIct+5xQeJswYXOYOXXxkjr0A+elhiW3yNyM0e/GeYg93Y0if1K7bU0TQvnteU
 WZS1hR2UuDsqqmYrzkxAM9S1G+slI29BNbjIpaQ944nEaatkS3O+V9yAeihjw8o4HUMDbd8q1ri
 eCqRs4RZrMxC4Og5PzhjG68Jo00Ank1cvyfhYOVKaXZB2tHg+iOg7plTlh4c7t/0SGLR5EJy1aA
 xrlWghOna8gaVdvphL6SoXVWxSNQcUpckkoTFssePYtiysub7yo5T6YNT5vPEuOyhFQRyP/owuy
 15FdgKApFnqNg/Fi/YUvl/NJHJ9nqWBPo6J7crUTH3KBnttP7QBEl+HdGWz9pTGhLGzbMEi5hzY
 z81bTiM0Zc9WhxB5ylU9jEZ09iFlJDJ2a6e+dgCwNiHP+IWwgG8gsaY/7Y0IwxgRb97N+TYwRvN
 HTYZ/lwQelPeuZoRkg6X+iskdnFRfUe3EQZMImT87AuS+6G47b17BXHjnOR036Xj5Z9EPvxMrw2
 zBfJY2CFdIPJWUw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9eb577 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ksbDLleXNvo7xJVorFEA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: k_ACNWdM4as19vhhkXgPWWWbHocPFVsO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX3wQz80NOHf+o
 /MPpxPyMw6ZoCT8HHi5cuGS+vc2OP8ohCVdi8D7vznczvra7IS54YBxJr0/+07TFnuIBUTIE0Ow
 MQNvzsXVE26CQ+lTSi5nueJJxWlFac4=
X-Proofpoint-GUID: k_ACNWdM4as19vhhkXgPWWWbHocPFVsO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX1J1NDbnGWkgN
 rpHv7fYH9+FHl723Rjz+rG9HGi2WK8ibR2Atywbfn9DSq8RJGYsLNcmPUNkJbXTTe1IPTEcdDNO
 gAxcXqOZ9orkA3A7POFX65ENPG6HG2U2nfz/3wYCUJLUbWbAX+vre7U+N/rZM/wK4K7ySvJHi7A
 yXGWDDqC0uEEGvialvjSB/fPvMj5k6x1jrT/YEimYQVjjkUItGjnSBqiU2DgIkx4YkTxLjNwQDP
 8I2q5Lro25Q+pIKqQFTRK+qq9jOJC4wIcJ3HbWR5pS2BC/YAHXjE4vD6Jbjab45uJEzDbPGeDua
 yEyIyCWFGPJTgSpwJyjB0S/XJm+NVCYPMvy9Hn6iNUTzOyVZh0PBKiAeMlBQZJi4QpLjHV3ZUyZ
 bLF4PL0Z+9tCWtMIJj8mlBX/rr2pQkwtRtTSnA8nFBFVjNa9kNqZOgLkPpOyKatb55fN6x5rL0s
 ahnjNY3s/zkMwJq742w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143

Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
follow reverse order of powering up, not only because it is logical, but
also because msm_hdmi_audio_update() accesses registers thus block
should still be powered on.

Depending on specific timing, existing code could have accesses to MMIO
of powered off block.

Cc: <stable@vger.kernel.org>
Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index db85400e574e..04c893062dbd 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -339,10 +339,10 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	msm_hdmi_phy_powerdown(phy);
 
 	if (hdmi->power_on) {
-		power_off(bridge);
-		hdmi->power_on = false;
 		if (hdmi->connector->display_info.is_hdmi)
 			msm_hdmi_audio_update(hdmi);
+		power_off(bridge);
+		hdmi->power_on = false;
 		msm_hdmi_phy_resource_disable(phy);
 	}
 	mutex_unlock(&hdmi->state_mutex);

-- 
2.53.0

