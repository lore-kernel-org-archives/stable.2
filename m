Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06651AED7;
	Thu,  1 Oct 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866284; cv=fail; b=WfJT6jctXytPd3eYmukHLczgfGfskjmdHMhW13q9QzuVY8UPh4FLlDu+U+jY57gAA6QzvB/0zw3JAJL59/Uly8Rhr1OCpc59lpQaup5Bt43fXGmSt9/5WzgPoKBTMv6EGqAa3MqUXEdP0anQIQyxv6d79TPLBLaeaQhBFxcz5cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866284; c=relaxed/simple;
	bh=FaewRyVnXSyVG1oKO9KzDBWG0lW4Yths0ieVEJ8Meb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLYY5QPphaq56YGv4ASSEe2fSDghB32kT76ea0GgqYlu331uXyIOK4LH4m+f7PS9Cq2eYq9ATX9ZlcwLm1d6LScj8J82Sgg/weLWtSewllQu3ENP+ygTYPgPL+kx+v1wW5L1Qh/RXerqreU15ibcyfDXzDes2iwKwaHySMovRPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fR2qu8lq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XPu+n+Cm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fR2qu8lq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XPu+n+Cm"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMcf9539266;
	Thu, 1 Oct 2026 14:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VO5Lz4gbmnW+lT5rMNOymNH+y9757l4tdzf+y2AZ/ts=; b=
	fR2qu8lqnEf0PTewWyJFilMp4P38YdJ46KUDZxzE//c5KEFJhpS+/NT/K+3itV4A
	OGKSSHnb7OVPfwLng6Hb8m7A4TmzzcmDDzqeqDFCup3GX8CWTggrlKuDV70EkVcc
	P8POqihxaziU5qFUAZSbU0vWLRGULgnajaYTlTg2wklgoToEBxJjNFOANFyWqk4r
	J29aV1R3lIwXlUpJujNVtNDJt0bbMpi1jHIfyK2kasX2bt6BiRIZkWrteypk3dXx
	ep1GSmn9aL/G/AwinbudQ1BP6cuG21s2CbVy2mgUrWXCn8yz6ZO7F7qKDROKM7k2
	8mizC2j95Ekf9W96pfx/gg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgyht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoS2T031740;
	Thu, 1 Oct 2026 14:51:15 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd2eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bllla3hQQEGbr6tgV7v8cdGD6VN3EQvu/lDcOtvPb8b2uKBI/cd0aPqAqhnBzQM7/fFxbzVX2ewgJeNl7LiOvr5ZTpNJxUklbW8Z29SV0i26dvp2QKfT9r/xMkKwAnlWmc8ljbGx+bGdOk+rDR2/g606o1RQPKkWE+0u/brrIl6oPJ7PUuJu4wY5C1N3r452egj2UHYuZZV1txEcPvLy6vBwqB57AosL7JxvrmVyTnOlRaKvdUoIQ+TjRN2Ub+Cjpyw/048Jh746pg3vSBpIiHmFmk0bvsUnLiuk8uiqB+n8CqBmE4Llgb9QjVHPqWDu9NzUuCoIGVeWmAq+UzHn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO5Lz4gbmnW+lT5rMNOymNH+y9757l4tdzf+y2AZ/ts=;
 b=icuCEM/bjzL03FJon/8RqkjWu6Oeij0WaZpZk7Ui3MpPXAWxhd4io5lJLLSu9QreIgrPilmZCzOL4W0YCc+mN+cfOa8+6zCawMNijHIIhWbRXc1K5i1JXcR6c8E6lU3XlY4H/SGrSgtSxec+x75i/4cZ9Pwbmpw/NQUiI72AZ3Q79WpnbiS4Hj9vu+Hmgpu8GQ1HdxWfWnytT6MAelNTfSjyRJW6p7/Gp/ek2NdlWAZv9EDYJSGwIGi16/cZiHmk+0I1sqAPlqkc0NoyEQP54vs2XvveFsIxFdYFTyEttKCdlufAqxPggwWdJ4a9y84uyxBBLUmA9gDO6OBF8xF+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO5Lz4gbmnW+lT5rMNOymNH+y9757l4tdzf+y2AZ/ts=;
 b=XPu+n+CmMWuN5gLyBtuWi72yRWMNK9nswIeBAbfvj8NooSw6IGMAnU2ClJ+f5Wkxs8S4q0ixczH3S9TWKWpuB0LS/kRR0H9DAt9KyLVU/SXBc+z4FicV3u6SY2R7bkMuGxHlHicVHD2LGzSk97DlrF/emQn8QgqOTAe/Wd7h/PM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:13 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:13 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.12 3/6] xfs: avoid dquot buffer pin deadlock
