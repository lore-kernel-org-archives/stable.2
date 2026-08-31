Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07B5237BC;
	Mon, 31 Aug 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188843; cv=fail; b=VjkjorRz04twNHJbYZEcRTlQO+y12SXgYTwHu/DKVfL7tuuV5ahIwpiKXXikgzZeDpsykhbt4xyICTpuPlQApsP5yQ49anGEYC4rcukOaQRXciC+IDEJJcnVu0c9G5997QD7RHjrwib7RAowM+8ZsDXbziqDBJQ6VjzhvzpTR7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188843; c=relaxed/simple;
	bh=gA+l5FDOovbSd11Htbo8nrLzS0wir3LEAHj+cfe2MFA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ZTA7Nahnetsr8r1YmmpgoOaScfJy3g+g5yXiRH3Kq6Rx50SxhjvsYKkObALF5DJLP4DqZRECPlVZW3DfrFKg2BYyZAbWRrx3IoW11f8AcAUjktjxhoscYu2TCJmd4/N7ioCIjy+0S3f7Ih8cagUlSZLfSsY3GTVGKWbi5XfARj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KOltG5ql; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KOltG5ql"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEXnVD1382603;
	Mon, 31 Aug 2026 11:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GvZ0rBa4nVAHKTfC+q/WZ3yov9m
	wWnqsIhp4sPw35I8=; b=KOltG5qlBG17ykO0J5GzFik+4sqzWyx+p6bR3R/7CxH
	N+BFsk3d3yFnzqYPzDVN+BtMpm2z1w86DvNvYN0cTS7h7YCTy22u8tQlEmL3a/B9
	aJwZ+700xCy6Vh5BgqQ2LZsViutJW9r00znWCUNkjpMVrFZ8wDobl15pEC2A2lEw
	sBO9SnWHPn3cfdiYjpTvdp4zv1DhTVc96qvnoYj/MDuPVkkHR+Q4NkDOv12POWC5
	YipOdEgbIDkQ3EAwTh4suOCgEDJcf+om81PoRwpkK55i309WE6HZnehv+Gb7BBZt
	e+atXVx0ixHRZ+TwkQClwSzVkAKR76hrzil2FBXfMjA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbvb2qyan-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:06:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNnJsLDMePaihBhfEeRzcw9PECKtnjLPQtmGGqGMX4vEiblnh0lHMDMc/vMt1LY8mVRPDF+677y9BN00BafyTQ1s4An7WoaYnSZQCDz1WJAm5MCn912xJnMwj7VpT8vKtyCY9riNFHt5rbTG3RbX8mrQpRawFwINDnScVKA2xA82Dx0pB3+1AJ5X10HA62u5ILN+J9hN4QyvLjq+JmHBd4pEXLZYqEZ0yro3AzjosDiXcrxgdxBdgIoaOgwE9CZfjhKSxYPTGxOjNWg3PKCNn8ap7jnQLJwY2xj3T90dxYKxJ0AoKSb9SdJJGp53cWX7mRjfwh616guj3c1vu4bh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvZ0rBa4nVAHKTfC+q/WZ3yov9mwWnqsIhp4sPw35I8=;
 b=IryWAb8oI39bfeqnR2ctuFlJ4h7+GIWiBbDp8IqSfmanxwYuE5h76XWbtekVfFwiZYUgSfAdZ99EBHQwAKIvTmDqC6jijGkdLRL97PKbD3bTRU0DlIwEpWhI0v4kfr0+RE7vQ9nLoxYuFjvQqawnjeTbDO6hz4ZiPF/Zm1edVGJZ8veH512cgGqtd/nhbBd7g5c9nqQ1UA8cCKDCgbChpiSP391fUY0N0sajHb59rA7lWuvqMSc7l51hUqCrTRNG0WW/qPEQC4kFt/5Xq7Xa/GXkCfPFE5RY7Fo/7hGkzSjAMS9pDVPmksGzjbko8gngylu/jUEpWboio0aAlFtBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH9PR03MB767167.namprd03.prod.outlook.com (2603:10b6:510:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:06:06 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:06:06 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 0/2] mtd: spinand: fix nand-no-ecc-engine support
Date: Mon, 31 Aug 2026 16:07:16 +0100
Message-Id: <20260831-mtd-nand-no-ecc-fixes-v1-0-c2ec46641b90@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqCQBBFf0XmuYFdTcl+JXpw12tN4Bo7JoL47
 035cuFwOWcjRRYoXYuNMhZRmZKBPxUUn116gKU3ptKVjbtUnse559Qlm4kRIw+yQrmpzn4IAcH
 VLZn7zvgfpt7uB+snvBDnX4z2/QtwIN79eQAAAA==
