Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE93AAF46
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532907; cv=none; b=B+GECCnjEoQntbng62jeCYVJUZlFGr3PY3FEp8DCiazaZwege/9rGmUKh/SFDpHKpRMWs7Vorsz+T+8voeIS7fWfOnnbIc6NStJ5kWV6T8Tm5nL71VZRufFA+xIjIFLG8dfBYgiHgQ84W8gGVYuWokP/QjhPvkkYX4tEeeh3Wy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532907; c=relaxed/simple;
	bh=b44yWDJIlMnSJSDZNa3DSc0Dk2gY4xhqvuHMJA5XfEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvD01KrBIxeTJtTaiggUlc1Otv6scPm8SxPZKTcPxbToluxfgOgJfRG6Z6K8TjdIZq4s6A145C1mY155iU0eQGJnMvrFuC1eOiK7eXx4ArFHnBXip0jwc89YVyBkk2+Fkb77WnlK3ePGwTNNCz9ro9G5gxH8hk+M2R9gzy5mxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cn/82xWJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Acd1x8mc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cn/82xWJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Acd1x8mc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYYeu050481
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=w13e55CcmdNW+giKZHMFFVQwwPPrIweJDmR
	EGBgqOIA=; b=Cn/82xWJC9ZY5SPWHp73+m4uFgZclVvkfAceo6MNWOy7Hkz1nKW
	VJH4g4NPJ74qqS/h3jWacH74Kk6aheGeu5yX+Ud1OqYffPGSpbmGqfXsEGSjry/h
	P5mdg0fKTh/erlCIaBwkaseW8DwrzeVapV378HVnIqtF0pLHtmKu14GcUlzc0S1O
	eh1MqngK2I51x/luYIvsIPMiFqLp8ncA6nYjwG0ymCDkz3aeUvHnv/STvX+Bvckf
	sUXfFV+blTQwEIOhW6jN7c1s7PhYuq1cAhMLIGMWTdK4PzHgQ6NZxdwPON3sRzSp
	29QX76PLrZ478lLMTyvac0OWl8ImzYwWCnA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n62nu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:28:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc489e7a701so7457919a12.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 21:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789532905; x=1790137705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w13e55CcmdNW+giKZHMFFVQwwPPrIweJDmREGBgqOIA=;
        b=Acd1x8mcPj4TDPbD0J0+70/duJilOAq6/afkFKUfdCTWPJed7Xa/UhJlsejtZXdIhZ
         YUZ+C6dfM4wmM0liDff1AUvFW07G5NMZC3WsXmf5/0nUrz5sZpmxQbr6k/6jw+wUkrn0
         MMDzXFbLL3cAodq8zmX3zXtNBfj5ZxdfeQ7EOO8zn6QjraHSzJumYWo1Yp6DrfT0Icx7
         Dl/coYSzzEAMkyxBW1x36JIZ0RtG6Uzr7O/xeRe81IXCqJEJRLcM3X8LNW0B2aGuoGTq
         D24y1q3tSF5oKQ8eObeZM/phQsez+kQ8xCCLh+LLearSAtiMUFvpHPf8BIUKRot0SPAz
         hJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789532905; x=1790137705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w13e55CcmdNW+giKZHMFFVQwwPPrIweJDmREGBgqOIA=;
        b=FkkYEw07LPb5FZ5UYN7imE4T+nh3nt3Pv+qp4fKbz9tsaeQhtWz8yuz8ZsuFZKs4/L
         OsT7T/+FWMG7lY4UpKzwMmUJiWAKc6GoYDqlhTeCQgDK9IEbU33pc6P3s6/vBNtXH5U8
         Esj/6KSJ4hK000Z8E1c28R2q9gEhuWMXYhP0E6sN2DaptrQ33dYESRh8A1i0sSIoQcMN
         J1McARFvQPvXwRcNVHPIhOaNGKRK42ohSmA3/5T9Z+lCWFm34EVuWrpZXPZdM0iT8R99
         YATXHI9E4oEif3ltBwyoZjQAe4HHqW/BI3jLV2ZcsQp+Qwk0j3Zeg2xrTt6rDAbFA7Ig
         8V/w==
X-Forwarded-Encrypted: i=1; AKwUvBzmPHxHmhyPeNn1n5khUy6quO4a7Mq2EDk8Wmwj7T1uR+Wm0TYU7sCjcGrZ/orwl5F4S88qZMU=@vger.kernel.org
X-Gm-Message-State: AFuF++l7APAfqZysRYiLmIogHv+/5AgmDeubzyMt6IgMHk+1X6MAg89x
	hn7gKGCWERoYo92u2pMsKd9oTcosE4Qz0bogeJgpAuAtsJmX8YrU+hCwpOl1cC7XSVRivGEoO1V
	ZCTMQTIIJ3Pd8j+XiE4qwx9bZ4Ez0dCZowq+nDOpqy/lAOR0emCbwT5roJtI7nop5jO0=
