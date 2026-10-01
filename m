Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DA522EFB;
	Thu,  1 Oct 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866377; cv=fail; b=OS9IvFp+rVXJbobDzUdL1AL7ZMEi1TDsP2i2VdR3/ZoQAynkEoShenRuQ0wHuAt6vfmvy9eVQQ1mh2HVNXIvswOtoRVIjB+0npJjYHgsMGG1QYFj9w6Gk22LDobeKVWK23ALGwkunI+exCAT8cqWpTeElXVBaySNsrHOFR/KOf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866377; c=relaxed/simple;
	bh=E/xkZ1ptQmOz/sG91Xanrbd1Cf0AGu6udNOn0S49dQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEVZvknsJcyQalC0xkV43Si+gh5sCU13p+EXgrJUn9Nvxw3H1mour0WCILl7HYYNshYevEMr2/rmXd9HvTAA9+MfBRL3XslGEIYIDzh8TJ8WBFs6VYXCERd3bgeBwBXpaFkeebqJU9+zzssqo8rlGp2jTbJwYVvjuyZdraKgYZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UVqRzjot; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hmwf9+Ct; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UVqRzjot";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hmwf9+Ct"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMgkF2256997;
	Thu, 1 Oct 2026 14:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vPwPMcwir8JMNdahQi0AvpqKE0CBhssd7amyUXFYD/U=; b=
	UVqRzjotmsrdoMay2H4upUmPQXMo38cKXOF8TmgM/l1YSVVbsBjrdGNukaNojoV1
	LjtakBdeHfk/rXk/tEYm4QQF7sV+u6FMtxpzUfWQW9imP1GpuYfb2kYEwVtrLny8
	+oX5j7sKJEiXF00omQFiyGMP5fnBJREVYHyvmVEedKZcQq9B3zNXmLs5zRv907HX
	pEd+B/yHi+rcICOmHhOY0f4STQDs2KpMOURvAm2gLW45Rk3RT+7S+buBsktAaqoX
	JcuWXxI/0/r4YpiM59+YYCx+vASq1CQh+gZynl12PMPeLTai0IyZpYqTUgQ70U3T
	zfVIedwKdStKgq8dWahu8w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpY8017265;
	Thu, 1 Oct 2026 14:52:45 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey0qe-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtfCGIrlOHO8/Es4nidi518qBn2a6QcPddrovNmbBHgNl/SA7h6+dRwogTayheLfvkqg1vqPiNP6q9IxCZC+Qd4AJIqrhg3oTM9cTRhAvJ01NU8NjJWE7pkEtAMHP/zK2NmlG6yJVfjDcLIhhit+OHUR+tFJI3RdMulXXGoWIVor+iPv6SYF6ImQjoeASSzUbo+caxli2flbnT74cICf4GMQ+86e3WhSTyM1Lx3EINGjKnpLVUknDY8Db7NYIz17RHdr22bVUbVNanHZPeSTPSmebzHjyLJNR098CngfXcLlhv/Fnspd4KK+ozOEHn3nM0WJDhRb0olVjpVeqBHINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPwPMcwir8JMNdahQi0AvpqKE0CBhssd7amyUXFYD/U=;
 b=y26trr5rhnspxtqt4eReLpS2Ln6EYf3So5qBqsN1ATB48bIBWvmbmL1zcDvXKRpm8V1LXH8w6p5Jh+ywHw2kje+k9qWg+3m9JK4ajq9TavPtdLu27sZjTCY/8A5ZLeLpyLqkTs8VnDUccQ5tNxyN0SNc5XIAq0cXBqF6tboIAMV/mU78U622efLO4iJ5jmtjog2ccB0GiG15CxIzRri33ta7wqyURFmCUVBPqPwo/A2yJIkYzEk/d2orF7rHP5v6AUOWjKUmB8CS0vb81CZPIHDwtDhBoB7B0f+ZCdXZR8JlpQel/Vr6F0A1V6TVSVN90yXNeRV6qLw79GpGHnQhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPwPMcwir8JMNdahQi0AvpqKE0CBhssd7amyUXFYD/U=;
 b=hmwf9+CtoNFZbz40AL3RnA1S/eXZs24rcX9gMLHB56wzjGT8cTTUU/DjRAEgdE0LDlyE5WT46jF7OhKl5cj6bn2HJH/ejm5aK7czUxnFusvPBPqNqfB1n/bqLKXNl019lfX4KPdX60UifhuQ7BC8ZG46gYEHq2PKmS6FBK6nug4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:52:41 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:41 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 07/21] xfs: don't nest icloglock inside ic_callback_lock
