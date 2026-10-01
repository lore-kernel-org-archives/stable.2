Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EE523786;
	Thu,  1 Oct 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866374; cv=fail; b=pQsEChxjcAz+IywuWF3zascW9+6jVO+P+AhTgcHgCduSaE5tanxGSrwXRLQkW74PfhWd4iqoqANSyvc4ROhn0K0nairiP3xyl/9N6JJ65+o69c9rfvY0JHwAVfYuZTZW0q6TnXB4ejBduHP9LPtMsaNL3Y3MaSd563ssmtgaywU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866374; c=relaxed/simple;
	bh=LjQxm0tFdlNXl7xZaUKn/m/kDGyXv3bhA4iQv7WlfC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEHhra8akm2hfrtgu+Pq0EXRptJ4YNmSPK5NCTYS6yf55IHpSKZfHfcT6rFnDkzy1b7LGLvKSf0Dbnhijqj6tGOtAmtZ7qn2I5VloHymYhG+AOraIJAFpxA5j0xvuCTt1Yz9eGuspb8OhYMHV6MVJp9XWZjXjTh7Ne1oKe04GZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UxTndiHU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yuVdmUgH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UxTndiHU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yuVdmUgH"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMgn2539352;
	Thu, 1 Oct 2026 14:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TI6fPeo4uFVjGqM52F3EOF7wswHYgfrLi3ygYD4ltxc=; b=
	UxTndiHUB3QCE42otk+fJNdlIUlno/KVFdVXwUe7tq2nTvG7ob83toR0RSJ3+u4C
	PbVki6DVP50BrtJuo8PcDWwBaUZXpAFwepe7LYBunRvGHVRs7fJLvnde7EX3rQtI
	dKW+taZe5jBbYr916n3vxGb2vMGOkxaTXdo6yTxBRojMNQCPfWS1XdT2OMSoccLX
	vNM+wu1cZ18cSj8wOoQPIbe8qCLgy5LS8/zFqivcO2FBcAOcp0Z3M5Ra7vJU0u+l
	7oV77HSz0qKSvoIa1w6zPHHqvg7EzFHbdqi4vxRP5T+FIwj6/qoJhIVa1gzuzoTV
	N1+ZMcc9GxqVZAcfkZWD1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgypv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpY9017265;
	Thu, 1 Oct 2026 14:52:46 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey0qe-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIi5HHxOk1ee5piQCXZMxVC1COuuKj8XZgaplFVcY06y3rz3+jpaMUz1D5mlK140lYJPpnxHEB7eHYM0MPS3GfJX/qk57k1obcfhNJJJIjbKu/CfjsTOrl0I1EDltXoVBcVnbYtpE1wUNqoUkP4ltY+F6UKT7Vt1nTpmyBZaRzUn/RY2x6Zgk3BBC/XpGzJeRZOtqbB+bON9tsrC9ELXQ+dnedTX6QmwU55beTyNUiLnJvmHRPYdzpSGyp8EZfcJ1uA3xj6bVVxmKLN3TasM00tvGEpBzvp2oFXtNEkaJbX0ozEFRI+Y4A77UBS2+oIYxNoGOfp3MlKEx3MUJXlitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI6fPeo4uFVjGqM52F3EOF7wswHYgfrLi3ygYD4ltxc=;
 b=V0F563l84GOtM3xAGf4Q8H2Bwl8e37q+l29z0H9dMNnDVAAQM5uFoNhO8wnWs3cr3X7dQWFRgvGY8geUDkCtIPQtz1DocJltQQhSWsRXTWYj4jg+URDy3uIe/qGpJJtVzlfJPVUSqB6OMqt/ymWMV8BJqqURF0YfXLSwKfUJqSDhAcHOx5G0QFzhooT3ZWBG26yrxAn9i6rBjePRxnw2j4jc03YQdtUjLLZZfZ6gcCGXaqYyH/+tbioXlDgwNQF/z+/4WgQ/bWwDyJhnwH6n23/QBF7LhmGt2N8eGZGqMqB/HDLtcDhA9V0KTwtRVo6bRLbtnotfu+GP9p1jjZUCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI6fPeo4uFVjGqM52F3EOF7wswHYgfrLi3ygYD4ltxc=;
 b=yuVdmUgHAjZkf/iYE4/i8GF0vTRVPhKJqhRFE4JQFw452a+DGEpee2NwU6D7tZXHHslDDh4s8jfTWkieCvD+qU8eJPxP8+fzLllsHRPsDjHcvE77bXge54HIpUxhX44BjpGVAFIWNirLp4kA9G1LeMI/bkP3zh7lRcIjj120odA=
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
Subject: [PATCH 5.10 08/21] xfs: convert XLOG_FORCED_SHUTDOWN() to xlog_is_shutdown()
Date: Thu,  1 Oct 2026 20:21:21 +0530
Message-ID: <7a59a53b0c1d6647b2f558d032287d8155dd67fd.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ba::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b952604-1994-4b8c-cab7-08df1fcba393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gtp3tuFcoJZnAG5yP8DNnl1elIWhLNQKHrbIp0TsnIPVHgI0PZHWMwCvU5t+zEf3LpNEIQ6aTfVacVXD4IbGEgk8pTmMtumSnXDs1+9Y/o/wbGVVMiVHglLoJxuJToH34g2o5Ac5zL1eFbFvUmsHdLqjX/r2sa538DMGZ/x7qY26oZS/g09OTmUK/CuSrcipXkEtXbLfpRDX1yENYMWsv14neeaRoEk51CfsSZskQJw/wImPIC2LBwiDUbdOwpDLT+PkgtL0n4QrmmsIIjfIQRjgNAazct3wt8tTP9sLF1SwDLJmtOjv+4nNIcUBHW6vb6cltn5mGo0khD30T4OD9y9o9mMkW0MMx3bePBE1IZYIg759WIrYpNrmLp+dCQ3iGb5vO6t9e4E+a+QigsnuP/mVToN3nLi/E5iIrqIrceoeCePGWhXtQNrmAg6oAOxRcQa7bfdlYiTB22TmdgZ6lBMK5cBCl1Xo+kTlLhqlJe9bVaAKMf1bJ849TGqYbORRMUgyK61NAHRiVkhoOoAeiQI5od56k/Fs9OWBIZHdhbJ1BfbHvseNcY0o9ul+LT0sKtWW2a7Sp2idr5KRGjbRx7601s7NYiJrX9JV0Ju2hJBNOAcOrK6TugzNjK6F4rma+ECzcuP3ahi3yKIehTQVtV4zrG8ApvW1KFX/OCki7AQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQOQ4jKb7Nh1JO2+3PRS/iIAZVJDAcyKx/ZBiekPguxTmsoSTvVyca0ASr8W?=
 =?us-ascii?Q?SKL9619BdVA1fF83HC955kGO/Ncap+rqfNAhmWED5Nfb1EWWYci/HtGl5w69?=
 =?us-ascii?Q?Yc8/+m4dDr7zSuB/qRgex9W/ljNg4LNc8TPlZAQSSn3sEFGFN53A5hvcA6lY?=
 =?us-ascii?Q?AEfQiUcSCGHwZNZuZbVrq9vkaKKsTvxNZ+see0RWG6lCQKjox7dyPouvqL4l?=
 =?us-ascii?Q?uYO+MVbsCB9awLf/ORfC5DOnSMtDlgfWDDIhKAUIlmKzwtWcrnRLkAkislos?=
 =?us-ascii?Q?z1akM8xdEyOOGouwM13qbmGGCjKEJMdLiXfadx0fq+HyEw4qkXPyQp79cZbk?=
 =?us-ascii?Q?CUBi4xs6IHbLyp9c8GPvS+TLP31e3X/6ArCAmWsCYoZu7sxUdw5yoz7BTda0?=
 =?us-ascii?Q?GLpCEuH7Pc6365I3ucqmqOyQQdkMovgeDyDs3qNab6yk9eNspKmwdWSClZ3n?=
 =?us-ascii?Q?XrNvSPEHyYufgR5QXtEoNY/ueSoMkw3BLpOlGryWHVFCS5zpdI6xC/pBDtoI?=
 =?us-ascii?Q?Ws1/AQgBd9Mu6LfJzZ5EanlVsUh0A1MooOCTFfAnKfIQs2TiTNsVeB/OYn2+?=
 =?us-ascii?Q?lkiWzVguOHTe+urKqun5WhLBb/8Q6zuYaKEWcJPP3Jt5zzWoC1CdVymlr6C2?=
 =?us-ascii?Q?6IriFZBfoFuPgam/vWck0HmYdF2iaAmpdFzv+Wfa1m2tXxI9q05Q2nQFgUld?=
 =?us-ascii?Q?N8rt6gnLgHZT3w94BAUHlfg8lkk2F+gr+F40ufB+KsiDKcMu7AfNDDr+X4/q?=
 =?us-ascii?Q?P1Y3kJo5oSZCKqrhxfh5vehM291d6gPLekJQgarTL1/rMsY0I06rg7OYMGGz?=
 =?us-ascii?Q?FbIcAHy8FxBonU2yv8Zc7raWprLJVuK3mzpJhk0nl3aqQ34s7cfWMcIayaek?=
 =?us-ascii?Q?g/aTiFjq0xAYdoV225f+UjBl/xmBYGhAB1uJzcN9ojhwsu6oAoGEmfk/CIFd?=
 =?us-ascii?Q?NxoGK6hGLj6KbssNAf0smlg7XH02USIUVik3PLHieZC6qS4ryfVfE6kIcXs4?=
 =?us-ascii?Q?AXYOlum+FUBdNfqEBJtfXUhhxS4NLxnUoxKGPe9UXRJxrRzDEh1bA3CnkxFl?=
 =?us-ascii?Q?OrljNv/viMDpZIt8loORhhTes3XsqAapkA0yFQXf8iYz495zjIQ1GMe09/WQ?=
 =?us-ascii?Q?sRvXjxtYEKur8gBrs7vEYtyfw+svTShdt7QVR42B0DA+F+1qDIu2cqcKSm1x?=
 =?us-ascii?Q?zNKVo8VagcuNllXD9BNu/hANbTlHpc5UlKJ+PKRCAWffs7EfVTGq4iLJpt6c?=
 =?us-ascii?Q?im8Z0mBsSE6Vf0qJivcoesmG2vSdyWqZ+B0vLo9ZBBJedWtCKrmre9qfC7HZ?=
 =?us-ascii?Q?WA6ondjuYrNZUZJUXwjxzgH9Qg4G1lx8tbQTwSWodxTBJdsoyhUBqjyEkLHU?=
 =?us-ascii?Q?ijmRt69lTVMf7qQ6OxC41SBb1ZaTzPf7wybTLC/IPze5hW1gHATE3vBIb6eY?=
 =?us-ascii?Q?t7Zd3rbXS/U/P+zun37D5pegnYw8UT58ovMrTYmsc+slMeMsWHdgEuAFPIhW?=
 =?us-ascii?Q?axv79zOrZhTIVtv4VH3jWTipADp/5mwNc9WEIo0rXd4R5BkA2aNIfsgIIP7F?=
 =?us-ascii?Q?ekwnFMDhBT8tVrK22EUMR8ZyGx2z06Or5uTwwfiWsEcQCMvTqcbrRsmh8bKy?=
 =?us-ascii?Q?vg9Qwh0wOS8rF0Hf4cuPnmFFg8RYpAy236ukRKCT3cLk5FsCsmAE+SOcubcI?=
 =?us-ascii?Q?YX1u2uRhHCp2vlyMeR/is8KyWf58yQE2Z1MPuvX4cHfxXrSeXnoTrnkbyC+W?=
 =?us-ascii?Q?ACtT+c+/2N+MgCVaBgzoN/Mvjak6I8svdd3+2XPe+l+3ccpEK6AnNclCKtck?=
