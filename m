Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAD518132;
	Thu,  1 Oct 2026 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866296; cv=fail; b=qQ0rOXtJa5XNv1+n7p2+ahL5WM2HHInrPjBrRAFwE1nCRNmGTR31qJiNlqElti8TOl556FDlJsq8t4AYInKn+zuyp9z91SQ7EmfHfnsk7FO+ydR3T/BvTly/wadSjLqcjXtxQDDXz+4M5hQ1ve5qrAfe9N37Ry4mKFhKoMxzDhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866296; c=relaxed/simple;
	bh=YLsDzitQefeC/0orD1ScpepUSkPilqgP4sd5u5kiX80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/CKI1CWQNy8L348rRMWP5lZ4J4bkA+uUrj134+gR6gNOXmpRH5etcyFPA/6RVOijpjKi9Xvsh+LGWo3GLJqfGaqe99N896Xry+AvrX+dXBfVFtV6EsCBPqYUAtAW69OCWxCwtqtKKgcsKFTWwlHJOu5WIseYKfcRUEvnHJNDL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ccra9TDi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WJO04bOY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ccra9TDi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WJO04bOY"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMroG624564;
	Thu, 1 Oct 2026 14:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OI3MJJMEfAUrmdHmqL+vEVJLJj1wNcJT3OAQvg3GyIo=; b=
	Ccra9TDiaNm4h+VTd3CWO21Zm5i3vje4S/QoutEqgIOqRCo5sF5oXWBN8TWBR+v3
	YjQkN7iU6PKxPc0TjvAkZYgCbnojCYl8MRG7voGOujp0HrZs5/kBXGqdYxnWrh4Q
	MLK677I+t+wOmUXDGYGrKIwxQgyhgNtNIcTZfAxXVDICHnXbrjhz3Iw+XySEjgP4
	XVU+rTZnBxvP8hTLdJ4JG9gAs1NJ6mJDqgAE9XoKL+UBXYFvDO4rlXQGq9vap72c
	p1dZeln5OqO8UEY3sjBWMo/Ow2Iec0L+6S6kWh8M+fgRPtLQvlrVqIGoOqh/I6/b
	m0jYNE8JJoUxY1ZOefQk6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns102s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoOnp031610;
	Thu, 1 Oct 2026 14:51:29 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd2tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJufQaxvvHfTximGpfmg5X2Mmnlo4MeEW6pOGR8Tedzo0/ZNkWe9Sz5ZduKZk81O5F/Nq2jhvJzWJN6RWR6Llqb9pgWGII9IIdftrSV+puiGugvYjcCFLb7u84IBgg4Tbxb0Syn/8wfLR0SolUOf4mp062jOAqTxaXNQWuOiqOQCqnUFWolCMwunH5WTGzhRmBcXGP3dYWF4sBa1eEZmYheAfaiPgOXLnYVzBhVX3pb0SzfGPY4utiG0/QHd975XHm54lsJvozukLtaJmO7xx5VNeiRycIrfrsw8rLNhmovdZYXZ06+Ngo9qa7PtNW7gupbUnxMqCNRuLXo7hLnjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI3MJJMEfAUrmdHmqL+vEVJLJj1wNcJT3OAQvg3GyIo=;
 b=Ohd7KQZbtBnSJDyLd6CB9vd8Kj/ZHXpEEEWW1axq+rrw4In5/w/mGPP1IGJzVkh8nMUd1DaU19grToB+/dy2JaF2JdXXqDJFnYI06IKX9blx/JzeqjiVm5MM/uDhKMl/lMa2HMgl+Y4fIlSlf6nq0iXjpIyXc7e5Jo5EtDMfsMM2ABa2CXl/Ysk+yNVJ77RQAnEh1XRbm1b7ButWfM0ZhjJBfo8e1TzBfTE2RxXiIWKNB33XJmR1WBs0J9RLhgTkAF7mphiw1OK/rYIe+OKvs/lfmQJBoDNIJsZa1q/d3X27YSl7xRxluAiZA9h5Fu+odmtL5dDkek7C9Wire0Pwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI3MJJMEfAUrmdHmqL+vEVJLJj1wNcJT3OAQvg3GyIo=;
 b=WJO04bOYQCGWK+El7VzKXaRvN04vr7miyQe2nLIBXFPCAupXdqbJsI6I5Vfc/MsPfnH8jU3DNWn3XtHqF0Ypfdo3wwUK/lRfErcIfY9DOSuIb1LdhAr4dImAMiiKVMvXk02C/Dx3ZiFzFSlgx6N6QxAFgwlA/MN+8S7LTrcIoxA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:26 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:26 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.1 0/6] Backport of XFS umount hang fixes
