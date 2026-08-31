Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C44468C0F;
	Mon, 31 Aug 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188850; cv=fail; b=EzXFT6UQEqLrZw87niUk2Vu+bmMrUr5xTEumJoi8sQRROyApOnXACew+dUICy9m5WeII05SXBAwTRMvTw4Bm8YAfzbSuDxd2CjgiZvD39H5VPmPTE7B+Yah1ATWL9CY13avJm1/xr9+0KmTO83rqy4H6ghjMY2YqGS5FgtnOTsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188850; c=relaxed/simple;
	bh=1IRztMYyN98YPy8CKBNMfqKLHmmsJJuEtwz69UdkKw0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c487E6suFe9ODynsBAu/gbd+0YPeKNaqgVnpR+ekWy6zsJDzPOKbI7/P+tZiJYNzMUesjRfDaRq8ttX3jlebQKgwedBq3VY6yOYS1Bq7ojh8tYukudL/d9Kxn6jFHDPQCZ2h/vYYkgHa7XAeseTmPzVOLxer8YUnl9wZKamM2ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wd2NS6zV; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wd2NS6zV"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEUOWq612916;
	Mon, 31 Aug 2026 11:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=e0YpG
	u4zt9GnN8Pn96daOhbMusB+oyMc0iIE5T+ZDK4=; b=wd2NS6zVtUrJEcTuT4q0u
	tyFwZil8EITHaNRA/ypovJ9TLKmOKq9InPU0wbzUVKw88ECWXUPRrU48VZ1qnDsl
	9Fwr1duSpcBOv6uerN0hdB/2g5FKVtWnGLpdI1SWwkoZ3U4rKWJ0pQ5atUG3WcVP
	GZG22W6d25D8x0arsxZUKaZaQz9O8vXLTLvmntHZiUJG5WvTQjwjHXpulgGOJbuR
	XeTOiLo9C5GKW/QIvxT/1jOWFanfwDSc3mfOi7TyJINuiv9s1yFsoLMW7kVbiLXi
	ShRslETvNSRLW9kBkd3yWzozKYg6tgRF2kWWJJLylk9Az7ZkzdszsmMIwCqDcERs
	g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gbs68em5h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:06:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuW1jrT6kcfb3RSfcudN7Gbp4ILl26VjhHzCX6tmx65jPkMerAmOoAil1cfDqnkaM4o35t/EtPj7eTbFgHjK+zuKvXykPBsifuLqiLvjsnMwpRdBrb2+xy25MHVu+SeaV0AM8QrqKXcVTykBYpMcYTXvcPSqp4NnRSrNX8rClqNKf+qxRsVON5e59/YvZa/MtoSIQDH6k9kVo9m61lDx8JTqTEmSAt0eZvzttYuvzrJ86Io8JeDT/0U7fXn/NEkXOjDYNLyTgzMlqKCknOkqgQLWn+GA1mudRtemOWbyDShVUy3gK2E/oMhs5VrqPvWdZTGzVJkQ00DRqCOd9n9QQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0YpGu4zt9GnN8Pn96daOhbMusB+oyMc0iIE5T+ZDK4=;
 b=CK7mMWAbMIlhkMhLAHc7b8wpl3mPTEyKr29gNvNPWkjfcMzAH9thFOO9phnrGHXgOfuQiSR0r3KZ4wulLglldqJUgTsae6ZFmCGe3CKNJwlg99u7xq3YrvzwN1EZs5NBWqkw/pxTvSostPu6sCSXcEt07aPcrOn6cvmlupSQgdwISawDILcW5AFTh+hQgAINvsgu1bjvIK9mesb3MbBtWadKM+HhCORWgbAM97zL09miDOkpj3My6+tLvmRSykJcedXqXciZ6L8p7bxD8AeiNUXs4/HpV9bbtpBdDyb71Cb4LQnMB6bYFw3tlPXivlji2Acsaj+Pr3mHK4HZLvLcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH9PR03MB767167.namprd03.prod.outlook.com (2603:10b6:510:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:06:10 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:06:10 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 16:07:17 +0100
Subject: [PATCH 1/2] mtd: spinand: fix NULL pointer dereference with no ECC
 engine
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-mtd-nand-no-ecc-fixes-v1-1-c2ec46641b90@analog.com>
References: <20260831-mtd-nand-no-ecc-fixes-v1-0-c2ec46641b90@analog.com>
In-Reply-To: <20260831-mtd-nand-no-ecc-fixes-v1-0-c2ec46641b90@analog.com>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788188838; l=3587;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1IRztMYyN98YPy8CKBNMfqKLHmmsJJuEtwz69UdkKw0=;
 b=vfSltMt6baXHkrHTH5uExI7/KLEAF2RQHJBmMXOKs4gZwNbUHb3lZBe4W+QiSCibqQUn2BQ9V
 xoW7JSEK2nyCOO5dag8R85oEjNJSr0zx6mdNv9To0Z2rD5E75GB3ozI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH9PR03MB767167:EE_
X-MS-Office365-Filtering-Correlation-Id: 538511ba-302a-4060-b5cf-08df07716439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XIv4uudRKp+VzqV24WCfkbIeILIY6S8/0UgoPQ/jEfxoamYkt5WcwA83yoZs4OZ8h/Xx3PmhU3zFEoUKCSQArAnjRd9KoZ0oAJC2JoV3wCgcDmsztw6cJx3vwUUYDrxAmAmjf+NpeWiEcYr5Qud0Quk8rC+R0CI7uv2fQZSZ+rP/PN7+KnTkKNxR9g4YA21WNNEjDjLC55galI74g9twGgA6oWhx6QdCy7H8sIPhGQls7GoSS5eilfajJx6+RNjyMSfZti1P+nyQZCwc2zRmLUrTmESipYcBgNHblP9/MQT073GF+pVPFg2qgekQaIkOLPqczxaltOQQAdxD5MUSjY3DYjJTyqcB5Fj1SwYfBagnGtblnGoJ+r0Oph7nhR/BnYrV6RL+QeqNxNw5cURpdr3GDsZziqSftYjYExKEaEG3OfEV3FAPx6RP+utam2gEJy736Unk94cu4UtykYBMmdDnavjVLuTihqVxJHesiciu6jJOUqwQuQHnitj48mCEDK7iBiu+vJPpqmlqzWrMaF2tRxPlHxFMNZtf9qFD2wpE0UaD92US/9Y0lK5KYKxZnd8aX1b8cpnjhHdrA+JE3CSS4Fvuhbbv8dUEkhvMOU0IqtUzqEu3O3YZH6TulD+ylH3OGRAiTyBCh0YATM/uZEuImJK7F+/19ErrjIbsxzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qld6U3REaTdCbU9NS21hcFFGcXZ5Q2ttRFZaT1hROWhUNHl5QUZ5bVR5Njhq?=
 =?utf-8?B?SEg5TmdZOWNoeVdETm5WUlNJRTdhenZvZ2gxZWJDODZSZTRNZWh1OThqZ1dE?=
 =?utf-8?B?aFZhdkl6RVZoSXcwblBWZkdDQ3V2R1A3bU9vN002VFpxSzhTR2M2dHBJVWxB?=
 =?utf-8?B?a1lxbW5rbS9kdkZlV1lGSCtEZlFsYnFTMkxIakJZdEN1eUJMSGk3ZW1uTjhR?=
 =?utf-8?B?eTBISkdNZURZbHFiN2ZjWm5JaFh0WExyNHlPbXhYR25SWFhTZGE1WGUxQzlq?=
 =?utf-8?B?NHhSZ0cwUUwzczBXTk1SUDFhSUVPUktwN256ZEU3UHpwYW1oU2t6NGRLQ0ky?=
 =?utf-8?B?eW9CSURqQ3o2Q291eFFNMjV6bzBSb0hmbXpqUHdEUFZpQWpqd0crSi9SckJu?=
 =?utf-8?B?bjhWbnRmV3ZzS1hSUnMvc1BMWkpnK0FCYTVVWmNnellqckVLTUJFa0Zra1Jv?=
 =?utf-8?B?ZHR1MHBuckpqK0FRN0c2b1ovbFFyY1FPNGNZZXZVOFc2SzAydkxnT3BxZTN3?=
 =?utf-8?B?cG55S1A1Sis1eUJDbTFLQUxkYlFzYjFqMW1XL2plZlVzT3ZHWU8rOVB2OUtY?=
 =?utf-8?B?WEdGblF5dHZqODFHaW9LQ3lDRDZUcEtJUmZycXozR1FGNHk2YkVaY1REb0tm?=
 =?utf-8?B?Q09RRE8ydW92S1FkOWxEL0FWYzdjZ0YrMmNmWEdsK2YxZUplaENsbzZpZU1y?=
 =?utf-8?B?enhXenlxaTg1OXozVnUvRlNMWlBwYlhpVzM2ZWJnZW9IMzBEVFFLVWVKcGpY?=
 =?utf-8?B?djR2MHB1aTVFVkpGWGJHNmtMTnhoVEpab016YVNZVDM0MHkzMENaZEdsZWhq?=
 =?utf-8?B?RHdKN3pDVWN3SW5sVDRDT2MxeGhDc3l0SEJqNWZhZGlzbzlZcERzTFY3bDVw?=
 =?utf-8?B?a2dvV2dGRUlkV0M1Y2tLRTR2YlpuVjYxdUJXQi9Wd0R3Vkx4NS9QcFVpOUVv?=
 =?utf-8?B?MVlncXJCbGpKa2h4bkNpMEZZNklRYkgyS24xUTd6bktMbnRrYm1uUTZ6T3dD?=
 =?utf-8?B?K1hId0t1S1VlY04rdE5qQjdWL2gxaUxhSFdXU000eHFGazkvN1VBV2poeHZK?=
 =?utf-8?B?dFlnV2NSaEhXWWx3RlhSZmsveENnWHJ0bGo1QWRRbFpzZm91ZDhOWlJHQzNp?=
 =?utf-8?B?ZVBqVEp6VmZPVjA5Z0lHTDE3Ulh1UDhHbkozT2JYSFRyRDFYSW55QkVicUh6?=
 =?utf-8?B?dXI3dGR6cFJFS3FtN3JKZm1mSGR2ZzlPWGxoelZoaUVrNmo0Y0QxNHJZLzFy?=
 =?utf-8?B?dmwzTFBkTkpNblU1SzhGR0JacE82cXhQQmxRM3NCQXhJOGs2emVtVW0rT3Jl?=
 =?utf-8?B?ZUU0V3FoS3hKdHpwUmMrMzZnNnBiNjBRcjBHVnVqdXNqZWhpbW5SQmM3UU8r?=
 =?utf-8?B?N2EvU1ZTYlR2d29QR2Jlb3ZKN3lCR3VCKzVnKzc3bG96RTJkYnpoUVB1N1FU?=
 =?utf-8?B?VVZrVE9EZ2Jpbk5iWVVRNFZ1bGtWL0hKamN5WC9ZUXB5RDR4SWJYOEEyVHRi?=
 =?utf-8?B?eUlUWXU0UDduVndEczB3M0VxZXRxcHVheVhVMG45NHl3UUU2VklRTzRhQUpj?=
 =?utf-8?B?V2F1cUw0S1RSZEhnbFlMdG8wNWVQemZDclBnaEtSWVdwdVVCenpMOXFacHFs?=
 =?utf-8?B?amZOeUl3MzQ3MEp2Unh4aUZtckUyVmRPME4zMEpudWowazRVY3Jvdk5JYWNL?=
 =?utf-8?B?NlJiMllISlorMFBOaWtnYWNhekY4ekFSK1VGYWJvWkxmSGNMUzJ2bnNaUUpW?=
 =?utf-8?B?dG1nK1lLYzFzMnpDR0V5Rmx0S2xabjhBbmxDZmpRK1BSY2pFeDdWUHBmekRq?=
 =?utf-8?B?Y2tXMGdUMkRGcTU1T1hCT3FoZURnVlJvNWxVNUsvZm00cUh4dDlRa0lEOXg4?=
 =?utf-8?B?NmFINUkxTWxCK0RJa1Y4cmJYWFZrZEx2VEhmK0piOTFBeUhYdlA4dWloYXJR?=
 =?utf-8?B?cUtiM2tJeU1uaWxFcVpHQ1ZId2ZPd2lkVWw0OEQ3Z1RmWkdPN21GZDJYQ1d0?=
 =?utf-8?B?YnRySTNXTXppcGdBVUtqeHdVZUFQWjdURDUzdmkwTXJzdmxXRTNEUGJSOHNI?=
 =?utf-8?B?UFNvZkVkV3dmMUozT0NLYkZMNmRESGpXYnphZG81dVJlRFZ5VHE4S2lhNzFN?=
 =?utf-8?B?eWs4cWJGa0I4U1ZMTWY5bXUzUlEyVUtFckU0TDNWZkp0MXc4cWhIUWFYQXBK?=
 =?utf-8?B?TGErMUluZDJLNEgxQUZzRmlKZStPZUJtTGFuaHhpV1FVRnZwM2NOSHpncmRv?=
 =?utf-8?B?UjhLVnVCdjRuaWN6ZEc0bnBqcVBkTU9LNHp5SzhncTY3NE1TcmNMdFFhL3Rk?=
 =?utf-8?B?cllCcTVNd0E2ZHNTSFk2YjgyUC93NmtDVHhxMldCbDdEYWVDM2k5dz09?=
X-Exchange-RoutingPolicyChecked:
	u/FHN/2ubvI9gn8raClQTWBNQf85aGfLkuNVjNyoGpGPOQDzNZzt741q/qPf/940hM4CwVN6QpQ6YaagY3CYhWpYSpUlmake9oYQHpeQRG9CVS0Hh0hO4Sm/ii2tKy1RQGMxIrDQEnV2WAbvdmNCQj+FafYRzpsU2R9BpP3fZa1nQCdTtlzJtsGQAiGa+U32d7EFcpjgUiObXnodEqfGWYH1xSmyMDOnGCQU4VBRGj8rVpxkAPJB4Xt9N/Hc2e23A6w7e0yj/QHazyoTGl9OX3+NMfFMtYGt+wJ0gHIX9RPxfA81rhMnSW9hWz/qU5Mkl0HCHvOfHcJ6UjntJKXVhg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538511ba-302a-4060-b5cf-08df07716439
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:06:10.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rOu8V/KTeNiDpa0u0FWXTkRW/8ueBJL2B2ZbzW/pBxiZ5fXeEgQMDu9VgnSOZuI4V+8totrH1bORV6FDX+2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR03MB767167
X-Proofpoint-ORIG-GUID: yuGGNdYGOCkPUo5hhVv16lfTWQ4qDUIe
X-Proofpoint-GUID: yuGGNdYGOCkPUo5hhVv16lfTWQ4qDUIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX+iTPh4tMBjK+
 ImrpTzyLFqLDcd+8CbxCyXbtKsTKiU0Kfnuph7WwWeWCY65pYKFdJVi90jApHsjnBmfcp+U1Yfw
 g1yfn30dj6q6b5MmvjWZamkVQbpnX5iqSiMddC9wAZsdMgSzcvB4tIF8WelfarYXRfUGlt/lbYo
 N5COGQX7DT87sgsuX+nE52pRHGuc5iMUtQxBAdpcQRK1QR+z53ImOx/r6DOCcMSKwCiIyw6ASav
 GO7cT3qZEi7Y0ZuMfsvvX7TVMVatFI6Yvp8prrTCLgsclPZCoL3kKMC94Y5+1je57Ta+zsSagZi
 nL7fmdHZssgagYXiQ9o4Vkizk2Ya0nuc/2nwADfjWZnfoK8LjpSNxT9zJ1ECsZjS96Ny1kFh4+1
 qdhNds6Acs2gun3NVKyCfF1/PSP/Kyun9y0YmPVPYOLrrg/352I+rALm8z1cpiIZn9JlnfvKEpc
 CvfHvoOHz74ZjTaLBVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXzDIcFx5qGPPX
 cqxGKYMgKEBJ5FVmmEn361kgTkGPxFMlshsU0I7ddzbrZYEq/j6Fz0pxtcYd4mirra74tpbZfc5
 2UTjZpxvW8gqeWNbBHtZ7gb+bb7dS9oLCm7HqqRMY/QMBeaypD1X
X-Authority-Analysis: v=2.4 cv=Xcq5Co55 c=1 sm=1 tr=0 ts=6a959864 cx=c_pps
 a=85i0V4ggiSMiQM2jsTwpvQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=OXZ2oO85O3lAY8GZ5_gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

When "nand-no-ecc-engine" is set in DT, nanddev_get_ecc_engine() takes
the NAND_ECC_ENGINE_TYPE_NONE path and returns success while leaving
nand->ecc.engine NULL. The SPI-NAND code nevertheless dereferences it
unconditionally to test for a pipelined engine, so probing such a
device oopses immediately.

Rather than open-coding the test three times, add a
nand_ecc_is_pipelined() helper to the NAND core that folds the NULL
check into the integration comparison, and use it everywhere. Future
callers then cannot reintroduce the problem.

Fixes: f9d7c7265bcf ("mtd: spinand: Create direct mapping descriptors for ECC operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mtd/nand/ecc.c      | 7 +++++++
 drivers/mtd/nand/spi/core.c | 8 +++-----
 include/linux/mtd/nand.h    | 2 ++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
index 6ccdff3fc913..1d809cbd47e6 100644
--- a/drivers/mtd/nand/ecc.c
+++ b/drivers/mtd/nand/ecc.c
@@ -159,6 +159,13 @@ int nand_ecc_finish_io_req(struct nand_device *nand,
 }
 EXPORT_SYMBOL(nand_ecc_finish_io_req);
 
+bool nand_ecc_is_pipelined(const struct nand_device *nand)
+{
+	return nand->ecc.engine &&
+	       nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
+}
+EXPORT_SYMBOL(nand_ecc_is_pipelined);
+
 /* Define default OOB placement schemes for large and small page devices */
 static int nand_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
 				 struct mtd_oob_region *oobregion)
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 35365b67dd8e..03ff43445693 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -508,8 +508,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc->info.op_tmpl = &rdesc->info.primary_op_tmpl;
 
-	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
-	    req->mode != MTD_OPS_RAW)
+	if (nand_ecc_is_pipelined(nand) && req->mode != MTD_OPS_RAW)
 		rdesc->info.op_tmpl->data.ecc = true;
 	else
 		rdesc->info.op_tmpl->data.ecc = false;
@@ -603,8 +602,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 
 	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
-	    req->mode != MTD_OPS_RAW)
+	if (nand_ecc_is_pipelined(nand) && req->mode != MTD_OPS_RAW)
 		wdesc->info.op_tmpl->data.ecc = true;
 	else
 		wdesc->info.op_tmpl->data.ecc = false;
@@ -1261,7 +1259,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	struct spi_mem_dirmap_desc *desc;
 	bool enable_ecc = false, secondary_op = false;
 
-	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED)
+	if (nand_ecc_is_pipelined(nand))
 		enable_ecc = true;
 
 	if (spinand->cont_read_possible && spinand->op_templates->cont_read_cache)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 09c8c93e4dba..6936180b6ea5 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -305,6 +305,8 @@ int nand_ecc_prepare_io_req(struct nand_device *nand,
 			    struct nand_page_io_req *req);
 int nand_ecc_finish_io_req(struct nand_device *nand,
 			   struct nand_page_io_req *req);
+bool nand_ecc_is_pipelined(const struct nand_device *nand);
+
 bool nand_ecc_is_strong_enough(struct nand_device *nand);
 
 #if IS_REACHABLE(CONFIG_MTD_NAND_CORE)

-- 
2.55.0