Date: Thu,  1 Oct 2026 20:21:20 +0530
Message-ID: <504acdc62fd2f2b7ec376c582c7f63556f4b554f.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 215d3eba-92f3-4d77-e394-08df1fcba0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cHajkux7j+e4EmXnhhqqkKk3HmncymamhbXi6qZBWi6LJ8X84nxhWWsDD0Af/Ztk3iM0+FSy3ek/cPNCIF5kTwXBpEjgFTujvxGrPmWNneZKGWsVdLMfCc1RVdlFwvtRv2boXSiattLzG2Sj2v92zTNlSC/ZQB0duZlXllce3wCZaKjR63+C0Y6mRuRzvm96zenRjLJF7K6I5AwnOqhYPyoIR85APv+jp85Rg6zqaqoaaujQNCGa4rEhvqAepw/zDyq5BxFD8sPN354lovYPSJxZ4vLFII8typHMoFDlQrVUbWAgPuVjH21MDNbPvzIOiRTUEv8UHYsICN7zLy+FL1CCXeFokKXIELU0DViFKOaD5CA5jSNKyz4w0Ml18oLCmzKzxYYCeRgvAzLGzWIn8l7x3QzWmd0jPPV/UJG+ofnCIVtsIbnh8klyTOdy6LkBAY/RrZJIedhHDdCtGqwSboNUmrAeAG04SMtZ3ODmVDjuuVueak5P0VIjmVRV2Csct4rDPRcS2jYb2rbD4VTzKxx11p1eF+/xjNA5OXD259YG9+o4sg+HppZunSYUsyTuPyVWoOnuWG2W3ffDx6yo90sFMoQUcQltnk+eEHOHtXbIfn4m9xpf3tpVxuO/EQDjcjCyQgozGi4IhNqSEQW91k1oBNSMIeYWxXc5I+9Rd6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jpOcZhenO2GS71JWfTE3t5q12xVapKUPGu8bDPFi2OIhKaOa6rbi2cUx/py?=
 =?us-ascii?Q?kEvym3fQMLuXC2+pgBwsvtihtV6nEeKDXgBvtYhv7yaPcW71RvFozx5y6MnW?=
 =?us-ascii?Q?wXOsl6yAQgPKGRCyl5RUZSKOZWIUQ4ro5OshRcE0QR+PwAWjdDZeix8T8Z9k?=
 =?us-ascii?Q?e6jhbOnzyj+c2Ax73dWu869GqeUmrVo9yG12L7DdTMR2tj9Hnq9pIf6RLF5n?=
 =?us-ascii?Q?U7HGjCINA4b8y2xkXxcALB6NoPjNYtQHj4cPRqef0bS4lONjoOnC6E7YH1UA?=
 =?us-ascii?Q?t28tOCTyIYWG70woqEtAaxUBtTMDzv4R3iGl7Jk5qZz6h5/2zB41egGnO46b?=
 =?us-ascii?Q?tKKO1GIbi6ZC8yumhqIi6dze4jo9J/ZyZIbgGWpiSckU0NayW9g+kvu+UTr0?=
 =?us-ascii?Q?8n5vJOg0rm/vHw9U6OBu9yaIGLgZM6GNzMxqOSZSbMYMKY9DMOXGZa5v3zg2?=
 =?us-ascii?Q?rSGV7qzgGARBcjLt4OXsvJsj8JoF9X3yit3Gv+KMhWKrrAQx8iEasgHFIv1B?=
 =?us-ascii?Q?ueaF34MrwlbeU9u6tL7HUIjWmSHXKKCdDHxZPrnp3C2DKVGTRpWY1TArYmAY?=
 =?us-ascii?Q?5s8JuptbdE2ACLYs1xLrTcD6Xe0RV8KfVRpec/oGCX5BNOEydrMBhvjuQvTc?=
 =?us-ascii?Q?bxmayFemdAImRRS93flFvpSn+pC0YnxL1OWqIhe5Kp4hDQ6cjzICALlaG45K?=
 =?us-ascii?Q?kvCskor7MwGiMB477YtvPrHHmWODNoknx+2kizT7UUf765IP+LhunQNzAYMK?=
 =?us-ascii?Q?GejnAvOH9cIPmQ3EJTi5pKZlQMspw/ASHzijMLGUfx8GBZFdrIesT6TyBTyB?=
 =?us-ascii?Q?6p2u3nLQvDmAmXFojKiyqF4E0oGbaCWwFJtuZG/1MUQ8EKYEY5f+3yI20YGJ?=
 =?us-ascii?Q?sYWtnc/s67ikEcW71VKCk6BvjYhF5uYjNt33fEN60nobw/ixIkUutIJhqzrC?=
 =?us-ascii?Q?lg8CRZaIdGN827BWtzvMkfzqeSaHnKIAA0ebOKAC3UP0dqJ92VcM2tqvsDxV?=
 =?us-ascii?Q?Mw1KlUEimAVNETic+XGl8owwmmWPMMDiScaYkXGA62sD1jLg/MzjaTLbSYDR?=
 =?us-ascii?Q?g7Xg10nxGR9Wpa4wZuupT/GuSp9o30Ahd6LV58Z5SHM/JSFgsYazg60W46fr?=
 =?us-ascii?Q?/ymJ+cYcd6lcnroy82tuaw2JibrnXyQpapHeCSdX/dl7M2oXYAaHlQH3HMBU?=
 =?us-ascii?Q?+IRov1xn9Bclv3j5jAeuM0SDHYLSvGqnRCTRXewJElDCGfwGmT/bPQj5bZx6?=
 =?us-ascii?Q?PawbLcjNtMyy1V89GDDjHOA58n7at7Xpfcwluya68XxakktE/VqSavMIA5E+?=
 =?us-ascii?Q?mRZ9xI6uAg6VBbafny1DLhel896/LOokTYn4qfPrOf+QAPaCXQV6pDciiVZP?=
 =?us-ascii?Q?iAfKmQggh9USiYaUJtM60fHDEbOuOk5hhj4nv/aO1ujdMeZBS0hGK/kKUL4d?=
 =?us-ascii?Q?QGmNbjOYPHw72G5CEjncfg7LRZAk+lr6GL2B+O0W2+L4vpl0A/Q/BDx/w3Ht?=
 =?us-ascii?Q?H92srvXdEurpSHX8YFO7IH5brKRYz26uq2ZQ6Co4S55njsBvSOFtf76DiNJh?=
 =?us-ascii?Q?+avU7enbE23BiHvx64wsPwb3oDlucZirTZ7zfCYNWYQW1pOfaeXw1ZJM+NBc?=
 =?us-ascii?Q?P4FWiS8aUywRemMArjwk9FEielc3zmtVQoM8JK2qvv/FlaqHSivFwISIjjMy?=
 =?us-ascii?Q?DdKUZNeLBubtDogSV7451qSgZbfxWNZVRMG3ONsDWMQwipXoLAyO/Mw3yPvc?=
 =?us-ascii?Q?P18dp8mSjpJoRiFv5vudfMqdPEaSLFzh7Hs9K1vbQvnk0iDrGXaqHgnKnIrV?=