Date: Thu,  1 Oct 2026 20:21:15 +0530
Message-ID: <cover.1790864538.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090954-revisit-dowry-37ee@gregkh>
References: <2026090954-revisit-dowry-37ee@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 532b5ebe-27c9-436f-7262-08df1fcb7808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	I7s/lscKoufugDfownU3DBVjmd73BO0OeStW+M57l5j44GB43CATguZHBWPWDRxhYxmbyIAFGsU6hqDWn+XEQlMFe9o5jutx7uYA148zneR96xUYrU6bqLxGof9jAtcAd7M34dmiy44AHMQDT431CMXqCikWbQ4rLn1dLVMOKcujfOb57PTCCtcvgwkn2Cuq7KZWnVu1r3DQVUEkqaTt4W1aXkQ1wm5Q9RMNSaV/k5BboyCgpUOWo4/jhSLfvAVZYURlqiDCB1Q34Rc0YGIycfJs1fN5OVj7JSJsajp+g1BeHcKMtOjeLPWbBHtmWSK/BzrNGB89uVJ2lBa/2BMwOhcoFt7rg5v9KNfcc+pdRiErTtY64Tq6NuWA567bzTgpNusSRbssaWJYaLDYULhAI5dhXu+lhVoE7x0Asxz6rl5kr65ihlC3PCkaVguMoGtYBujzcMzEejCv4+yWkcJJdkfUDC/TL2XZL//ZmolEB9JYazPwJpjvXZokpnTJOdvgdFSpStY3WYsHy3sQuW6HkWiIuImuO35T9d1fSv0nvS3Gmx5KvaSP5fbU7zyWZixGBTVdoEHuRAGiPlx0lmveuGr1XzWMXyEM5qFdM+mrbEesoHF9XhfrvjDCf1g8T1LyTe34xrYkvoh5kirVRHgkl5A5P2UxUJw25dV3FZF4lSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4LlLjll0GWx7d5aKYk3JjwQhjpK15/RBnWcSwYe6JR52egmMFPWXqrFRV2/?=
 =?us-ascii?Q?SP+QB1C/J2GC5i/rtpnh6lJeV/eJgzViAqcT0E6NJJ2folNFREVEVWjeHFSm?=
 =?us-ascii?Q?GCqHGSw5RkS6r9KnVYIhWn/29zxufDzXLRgePwWO9w2d/dgkuYatPMoLxbuR?=
 =?us-ascii?Q?38cCEZBUqeCPoVwtWuKbvFNPIF8ve1D5UqXGi5Ybrb68UGhM8dpG6efwwL5N?=
 =?us-ascii?Q?g9v5+bQkXXXKSSsxyyIIsOceY61HEnvQqb11yvr4Yn3p9i4M64EvEbu0oeLt?=
 =?us-ascii?Q?w05PwlKnpMrNY9Sv6mwOhpLTjEw+acrwRibWzDE3sCvvJF+VCP5QqV8VGpvP?=
 =?us-ascii?Q?qguDnJJM+EmVu9xnsYtSdGyn15CP5uKZzK5vQp9pmcTshpe2wBx+mp4/R/ll?=
 =?us-ascii?Q?JVbH60QKmw+Yh4iuY6YiGQq+tqnpkUmtPMZK8HZYnjbHwdZTT/poJPpiVCGj?=
 =?us-ascii?Q?9yi1DB3BNLehBqYxcgnyzqtyUrL29LicwO1OtiRxloayHU90Szsg0KBp8CxO?=
 =?us-ascii?Q?LhWZulWNrMfK3U3R0ZeNb06Py6ZwCRAHB6Y9kBBxi4OzfXBlYX+Tt9h8jpu+?=
 =?us-ascii?Q?cK42z3DcVO9P3P7jJ6iBW+4fBQiGB8U9R/fWWADr8VkFYi8Ox+/eXhGrADXv?=
 =?us-ascii?Q?80KQaSQFecmPAQ4Ft06yGXN8HNv0VAuvKxFE5Lvkv8EZWrOubvGTBzGTt4Rd?=
 =?us-ascii?Q?4BcXtSbyPs8l3Lwz9dVKhARsGdKkJM5SL6gSsyPfIIJELEgbSzlOlg3jI14i?=
 =?us-ascii?Q?5PhW1K+3Ud4J9q/s7UqGg03Lqhvd4vOAehdCpJeEbMzyX/j6CMDOEuKjBVAF?=
 =?us-ascii?Q?0493n4gi/mHcASCDuNSoi28WlT49mEB9T1Y62DhHnAVLIWsrdIKImQ6H4/wL?=
 =?us-ascii?Q?sYeFa0zlusiVCEHy2UVw52/krGpDQXQuBvhJZsU5TTiPANwOPqX4DC5FOHl/?=
 =?us-ascii?Q?yF1Em1ZvEK0wnvB9FEgN7ZqZ3VyVwbUAphbZoZiUpAWvac/K9OZ/1XEUgY35?=
 =?us-ascii?Q?AXJrHWMIF5JzojuEJ45mvNWndGvnPYGN0vWtQSt7A/cmbmiA5tiZ5El1HGhh?=
 =?us-ascii?Q?F0bHxkbLW1BD2r0du1daurPZw5PIJ3Ab8MvWsXKgXcueYr7YhPxVu4m7NecS?=
 =?us-ascii?Q?Gg2WmQ+bG0ACe75AEO+37Q7+CS6hr/+sQ4CB4PbBKKkvq7BP5Z09A9tuHJ3q?=
 =?us-ascii?Q?STYXkmVSjsK2mihp6epOSh5Vc0ZKvnS2UQbterZDko/DchFqkaoVrylRBy1n?=
 =?us-ascii?Q?LCoLJNT8wHOyMvB45EiO5iAaD7b+19bHr+Wf4ms7c94qV6iLJ49KyLTMkDKn?=
 =?us-ascii?Q?dMUzCjirefocom+/QDOvF/Rhagp02CE3eGzuwK7fsXnus13zWbm9Ids0tEbB?=
 =?us-ascii?Q?R13fkgj6bWkWiL3I5/2zoBf4ld8f3UneITOLq+e67TUOMPjdKT/YWc+eQimF?=
 =?us-ascii?Q?3GO3zvFnbCu8m65lAl5puhFcgifunXjkGKhZ1Kjb8BZ6I6rabaYfvZUc0SWh?=
 =?us-ascii?Q?lPy5EJwX0NlaVc2R6RxcphsQuqwAhnvqK5c2OI+92Yqyfeoi+kJL65lVzYEt?=
 =?us-ascii?Q?65rIiUU1oaqrbr31ro3GihCg58vTa1f7m79yGNLYcGSXH10zZnOq4iDokzG3?=
 =?us-ascii?Q?WQlYriVqOp/p7/DkvgvQ02a/FOKR6b4EbaCZSBRp5FhXtmeQ8M3T7x6iXErn?=
 =?us-ascii?Q?UTWPpnGW1acx74N342OlecvTeNXApBFehqP5UnDPC5FSxMDfLJhNeV4y92Sw?=
 =?us-ascii?Q?4JZQkD+f029Qz1pQ7cNudszYlZxfb7UJ/HSKkUu0A8YUYKIa6ex7wBbne/tU?=