X-Change-ID: 20260831-mtd-nand-no-ecc-fixes-6341fbbeb059
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788188838; l=1147;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gA+l5FDOovbSd11Htbo8nrLzS0wir3LEAHj+cfe2MFA=;
 b=xlEBJr2ucWQwqi98TZRMzcl47EyuhU65hU971GT2uV3yc5qf0Ddfyk6nOQoYgaPRkZKEC+FH9
 QTDzukLq4hwBg4Ik3BVBcFUqJXvsbuDt3Rw8WHn3vBKhasjwiw0mFWV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH9PR03MB767167:EE_
X-MS-Office365-Filtering-Correlation-Id: 69565eb1-48e8-478f-49f7-08df0771618b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aMhmB0dv37EgVDAXF0D0Qr5NN3EUXplta+Fb2vn0hkPZdiSSOnXmL142IlWNjwgBQdfIYuiwqwZgsgC9fIi97+9lA/f7MWff94TewKCOIOB6R0EyBmQedeN4fUnVFEkNpITy4o9GNdhUFhrx/p6D3Mmj4oqGaJx8jWCWeiP7byNYnECPSU9ucGn48kVMbAzsF+pqqsiI0AnkHxoQ82xeA2Xp1Fz+3L9PkdrWXkFDgtERvmPlsJPtFRLOlam5Abq0IVe3mVQvJBfxBpyFpj2BalQke5RdyaEi2D9xkX9B0HqK7L6HfEWzInA0b8cwypLAitTxCvJlxZrSxF9HJEW9gP7TSTaEqybvHGXeehmgkIQ3V58rbIJL8MP1K8Jb+PxS6oC+YR9uX6AiEXFafNnmJz3AWn8LMkdsQGTnup7nFeSwu0nQKFymvfQ3DbYa/61ou60KvYQUXIraNQCdoZrfPhZ2WjnIjPPfKHrcvcndaB9WM7j5mhl1I6dswwaQc5bdshAFVo7fiUsJxwB5IK6JMsko3W5DcaENFJek87guSt6awStdOq0HzI+EhGZzx4KR8JXLYLBBIRr27b4qR5+wgj5GogDGSJx0Xm6lMLuNEHai2j9GUUirOZKUXDdse4mRVhqiF661QLsOBdkW67riHsQIwvDqA/stBS+dJUGyL2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE1iSnhIdGtYemNhVlgxZDZ4YTE5Rjk1d2FURWVHNFdtak5DLzliekxrRWJx?=
 =?utf-8?B?NkFuQVZXdnBZTWF3b1ZmbXh4eFEwSVBrM3dRUVp5cU9adnFNYWVzUDFjRldT?=
 =?utf-8?B?bjl4bDdpQk1tVVBLVVpna0pUbWgxMnR6TlRjd0ZPUFgyUDNYQzE3WTJBRzFE?=
 =?utf-8?B?dGVEQUlPeWhnOEpQNzFlZDdqTUtJK1l1YU9Ta0ZoUGh5T21LMmVIdFArYkIx?=
 =?utf-8?B?V0toWkowaVp6QTNkWUFEZWpGNW9Tcng4QlNFUGFMaEhwcE5CeUVVNFBLTmor?=
 =?utf-8?B?ZFJKNlJWMUUzeHFnbThZTzdYNDlNTTJGT21ZQnlMSGhidWZ6Q3cwZkZnd0lr?=
 =?utf-8?B?akdnc2sralRwQ240RHU4cGRUaW5kdmo4Zm14eWY3TkF0enduTktxSk4vMlY4?=
 =?utf-8?B?MDZtaGtNM0NPMTRvWWxTWHgxZ0VMdEQySUpqc0NoZC8yMkpnQktDOE5MeGdh?=
 =?utf-8?B?SDg3SWdxazdNeTU0QnU5aUF4dUdlU2V3OEJSQUsxa1pSNG9va1dZRlZLbFN6?=
 =?utf-8?B?ZFJhYXZCUGgxRzZZMW5XVEltQklTajg0eERLZVdLVldZOVB3d1dhYzBRcjlM?=
 =?utf-8?B?c25MSm80ZDNWRjFRY0s4b1k1MTVqZ2FudTBpT2c3TXlBVUpXRzJJb2NjcGY0?=
 =?utf-8?B?a25MMDF3YnVIQnJsS3Bja2xWWitWVGpPbTMvUSt4YVNzVGtrdFZkZ05XZXpl?=
 =?utf-8?B?VjBmall1UUtBTFpYWXpoVUR5RGp1RWg4RzlIVWEvaUlqd2duNElERUUvazJI?=
 =?utf-8?B?bHh3NE9ZeTJVdkFiYThuYzNXclJhQTJPSW1rMmdjSSthalNQSzRFamI3TitC?=
 =?utf-8?B?K0hHTEgyYjJNVTFpRTZpMC9sWEVLMHo5WVJESlVjdE94b2xIa0RkMEZPNCsx?=
 =?utf-8?B?VDdCeWZVNDVzdGI1U0Q2ZFFDOU84c2tCL2o0dFR0UVFYbzBZRUZUTmdYL0Rl?=
 =?utf-8?B?OEJkN3V6Zm5FSHhxaUQrYTVhOE4rUjViaFZvcHp6ZmMwWXFsdjNVR2VIR2ta?=
 =?utf-8?B?VVVoUUNFN1ZGTUlJMVNaUHdONFNXY3IvZEtxVTI2RTJ4dDMyZjZZZ0FrUzRo?=
 =?utf-8?B?ay9ESkdWMU54TWhIQmxtekF2NHlWRS9hMkpqOVhaTmErNExEc0NiWGtpVDNP?=
 =?utf-8?B?cjMyeDNHenBvNE53UUNXellLMndiL0RjRmJGYnJIWXY0RklTQlVTVkE3L3RP?=
 =?utf-8?B?QmtHTWdaWTRqekpOYTdpWk9uMjNwaVNqN21rZ1hleDlROE8zRm95Vk9RN0tU?=
 =?utf-8?B?UEl4dmd3YmhvT1czczh3UzRxNTM2dm5kMkQ5N3NkdllSOTFycmExZU9rbFpJ?=
 =?utf-8?B?V1cwZ3MyZDNWaWdqYU9xcDNWalVDQmxxL1dRcmFoTXRlZkV1L2RGS0N5WUYw?=
 =?utf-8?B?QS9wTk0vNnJrZG5pWTRCS1QwR1lLRldnZkwrdzVmZGlSazY3V01ITzVPaDE0?=
 =?utf-8?B?SE1VVmtsN1cvTWlIVmlHczUyQXljTlZFYzRDbVJhS0lPS0NLSTZlNVFROVJZ?=
 =?utf-8?B?MmN2aDRDY0VTUTUybWRzU3d5SWNmRXFsbjVwSi9IRWEvSG5VRGFGZ05JbTZQ?=
 =?utf-8?B?S2ZBQ2x1TmpIcDhyOEc0dkZHeWE5bFZFdFlaM1dtczEySzlTamk1VUNDOGNy?=
 =?utf-8?B?QjZnQ1FaMkpiem10M1hQS2pMb0l1OWRnOWEvT0FjRkphYld5a25TODY5QVRp?=
 =?utf-8?B?VG5Ub0l3bGk2SWZ1ZmNYRHdTaDkyYlZwZXRBVDJSb2IzWW5xOEVyd2ZscHRv?=
 =?utf-8?B?NFhYUXN5L0p1NDFybVBqbnRydzBENTNGbnpTRUI5UFhtSHN1WDlDcU9ucURW?=
 =?utf-8?B?aUZZcUlmc2FCRzdTaGo3Z3AvZnp2N3k3K2JUYU4wcVNNOGZOckQyaXVPcUJl?=
 =?utf-8?B?R1NJbXlNWWJneG12b3h2dyt2dUtFc2J5b3lHeGtxanBXTXlxUWNMNG1oT09H?=
 =?utf-8?B?eUtQSUhnT1A1S0hqSjFxdkFOOWdRQWRpQWhkdVA4Wmk4T2RmY0hzcmEzQzdl?=
 =?utf-8?B?ZUh0Rm5xZ0MrU3NXTnN5T0ZDOGNKa1MyRlBnRkVmbUkwV2J3RjRuTmZHb3I5?=
 =?utf-8?B?QnlBb3lIWXBtanVXWEZUeDUxRFFLeXhkMytPOVF1ODZrRHNqZmJwMlc1Q0lm?=
 =?utf-8?B?YWoyTmg4Uk54K0dJaEtBbVBJWlRzek5lSGZvSWVpT3RmWGJQWmhhYWtyL0VH?=
 =?utf-8?B?WFp1N1QxNlFLNkxlaEpjWDRkbXZvcm8rR2xTV2VFSWVkYk52V2lGUHR2TjVF?=
 =?utf-8?B?Zk4xS0JUaUNGZkpLT2FqUDRqbGVpNlpKbmVwREVUeGJDY2R1V00xSlBWa3g2?=
 =?utf-8?B?NUpoQis5am5ycDlEUGd3dS85YzEwRVVHZFlQUnlvZjRBTEV1R0krZz09?=
