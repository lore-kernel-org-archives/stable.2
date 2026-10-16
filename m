Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652564E06D4;
	Fri, 16 Oct 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166513; cv=fail; b=YeC+NscQCPo2lWLgkqrA6Wm/nFbztknlv6yeJgE86vu2OkxrjJda6pOcwB4fdpl8L8M7ggHSa9wCMS8HKcQsbAbfBzM9dxKbtvTmbMBFIyApGJVO7Kq/k5pa7K9wXBpm0shUklMQgdtZ/1JhdD49kkm7J8zuMje0OJeuHoFx4kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166513; c=relaxed/simple;
	bh=TZ7T8wS/02IeNd096QB/i6n29BNJBljN1/FboLK4TeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZupYXyF4pwJTWvCTSX8xu1yeGdy286/vlNhztpFLa7ucHInOPAzaFzkQ0SwrEi4pzysdFaTxz141SHHuKLrj7Svl5mgaW7IIHgUsMuAs8YCxuQhpIhzqMGYm8+dPQR/PW+y//uP3UC5v9+1iRHDZwXFhAIi/+LcmZ7GgOsQN+RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4iNn6oV; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4iNn6oV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs72yViS+DCyOB+cdDtpUO5kjrcoVnP6gRWREoO6RQ7mxYJWpLKcfWjwVc/Mjg0GsmOng5CYKEeO9gqtMZy2nZRRWw3XmCQNtuCthY0mGc2W+v3yU4qdSCATn9YGrGAH8Rb6X27ZP35FJwERU7jBRHHlwz2wkAilTGWaN8pC+X80RGfesQh1yfQ7MV7fOw/Hh26cnf1YUXG1gNVaF2IA5jIjVEPVAnzsSbCG2TlYfc40yY8xffp33hKxF+mO9vTC4iHWtU6RjoSiVvYfhFlXdQObysUORJMnAoNghudq9I7l5ll7gJv2YZhiJzhB8gh6+Hr+TisDRWJoy3c+kSWc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXEGHgRS3zRls3v+pekqx6OEF9F9TILH3GQybP3sj3U=;
 b=rymBYE0/T0u51HZbeh4AjeyzeKQW8/ziqYn3vG/GKH4veO2th2EO4BtCyvKcQEXeOSg7O9W5V8jPJt/1JGlowCWooB9klHSgLIpIxGe8MdyLRTLvSJNZv7KHvgbKGs1opdDfxxR7Q+bN4vAckMagUOaOa2xw9OKHEAtaDVNuhKN9ohabBWouxufz4M3TEL+HijfdF4TeqNgzH0hroKGHxy4998WyaQoZ8l4m4lRE0ylBwwXRulvKGKinpJqKpV1IdrB4DSoAXGEZ8ddfVbDDJzB6rD0rm9BAazRKtcLO8IXuCAvbd/IU3TcOrocAcmGNjpSmqqqi0RBeYQk7f4pg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXEGHgRS3zRls3v+pekqx6OEF9F9TILH3GQybP3sj3U=;
 b=Y4iNn6oVQIDQiERAiFs8ILjacC+jMNw+odOxIJXh8h0y7xcAHv9R+unmQQFmC4FCcel2M6W/MrumCE/9NIt40AcnRJ61HQhPQdAJpw7WiJb6je50R28S9I3gsnDLKTX4RTDSRuXbled1m6kTlOVdFv+yeJLzMSnLlgitnDwZRp9nIwbdYcH+qTPDoEekCdpzWLI0Ce29R4JZKvqTArU6d3aVZ6+yLOrY00JJNpHxzzKo63VG9P2kV5y/rMMmfHasKkVpXljuEYsVr7b2MHr08hn3+p0ft+H0xqYG/szhT27oQdxYIxy7UMmLcSS0DuDsj+yYEIMxYKyiZAH8FlsJpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by PH7PR12MB7355.namprd12.prod.outlook.com
 (2603:10b6:510:20e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 16:01:40 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:01:40 +0000
Message-ID: <a7ed450b-5dce-4485-b4a0-9349e75e4c52@nvidia.com>
Date: Fri, 16 Oct 2026 18:01:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 RESEND] vdpa/mlx5: Don't free QP buffers if destroying
 the QP fails