Date: Thu,  1 Oct 2026 20:20:49 +0530
Message-ID: <4ea0396a542aa38ac2680898988782e561046774.1790864403.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864403.git.siddh.raman.pant@oracle.com>
References: <cover.1790864403.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b9ddac-e20d-4037-bdbc-08df1fcb7078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|3023799007|260925022911599003|260925021311599003|260925021911599003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	AR/GQo0wBhv1O4h3/rmDsd7yaFBYfIzPSNC4ESbqPQWt/IqoJ+FYPghmsgCP6qEc+bdhPXJyIXHAKXRDjuUtSMIk0mFEgPLwKQD74SzsBpYf0qrCWlOCs8qdrR5dLD/M5T7vwmFmKI+NrSK81MZuhWh0Xq0mMkFqdyiKo1lTItn/eoeoIyS03l6YCLJVELbSbxxU+WmSux8FS6E4M67iIuDTsaL4bQc+pW7UWjizRgexblAMqO7C9tflj02/mHZCa2o2ZJFtyEicWLw2VlnW4S8wJkQ/f43U6N9AwkbrhznloMk894BoBCDG9cvjSYZfbeD+9q/FdfyQXhj2vjKMrSntrRIrqwyi2KfYPLX6w5fO8tMYA3baEeebegYn34qz3MROAbvg3NjlSht+3p+6ToeFm26chHFvBWCWSUUJfNFxA9rW8k9u1qY7w9bf6in5c5QbKAKzBsx3a6BuwNA2udqwP+M2W01NbeyN7AFdbFnWgvgfCFdQkcEjYfeUIBJKdVioKkORcHurSmk8v5dQt9hCAZXB8u8j1fK2sn3uCkGSyz3g3FO8wBe3mqstZcFb9LXSUXqRoP5kdvcc1IDQub7p7do5ivk4HpJrn2giqsVfw6BCXo/3/ss4xyq0r+mMKBKjR3sEAUBR0AvfkFVR6TszuW9SLv+vTByUC26VD38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YtEiBwizkW7AYPiSsUzvp5Fu6CYyBHX+fr0B/DdJOgMRdao7+uVw9JcTmTz?=
 =?us-ascii?Q?FwsCBXbNo7JnF3HY93jbDu7kAEo3du3X1wZTunLO41AHP7Ee0COCPqmRNkI6?=
 =?us-ascii?Q?Snh8FwIqmSaKdPZK+XVy3T0Rji5qEoN7i/wWiDBLZwZslcBRe48LOdksHFTP?=
 =?us-ascii?Q?nR97evF3uCDW65W+H9jhvdLk7lAK9JXEZ91wK7YRR4bxxm99FjNHNajDzBtd?=
 =?us-ascii?Q?bPaWqxznPolGdodTPCgOR8DkbMspJkOOt7AkTk37YoazMj1JYOgJnJ/BSHnH?=
 =?us-ascii?Q?saq2iM3OZzNAphkbzQTTnBDjURc9Pfg+zANg6nvQGmcq2Om2CBCGgpz54lE9?=
 =?us-ascii?Q?IUAit9E31C8G37niZERIae/598p7JK9+Ufi/w5iVicP3G3aycuP9TYRBLqQM?=
 =?us-ascii?Q?q6ArXTsVPKNg6PH9MgIXcMXX1Ps1mSAmdsKRMZo05xQj6r7SA18hiYfGqJmg?=
 =?us-ascii?Q?LyuMDFRbsIF5nE/uqhDJ6qeyDeRUocAkQcQ534efzw+z1Sr4a3/s6B0T23GV?=
 =?us-ascii?Q?bKQ+CUI78NfLmJLOUB/e6tCJ5PLSSWaZKsihWs2QydiKQkZKG0BQul+22lIk?=
 =?us-ascii?Q?OO6L1u0vP2o74syhCiIokfHJ8UvJnPgG9vxzEhaUx4We4/c+Xosqu7o8fszI?=
 =?us-ascii?Q?gfn2VBGX9oXhocvXm2SKuc3jYhEQYPeoBMZf6NqRXdPSxHKvdFG7yinX/IH5?=
 =?us-ascii?Q?VZ7dX38//kqmedjpPSZtqBNo3qut+YJt7LKeF/ilavLm9XoKKA4OaisDHtcj?=
 =?us-ascii?Q?gKevmUq3XUZ/8ANZxip46ZM7hgZyR0haAe4cNALn73l+ViOKALcD2SXCiCAE?=
 =?us-ascii?Q?3FvZJ/RPkXAB7AajCJzQDHVZsXxdP1LB9MZNKhxGlg8q5ym1L0wRnquw+bP+?=
 =?us-ascii?Q?KdOAbRuztp4AiWeeXQ7gEVQeIHeKm7Efm8Mpz3iScRXIRF0dX6mQGDj3sn8m?=
 =?us-ascii?Q?t/rZ67GYbO7X6KuRjJ86kFP78up/tztscA6MPQ4i7yCY4WNlfqiEe9iQKzKM?=
 =?us-ascii?Q?9G04J/C4no520dk6AH++iCI7nIzXyjnOK3UebkTxewtSGs6c1KVCyXEE6dF2?=
 =?us-ascii?Q?Z8SRkK2KyI08l/MMHdSDRbuzAhuh0iw5T5CKdXwV7D5YneY2q2y/E+xfIKnZ?=
 =?us-ascii?Q?79ZhS6kP21pq6NcFFdpbciU2pohtrcEukpq3SBFcR+LjVkLE4VJUS08Yp1Em?=
 =?us-ascii?Q?RObJXc6W98H27uECcbsjQNO3q58/9gv15nBNFRBqcgTCvfyxMkUcYhT6YCA5?=
 =?us-ascii?Q?LOqEndUD4BwpaLpZLt8XWly6mYrULuLCm9ZbQv0ahJWV7b0o+liNTa3OzMzj?=
 =?us-ascii?Q?A2fgJ9h9e+uXquAh85pYdGLhwMNIZZPncCK54ot9g9f4W2E1PxX8SUJJiS0H?=
 =?us-ascii?Q?hnAMm/0i6sMYsdrThrA22ocFPEL0Kyj9Og6p1AEnHPSuRzUSOB8jJKVWFv0F?=
 =?us-ascii?Q?dZi8qU4v1FRAeUWV71frmFkdQpixTg03XRhGEst9vPxhvQQ26QGg1pf78bxm?=
 =?us-ascii?Q?lZ7DDlgs6ca25SS+ljwi/L+dFOjV+CPk8KTRuNJBEwy1cFb5yl3ZRMn1T/nr?=
 =?us-ascii?Q?A7ofjfrok3cPe3KPTWQBRyuAw5cZqfwxTS69baimOmm5RZdSl66uRM/DIeKe?=
 =?us-ascii?Q?KmpAFK4jzb8tlYjdkXNxm7otik9knuq/DT0dSrlOk82bdAC0AulFWpcfs0GG?=
 =?us-ascii?Q?luFPcztjguDrACMx/m6HWdDGyaA7lG6MtqQLpFwTQWh0tqbZsTaC2e8KlrPS?=
 =?us-ascii?Q?qP6lBLSkwjIZlHP7j0KgEHco942QNGHrrJ/LXQCSD1EAmlbnbLUkjasBCkBr?=
