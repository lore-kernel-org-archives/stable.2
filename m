Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BC4F4725
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674204; cv=none; b=Lej9wmnUD+TidEa9DLDclAu60I4TLCIBPitZHxSGUfxhtJ0Po4ImxCU6QlOvxwuN+hHJ1FMIPGLnitgm+qJWGQ5q6XXWU/+HJ/FBU6Pvzj2hOk2yOM4MoOcYCLxcAVtxF06h8Djq4qIqIQjHacKn3nISBGnKQjxnKt8ziHvF3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674204; c=relaxed/simple;
	bh=8G5gXQyXRQwwX7f43Ne7m+CsLz/u4b+l3A+714FBABI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xd/9oma05MQyAZrx2tCyIf8Mb+itAEXQSHHrPEo0oKJSWxh0q33/m5y+Luogeqwl/5xkY9CEGznvwOO6fgJOzRIUFwo4+7wY7txSAL8/vj7O8d+xyUCYSW95CD9eQjyW2YU+6xuFG3D+V0oGmyEkmgNFYQD+dNoL0zthiM0hHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=myc+tZGn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a8hkPjvD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="myc+tZGn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a8hkPjvD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7TqmZ2570996
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uopSwhhdcz9IXu3XnYnIyA5siTYr06KZ8SL
	qrVGutvs=; b=myc+tZGneM4FK7d+SYaxWaJi/68m7QFJ+k7jV5+ZhtIdzRFIlL0
	/l+dLGSZrYAemY5O/b1TI5tFdT5O7QSQBPo23YijsboocglxUODuWMeLquTSc+kG
	WEnZhOmfD8NPMlHyjcyW/7EJusRHV/ORgWWlEbaInUHu/w/52dCUVjJGykQ1OnyL
	NvEefa0AkWzj1Tmr++VHBfI4KiKwXfVAaNahIWGefXYU9hqE/9AWqRH2Ld8CiBp1
	X3u7Xykk/n6CG/iUrkkSPWBOKzFf+AT8X7dAhEGxLTS3Qr/O+cr0LAHQ80T+KiHQ
	lxN7PYl4VTus8IcoSjLTM8fAs2F+PubwYSA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn9xgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:30:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a470ead068so1551467a91.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790674201; x=1791279001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uopSwhhdcz9IXu3XnYnIyA5siTYr06KZ8SLqrVGutvs=;
        b=a8hkPjvDF/U1/cZnuGjxavuA2HviXJB0gGVf0NYl7Sfl+7118u6lNmcOlIYKIWHUNi
         Dr7e93tvxfSUjQTaEbhU1jIGmbK7OlCqRDogI+naJ4ITglSNBzPx15HSs2qbuPjU5qRI
         VDAFnA6nSkXHCSbEf5A6hP4bmsqtMZdXTOa/KxbxH1rb55LsKFSu8ibKZgtPRC4Fybtu
         3T0+e4fcR1BXMx2IszbL+SMixqlb/ytThmeVIx2Yj3NYKEa13rjBENpneDg0Zy7gk9i2
         T4UgSsxDvkQ7G954cQ5hHEOHZDzUFu0ujy486C7OX5o3NC3JFCki5zEiewjldg7DAM8z
         WnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674201; x=1791279001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uopSwhhdcz9IXu3XnYnIyA5siTYr06KZ8SLqrVGutvs=;
        b=lQ/gAp17291hhQgVPQIJazrpXwvrqLZQv/mOGYIhqzU6e8ndTqyZlQ5xIn/ntV4obV
         l0nRoKmSJFZ4nMxVLbfNz2dNspvzco7RTshpy54MHEcEtRw0cve4dBzZYvmxmSb4IAuf
         +izaFFsTdEvn8WWp4LPK647YaWpTjicC6aSPi/GiTQnO8gSj01JlrrzTyrtLDbC4EeNE
         4OkP9vluWn6G+hupeoqLxGrHzWRV4lquEENxylZsqSmJDwJSnfCr5HjgO93EI2zJ3rqE
         ZjPj294EbCFk+DMwawXvBcqtP+u/n8vXM5VOi2Vfrs9TjPsmFoIYfdN6nsnjWHJ50bSW
         uh9A==
X-Forwarded-Encrypted: i=1; AKwUvBxk+kKZ37x2pdMWrNh9kDmEVNrFnL93cp2EkJaGY9Xrbsqj+BUsUZY+bpQf9qCSFT7SHn0f5gA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKycQkJqC7XSuEjdrkaE/5aNdIXT//dcck2t49I5tUI7Jd+M/vR
	+FkXmM9+qvI2TOrUuSUCzVxAVkynGPIYsjCU+LuPjlhN29shFewXlA2dRaxHEyQ9k2cPdJW5ri7
	OruEUfJhB/fHN5p9I9zuc3Om8xLViKC2EpmYsWg2A6nex5Dt7IT9oWIOf4Ko=
X-Gm-Gg: AYBFou1aIz7W2g8ltoYlX9Ybvfv6spdNFlkbMC34ObT2GcY90h8b+19OfD3yvRbmCle
	3Ou5g1pzrO8pMK4ovIjhPg36dxglzw8OInfTKlDGOJEF4CjRO0fF08uJ66wkIWWeZ7jkhdQqA3l
	8YqoVzs/rIE2nCR1ox+sKXA0E1crM8aT/KQBxdjzjr8Q/+v2yUjdG4rkAzm/xtXOiC00rwmuCrO
	+RL8hqFCO4owYTPrXWIb30JD8l0lOFb+nMTlhvhp4Waq2dfXm37BWB7q+5CKRC5vG3sj2m0zd6X
	8PVqiBbIIBzVf0j9NOjC63TXSvxPHPYdFVM1d0+AsGiQghQ7wLkMjW3aDppFDFwZeX0lrWgmfT6
	zbot53wzL35ZrMa8XsXhFl/5K23HGDlPF4yZ3rA==
