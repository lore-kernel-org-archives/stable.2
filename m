Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AC5218AE;
	Thu,  1 Oct 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866307; cv=fail; b=FbTYjVvBKun84snNbd6SUVOg2HQM6FNDmsHfFctpmT8Z+2ltfo4L6T+IjM0Hss8Uonk8GqtSocQOoXPWzFpDoV3OXeq3LL2wp/TZaCIv8B2ijjiaopNhG/a5a1C7l07reyxfMEw/HybT0NzzUHsy81x8Xhq718u0nFFq5vX+wW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866307; c=relaxed/simple;
	bh=qfPSZr+UozdFhI3TY/T/sW1+dCGj7KzQtrT2QerSVqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpE49AHEK46VuG7Gm76+M7C1LwkmdYDHUbuuvEXj6f3C7YSuHTcSzXKor7CWHrsD5rGzCB9VjVSEF2Tw1zyDfJAhJJ+xg/1lIU8mOggR3Ux4oyvEQUMGufsy8P8v2IzywxC8VIliQrYRS/N8peUknToRKECLGcqU/kWBkUWVrwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YdRkk/3P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RPs/a1fe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YdRkk/3P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RPs/a1fe"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMdGf539276;
	Thu, 1 Oct 2026 14:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JSCXVihtmh1Fv2aozfVrV66lJhYta5bh0E6Ap+c7aTo=; b=
	YdRkk/3PXJAC7JVRp1e35ilLcQElcnWscBb5AZIvKnW1xhlPHVO+L4VvQJXL3dib
	gYVIXKdTxq3bpj+CzyCtCw+Csbmadvoj/mHahYMi8VlSn9aY/IbfD3E+qjh+9wSu
	W/CM/Qq1BbicML4emyjo5EGkfL2d4ZdHhyAZ15tu9VRVNQXJ2zOGFCV5il1oyHP0
	yKwP9n47H8aphVFrDHwxfK+5FFZwOZGbYUQFJuVQ6LFpbwYSUFHHQdlQUMP3skjM
	HPBX1tqQ5EOR6HSjx0h/jY1iEDgLSj3PHbYUEwpP25HbPtJWUgCKiQ4dITOnRPyv
	1/khyIPUDNA4qnXsUrl5wQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgyk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoS8p027813;
	Thu, 1 Oct 2026 14:51:38 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsntbn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNUjOI72XvF3R+F6H52AfZf+jLnnqOleukS11EJf3SEHA9yX5DvX1fh/kcEENIs6+IDWWm9dBFM6dD6rfY8IxuUm/2aofs/MJVJ+LN9HylIcvsyG1ooNk7A8OSQQ2zec+gmN4w0MoY5rhAV6t4LrP5U3IM0UPIljVchIj4NBlQktDvwdqYrj4yiEqRwEwHL0JqJd+LFx8KOjLPQgnNpQkf5BDPhAf+E6v0BWmNVz87JwMaM7mC7mn8Nc0HfMXKvCQMyfiRR3ATF8vBzVOgM+tyTIX1eCsmMIsHa9921Ofufhj1FfmA2e+Dsk0sgUfFWdquI/H19p/tAcws4gXcC+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSCXVihtmh1Fv2aozfVrV66lJhYta5bh0E6Ap+c7aTo=;
 b=JzlsDYkgSxhIe4VeHhpgbj2vQPh5KkB727Zc3VbmdB3yqKazDmQks14p/L36Jq2J3YHDRYCLfJnP8p6bFwlDpsvGOP6qxRyN9xYpPPtlq5tp0brW8VFnM3DDveAe5brWBID+fPByUVXWiCK8QaQU/jjA0pNwwD8o50C1TnrkfWjXU8jlN6wBs32lfKJeCygQSv4nX/qNDFUK/4AAmCbkbMrI8XoHPAvohin7flW7TM8Km23/uvD0Amu8ehDLEQL4cfMNquzKpJsdyEevShV45gcOTvkyrIuPK2iLvOK+uY5U8J1vUrQzVgyOUO/ISalv20VV/DTIDPhgnNx4nI/3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSCXVihtmh1Fv2aozfVrV66lJhYta5bh0E6Ap+c7aTo=;
 b=RPs/a1feoXltYwcF6s0Ckng4CFBhgzBSRDwVK862LQNroR8b5xf1jM5Absa2BD3u/NlSC31dHWPQOd2NZWS56VqsgQS+eh1Z0bNQ9qJ5TwNFAkFZHGY1bhIdobZViy35zfH2QKktyG9I5nh1SRSHT5Igc6N9/rL7gQuNnx2AJHo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:31 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:31 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.1 1/6] xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
