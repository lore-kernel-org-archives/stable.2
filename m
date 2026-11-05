Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793921071;
	b=nkkfWhjEYuV14ndn10rKUPiWVl4uyZWLtKBAcCM7YYXM5ltc7XFZlZij1LL+CeHDhQgN
	 aH2aA0eTmm6PX9BVG8y98gYGXbacjJMTNP1w8e9wFS68uR+vcyBplmzfMyJNX3K74hNJV
	 0gkhGfBXdBbI2YXKJ5tZnyy7qRmcdY1jd3ZvJ82i+c3DOXY4oAAi/EwimMr03aieJcmVi
	 X0hXSZsQhR3F+xqwQF7x2EV9OrXjnQd577/kjKeudfGLhukBk76RHSfriNQByY8+wxaa6
	 dW3dP4/3ETiI+SzllY59Is+Hx4xYRURJQVpzcN8H1WaHM632Wq40Sb3V6eYmLCUvWjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc;
	bh=5kobb8FySbUehsE9J4ixgYWwsbXoMXCJyqDNiMk6j5A=;
	b=4V68PQdykCIf3oKhp+EQbsrzQ1ypeCqcTvkL4N9rw9AcejU2egwXqMrDllUJ5dA4ZtN4
	 EDS3iEieFvFnmA+mPO2vSgnF3ciyB4sGHWwTEEsKSlLRkTHylhR4gVsUxcNeSgQ1DiGOm
	 aUV57JyxcpMlyRLSBIpGrb/EhvzMggr1lB9MxecRIL/A9HhkPJFuGRNjf8arlZ0rOMBZT
	 gTa+lbzwAZP9hU+ibANmI8W7gLN6sCJK7yDld8cpELYg7Sl1pcCdBph/0LTc1bSPd0Kex
	 UvjYEpwAa5YVHAA2GZ66n666biEuiy27AKQXu2USrsNRqfYlXrJ9TNemVuz2IQLSs9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=QXweetyu;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=mGpdvMvs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8982606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8982606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=QXweetyu;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=mGpdvMvs
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5L9kUq1083889;
	Thu, 5 Nov 2026 23:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=5kobb8FySbUehsE9
	J4ixgYWwsbXoMXCJyqDNiMk6j5A=; b=QXweetyu02mstaE242Vy6HFjcrKHe3kJ
	2tjVsJr7cBjkHu4N61Q/L7qNWlxZgrnCITlXDEZQ9si3gZLI7Jf6Io+2BTtwZoZA
	jnCWYWagmcYNOfFOWTQtcyIC06RIkZSUryBu4VMUXTrxPvIUIIELBGw+goKOS+3E
	bbAR/EPng8r5Zm98gjI2/aOfZSkoynvs8n7nt6xkAG3lZnqWdwF9upjO+1WZtJle
	wyNRUlkMEAY0zQFTcnCThnOvYnQm/tKIcNzVoIaglB33SBs+/htHLPVX8s4TLh/Z
	um/azintSQj4p2z8bSMBAuxjiOSj0K2EBQu1kLiaqmfcBigMDCN5fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn7439gcw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 05 Nov 2026 23:24:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5N9Maq2387636;
	Thu, 5 Nov 2026 23:24:06 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hs37mgbqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 05 Nov 2026 23:24:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXVaOOcTXHtfLV7mEdOiSTwZOj8I0EWE6iUV0bSRLvBeeyRQcz0JEWwY9cNaAdnSztrnv24SLyF7fS1J/HLLL+BNhU1dNP2H0991YKgjn5cuo1bgBPMoUOXNe+N3Ry4Qp+zQx6id9aGTy1b4mPc/L2eVW1pKCs9HHXvGLQGf7gSH6MpCkB7KSyaBFA7caB69YKqymMoBe1a1ov0nctLcQl1EETx7oWmEzi0TebvAB49Pttm4j3Y6WLkun3dAfL00+Bp+rRpS85f4D/8X5mERQov/9L3iE+BW8WT3U7W45M9UDimS9+vfuyJL4zPVWzMQhMyX/IuuUGPUNS+qGrR3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kobb8FySbUehsE9J4ixgYWwsbXoMXCJyqDNiMk6j5A=;
 b=bWPilzsqEr9cdHbCu+3+ozVXrZcpOF1leg1OCF4OORZjz5o3OOe7rgMbtnAOW/wrqzrP2OlGIS/78rvCdLaiCUNubpEyeN1OZIpxfrcU/gcE7bZTvZwUZS6Y8Eu8E7cbxSQ7UAZX0ZkuIok1cWMlp7yf/GxkpWYp4Iyi0v14ns/CI2p9rr20Wd72aOFwP68K5CnSQp8gBcKgvYuBCR8wgS/2vvvs4aq7cCaOzCEQ6a6tLAdxBiJu8c6YlXb4NFSDxnXkNWRC0D94eAzi6irOq9ne1HO3hL9dnfvS452Szxb8dSheLCIb5g6M4DqHy4z4V8NQeCBNvoKGdXDUuepM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kobb8FySbUehsE9J4ixgYWwsbXoMXCJyqDNiMk6j5A=;
 b=mGpdvMvs/25HyTc8WsPp2TcblTNRxtU3IXWD5aGdDek5e4y0tTiokTOx++8rhBmNdK6q2Nm9PYSzLOs+YixR2fPn1ZYr2A9YAUxkqgYuagIF5sHHzEg86CuWqnGeqA8++BlLV1nU8sUgdsHamN6XzHr6SE6dpKiEhSuGYM/j1zs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by IA1PR10MB6734.namprd10.prod.outlook.com (2603:10b6:208:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 23:24:03 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 23:24:03 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Sasha Levin <sashal@kernel.org>, Gaurav Batra <gbatra@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 6.6.y 0/1] Fix ppc64 build error introduced in v6.6.161
