Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794826842;
	b=ej4KCmOZlBn5x2Zwmt9Gf6tgMQNSp0wytn2V4CnmNd3WX2bfeInlAXNu2WWV2YMtT/kt
	 yYc/iutkZCJt6OH93zQcY/rtISCoHRsaqGHXrRjAryGDt0pU/YDeC2bJIb7cgOqPTWgmo
	 iUeGWAeZReoq8sYVIfIzN7IkwzT60eZe+Zmerc4O9aBQGshMTIiMps5EzOZtNmHvVgwU6
	 l/wd5UWfOQJ9n9xC5TpGiQzW0+5BpQc8Ys6n5HjLDxGG1LyKi3fk0mzkw4J4EUxRDcmbM
	 /9+yUSGZXYi2wne/p3ACaPRmJBHb7Vw1Sn2EvgN3BBV6EP4AnAwrn3PriiFWq++7vZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID;
	bh=msv5kslc41TurIp8PhhZDujaZqToueV64IkCwczXb+c=;
	b=TNXmIBJMlodEFXCD8qzhEqYXZP6C9xDfNkZ1elr3MPtTZpAqA4E3Bn13PbzJcepVHjP+
	 8hmOZySqgDpODHIk/FVVdj7u014RFy/oZ0jmmzzl8Ky31579+YYJd57kHlsShgU4IBDqQ
	 oM+bnCGXUZTl9evGc64fQsqGDiRO7CrFKMOgtB+H1oRs/ts/Ac3Ry/FMqXAsw7bATq8GB
	 QWx+zeMsQTuzScyWyj2by7FC262RmcAca8kGx7ag/416DjbGsM1dWNGkUpmZBJQjGoRIz
	 ogIlcxaU5OnqxnY9a2kA9OuQeCFq71SgDtyv6qdmas39a6vZ4DwV/5fiCxiKj6v4aAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=bcSQfIvD;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=afMtP3Fw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11318606A333;
	Mon, 16 Nov 2026 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11318606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=bcSQfIvD;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=afMtP3Fw
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNxq9p3614599;
	Mon, 16 Nov 2026 11:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=msv5kslc41TurIp8PhhZDujaZqToueV64IkCwczXb+c=; b=
	bcSQfIvDVY9HpdNvtm6SAq6bPLdutY8jMjQGqoF8QwjvP8Ma++s4iUJCZ3H0A5hJ
	cH5pPWRJqfdL8E2mYVfsyZpKXcJ1d+efau0dNgWXBYtU9TntLLM2QYSXewoCGZZW
	8FfGHiY1RiZ1pcTsu/hlKj5QQ8lpFSSnUTyjOJO2bPG7TOfWqeQ/rhnGUakguc81
	SlGuaU2shGo9ujzTMkWKkJjSMJVjYBv3AFJdFU0+ECcMJ2szIJVAvFVp8LMREmbp
	dl0b3ePeOrmlj3Yi1OrxzrXFiY/jTBsnys6hE/eLhbnJgDUwncceebHBjh6LX9LH
	dFa1UpFtGhyMWBqBDWWRLw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxg6u1t8p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 11:00:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGAsEma2181692;
	Mon, 16 Nov 2026 11:00:22 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv7ps9pn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 11:00:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAXdoxRQuBWoETqFfYsIvaUx0gdb9vfRHN9DkyNoAofzt1NPP295pnNTYSstiIyUYo2r+OIhDE6xPHkI8XPBTx09IwsYyFaPlXR0cA7BC+DCjdgSzKGOEPPmcLSwY1aGjgZhgs6UszC4lY+A2jpkElVYIukqPEWAuwmVau1RsCPMg1VvmzkrPWfleFcX4Taa/AfdHAhF8JLALJ2hPQ1P5scDtzbxm3J2PH8f5xRoDGJ8kfdrDej+AqMS6vP6CigATu95QwJ7kLn/QZYjrE7jhLNRxnD7r3/0UZDxOI49gchJmXIm4mkRyripG5aTMum0oYwF/Pk9AMm+byQQpl6FAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msv5kslc41TurIp8PhhZDujaZqToueV64IkCwczXb+c=;
 b=bYA5slcRkBtRz7qcQ75pAebAED+tORhZflPzGoDUd4Y2HCZ8wTYyKNEvfrlf9AlCiR8azEv6pFqFrm/APysNhwiC06qlIQ/qCMhSjAZ0DsAX0YEFOK837oN/D+cpZ5HrvJ0RG2hVXxtA6rWVE6GkePn8K4fad0ugAHCw0joX5627tTlfDfwnSzNqyYtwXkvf1j4Qs8TNNpXNrLyZZ07V1C5hXOOx7kLNBz4hjkQbCaf/huEHQoT2pk51zthScVv+2JAIVKqIO5kepTOJIxCRxND1Lq8K1t4+v595Z8aEU05VHa0j47XVMdCvn/iindglwYVGxObQPCVENkhSdUtWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msv5kslc41TurIp8PhhZDujaZqToueV64IkCwczXb+c=;
 b=afMtP3Fw6wjohWYNK80XF1+KK3jtBMPZw5cmzDXnMT9TDgO6glTBusYP55lSLBSzLFxpuBXXRd+pPzhAqj2JNwxATCzzrw9WTlTIpUPVMhoGrMDXaPUiMYBbLeGjNwHV+NMuwdifx81bJX5ocZxnA/FGYmmgRMXTxVVAeWT/OBE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16)
 by DM6PR10MB4187.namprd10.prod.outlook.com (2603:10b6:5:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:00:11 +0000
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a]) by SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 11:00:11 +0000
Message-ID: <3477f124-bfdf-4dc2-b05b-5048eda97724@oracle.com>
Date: Mon, 16 Nov 2026 16:30:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation:
 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 -
 0xffffffffc0477fff PFN 109c1f and WARNING at arch/x86/mm/pat/set_memory.c:665
 __change_page_attr_set_clr+0xf62/0xfb0
