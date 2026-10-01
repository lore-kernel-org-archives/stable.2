Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE3514779;
	Thu,  1 Oct 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866288; cv=fail; b=K/gb7tIvQ9I/UQxCyY+ciph2zicgmVGWTBC5F6eLOI0khwhmtpD43FtUFYtx8fNDRYKE+E5dxVO5CPkfkpHkPssf6o496jRLaNL8bA6QvKwv9aZC+O8zv7AVHVIbex9U5oC/EX1rNliYn+ZTtVSOCuf5Z+jaU9jfFzXdDAOgzVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866288; c=relaxed/simple;
	bh=klLlUzVl2OHvSOmofLGI4scAZQjq5sr/6cj4SRTAobo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXvRqgg0UWmviIOfqqNwwAt7ACXhwlj1UIGmis5KCm1DqgB1WtsqXdhQ48h9X2pwytlJQ4r74qz91oi0XdGM44Rh06/VVRxaOixPKxmOzweIhfkJS2e9UlduPHyrxtJMSOqIOsWaOjn3PzS/qGNZqr+ji2wmrH1iJNy13jMmV0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qYf4fbuP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xc3Ze+iR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qYf4fbuP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xc3Ze+iR"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMroD624564;
	Thu, 1 Oct 2026 14:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wKI7UGzTfIfw02bKeXN5sUCA9m0Nk35g8/30Fb6mEAw=; b=
	qYf4fbuP6H0NneyHaW+YeWuvD6k5DzyaY4xOWOLiu83fieHhN0/xXXZdmmYlSfu6
	objjA7Gv1MxLIqHBHfxP/lIWi3TA+rdrvBxGrx0QoYfG4TxCHvhfcD43A0LCijAF
	DQYY7D4BunPuirE6RaRKCQUu6xjjCXipaMOTDKxjR9vi5Outk5FOZ5BltI8zIDj6
	3Qm64foBGKKyeLKPaaLPAnPcGCJXSEOwocNZsGWvBqAQxmUoJs6LUjTBdUJM9ceR
	nu5pglF2kGxSSFogY+YTwRn0IjbiQifDLGF8+e2LW8VB5Wi7nmsWbKMeRzuTGpZJ
	Wb5R+iedR27ZuUQrdxJoTw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns102c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Enq7S017292;
	Thu, 1 Oct 2026 14:51:20 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gexy8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRK7s8qO4SSFfdLb4WSY8Wv3pbCra+lQo7WONqgHRg93KlXJxQNRsSTk46DcMCRLeb7xmN6Dd211uRRD/kW6mv1LuohmTOjfWoiPTw3VNZhWHBeujF6BhZ/ZkEjl9MbMRQqj+Gtj4pgbwbQ1qD86L+DUmHA2pxpsS11TDLoQLeQs52O9iPjPUuwb5jYu4JSfM6s92BodSeRczIt9Zc65Dfn3loYiZjElDp9VDcjSMtB0Oj9pBzzc0/mdGPJdPQStTWPo3jQyU7q3l6dOOuM11Zb0Be3WGuIzLwG2Uu0JydzHVwDyo5aM8lz4Fd694tnNmqQzvwYnO0fF2z5BoWF9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKI7UGzTfIfw02bKeXN5sUCA9m0Nk35g8/30Fb6mEAw=;
 b=aJA+KaRIzDWigpcIblqn7iZmnsvSJcnK9/gqfNkSUhACKhUM5/iSZ7Qh6G2Y4mCtS2/SHYlB2bqGVVVHUWOgOcJquoNOyWhP5vnpQi9nWqwgI+KVISbp2SWy0rPPHD/dqNir2OPLeG/VmeVHzlnT8W32722+D0vVh4XYbC7VXZwdEcgTXtVUazPof2EcWK/RnOLHzxXQ82cxfrOBWYI1eLJmWTSf8X+ElOQq4loLpExzPCVL4msZr2bjvMt+1p3QKWaEPBClWRxUoZWFIkDZflDDCdWbJFtC2HEyuEHrZjWIjlTQzRhXDfQOGEsnqEbeZoM8vtwddiFEq24gDceG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKI7UGzTfIfw02bKeXN5sUCA9m0Nk35g8/30Fb6mEAw=;
 b=Xc3Ze+iROjRx4K6lY1fSJTcZgEHcG7ifN6gdXyIG5/78WGxFBDR4cdU/DW9B63zSfCLjY6xwd5g8yoWIh4I7YKuEnhy3nBN0X0DK5dWF0ObQoTCGqWlygAuhoDf0pCWgHpJNPieCUuYNIZmhQ8QqWgGB8HPb0aqInJh1zt72Jig=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:18 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:18 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.12 4/6] xfs: rearrange code in xfs_buf_item.c