X-MS-Exchange-AntiSpam-MessageData-1: zTyG11FEtaU32P8QkbyvWz2MAGpQKYAja3M=
X-Exchange-RoutingPolicyChecked:
	Ki+e5hIzm5ihgWN5FpzxGgk0rpaGbhR36tp19urhgN0CSMzerFsI2R8Kcu5QIBqtm+Lb4c4GkkrQtLidd3+X0o9DmJR0UnyqkXIb9pShsKAZnFyKWdyzRqQ8NKHk8aJxtwtlVzCc4WAch+Pbjx34VDDHhBir0rsUt/0pZnPSoYMj4B5byzRhmoi8pnd97wxUL48TKBRJsN6juVPjs9ItsgX9dPUdmuIQJFezdQWWPtsny3GIDk1+f0+AiuNBMZJF9jjcWsFeasocPQWsy4/PLqdb5Gof9wz8F7O0ySGXkVfNHCFzOq8ar1ITbFGWRDJVpAcZoXE0QLXsH5um/sMAeQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wBHjLer4V3poTnMKfdYM8MfeGEE0fwwrtnV+XHxmUdV7X4AQk3pIS4Bcsj6Kt6Jf8Xt57gLZANnYd4gBjBHstXcwZvIOIQC3D9VXdzFW570gGBopht4/88oyim43aqy4Hu8HepAqO9lMVJXlJwPVbtXaJktPX2vsqWgRGuaUqXBG9VaQvrLCJN4S0mkiWxM6Qij4cb8HUi5tiF8cQAqr9qWKh0DBLTUiH1DEeaiH756mxFmIFu9s5mq8kcTBgCiDx6VNlKr10OpMCsvYhToobOLKCLGTnivllkzhUb/nm2RzOej75W6IX3WHrHh5eplKbDI2n4Gw6ePB/ww+KmTfOJms60Vd0CWWMGf7IR8Rz/q/wvjTshqLgxmfz1aXyj3MrUSCqhbHH8lsMVeMNLNpKdZAfSQX7zchiPuPepEO2ne+R9JTIxMrEUVJZ5CNDTs/TH9sW8U5zZHnimmJBic6B+h45AbO9MZGLrusgDyARONrgryiNHuSZX4Bz0NmZTC+Gs4ZqriAbLRQaCaCMdWk+Qow5/zCkjLR9plBmq6aNgkXuM4rmKReDd9bi517Ia2M4MWSgD3x/p+Escskr8BFr5JjQYNnTnIAlZNbSaH8yvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b952604-1994-4b8c-cab7-08df1fcba393
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:39.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZaXrXjmlcfg0vzCJ6KSvyXrHWrU+HKzZ3RFSmBhk7v8oQRpf+yORtw4FsdA1Hhp3d+hT4dFuYIcYnEU/tXiidK0LSYDWyuA/WnQdtwbZ48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: YdVnF0Y3audmO6zeXIou3l5NCER1_t0h
X-Proofpoint-GUID: YdVnF0Y3audmO6zeXIou3l5NCER1_t0h
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe73bf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=28ojpAUaEbF8HSBGY38A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX+Nhc576xDEh5
 mkSPQQidVTmiYKZRxyqFnAMq0yTaAR83auLp44lBEQmijJ04QGgl+dKCXPiBqO1J6iWvaF7ViQq
 9r1Hfo7O+YsiE8b/2qywnShgsEk/yYzEGqOGXfw7ORsVhx9uH7/H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX9aJPRQs3KFlw
 alonNmTSi0JDRNJwNfAwjNPLBXAakmMXxTsFSFdBeHxzlhyizE6/80ds03jEx8wO8uEQgAOSLCZ
 iXRGfIu6x+M8LiZ7NGlf6WgWqO09p28uIG1Gpzr0QPrHxg3Mu+6r7U5E/k40pp/YHoLzHU9ew3f
 Z7bi/WqIZmwlfNEsOpKThHzHZTkfmIT3UvML86tlVquajBcdjzZgOKipvsSIEWVZtr45StupcGR
 6d8J3tMEHjThoB69RUWVmFxdO8+EjB8B93vAcy3A1OosF89JArndIYyhTc8m7bqH7Ea+ZJlV/Z0
 SASNDPwc4/U2kXqcP0YHaL3rjNDCw7Y2S7gTW7zZ7vHW+uVyALHXdxq2sa71d4pDCFV2kGauCCg
 xlJhuBEYoxJZEIP7/zQw7UJ4wSRQJZAvMJ0ioaWKK8snNP1rywvOm/DgMbcOJ8CzxLeb9puuAub
 WR6DgNnzQ1tQfTY7YHQ==