To: Mike Rapoport <rppt@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski
 <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        Salvatore Bonaccorso <carnil@debian.org>
References: <avdb9EPXBv2hRCzQ@eldamar.lan>
 <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
 <e258c325-4b4c-4738-8de7-733da90b532b@oracle.com>
 <avrhRp9Je2ip6bKM@kernel.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
In-Reply-To: <avrhRp9Je2ip6bKM@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To SJ0PR10MB5834.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::16)
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
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5834:EE_|DM6PR10MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 898d05aa-cc04-42a4-9cd7-08df43d0c8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|4143699003|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	60qrg56BTLZX+nshJLdSbuIL/cuzRtY0babGTP/y+rukO4OSKlKN0clTcGcZN1AtLNQ0mkIcbeTbGO+acrpcOoB1szMmgaKBtzGvRFBFfm7HUQkYb13lOau2cG9aLoj3goR389TRNptIlYMcQJtC1OEvn3/eJfQRCB0alvhdwBnmEy28SZXKhg4WGs3R3drtTaKrbuvMANl5T7JY/dkrU/QQfAh1Exl/2Lnmz1S/wZ3iXivCdlhzA69OO5kFoKpo1ZA1gw1GAAzrgyd574PEXLGMpzU7jY/P2uzGg0a+PeboYvHswO/LO2Yw/KnbL9cbXSVaPsNkB7c4ml6A+VXlW2F4VMzmqId85N+ca7Jzlab/v1QCalYDNlMnxBrPUFIP3RnQ48tJl079VpzKAXmLu1wsbD2/Mq/pQU886cEMHOfsnG8A3240RNDn3vO/P11U7R6pOmm5tIv5D8myFXASAbDbFlGIr1PK3keg3iEVdcBzJw3dD5GoTw9I34EbLILjS6CBb9xrPxQKOmWjlYlIC74Hf4amWvNhXv5pN/K5YR6LHzWtfqpHOZIkwzlTh7Pf0ENxWlDhi2hQnDHGKQtu0PYbEwbUaOZkPddlJ7K5mx787Wm6xwJJoybSh7wi12RxZIxHjbhqbG01Lq+LgwI3tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5834.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(261022075727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjNmaGg4UVVXSEtSazlYbXo3aWRIMmlWa3RjZE9wWTlZUVhhdC9CeE8xOEdj?=
 =?utf-8?B?b3pkbnlWRlZQR1llTGJpY0FZTldhSmdhSmlQcVFrUGo1MDQ0aEVYaVBFUGda?=
 =?utf-8?B?UWphNXVJSWNCT1dsZGZ4Yk9aVEZGWnJ3cC9LTUdoMkRWR1BtV1hlWkdvWm9w?=
 =?utf-8?B?OHNSN3o1RTBtRG80aXNRV1hrc3NDT3lFcXRqWXhOQjVHKy9VZ1E2SjM5bGFi?=
 =?utf-8?B?QjhOMjRmUWxNbzFKVE10MjNnc0FmRmFvRHFFdUx5NEpXWVJMZEdsQ1haN3d4?=
 =?utf-8?B?M0JKMGJYYjFMN1kwSHIxSmxmWitoWFptV2U0RHZtUmFtOVBnck5XREdnczZP?=
 =?utf-8?B?eUVnYStjQzdCbk4wRTlIRGs1M090dzd6cE81SWlISVZKOFRxQnB3OXFqenRZ?=
 =?utf-8?B?NnVVTGVzbWgrbnpHNm05ajA1bzdDMEZ6R2pIclU4dWc4eEhZcitzUTIvd2dT?=
 =?utf-8?B?T2pDOEF6aTRtYU92cW4rTDdpVmhmdW1PaTN0aHJhUUZmelY3UDY1NDdRcGl5?=
 =?utf-8?B?MmQ1cFluKzY4VGxKeUZyeFl6MFJNNmRneXE3QnJWdmxFYTBJU0tiRGRKaGdL?=
 =?utf-8?B?Z09FTXU2NVdjSlNqR1FYUUZWUXVPZU9tTklpanFsSlVmQkV5Zm1ieThHaEZS?=
 =?utf-8?B?ejRmUVU5THlkamh2Y2U4cFVEWUhEZkNTVTZGU1dlNXFDT29wWGNoMHFMSTZz?=
 =?utf-8?B?Mk93Z2k0bHRpL3NwRVh6Qm1JWm5WSnlKRkU0NSs5NnJ6OElDNmRNSDZkcVVE?=
 =?utf-8?B?Uk8xdEpDVlltNHdtNklTMGhQYlJ0ZnQ1MStWemxabGo1N0s4UjBPVHFvMVBu?=
 =?utf-8?B?SnhIaDdEMG1YV1JjT2JwTnNkSE5SOS94K3ROZFB3ZXdQUFR2S0hCdGM5a1Fo?=
 =?utf-8?B?ZUxRNlVzTkJIb0VQT2g3MXpYQkUydGVPL1hNZGczOG4vODBRR0tHU1BZTWsw?=
 =?utf-8?B?K2RSUjVQV0JJaWRhQ3RBOWk0UHYxQ0dGVnVkTFBrQXFNWTFuczdnOURBR3Ro?=
 =?utf-8?B?eWhhSFFEK0pDMERBVnJ4REIzRXlVQnNrbFk1bkw0TDlBazJhcURWNDFPVkti?=
 =?utf-8?B?RlNTMXJBWGhTMmdLTjMyYlozWVBqVWZnVWk2d0RMVEVYZ0dGZDVFTjdxdSt2?=
 =?utf-8?B?eWZIOVloaUxiakNrcXlaTVhodE1aR0Yrb2lPTmJDUzVHdk9DcFA5K0JGaDJQ?=
 =?utf-8?B?WHpVR1htZloyaFBlT2ZCMjhzZkpyNWxIN004SGpGeVJvQXova0dvYzh2U3pV?=
 =?utf-8?B?Uyt0ZzU1ZGYxUFZYa0c3eVJIL3BkQzUrdTZxa3pYamxpaDAzS2J6TWdCd0U1?=
 =?utf-8?B?ejNKL0thT0JZRytRUWRXL2xUenUxTzZaay9HY1ZVMXlTMmthWEh0VW12Vlkv?=
 =?utf-8?B?UTdVMUY3SDN2TGJTajFYSXBvVGQrV2VTVHYxNEt6blVzSFpjSFI4RU5iQUJD?=
 =?utf-8?B?SFZleU1zR0l1ZWRTWU93T1A3Q3ZFWVl0aXNiY2NCbVpWenhrRnlUNkp4U1Yw?=
 =?utf-8?B?TURpRHlCZk5tNHpYVUlrdWpENFdRNUFjeVNPVnErUFBlZkh6dEUxTUV4alUr?=
 =?utf-8?B?ZlhzTGhqblFDUnZaTjd2bVNOREg0SmNmaDNHVG9aaURCYm5EK282WTBSMEZY?=
 =?utf-8?B?azQrZC9RQkNnaGNwSmhLS1RVWVdHcXNvMFZtRGRUYzZVVXZ1QXNrajFhS1VI?=
 =?utf-8?B?YWRmMmlpL2pqRTFhZWJjOWdsRGxKUk9tdlhpeHMzZVdrYUM3NFRWQkVScXZH?=
 =?utf-8?B?Zk9IWGtvY29nY2s0SXM3cWtZSnY0bEU1WW5NZ1EvTFZqWlA3MHRCMnQ0eHNn?=
 =?utf-8?B?Y0pPMmNUTDViWngzTlViaCtTKzNqNGdLVzZ6WHVydGRmMFF6ZVV0czd0ZVhS?=
 =?utf-8?B?RDNRZjlRdW0vbXlLeFRsdUlwcmowdkRORWhZdFN0THpaeEl6MzE3L0IrK0Qz?=
 =?utf-8?B?WExSbC9ETER1bHp2M2ozdFRHRFUwdTZBQVdLVUNNUjF6MVkzUGdtM0lzMTVT?=
 =?utf-8?B?WnV1alVDNnZhSlNwSVBqSWNGM0RDUVUwTThESHJtVklteUJPVXB0WnduNEYw?=
 =?utf-8?B?YnIrcVRmbGJ4VEVjaHlVTG5Ob0l2Vmp2dW0yQ2RnV2d6OEFOdGtEb0M0SGd4?=
 =?utf-8?B?ME45dzk2T1dVWEN5Mlhya2JBVWdnUTV0YmVlbm5EOVNLUmlRc0lWTERqQm5v?=
 =?utf-8?B?Z3FYYmN4Y0hnbVI5WUU2RUQrZTZxK3hSZDZLUlFyeENpK0xRSnJweG9idlZa?=
 =?utf-8?B?Z0FhQ09NWWdWamZ6c3FmZ3FUN2Y3bm5xQXZ0cmQ3OHhOZjRPWk1wbFBFRWVo?=
 =?utf-8?B?NVhSMlRTaU55dDJKOStrbWV4dDE4TnVBT0hlUzhwZkppd2dwZ0Eza08zUG5p?=
 =?utf-8?Q?qIlMFm4Ije8g4XOf//F8LO4muliuie7NONMkH?=
X-Exchange-RoutingPolicyChecked:
	EJf0ugH8Biux6QQncL/7iazVhk0XXqAUF5A43btxmRcX3+mA6c6K6QoLnbhGt42VdikjhIMsvvy4/Yk1mMttwz3vSwUfYD1MsJkKSmKonCCMXc/2/GdBrRDSClfEoZUYcMXzDN9Ep2ZLbbeKL76KhERXhSZQudKxk94bxxnDuenBKTqB9aOiueguephfbBVcR1fs8LQ/dHPm++iX9UickXDdfQ6m0CZsd2AYgRqrTeIefhUU5rorBmfk4s+HmKKiVm3hOh1XRFdiaoHoKyyzhHC5wGximxq/ZBIsvZCzspIKT1EkbVmCgbZDRzAFkmqvo9R/7bWBWPYxghnuRtmQVw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ltK9xXlM2bUTRESTMhMwkprbhQVRVcxRg9PFsS6zM65pv1OELK/fNRhTjUosgvqa02TWsNX66uDYMdohH69p2OR7jGeZx5pQgLKB/8GC96mV+8/8+1oLyBlxhk342D6tp64HMvwzagwLvH5i08qm2sEcBjaHUGZpqJzxjQQPoeYUzryZtWHjUuCiHzELoEU/zLWHhMDFNUFxvA1dE/jAo9dXhSbXBp/IM52R/qe0aNpfMfR+BGILRdsLnGYsy868iV1gE84PnZ29RhF7ufBhu2CIpjeUVQ5wzKbzvrbIHZHgRmfAP4U8MIItBxX0VNlo+8lZq8p4jqkFgbKRPhXLxuITwGcWDuJG+cJuLVigJnDdfucE+t++xy4EO8tz7d5IWOWUwazEJYY8SHsNh5A1PttniYM1IIpMqvGlKXIWBiNQGxrew20Wnm28mVti4c+2iw6z46kC/bN3GkSwefmxZEA/7BfXGaUwkiTdMoTqB62tIoec8Iq2fiLr9VhqPqt6QpkJcNy+3SWqHUoYMe2HZWlZDesyBkw3iPKg6f9AgNxmGg3BT99W3F1E992sJGye4/9OsYgwn4x1Fe/zv3MHkDUfLTDybkkxONV0qTrQ2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898d05aa-cc04-42a4-9cd7-08df43d0c8d4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5834.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:00:11.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O99HkxIlMGayiqON2jA3pXKx9DLLZ1guSGmAk65V05/0hr6v8AtF2eVwmkVq/1XfsLthKw5tpIdRxpNEo8In5aQlhVjqNzbIDNMjGJm8Gue+syoOjt7CEG9lmNWhv1xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160043
X-Proofpoint-ORIG-GUID: 4QIwqHTp6ODdRwngN6Dvi42k2C5STyBw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MyBTYWx0ZWRfX+pFoUDpPfrTu
 ky1b4ZH5RJhcltXDZ+UcBXDIq09v/xvwWhEr0qrCdBOSah18RNjsaDHUgo4wQAR04lUHBrKY+Q/
 TdmNn7qO5ZDhH+Y6kZDfZQFEbvKN1XkEdN3/YsIBfKXYu1U2u6z9
X-Authority-Analysis: v=2.4 cv=foVJ914f c=1 sm=1 tr=0 ts=6afae246 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=bbRJZBErnACIw58KS5wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MyBTYWx0ZWRfX6lBQN1N2C61g
 U59zL2HecHSW1nmd6OjdfOcK126xoc68bo5GT1kW9MBQGEzjgM1oq8mSsbyRFANUJfrtJdfBCMv
 f3q8k9it7B8VNmkCsVH3Yvv/2bOYU/M2JX2/UQKNiK8XGOMZ05YUdBkZUqQt3wuXoBXCtsSmTwu
 v59hO2pLLsZUJ32xdrAU93PUT0pVHvYFX7zwt+H5+wFdi5JyL3ESkISLIZr3L3H2NeSRgorB6H+
 5VZtDSOJqup2FLxvx8U5v9Y0a+SGB+gWTG8TZ/xuXsTBuczAxg0Se+ugrmIE2ajY+iAMiM1VaR9
 2CzRPPMUdEocxY2vpUMzoBx/npT4KekxrbkOZt91fQ6/PI4JUZlU3Itc030FPJJB14Ti8es6n9p
 RHP/Zi+uk/0+36OpULMIYLQZqahM1RALY/MSsDcn7TSC2XvN5hlvryRc6aEp1uAYPCpAsSQ9w2w
 VRY451cwGOehB6tNBKw==
X-Proofpoint-GUID: 4QIwqHTp6ODdRwngN6Dvi42k2C5STyBw

Hi Mike,

On 16/11/26 4:26 pm, Mike Rapoport wrote:
>> Quick Note: We are just reverting the fixes just removed the fixes to the
>> checker and the actual broken commit is: commit: 88a817e60dbb ("x86/its: Use
>> dynamic thunks for indirect branches") that introduced this problem.
> It didn't introduce a real problem, the permission are correct in the end.
> It's just the intermediate state that causes warnings.
>   


thanks a lot for correcting!

Regards,
Harshit