X-Exchange-RoutingPolicyChecked:
	s+yGEL3BF74BDFvxvysLnU+kuqacMCOwgo7HacumT1ObarQWJoWH9Vl4wGL8zp2fDwhY6pu6CEf3gNrIgQz1IGMOGNEgBsSPI3LDOOKNiQjLIgw6dzA9l02Q65oYZllG1MMkUlVMFMo4jcosUCQai69jWba9SXv4ghnCRDElP+f5X7UqqNw8z5yPRBGL4YuwQfxzn0cXxvN/MSHw7Lsywl9a+p17YXNpJ+DUz9cA+E1tnF0p09dF8GyW42YyWROKSJTJmR4HLlMH3ES78MUGipsYpatdqzs3i5KCwhulhfHjwUsBhkIRjIgCjsGcEjksWPGOHMU/fjTQDsA2XOo8Yg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69565eb1-48e8-478f-49f7-08df0771618b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:06:06.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWmljx7h0iYRVeFmgwXSrPpftVhZY3cw854f7SOzf43ckiJLRSboX4jBx0/psfde0suS4IBe5LdWfRIJKY6L+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR03MB767167
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX0197tEPK9erw
 pg1FGriW1f7oXGOwVB+ZWWoQ67lB4ohX4LDRJYVzcmYQhwAhrUullFxfSpLDYC9TDLGVjD3xPQw
 qXBpJWnJm9ra+4wNBVCfJD73cEXMver5aeDO6wFYf94xJZ+Mcnx/
