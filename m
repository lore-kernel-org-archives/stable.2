Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795110099;
	b=hG9UNYAPhaCL9llnutX7UYMGWRdgmQid+syNRWYOvJvYVTESytAXYu4cJijV3x+D44jT
	 FZ7gthVCI9yZ3VrVh3dH8eMBKhkBMCkFDVadJUnddntHB34i/ZhI+XnQUqOW1U0s9HG+5
	 O2EchpsjchPr2hLhUEkz3YgrKEVyp3TzJI2E/CIoekoJ6nyNQ/Q4xfZbgazXrqjJkJBC2
	 q16q/ptX0F4xfwc5R6Dg8FbuCiNbx83TDY6MqgNmeCQsmE8wGdmJF/jtoOkxTDkQrCQZc
	 lbBUrqCmMwANEqNUpGidYBhJAe/8ik+4AOGdPxR0EMmtTlT2kYVJpy8OUQ7EwmDjv4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110099;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ruYbthRTvOfzuCWX/nYqiJHOMoqZiRsKgSncSWNmiCs=;
	b=dEh2Lmj5101IkOiFgw3gev9plD+XUmxtm5C9UtFXjFzkkU15xe/kVbvtdDx8uiBpdwZU
	 zCEMizVxhW7qWBXxxnU/+iSD+BepkydT/AZEy2rmvi6YAB7oROMj8tVhzz9fY6dOR45Si
	 OxeUoMaghaBLMD0y9cCN1gZ8aYbFyPjCLlSr6JwcZxfMKjYgw4m3FS6W9fLUl5jg4cZZw
	 +MkocUbMahGiKlzaJi5WH7vVy/gLdRzOAcDKYSNTwoEZaB2l79rYwyov91dF+Ze2fY0L9
	 T4BI48GUkes5vtAIRdpuPzF3mjWsEhExyPpH0B8v32GN+JPMXOV+3UBdcgWHw68uEvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=i2tMmyGQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56918606A32A;
	Thu, 19 Nov 2026 17:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56918606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=i2tMmyGQ
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF90bK2219779;
	Thu, 19 Nov 2026 17:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ruYbthRTv
	OfzuCWX/nYqiJHOMoqZiRsKgSncSWNmiCs=; b=i2tMmyGQ7Anz/8nxWIaYLKxZA
	wuJIcvMY86gctaJowgSrAvY2fGPxms22o7qtJJ42DEenz2i/inNH4M2pWPJa1gcq
	jAuOJQD3IWyrcQYePCLcNxqxztUFhH68OfW8FwUpz6hMojvBK+aRoBwSzD6IPb7u
	HV0fWVs0EsirHPHXautUlT/o3jWoob04FOrwwjEXAQ6ztfbaznEkx5qqeVxN1HtL
	tZb8Hw3cUuidLQg95xE/1Hq3x5w64EHa/8z7flNS7X0cFPXnlNzrZ2HgwRpn1v+l
	Mj1+1bjzmOg/doIpX93WvRtH5e1v72bfpdjQxl1KQWfovWsPIls53J1tiFT+w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020073.outbound.protection.outlook.com [52.101.56.73])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvkengg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 17:40:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ1MmR/ow7sZpUoRmovDY04NftVjvz6Rbyl2PtMO+ZuRrnq8hrFowUINF7SQ4P1o8J/zIGrXtr6S6WUBnOca+/B2dlODtOH6P4uGeRReFXyaRJZqdg3g8rnXN+CBIFatGGyg8SExdRWIj73aRBeeSI6TVCtV87Y67e5BMsnlbfghUL6QDy5EaHY0Fca32IuYwWl/WtI18DBvX3BBLPR0qei73hBUy/B1ebxjE3NHuuY2ymZEbHaqS+E8t198D6AHVRa//8QGjHYFAYk1aJoN2zRXhqO0IwZaRTBu4lslWOWjlwQ9N8/IhjrsOsHXuhQxvHeQ76iqnsIbnOXSsrCpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruYbthRTvOfzuCWX/nYqiJHOMoqZiRsKgSncSWNmiCs=;
 b=bCpNKnXOOd8w3dlgCq/6T+veVBJqkGwWth5trOc4/Z0qzrxQASAiClHM19O3GQVuEtmli6B074lNDUBPSgvzdogtYXNQXtO0gEEKsEV0S6dzoKiX45oqiN9nxsE+FDpiWVEf/YZouVXfJTXvKhV43wYfgYotSjg9C7yzPfO+mbiyvIHpEVhgScY+YX29Nhlffb/l6/XLgjatNW6bu1D83XsKVOrw6gSsSIQiypdpXkUPD9gEnwY8UTRptIVEgqWpwHgzgvMMnzPbOhXuQrUkm8pq1QH8aM/dPoD5++n5r3qvvjRZoQatkDmimToQbgK0FqxoxOtB9xj4TTNefczJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA1PR11MB9825.namprd11.prod.outlook.com (2603:10b6:806:4d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:40:47 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:40:47 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v9 0/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Thu, 19 Nov 2026 19:40:19 +0200
Message-ID: <20261119174020.54399-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0276.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::42) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA1PR11MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: f95accad-eb44-4a61-f3e5-08df46643d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|38350700014|10067099003|261028144727099003|11063799006|56012099006|5023799004|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|20052099010|261009223027099003|18002099003|6133799003|261009221227099003;
X-Microsoft-Antispam-Message-Info:
	sPUhEBl0OXuGCHWBue6MsAjG8aXilg2MupiWJXqF/uwnfpRZD9iIUDDaBDU+sdyujfw2EfB+cWrvL3dvL73R3n0OrP9y60n1oWZMA3uhrsZ87Nhr6X/Bd5XD5HWVnM6vmjGyfRhiRxpXnH7xZGwsVjURayD3MACu0ZpH0xy0XiZ8h0jOdlziN8sKUFKHBIHhfSEd7v1ccFEKFJdWjQ+080vfgGZo+k1Oi6/J0qDSQ88XWsmIwaex6igrkn6rtBkXam/ZSi4RdcHKsPZBU0X0hCMMQmDAcWMT6m6maqoOA5CvNcSfj7+Ex0nMOZCi8AxVgGIlqzC7Y/TSrkudpxm7VgPDrZ6EYTJoO/upds0LhlPYWjDzZsLiwStvPz/Im8MRkmA/HVOqnp0KYkoGpSQX0rvEFtC6UHXLGm4QFKcl9eepyhTTpHpQ8ZNEFX52DpdTpGB4/aYMM8/JRsQHtBtFLD71yBlU9AeNKjWLxinMAF5GFCc6ESOrcR619jCJccY8ltz47U34t7zJIeI8WtJwM6UXXk8gl7A7MgJgKm9dBBebcblvuQdFCJSOXMN9PJgsK1tp9uwFaMr2jjdob5YYhcvtXmYnNZnWWm90Smevip70dDwBHkGSRyqysc86YZojCWgDKik/LMDrljuOlDVaYyNaY10cUL19ZDWJ0vL4eBs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(10067099003)(261028144727099003)(11063799006)(56012099006)(5023799004)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(20052099010)(261009223027099003)(18002099003)(6133799003)(261009221227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1G8dKyqHl64DR3uYJVyjMUkU/Rd0s4ZFZEn/WRgAdeN+8dCrpjfYRgm1zFjQ?=
 =?us-ascii?Q?yCHk32HlX83OVl1EkKehM8+KtPB7c/jL+tilqK3r3LFUPNG3whZjg/8Nj3UV?=
 =?us-ascii?Q?xtrODWh5wO6+jSknPKtQTJZA+o2eq9Wkx6YpX7LFeEIm2X0wkgbYpmILUwtG?=
 =?us-ascii?Q?r1fdN1UlB/cpWIZJPc3eNgzgCOpdmuGSjpDXr3GyNjfMNM5E3gAWL6flK9Lx?=
 =?us-ascii?Q?djbLqu3JvdjBiSdMIf+VE1+0xvbBDlQunER+6ImEvzYpvcYh4xzcA872C26S?=
 =?us-ascii?Q?waB/2U2clWp3YLjW1zlvzR1EZPLwEbd0MYMVGUEAFsBTZdNrwW/cqtc7uj5F?=
 =?us-ascii?Q?ePEdZA8jNrtuDjKOjSK0fHHF2FhM7aeRjOUabiCCEWqQh43zu6ebkrz9uyE7?=
 =?us-ascii?Q?HRHgBc2cApG2a7TkzvBRM9g4ycT+JHimRgzZZDSKL9ZT/Z42FOKFCd6nAxz0?=
 =?us-ascii?Q?uhoJZkccsatPjsbPxBr91KJ1v0grkf4r4UtJmdeLLjlwLAzFVvPuQWNlJTez?=
 =?us-ascii?Q?PwN5OhP92e6ZgeqhHcThVtBuLarX0q5/UHhVl4mVNLBsuU/5mYE4od/tiMa/?=
 =?us-ascii?Q?SeZcm0SdfzeuB/Xh5BY/Ev1oM/7oojNc65gK0EFyt94xgvf/J7YNnZJxDLj9?=
 =?us-ascii?Q?zaQyPWbgh3XWfjdh3BlYD1aCU3zg9RhG6VedLHV2XsokWSg2+uwwIChwkrLZ?=
 =?us-ascii?Q?fJJoKczaOFyVodLfP6ymj1Atkz4ePHHkH3PwzHnHAUy3AbRRekbE2iUo2cK+?=
 =?us-ascii?Q?ybm9r1TnILLNnlnZnWryGU3rDFiT0iODdrWB4p5G6LfiXToDKU1cX1KPQewk?=
 =?us-ascii?Q?uSiJC5+oTYMbPzx9VpAx0gk8pTRAFSKpixxmB3f5zu7R0B9cRfsJk7G3XT/j?=
 =?us-ascii?Q?Fn9DVfHZ7Zrv1Q/j1LGVhlCVfdmSmi8C4ngxTBhG3ydrpJIr9mS9LSlovDoN?=
 =?us-ascii?Q?js6cRgKoeiGKPHFgzUqSGYrHUavvXWuS+zw7vF1JecfYm+lHsOlAXaCEm3KL?=
 =?us-ascii?Q?L2n3SYgGjlIPTQAJ0NV38wdC+2gv6regNrDKW8VmRgfSNvsE2H3zFxZRu62/?=
 =?us-ascii?Q?fUcUATogDdD0JppdUTuHGA3/4PQfp9AYb1zlgj8WASr4DZLubNmFw+HOknee?=
 =?us-ascii?Q?bk5avlqUH+tE0DiwZw6FYTBVbJ6V+XrektR24U3CZyvWRjbWE51jveI0QjtX?=
 =?us-ascii?Q?OShxWyFBDomXguUjjoKUvsYXWByvEvaCy8FIg0daEjJOXljoei/ISC0MUIvF?=
 =?us-ascii?Q?CXEEMFWHG6PNRiQ4dL1C0J+6SiBI9PMMxKL9Ft6L24d3ihdCKdKwHVTyw+lQ?=
 =?us-ascii?Q?2bHAVucrD13NTPw3E0ZMQxvJNnopS0JagGUQtrOi7fgIN3gBJbANPVOMsjz7?=
 =?us-ascii?Q?Fx74ZT4Ao5iW5kakpIa/QpZQS5jJchye8vGd2/MLeSV8tDtmBQl4KMP2ATAv?=
 =?us-ascii?Q?RUGLTDqAADxNNiqAzTWShDzWiQ2MMJQhmfm7IT/WtyvLBUXK5DCH6AwpVGTM?=
 =?us-ascii?Q?OQMwLUFALERC8CGOFM0mSWMHLeGLrXvAlmBcltiMuKSEOQOJluYW9mXgrBlB?=
 =?us-ascii?Q?nlrbRYCna5sQ6/144692YZHh8Atv3GKGnj/yBLpHNjj+4mxE9aINuI27PmGO?=
 =?us-ascii?Q?GCxyLEnemUIJP5J9FU2Hz7BiO8VhWhJmPO+OgSHsNgQxfBNJWHbG8EOO+tMU?=
 =?us-ascii?Q?ms+oL7Q8oi1EkkmqVTfoeSHgauRt9N/BBt+NcMAXLi87IgbSyTHBIWeLL/kF?=
 =?us-ascii?Q?M/MJZ1nko5b9J7R1/7ipSQ1lfvQA/F4=3D?=
X-Exchange-RoutingPolicyChecked:
	DOddFbESjp2Tqr1qwRXLmZ1SwAvX7eUycvLlHe0XTkJ/z7Xu7qwoLNJspPsJHYkD4UZX+gmTWh3Q76toNhy8O8/pCr08rAc563zmPw06fnkXEg5LtTrhMxeN9f8dXusNwrF3Bm9W1shZ2D/FwsW9n958f2KRE7HEHGNxdoxWaA2gl9PloSBceReMBP7FKBq0X7V5vXfe3hHUCX9xJOOaSfiPE5Vt67l8kmwRvOtpePV+tB8hLcbIoqQOimtluB6pO3RnoItZVe/HlKioDd0v1amLA1KnTBFyxOgTLRH9ruub8/763SsfYbgyZH1wb5ZN5hO76iGG5rkpAQvfQdPOWw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95accad-eb44-4a61-f3e5-08df46643d91
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:40:46.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHqyrmnqOuGGdWhcOU/1kRyggwupLABDK7mfFQnLYMSY4g57CpJGAzOv5cxg4SwL8rEg2x9Q9vD5gqbmZJ0jZeBSXvDDsTpz9uuyeZzC9vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9825
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfXx9ESVpNREmKL
 1efMiBYkng4l8bmi4Z2/StNAhBDTfiGVYATdNvX1e6uZMEd1wd2nuJ2/ptOg3KhQXretAvYBvil
 MAx3LSPHRp/kObW7J0NProvSEc6m4CJpzU1DFWSviRccL6ZaovJM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfXxePusT3VmcEM
 7Xaph+egcqTF9vYjb06UEGhPVrrl7BBMUP9nFuZDhPC80DTq4nCRp0UQmiG8ljuoIUnZL6YNtRs
 43n/OXPCRG1/oaXZJP7LtCNNUwjN20dVVRNcruS00fTZ5Nxs0F1YnsK5lzzpd7oOXYu644QWKkh
 LK2lb8Pt+GXjsAbvIN7kgSwl/yYv9i1I3Ysc69xBKYQPX8ZgX7fBkHqctE+duptfwIKNJkLixMv
 3TTjvt6cCKekOKkFZlIUT0QKsmtdgp8JHOhGiRiWkJKy1VloMP6MwFt/KxLP2sdHRM2jWCPbxQs
 vpa03RRV6eRPPIt3EYn4tlnVX1XcEhkey8rNFdM3kfGZpkFEzhl5pAkLp4Zr5wYAEYzXIF0rVl0
 DXAjV3eM3PV8aSrondLqetW4Pw8+hkvb11nHzYEIjB/VTbWTckas7mFtb0W8/fbUEsTXIwUnXNn
 dUzV+jlwvW32ioxkXUQ==
X-Authority-Analysis: v=2.4 cv=OdYNnRTY c=1 sm=1 tr=0 ts=6aff34a2 cx=c_pps
 a=jbJ28DYoiqYHDHWWOYDcbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=sF3i1FnlEJIwcltGWqUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 2V9JaaZvGMTVxqThs1SX83Ozt4cyzbPg
X-Proofpoint-GUID: 2V9JaaZvGMTVxqThs1SX83Ozt4cyzbPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190070

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Jens,

This is v9 of the fix for the PREEMPT_RT performance regression caused by
commit 6bda857bcbb86 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Changes since v8 (Jul 9):
- No code changes. Rebased on linux-next (next-20261118); the patch
  applies cleanly and builds without new warnings (W=1) with and without
  PREEMPT_RT.
- Re-checked the users of the quiesce state in next-20261118. Nothing
  outside the patch references QUEUE_FLAG_QUIESCED or q->quiesce_depth
  any more. blk_queue_quiesced() has eight callers, all lockless reads:
    block/blk-mq-sched.c  blk_mq_sched_dispatch_requests()
    block/blk-mq.c        blk_mq_rq_inflight(), blk_mq_hw_queue_need_run(),
                          blk_mq_try_issue_directly(),
                          blk_mq_request_issue_directly(),
                          __blk_mq_flush_list()
    drivers/block/ublk_drv.c  ublk_wait_tagset_rqs_idle() (WARN_ON_ONCE)
    drivers/mmc/core/queue.c  mmc_cleanup_queue()
  They keep the same meaning (at least one quiesce in effect), now as an
  atomic_read() of quiesce_depth instead of test_bit() on the removed
  flag. All of them pass a non-const struct request_queue *, so the
  switch from a macro to a static inline is fine; the affected objects
  (blk-mq, blk-mq-sched, blk-mq-debugfs, blk-core, ublk_drv, mmc queue)
  were build-tested.
- Kept the Assisted-by: trailer from v8 (Claude:claude-opus-4-8,
  checkpatch), in the AGENT:MODEL [TOOLS] form used in mainline. Claude
  also helped with this rebase: re-checking the quiesce state users above
  and the wording of this cover letter. checkpatch in next-20261118
  reports the trailer as a non-standard signature; that seems to be a
  checkpatch gap, since the same form is already in mainline. I reviewed
  and tested everything and I'm responsible for the submission.
- Kept the Reviewed-by tags from Sebastian and Bart.

The problem: on PREEMPT_RT, the spinlock_t q->queue_lock that commit
6bda857bcbb86 added to blk_mq_run_hw_queue() converts to a sleeping
rt_mutex. blk_mq_run_hw_queue() runs from every MSI-X IRQ thread and hits
that lock on the common "nothing pending" path, so all IRQ threads
serialise and go to D-state. On a Broadcom/LSI MegaRAID 12GSAS/PCIe
Secure SAS39xx (megaraid_sas, 128 MSI-X vectors, 120 hw queues),
throughput drops from 640 MB/s to 153 MB/s.

The fix takes the memory-barrier alternative and folds the quiesce
indicator into quiesce_depth itself: quiesce_depth becomes atomic_t,
QUEUE_FLAG_QUIESCED goes away, and no lock is left on the dispatch hot
path.

checkpatch reports "memory barrier without comment" for the smp_mb() in
blk_mq_run_hw_queue(). In the resulting code the block comment is directly
above it; checkpatch only misses it because the removed
spin_lock_irqsave() line sits between the comment and the barrier in the
diff.

Is there anything else needed for this to go in? Happy to rework it if
you'd prefer a different approach.

v8: https://lore.kernel.org/lkml/20260709063803.23538-1-ionut.nechita@windriver.com/
v7: https://lore.kernel.org/linux-block/20260512062815.10815-1-ionut.nechita@windriver.com/

Thanks,
Ionut

Ionut Nechita (1):
  block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention
    on RT

 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 69 ++++++++++++++++++++++++++----------------
 include/linux/blkdev.h |  9 ++++--
 4 files changed, 50 insertions(+), 30 deletions(-)


base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
-- 
2.55.0