X-MS-Exchange-AntiSpam-MessageData-1: +HM+WI66BbB0k2JS3jjy6hC7LwdrVSEMoFo=
X-Exchange-RoutingPolicyChecked:
	4BKGmYlip1Jr3tCDM5FH9gQ6s8zcd3ZAil4iEAdXU0fWVkHgoIIncrXkaCUamllGCxo941yx2gYzkUT0NKEEN2SZEyEfuctac8SygYeDxJAG3FSOdqeKyBdxN6nXes1PWW2bfbmoNp5KwytK77CXgToCNt/aPxDuRAq07hAn4/1GUBkPxBBKYAQMWJxsxzz1Ndzvak0T7KZyC0GKrQxg4nVV+6AOKwuD47fO7HzTq6F2onnGU4EulAryDOGJ2eId/TN+MLZaP4k2szdnJx+ItPHgrDCwEXSlhGk8ZQb+xL6xOZDP0Y1guLjZ1nPso7St7bOByD1iDoFg6aC6FJHJTw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCyshn1g4t5eXRjDru8mE/tTn7VqPDr1qD+V1ZYdE+l6AdJoQ/4xqcBFwhE7Ss+qJHcxczKmnqAxov4SNf7PyiLHj9b0ZHoBUiIB5xj2LP5syHfa2Zo2aG5JgGqyl6HOMPmmGMIMIWmiAjjOiaakKS76wnNvfEMqJv6KWuttXQuEd5iVLgem2G/2NxabE6xkt2pJe91ZsdGEGLfrLwy7ZYDFofeWzvFBxMneBrXwSZcH8jn/h9ux8JFR72Z3p9CnUSJR/EQxl2BQGbba2TQSpwZlrunxoyTiLKFmoHokng3hGef5fm79Z9Jmj4wckpEM5Dw+8LudioOSiDla1xj5rx3nNfNTKtrWXqjnUWrHx2kXW7sbquC39UopRdRzOO+6u9+cfxPMxyYIXFxCINlCgeG1G4t6v2ev8sLqGXuzCzB7BPqxwCNfmzX0vqjSykjk6sohMs1K3VOlJIDrzqSHj9Aj+ijgJk+NrzgDD41CiJBCKr8Cx79F3vbPZAHdROegCe5aPfrCNYrEwxXjj7kxb5Zkt6kpCkJLagsKS4LH3yR5WmdGjx9a/++4UWeAo/SQKCaJVafIc7ZCRGa+STX1XwDNrflYyVsLk1PxkRRMFFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215d3eba-92f3-4d77-e394-08df1fcba0c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:34.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1toJjEm7Sc+tgpfNjFBdxVHiSBKCJ1VTzBw0S2ScslXuMKo/z52CECc2mBSNLK5GoRcJO2gmHO4Wx2uCxbJvSKcYkZ4q16VwyzeYiIxmdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXzthjQYRTJGzY
 L0QrLqiofcFP15q3n4jBd3h+kD5IKsMsMvFZmqKYW7Ykqqiz+c3XQ3hGN8MqoGzjaHEAsBbIkdE
 p/a3dZuDIRcxurGRrWmxVxE3hoJFwLSv8iXsrE8pTtl7n7NxOEv8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX+R2MovMZ4NQ1
 WU0ReC8YbrNsyYqOelAsGzwGMKmDZ6TFXmAj53H5BbpFPLY0QqU4FHA5YN2CHHxg9RZoJ5+ME8g
 TYBwr5Q+UCaOC81tZeZbFp6XdUYfgHV9wgsdgi4PGmabWp9igkfjJ05vYnYToGgw0dAR2DgRgkv
 l2m9EVa7K6ZmopKf5NLlyKoc5aGl9HMHmbO4UTQVNr/Ke4SiDa95M5OvU9zrm/gwUkVH6Upapae
 BuGr7iLFWwy1pYkhKik/JV4WNzVJI7SueaWukyPBRYjTKe94Pr+k+I64XVrJ2uK/37dXLlTacqt
 BtXl7xAnlyUZFGMwlOpFq+uyo5x38MWaMnDudVK0LJ99eZ/7dyAdQ3Jy8bdKi2bK9fC0qCaQihK
 uTA7R/Lc4i0qeNzaW6oZMv0RD2mxoxICG9RYLCMvg+8ldI7JdOAEw7KvfP6U3aQ3RO1im65x255
 uqpzJFwLRMD/8yaEe6A==
