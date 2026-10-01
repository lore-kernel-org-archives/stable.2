Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E255208D3;
	Thu,  1 Oct 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866294; cv=fail; b=lP3eGYtsrSAdBC/rwGsxeSikMdapQHOAChR/F+m9LsXJmDOpk+DFTP0gKnXy25kYtZkyiA5bPA7hGAukBbL/fbJzIo5sJcxzMt6cGLsYZKzlEufQSQQizhFMF33AwYBqOHg4IFJUtDts2EZElgTlIuWL6BICCcTa9zYEDq2wF5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866294; c=relaxed/simple;
	bh=N4sFKjJTzF/ujxtaq5jV7HhgtObxGRY+UETOir7W8gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYVbkxymXGYwOzzWxODIhreDioSEBeXyk6koFDgT2AUl8mGoWTVwec/IHGmks0LeO+xYFRDVvkvNl57V1vt7f9MAFz/DwZNXCfg2Q2hDYiW2zi9ASHQAMo8yO2peQGGZVreZAIpzCGu3QueafQfOhBRG9ttdahbQlkxppvZBy0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z8kAOWCP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fIzgCCCd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8kAOWCP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fIzgCCCd"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMULU622799;
	Thu, 1 Oct 2026 14:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i66nFE/3stomT3hiXygtbbWR/swB2TUQrDP+noR5ZhI=; b=
	Z8kAOWCPdOU12W0Bxc99PzyKqDNUjy3DUvWqaJeKez5lJR5n+A+J+axVHVy++2Yh
	1ZNbCvyqT23cxm5+PgT8rUkHYk6kskYo5P4/6FshfIs6SOr+iwB8fCGKziRdjrSc
	7jDNK83b7tpTwVXgfIG8o0unMB6HrTwer5eSGKpfhnhRJy0Ow6IBxoTvqmTzSZzU
	G5bx+XC7pl8mHWkQnstBwdoFp4wcIOEPVVcjHwgMkXtWlFxA0u+hmTDpTWwxkxoS
	838ztpVsmorBE6Ah1M3Lxo6gedD5vDZ4SBI5oDsB+n1ayoJnneCQEbQrvdD+UXOM
	bywSmpa7LusZs8SeeHx5mQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4u2h08x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo4qq011777;
	Thu, 1 Oct 2026 14:51:26 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxrqu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROSkyRfgVY1kh3gHtwLnXeKT5zp+JICNS8Z9f28CS3R7cVY/gn2amking4hMyAEpsYh9k7lziSODImHcoU+MiOTZ4J6UmzGJc4+q9H28kJQODHAJSh70SOfAHBXVv0Hmd31WIk9s33PSGRp4qVSH/x1MqS/gEwD8eTL5jaR4Mah9GlqlEcs4G7g0PknDnwBRMsHxPMwJ/GQrcTLXXVI8qJ17oMhsmhVx2kVORuKPT39BAtRDFteGmqiWimfqgr35TMeHxTks2VLZPdiuNI8nHV9/3/Ck/h8wT+3+RIL7+mKWrMjj2M8uXxrLE56LS4KD/nwHjxZG8ggaqLDVNjJ6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i66nFE/3stomT3hiXygtbbWR/swB2TUQrDP+noR5ZhI=;
 b=TdUBi8jCmCxbkATmvOeT7YphLJAm7aLswCXqh0BSoG+wKFHHQyNs3MXEq0Qs89J1SwKNBG0jHLf15owJFEeOEJQ+kl+btHx4wk0AmyZDm2UJC/cg3p0OdBZr3Xyspt76K8phdeORBdLlpg4iDae9Md8tU5BhvYRABxrHZK9xanbHMnMgON8hjm4wfTgPgys86zmt6u5nAuNJGW4Me/D7SHlACmssFOJ4SDLkPwbnaxll6/xKE52kA0YVOZP+Aq3HRQrfBT7boomolIa8oqojDfUDgAYWwVh4L6AymjePI9dT57zDHs/JOmA/yKO6wKwTO8n9Y7dPvFbsnE8z0c1lcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i66nFE/3stomT3hiXygtbbWR/swB2TUQrDP+noR5ZhI=;
 b=fIzgCCCdQuocDGmEwfSn+bm5ZP0FWSxXWaLEl3xnjhke1z2i00ObKu50hVw+DeKpsV3stnsCR3vCsgq7+kTXQ8UEkvTzfTfPukxLm/6LFVCJaGNk8yAM4FvHJaOR7AntZ1hSf1PyKleD1BdsWZw6L/OaYaz3CsOcKphz/nWM3U0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:23 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:23 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.12 5/6] xfs: factor out stale buffer item completion
