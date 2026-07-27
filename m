Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049662EDD6B;
	Mon, 27 Jul 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162022; cv=fail; b=L7EDmDHmsgeXDyxAVOkG92RTdJcUMaFoDlxzmFF7EWuICA6v/vgncY4FfkNiqxv7eoBcZbVh4I61SQTmI8fWj1pdujmxh1uyrN5iuvwfkF2bJkekgP4g3yti6uG8PrUOHCljnj+UJS2QvE7n3vDB0spn5EiF4VVjHER+tZPKskE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162022; c=relaxed/simple;
	bh=rI+m1DpY5NtLQvxM5vdLbPCkaS3oMAXZ60iymoIOzro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/q8TwjZB+lGj7rUpCuucZPObpw2reEHypgPujhPPOpXsCPAg7CLl2kbjMAdgxwE/FCMEYVKgE2zizg4WiBchCd2QyELZYxa2dhZZfk7GwlzqcCiHnqrFVPY9C6jXXOaVrSw/Z+kPYWSn1HhXxVIzoWhBzI5Eeu6vsco2Tw8bZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QgW8t/rc; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QgW8t/rc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4qDxmRCDyOp4odGvZutM+V50U9fYBg/rXXJct+PiBC/OAZXEZ3H2sLXKVdbTXpMEL0QzVFqhyunLGeAvw0jPOd8FrPFGkLB1VcLVBWtXG16TDAC6hVcAhivyjqk0ZStTtDWJodZb3vfupqnDywSYZ363poEjG4hjT7SpBJRHas9/SyMj7KIZHODt1wkYOy17lVZq7WgM5+A0PK0ulGdLSXMrZ18fan/II0ewvoEBBhMhTvNPnSCxAP7v0b8zZkUF9scosQ0LR3/tMJ5guRSR5n3Dd4VDVYcA5JNpmvJGQvw8TSOqU0PmPfgW2jD+DXvswgfRvTgAkgAXf9H3938dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPszo4t5s5hvBz8+kvxdko8yfSKLDumvMRmMl6QmYes=;
 b=EeTPyxVEpNE6Mus/24nceG8sEaA0DAqnL23pWcnQWZJwNgE12dXuAw+q7rnDT3V+v4Hj1R6hKIqxhxjuqiayPPu2e4g2lOsb+8FLB/OL8ZSWnmmjQYWQVBXcDE4ZTgwaZnHO/IKv57IlltP8joJVHAOo6H00wC1N9kjdT0dxGiAHJvClG5YHg7g9Ck5YTtx1D0Rowa+HG8KSvhJbCqPSjIt/SJKaE79XDo3tG7B4zNZbRgjUH7iEwIu2HtK7V3e25kke0nhGwaKYiOITqcElBVhBqT1pMYlPsyg1Jfrd8s0F1XR2k8II0Ff3vV3yKDW7U3mp9ml3/j0aaphQG57gkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPszo4t5s5hvBz8+kvxdko8yfSKLDumvMRmMl6QmYes=;
 b=QgW8t/rc/nweT3gbM5f0RDAuU/CJtt5cPKrURkWZucXj/T+LlDGygt9vCWZVqE7fvRI5ZHp+u+px96nqHY64D3HRMmfUTOBmdrl3NeUXEL+Wa8qE2I+x8ArPXGfObWgHZ9lwmLnozX21tmUaaTFcFyriLI4RX65xruPSOBWztiJQjWbEl8acPGQSDBnpvWLWkmQnW/RfjNXCsULHEZCc0sQ6l8w5ZTTWLKNfZ8toRnO3Tw494D2iw4tEY9Dsiblu6euEms2RuUePzB8okjNuA2oi7SWYyCm7aqRk0s8iyehG3R0n71ILD/HPWv43Lg3kpAJ4GUzoIWes7DVE1YXWEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11538.eurprd04.prod.outlook.com (2603:10a6:800:2ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:20:18 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:20:17 +0000
From: Frank.Li@oss.nxp.com
To: mirela.rabulea@nxp.com,
	mchehab@kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Cc: Frank Li <Frank.Li@nxp.com>,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: imx-jpeg: finish the job on device_run() error paths
Date: Mon, 27 Jul 2026 10:20:10 -0400
Message-ID: <178516199439.2421069.16061546765189005821.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624003208.12400-1-fanwu01@zju.edu.cn>
References: <20260624003208.12400-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:806:121::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11538:EE_
X-MS-Office365-Filtering-Correlation-Id: 891b4273-6e23-42b7-0e14-08deebea2edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ko/HYBYWVgVpCxQZ8gNG3uv2VQqaLIWEPqfrloPZZWgx0pa3vvAy2tfr3khHQnML/kSaamVByXaF8RfdwCxr4qyIN23jfp725SrWnbtpgUiceuFg62yP/38Z4QkY72zCV3Aac/aiqxFhu9sL1zPOcaCz0gKG42u511sYTjW0sjEyRIiQlnik7y4wd9Y6dVPODY7VnLnZl3Y7c0HBG5b9MojEdCXriP5BsuJNCGFQsvpMzlBP6jRbbpr65PI9I88hnKA4CKygfyY5cpzHHoNiJvIW5NiYTZPbFE4PQarhdi5oosf0EmvAgfXEwo9uTCC4dpGDOcYr2xBc5f8lUfMUxroXE75pVEx2icFg1NES07FvYlUSUqo4bJIoAgI6ltibll63hZDZ1yygEsG/EwS1TTSgm1mGo2jxidbgW+6p0i1tKTx+wnMyG9SmBz10lpCzgx/h1G9lpochR6G6VDYx44C/MNhnRtiwTIKSMr9EK8uc8ZNUIIARDHSCGnFkdvPvUw0pSswWckryBvDAEb7E7+7viI7jY1cKcGqoRG0jT8i4/JSwI3l1L4Xprs4qUvAw2O4g9WLemCZhmgrHsuSLuQk/SvzFmBTu4oHkgkYZt5EzZbNRgvJr8Q6xNA/TQpNw9g5+iojSkKczU6MV2cdhCh4DXd6M/iXQMPKKEQaMg04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1JTMFhqdEdST3Y2dW5UWjEwdEpvdlZNc1k5OWxJcFkvREgzdUN1OXcrL3px?=
 =?utf-8?B?amVrb0pQY1dtRGpBT1A3NVNzZ1NQT1ZKb2hFQmZ0d1JMaExxakthQ0I5bG9n?=
 =?utf-8?B?Qm1jODMvZnNxMGJyaGovVGMyN0toQU5pSyszYXpLalJzVmhOMjZUTE1KOStz?=
 =?utf-8?B?dUFzcXpINDRKUVJ4akg4ZS9mZ0FMSk00Q2w4K2tsVnJFaGZBYTVaT01CbUtK?=
 =?utf-8?B?ZkJubTkwc0FaRWdlNmJmNFc2MDR3SkZkKzBTN2p6TlZ1Ti9NUWQrTjdsUG5Z?=
 =?utf-8?B?eEVlZU5jYXVaMXAwOHJrRHhmNHE0UTlXSlJOaHNGdUd1N2Q2L1hKb25lMXlI?=
 =?utf-8?B?VC9ZQnBadXplQlFUY0RNdEhHRmNndzNDL1FtQnVYTjlxdnhzZUgxeEJwd3dw?=
 =?utf-8?B?RVNjWnU4cWx6QzRWYnFrUkVZZmxYMkxkQW4wOGxVR1E1cWx1ckhjQ3RrTUx2?=
 =?utf-8?B?Tnd6ckNCMlZwS09hTTRkZEZGaE0yWVQydDlwdVVrZEwrVWhoZ3RLWTIzSExt?=
 =?utf-8?B?MFF2NTc3eWFnTys4Si9yWWZCZDJyWkZsY012dEZOWWE2Y2dhb3UxNjkzRWIr?=
 =?utf-8?B?WjVBR253WlZQdDhFUWpxTlBLckxxOWVQRFhWN3BHVlAxR0pla2dtSTltc1Fw?=
 =?utf-8?B?dlRaYXZXY1hXYjBod0d2VUc1cFJXWEZqZWRWbkpESWZKV3JrM3YrSUNkSjI2?=
 =?utf-8?B?MXdUV2k2V2FDd0dVQUZ2ME1nUTFQeHEvQjZpU1pEQ21IUTEwQmJwQk9GZTAv?=
 =?utf-8?B?U0VleEc0VWkyb2k2bXZkQU9CazZmVXNnR2dsY1BlZ3VaYTl3UDZDb3ZOVTJu?=
 =?utf-8?B?UWdTZXR3ZFA0TG95b09lSjdXQmhKUEFGOGttVVVqRUdGY3cxT3QxRmhvZGRD?=
 =?utf-8?B?Z1hHaG1MU243S2JheDg3VVB3RElxRkxaMDJVMkwyYkhNd2NweXQxV1Bianls?=
 =?utf-8?B?K3ZqVWRtZ3NFSkJSNi9pdHRpczd2cGVJaHZ5MzZOb2JtTGQwTEl0M3hBQnFr?=
 =?utf-8?B?Y0VnUSt0aDg2STlGendhbmlkTlFTQS9Pd0trSGpxTEFVbmltbjN2TXJhalhh?=
 =?utf-8?B?ZXVzeWtCclBCaHhyMVBoaGIvWEVjTCt3aTllK0RBYnNXc3NHNnRxcG1wYjdj?=
 =?utf-8?B?dlNWZWZaNmNkK01kZFZkL2J4YjQrU3hYRExBcVNkY1VqanUwOVBpOEY4K29r?=
 =?utf-8?B?eDNMbXZGenRDclZoSlh0bVhwM1MzaG0vazFnR1J1TFRHZGU3Vk9CeUxBbzVh?=
 =?utf-8?B?Q0NtWk8vUVNySXpLbG9LdWVDdEh5aXI4cE5CMHNqTi9wZnZnckp3NEF5NkZr?=
 =?utf-8?B?dHVNT1RzSkhGMm1oMElyakdCVjV1WlZjelhMa3BraVRseGNBSFRGTzdRK0xq?=
 =?utf-8?B?c2xJQ29pT0NxRVBNVmlXV2pEOVRDcUd3SHRRc3N1VFhxQjd6b3JCOWNuQ05r?=
 =?utf-8?B?ZklFU0VpSzVLajFzajdFdys2R0IxL1cvblFwOVlMYmlYRW16akI3UC9WMXN0?=
 =?utf-8?B?YzVHQUdHYVdMQVA3MmxTbWtLQ1N3d01HMndrcE9PdUhKN1FmYWhScDdKVlpE?=
 =?utf-8?B?cmRRYUJSQjJ0RjFBdWZ5KzE4QjBHWUtkaEJZOVlPVzIydlB0SWZRMi9peEN6?=
 =?utf-8?B?MVFrSlV0TkFyZllVUHRpaUQ0TkZqa3JsUEJweDdxdFVPYnNYL0QrSUZaeWhv?=
 =?utf-8?B?K0hKVldtYk0zVnh3UmhIK2ZKSGdnc3EzMDRqTDB3UGpoS2luU283R3JlNkhz?=
 =?utf-8?B?TnpIQ01ETkwwb2RPZ0wwZjNUazFUQXdwc2VnaDdsa2Jrd0tGdWRaQ3lLNjNE?=
 =?utf-8?B?eGhzM0RRUjB4bC9XMzZRRUtuSWNKTm9CWlJWQzZxODRmK2dIYXFsa3Q0UHl6?=
 =?utf-8?B?RG9xcjRNR09ZSGFTMEszaFVWN21hbm0wcmgxS1NiYjNMZXI1ejBuVnYvTk5n?=
 =?utf-8?B?OHZveS9tWEJJVG5Oajd6K2hMNjNaWlNzaUdmc09TZkllekVvSWc1S2s4aUVV?=
 =?utf-8?B?dC8xNldPUy85VHd4aTcvbE9ZejlMQnQrQlRQK1VjYlRaQzZtWVBKNGI1SU1M?=
 =?utf-8?B?QThmb0RVVUVsWHVtV2FnMFp0bXZZK3Z6TExkbE9KZjdMVFdvQWg1VlprS29h?=
 =?utf-8?B?aGsxMnVENUZvbjAxaTJuMFdzU1diK2Zva1dwVVI0YW4wSWZ6TGNjR2xpUjBz?=
 =?utf-8?B?NW9FSmtweUtRNGU1UWYwM1VXKzY5c21vTSs4Q2dna2kwa2VxeUFzb0xKQWNt?=
 =?utf-8?B?c3BUd0xSaDhpdkp3VWE1bnQ2Uk02dGY2YVVWOEMzTjYvRzNkRlo0RWNjN21z?=
 =?utf-8?B?S3kwWlhWQWtUSHh4NUk2YWsrM0FBdmNYRnppZEhCRHd5RHlhQnJpdUh1aDNX?=
 =?utf-8?Q?Q7rmYcW4Q21vzMt4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891b4273-6e23-42b7-0e14-08deebea2edd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:20:17.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FnBthADLkJRyXR8wbQdcq7LnHafik7cfQ8VsP/DN9HT+kE2TJS18u2awjO1sr8nqx/gjbZC81lx7jdPWOSTop2c/4aqOjCQWHPnFjRB3T9NYy5VjH57AK115rYmQHyq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11538

From: Frank Li <Frank.Li@nxp.com>


On Wed, 24 Jun 2026 00:32:08 +0000, Fan Wu wrote:
> mxc_jpeg_device_run() returns early through a shared "end" label on several
> error paths (no free slot, mxc_jpeg_alloc_slot_data() failure, or missing
> buffers or queue data), and none of them calls v4l2_m2m_job_finish().
> Since the delayed work is queued only after the hardware is started, those
> paths neither finish the job directly nor queue timeout work that could
> finish it later. The job is left with TRANS_RUNNING set, so the
> wait_event() in v4l2_m2m_cancel_job() (reached from v4l2_m2m_ctx_release()
> at close) waits indefinitely and the close hangs.
> 
> [...]

Applied, thanks!

[1/1] media: imx-jpeg: finish the job on device_run() error paths
      commit: 84cf16d021a20ff35ec50833af531deabea71992

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