X-MS-Exchange-AntiSpam-MessageData-1: bsUJRx2gWgV8c1rjjYI/v87BF2npGDCtRLE=
X-Exchange-RoutingPolicyChecked:
	nqsnE586XQSrDxKIuOs5BgAyvDoCvWPBaRKvLL0QZI8ZsQ9LrWBWE7dK3+5yOEOLlzR3tmUIY/e5u4GvH1SKaTKzjtUNmzJwq9HDxqtGHjyRiunTzfi81wOxqN8Uk+6IdB1icM3FCDPdveJmRPeajtjdRX+kz8jrPXFw9bZYx0pdUrw0BOTQXlvjDeb8QriVSc+7zjzmL1lK+6vvWJ/aXRnzDdf9g1RQjllzmvl/FT6YwAyodMbu7X2tY3mHuj/yNZwCbIyTeqLMMrJ11Ieu17kZZOouCjt6V2dhpMmGX8SqSmsNv1/2/HFY9k2Sv06O52yOCydt3clf8z92i3zaOQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4126xWUGWTw0/sj2WuXZMfCWZeqlw/yPNDq3bTLAp3DNqzGBbnMUuN5Zhjn1de8lh32htygurUdMdhfN2IRnLfIeE7l2YoV//CZmWn9dTDsGVTHNQuClhDn1iUdARzhYnvePn178mZyL5isHJZDKSOXmibv0BeCPix/pp4glHHFdlD8/8KaPvUoFiTjWTssAMKDlzv0zh08gY35NVoEMA9MetxtPIWTjEczFmUCKJPRBd1l9qdRFgH5mfJ4U0eEfpGMEd8qNO53/5stajy8zy8vYiWfZl37lfy0eSA5M+x+Xw6Izjt+/yGJSmAtLi9O8/cOWmPbZ76j+Xrcg/yoRzBiySoYHzsPh3j5OIRzLVk3wF836MIoRknR88LzqfcfSyD1RXkV6Yg6AlS6oyVz8/DxvJxoaTNOuFdGg+DkVTi86uMcE6bXnEnP1FoTTNKCqHAcCIolLey75dnVU7Pvvo/bemVFDKoQH+Sup30xs6JER187f/4tj4Y1QYFFkN4RNUOJmkl6qdlYNI90VbMr6GZgHMd9d6yUrqh572kZJ4/bQkhhCgJBMEOzIvp0rMxDCIUZMPRYhNrqyXcbuZzjOkOnRmAOzNG6KlRsk1CgmVCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b9ddac-e20d-4037-bdbc-08df1fcb7078
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:13.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pPwsYYFQURFfv5Q0ltbEOQigXb4G/5fLUo4gK35jTcusKt0W1KaKMUWr6Q5dsODiQn12wFa5dAjZ7W88bL1lxBI32nivJ88chaRQIc2vAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: pbqDu8mUZvGMi7RoO3HxHVv2xHDuYvN9
X-Proofpoint-GUID: pbqDu8mUZvGMi7RoO3HxHVv2xHDuYvN9
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe7364 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=s_x9I6ZcpGuAll3zZK4A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXzYVpWtVWdoh/
 gnF83zVA+fkDOfbcNk4J9Q2ia/XyvaVla+t5CvkvRqDw+xqrWZZpjVgMei7zsiX2B/NFuCkiS03
 QEm1chDIGbYyOXcaKHM6jKyrI/K5BtV2pvGMpMEW8pUIHIdBtwFZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6c65WYIAOeys
 u7bR0XoyNSbzcvvHZnZgh1o+hfMGz086sA7T6C7e4Hn9ddVMp1zJvxM8XbIn6g53Ugz3btc1DFG
 neMVzjaICEkT8WJfMMe4C71ro5ru9H05NSxF7yWOUIWA1h8QtzbFg1GGvVSmBW3dLzt/bw8hgYq
 gtfcJ089R029WhFc2ZaoiZ9tB9dAV90tdY2quHCpHiZIaPRKUUWuL3VVcBaggMAfHHDnP2ZbQ5K
 lAyG45L6Byz9LQYlN7lAowptFCeIfLCVBmnrO8I/pafTZVBQpOP1TF1nXHdUlefuUnE+JpklPUh
 udBAflPwRDOKG3cZXeIgep0uLlB8/RsjZ5HUAlrr/MbfEFoabuAL/75l+idFrvJo5kipF7sX8PE
 XHRoj/aBdy0n7WDNrmA7N/bOfLniBpdtgw+H3ApPvcVUxmt7h+g2cEfhgHnxltJv+kj2ZnlNMKq
 sEK4WT51mTltXeBy7JvW9zKTuWrOYEcRuQvTym4Y=