X-MS-Exchange-AntiSpam-MessageData-1: zqk2A83eauLoCJx450ejdfCLZlDHL6bHwr0=
X-Exchange-RoutingPolicyChecked:
	WcxZU1QgaESZAb3HmC35W0opdb5XBbEUWLxvpIi8AwPhYq7O0vLx2/qWy4bdMzD9wvFvdsWLUTWeerbjRtuw7g+9r5SwYiZu7qIf3hxxq8MMuRqSuFyfk0XcTuQB/LmFS/Qt7Un8WXFp1qSZN8s9hFSM5n+YGiI7sJpqh1QdIZNX9y55oliWiRQ57ONAKe1zgyz4GFpXF1PEgDqTLYRZ4mNfJ8J7eARoxdqoLnBnYWNTR03gFjvfSYUP6HsQp39NZjHhPxzrty7iP4fmMHFcWayOWXBGXIzQlwmMC44YKKYpqlkVkwzGiNvLeIvfofwCbzgnNZjuitNWc68FitnhGg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VAAkDm4YKDzOfGKNEus8KQvaAoePFFu8f/Rj4COHRFDfoOXJRjOgYW+xd8mJHNqva37+9pB6YWiT+NciHfHAoOD/llv2AjjLkMOexwZ5KF4LgTXKLCgE9E8tsRBariHghs8kDhtb8Rqh46MuqzUqpf64QS+siEFKrnAvdd/0jv+eD4G6NyxW6WTgLCa14d/CuH5so7FZ4HtjW9LCz969vyecojkoqYnJZYGN8yZLIhwpzR9Ky3o1Hb0gK2CDeiYbbUTW0Iwwtn5Izdf+68mI9vZfmq+wH1CM3gc5BghLlOO5lqujq6fF3MkTFmHeV4foBnpUdRXSMpgje7m4XnpY/bTJhzOar9JQT4im9aDIYVuCnIHKq6RzZ3UH/+X+Xem7UCb/WSk7xrKDadn0aTNlelMMg6vNnKOzUbOW7lWyWd7hbOePU0t6Qj/fBZuQ15la8ZansE/CPkuN60iyqQXq6Y/wBfjl26ra//XUzOC0en+p9/52oALMX66sJ+brL6HxFLUbFyEG4695NAqZObZ6czTBnz3saY2ABg7KUgHOYnsL40lNyU9TR5nfr+Qoo/k7MipboDJEbrXcdB9nu774Nu1BjjqPjU4Z5+tRQTgakq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532b5ebe-27c9-436f-7262-08df1fcb7808
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:26.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhOSM4ssDVX2VYETTkd+qsZ0KeCwsITo2NVEkn9X3c+fBwwRblEN4erlg+EzEA37jLEHNk6gKbu2Lcp/NM4RE/oIMzM2UTj2E8wcTBSR9TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=784 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX30uk8/hw7arg
 +MwdtOeq6O2/lRIfT+axY0E4uJRcF0cfS26PkAf/HPli7C3ddtNycq+ViqFEVU8uPrchdhCbJ+Q
 qxN7BWLv20vWkgzxfQKt3pNZTS3GmfFj4pbdQOnhwnpDLzyNAgMUOoRI5+ZIsIEfr4UyVn5Ra5i
 TrhGi87aqKev2nAzDAGBmw9CUD4AHA/VNKxYFIaxJGexwwQ4XdEO9mpTmeR6Bpfp4hXxNpJL+jo
 ZLZcNkASlo+dtZFaKU0hc5G8WVpC6U33zG8oRxQM6nSkM22Q+EJCNK8pFvPjY2rlVtnmg5cpy6E
 jn+jDL16Pap2fNiuEIfzYxkWSeVoHRBN4Fqi7/UeHnxG8ld+5Ne8hY8OCMrSAhAo3ysI7c10ieo
 ysA8plFIV6iTN9oltYavx0o64EQ3VVz3rdBgc2x3b8EKdjrnHKi40GC0o0rCHRanrlpN4+M+KbA
 8mbQK+hjIUVxazGVt4dFN0sUtJ9avOR1A78kN1bA=