X-Gm-Gg: AYBFou2gajE59X+kbddL4RHqnAUCbIcuAAK5ydB7QZpepWaEZvoen8R2E+WXcXYBDFG
	b1MNNta4782vVeQNf2fZlWYzvSzlk+vTVj4Y0ihrJmdISzPOX6e3DjRX5MNVsHjPBl9SoFB9DtW
	3MtzDsiTuZAhRuJ0DlmgZ+2Iqc94os7eHU0sex8l8L11VhWjuhyxI7hGXHZUBzfO/kxykY24j4O
	1szB53remEYvajid2z56fPR0l+yp2WZKQg43X/xKvtdkEeTnzdLZoH8BefzPI5aLFOKAoZLHsgJ
	1qs9hEUbisix3/T280k+Lk6iPhJeEGB635o4Ytw97NXKxq5hAo6P6GdyMxaIntmcPb4aNuSyJE0
	PYqc1XVuB/sIboT0KYTXMREF5oz90
X-Received: by 2002:a05:6a20:d10f:b0:3d3:aec2:4dc9 with SMTP id adf61e73a8af0-3dd5f72b353mr2962495637.21.1789532904727;
        Tue, 15 Sep 2026 21:28:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:d10f:b0:3d3:aec2:4dc9 with SMTP id adf61e73a8af0-3dd5f72b353mr2962457637.21.1789532904296;
        Tue, 15 Sep 2026 21:28:24 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ad6b9dsm3643105eec.21.2026.09.15.21.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:28:23 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Get the connector fwnode based on reg value
Date: Wed, 16 Sep 2026 09:58:08 +0530
Message-Id: <20260916042808.2879079-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aaa1ae9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=KtO3Uq3HwnMQzyJ4:21 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B9IpDpKWNnwCR4r9QlsA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA1NCBTYWx0ZWRfX2fewFOFgcHT2
 VjAvZUEOfwAvWBCuxsCuh7h0KuZ8RwFkSqVpdsL6CzhRqfp2B/1IyLjg7LHPZeyxayKJ31KGWq7
 qP29dnyLMMZnFPUJVQGsL0qplJNaKtmRAE6hf5etk9O6VPdkg6IrzKo8rML6YhqnwhQxnV+T9RC
 8eG3gOCZQDJ7VLyXXapDdjT01XPAMuCMDjAX0gpL9Az224pO2k4jU9FYcVEgLOA6nS8fcEnORzu
 nCPOEsB9rBSAONKeZzdO2nf8jVSrWgxFiyJ40eT7H0LjBgXBk1Qo1FV7EtAzcstGAIo/bqgbnVu
 JpKHQTrjmOOQ761MRrAeOAF1L38RJE13iRSF+6QSkrialopyvfpmpcqLpRAjHv1eedphaBvpMCy
 2KjFP4f9j5xB5gWV6HC878nkQGX8ecY3Dadw+YnMfhx9ap6GWoG+nNt7dTUQP35TYosDF+9wxmw
 7Ce8+tf8V1TaXeyDKmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA1NCBTYWx0ZWRfX/UJGWsCERjwR
 q5mlTPqeTTFjZ6XNTZ/jAM/XSbR4XRQ8GUMvBPkniRXwe0KgZfy2f7xgmlYVaXdhqBooJMUzGvx
 t6/ed+KM1vum5yj9M8CCN4XiPdP61J8=
X-Proofpoint-GUID: 6eeWaWub4fqQTXoCR17Bjzw27vz0WyCD
X-Proofpoint-ORIG-GUID: 6eeWaWub4fqQTXoCR17Bjzw27vz0WyCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1011
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160054

ucsi_find_fwnode() currently maps UCSI connectors to Device tree
connector nodes based on the order in which connector child nodes
are described in DT.

This can fail because the ordering of child nodes isn't guaranteed
in Device-tree. For example, DTB may contain connector@1 before
connector@0, causing connector numbers to be associated with the wrong
fwnode. As a result, role switch and Type-C notifications can be
delivered to the wrong remote endpoints.

Fix this by using the "reg" property of each connector to match
its corresponding fwnode. While at it, if the reg property isn't
present, then fall back to the old method.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: stable@vger.kernel.org
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bef3f9b71d71..c1450639c795 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1801,10 +1801,21 @@ static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
 {
 	struct fwnode_handle *fwnode;
 	int i = 1;
+	int ret;
+	u32 port;
 
-	device_for_each_child_node(con->ucsi->dev, fwnode)
-		if (i++ == con->num)
-			return fwnode;
+	device_for_each_child_node(con->ucsi->dev, fwnode) {
+		ret = fwnode_property_read_u32(fwnode, "reg", &port);
+		if (ret < 0) {
+			if (i == con->num)
+				return fwnode;
+		} else {
+			if (port == con->num - 1)
+				return fwnode;
+		}
+
+		i++;
+	}
 	return NULL;
 }
 
-- 
2.34.1