Date: Thu,  1 Oct 2026 20:20:51 +0530
Message-ID: <883db7d82b71cff6f2160e5919dc10df75dac2a8.1790864403.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864403.git.siddh.raman.pant@oracle.com>
References: <cover.1790864403.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: de666ae1-0f1f-4d42-541e-08df1fcb75cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fyN+quS1yltCqgIiq1hG2+ar1ikHJqV+jwgeJDiYpQJd6gTRQTjS9GZLeZstfSCYdJO0lvv+2PCBcuIi7/NMa6zyecnVX8E+3K1CSSqYHzu8imemdDYFFWhLaRMK92ve93sUquWFrhS9x2Urr5Y8ObCAjWucoP9/W2+HMiYlGgHmiejMkUskz9AXLk9p/Azdbd0AArsr52HbGV2n1h1/fCcJiahnqjjym3LGHLKtkDbweKPV3nocJclLFmi1JsNPbS1qpcuC6sx16AiSgFGf73lA/q6BSG1XxFA/2jiZqEYy/eOe6GsbmuYx6mx4J+lguisGRD2/ryOd5WTODrKeUr+gG0ueSXnbuoK8DOfKozlYiHjolGpAcHMsdxW3m7lxhwd+L5Enzv3yMx+eJGOaRJBRlbuLM2XuDUSu3W/8S3Wj4Adv2+rBBVOE4tuSsBdgmKbp0wRWFrbi6rgGbfohdyVzoh1F0siQ0LTukDmD702Rc3pw4qJtP58Rm/0Xs6Y9ElPPIt/xJHG8YZGTQCOzWDOkao/t0mTU5GqNGnLhFyArjRNTAJoN/2XxD89CB6qTmStb6XPVKBF64Rm0PdIsL+XgzzqBIahgDs/vjFbu26XAQqXCMFmYtiER0k83g/7LDLSVjk3VFDGRJfPEaIxceoDE0txNbNmhmI/IFsx6TBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1VeVGDZG9/Ko7r2UitA/13qy0+XgAqFNd67t3dNv/28dVhyxRHzrm6XEGjW?=
 =?us-ascii?Q?zkS7TNGFHwirWDul+DsPI290hfZblUsApvzBRj1ZHJUvE7iqRIGS31KRVF2x?=
 =?us-ascii?Q?3L+6m7EaOyhudo6ori0h0c+HKZ3q5m2O6WdZqLN1Oghagm/2J8kjsVg5HyxP?=
 =?us-ascii?Q?vICcrw2AhRFCt1a+7/J0CJv3cCvTqCiX8AtSRf0QLuC0DpUEYs8YRN7v1dHe?=
 =?us-ascii?Q?rNI4xSyZ+TyAoOp9VtSgkRqD4cENTTLQiKYhBWvX27vLU6gQC2x5X143ipat?=
 =?us-ascii?Q?R6u83ugSlLoa96su4goFhHcNYJ0h4ZSfAlkrNtZG1H8ppOAOn4GIcm2eZp+O?=
 =?us-ascii?Q?Sy5oh7mLjAjjb07Vd9jVeokJqlKgS/48gnjTReWAVzM7TGmAhO8GOLJIXjm6?=
 =?us-ascii?Q?OUJ6FUrHqjjA54JDW+5GvI9nvrdDPMoecf0poziiGM9f4SNJl/M7DFLmbR1a?=
 =?us-ascii?Q?FBBXaMBBk9p2qd2Qm6QGjinY5DyGf6H3BCKvhciq3Xolvs1fNtc15lPn12ID?=
 =?us-ascii?Q?JRcaaKeODS3hcyQxL/+5on1ra+gaK/WXM5tGAe6xBz6UuHVOC5sSfB64ldEy?=
 =?us-ascii?Q?1eYSoENviaZNHHsuIkDTL2sxFQTjKe3vYtcHLdw9Wcs4s+Jf5ElLSK1ahojI?=
 =?us-ascii?Q?7NrzhZEk0Ml5XppqgEl5M+3t5EO/clhTmjy7i4zvONF48wnDOWqWkv44S8Xd?=
 =?us-ascii?Q?WStzTOUe63VYmUkhBYoCQYCPSq0iTKCA5hRSHT2XmKv8q4jTJnpZf/UfD0pp?=
 =?us-ascii?Q?GRWMwsiLyl0s7nSY4nwFWfHXxH6BPk+dhSo+4q9Vh4WJxJRPnvIvZjFNvSwv?=
 =?us-ascii?Q?JsSNoPiW7iEeZH4K0Ua0ynG7XgQ6JC49Mzn7Cb7b1F4AP1RKf7hWF3pNENEV?=
 =?us-ascii?Q?BMLHijj3zYPMd6bXgA+o2hAojKu58jtrx3EjHHl9oy2pmKhwoCR/B9Zprmqp?=
 =?us-ascii?Q?P9aJ2bx6AvGW3L1H6XacFJ5/oZ6EIKN3Q23eMqAetj1qw9aoBQvOaCdUU+aU?=
 =?us-ascii?Q?EdoX8B1e/5LAO+aZi7q6l7zFXNNP+W95fXhNr8aj79dH2lndQK/WJ2c0DyuY?=
 =?us-ascii?Q?prId3X+wH+7P2jCEihvlkmCbTjcMaA2jqViNaKyeCuNkQbXvEFe59j+yqxVu?=
 =?us-ascii?Q?MC9/u4kBJU4G4qwYNyFj0PRz81LZTDujm+PvZp9ypICIrh6yeQlVDDf00dy/?=
 =?us-ascii?Q?UBgd4e+bErHNwAsGt21drFphW16nifzta+TqyHLDcDISkBYVxzrw2Vf/tvQX?=
 =?us-ascii?Q?EE72IylxlsoyFwGxhfclc9ecMQkodwrQNASwT+yKFtBWdTklcFf8aRmo2KYg?=
 =?us-ascii?Q?6NDR/4DHhY9T90Z6HlB3C/MzDNiezuDcl+F9RHSoWNp1FIYucMesEpBgwFAY?=
 =?us-ascii?Q?YwVW/Wm7PZgCBERBQ8lkH4c0+q1tuh8vOnPM/0Dlq66fe8JmJfWwXzAS1Tz0?=
 =?us-ascii?Q?PCxgR5PScUA/Rd/Vo6p+2/c6SgkDfIoD3bIb8+G8rmDLcie4BgfBAfaRKILx?=
 =?us-ascii?Q?qpY3Y1Y63NtIx0DxDJvIrZ36XHvI21MDHZ5PTrhdARljCF7m4OAGtaK/O3d6?=
 =?us-ascii?Q?LPd2z8t2P/IdokkDDEylEhGNpHdOD15bfj+bxSd+JABtMBlg/fE0MWSnK3nr?=
 =?us-ascii?Q?Fx313A9ufswb1gzS2a/9XGuEpKMFQk8Xo+lqHe9SSafFi6k+dYvT+paPVFF1?=
 =?us-ascii?Q?zgC50OLxyFfHXJlseiE3uiXFwnt8zsoClbgjKygsGp6ScRP2J7nAAGoB5p2e?=
 =?us-ascii?Q?FkFi39EjnHhKQuNi/vaSQ/Oi6ArNzlSYaYENhV1XHap9QkaW9/fZbjbtOa9q?=
