Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273446;
	b=235e7rTb+qKYODLUZKgF/Qv+qVX08K0TtlpM8Ris8YRWJGjGeNvJMk1wodjOjXIT1Z61
	 LKuky1KD5uhv/Hr47pmW2pZttNmSUndvUXhwo0OgDIi4VaU75wh8wSVEOTeCRyVYcHuGP
	 h/iOkBdFSloS7dCItJ065GsCSESS+BgOSj/UpQk5D4DheDJ0UyEV7+SOLccrGxJwj2Ea6
	 9Oguj4UVuJNums6Crr4Do2MPHxPkxOgSL/A/oZ7r8+6BFRNmA4JP+kFvDl0HrKfbAyDng
	 e8lK7Iy8tbixalCqkvfdGimkuK/ZxchIH3puNITR/7LfRb9uIlCNSwfl8NICXbbkvRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273446;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Organization:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=E5nKOLOb0TNRD3R8Vu/qLhN+A49ep3rTeqrQNWsdY7U=;
	b=3KTfr9k8/ojzstZkWebG8tPXFMsey7WGALRWXVf05z6oJIOd8Q/OMAKfR8dz9QT85Uf4
	 suIOf0zCQc2m7fY2saUNW13v7scTOIwh0wHXRvAt3Zbvh9VEqUbHBE4tba5UWdq0g11Cl
	 RV0pPa2tf7kEGCkoCkeQD8i/f2zP8CDRZed77cETYK1EoY4WpcnXm5+dWWe+LMSwNQB/X
	 GdIKZe/gJg6zPa/edp/ftGVH22LoLrglPywYjNBN2gaqBk8c5aqZ+EIe9kNYBR5nxCrOx
	 noWJqwFoJLD7yNjYVUQJHf3khvmYOK0Ae0c29PK8tX1xFeiYxSUiSVhirE1M9ihDT3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b1TVWfAr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C544606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C544606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b1TVWfAr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793273445; x=1824809445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=51a6mHFAro9bpOqS6nPhyVj3UmbYwR6YSkJ+n1us9I8=;
  b=b1TVWfArzrY0dvajcIu+Mv7cTW2yYClf2A1Dy2WZ7TAcX8gmE45DJKsf
   G+88dEdH/zHr3QNwZV0YQyONnJsEIsd2XWj51Ekfmw3IrMTGTePrClCLA
   ufmHPHwjgSTme0xmpo1bB0SISJX+yf5Rlc4cwBYhFaXu9/jGuKfTj/Owg
   o+nQiERCnnTAJAWum2axNBYhXnJOXUCSYhexF8ZzJyWVoLMg9VUyh2RTf
   iEs+mZnVbtMAiH7vxbouycAMBQK2sUWgACwyH2HHCBSr880XPcQZ638py
   XxrNJqfOlh7uOYEJ8yKVTPvmUfbHeuxaoLNssF6KDFXkCuFo6Ch2fnukS
   A==;
X-CSE-ConnectionGUID: ZKO+qje8TcS5iB6Z9XdmXw==
X-CSE-MsgGUID: c4GlV3JMQYGXiPM2x84zYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2018061"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2018061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:44 -0700
X-CSE-ConnectionGUID: 0REhG9kgQp6L60O5RxvBDw==
X-CSE-MsgGUID: rscclq4DRhC4uvrQJYJHDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5130206"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:30:43 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqHWE7c//6KNd21boCmL2gR+WvFCF1Z3kOLW4M6hxSyIptlT4BAy72ddQZ5MQLpzxE1T8A8RS9NSctWtgguSsTGxQPWAneLgf0S17plZ8ael5VrxWHzWus7jn0zFnbYsMi7YlWj7jvJeb6maoLJK3EcZloG3ot4Mddmkno+gc2hVuuma7kntfShNGpRO+nL2LrG/P76f0EEk5lBe19DDjv4C1dH8BT3hjCubuIwIx71cXHTzALlWBQxJ7KQHweX/axa4dWHs7LGWV/0MdmM8++UEF0RkHez9mRhsNCH3pVFOeNLJsagiA9wwlxvx1+TF1wX2Fbp3Hcq9JibttwcvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5nKOLOb0TNRD3R8Vu/qLhN+A49ep3rTeqrQNWsdY7U=;
 b=jG6SeyBmoDo3eixXm0N8k+xJtegA9mkEM6Aij4FaIiNYC8/dCZd+xqO1ZjnNTv6d3M71LsLL6vJMeL0Ca9ormTebh7T8dzOPkAygBaHB6GUhNkcgIg2o2YwKXIOrIvnnz4irntR+IfATPaUDmfK+XboawJXxeXZTWXMGD879LRCtAjnG29Loc8tEbcT+oMJMPCDIK+fXXStqATwb/vdqEDTg+QbuSYZYzjEfMKSzj2xyfoQE2XYrObdwJRqaMMEIHSRVEeb7CWIF3yXJ5/Dmx85hQ+EmApY09poOSwWM5cxqdqGFxo/h2eOB0e4i0T0Nplves9vVteXPzVMd4xc8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DSWPR11MB9823.namprd11.prod.outlook.com (2603:10b6:8:4e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:30:25 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:30:25 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 1/6] drm/i915/dp_aux: Take the TypeC port lock after the PPS lock
