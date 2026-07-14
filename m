Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF234C130;
	Tue, 14 Jul 2026 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007829; cv=fail; b=Z+PSjgBJ11rrkz8JYIRN8UCZ0Kos9h7sHOWTiNUau08/8S5/3C/jnOiN2GbvgQSYj0ljklCKcYowux6FGBVC8JqF/wZ7eqpHKgUkwcChZhcttAFPQ5/N6T/iKxkPaDY2crbtFE05ra3lj3uWL/ihFql6okLMXEIUrt2r2RiEIzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007829; c=relaxed/simple;
	bh=lMEGTtMuQwpQ2ZYaKb0cEduKv9H7GhJ/wBXY/mxfuJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgt8eqYuBBjWTrC73o2IUNIRvJJCXvLtv8YqmMLXExRWEqHNDleF2fI2Qt5GOCrJK5SE253IV69ykKrDo6kPN57ZvzHUO4HqzaXrs3wzptWvrn+qwIX8jqZQvbmBvSYUS2rLIMCfiD5nXFakcwBOtQMi+tOOvIc3ZBkSqjvpheQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IdY77sj5; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IdY77sj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgOQ83eSei3ZNlhFyeCaU8D8hz9kFmAZhFSzhDbm5O0WUykej1xsbWrI7QykybyGbgfeHE7hgAb33RJEXuUoATchfVGF3pPgm5dwJWPzpFlg7cnIMuOnhyYlctkcokP0STp0vMeb1MSq2y7odSdbQkIFv8IDH8og3WBfWWuR9GoR5l5ZvPzZtLGRXMSgC0rKw/UkpUUJ3DS1eORh+RZsnUseOcobEVOLJNVUH6vEDE7a7SyhM+NXV45a+mHozlDHeP7OY/9yz4AI0mOkgtC/VYmcANzLw7qNVSAH3gKt62VuGkZoImLy0dwAJXMd7wz0vyuDAj1D3bVBf/8KrGF/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCNfFXeY3YKm1TRT3mDfUNdFXF/0FqCBGOTNkkiMVRo=;
 b=TzCT5sp4DdCHPUbMUEkQSTn1zvICgwuI/KNzr5Y2HjdWohD4zDYn1LZ+nAcEW7PziOrYwpOYJHuhNPh6vJDz3qbga2PaMSGtIgSp+Z0vweAy0UCWIGJPk5rkIuSISyWXmGUMqVTUWt0/OTBzYillg9jJXAwtGtgNKXzzDnOH0VBeFh+xPhuaGTpAZbnA2+5tUW8PAvBQ9TNADZdsDKFnaVuKxKdNC6a6Wkd4xDFXxg0i9BVOvbu2/DjmngQHNz/pcdB/LxE9zOuKkdvG0OBwKLV2zhTcM1YbZqVM4ePkYgC17bhnDU03tK6AJsfVzYR9MLN78NqmLftDwW8RNOZNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCNfFXeY3YKm1TRT3mDfUNdFXF/0FqCBGOTNkkiMVRo=;
 b=IdY77sj52EhJLdrDX1Kv5PHsvoA3emPaS/RsEDQfSaTgRpEgByTI7RhtXhhQvCaw/1bqNU8RdEkgHMM7FpcK/5HM2I1ZZc5VUZpMWJv7py41/7AvhqyBmzmyvRCOhOjzdqPCkk5yUEbcK3LELmXdwusD85j0Nkpa4wWUfUdrBM/SArEMbzMBZ4P6RdpFmWOFhCSwPd/qu79Q4z9ZMz3EYgvGEUpuCy/57kyk4O3wWoNiZesD0/olc0AhOe8SQK7dHjUjTBBmEF8RwyEOWsMoq+KM6NXAImvafceHQheOwALmNniJNbeL2V8UUVBPgyMv45C8pm3UX47gRWuVlnRi2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 LV4PR03MB8234.namprd03.prod.outlook.com (2603:10b6:408:2e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.19; Tue, 14 Jul 2026 05:43:45 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 05:43:45 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: tze.yee.ng@altera.com,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] firmware: stratix10-svc: handle NO_RESPONSE in async poll