Date: Thu,  1 Oct 2026 20:21:16 +0530
Message-ID: <f1203e13b8ad67dc23904cf77c502069b2505d9e.1790864538.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864538.git.siddh.raman.pant@oracle.com>
References: <cover.1790864538.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a12711-2cdc-422f-7843-08df1fcb7aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	HIptvnnDBF6Nf/7L9LyQl9tCGWEYEaqfTDUZG4jDEdr9IJL0w09GQ58vTjVfceNEFDR40En4FHV2LQxK/+YOwADmZza13YcaSzEKP0pQPQrzqT1daGr8q6i1GXnY5AjS8/ra0VF+5hlGvcCNKm5vnC7cFtC47Q0+P68luWhzJmwXvzEh+iH/ueW0cC2ef0MTdnVB1vA3A8ekGpilV2uAES9TTG32FLmaXIkFyCDlEczkCTvRFnP4APeQsRpFQt2wAnAkDNvsgGhoT4wjScj0qHX8J7Yw0DqNe5FRu57JO1PGWSyB9r0jVb6hSBujJUYgU9nhe4Ng5jCAoeIy8LCfTML7bXWsTaCSHLFJ8ea6woUbBR4ZiNb8GtgSx1D0c9w4zfLx1sRytRGhntvzp2bTHungUzajtG/7KF6lqXa6JxmjX7wyM5+zPIjLyhkXkuygRh9DYwbt9LjWDzXNpzMMB4+j2YtO+0lO7xz5XOLulazYPyorXTVOImXZ/gHp0nfL7Q6Gcrv4YqSi6JbCcgfKjKf5F4MM8pfnZ4muE6Q5YgJzs9/PG6NIxClIOsBGDOeQHry2iQbDJGAdkzHFgvPmjCoCmcVlYNW7Ips+UK6dGcheC18E+CuOlUQ+oXqpmiGdALYApQI5iMl8UVCdCU3Y2Ong0eaDHtmvf7DTMgd/bx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svc8dSjGFG62TdlbRePCiQsp1FSBbZMg5TX6WjbAlrBYDMfuN37rclzalgHz?=
 =?us-ascii?Q?S6KgBS44V15rkgoPxfCHsj1L0ZkbgXc+W3jZlZAYpfVWGzc6kNNGDjxxpqjI?=
 =?us-ascii?Q?YT74I1+i9/r3M0XtoXs2OBfY4lBwo4e/7n7EOSy0WTOM5ayqCfJh9QTZpwIO?=
 =?us-ascii?Q?dHbNzLFJPVZSGtlVhkzKwb28/SpwsUuWpUvSdVi5tB7mc131rHulchRmADeJ?=
 =?us-ascii?Q?q/eB2EW8S4BLKyH5zeN5zqsmvF8BTr2/bQnjBnShQH3xpuYPBpS/BgiPzLLT?=
 =?us-ascii?Q?I1oupMBgxTKTPUY0NEACiT3A/YSziLIydF/CtXxbROpYfo0YobqlOqPmo4qV?=
 =?us-ascii?Q?Jlove5pZKeu8WMQZRW6lTSfhjNihERgMabJZNTeXKolUNUm2CgM9vvtcpQuj?=
 =?us-ascii?Q?sH4sEuEdY7o4Hf2vK6/y0+PJXsdnEZBEqJivsYFDdckB/PV9R64snAeLWno0?=
 =?us-ascii?Q?AE7kWQyHQRsjLC3syD2nZkNv4DA8llQptW95mHLnF8iK0nCeJDJ/4E3t5bzb?=
 =?us-ascii?Q?6XZDIEZdRtG8/aDfhyk6YON/lDgXC3tKOfXSJRyCADKPhka/re7Xdt7fXJec?=
 =?us-ascii?Q?n8fJkHRSinyl6fjSdAGZ0EtVkWpoxmZ4ZpDjgWgQXuaWQKZmQAzJ396IKP4R?=
 =?us-ascii?Q?I3QpJJVcfC39DP99sAXMChJcfdmRlW93//c3p98jhLn16iufzcKPstWEQr97?=
 =?us-ascii?Q?q65zU3nh11rc0x9tqPflyEXWJoHXbcpIA3S08jhpA/FdnjZNirHvl73d0YvH?=
 =?us-ascii?Q?cSck690LJDujTAMsNyckRXVZd5XevwdcyYjoGdOeiPdrpK606caVtcHEfcZy?=
 =?us-ascii?Q?GOuN9u4ESmnEoK5ttePl7+DIB+Q21g9ik2eIhAZ7hYIZHqQr3xz8QMUCtlay?=
 =?us-ascii?Q?Nb/5kSQIqaTlQOa1C6Sp9NY8dR89GkRx/YgBjc0dVYh+3WYuNXhqFUakakMD?=
 =?us-ascii?Q?sr8IzEHC2o39MogwN3y/ZEz55t2HHJZGxohg+LR0mzT9fwpNST4ZyjyDfTeL?=
 =?us-ascii?Q?dLGRyb1IpN3+wo5F54kIqVhH+qgI54KhqyMzDjZ64VpM0o2x4ECmbid93MrA?=
 =?us-ascii?Q?vK1bSowT/98gLh3NDwGRg4Uo7wvl1bxZ17BoDZkiYUjjcIQWhUWwX1IMsf/N?=
 =?us-ascii?Q?byDYIGTwBOoEEpHLbD1nrKHUXt/1B0Y2cVcV6QsjPL4U3dPnZ260kSt5UyyE?=
 =?us-ascii?Q?zcJO3985wybVCYx7Wy9ffPGDx1Pyffi/2bEKww5+TriAt2FDl0DAtk3UcePB?=
 =?us-ascii?Q?lQGheBlEH3EkCZAuEt0besk4CV8ixqEjgF/gffm2dQTNjHXY6soV/fFhXhws?=
 =?us-ascii?Q?0s+4kPUqrj3fW0WXbygyg6hBUuJnpZj6TPGt/RT3hJqOrmEJdVStsQrdvw58?=
 =?us-ascii?Q?pa2kz9HgTzRFPiBn8O7KrubnifOgwaQaWVicVEkO3on1gpzV5sfqc/0H8iLM?=
 =?us-ascii?Q?tfn00bql692pCDTrumzGNpwBT0tjylxnKnZDW6Perfn7pRRpNnPj3y/ZMOjb?=
 =?us-ascii?Q?Oy1FjqALYmhG1npk8QkNPk6UOS89BQb/u2YsgR6Z2RI+X5HS+8MjjhltD7mD?=
 =?us-ascii?Q?wvD/zA5FNSbavbLD7PR/CR053zMj2NjuOp8VQJ6WzVwIgKfbaldcsfyDYLu9?=
 =?us-ascii?Q?dT3VelnIBNdqYCqXGACCsOja0cwIxtJYgGehDCm8ONZB5frAa0HTo8+qdVKc?=
 =?us-ascii?Q?61wUdLJikJzeL1r57AfE17Ztv923H3wd9ofXj1txhbpdXPar+wIY6IeEW2E4?=
 =?us-ascii?Q?ck1bn5CXXR1KsZaGKdJ8pvD/rYtoFZRQtJvDmN3zQheD7vexwHFAcYkbZ+Fy?=
