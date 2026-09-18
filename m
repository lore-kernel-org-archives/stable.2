Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994303446A7;
	Fri, 18 Sep 2026 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707615; cv=fail; b=Vasu1QE//+rpopKbOOPfjShY1egwDdzIhPzYU467imQVA7PfcT2rzlDK9DQFvZMrBZyUWvMMeapb6+R0LB6VlRYzsvyokTVudWfoB6KAl1cSvr0k5tNQh+4WwZ1ekLhh8y2TOOKdZ2GkbZKGM30df7ligKT6w4iu28IuMuB+CBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707615; c=relaxed/simple;
	bh=YtgqmeTApq5wjJMf82L8qnnHrFRFsReksdMFlYTvnHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aQA8s+/RDwSC1tsgldCHLyZGwrO+xaDdl2Jvpg/DlxdPuSRmv83uTNkIwl2nZ7Vu8vZ/pP7mYO7ga8EjLzhdCndaRoDkzYuN92KVwZjSEUwxPyJDyEd4kCjRhQWonp6mblBUp2ofIbE6195WqYZ/zDVD5/NG5J2qlvfG2+MtUjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mjHQwiHn; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mjHQwiHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhZN1Ex+9HUEA+X0iuHYdD28savyVsF+2MTyp+WbkkopZx6QWEOZ+DWkbeyimB193DQwN6Ltj5PbfbI5CxlZ6PTKAF7/ou79WaFqqgtwnwvZKA6WQjcH/RcM/M6wQ5Kw7fM8PgcfIj2nkIzBCyUfyU+HUokrFhuLsue65d2OqUARDXwtpgst+yI5YmsA6/E5v62Xkt24XeS62e7Z2an8nXbFXtnbtsnXCUxLjxr3HeldRKQvlpXpbz9mb6xKdfwmYqRn8mEvjX87QZek5yslaNqlu9OxBT7cP6olnPLaifDWdPy3JXKWv4ZIV52jUyM2PLnHEpFFsv0K1N75NYe0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtuSuuOknMzFx4+afTrZk+tteuUVJ+ORYuT4hdFZA7o=;
 b=NeDHId8F/80JYgUDwqcJrKOlVCTY60T0+sNAXQC3Qjrrdz1EXERYss3erDwOkVUUjpqyISA/Cg0gpPSlJhiz29cMrvGB5bzMwu1b8oX8FXaiQ4oUKlD6SLFcHBDe2/YajM5936LSJR0LEjkkBGkB0ZDb6FA8NO1oZ531GIXDXDu+KVUHWqu6LHjcPTsIHo2M6DZopiC/QpZ71ldOb45+szy311L9btRNyR82w9R5OdPtzfdEVgt7fdCFm10NUmWWGNuyrcpotU8AWwbVQ9ZbFz5/aImn8RrAORrFWtyTxgM///1CLa1YiYwKryckrnAfil8DkvF5lvM7P1FJM7s3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtuSuuOknMzFx4+afTrZk+tteuUVJ+ORYuT4hdFZA7o=;
 b=mjHQwiHnfJRNGU2+oYCiV1Dh7VhLYxq3dVeAq1LSVXyNSPwhIlO5c+LNSez0OOlygH5sVT1KCo3k5Fws1uj3S4HzACFnyXylMWU5RmXLW2dWbxvWa4ZkkZX30Pwq34aREq4nLRXy3DwOjLxWxtbSpLsQlOAdhsSxE5lwErk2DJZDMX7DMo91FQOc86zrAlGL5J3MMyqF5HHcYqFxV233lBFmZqHlvcdQaZ1NUnCD6qI4FHvbPjMqVYW9J4zYpJMljYGKtgCGNL/sid6cYgU1DfwxTw5w2Vd6fCOznljW+0LQS9UvI4XPvOQbmVuOgi3+QC9Idia96pqQ9pRZlnbq1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by BR2PR10MB992311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 05:00:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 05:00:10 +0000