From: Dave Chinner <dchinner@redhat.com>

On shutdown when quotas are enabled, the shutdown can deadlock
trying to unpin the dquot buffer buf_log_item like so:

[ 3319.483590] task:kworker/20:0H   state:D stack:14360 pid:1962230 tgid:1962230 ppid:2      task_flags:0x4208060 flags:0x00004000
[ 3319.493966] Workqueue: xfs-log/dm-6 xlog_ioend_work
[ 3319.498458] Call Trace:
[ 3319.500800]  <TASK>
[ 3319.502809]  __schedule+0x699/0xb70
[ 3319.512672]  schedule+0x64/0xd0
[ 3319.515573]  schedule_timeout+0x30/0xf0
[ 3319.528125]  __down_common+0xc3/0x200
[ 3319.531488]  __down+0x1d/0x30
[ 3319.534186]  down+0x48/0x50
[ 3319.540501]  xfs_buf_lock+0x3d/0xe0
[ 3319.543609]  xfs_buf_item_unpin+0x85/0x1b0
[ 3319.547248]  xlog_cil_committed+0x289/0x570
[ 3319.571411]  xlog_cil_process_committed+0x6d/0x90
[ 3319.575590]  xlog_state_shutdown_callbacks+0x52/0x110
[ 3319.580017]  xlog_force_shutdown+0x169/0x1a0
[ 3319.583780]  xlog_ioend_work+0x7c/0xb0
[ 3319.587049]  process_scheduled_works+0x1d6/0x400
[ 3319.591127]  worker_thread+0x202/0x2e0
[ 3319.594452]  kthread+0x20c/0x240