X-MS-Exchange-AntiSpam-MessageData-1: NQkSMDlSgTT4J9emKl7mOZQjJIkVNRA39ck=
X-Exchange-RoutingPolicyChecked:
	flNBY+g238HjfvGbO/YvvdJHjN6uw/kQKr9OT8SjK3k1jqBQOQIH+V5gp/jZd2fGqDN6ZN5VT+eUMl8HrYIsxhTiher1wGKCvdiaqBIGHc2Uw/nHjkIMppbgAvueGBl16rpCNlNOxqcXmoP2Xf+DKvb2w+lkcG8HezrknpZJ0lHfj5JmuxbZnbRenIhOdtBGyHbDo4c1mZXmeJbe79nAfECtfjXv4jqLFONMhGNc0fImeLCoWw/NMJd6P0OPHl/6FwK8fQn0v8Ve414BgHrdM2F1VrhgJCBO9lqm8X57qc5BMKM4A9zwLWVfLCYxk3dn94ciLFFOxYv/c9niXyzcqw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lumd8iTFopCqiukjC/DGC28sUrT1kbncVnxgUPMT6HrQnUg67SIY4ohYNaniI5R9Du4X02P02sjeQX4YsRyo/mBHt1bx7zcC/lGfm3tP+0dqYcxtNdJgaWn/FeiqgxuuFAbOo9pELhUlHZTwKUn2QdzgufoAGtcRlq4wj9rR93ryMhnchKbsbCrsHZexVaGRjeaYsL4gaxTTUZExxzFGlSmFMJ2rfWa8B6uwpFko8r/1ep9Fa56zsoO+QfkUIHZIKhr1anFAZp8jaLZsBCoJX4cBWfgAa6ZSn80XKBUe4IGHeMFy5DoTRJVeGWFF33JmPgUyFSqqShpCIYP7JDLT3NqHY+Ec2/4tDxTppYB5f9+p1Eegk7RIAtst+VsYroDckVVbYseUF4nfrBtSSL0YXedpqLku5quw4bk6M3gA31TZNqt1Ty+m75NWGoDxqT/azh/PsTS/ceK3N1ypfwQd1gL2HKRVU1dX9s57x8wP15X+yCv6vrRiy0aU4KjMKl0QJzcRHLULrqMPr6E4tTfl3Q+a7a+mBag4veUOf7H6PFTtqJ9wVO3IAARxQFfdCObKt0+AzOkwUNrrWdEGFYSKMcxgkOOE4x/NEEf+JM7VSak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a12711-2cdc-422f-7843-08df1fcb7aa7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:30.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DHoVu4mxBPSffAMUrZdqGAsHpxExTAurlzLyoebjRgi5RXKdszdRGQWuoy2r32WqC2mZFybg0Ls53uBipJR0Cmt/i9/FtulIEt/DDAflxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: aK8VlpiPRXRZOZHqraeMq7WXeHjB0jCf