Date: Tue, 14 Jul 2026 13:37:46 +0800
Message-ID: <6bead7c9dcf06de36f8eb4436a5fb8992290986f.1784007275.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1784007275.git.adrian.ho.yin.ng@altera.com>
References: <cover.1784007275.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|LV4PR03MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c300f48-950d-4d5d-8887-08dee16adeda
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Obnb6PsmhPIljkyin7ifw6JqFPalEiraaU2eo87efEEwBrWl/oeHYmqvGzxoirwVerllDWFVhApa9t4Wb2sjasyDpAenOIcFkTbFxGIPp8euVuo+IK90hbEmo2T+xdScZr9ySoEBuEv51dEZLeRtSsPIjsD9mO6IilLDw4RRBwtY7ni8SpMHPq0GeVxHEl9RLxlA06PcYxABhrqimqZeuz3NjFs2taZnqUwMOiJsQrhzAKkoIy3sNrKG3PWhajubnVnyMdEB5qxhWVgqlua3aQ/d7t4Z+UpHE3OW1IEBniufJQdDeDrid7v3nBC7Ohekp93hcKAeOo0pReyHKYvUzu0ltf8C+S9riCiu9CZ1NNrt7XbNu6ePvDKhUXGNRVWnnDKqfKifZkzhfBjuE0vL6oEPFIo6GolCk4vjH07i1C1oo6UqfCw18J7d5hFGgia/ObJcSAmlHru0XXYBnBsxMHVs3CFT+28HveqSu9ISgYJVp+TlLrNG0SOXUYhN9MGefeMPaz+cV0ALzEcGDJmIIBP65b2OT2Xq3hh1DFJ4su36RIZgTfv+JdHZpUZVtraO2J1T4jqHUPNizMD+4rCR5p9gfeXuKgvcEjqI3OL+WQRd5YPEYMV8g17skwKWQVU2mHCRpIAWCeCGzyEGyCEKJQI/oYH1sl6tawZcRkoV2XE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v8x7OgIVxIGcdQROKGDgsuR7JElpX9GoIklNkmoxJMBFU4wCmleKTPxi7PHC?=
 =?us-ascii?Q?RvMTN16k5gPV8SIHFS9wVNqIYTkHqzo8yySkQdZLleT5vdcES37WfsizYvQJ?=
 =?us-ascii?Q?6CFE/6j7XSLP5/dfsgD2vloEVUQ37CjYWaT0WJe1nShHosGGtwfbxUUjtDhl?=
 =?us-ascii?Q?kFlPM+pw4cCCWEG4AQQ7R60Nqg5qBEG/+BZp4UikUDne9zphSIo1QbdMPhZp?=
 =?us-ascii?Q?lOlF8DokF1thL7krAFQWZ6fF7wBRiVF1UoKPTWdSW6PSazX3omI/YeiCEfOR?=
 =?us-ascii?Q?I4ISIUYEjSAboxWc8Y5lzHlX21VtCY1e0rsHQs+Ua6U7ZFDraI3xKz3YpEsA?=
 =?us-ascii?Q?6JGuKTNHBEvQBMbbjMMFZRLNT69lsewtxacYepf/Ddz6yYLod6Sxbq6s9rw8?=
 =?us-ascii?Q?JGK7DrPm8fNfgDvQqRSEpzccoYyBHzS27FjOofQ+jbPAFltG+W+OzCIcQ9Tw?=
 =?us-ascii?Q?EVafX6jifN7YBdltOfQJZgU8RPoV8+GJtEQ1/Q7kKI0d9rspYRgEnNHHun8M?=
 =?us-ascii?Q?I+V8hDTtOLVd35D3Ti62fV84J8mmTEaO1W6Gj/pFSjH48BtBaw/cw31cGNAe?=
 =?us-ascii?Q?qVW/NsSLYrqJGEnOwEMbjI1NCvvKQY+dhGiQFjldLuf2wXPjeFhHTW/KqxNj?=
 =?us-ascii?Q?x2YaKo7sBwgBppNmTuyU57C4BVa+RVi4f45vmmHBIDyWILRfJa4eVUXTnj0q?=
 =?us-ascii?Q?E+cbRfXWNpCeq2nTrsNnq8dDL10At8hV8uqt4hMf87F2Sm2eixS1rGypprgt?=
 =?us-ascii?Q?rD4TNDRjYJxH8h0sNzv6XxtpszvdXLFKsUB0lBfCSihqkYHDmp6cx9ZdGSA5?=
 =?us-ascii?Q?833qbh+ikXs6Dzf3nROrNSa+rjD6lAgfH5bko/CroCdkNIUk4MZdUB4Sw4H8?=
 =?us-ascii?Q?JxSWf7K50zwsDTELIMv3+y3x97pstmqB0+YTnMuZ36B7/E8SbqXw6yrmKEtG?=
 =?us-ascii?Q?T00Flaebc054QfSOgMc74m7XonyjjfXNZ3y/p8igkLf5XfqltlmlrWXpMu8v?=
 =?us-ascii?Q?WQIP+2JT1VfpPfsz9BVe3VxyICI5ajBDjvPjrjB3h6is9UzMDh3pdNHpwR4h?=
 =?us-ascii?Q?E4LEssuJNiaXfVV0aeMWLmoJN0I0JLobjyrj+3wXixf8GHTQsAw3V4UeLa4d?=
 =?us-ascii?Q?hm2o77FBIOTjUIi1eWO6CNlNT9q/iow7QTRjxfxtkDK3FseaKaenis+ioXZE?=
 =?us-ascii?Q?FR5F2p3B4mktNaTdf2GeTDwLkxJ3saeClPo/srACGIgu+mKpFM0UaMZqJRVP?=
 =?us-ascii?Q?6eR8dx7jSy4dxzS4LZ8vdKbs0CLyFpxAePyyot4y2VEcp5RGNzVnJjvUUl6R?=
 =?us-ascii?Q?mmTRwgPHJVFCmJFMhxueuIH59gzZRTV6t0yvUU9XFTPuZ/aPA1CuSB0GTlaY?=
 =?us-ascii?Q?aoPRHUtn57iWXEnzwvZJCYz8DW3rp7Wh3ZcHSW3MC1S+gFE+sQSLtnqibJ6i?=
 =?us-ascii?Q?tu1Hb0SZk2d3gpT1mdjvOaGBtOMGvbuSTeD97+oII6Dzg1jRUoeAXHciMDn5?=
 =?us-ascii?Q?cSaNEjL+w+szlx5Fz+NnOkn9JtWykP47c1zxdAdLHG6NlzadzvVqFo539+rn?=
 =?us-ascii?Q?QYrcg0jWfUrTiHD7GHGY9eeHGU3utYTuTXBptsRJ/gL9s2TGt8bgGLT/qrzv?=
 =?us-ascii?Q?4jSeVRCcn5ac62/vJjDGzMlprk9aUB1jgU0DqVucMV7F09VJHNTSQ4Y5xfo8?=
 =?us-ascii?Q?svIwORkXzQwF+g8aFv8ztrUSycSUYXAU3DtOF9TB2YIjG6/yRrfL7pam3WPZ?=
 =?us-ascii?Q?7BCTX0gHWfuH2NQuIW/kN5uACLlO9iM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c300f48-950d-4d5d-8887-08dee16adeda
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 05:43:45.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtmRvziNUYlNWkJ1lnCn1DgeERvPwIFJW3qb4zQkeVZWQ4sD5VPv+X6kG2PxaF61wm0XGbeJcCBQdbja6uPuPH7cUt8XPbB7Gw0OhlkrsSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8234

