Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041A3A6F0F;
	Mon, 31 Aug 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211990; cv=fail; b=S+lK6p6thO5bu7dO4hpD9YDshZEEuY6FpAalIkYeHZJrVO3plWNVrwmHmcfycViMFIbUOsRyWAEGP9b1Edz1fHzzKu3JYIcNUVDD961vAp4SdSc+DOVSIcW4Q2fRL1mNve+DnsnBCvdvW1JG58tfwXPttZ8X3dmPKviOXPJd9hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211990; c=relaxed/simple;
	bh=fwhXzJCdieu/sQuGsR8dOWnwVBrM/+Wje8ZeoAZaqhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RePw2iftkLdBxsaop4S8KiHO05BQltwsjqY2W0c+77xb32ysmHBbHiv/e963e2+DBB23m/+r5TdH6pRK0u1lJjcjCzAK0h2npsVbhX3rNZ/KZf0qAkL+FfY7bVy/I2WiXjmZLDo1eRDOcMEAIQ+CnPa/yJMY9PGPvuS8baolwQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=cJgWz4m6; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lVJseC9K; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="cJgWz4m6";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lVJseC9K"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIS7Kv1444698;
	Mon, 31 Aug 2026 16:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=H7Av2un0hSQlY2v3HvdY95V+l2YM8/WTm9OsUFD9d
	jo=; b=cJgWz4m66ZKI0NjDK+6tDYl1TxX4LKJ3ARhAOH8KCRZ7lFpYm5VrzZFzv
	AnxYgg84QVGKo+n3PqAcn0YiRQ8jdVSNfvNF6GfKFMeeH+aLIv5MqkUPdlfNcrx3
	CPl0s0q0wcf5gEty56P0vCqzAaGJN34FDeFFIVZICbOcAbhFbuC122Ik2kfGKQ6v
	YSkG4/ClszPIsgELWKfB/RchTxwB+Mx3Zvpxp5+i5IjNYfySv7/K5k8vz3wwXhfY
	JPrGrIaLOSPlUrx34GqFiYe2yrI7+kmoUwu/X6RE0BduG/heFE5cxB6G61ac/VE+
	IUCbYAEDKoliJsX5LTgJ2uEx76YHA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gcejq0yv5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 16:33:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCVSxQkAYWT+LH6/ieudgu6Se7USF6wsJ6M2w++DDtWkzKKWAP5Uf1zdnKkj6u8AqCKmjoLHCMxN64sTtSc6XS1HzXbOotKr3PfPjqanJ4LviSRRQJ9baWRgu1958W4K6ywMYDZfFR0c1xSutws92qHHno+pyZ2CqPkyYFFoKOb6j0HX/LYsGG2AauyJ/MytYHkngnBGjTA4PYqZUldjQm+chK8lrOS/b4eZIF1Pt7JNj2bjP+/dO1JoAUPa/mqnoiwB3Ni21h1p7ucmco9Zjjs9UJ8yvd8cObjiKMckRSWyKUsfN2bw5cHbTK1EjoSnLGuSBlc3GvBFEfMV0BoPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7Av2un0hSQlY2v3HvdY95V+l2YM8/WTm9OsUFD9djo=;
 b=JheZiFZ0WInogKV8vhN3T83B1lmidjeI61aTGjHWscPSNfr0ZqpJQGxzF72oHyoo31+vqhJTJ6OHxuddzka6WdkXHyJdfdGVaHmFHe1phqIBySnfMrLOA7Xkg35mx4XzYom6zFyrNhclTiRL1tmMY5TKXBu2PemWHGuXcu0H9HkxcDDbPIhqWrUFzm00DsBdXLCnjJ/Ckre1c4B7mR09FKeGnsXHwwaFU+fzlh4COhaJO1ffNzQHQXrGXj+iLrP7W05IpBpvuQkc37jeDUri9YSxpi0uT9rtCYgTyzIS81zdhO4j62zSYjUrUwF2MJwOLEEttRZZq4NI7nUuyrmEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7Av2un0hSQlY2v3HvdY95V+l2YM8/WTm9OsUFD9djo=;
 b=lVJseC9Kv5/hPAVHv2YfvBGytERGxloqku3/2ICv8AMuZPlcspzg/ZTgNCWjTnccUYFRvJ5yC5Kz8fIqnfcLfIEYcVChK+L4FpXYo8HrtEvjSG07Lhe4kocBQNIcuZ+cBaIxePRZBWMXZuDQnyZE2MCGUwI/dI8G3irvy0CFwD0=