X-Proofpoint-GUID: aK8VlpiPRXRZOZHqraeMq7WXeHjB0jCf
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe737a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXyRqFSE2XNDd9
 +7WBqn1NyQDylZyzLkHvokUAagxxsclEquHQWL8MmS8tnaQba5ShIkkbS3E5i309cP6nF2YoZi9
 ovzoFPDF77izBrdeMHLKhU2XKnPQhU7srqgbOsdRoNyPRbOUs1W0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXzmgzMm8d6QAf
 bwVS0rNf+IHvUrh6XmVwC1hx/k7qxZyeiz5kOn7ejXK9K+ff+6cApYWqadnLAmzZ5jBWzyOEyi/
 poqvyWoQgX//LFsVFBBvbLCJJUuhnrjcnz4X3w9RNwCO1zoqiX95A1H9HILtWTTwBBxpXRA0TYy
 XYuaw4PWiNUqrY2xbCObl7sdgw+sIgHbx1oCihqk8O7lV5DgyQ02vYZ3wWFR3nK0Am6GTRIYCDW
 oBZJN4bJkNHYR6uY5w/tf7yr67xmcchOXFqu6pRjJK+PZBpoDxMR+I5ul1pnWcwHyaBBoeTPlmA
 sIOF5FJ9iwOXgNXe6TMQLkwtZ+IItB9ZbORMDAp7F+qI1r1I01FQQfwZmYY70VqlkTYgcrY3axd
 AxAHozGeW+AylcM0W3XF+yGg4AgFiYSSRGI2hAYQTrwSo6FmSWx1HNPiMkkBlnRrdYdyUaz9k26
 iNpI6g76rAEMtBLW1Ezufz98iU3/aTzKEJZ1bP2I=

From: Dave Chinner <dchinner@redhat.com>

Lock order of xfs_ifree_cluster() is cluster buffer -> try ILOCK
-> IFLUSHING, except for the last inode in the cluster that is
triggering the free. In that case, the lock order is ILOCK ->
cluster buffer -> IFLUSHING.

xfs_iflush_cluster() uses cluster buffer -> try ILOCK -> IFLUSHING,
so this can safely run concurrently with xfs_ifree_cluster().

xfs_inode_item_precommit() uses ILOCK -> cluster buffer, but this
cannot race with xfs_ifree_cluster() so being in a different order
will not trigger a deadlock.