Date: Thu,  1 Oct 2026 20:20:50 +0530
Message-ID: <ae69a74cc18a132238ff9bdd33efd6bd89fd979e.1790864403.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864403.git.siddh.raman.pant@oracle.com>
References: <cover.1790864403.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8a22a3-0219-4473-5eaa-08df1fcb732b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	B0xZw8a5ItBM9rrRXdigtNQNlorRWodd7PEgZqPwSEr+DNibw1O0pCNcJykgTtYFCI15Fd2kD7R8JrXZQaJD9/8Qz4cMSTBywwQ6+FPSMuh+hcY0NdghH5Cd22bqIkpiue7XizrUY/9r2eQaVOMNYOuHV+70lYXugvz6arwH+G77kqkyp0KUVScgXIIcOhD8J9KdYgrFSQAOp8JsQY6dQAZU0XReW0lsUN2G5zdc9FmqoK30OTQS6vQSCgDDUTqCT/WKcll76qzdVF1SKlEIAxzOighZUUNnD6+3iz7qlza1+JlOI74xNPMPFuS6MBDmE2zKUw1Ivy2PTigrtKUk3S/azkTztoG8XY7Pt9024YqcPUDBv4CgFLwa5qaSaCrreUyZZUlmvdfMX7iwtYNSf1nEUyyMJVlECxTbz/BHhOJ7ZS1I2wk6LtnIaRWE389Sd9shWyKZb2aW4+ymX/rJoY++A4xcKApmvODvPnm92wO7FgEOqyzx4wVDCktdd4jIC9BgMvkOSnmZGclYho/W0SSSaq66uyRAlUTv+2FrqkwAM1OlLdX+tZ1qXO0TWDD506DjBa3eYfNOzGDahgkCdgNf/ZiX5u64+4aCNPBltrdizpU5wR4+sW8xVyyBVwmeC7fptmfNKuLgURcSPSTtetFsCp2sdxg8KiHZImB8U3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?deNEy4F+kuHPtD8Vr5vkyGRCAx/K7jR9wpQkdjGQODqLcumus+m5fTKO3TUG?=
 =?us-ascii?Q?aWKDilx/JoW+NuEhiNWzcshJ4oQbAFsm8f9VxZxpZ6iwA8l+l2q3sSZWq/jv?=
 =?us-ascii?Q?+tLSABv0+exCAWTrWzvalKW0UZXi05kMPFoDUe+K1/VXeBZeVvpt8ad1KA8y?=
 =?us-ascii?Q?dBLB60A9Z3jTl6xs1oMQFELWwlx65g7icjqu1iiP0sW077y0k9OJPjzey7uK?=
 =?us-ascii?Q?5cAckW2TVXj60bNT+AjMYJ8OA/QNSnGRaieceYm34QAAyqqRGPNUyupDPjSl?=
 =?us-ascii?Q?ewuEj31iBGrnb4XokqfS3IK0Q6azliO7b8kd9m536fsHALu4sgNJd4xBWtT6?=
 =?us-ascii?Q?o4BwDVeT3CwpfAahJRcFzx69nQ+gosS9q+xmh4dT9i5WwVBxyqcV3nRFwNeX?=
 =?us-ascii?Q?V50UGBtzELB6y4OCMCjxfIQho29xwTftfq3TxdDV4oTFmaIX9GD5v0EWHcZ6?=
 =?us-ascii?Q?3TaLtykM94zR/Rt+V561yvHhf5WuLiAz+yYeRijwGKXETtdZcxtDrY7Q2CEU?=
 =?us-ascii?Q?o1vAV6WvFFfUASXkSMRjlszDiIVkfm5YYWxhM40DEIZEA5wKEMunnZQi84Nk?=
 =?us-ascii?Q?PMnP3Ci0Vz+/f23TcGL55LjaTusTTekKCSHjbzJOCJK1/z/wrfdJuKhUGNpo?=
 =?us-ascii?Q?qDMj0ZDFbD1bqOwdgvpmR325eGhlY4AvwgGuF+pMGR4QgjkQtJ7HkK1eqe5w?=
 =?us-ascii?Q?q3Pgdwr4XMKFyKPs5SWJeO5gWc2QygJWzKG/AUKgslyFY6/wjFkdB0+KGzJL?=
 =?us-ascii?Q?t8Fcpx8Qsd4voHOHEIvJ/qYX0UrX2vy1wYpLX1ReE9MFDeFcc/sel3a6lvr1?=
 =?us-ascii?Q?QsLQyPfbF9KP46Fo76t9thqGqP+DEF0stYMQ5hcqFqWUlwytI1nhzGyOiqD3?=
 =?us-ascii?Q?/kmvNTzemG23le6VS5C4Ctw/35AWJ6trlw02LaxEyI1tuyUU4hwkl60IzPoW?=
 =?us-ascii?Q?aobLmTGpCOl1yO6CmO/jA8OP1vyamj1SumS8mbzmOI0Wff7BDMOVTVMsQmv2?=
 =?us-ascii?Q?tVZz86jCptAGQUxsVb3Hc26MmPnaKIwypspoVolIDRm97oWQdj9OjMTS8Kkw?=
 =?us-ascii?Q?QBRC2z0Hd77sigOksYu5/xPuf2eCUpeV9GsizNJX+cSrXG3jWf5HsyW00TBf?=
 =?us-ascii?Q?jMnemKwuLyZQmZ+JqShhMUvQM34KHvnm4342cOkJ1xFUn+fv2rP7d5Q97YWd?=
 =?us-ascii?Q?7D6w1aHLx5YOoIrLGyuJ3lTmEzujuT4/jkfQMh9AuhlvFXM3vQZeYNREsOAY?=
 =?us-ascii?Q?FQ+2lm4sCvsHIiVtU9oqYUR32o5iVPalngboOCi6BCHYeTvy654CHo9LObBT?=
 =?us-ascii?Q?135g6A7vMX+64r4Sfp4M8uqeVb8VyO+Y9jHeUWawoUICJ3Kz6HffyqkofzFk?=
 =?us-ascii?Q?zH2bxqZZGkzQnqUi6QTOJdk8C4USAtaGajocNhEHdony2H+iGnph1SYQDWLm?=
 =?us-ascii?Q?G83AGtLxbT2qKaxnBOc85YjO9HAROt/HDIp8xjxECZPkHTKzdYVI9aHw08/D?=
 =?us-ascii?Q?7C/crm+rOTYrowL775UoVLnFYpJFIKwhzQzaziNB2575I1G/nANMuUhM/aeB?=
 =?us-ascii?Q?liu47+QZz3iBuFY4B2Uc88JuThMaYiFZJ/gg/65Wi+hrWWLIbZT/wRzK3EYH?=
 =?us-ascii?Q?F8DyzMWOma6J4tjR1xIOgWfuMMHFYa1A7PKp87UY0wDAf7kIRZLt9C9Pqkfb?=
 =?us-ascii?Q?d4EEkUKt50ekWLj4KiNBI8r8N6ZB/3It4eQ10drlFsHjGCEcCBGtYLa6dhrb?=
 =?us-ascii?Q?I0Wbv9uf1BenyvbQ5uCQ6cXkHk1wl0Jc+a9GUbSs2Gg60td586sShtwV5Ruw?=