X-MS-Exchange-AntiSpam-MessageData-1: AUcSwFmufiqHHbyGKPGDHA0ElKJhNFI4H+o=
X-Exchange-RoutingPolicyChecked:
	V3unNXMvWYCYRa9HpfaCsWwK0SNPe6gWLMP9rfr5hTQRHlRyBmuK2DWKiJDWyf9ynwOdMy5SweUT93W4vRc3/jSoJP3Gxtj1gg6sKpYXs/l6CkoVdHg0Uajwee0RBA7ZNRpqFKSAGLnbB+xUASvBRYE+jsv++PS3Rz4vSSrryayuKxbmZmR+K8L8WJys6kwsH/hE0oTLhkVXn8cbzblBTU9SZEZYNu89cCf3t+7FNnTGxee4lvqLf9hwf1idMG01hMEtQCxzKiksnFURkdNFBLOfdEq5sMxF8cb0WNEqnvj8Ui/emuuYN6rqnIDnZkdQVIyJHa9YKo8dQttDOHRVbQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tVwQ6Pk98JtLGdNUBdo+mhmBm+twx6UgZyoR9SARuW9+UGF+dg7NRtw5626ShGW4UiXwSf49ogydf7Rc5lCWPAmg+iKOQMCW94Da0yr6oKKyvv5EobVCB3sVkhpnMqGU1oUPGk9KLhnpr2lSVnQwwLyxxC3WG2slRM6jG3rGH705+2QTxicCoP2lcDMV+6hsHKOci7g1ucjE3+UF3ongGBx+Ou/YhLPccDv4O+st8zGnqBk10C98UyH/qgaFDrsT5reoj6bjo55Z2EWYwOMS++fN5TBCF0LrIN2eshe0VTUGm519hzjdarDbzny55USeR988fVoz9UcQHE8olrP0piNbe74fK7KVFLP926JzYk7b/jInD8jEcl8v2KseRYNxBtbZWwtFSeDGikaC4zzAFUAB4K2ZXHFCO3bHykJK7ElISpFOZPXf9d0fTpXW98c8Wc8LyHplHPEPrpyQFWfZUVdnDxnDnkIHnnMj1AoCqtu64DdT/63TITU4hQvBLJ23+K6nRz4FjRmkx9JMAnMMpP0KQBiN0WkWEVgv4tX7cWZRLmqlxIfrYCMbrBZFvhBjHEKt7bAk4RbUG8qVWFMsrE6bVu08VWvMm2IvQRSpcmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de666ae1-0f1f-4d42-541e-08df1fcb75cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:22.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K/SXpqSk0kajtaxocUqersCAxtHUj4LebS/hXWFgYovgkZll9rtne+e+g+6XybXrj3eIcMkdKIJ6Gm2MZjMj6NVNq51PTd9kyiNM1Lhplg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6TEyNlNxWBPc
 EqBs5qtShAjGkrCZ3QOQSu7obcKKopa561TVS7AtkQOu3AvEkuZNwkyeIm5g+r8w5e6VtjheRrT
 dFhK51mMkzLhcHSJFW+7d8MoQzywcIp5potei+y2tyJyBk3kwQh6