From: Dave Chinner <dchinner@redhat.com>

Make it less shouty and a static inline before adding more calls
through the log code.

Also convert internal log code that uses XFS_FORCED_SHUTDOWN(mount)
to use xlog_is_shutdown(log) as well.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
(cherry picked from commit 2039a272300b949c05888428877317b834c0b1fb)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")

5.10:

Fixed conflicts due to the following missing commits:
	956f6daa84bf ("xfs: add iclog state trace events")
	303591a0a947 ("xfs: cover the log during log quiesce")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_log.c         | 30 +++++++++++++++---------------
 fs/xfs/xfs_log_cil.c     | 10 +++++-----
 fs/xfs/xfs_log_priv.h    |  7 +++++--
 fs/xfs/xfs_log_recover.c |  9 +++------
 fs/xfs/xfs_trans.c       |  2 +-
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 2b83b2b7786b..bb57a125eae5 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -244,7 +244,7 @@ xlog_grant_head_wait(
 	list_add_tail(&tic->t_queue, &head->waiters);
 
 	do {
-		if (XLOG_FORCED_SHUTDOWN(log))
+		if (xlog_is_shutdown(log))
 			goto shutdown;
 		xlog_grant_push_ail(log, need_bytes);
 
@@ -258,7 +258,7 @@ xlog_grant_head_wait(
 		trace_xfs_log_grant_wake(log, tic);
 
 		spin_lock(&head->lock);
-		if (XLOG_FORCED_SHUTDOWN(log))
+		if (xlog_is_shutdown(log))
 			goto shutdown;
 	} while (xlog_space_left(log, &head->grant) < need_bytes);
 
@@ -361,7 +361,7 @@ xfs_log_writable(
 		return false;
 	if (xfs_readonly_buftarg(mp->m_log->l_targ))
 		return false;
-	if (XFS_FORCED_SHUTDOWN(mp))
+	if (xlog_is_shutdown(mp->m_log))
 		return false;
 	return true;
 }
@@ -378,7 +378,7 @@ xfs_log_regrant(
 	int			need_bytes;
 	int			error = 0;
 
-	if (XLOG_FORCED_SHUTDOWN(log))
+	if (xlog_is_shutdown(log))
 		return -EIO;
 
 	XFS_STATS_INC(mp, xs_try_logspace);
@@ -446,7 +446,7 @@ xfs_log_reserve(
 
 	ASSERT(client == XFS_TRANSACTION || client == XFS_LOG);
 
-	if (XLOG_FORCED_SHUTDOWN(log))
+	if (xlog_is_shutdown(log))
 		return -EIO;
 
 	XFS_STATS_INC(mp, xs_try_logspace);
@@ -794,7 +794,7 @@ xlog_wait_on_iclog(
 {
 	struct xlog		*log = iclog->ic_log;
 
-	if (!XLOG_FORCED_SHUTDOWN(log) &&
+	if (!xlog_is_shutdown(log) &&
 	    iclog->ic_state != XLOG_STATE_ACTIVE &&
 	    iclog->ic_state != XLOG_STATE_DIRTY) {
 		XFS_STATS_INC(log->l_mp, xs_log_force_sleep);
@@ -803,7 +803,7 @@ xlog_wait_on_iclog(
 		spin_unlock(&log->l_icloglock);
 	}
 
-	if (XLOG_FORCED_SHUTDOWN(log))
+	if (xlog_is_shutdown(log))
 		return -EIO;
 	return 0;
 }
@@ -913,7 +913,7 @@ xfs_log_unmount_write(
 
 	xfs_log_force(mp, XFS_LOG_SYNC);
 
-	if (XLOG_FORCED_SHUTDOWN(log))
+	if (xlog_is_shutdown(log))
 		return;
 
 	/*
@@ -1013,7 +1013,7 @@ xfs_log_space_wake(
 	struct xlog		*log = mp->m_log;
 	int			free_bytes;
 
-	if (XLOG_FORCED_SHUTDOWN(log))
+	if (xlog_is_shutdown(log))
 		return;
 
 	if (!list_empty_careful(&log->l_write_head.waiters)) {
@@ -1479,7 +1479,7 @@ xlog_commit_record(
 	};
 	int	error;
 
-	if (XLOG_FORCED_SHUTDOWN(log))
+	if (xlog_is_shutdown(log))
 		return -EIO;
 
 	error = xlog_write(log, &vec, ticket, lsn, iclog, XLOG_COMMIT_TRANS,
@@ -1561,7 +1561,7 @@ xlog_grant_push_ail(
 	xfs_lsn_t	threshold_lsn;
 
 	threshold_lsn = xlog_grant_push_threshold(log, need_bytes);
-	if (threshold_lsn == NULLCOMMITLSN || XLOG_FORCED_SHUTDOWN(log))
+	if (threshold_lsn == NULLCOMMITLSN || xlog_is_shutdown(log))
 		return;
 
 	/*
@@ -2779,7 +2779,7 @@ xlog_state_do_callback(
 			cycled_icloglock = true;
 
 			spin_lock(&log->l_icloglock);
-			if (XLOG_FORCED_SHUTDOWN(log))
+			if (xlog_is_shutdown(log))
 				wake_up_all(&iclog->ic_force_wait);
 			else
 				xlog_state_clean_iclog(log, iclog);
@@ -2830,7 +2830,7 @@ xlog_state_done_syncing(
 	 * split log writes, on the second, we shut down the file system and
 	 * no iclogs should ever be attempted to be written to disk again.
 	 */
-	if (!XLOG_FORCED_SHUTDOWN(log)) {
+	if (!xlog_is_shutdown(log)) {
 		ASSERT(iclog->ic_state == XLOG_STATE_SYNCING);
 		iclog->ic_state = XLOG_STATE_DONE_SYNC;
 	}
@@ -2878,7 +2878,7 @@ xlog_state_get_iclog_space(
 
 restart:
 	spin_lock(&log->l_icloglock);
-	if (XLOG_FORCED_SHUTDOWN(log)) {
+	if (xlog_is_shutdown(log)) {
 		spin_unlock(&log->l_icloglock);
 		return -EIO;
 	}
@@ -3720,7 +3720,7 @@ xfs_log_force_umount(
 	 * No need to get locks for this.
 	 */
 	if (logerror && log->l_iclog->ic_state == XLOG_STATE_IOERROR) {
-		ASSERT(XLOG_FORCED_SHUTDOWN(log));
+		ASSERT(xlog_is_shutdown(log));
 		return 1;
 	}
 
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index fbe160d5e9b9..407e80d06bec 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -576,7 +576,7 @@ xlog_cil_committed(
 	struct xfs_cil_ctx	*ctx)
 {
 	struct xfs_mount	*mp = ctx->cil->xc_log->l_mp;
-	bool			abort = XLOG_FORCED_SHUTDOWN(ctx->cil->xc_log);
+	bool			abort = xlog_is_shutdown(ctx->cil->xc_log);
 
 	/*
 	 * If the I/O failed, we're aborting the commit and already shutdown.
@@ -827,7 +827,7 @@ xlog_cil_push_work(
 		 * shutdown, but then went back to sleep once already in the
 		 * shutdown state.
 		 */
-		if (XLOG_FORCED_SHUTDOWN(log)) {
+		if (xlog_is_shutdown(log)) {
 			spin_unlock(&cil->xc_push_lock);
 			goto out_abort_free_ticket;
 		}
@@ -888,7 +888,7 @@ xlog_cil_push_work(
 out_abort_free_ticket:
 	xfs_log_ticket_ungrant(log, tic);
 out_abort:
-	ASSERT(XLOG_FORCED_SHUTDOWN(log));
+	ASSERT(xlog_is_shutdown(log));
 	xlog_cil_committed(ctx);
 }
 
@@ -1041,7 +1041,7 @@ xlog_cil_commit(
 
 	xlog_cil_insert_items(log, tp);
 
-	if (regrant && !XLOG_FORCED_SHUTDOWN(log))
+	if (regrant && !xlog_is_shutdown(log))
 		xfs_log_ticket_regrant(log, tp->t_ticket);
 	else
 		xfs_log_ticket_ungrant(log, tp->t_ticket);
@@ -1114,7 +1114,7 @@ xlog_cil_force_seq(
 		 * shutdown, but then went back to sleep once already in the
 		 * shutdown state.
 		 */
-		if (XLOG_FORCED_SHUTDOWN(log))
+		if (xlog_is_shutdown(log))
 			goto out_shutdown;
 		if (ctx->sequence > sequence)
 			continue;
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 42cd1602ac25..6e619b34c6bb 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -441,8 +441,11 @@ struct xlog {
 #define XLOG_BUF_CANCEL_BUCKET(log, blkno) \
 	((log)->l_buf_cancel_table + ((uint64_t)blkno % XLOG_BC_TABLE_SIZE))
 
-#define XLOG_FORCED_SHUTDOWN(log) \
-	(unlikely((log)->l_flags & XLOG_IO_ERROR))
+static inline bool
+xlog_is_shutdown(struct xlog *log)
+{
+	return (log->l_flags & XLOG_IO_ERROR);
+}
 
 /* common routines */
 extern int
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 527facd5126b..46b1213e8ff3 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -145,7 +145,7 @@ xlog_do_io(
 
 	error = xfs_rw_bdev(log->l_targ->bt_bdev, log->l_logBBstart + blk_no,
 			BBTOB(nbblks), data, op);
-	if (error && !XFS_FORCED_SHUTDOWN(log->l_mp)) {
+	if (error && !xlog_is_shutdown(log)) {
 		xfs_alert(log->l_mp,
 			  "log recovery %s I/O error at daddr 0x%llx len %d error %d",
 			  op == REQ_OP_WRITE ? "write" : "read",
@@ -3288,10 +3288,7 @@ xlog_do_recover(
 	if (error)
 		return error;
 
-	/*
-	 * If IO errors happened during recovery, bail out.
-	 */
-	if (XFS_FORCED_SHUTDOWN(mp))
+	if (xlog_is_shutdown(log))
 		return -EIO;
 
 	/*
@@ -3313,7 +3310,7 @@ xlog_do_recover(
 	xfs_buf_hold(bp);
 	error = _xfs_buf_read(bp, XBF_READ);
 	if (error) {
-		if (!XFS_FORCED_SHUTDOWN(mp)) {
+		if (!xlog_is_shutdown(log)) {
 			xfs_buf_ioerror_alert(bp, __this_address);
 			ASSERT(0);
 		}
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 73a1de7ceefc..d334bb3ce643 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -901,7 +901,7 @@ __xfs_trans_commit(
 	 */
 	xfs_trans_unreserve_and_mod_dquots(tp);
 	if (tp->t_ticket) {
-		if (regrant && !XLOG_FORCED_SHUTDOWN(mp->m_log))
+		if (regrant && !xlog_is_shutdown(mp->m_log))
 			xfs_log_ticket_regrant(mp->m_log, tp->t_ticket);
 		else
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
-- 
2.53.0