Received: from CH0PR03CA0442.namprd03.prod.outlook.com (2603:10b6:610:10e::32)
 by IA4PR10MB8688.namprd10.prod.outlook.com (2603:10b6:208:55c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.7; Mon, 31 Aug
 2026 21:32:56 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::12) by CH0PR03CA0442.outlook.office365.com
 (2603:10b6:610:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:32:56 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 16:32:50 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 16:32:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 31 Aug 2026 16:32:50 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67VLWbYd1545515;
	Mon, 31 Aug 2026 16:32:50 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <sebastian.fricke@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Brandon Brnich <b-brnich@ti.com>, <stable@vger.kernel.org>,
        Jai Luthra
	<jai.luthra@ideasonboard.com>,
        Kendall Willis <k-willis@ti.com>
Subject: [PATCH v4 3/4] media: imagination: e5010: Move e5010_init_device to Runtime Resume Hook
Date: Mon, 31 Aug 2026 16:32:30 -0500
Message-ID: <20260831213231.2125544-4-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831213231.2125544-1-b-brnich@ti.com>
References: <20260831213231.2125544-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA4PR10MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: cf049009-7174-40d8-b4bd-08df07a76c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jiw4bSE7aKhsQmetwoLH8m4JLIQvJXICozCj7GqKm+io0xt0f3HUp5bNchcFT+j2YgiOsdoS7vwApIAUofuGNzzKabd17BrX67BxVEvsLlGX3t5SQjubPCPvuBzMVApbwBY58kX99g2uA4+ZiM5AXr6qsneTaLHN4CvVX7w/yksvSbKDqj6RE4nieVXdiWQcoPNVV+Hsdd0O3U1OfurmY6bXM6fyGr3b6T40+Q13Jv3PriY19iTpChOq6vYykL6EeJEMNjNJxjFnAgIZ10Za5sis/IOuLzQIb59mT6U8dLhDJAjKTjY6w7DzLru2iHd5QBD/ShuPfmz9GnVG925OW8E4bosJweN6w+9NA06F4r7c4ih0CYy7w5aopIrS9S1q5mjXoswMUGx0dfY+G7d5zFr2AszN8Ll3yF0q61loAP0+as7BGnWcjXVomL474Rr+aN6UGBZirSO+ceUvTqlmkyzvy4fHCxHFbtfAdyntzrvF1+zH5osoT4sOE2dASO5lJb4OSRRCLKPgEpH5k9uDfhTaHowgxizCPj8xb3KlQNfHVK5zRBn72wORXUUPnVyjQy8F2pVvA2XhKYmaXeb36V6xFnFwSZ+UnVb7ruJlivNQyGCr/ez4hIm2YhuvWf30FsNllgmV8xj2mS71hLE/sBLPfX0y7ly+FaIE+7wFGdns4OJu3X/nr9DcoEV3XyrLP6+yqWDo/dK6m+pXSLhRmg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OKOtyyKDvoBMRKnlZUxGeq6TTK58CbeaIwNGVeBrtigw0WCIZ7ZqrToU/7qvwV5RDrlwwji6dupbhIdemxOz/M07nfEqufMtnpkvO1s5DRo6k59Gc5vI+Qgioq4TT2L9UU5+IdWR22h+6CCHA9wzwEOYxjioxD1qh6JGltNo+6m5tV5nDSZIQUYZAmiJXp0zWpH63LAvCLAZMEux3+kynIgcF16nIBpbAEJNNUI5IacNl8E2eFLkPhH+S5khays/+obQrhF5Lb7BlpOFJh8EQlbpQ1WRxLCPR140bp9SlrydKdfSFqGD4nAOb8H4yWCpQGnA8Nvhm7qDqVOwoBJK2f6r//DD197MWs0fJMkQgEs7mNOJehPpVy2GIliZqwUnSWOwP5CQY+8dWTxkDoKic/Xnk7TPAwAN3tb+WNGLnEYhfalvBwWylbLOiZ/n0E1N
X-Exchange-RoutingPolicyChecked:
	xbHPn6bHfuQDc5o8ZPvIi7YqMwLB3/FygD6XjRkyDY94Pw0vQt7eD0EDAJ4JSttqFvEi2im34RE3w+8G/nmTG51biSCU112DIy76E4vYYXZ661thSvwo0PosKd2VoB5zBqlQAILkSQ4y2GgcmMCVBDMu+DGq2x/3nDx74l148UbmK78KSNmrdXHvQ9ZTDs7X8XP6rGoLPhgO3av7ywsm27MP0LkZjwzTsQkmalxxVp4oOI2hTU69CDmkEp/M+8oHvGxTKW4a2Ei0pr+NYdHCaKegNw1CMCmq0+xg+UyabnLDdUBNzvm4jVjsm7TSptEhEY2Oz6zcQ/sZiiw+VM+gmw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:32:56.2253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf049009-7174-40d8-b4bd-08df07a76c06
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8688
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE4NiBTYWx0ZWRfX+ncoSDLjtFux
 1H/77jQ7oytJozRZ0i9TpzgfXQQ9e1pn4+mMbMXrsR11xMqsnEXoss6QSbsSfV/pcQfJr0h4HCC
 0L37aE3L/SLvH567zf8h1D9fkwH40gY=
X-Authority-Analysis: v=2.4 cv=b6eCJNGx c=1 sm=1 tr=0 ts=6a95f30e cx=c_pps
 a=TuoCv7SfN2yFw/uhdbj5/Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=UlmMjaRoNFhtWZaF8JoA:9 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE4NiBTYWx0ZWRfX7A7PsATaKWAY
 j+Bo8RENS66bOgtO+0BNCFTH6pWcHbyaef9Pa3HF70ulDLY0OPWLq5HOKEFjkNeFkn/KzNb6bI2
 NH4WvP41YMx06tQNiwe2PGyILgm3iHD6Q6K2L8QsCEY8F2qEOyMPKaSr3gJL88dj7tuODbHNW3y
 4lZUsxl3TZULRexNdcKcPaT1rv0UQlkxmt6z13cwPFuPQORsuQMdObaxhojQa0GOB9mUbW9viXO
 NH0JCcw1crfJM85U8WciSWgBMZqkSOZYHWm33dKWYittQrmaf42piedX7Rfk5UH/9IUQlVE6J/s
 6ONpEClCMMqY3MAllgQIw9s3YNVzlODDkuF8r3zD8eJOLIlK/E3IbcnAqxfGiFy14l4O6/i0Abx
 ifgUDt83OXAPczrXhTsJPR9RWfqE7EF+h4JfzTT852EjUAV13fQbNWrymEzqr9IN2bkxpUpEa8/
 yuk6w+XD2T3/qOAgCmQ==
X-Proofpoint-ORIG-GUID: CsCd6Jkv5j492bSSebJ12_P4MiZdqVXE
X-Proofpoint-GUID: CsCd6Jkv5j492bSSebJ12_P4MiZdqVXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310186

The PM framework skips the runtime resume hook if the device was never on
in the first place. This results in a crash in the system resume hook when
a call to e5010_init_device attempts a write to a powered down device.

Move e5010_init_device to the resume hook to ensure register write only
occurs when device is properly powered on.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index e98fcd3fcd9ae..488f5d7e4c9d5 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1511,6 +1511,13 @@ static int e5010_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = e5010_init_device(e5010);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable e5010 device\n");
+		clk_disable_unprepare(e5010->clk);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1543,12 +1550,6 @@ static int e5010_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = e5010_init_device(e5010);
-	if (ret) {
-		dev_err(dev, "Failed to re-enable e5010 device\n");
-		return ret;
-	}
-
 	v4l2_m2m_resume(e5010->m2m_dev);
 
 	return ret;
-- 
2.43.0