X-Authority-Analysis: v=2.4 cv=QopuG1yd c=1 sm=1 tr=0 ts=6a95985f cx=c_pps
 a=0FlYyfQadWprtAtRvkXThA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=-HmWdmTgFCg_vu0JA7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX6UxVSGKCGH04
 1059V4tbQF6GTXoVpeVv0ZKJ09gw+Hr34mpSJj9nL67iATFYZcduMNS6YwVPjURQ8irmxgVHsbs
 EdoB3OtIkch0LC/5kEbGio29tD3M9O3/4c4my1N5Fg0BUd2sruq4IlKMZSG/i49nL5Q6NKxDI4I
 Yp//1iO2XS8VItWNxFm8z+Q9jyQ61w24jgAztiZS6JQVnrb7dLVM+ty7lZPX2JO/UjBb0IKYlmQ
 FORB4uCfMkVrNLqp3PkI/X8oFO/qg839K/7EbG3rfUFfBXZU6eRZq+jgQ03fcZiH2czZ8P3rAcJ
 5daVaWz7ngEIcFw5MoxbLFANUmHqU6b/lxFMuMvljvwGUftB2D0ID7cXUWuyAvBVVayqW0VUx3c
 MGBOfaeI8xYEs/CMI9oA+w60dApl6UDyphHFC+ZAwZ1+0wc6mnPYqw1AlMUW1i3+x6xXJhnrPCg
 S/DBXCK93v5j9xKHwpw==
X-Proofpoint-GUID: 2L5Oxw06cGeNlXtqQ_l0S0eanijaA9AR
X-Proofpoint-ORIG-GUID: 2L5Oxw06cGeNlXtqQ_l0S0eanijaA9AR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130

Setting "nand-no-ecc-engine" in DT currently oopses at probe: SPI-NAND
dereferences nand->ecc.engine unconditionally to test for a pipelined
engine, but nanddev_get_ecc_engine() leaves that pointer NULL when no
engine is requested. Patch 1 adds a nand_ecc_is_pipelined() helper to
the NAND core that folds in the NULL check, and uses it at the three
affected sites.

With the oops out of the way the device probes, but registers an MTD
advertising zero available OOB bytes. That makes every MTD_OPS_AUTO_OOB
access fail with -EINVAL, and JFFS2 refuse to mount. Patch 2 installs
the fallback ooblayout and counts the free bytes unconditionally.

---
Nuno Sá (2):
      mtd: spinand: fix NULL pointer dereference with no ECC engine
      mtd: spinand: fix zero oobavail when no ECC engine is used

 drivers/mtd/nand/ecc.c      |  7 +++++++
 drivers/mtd/nand/spi/core.c | 21 ++++++++++++---------
 include/linux/mtd/nand.h    |  2 ++
 3 files changed, 21 insertions(+), 9 deletions(-)
---
base-commit: 15a3cbce32994141252bb4ecfe3ff3a5d22d0b4f
change-id: 20260831-mtd-nand-no-ecc-fixes-6341fbbeb059
--

Thanks!
- Nuno Sá