To: Yuho Choi <oss.patchbox@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261016035851.771496-1-oss.patchbox@gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261016035851.771496-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 77566483-a798-47ad-4085-08df2b9ec3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|22082099003|18002099003|261009223027099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	1ajpBGDhH13f0h44xIj7lQAujFiFmOhwMV90MsV65nKk7ODrGjb/bD3GJ0vtlJRJFiD7Bk0sWXq3YGYPXP8kXCA19oGt4KLa893sA5aDkpLpAeel7jeYwSOMHXzeutglUxyv3u2N9LUBPFGZYNqeJ7DNIQLRWw2Kso5cf02Ge2LItSizmjCKti0zaTilS1JT8lX16VurlmiQVToAxeJecCUj0TB+xEyEi2DVnaH7WhYlQEPKjL32BUlDZfSkjEDN/PjOTbJKuS79cJSWF5iXYAjSSWmPfXTffqqMEl3JgsImDHfARjj2nKWvo9nZN+uW7CJ6+5kiD7LZXs0mmedUVMuQLnKKPGhk5z196629pooSHRCvZJNfdYZ9A+oeJqaqtqU6/2BpogfjhN6x3WWQ2C+0CLjIg14v6CkPDcgYXpjXr244V0f1d9dtfzb1BJMUuDZGrsRMawdtGakPXrBORVs/LGz/PkFr1ZLbh+IPUipX+x1yrqaMAck6RqiRtl/dXVbhaHp53IZ4SCEk6wZP+fqw2MDhk3fe1MPNMYsH/1FqdOmUsCLyimM6aNYUl7tofSGU/n7wK6tji7KMKI7FLvWlL0EuzMpwINht501sE+5UyMnADCKwhgFR6omWTGYcf9RQXj5S5KkB8+cBLXoDtwzbG79HqSQ5lXOBKWCFOI0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1pIbWZrR1UzcTVGN1c1L21HS21Jcmw2WVdITFhUcVhEcHRIMUgyK0NySEk1?=
 =?utf-8?B?VUtjelg5MEc1bEVJZDI0cktJTGhFUnh6WmJDNjV2YmV0MWV3RWpOeEJpYmE0?=
 =?utf-8?B?cEZ2ZXlaaXRPSDhVekQyVGdSK3lIR2lmMm1rKzFRMmw2MG5VNUxCZmdCeTRY?=
 =?utf-8?B?NmNRWDAvSEhXcUZvNjFESnNVT3NQa3FJMFp6aFhTalMrSTVhd2FzMTRuaWZv?=
 =?utf-8?B?VHlMeXJmbk5ycGVYS1pvM2pKM2pwMEYvMHhyUDJTOEw2S3h3SXo2T2dkTTh5?=
 =?utf-8?B?OWdLU2tETnFlSnNuZzJEY0Z6VVJtbXlmQU16cFhyUjZJWlZFUkh5c0R1K3Bn?=
 =?utf-8?B?RUdHeUV1Yis4eFBNZHRQTHlmaDNIZnRKa25mSnRuQTg1dzMwQlkvSnBxZFJv?=
 =?utf-8?B?WkV3UlJzWmFnOWcwaWJNVWtUTkpNSzg2MDB2T1pFUlE4cldLbkxWd1k4dEk4?=
 =?utf-8?B?TGUra1hTOUYzbDdNbXVlUk55TEZZZDZHWSsrRkkveTl2Zzk5NGpnK3lkRzFQ?=
 =?utf-8?B?L1ZPVkI5Y0krNTNiWmIvS1NLRTZ3ZGpLVTVJQVd3VDJNSDNrTTR5Q1kyM2VC?=
 =?utf-8?B?NnZNTENpeVNVa3ZuRitJK0hIR2YrQmpucmJYbmxZL2wvTUYxQ1paUU1BQzhV?=
 =?utf-8?B?K2ErTkNObDlkNDNMUUYwWWZWN1M4SmxTWW9tUTRPck5Ccm1UY2Niait3UXB5?=
 =?utf-8?B?U3Y2RGFzNzVZT2pFWHhtS3ZJVCtaYWd4STZXTVFhRWNZdEs5a2pOSVBMVStW?=
 =?utf-8?B?dXorZFdQZW5JMnJHVWZ0TVk4QWk3L3ZHVXpRZXpnWDhWQnJBMnBIbkNWOVJT?=
 =?utf-8?B?Zkpacnp5THJYU3lHM0M1b3FPQXdFckUzaS8xMFBMbWNIdEEvSnZIU29qclYz?=
 =?utf-8?B?YU1oakp0b0p2MTNZV2NlSk5samQrKzdzN2tNRnQyQkQ2eTdHR3dVYWtta2FO?=
 =?utf-8?B?MkpBR2tTTmNkejBrQ0V6VzArMmJrRXVNRU5JbEo1endTdlNkTWliRXVPczF5?=
 =?utf-8?B?cHdiTWxvL0RMYlUxSFBFTEVMbm56c3pDU1l3NGdBdmlwT3dVUXlZdDRDckVi?=
 =?utf-8?B?WUxVWGYydDZkb0lBZU13cU5UUHRINER4NWs4YUZ6NXBJajIrd2lobkI2TkZM?=
 =?utf-8?B?VVEyRVhOL3h6aDNTcTExeFp0U1ErZ284bm0zVHBMZE9oU0NNeWdmVk9xMXN2?=
 =?utf-8?B?aWhnWjkzVVJIcDZHajIrd0FKNnBVNUtLVHQvWVBYQkR2ckxRdUY2QUVWZWx1?=
 =?utf-8?B?eU43K1FkZkYrcjNRQm1CN2w5L2thMndUYVltOE1FQUJmajdHTDVRMW9aWExU?=
 =?utf-8?B?dVNBM0trNkpNaWNVeFZYbHhYdDBDQ0o4eGxKTTJta25BamJ2b0FqbzVaVmFh?=
 =?utf-8?B?bThQNk9sUVlPRDV3dUJ6QkgvMXZ2WmhPbjc3TmRaRFFGZWdBVzlYSDVOWlhP?=
 =?utf-8?B?TUszZGViaVBhMC91TzVFdjNnM3cxSy9EekZMOEFjeVBxeGYrMTh4VGhDRlpU?=
 =?utf-8?B?eTFSVmJJVm5iYTFlN0xiWGcvTU1nd2gvUmVwMFBGOTdTK1ozVzBGbE1DaC9F?=
 =?utf-8?B?RTBnNmRCa081Y0RMK2FYbVMyNnYrS0hxcnVObXpUTURZTTdBOURGa3NBL1Zt?=
 =?utf-8?B?SzlKbkhBT0g4WGk0eldmYVI3SzgwNWdlM0Q1MDhrMTVxRG5pTkloNERaZWRJ?=
 =?utf-8?B?ZHI4TWFIQlgwTlFmaHNxeFEyMGJqUkppRXRjei84QlNLVStWOXJzU2FTTHpy?=
 =?utf-8?B?ZnlyL1A1Qlcwa2paOW13YytkeWViSGV5bmVoOW5qQnlRZ3NOYXJlOERlM0tn?=
 =?utf-8?B?MVgya2NMRkIzZnhDL0dXTXl0a3FnYStaTFc5dVR5RDFnRVErVWQxV2JMbmsr?=
 =?utf-8?B?b0cybGZYN3gxVmlmeFc0cGE5RTNTc2RSTExWQkVuTmorVDRpdzkraTVUZTBY?=
 =?utf-8?B?TGtzcUkxdTB5WmthYXl2RHIyZUlBNEcxL0MwQTBNYXBmMVBOd3NLMnlOekF6?=
 =?utf-8?B?bmVhREdwZGlvN1Z4WmpWbnNTaGlNNUNpR2pabElsRkQzNGp1bVR3alprWGdl?=
 =?utf-8?B?Mjc3Mjl1V05VNTErTzY2cHpVRW1TdkMwWVR5Z0lZTHo3L040L3dTUmFtb1FU?=
 =?utf-8?B?UmlVMTBFVTRjM29YSm9iQmVRTnFzZ2tNOFVHdWtLZ0VNTEVObTRIMi9vUkNk?=
 =?utf-8?B?Z2tFWlBLTndqcXRzWmZ6MStxMlRVSUpveXBKdUdjVUxscEMzcWFodVA3Q25s?=
 =?utf-8?B?aTM0cXJZR0NLRGk1RDJ0Z2dXbW1XeUxyRnZ2dzZwTDJBZWdpZGk1MW5KbEhJ?=
 =?utf-8?B?TTh4VnFHdVFRWGtkZTg4K3JhNkFxajIxUGNQT05GVVBYcU1VaDg5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77566483-a798-47ad-4085-08df2b9ec3ff
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:01:40.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTAbL+FcjJBeV/DE6+wi/vhgATibkvM4mp5VYlQ2YzexCfN8GHZImybqO9JPVMbeDh/KWYwtLDay4gAG3B77+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355