Date: Thu,  5 Nov 2026 15:24:00 -0800
Message-ID: <20261105232402.4033385-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::16) To SN6PR10MB2557.namprd10.prod.outlook.com
 (2603:10b6:805:3f::22)
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
X-MS-TrafficTypeDiagnostic: SN6PR10MB2557:EE_|IA1PR10MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a127431-d715-4415-429a-08df3b93e0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|18002099003|56012099006|261026140227099003|261028144727099003|10067099003|261021121427099003|261102123227099003|261022075727099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	Vav950uGgbusMn9dVyIYhYXo5CyPzR/cXVAFKK2avdvYv38wnFlPkPRMW/nxTeIWZuQw/YLSucYtkUbcPd3Qtx9ZDw1JcW1dnwgFODQ9A2XQF6alSZDSu92t9WwRh/loxKGikCckzOWRMCf6K5pPXq9U/oOnIr3SNKO1t2q0WvgvuJ6Ps8hqSPSi/cq5oWW4dv4psaHhQbXO266tavrin30Vh1oktVNp2br3b293JsS2mizfRFUDxfhTueqYqD1O3lIoykDLGVFEH6LM7GB4598cy/MUZ0a5jqIdv6nQQUBuKzZBbxJir7x5u85a35ELdVeQbTYyz9pnOds+vx9GpN4Zh/4zDJd3NS68QKEFISOGhGUfwwvVV7QhAI2h1HYkVsb4zygRwaml760Ih8suNAvEWseKUhBbFyC++l7dL/Sf9qFEx6byK55/sORumQs0dTBkNSrCSlVr45qyccgN7+5gmbUsvnLZYfro4xeU/ZU+JWqYHvA7YguNkI1g0CASVCwXqrxsBytCOSOwjDgrs0PSxqe/RU5b78PjyCeQLXqbqNvdmngfGLPZlacLuKrSfLKoLa27HmMJV7E/TEA48Nur7LSF6W0RwOY3QFP7jLAxfRLnnz0IvCDseiM2qznW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2557.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(18002099003)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261102123227099003)(261022075727099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZR073VzE8N8voKaHQFBHzOOvY/6RkVE+QYT4RncWY21Zaz/AlAtrwG9Kip+?=
 =?us-ascii?Q?/ALBuH1qs2nzIVALE6HndkYC8Mo3E42ObPPjQkYa95bKMbcIirFkLoSjPZzD?=
 =?us-ascii?Q?wqB9NepJ98kuog7Fw2Dlz1+fwsilqytEJLxIxw1fpNzXVkFt4jsOYgKI5qwy?=
 =?us-ascii?Q?QPCN/RIs1Di5DioZda4JVfdUUQhM16y4npBvl/zWZp+99RW0qlCvlF8rn1qn?=
 =?us-ascii?Q?uLrfC5peJ+cfXyi1WVxRjBXGJAsQNap2upVfIBiFbHkX1Y2nLwq02Cl+zOZy?=
 =?us-ascii?Q?7nlF76QzEn9v13GOOB5WrWUXw90sdBUVQuVbBzdbobnxVmnxtNyWJfTXl48d?=
 =?us-ascii?Q?hpmFU2YZDWbiKiS2O7z5eqnXmsoZ57MySJ1mXQ4yNXcGUiPw97KbVyaDa7Yn?=
 =?us-ascii?Q?pg5bzYc4AHLwjxcwNdtViyTbjfOW18EvqNZhLxqaAm4V8uJdJLaiiIRL8PYB?=
 =?us-ascii?Q?7kHDsmsB1oy89gjEqUmczCT2tR6UsUYMXgLu8P0gy2sVdWEtASNQidsjAL05?=
 =?us-ascii?Q?so4dul2jLALyQfXM49CofEOG9PaHC5UVZ/wZ4C8foRPi/G80YDpXXts5X2lF?=
 =?us-ascii?Q?wt+NsgPE9je/JIrrTgjxufV4LU42HJxBTVOBUwkhPWLLPjIlBA7IcpLWCENd?=
 =?us-ascii?Q?dGTPcs4/rBS3IRrY5Qs9YXaCZ+nt+MblytYdBj8WDkFN8xVW2NV0bXBsX0It?=
 =?us-ascii?Q?EBOO7VvkAOvDnD8MuVxa9FedGJYcNQpcnhyYsE1+cmrYZUFTG7qMjp7B1g6c?=
 =?us-ascii?Q?GpPQasSCPDYPNeJc58iy8kixguQ6divJrCMLqWKR2P2K4NU/keAy/5imZJMc?=
 =?us-ascii?Q?rBKAJ2WllQa6FvXu121bXzEMPDGSlKmP/kiV4umNi/6d2hebowoZxLYYFF9C?=
 =?us-ascii?Q?1XACQubR+PpDPzNt5IM59IwciMP2nN3B95hBziNAYBld3QpdHLb3EnJIFVnw?=
 =?us-ascii?Q?7fd1bPEnamIGA2nBTVWWXVRg3kyeStR/avgHHKZyEmnlj+ilxkYqotfgSRsM?=
 =?us-ascii?Q?TyJh0/06hv99t90y5ipHNaHuYxIGABXYyARQ7KQ6tSChUjIyDFPns2VHYuC/?=
 =?us-ascii?Q?AZSCci9/kGRgmcc6w6ZdfE9+Dss7w9ySMmU7z8khq0teMEBUglGu/BN6+VSs?=
 =?us-ascii?Q?U+EeePd2IV0Co32Ixpifrbs1+uYuxwFjy3VWjxWqSYTam0ivolxp8BKqlfCS?=
 =?us-ascii?Q?+slZR7HndT9oJXQeyXbP+c0cnchdmXFEpO8OtYcVKM36vTCRq/BU4t4LDrTX?=
 =?us-ascii?Q?Mz3Gwbn174FPTWrbu/iT99nDYuSmT5XfQ+f3L3gadUhaQJT6nlHkQCDASkFN?=
 =?us-ascii?Q?S0R/F+ktmHBEbVfwPrivBPi7f+DgYEeo0W1v5hGgk1+fM+G9c6XvEHhGyNjI?=
 =?us-ascii?Q?xoSg6OsPnMNaU/T+n+74KwWEAI0YxtF9RrY4+Z7kFozluwMnohc0fQvtEP//?=
 =?us-ascii?Q?GWtYkYm5wPCml7zrIaB9AfS5IWy8FBy64PU4qLrqolVEd6Lo69ShhH3HnDon?=
 =?us-ascii?Q?3e6Ok3kJIRAyJ5FQyfPLpGg0QEE4FECalWVJQbb1pbw0otqrsYcNIWUZLTAP?=
 =?us-ascii?Q?2yzDX0CAbjMHNveXdek2MOa00T9sYS27UJQ2uwGEPqGYLYLKohmVK9+n3Y+s?=
 =?us-ascii?Q?C478UB4Y7FvH+v2lLA4Y1sSw55lcKCWccC36CvcNXwaGrhOmMmiQH4WwVNXp?=
 =?us-ascii?Q?zIk722F5UO2sLL81HGy5JgH92JQDqhmc7OeuI0xc6ClsF459VjC5Hqp4X+Va?=
 =?us-ascii?Q?0+OL4DloGpg2VlmFFtNRj+qyswFIdzk=3D?=
X-Exchange-RoutingPolicyChecked:
	pBlq/WsX8zeMlrfyZYT53NQAcx33dJ78E/YyVLCEhfsJXkQsa9sE0gTDoRr46wsOT4B3PMV+sPBPtCYS1WwlyFR2xVrc3XfbykT0TSBQ7OyLZasaPExZw7EHefru5t8NSJlhB9Rc0vH/mawp6ZhnmIWVHShWpfMDrk3K+9l0Q9LsPTVMelJcz8n1HR1R9l/XuHm9Wg6flr5DjoOJucEUTVOeCOY99EzBXU6Rmtc7HPLXj0c35XbW34do7LkDIDdGeS7LZxBNqCjBn4nx+8M6qfEZiY6Zee1UuGeCRZIBrzv7ALsrQTaNojJ66VIL6/T/tt/uFvAM0uQv+dnTBtdZkQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xlSu/p3WmzbEDZ/W7UPieTRs9+aw0ecWLEJRvdc6SPEMrJ1Kcmr3MChCfqxINOFXvwgk+cImXnJSRmIxL7X1s5kDE+5wE3smEAD3yY4O7wPKDuqJEhTSaER5I53ZGeiNbCpv5sB4H3aAF/YcFWCePEk2sGOGgvMasX1YdbWaGxK/QplLXju/SBNUw4gmgRcXxOG4grarvPp6fM7s6XPaYfnbdCFvj/IQVTUlCj9O5Srd28Q1wBhqqysmX+cVapMouJQz6YiWHDA/Fnmo9+xJiFgvOZJVW5b5PO51P/x9zz9+v51ZEWRD8eIHImF/tkTQon9l0ZgqNDiKe3Dk3hVEJhC0hDxL3YKlerRzZpZ4A3Jn80bEvZ9zp5FgMOxQdh8E7iENU+V5NANcLAZ30nUxiqzzmADx62uA82aURnmEt8bmOzpe1Nh2vIgcQMe9JY891I6JySg00JBgE1ekU/Ogu+acn6Imgb6FyxIQxoTvEnpj7a/tWGi1rHDtB/8Pwr9hKHsbT6krDBo2nRoqi+MsHt1UbSiew2/EZFgEC2HS12+Du7h+r+Ats3m43b0GCAxrguRpsCPmsJL/rFnV6Y0UoNsoWH+eV5xMqWDIZGcCqDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a127431-d715-4415-429a-08df3b93e0dd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 23:24:03.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+p5Pih4OudnXCAeyj+yerKGaI5V/l35UALg1alnh7YOV+cD3R2yRIhMsjhnUgQvDRwQ07c/+CC6+MMS9eH6koRJ1aod4+3ZNCHPfijuWPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=888 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611050093
X-Authority-Analysis: v=2.4 cv=OpXaWC/t c=1 sm=1 tr=0 ts=6aed1016 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=6pGoc_jSpbJ7s-4v1twA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-GUID: U91fY8rO1pga3wjOkn9b0Oi6hXwPX-j9
X-Proofpoint-ORIG-GUID: U91fY8rO1pga3wjOkn9b0Oi6hXwPX-j9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA5MyBTYWx0ZWRfX8OGeTcqESyHK
 RIsv2cxqZDrZHyVkFMFDNjCr5sJCLs/8yChfClCgcVD2OexZ0JBJ9B0Sye8TUG9Zt+FTkHBxHs3
 H1fp0rUOZSCLr3E1UsAY9Y0VjD4jdXN/65cds+KASIOLXl2DCtyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA5MyBTYWx0ZWRfX5UJOuZHsLPcP
 x7vmKSmM2KoCyK/bEUwe6pai57DY6GElral+1YdAf8hMMVXfBmsGrMixa6/5AIte95Xoedn65ud
 4S6+P/2BE4XdJnkD9NIYiFUjELJPZRkbH9hsPSXSWNrcAAkWa12XODFQzOxwrlyQCKpN+TwbCJe
 a+cIgSIy3eXXxjb+UWI0ICDb986tHQKZhYWBz3Da7tJfl+cuWI5+PtYLFaODj8TXVQRKGxEGu+g
 4xDoIeUTklHlt53Hp8N+BV5t8paaBTX8ydIABtx5Ii/MrefHXLTRHuHC1ysxtAyrdklqzevd1n9
 EK/qs4KeZ15KrpkTZqAPk2WIRCiNr62w9bFQLhSZbEsJENc7MJ9YmL8VJye7mJBnDxMaNax2U2F
 IX5/MvmdQxFqJ7LVapO2aK34vWKytLiWkF+RPLKkk0ccoRJkYp7XntNqJ96Ws4TQ/HMQfCqZ/hr
 Ocoj73GG/a076zbJKpOr7sn7kq7CLbqaZrOyW2Nw=

Hello,

Drgn builds stable kernels regularly in order to run its test suite against. We
encountered an error compiling v6.6.161 for ppc64.

The 6.6.161 update contained "powerpc/iommu: Move pSeries specific functions to
pseries/iommu.c" [1]. On ppc64 configurations without CONFIG_IOMMU_API, this
breaks the build (details in the patch).

Thank you!
Stephen

https://lore.kernel.org/all/20261017160448.281572781@linuxfoundation.org/

Stephen Brennan (1):
  powerpc/pseries/iommu: Restore CONFIG_IOMMU_API dependency

 arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.52.0