Define INTEL_SIP_SMC_STATUS_NO_RESPONSE (0x3) and handle it in
stratix10_svc_async_poll() the same way as INTEL_SIP_SMC_STATUS_BUSY,
returning -EAGAIN so callers can retry instead of treating the poll as
a hard failure.

When the Secure Device Manager has not yet produced a response for an
asynchronous transaction, ATF is expected to return
INTEL_SIP_SMC_STATUS_NO_RESPONSE. Without this handling, the service
layer maps the status to -EINVAL and async clients cannot distinguish
"not ready yet" from a real error.

Fixes: bcb9f4f07061 ("firmware: stratix10-svc: Add support for async communication")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/firmware/stratix10-svc.c             | 5 +++--
 include/linux/firmware/intel/stratix10-smc.h | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 4140cc488d96..e89fa198688f 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1569,8 +1569,9 @@ int stratix10_svc_async_poll(struct stratix10_svc_chan *chan,
 			WARN_ON_ONCE(1);
 		}
 		return 0;
-	} else if (handle->res.a0 == INTEL_SIP_SMC_STATUS_BUSY) {
-		dev_dbg(ctrl->dev, "async message is still in progress\n");
+	} else if (handle->res.a0 == INTEL_SIP_SMC_STATUS_BUSY ||
+		   handle->res.a0 == INTEL_SIP_SMC_STATUS_NO_RESPONSE) {
+		dev_dbg(ctrl->dev, "async message is not ready yet\n");
 		return -EAGAIN;
 	}
 
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index daa693699c97..2bb7f8427a47 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -67,6 +67,9 @@
  * INTEL_SIP_SMC_STATUS_REJECTED:
  * Secure monitor software reject the service client's request.
  *
+ * INTEL_SIP_SMC_STATUS_NO_RESPONSE:
+ * Secure monitor software has no response for the request yet.
+ *
  * INTEL_SIP_SMC_STATUS_ERROR:
  * There is error during the process of service request.
  *
@@ -77,6 +80,7 @@
 #define INTEL_SIP_SMC_STATUS_OK				0x0
 #define INTEL_SIP_SMC_STATUS_BUSY			0x1
 #define INTEL_SIP_SMC_STATUS_REJECTED			0x2
+#define INTEL_SIP_SMC_STATUS_NO_RESPONSE		0x3
 #define INTEL_SIP_SMC_STATUS_ERROR			0x4
 #define INTEL_SIP_SMC_RSU_ERROR				0x7
 
-- 
2.49.GIT