X-Received: by 2002:a17:90b:3c92:b0:3a4:7c19:6a0c with SMTP id 98e67ed59e1d1-3a47c196e00mr2108200a91.31.1790674200842;
        Tue, 29 Sep 2026 02:30:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3c92:b0:3a4:7c19:6a0c with SMTP id 98e67ed59e1d1-3a47c196e00mr2108188a91.31.1790674200346;
        Tue, 29 Sep 2026 02:30:00 -0700 (PDT)
Received: from hu-uaggarwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492da42a3sm2266775a91.2.2026.09.29.02.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:29:59 -0700 (PDT)
From: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Subject: [PATCH v2] usb: typec: ucsi: Set ucsi->connector before enabling notifications
Date: Tue, 29 Sep 2026 14:59:39 +0530
Message-Id: <20260929092939.1806907-1-uttkarsh.aggarwal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb851a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aR1d7MnS8zDfWtQP9dEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: mA6ebC8fxFHm1el8g96yCWjfqBXZz3lT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNyBTYWx0ZWRfX1ZPSKWBn9C4u
 3ZH3hW+EeWOok2agIzbfFdi25AEvVfWJrGpIOBlIDzQrsmTuWaUqvoZPAtE77/3yYi72IWbMPRk
 CJHQUyE/UnstBAvVBgJDJ0h760KitZo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNyBTYWx0ZWRfX84SkeHEsz5G1
 WPKuD+76XLU+hjd5MtqP7kdXcm/yT+Pzg4SdawQkgXCK3fRSOr+4PXFh508zrE3zX7rF/iYumY5
 j0avDdGwrABIwERt1NkSvMPIg8bByTcJ9Tq4G+hPv53/soKx76TsbWUQMIc+MOko+jQeYYJ40uD
 e2JmeVQfW/m73VYPOWLXVNi4Kmeyg15NpK983kJaKHPtEJ8cnHjoYfgIIoTziAFEsO3USn7JENm
 QKIEivgtzJu/uoK4c24E5ogd+5+dfkpAe0VUmDLI3kDqavJoF1PzTOQ1ObJxePJMeBpuOpWxpu7
 wvmUXz2W4sx7o6osvmj9rpCYRqLG9AYYzXOvsnWXEhXq5dHZT3QDxjH72pqvEA19DL8UVDBN2q5
 tzm4RW+fWVu02McratcEabZHX2xRxlNtIgcP6L0cp1AyY2fH1YDli8J/gQATcBO3psDW2JpTar2
 TzxXmJBnN1WZ6gbLlWQ==
X-Proofpoint-ORIG-GUID: mA6ebC8fxFHm1el8g96yCWjfqBXZz3lT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290037

In ucsi_init(), ucsi->connector is assigned only after the
UCSI_SET_NOTIFICATION_ENABLE command completes. But once that command
is sent, the PPM is free to raise a connector change notification at
any time, which is handled through:

    ucsi_notify_common() -> ucsi_connector_change()

ucsi_connector_change() indexes into ucsi->connector to get the
connector and schedule its work item. If this notification arrives
before ucsi_init() reaches the "ucsi->connector = connector;" line,
ucsi->connector is still NULL and the driver crashes dereferencing it.

Fix this by setting ucsi->connector right after the connectors are
registered, before notifications are enabled, so it is always valid
by the time a connector change event can be delivered. Also clear
ucsi->connector in the err_unregister path so it isn't left pointing
at freed memory if a later step in ucsi_init() fails.

Fixes: 0482c34ec6f8 ("usb: ucsi: Fix ucsi->connector race")
Cc: stable@vger.kernel.org
Signed-off-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
---
Changes in v2:
 - Add Fixes tag pointing to 0482c34ec6f8 ("usb: ucsi: Fix ucsi->connector race").
 - Add Cc: stable@vger.kernel.org.
 - Link to v1: https://lore.kernel.org/all/20260923060434.2599545-1-uttkarsh.aggarwal@oss.qualcomm.com/

 drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bef3f9b71d71..8f7b73a9f4f4 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -2122,6 +2122,14 @@ static int ucsi_init(struct ucsi *ucsi)
 			goto err_unregister;
 	}
 
+	/*
+	 * Set ucsi->connector before enabling notifications. A connector
+	 * change event can be handled as soon as the notifications are
+	 * enabled below, and ucsi_connector_change() indexes into
+	 * ucsi->connector, so it must not be NULL at that point.
+	 */
+	ucsi->connector = connector;
+
 	/* Enable all supported notifications */
 	ntfy = ucsi_get_supported_notifications(ucsi);
 	command = UCSI_SET_NOTIFICATION_ENABLE | ntfy;
@@ -2129,7 +2137,6 @@ static int ucsi_init(struct ucsi *ucsi)
 	if (ret < 0)
 		goto err_unregister;
 
-	ucsi->connector = connector;
 	ucsi->ntfy = ntfy;
 
 	mutex_lock(&ucsi->ppm_lock);
@@ -2143,6 +2150,7 @@ static int ucsi_init(struct ucsi *ucsi)
 	return 0;
 
 err_unregister:
+	ucsi->connector = NULL;
 	for (con = connector; con->port; con++)
 		ucsi_unregister_port(con);
 	for (i = 0; i < ucsi->cap.num_connectors; i++)
-- 
2.34.1