Hi,

Thanks for your patch and sorry about the late reply.

On 16.10.26 05:58, Yuho Choi wrote:
> qp_destroy() only warns when DESTROY_QP fails and then frees the RQ
> buffer and doorbell record of the driver-owned QP anyway. The QP still
> exists in firmware, so the device can keep reading WQEs and the doorbell
> record from memory that has been returned to the allocator. This is
> reachable from teardown_vq(), which destroys the QPs even when
> destroy_virtqueue() fails and the virtqueue still uses them.
> 
> Return after the warning, as cq_destroy() does, and leak the buffers
> instead. A device in internal error is not affected, since the mlx5 core
> reports success for DESTROY_QP in that state.
> 
This commit message is long and hard to read. Could you make it
shorter and more readable please?

> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Cc: stable@vger.kernel.org
Nothing against the change. But it does not deserve a fixes tag.

> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> No code changes, only added Cc: stable. Resending as the original posting
> got no comments:
> https://lore.kernel.org/all/20260926215632.1343807-1-oss.patchbox@gmail.com/
> 
> This was found with a static analysis tool from ongoing, not yet
> published research, and confirmed by code inspection. It has not been
> reproduced on hardware.
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 8563fec2855d..a01cd890bb58 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -483,8 +483,11 @@ static void qp_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_qp *vqp)
>  	MLX5_SET(destroy_qp_in, in, opcode, MLX5_CMD_OP_DESTROY_QP);
>  	MLX5_SET(destroy_qp_in, in, qpn, vqp->mqp.qpn);
>  	MLX5_SET(destroy_qp_in, in, uid, ndev->mvdev.res.uid);
> -	if (mlx5_cmd_exec_in(ndev->mvdev.mdev, destroy_qp, in))
> +	if (mlx5_cmd_exec_in(ndev->mvdev.mdev, destroy_qp, in)) {
> +		/* The QP still owns its buffers */
>  		mlx5_vdpa_warn(&ndev->mvdev, "destroy qp 0x%x\n", vqp->mqp.qpn);
While here, could you improve the error message please?
mlx5_vdpa_warn(..., "destroy %s qp 0x%x failed %s\n", vqp->fw ? "fw" : "sw");

Thanks,
Dragos