xfs_reclaim_inode() during a filesystem shutdown uses ILOCK ->
IFLUSHING -> cluster buffer via xfs_iflush_shutdown_abort(), and
this deadlocks against xfs_ifree_cluster() like so:

 sysrq: Show Blocked State
 task:kworker/10:37   state:D stack:12560 pid:276182 tgid:276182 ppid:2      flags:0x00004000
 Workqueue: xfs-inodegc/dm-3 xfs_inodegc_worker
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x8b/0x180
  schedule_timeout_uninterruptible+0x1e/0x30
  xfs_ifree+0x326/0x730
  xfs_inactive_ifree+0xcb/0x230
  xfs_inactive+0x2c8/0x380
  xfs_inodegc_worker+0xaa/0x180
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 task:fsync-tester    state:D stack:12160 pid:2255943 tgid:2255943 ppid:3988702 flags:0x00004006
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x31/0x180
  __down_common+0xbe/0x1f0
  __down+0x1d/0x30
  down+0x48/0x50
  xfs_buf_lock+0x3d/0xe0
  xfs_iflush_shutdown_abort+0x51/0x1e0
  xfs_icwalk_ag+0x386/0x690
  xfs_reclaim_inodes_nr+0x114/0x160
  xfs_fs_free_cached_objects+0x19/0x20
  super_cache_scan+0x17b/0x1a0
  do_shrink_slab+0x180/0x350
  shrink_slab+0xf8/0x430
  drop_slab+0x97/0xf0
  drop_caches_sysctl_handler+0x59/0xc0
  proc_sys_call_handler+0x189/0x280
  proc_sys_write+0x13/0x20
  vfs_write+0x33d/0x3f0
  ksys_write+0x7c/0xf0
  __x64_sys_write+0x1b/0x30
  x64_sys_call+0x271d/0x2ee0
  do_syscall_64+0x68/0x130
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

We can't change the lock order of xfs_ifree_cluster() - XFS_ISTALE
and XFS_IFLUSHING are serialised through to journal IO completion
by the cluster buffer lock being held.

There's quite a few asserts in the code that check that XFS_ISTALE
does not occur out of sync with buffer locking (e.g. in
xfs_iflush_cluster). There's also a dependency on the inode log item
being removed from the buffer before XFS_IFLUSHING is cleared, also
with asserts that trigger on this.

Further, we don't have a requirement for the inode to be locked when
completing or aborting inode flushing because all the inode state
updates are serialised by holding the cluster buffer lock across the
IO to completion.

We can't check for XFS_IRECLAIM in xfs_ifree_mark_inode_stale() and
skip the inode, because there is no guarantee that the inode will be
reclaimed. Hence it *must* be marked XFS_ISTALE regardless of
whether reclaim is preparing to free that inode. Similarly, we can't
check for IFLUSHING before locking the inode because that would
result in dirty inodes not being marked with ISTALE in the event of
racing with XFS_IRECLAIM.

Hence we have to address this issue from the xfs_reclaim_inode()
side. It is clear that we cannot hold the inode locked here when
calling xfs_iflush_shutdown_abort() because it is the inode->buffer
lock order that causes the deadlock against xfs_ifree_cluster().

Hence we need to drop the ILOCK before aborting the inode in the
shutdown case. Once we've aborted the inode, we can grab the ILOCK
again and then immediately reclaim it as it is now guaranteed to be
clean.

Note that dropping the ILOCK in xfs_reclaim_inode() means that it
can now be locked by xfs_ifree_mark_inode_stale() and seen whilst in
this state. This is safe because we have left the XFS_IFLUSHING flag
on the inode and so xfs_ifree_mark_inode_stale() will simply set
XFS_ISTALE and move to the next inode. An ASSERT check in this path
needs to be tweaked to take into account this new shutdown
interaction.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 09234a632be42573d9743ac5ff6773622d233ad0)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_icache.c | 8 ++++++++
 fs/xfs/xfs_inode.c  | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 586d26c05160..18c905d7cff8 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -916,7 +916,15 @@ xfs_reclaim_inode(
 	 */
 	if (xlog_is_shutdown(ip->i_mount->m_log)) {
 		xfs_iunpin_wait(ip);
+		/*
+		 * Avoid a ABBA deadlock on the inode cluster buffer vs
+		 * concurrent xfs_ifree_cluster() trying to mark the inode
+		 * stale. We don't need the inode locked to run the flush abort
+		 * code, but the flush abort needs to lock the cluster buffer.
+		 */
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		xfs_iflush_shutdown_abort(ip);
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
 		goto reclaim;
 	}
 	if (xfs_ipincount(ip))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 3ccbc31767b3..3139363d892b 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2225,7 +2225,7 @@ xfs_ifree_mark_inode_stale(
 	iip = ip->i_itemp;
 	if (__xfs_iflags_test(ip, XFS_IFLUSHING)) {
 		ASSERT(!list_empty(&iip->ili_item.li_bio_list));
-		ASSERT(iip->ili_last_fields);
+		ASSERT(iip->ili_last_fields || xlog_is_shutdown(mp->m_log));
 		goto out_iunlock;
 	}
 
-- 
2.53.0