X-Authority-Analysis: v=2.4 cv=W9itxhWk c=1 sm=1 tr=0 ts=6abe736f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=HRhzHcoIBzGTXiVGymcA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: Q3Qu8tj1Twl5vXy2aDR-CJEi6HGIhmF3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXxrSJqwv05vjy
 CisDWcPhvRmXBSUr3hUSEEuI1J3KpSm1YfvlfOO1GRnGcr7J/CH8rdyn17dL4Gz5BubvtJvM1OJ
 p3LykXsxSmPGgKuwASN8+25iz1NH7jIcrg8u71RD18eMd/HXdOhRcf4h7OzNiB8KIs9Vh9p8FSu
 NDzf0iM6rh+SA/cpg2g6R1vZ60Yz4yH9yJ9CFkUb45aj+69nsK5Jxd7inkOQmAnavc7bL/yDpmN
 KxJPJSpeeq3hpMK86QnGLO3bSqkEr4MnWvVbLnFqU2kGy+v/P4wpkNiK416xRFEelL8ko+oNyKz
 LANkC+h53hCZ3kjf9GrSacymePET5N/xW1rZKO8UW8zY4S++zjXAo5iET94ORQxSdhCzzG+rXbk
 RN7T7PzUAzlV8uJAHd8CYwxLTNwuGVTPFerzwYDY0N7pIJrixED4LvxAVJkDCLl26W+pdUzOHwM
 7O6Ai7fhChVwr4NYwtA==