The CIL push has seen the deadlock, so it has aborted the push and
is running CIL checkpoint completion to abort all the items in the
checkpoint. This calls ->iop_unpin(remove = true) to clean up the
log items in the checkpoint.

When a buffer log item is unpined like this, it needs to lock the
buffer to run io completion to correctly fail the buffer and run all
the required completions to fail attached log items as well. In this
case, the attempt to lock the buffer on unpin is hanging because the
buffer is already locked.

I suspected a leaked XFS_BLI_HOLD state because of XFS_BLI_STALE
handling changes I was testing, so I went looking for
pin events on HOLD buffers and unpin events on locked buffer. That
isolated this one buffer with these two events:

xfs_buf_item_pin:     dev 251:6 daddr 0xa910 bbcount 0x2 hold 2 pincount 0 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags HOLD|DIRTY|LOGGED liflags DIRTY
....
xfs_buf_item_unpin:   dev 251:6 daddr 0xa910 bbcount 0x2 hold 4 pincount 1 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags DIRTY liflags ABORTED

Firstly, bbcount = 0x2, which means it is not a single sector
structure. That rules out every xfs_trans_bhold() case except one:
dquot buffers.

Then hung task dumping gave this trace:

[ 3197.312078] task:fsync-tester    state:D stack:12080 pid:2051125 tgid:2051125 ppid:1643233 task_flags:0x400000 flags:0x00004002
[ 3197.323007] Call Trace:
[ 3197.325581]  <TASK>
[ 3197.327727]  __schedule+0x699/0xb70
[ 3197.334582]  schedule+0x64/0xd0
[ 3197.337672]  schedule_timeout+0x30/0xf0
[ 3197.350139]  wait_for_completion+0xbd/0x180
[ 3197.354235]  __flush_workqueue+0xef/0x4e0
[ 3197.362229]  xlog_cil_force_seq+0xa0/0x300
[ 3197.374447]  xfs_log_force+0x77/0x230
[ 3197.378015]  xfs_qm_dqunpin_wait+0x49/0xf0
[ 3197.382010]  xfs_qm_dqflush+0x55/0x460
[ 3197.385663]  xfs_qm_dquot_isolate+0x29e/0x4d0
[ 3197.389977]  __list_lru_walk_one+0x141/0x220
[ 3197.398867]  list_lru_walk_one+0x10/0x20
[ 3197.402713]  xfs_qm_shrink_scan+0x6a/0x100
[ 3197.406699]  do_shrink_slab+0x18a/0x350
[ 3197.410512]  shrink_slab+0xf7/0x430
[ 3197.413967]  drop_slab+0x97/0xf0
[ 3197.417121]  drop_caches_sysctl_handler+0x59/0xc0
[ 3197.421654]  proc_sys_call_handler+0x18b/0x280
[ 3197.426050]  proc_sys_write+0x13/0x20
[ 3197.429750]  vfs_write+0x2b8/0x3e0
[ 3197.438532]  ksys_write+0x7e/0xf0
[ 3197.441742]  __x64_sys_write+0x1b/0x30
[ 3197.445363]  x64_sys_call+0x2c72/0x2f60
[ 3197.449044]  do_syscall_64+0x6c/0x140
[ 3197.456341]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Yup, another test run by check-parallel is running drop_caches
concurrently and the dquot shrinker for the hung filesystem is
running. That's trying to flush a dirty dquot from reclaim context,
and it waiting on a log force to complete. xfs_qm_dqflush is called
with the dquot buffer held locked, and so we've called
xfs_log_force() with that buffer locked.