Date: Thu, 29 Oct 2026 13:30:12 +0200
Message-ID: <20261029113017.618286-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20261029113017.618286-1-imre.deak@intel.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC22.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::119) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DSWPR11MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: c01e4d4a-d0b8-4c15-89a2-08df35b00649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|56012099006|11063799006|261009223027099003|261022075727099003|261009221227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X4R4x9OuG07nrltCHwYIYpoGFC989X0tGNQIU8a81uZNklwhTlsjb6rQwNINg48bx8KPDlmrxZvL6SbQzTpT124Cv39aKDTCdDG9F/8d31cHR8tVit+MCRiAq1L5FCaxF/UgX3nOZrkT9Uel/pIr1OZ6uyxXjf+9e78T1sYiMWFuqWwv2xZAA/e/+gnImAUJ6TCf8lSsho4W2o0uF+TiheFxl85RIY7ik4bA+qdwMXZhz0MPZx6iV5c2CHlPLW0aQvIV2LMuYJBVzZPNi++Ua027deuynxtwPTUJFUyjnA9+iGA0doQ1cTncLK0QzbvYhwPS0ZHIqXC+xYQC6jy0wAQs5yg0yiXT3ZupLvikGgXLfSzW3jxLr6Z1+UvOhofe9dzIWXxPzNQcjUXt75Vk83i+H2AltcZ8s1ZOBWoVfWWjJhZfIETbGwbJJOmsY4O/akHbP0h3+UJRhVqzOY8Cuvh5Uip5laNWc/HqQi7fIja9N4VAscODmqtf37KrWz/Mku+c4al9fEOv71MfhD4dYE772E1254Opx5y/juu33P6DOHiWgpanSSLRdd2P4GhgCjmgbhJvVqjoBSAdgUAYm8pr1MOwrEfvDD9O511Dntbdkdb8HxKG1dej/iAzUweja83UmZsKwlYm6HxTjpjvxxmV7sVY4CznU2qRHs/wgXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261009221227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hM9ZnMYti5WlbuH1XmDVJ2zIc2STQBTgc9mx8FXQZjVpW8T+WHFyMYqzC5xc?=
 =?us-ascii?Q?pWKkbulIEkRdEMvlqa8GgkXELlw7bOKS1/QjxIgzuPufMTJjf/2P1o78xXUU?=
 =?us-ascii?Q?pjrmFteZ+mIuUP5wL6QR/5pPgZtv4INkp0oZqFQa79WIDKTppzln9v1/PAHF?=
 =?us-ascii?Q?T43strPlfBxA2W9fL++2AWNdoftAegAStXpqFW2tgA3Y9/7QzaCP3X+pzEjz?=
 =?us-ascii?Q?aoRInXOWdnIq7Z9AyaDLcOPd3iD/Fdux7tbghK/LKfoCc6xYo9np7rqBtJGI?=
 =?us-ascii?Q?LDFD5WDPDsv7TfFCWzouVhKkSJS77RvBfQxCWxGIir3mGy6SsvoCxFppg2MK?=
 =?us-ascii?Q?G7J61SlA5e/nMg21KaP/QEINTF1EPjM7WCqodz1PAPRGT1X7xI0/ErZWN74q?=
 =?us-ascii?Q?OTVCZNZnXgmaYgqsn4Lb6FmZt9MSDFP+DkrXvKJ53iodmm316FBaW/AC4Nz7?=
 =?us-ascii?Q?yXAhvQszPWHRlK3MWDGLfzsuvL8hEa42pqEJhuTSMiW2tdiZbhHyXC7iOdyv?=
 =?us-ascii?Q?4E596u2u7tBFGbMzFtF+9D9eMKKNX8nvsl93pH8bkCY2u/QJzfaSs21JxR1P?=
 =?us-ascii?Q?wXZNWP5f0MUDfLjHyQYAaBAz5lvh3dUzJz9Hlqvjq7Eq+54WggQitBixODmG?=
 =?us-ascii?Q?3ZWD9yeQY7Yp8hXQSlwGo7YxVxyzeLKgB3DWzgWBIciiz5N0W8ZvmtB+5CFW?=
 =?us-ascii?Q?ppKKoKQWuw0aE+u0UlfFC/KnACdOew4RzRvGA3NVNu1GbvDbBgHyI+oVFSjx?=
 =?us-ascii?Q?sQcyGUr2zCihHQHLLYFfNEDg88D8p8idViRKllQeKz/rcnYRY9VTMouaE4aM?=
 =?us-ascii?Q?SNz/ACZfaB1U/l06AE9u73IBj+g6sRCIgjKcVEs06/WBnw+smiCJIcrx+MrU?=
 =?us-ascii?Q?z1ZxFlIgZhJgBt+Ec7CWOOizZ9sOCD55TgMYw2EOiTjRimP8VdbTX0Qt3JBn?=
 =?us-ascii?Q?Vz3yuR6VMNopG+Tsgw+XnVvBXsoPSGNaBj1ee4sTUz5ALBsEKIXGPpd/WkQy?=
 =?us-ascii?Q?ND1vhWUXvWEJFrV28JsgyaSAESIHcphmIDo3ANBqz8EtCyp+5crF/37djcfV?=
 =?us-ascii?Q?JXzXZTmWBuBdzd3Cvaq5uxskkXOW8Wt0FelCNgBfHuA4AzxmuU0sSLJVhDfr?=
 =?us-ascii?Q?3kjqeVA4T77FqKcv77QJHZh0G/ACl9jWwGeFYMRcKNbTLdyKO4Ss+qC2hp20?=
 =?us-ascii?Q?BN6X1OJNtFeEaHPh5NZYIsonEt93sV2e28z9eVvyaiiVolHr11JDuHpYviNi?=
 =?us-ascii?Q?GOAwGjH3AANxxuH3KE2sGDNhwsSoP4Npf0MCblUPedSfsHCf82WxYUFpkIBU?=
 =?us-ascii?Q?f+DrGYJX+0gIPjLW3Jr2MEuRQSXr4293dfx90V8djkK18A35XN7vr0LuBfpr?=
 =?us-ascii?Q?5zgH7t664bawQmaKsl/VWxri0qkfOnEmPshqpIPRvTv+FOk40p0PWFFTohD9?=
 =?us-ascii?Q?e4iT44LrJ+MvJxn2GmnipbEeeQZOlMD3mPn5zeFbx/Xp/bqa9rmfmEQVfoDV?=
 =?us-ascii?Q?42GkPh4lyRR3dXrjFvKY/XhDYdWba47GCziZrm+/v1BHPn8oun2VWjalTyW7?=
 =?us-ascii?Q?AQbTs2xFJVViCLOqEGyTBptjty4euetImjzjB1Qn1uhGVvvF5rqHRwM31HPp?=
 =?us-ascii?Q?qPUroHZ5OucC622Q6aPhuBKFPFxyCuTj0Mhr80sMBhn22O7n1G0ibF4NC6WN?=
 =?us-ascii?Q?ySARMjDeNzJo3TxSkg5/rNALg2FvcgcWIxRK1ukdiQJUTqE7MeRnSrfrr/IT?=
 =?us-ascii?Q?xKmmxRFS4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: cw29c+NEMm87peopRVUu/V9OTejk+BJkVpc6MJ2B1ZT6C4UsJWdqD4Up9Lj3gh5vVtxXX+fQwKoomT/fCmq+DJbSveWFa9WIkPiUt6VfdoWvdwBYimpSaFQgm2DkDwqRfXNh3m80xaBo1JjjfxQsoC7AhiDrL+7s2DeqlSCj2jvhPJMI4x/66SICCEXut7PQRQ6raAw1dF4ZSFyFtiCxqxZWXHKISUR4BUXR/ay0OYGJn9qmdI523n7/2rS53FYpQC5RCJYGz2Ui/VwDRsqPznqLXZ1mTQMZdqNcG8J47II+nMJ58ss4agcxPlztMRkZgTI3tzQCJyHchjhDElT+zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c01e4d4a-d0b8-4c15-89a2-08df35b00649
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:30:24.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK+kNBoJGeP+hgXSSXaRKfp9otdjEbt+8eadcCBuYzhWzSJ/eIO7Bxk8LVZJdX91P4zGru8Y4qcZ/3ij06L4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9823
X-OriginatorOrg: intel.com