X-Proofpoint-ORIG-GUID: Q3Qu8tj1Twl5vXy2aDR-CJEi6HGIhmF3

From: Dave Chinner <dchinner@redhat.com>

The stale buffer item completion handling is currently only done
from BLI unpinning. We need to perform this function from where-ever
the last reference to the BLI is dropped, so first we need to
factor this code out into a helper.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 816c330b605c3f4813c0dc0ab5af5cce17ff06b3)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 60 ++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 042282a08216..9e6a68367ca9 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -539,6 +539,42 @@ xfs_buf_item_pin(
 	atomic_inc(&bip->bli_buf->b_pin_count);
 }
 
+/*
+ * For a stale BLI, process all the necessary completions that must be
+ * performed when the final BLI reference goes away. The buffer will be
+ * referenced and locked here - we return to the caller with the buffer still
+ * referenced and locked for them to finalise processing of the buffer.
+ */
+static void
+xfs_buf_item_finish_stale(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+	struct xfs_log_item	*lip = &bip->bli_item;
+
+	ASSERT(bip->bli_flags & XFS_BLI_STALE);
+	ASSERT(xfs_buf_islocked(bp));
+	ASSERT(bp->b_flags & XBF_STALE);
+	ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
+	ASSERT(list_empty(&lip->li_trans));
+	ASSERT(!bp->b_transp);
+
+	if (bip->bli_flags & XFS_BLI_STALE_INODE) {
+		xfs_buf_item_done(bp);
+		xfs_buf_inode_iodone(bp);
+		ASSERT(list_empty(&bp->b_li_list));
+		return;
+	}
+
+	/*
+	 * We may or may not be on the AIL here, xfs_trans_ail_delete() will do
+	 * the right thing regardless of the situation in which we are called.
+	 */
+	xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
+	xfs_buf_item_relse(bip);
+	ASSERT(bp->b_log_item == NULL);
+}
+
 /*
  * This is called to unpin the buffer associated with the buf log item which was
  * previously pinned with a call to xfs_buf_item_pin().  We enter this function
@@ -588,13 +624,6 @@ xfs_buf_item_unpin(
 	}
 
 	if (stale) {
-		ASSERT(bip->bli_flags & XFS_BLI_STALE);
-		ASSERT(xfs_buf_islocked(bp));
-		ASSERT(bp->b_flags & XBF_STALE);
-		ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
-		ASSERT(list_empty(&lip->li_trans));
-		ASSERT(!bp->b_transp);
-
 		trace_xfs_buf_item_unpin_stale(bip);
 
 		/*
@@ -605,22 +634,7 @@ xfs_buf_item_unpin(
 		 * processing is complete.
 		 */
 		xfs_buf_rele(bp);
-
-		/*
-		 * If we get called here because of an IO error, we may or may
-		 * not have the item on the AIL. xfs_trans_ail_delete() will
-		 * take care of that situation. xfs_trans_ail_delete() drops
-		 * the AIL lock.
-		 */
-		if (bip->bli_flags & XFS_BLI_STALE_INODE) {
-			xfs_buf_item_done(bp);
-			xfs_buf_inode_iodone(bp);
-			ASSERT(list_empty(&bp->b_li_list));
-		} else {
-			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bip);
-			ASSERT(bp->b_log_item == NULL);
-		}
+		xfs_buf_item_finish_stale(bip);
 		xfs_buf_relse(bp);
 		return;
 	}
-- 
2.53.0