X-Proofpoint-GUID: jDemrxsKav5d_5-CbiL4FKYvovSbqxf3
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe7372 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
 a=_lStUm-aLo99ZRpnu3QA:9 a=biEYGPWJfzWAr4FL6Ov7:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXw4KzT6X2byjb
 XbeOqKeK7guW9st1rYllZBOaWVub5C7C99czfFz+CXNt/+ElaGjkKjWeP9P1rROaUgWAUcWG7Cb
 PyJTEYOhfa3wg0/Fy5bJ4XZQfZonmM/UHjUo+SPcYzJMPhtNyIO2
X-Proofpoint-ORIG-GUID: jDemrxsKav5d_5-CbiL4FKYvovSbqxf3

Backport of this series:
https://lore.kernel.org/all/20250625224957.1436116-1-david@fromorbit.com/

Along with appropriate pre-requisite commits.

Previous stable backport was used for doing this backport.

I have added information in commit message upon conflict resolutions.

Dave Chinner (6):
  xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
  xfs: catch stale AGF/AGF metadata
  xfs: avoid dquot buffer pin deadlock
  xfs: rearrange code in xfs_buf_item.c
  xfs: factor out stale buffer item completion
  xfs: fix unmount hang with unflushable inodes stuck in the AIL

 fs/xfs/libxfs/xfs_alloc.c  |  46 ++++--
 fs/xfs/libxfs/xfs_ialloc.c |  32 +++-
 fs/xfs/xfs_buf.c           |  55 -------
 fs/xfs/xfs_buf.h           |   1 -
 fs/xfs/xfs_buf_item.c      | 295 ++++++++++++++++++++++---------------
 fs/xfs/xfs_buf_item.h      |   3 +-
 fs/xfs/xfs_dquot.c         |   3 +-
 fs/xfs/xfs_icache.c        |   8 +
 fs/xfs/xfs_inode.c         |   2 +-
 fs/xfs/xfs_qm.c            |  76 +++-------
 fs/xfs/xfs_trace.h         |   1 -
 11 files changed, 273 insertions(+), 249 deletions(-)

-- 
2.53.0