X-MS-Exchange-AntiSpam-MessageData-1: sNSDtcAtZ7+/eltcHafSjutfWxieKnazA3Y=
X-Exchange-RoutingPolicyChecked:
	KiRdf1F4APOluglKV0pRPvCOVsY+7hznciqQoXJmAW7zReNeKLY7tn4JlHzHUZryZzdoPDD3nRPAr3AC0bKTezapvWAgu8vhMWU4QiqphKwzRLF4FCGSEz1iOnlBzpyhXMPXuru0UKnwH7SRh6KDr6Kees7eqnIeDbY6HlQudjV9jUHAgjz7OxUE39Gde6Aa1n9XDcjRB6OBK7GnxMMFX62n/6BY5GaDkGqfS5jpFvDsZWBcjUqUy0R0dCELAYuxJAjHBKaVIgG5yBjldfpAGMLLq2NS9e+uhBZ3y/G71TDhxYiDeyEUlzpmfq4EsGLODP2JE+ftUo1+iP63XAQ0jg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TVXzEOw+qH76wJ/OYpHuGAnbXQQU5jg2ZGYnuKq9xyemOx22liFAWQlfoX5yIXHj9xgrHx0+9XbqzYZrtjELjAEdDzLi2y56FVSp8VgR/Er7QM0LZycSu9Fbw/47EZ80h48IBUtG+fXqzRUDMxjOoUDwEl94jRPBRi6UtMXLNyhR2py9x2yEERj5iPbRRiU60rh7cVd+bfnRBe/8M8R5ZWX2cu6wSqSFs25UNZZSfs2ZcQewr8n+dOyhk1MfD1RYJbnDqnciZT9xAiwWTd7PO6Ev3m6Zl1qf9SoQdkMlZKSJSjaWjoNyj9vKxdCuXlFXg0jtKOoU6rtWnFIx87cySzpPwBw61Jql+41GBdUlpQfwA6bMdJ/pFAssal0J9Hy0otG5lkaXsRjREJVKAklONtGyuMIjl+5PKaQZtVe/8lbpfVWx2fCiVtVvoRu9bV4yKseEXh8ucAEI6TdSZTY5a6Y9k1QUSz596LRhru48ubem8S0HGgSwCxlNCsPz7H1GKyQqc3mOaHZ2Fk7rY2NUgyLJbZgboBdssBoStQqXF0ZA17X5oIt6T+C+SEpWz5dWYnVETTC1p+ALcpt3i9JAb/u2X0CsgwI4uTBP+kL9NhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8a22a3-0219-4473-5eaa-08df1fcb732b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:18.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfU15LtIZz1Zfsb3972eLBJi2LSDMVrPaxR2MfU07WUQ5U6tJy3/04gsknuEaKZydePC/bbQMvyjIb+R+37zsI9eyGhCHer1mapoI/KtNXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3A41QiZ0gk7D
 t5OJ+GHQhxN8Nf5EUCJsQSOMUH6BUEJVz4PTYcuioeGAHHuQA1mo6fVgEN2L3XiARfs3CkWMGa3
 Vbf0AS28N2D9knXuTJ6KJBS9qWeYe6WnPY6HQ02q+0kxz5LO+tQ4A1ZtR2p+0HECcxjk7Nv7MUp
 zsJZstuP11KCA6pFB9MaguPTWRm9MtDgBCNyVx4bzmzyyhCcPlbCITqPqZNd7zCQtyroO6o8IVO
 XUSxzz9jVC365MUoyKgztYEJJBl6NCL7qurKYGRiRNVDwGy3RQAyA0pWZqAMM+5k6x2kKc1JyKK
 f/eD0MotQLEOXTX7crMhvVnwDkz9yyryy+OQ6Zttj2mlYBUwCSLQYuHTtQj4mcjrfp0tiOEE6P2
 HPU1D9SfjlIf5R41BYgOeqHcTf8O4icsX1REytJnzS4tHKFhBY14mzIr36CO0ftae3tD7TUB5vP
 ht1cbZBJWD64imoCleA==