Message-ID: <6a47a43f-6844-49c7-bdd5-cd84f63d38d7@siemens.com>
Date: Fri, 18 Sep 2026 07:00:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: keystone: Fix host bridge device leak in
 ks_pcie_quirk()
To: Wentao Liang <vulab@iscas.ac.cn>, a-verma1@ti.com
Cc: bhelgaas@google.com, kwilczynski@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, s-vadapalli@ti.com,
 vigneshr@ti.com, stable@vger.kernel.org,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
References: <20260917132022.2153069-1-vulab@iscas.ac.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260917132022.2153069-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|BR2PR10MB992311:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d01ecbf-7092-4cbd-fa2b-08df1541b74f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|22082099003|55112099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8jaJ748kblMWEtxNmcibNelWNqorhOwVE4SL8AxWFl7wh2TIVBj6gI63O2DBb/z+65f8h4I6ZcJuK55UhgETkJ9tq5qANURxcnZjs3/0vG05sKXn8MlsrnbUyagFoU8MqrK9Wd4SXL/BMp4J+UFDojOHcgHGCjkrikiYU/2til3aDi36XctLQdUvhCbvH1ZiKNTfLYqUZi/PEXex/MGxK/zyPtIXjMkzJ77MVk7qbjyHhEuMOHlZrVHdChOvNRqC+hd86lIIwuC95K80MBj+co+/lp2Ut2E85OQIPpy+sx5AR4C1wimA2fO3y5/s5nhMq/6c7qaidOfsZUyuO6gew7YvaOjEnc0c7wl+zG8IO42Z2EuVL2M/8bDBaETtuUWiD7rwR2oV2jZmdj7RlBDmWyVfh6qsDoIjWGfwvhvDNYaAQ9wKMD6iBApspwePen2KbZHjwkpxsBHoZgM2dPjU540Ll8BqiC4/vw+p5TdjeOKnkrcGQM8QOWnBRYfow3wSWuC4ykDpTX8DWAqN1SmTSN1Y+aZWTT4QPZ883jNOfGHGzugRPqg0TbLoe+3SuHNk2VLII4XeuP79ErI/mKuh3rYy76XT+AdNGS8NZ3KtmNDPv/GDMT4PlR9i9q2ksqdqTpc5iRsmygzLplMsal6c57R3/t/dLQucZVjmmwHqT9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(22082099003)(55112099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFMVnhhMkk4NTE4K3pxNTZaYlFZUHh1OXFxVmQxQzVBNy8vekpwckhBalU0?=
 =?utf-8?B?eHpUalhqZ2VKT21VZ1RvSlNjOGtJVm1RYVdQdkk5d2V1dGoyT0IrZmN5L2Er?=
 =?utf-8?B?RHdrRDRIVUlkSHFvSzB5aVNKZWUvUVNXWXZ4ckNTOVdlQlJNMUZIWWFKNmY1?=
 =?utf-8?B?dXZING94QnI4clF2aURCMG5wSDNMZUZtdEhoa0I3d3JpcTIrMGFweVpTRWxs?=
 =?utf-8?B?Q2orZEQyVGUycFpvMktndFQ4b2Y5Y0Y5SDRuSkVHbjVteEZhUmJFU1RkR01H?=
 =?utf-8?B?Y01xZWFrUXpKd29nVC85SDN3blA1eE5TcWNQRlQ2b3o5U2c5Z01Sckp3aDJL?=
 =?utf-8?B?NGppRGJ5UVFGVkI0UDMxNDBxaGpKRGNDVW9WSGh6djE3dlRFOTZrdWN4Y2lQ?=
 =?utf-8?B?MFBBVk5Sa3B0UERnc0hCd0labUI5U0tuME85WjhvQVFVVVZsS2F6bEZqYWVs?=
 =?utf-8?B?QmxmM1hkcmlEWVlVUE9KK1BJd09qUngwNzlVWGZEQVZhem02V0RocWFJdTN2?=
 =?utf-8?B?SDlHTXl5MjhSMGxieFBCQ2ZncHoyOEprd2ZJQjlmRnZONXR3bDVHVDl2akFR?=
 =?utf-8?B?TFBwdWdCSW0vWmVPcVFrT1Z3dE1xSEY1Vnk4blhONE96VTB6VHBWbm9LZk1q?=
 =?utf-8?B?SU1aZFh2TEM1aC9VMkFzenFja2x6UCtVQmd5QzJobC9FYWZiVmFVendCK1Zr?=
 =?utf-8?B?QytQNWxUQTRrU1VodmtGZmwvTlNkOTJHcDBKQlFjNmFEZlQrR3JJRGhRSDRE?=
 =?utf-8?B?RXM2aDdMbDg5azI3OE9JbjF3eUFwVUE4ZTJ5aDBSSHJZVmdHSDJYcTlNQTBH?=
 =?utf-8?B?a29HZ2EvcllzYURHWDdBSTZ0WklPcnZJZis2Q1dqNC8zY3ZzOWc4VkZiMHRX?=
 =?utf-8?B?VjR4b2VEUDBqeDkrVURCMklJM0c0ZXc1ZVRxN3JQM1U4M0Z2djN6aFM2cVhZ?=
 =?utf-8?B?Nmp5R29ubkZrTms1RlN6T2xPVnV0dWFWZC82R1p1U3pJOHdiWHB0eHk3YTRQ?=
 =?utf-8?B?RXQzaWlEVk9VK1hMTjdWVHBnQ1Rqd2FLWExjTFJNV1JIa0sxQUowV282UmlF?=
 =?utf-8?B?Yk9jNnZ1elJLYy9pNENQY1owb1NyZGhVTmwrWGNFYklBaEYzd2FCR3NiSzFa?=
 =?utf-8?B?bWR5Z2d5eUIvK0pkSGlEUnFpQi9UQ2x2V0c3bDl5WDNta2Mzd1IvTG1mRmpP?=
 =?utf-8?B?cTNaMW1uamFvbXFQZ2UwVzI1UW5YRm1wSXp3MU00UnBCZnErbzM0ak9xU21G?=
 =?utf-8?B?UEN1NEk4QkpoV0RPZlpOUnA2R1BYT3lWNDBMTVZGakRRU1pHbkNWd1FpMlEv?=
 =?utf-8?B?OTliRUxITDRJWWN2S0xkaU90R0QwY21QZjNyQ2wzZGdlUFBKamlXSWFiQjBn?=
 =?utf-8?B?eEtlOE1wTDBOdVZVc2RIaVpBblVINENKQkI2UjM5WVlobEt2dW1MNkIvL2lk?=
 =?utf-8?B?SjlmYndXSHErRnVsb3p1VW9YNVdwclliSll3M0d2UjFVNU9vZmlYa1BERWZ6?=
 =?utf-8?B?TXFRa3gzaTFMaHBuMk5pbzU1cnA2ekw4RXR4VFhkcmwzR1daeVNrWlNNM0U3?=
 =?utf-8?B?bys4ZU9rMjUxS1VRMEJ0RWlZTFpqMXVrd0VlajQ5NncyYitWSHpzY1JiS3RB?=
 =?utf-8?B?K003SkJVcFZWNG5OSkVCVjB1N0ZzNlM4M3pwT1BLNTNpcG9INm5YaUZrdlNR?=
 =?utf-8?B?UnRGSmh3eDFYQldIbkFja2ZQQjJXb2k3dUgrTkNUK1hFK2VXc3VPc3VEcnpL?=
 =?utf-8?B?ZkRkQlcyb3lBWW1nV2NvV2N6SVRBUkFucENyS0wwQ2FsaWFsSlQ3WUNhRUt0?=
 =?utf-8?B?VWJYTlI0dUNHQnZBTXFpdmxEaC9vS0NXRHRUb2lSQ2FMaXVBQTRtOVI3M0xU?=
 =?utf-8?B?cURmc29hcldNSjloM0lZcXdybStKQjEyMDRHN3JuYmtXMXVWVEc1SUJMV1hG?=
 =?utf-8?B?ckRUMW4rczNxNEZycm84MVJQUFZ5TklCQkZ4SEs4TGxuZnpyRG5TR25yTGNP?=
 =?utf-8?B?RThWb1p3THRvdFdubWVwZ0M2ZUhXeVNNZmxtNGF3UzRyTEltcm5pN2QzNUU2?=
 =?utf-8?B?OElTd3BMWDVuQmF3WlRCYzZRT1U3c1phUGcrU3NEdlhGRytyVnVtVnFqS1Q1?=
 =?utf-8?B?SHhaKzJ5Y2d0WHVPby9ic1RPczF1RW9pWFozRytiRnlkbm9pNHBFWXkyanBR?=
 =?utf-8?B?Z1NwWmMzTDc0RHNHeC91Q1FYRDhiZlN2bklHZEFlSFd5eE12V3pUVjFuVEhq?=
 =?utf-8?B?TFdobkQ4MG1Ea2UwZWwwdmxCaS9QcnJLUisxa2tJTkdCdnE2Tk9GRjlOV3BT?=
 =?utf-8?B?Zk1YcDBZUnQ4VGNXVkZDcCt0dHNwQVZnMVNhRlRhVlprL2VKMmxsZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d01ecbf-7092-4cbd-fa2b-08df1541b74f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:00:10.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+AooxyBGFpJ9ceBVVcLuNiwk6hzB6Fl3YfERP/+VYPeSPCdPgoEgx6uGb4V3wcoPig8SOKLTX32o2pG4U0dNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992311

On 17.09.26 15:20, Wentao Liang wrote:
> ks_pcie_quirk() obtains a reference to the host bridge device with
> pci_get_host_bridge_device() but never releases it.  Every early exit
> from the AM654 PG1.0 workaround leaks the reference: when the bridge
> device or its parent is missing, when the parent has no driver data,
> and when the RTL revision is not AM6_PCI_PG1_RTL_VER.  The quirk runs
> for every downstream PCI device, so the reference count grows without
> bound.
> 
> Add a common out label that drops the reference with
> pci_put_host_bridge_device() before returning.
> 
> Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 278d2dba1db0..cc6739edd434 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -528,7 +528,7 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->bus;
>  	struct keystone_pcie *ks_pcie;
> -	struct device *bridge_dev;
> +	struct device *bridge_dev = NULL;
>  	struct pci_dev *bridge;
>  	u32 val;
>  
> @@ -582,23 +582,27 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>  	if (pci_match_id(am6_pci_devids, bridge)) {
>  		bridge_dev = pci_get_host_bridge_device(dev);
>  		if (!bridge_dev || !bridge_dev->parent)
> -			return;
> +			goto out;
>  
>  		ks_pcie = dev_get_drvdata(bridge_dev->parent);
>  		if (!ks_pcie)
> -			return;
> +			goto out;
>  
>  		val = ks_pcie_app_readl(ks_pcie, PID);
>  		val &= RTL;
>  		val >>= RTL_SHIFT;
>  		if (val != AM6_PCI_PG1_RTL_VER)
> -			return;
> +			goto out;
>  
>  		if (pcie_get_readrq(dev) > 128) {
>  			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
>  			pcie_set_readrq(dev, 128);
>  		}
>  	}
> +
> +out:
> +	if (bridge_dev)
> +		pci_put_host_bridge_device(bridge_dev);

I would pull this under the scope of pci_match_id.

>  }
>  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
>  

Good catch, even more as it does not only affect the legacy silicon. But
I guess the leaking normally ends when all devices were probed and
enabled, and no one has a desire to unbind/rebind them.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