An upcoming change will need to acquire a TypeC port link reference
along with an AUX power domain reference when enabling PPS VDD for the
port during an AUX transfer. Acquiring the link reference requires
holding the TypeC port lock.

To allow the PPS VDD code to take this lock itself, acquire the TypeC
port lock in the AUX transfer function only after locking PPS and
enabling VDD.

CC: stable@vger.kernel.org # 6.14+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux.c | 39 ++++++++++-----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index 394326d17e0da..63bd72e537ec3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -269,22 +269,6 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
 	for (i = 0; i < ARRAY_SIZE(ch_data); i++)
 		ch_data[i] = intel_dp->aux_ch_data_reg(intel_dp, i);
 
-	intel_digital_port_lock(encoder);
-	/*
-	 * Abort transfers on a disconnected port as required by
-	 * DP 1.4a link CTS 4.2.1.5, also avoiding the long AUX
-	 * timeouts that would otherwise happen.
-	 */
-	if (!intel_dp_is_edp(intel_dp) &&
-	    !intel_digital_port_connected_locked(&dig_port->base)) {
-		ret = -ENXIO;
-		goto out_unlock;
-	}
-
-	aux_domain = intel_aux_power_domain(dig_port);
-
-	aux_wakeref = intel_display_power_get(display, aux_domain);
-
 	/*
 	 * The PPS state needs to be locked for:
 	 * - eDP on all platforms, since AUX transfers on eDP need VDD power
@@ -307,6 +291,21 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
 	 */
 	vdd = intel_pps_vdd_on_unlocked(intel_dp);
 