X-Proofpoint-GUID: vf3eypawhn6ZKhEuOtdmL1EOhx8g51V9
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe7369 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX2AgqjenmIPoe
 Xtya0rikddG6c4woovneaEIb+7mP7smuSnEab4D7gonCJJzPpm7DF8aIEplMX87UDj5ELkUMi6o
 zzvyIS4Rap7aYrXqqf+nNEIpL8I552nFKymM7dQ3l51VDA3R4YFr
X-Proofpoint-ORIG-GUID: vf3eypawhn6ZKhEuOtdmL1EOhx8g51V9

From: Dave Chinner <dchinner@redhat.com>

The code to initialise, release and free items is all the way down
the bottom of the file. Upcoming fixes need to these functions
earlier in the file, so move them to the top.

There is one code change in this move - the parameter to
xfs_buf_item_relse() is changed from the xfs_buf to the
xfs_buf_log_item - the thing that the function is releasing.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d2fe5c4c8d25999862d615f616aea7befdd62799)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 116 +++++++++++++++++++++---------------------
 fs/xfs/xfs_buf_item.h |   1 -
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index b746a1a0f8dd..042282a08216 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -32,6 +32,61 @@ static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_buf_log_item, bli_item);
 }
 
+static void
+xfs_buf_item_get_format(
+	struct xfs_buf_log_item	*bip,
+	int			count)
+{
+	ASSERT(bip->bli_formats == NULL);
+	bip->bli_format_count = count;
+
+	if (count == 1) {
+		bip->bli_formats = &bip->__bli_format;
+		return;
+	}
+
+	bip->bli_formats = kzalloc(count * sizeof(struct xfs_buf_log_format),
+				GFP_KERNEL | __GFP_NOFAIL);
+}
+
+static void
+xfs_buf_item_free_format(
+	struct xfs_buf_log_item	*bip)
+{
+	if (bip->bli_formats != &bip->__bli_format) {
+		kfree(bip->bli_formats);
+		bip->bli_formats = NULL;
+	}
+}
+
+static void
+xfs_buf_item_free(
+	struct xfs_buf_log_item	*bip)
+{
+	xfs_buf_item_free_format(bip);
+	kvfree(bip->bli_item.li_lv_shadow);
+	kmem_cache_free(xfs_buf_item_cache, bip);
+}
+
+/*
+ * xfs_buf_item_relse() is called when the buf log item is no longer needed.
+ */
+static void
+xfs_buf_item_relse(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+
+	trace_xfs_buf_item_relse(bp, _RET_IP_);
+
+	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
+	ASSERT(atomic_read(&bip->bli_refcount) == 0);
+
+	bp->b_log_item = NULL;
+	xfs_buf_rele(bp);
+	xfs_buf_item_free(bip);
+}
+
 /* Is this log iovec plausibly large enough to contain the buffer log format? */
 bool
 xfs_buf_log_check_iovec(
@@ -563,7 +618,7 @@ xfs_buf_item_unpin(
 			ASSERT(list_empty(&bp->b_li_list));
 		} else {
 			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bp);
+			xfs_buf_item_relse(bip);
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
@@ -673,7 +728,7 @@ xfs_buf_item_put(
 	 */
 	if (aborted)
 		xfs_trans_ail_delete(lip, 0);
-	xfs_buf_item_relse(bip->bli_buf);
+	xfs_buf_item_relse(bip);
 	return true;
 }
 
@@ -824,33 +879,6 @@ static const struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_push	= xfs_buf_item_push,
 };
 