X-Proofpoint-ORIG-GUID: qUmdVY4J7n__87lySRUMrRrTI13PKSrw
X-Proofpoint-GUID: qUmdVY4J7n__87lySRUMrRrTI13PKSrw
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe73be cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Yrdf2Ick_R6uxJIQGh4A:9

From: Dave Chinner <dchinner@redhat.com>

It's completely unnecessary because callbacks are added to iclogs
without holding the icloglock, hence no amount of ordering between
the icloglock and ic_callback_lock will order the removal of
callbacks from the iclog.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
(cherry picked from commit 6be001021f0b307c8c1544e8b3ac87de20d711de)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")

5.10:

Fixed conflict due to the following missing commit:
	956f6daa84bf ("xfs: add iclog state trace events")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_log.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 22d7d74231d4..2b83b2b7786b 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -2721,10 +2721,7 @@ static void
 xlog_state_do_iclog_callbacks(
 	struct xlog		*log,
 	struct xlog_in_core	*iclog)
-		__releases(&log->l_icloglock)
-		__acquires(&log->l_icloglock)
 {
-	spin_unlock(&log->l_icloglock);
 	spin_lock(&iclog->ic_callback_lock);
 	while (!list_empty(&iclog->ic_callbacks)) {
 		LIST_HEAD(tmp);
@@ -2736,12 +2733,6 @@ xlog_state_do_iclog_callbacks(
 		spin_lock(&iclog->ic_callback_lock);
 	}
 
-	/*
-	 * Pick up the icloglock while still holding the callback lock so we
-	 * serialise against anyone trying to add more callbacks to this iclog
-	 * now we've finished processing.
-	 */
-	spin_lock(&log->l_icloglock);
 	spin_unlock(&iclog->ic_callback_lock);
 }
 
@@ -2782,13 +2773,12 @@ xlog_state_do_callback(
 				iclog = iclog->ic_next;
 				continue;
 			}
+			spin_unlock(&log->l_icloglock);
 
-			/*
-			 * Running callbacks will drop the icloglock which means
-			 * we'll have to run at least one more complete loop.
-			 */
-			cycled_icloglock = true;
 			xlog_state_do_iclog_callbacks(log, iclog);
+			cycled_icloglock = true;
+
+			spin_lock(&log->l_icloglock);
 			if (XLOG_FORCED_SHUTDOWN(log))
 				wake_up_all(&iclog->ic_force_wait);
 			else
-- 
2.53.0