Now the log force is waiting for a workqueue flush to complete, and
that workqueue flush is waiting of CIL checkpoint processing to
finish.

The CIL checkpoint processing is aborting all the log items it has,
and that requires locking aborted buffers to cancel them.

Now, normally this isn't a problem if we are issuing a log force
to unpin an object, because the ->iop_unpin() method wakes pin
waiters first. That results in the pin waiter finishing off whatever
it was doing, dropping the lock and then xfs_buf_item_unpin() can
lock the buffer and fail it.

However, xfs_qm_dqflush() is waiting on the -dquot- unpin event, not
the dquot buffer unpin event, and so it never gets woken and so does
not drop the buffer lock.

Inodes do not have this problem, as they can only be written from
one spot (->iop_push) whilst dquots can be written from multiple
places (memory reclaim, ->iop_push, xfs_dq_dqpurge, and quotacheck).

The reason that the dquot buffer has an attached buffer log item is
that it has been recently allocated. Initialisation of the dquot
buffer logs the buffer directly, thereby pinning it in memory. We
then modify the dquot in a separate operation, and have memory
reclaim racing with a shutdown and we trigger this deadlock.

check-parallel reproduces this reliably on 1kB FSB filesystems with
quota enabled because it does all of these things concurrently
without having to explicitly write tests to exercise these corner
case conditions.

xfs_qm_dquot_logitem_push() doesn't have this deadlock because it
checks if the dquot is pinned before locking the dquot buffer and
skipping it if it is pinned. This means the xfs_qm_dqunpin_wait()
log force in xfs_qm_dqflush() never triggers and we unlock the
buffer safely allowing a concurrent shutdown to fail the buffer
appropriately.

xfs_qm_dqpurge() could have this problem as it is called from
quotacheck and we might have allocated dquot buffers when recording
the quota updates. This can be fixed by calling
xfs_qm_dqunpin_wait() before we lock the dquot buffer. Because we
hold the dquot locked, nothing will be able to add to the pin count
between the unpin_wait and the dqflush callout, so this now makes
xfs_qm_dqpurge() safe against this race.

xfs_qm_dquot_isolate() can also be fixed this same way but, quite
frankly, we shouldn't be doing IO in memory reclaim context. If the
dquot is pinned or dirty, simply rotate it and let memory reclaim
come back to it later, same as we do for inodes.

This then gets rid of the nasty issue in xfs_qm_flush_one() where
quotacheck writeback races with memory reclaim flushing the dquots.
We can lift xfs_qm_dqunpin_wait() up into this code, then get rid of
the "can't get the dqflush lock" buffer write to cycle the dqlfush
lock and enable it to be flushed again.  checking if the dquot is
pinned and returning -EAGAIN so that the dquot walk will revisit the
dquot again later.

Finally, with xfs_qm_dqunpin_wait() lifted into all the callers,
we can remove it from the xfs_qm_dqflush() code.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d62016b1a2df24c8608fe83cd3ae8090412881b3)

6.12:

Fix conflicts due to following missing commits:

fs/xfs/xfs_buf.c:
	eb43b0b5cab8 ("xfs: simplify xfs_buf_delwri_pushbuf")

fs/xfs/xfs_qm.c:
	da0c02516c50 ("mm/list_lru: simplify the list_lru walk callback function")
	fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")

We delete the code so we don't really need to add them.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf.c   | 55 -----------------------------
 fs/xfs/xfs_buf.h   |  1 -
 fs/xfs/xfs_dquot.c |  4 +--
 fs/xfs/xfs_qm.c    | 87 ++++++++++------------------------------------
 fs/xfs/xfs_trace.h |  1 -
 5 files changed, 20 insertions(+), 128 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1f6b2888bd41..52e3535411b2 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2389,61 +2389,6 @@ xfs_buf_delwri_submit(
 	return error;
 }
 