-STATIC void
-xfs_buf_item_get_format(
-	struct xfs_buf_log_item	*bip,
-	int			count)
-{
-	ASSERT(bip->bli_formats == NULL);
-	bip->bli_format_count = count;
-
-	if (count == 1) {
-		bip->bli_formats = &bip->__bli_format;
-		return;
-	}
-
-	bip->bli_formats = kzalloc(count * sizeof(struct xfs_buf_log_format),
-				GFP_KERNEL | __GFP_NOFAIL);
-}
-
-STATIC void
-xfs_buf_item_free_format(
-	struct xfs_buf_log_item	*bip)
-{
-	if (bip->bli_formats != &bip->__bli_format) {
-		kfree(bip->bli_formats);
-		bip->bli_formats = NULL;
-	}
-}
-
 /*
  * Allocate a new buf log item to go with the given buffer.
  * Set the buffer's b_log_item field to point to the new
@@ -1072,34 +1100,6 @@ xfs_buf_item_dirty_format(
 	return false;
 }
 
-STATIC void
-xfs_buf_item_free(
-	struct xfs_buf_log_item	*bip)
-{
-	xfs_buf_item_free_format(bip);
-	kvfree(bip->bli_item.li_lv_shadow);
-	kmem_cache_free(xfs_buf_item_cache, bip);
-}
-
-/*
- * xfs_buf_item_relse() is called when the buf log item is no longer needed.
- */
-void
-xfs_buf_item_relse(
-	struct xfs_buf	*bp)
-{
-	struct xfs_buf_log_item	*bip = bp->b_log_item;
-
-	trace_xfs_buf_item_relse(bp, _RET_IP_);
-	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
-
-	if (atomic_read(&bip->bli_refcount))
-		return;
-	bp->b_log_item = NULL;
-	xfs_buf_rele(bp);
-	xfs_buf_item_free(bip);
-}
-
 void
 xfs_buf_item_done(
 	struct xfs_buf		*bp)
@@ -1119,5 +1119,5 @@ xfs_buf_item_done(
 	xfs_trans_ail_delete(&bp->b_log_item->bli_item,
 			     (bp->b_flags & _XBF_LOGRECOVERY) ? 0 :
 			     SHUTDOWN_CORRUPT_INCORE);
-	xfs_buf_item_relse(bp);
+	xfs_buf_item_relse(bp->b_log_item);
 }
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 7ddda0aa9dac..8a8a46e698be 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -49,7 +49,6 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-void	xfs_buf_item_relse(struct xfs_buf *);
 bool	xfs_buf_item_put(struct xfs_buf_log_item *);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
-- 
2.53.0