+	intel_digital_port_lock(encoder);
+	/*
+	 * Abort transfers on a disconnected port as required by
+	 * DP 1.4a link CTS 4.2.1.5, also avoiding the long AUX
+	 * timeouts that would otherwise happen.
+	 */
+	if (!intel_dp_is_edp(intel_dp) &&
+	    !intel_digital_port_connected_locked(&dig_port->base)) {
+		ret = -ENXIO;
+		goto out_unlock;
+	}
+
+	aux_domain = intel_aux_power_domain(dig_port);
+	aux_wakeref = intel_display_power_get(display, aux_domain);
+
 	/*
 	 * dp aux is extremely sensitive to irq latency, hence request the
 	 * lowest possible wakeup latency and so prevent the cpu from going into
@@ -450,16 +449,16 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
 out:
 	cpu_latency_qos_update_request(&intel_dp->pm_qos, PM_QOS_DEFAULT_VALUE);
 
+	intel_display_power_put_async(display, aux_domain, aux_wakeref);
+out_unlock:
+	intel_digital_port_unlock(encoder);
+
 	if (vdd)
 		intel_pps_vdd_off_unlocked(intel_dp, false);
 
 	if (pps_wakeref)
 		intel_pps_unlock(intel_dp, pps_wakeref);
 
-	intel_display_power_put_async(display, aux_domain, aux_wakeref);
-out_unlock:
-	intel_digital_port_unlock(encoder);
-
 	return ret;
 }
 
-- 
2.49.1