-/*
- * Push a single buffer on a delwri queue.
- *
- * The purpose of this function is to submit a single buffer of a delwri queue
- * and return with the buffer still on the original queue. The waiting delwri
- * buffer submission infrastructure guarantees transfer of the delwri queue
- * buffer reference to a temporary wait list. We reuse this infrastructure to
- * transfer the buffer back to the original queue.
- *
- * Note the buffer transitions from the queued state, to the submitted and wait
- * listed state and back to the queued state during this call. The buffer
- * locking and queue management logic between _delwri_pushbuf() and
- * _delwri_queue() guarantee that the buffer cannot be queued to another list
- * before returning.
- */
-int
-xfs_buf_delwri_pushbuf(
-	struct xfs_buf		*bp,
-	struct list_head	*buffer_list)
-{
-	LIST_HEAD		(submit_list);
-	int			error;
-
-	ASSERT(bp->b_flags & _XBF_DELWRI_Q);
-
-	trace_xfs_buf_delwri_pushbuf(bp, _RET_IP_);
-
-	/*
-	 * Isolate the buffer to a new local list so we can submit it for I/O
-	 * independently from the rest of the original list.
-	 */
-	xfs_buf_lock(bp);
-	list_move(&bp->b_list, &submit_list);
-	xfs_buf_unlock(bp);
-
-	/*
-	 * Delwri submission clears the DELWRI_Q buffer flag and returns with
-	 * the buffer on the wait list with the original reference. Rather than
-	 * bounce the buffer from a local wait list back to the original list
-	 * after I/O completion, reuse the original list as the wait list.
-	 */
-	xfs_buf_delwri_submit_buffers(&submit_list, buffer_list);
-
-	/*
-	 * The buffer is now locked, under I/O and wait listed on the original
-	 * delwri queue. Wait for I/O completion, restore the DELWRI_Q flag and
-	 * return with the buffer unlocked and on the original queue.
-	 */
-	error = xfs_buf_iowait(bp);
-	bp->b_flags |= _XBF_DELWRI_Q;
-	xfs_buf_unlock(bp);
-
-	return error;
-}
-
 void xfs_buf_set_ref(struct xfs_buf *bp, int lru_ref)
 {
 	/*
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 209a389f2abc..3fd9bc72f8b6 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -334,7 +334,6 @@ extern bool xfs_buf_delwri_queue(struct xfs_buf *, struct list_head *);
 void xfs_buf_delwri_queue_here(struct xfs_buf *bp, struct list_head *bl);
 extern int xfs_buf_delwri_submit(struct list_head *);
 extern int xfs_buf_delwri_submit_nowait(struct list_head *);
-extern int xfs_buf_delwri_pushbuf(struct xfs_buf *, struct list_head *);
 
 static inline xfs_daddr_t xfs_buf_daddr(struct xfs_buf *bp)
 {
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 511e7b0d5871..1dd4dde91736 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1405,11 +1405,9 @@ xfs_qm_dqflush(
 
 	ASSERT(XFS_DQ_IS_LOCKED(dqp));
 	ASSERT(!completion_done(&dqp->q_flush));
+	ASSERT(atomic_read(&dqp->q_pincount) == 0);
 
 	trace_xfs_dqflush(dqp);
-
-	xfs_qm_dqunpin_wait(dqp);
-
 	fa = xfs_qm_dqflush_check(dqp);
 	if (fa) {
 		xfs_alert(mp, "corrupt dquot ID 0x%x in memory at %pS",
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 36ed81eb0d6d..43775ad8ce78 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -132,6 +132,7 @@ xfs_qm_dqpurge(
 
 	dqp->q_flags |= XFS_DQFLAG_FREEING;
 
+	xfs_qm_dqunpin_wait(dqp);
 	xfs_dqflock(dqp);
 
 	/*
@@ -430,6 +431,7 @@ xfs_qm_dquot_isolate(
 	struct xfs_dquot	*dqp = container_of(item,
 						struct xfs_dquot, q_lru);
 	struct xfs_qm_isolate	*isol = arg;
+	enum lru_status		ret = LRU_SKIP;
 
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
@@ -442,6 +444,16 @@ xfs_qm_dquot_isolate(
 	if (dqp->q_flags & XFS_DQFLAG_FREEING)
 		goto out_miss_unlock;
 
+	/*
+	 * If the dquot is pinned or dirty, rotate it to the end of the LRU to
+	 * give some time for it to be cleaned before we try to isolate it
+	 * again.
+	 */
+	ret = LRU_ROTATE;
+	if (XFS_DQ_IS_DIRTY(dqp) || atomic_read(&dqp->q_pincount) > 0) {
+		goto out_miss_unlock;
+	}
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -457,41 +469,14 @@ xfs_qm_dquot_isolate(
 	}
 
 	/*
-	 * If the dquot is dirty, flush it. If it's already being flushed, just
-	 * skip it so there is time for the IO to complete before we try to
-	 * reclaim it again on the next LRU pass.
+	 * The dquot may still be under IO, in which case the flush lock will be
+	 * held. If we can't get the flush lock now, just skip over the dquot as
+	 * if it was dirty.
 	 */
 	if (!xfs_dqflock_nowait(dqp))
 		goto out_miss_unlock;
 
-	if (XFS_DQ_IS_DIRTY(dqp)) {
-		struct xfs_buf	*bp = NULL;
-		int		error;
-
-		trace_xfs_dqreclaim_dirty(dqp);
-
-		/* we have to drop the LRU lock to flush the dquot */
-		spin_unlock(lru_lock);
-
-		error = xfs_dquot_use_attached_buf(dqp, &bp);
-		if (!bp || error == -EAGAIN) {
-			xfs_dqfunlock(dqp);
-			goto out_unlock_dirty;
-		}
-
-		/*
-		 * dqflush completes dqflock on error, and the delwri ioend
-		 * does it on success.
-		 */
-		error = xfs_qm_dqflush(dqp, bp);
-		if (error)
-			goto out_unlock_dirty;
-
-		xfs_buf_delwri_queue(bp, &isol->buffers);
-		xfs_buf_relse(bp);
-		goto out_unlock_dirty;
-	}
-
+	ASSERT(!XFS_DQ_IS_DIRTY(dqp));
 	xfs_dquot_detach_buf(dqp);
 	xfs_dqfunlock(dqp);
 
@@ -513,14 +498,7 @@ xfs_qm_dquot_isolate(
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	return LRU_SKIP;
-
-out_unlock_dirty:
-	trace_xfs_dqreclaim_busy(dqp);
-	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	xfs_dqunlock(dqp);
-	spin_lock(lru_lock);
-	return LRU_RETRY;
+	return ret;
 }
 
 static unsigned long
@@ -1275,7 +1253,6 @@ xfs_qm_flush_one(
 	struct xfs_dquot	*dqp,
 	void			*data)
 {
-	struct xfs_mount	*mp = dqp->q_mount;
 	struct list_head	*buffer_list = data;
 	struct xfs_buf		*bp = NULL;
 	int			error = 0;
@@ -1286,34 +1263,8 @@ xfs_qm_flush_one(
 	if (!XFS_DQ_IS_DIRTY(dqp))
 		goto out_unlock;
 
-	/*
-	 * The only way the dquot is already flush locked by the time quotacheck
-	 * gets here is if reclaim flushed it before the dqadjust walk dirtied
-	 * it for the final time. Quotacheck collects all dquot bufs in the
-	 * local delwri queue before dquots are dirtied, so reclaim can't have
-	 * possibly queued it for I/O. The only way out is to push the buffer to
-	 * cycle the flush lock.
-	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		/* buf is pinned in-core by delwri list */
-		error = xfs_buf_incore(mp->m_ddev_targp, dqp->q_blkno,
-				mp->m_quotainfo->qi_dqchunklen, 0, &bp);
-		if (error)
-			goto out_unlock;
-
-		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
-			error = -EAGAIN;
-			xfs_buf_relse(bp);
-			goto out_unlock;
-		}
-		xfs_buf_unlock(bp);
-
-		xfs_buf_delwri_pushbuf(bp, buffer_list);
-		xfs_buf_rele(bp);
-
-		error = -EAGAIN;
-		goto out_unlock;
-	}
+	xfs_qm_dqunpin_wait(dqp);
+	xfs_dqflock(dqp);
 
 	error = xfs_dquot_use_attached_buf(dqp, &bp);
 	if (error)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index a53a57b4e365..526920b41766 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -493,7 +493,6 @@ DEFINE_BUF_EVENT(xfs_buf_iowait_done);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queue);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queued);
 DEFINE_BUF_EVENT(xfs_buf_delwri_split);
-DEFINE_BUF_EVENT(xfs_buf_delwri_pushbuf);
 DEFINE_BUF_EVENT(xfs_buf_get_uncached);
 DEFINE_BUF_EVENT(xfs_buf_item_relse);
 DEFINE_BUF_EVENT(xfs_buf_iodone_async);
-- 
2.53.0

