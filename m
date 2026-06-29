Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06052389460;
	Mon, 29 Jun 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712755; cv=fail; b=AWdjgLMKZvUgqPMqlqKFmuGXU/v9jyj4754Z6d1HeAW2+ZbksZBLXAehD5QJBagjRYbxXE3vEpUZRJAZrI+10V6B3nbnEvKFVIGFCf0Sr59bTWOYsmcRZweG9bJZtrMEvyx2FgQwOE+uPmfYu2qjHD0oXCxKyOBtYj1vOcFsCAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712755; c=relaxed/simple;
	bh=Yf5G75XhEQMHupVuOSV1+rN5maSnMAw2oKM3qiGSM/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q79VeSF/OXo4nxeASFnt8sGd6UurfU0qKDP5xDrVJNd/w36gh0Rz4qUX64HufDQWx/RD+oEHQt2Y67iHcBMP/RfHubyk3kVUUFW+4MF0dFXzbxDBT1LUO15eGr/SSkH2GgOCtHGaI1tL+Lrh+LKWWvuJgYBfHqhCXokrz+E3WAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7ymcXGI; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7ymcXGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRZLi+lrt2u0rfxG3hzkpokfESqQ+OTr6/PDPbtMJKoPqGrk/aw57SlDKRF2C3PkP6/DCjzD1VED/j5vFIIg6PpL/Cr5V2hfPODPwxoJpNN0Ds5L5E6Ty2Slu/6aGlFCQF5qnmJcn/p4ZxtXZO9QlLNB+pB1pQqZmc87SI9rRAnz8OuG0Fi5wXDPnbTW8nq8eOGEfstq77PBtbvXJugA7nNRnesMgPBAqhI2cPjdN3mHE7AXLB0N1jFIGNkoBXVL7HC3OZ+AvdpdE5qxnfQZ37PnVZ52DA1/RvEEv7t8ftRN8CEDynG3TbjaGHxYAtGy3z0vXUfT3d1kmfVIxIZjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3YlqlXBNLhGlEJaKXCIBiTo90OrBrBIHv1bAz4FFBU=;
 b=UpHb7gEgAAZJj1zOCW4rWoSjLGHeMymNonrSJyUGEvHap1dcNRXXhhO/rEDpMfhG8M8Nco7SQNLFSe9jjydaV6YBX/aPpF9PH5qAsXD0jhEhYgAma5sHCbvX/OFXWuWbtIQXs+5uBQ3To/omGCcJVZANFg5cTk+d197SmQbrpkPG9vJ1kps30j3oJ/PAbI1D7PTOyYaIlUCS1wJWcmcDkJaOedvq9ZDd1egZnnJ4+W3dhD0MeC/lwCd71Vktu1lAYC+PHaP3UM/w3ka+6UVNLDfjYQXzOkTSMj5lWUUJ/RIyC/U1JM3r0VKuEHXiSdK0GnvZDjf1FL4p8QUOi9pFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3YlqlXBNLhGlEJaKXCIBiTo90OrBrBIHv1bAz4FFBU=;
 b=O7ymcXGI1LuGySaLoXkOTbFrktLs4k+ECGJN1nFDRS/vqpPo69752CIGLda0hkclOuZlArTBOc/fJfix2JF/M3XxJb/F8YM6obLkP+nXCTBpNQyHIF9nzxN8ieZ73SNyoQ+KjD0PEWdk/QGet20R82V+BM+Z5AFovYxvExc1WSFS/VTVZPl1u0M/q2LKvHPNkcaOoVvQ3hoKB9yN6gJloUJpD/IZqYSi7vJMt15IzobmnQ8WGHnqcLc4yjb7GMJ60xPua8vZ03q+LdEVBqUf8Tl68TtE/nCw92l3xdEkde/7zaP5NeBu+7MefbokwpNPJ8OCnTYeJq+MpWeeFZ2mmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 05:59:09 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 05:59:09 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: thierry.reding@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jonathanh@nvidia.com, WenTao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>,
 Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] drm/tegra: fix host1x_bo_pin leak in tegra_dc_pin error path
Date: Mon, 29 Jun 2026 14:59:05 +0900
Message-ID: <6iIwnfniQ6-oslWmeLae0A@nvidia.com>
In-Reply-To: <20260628150228.47948-1-vulab@iscas.ac.cn>
References: <20260628150228.47948-1-vulab@iscas.ac.cn>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:378::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaa16e1-aefa-4066-a7c0-08ded5a38984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/7834w6oNL5kivi3bEjhvfI+p1Rb3QqvvUPbJLNcm91cEG547k10Slnsz1tEqV0nONWn0wwrl6YP6UUn33wioUpko0kqCaBl5hwfbHn2OsKEhmwZSxZFmK63HySaCgvxSS/nPSxm7menXuyIkm4RoyctNjvbkpZYjk4ucryQWK5p3QpCnvn/ksW8Zp6GdTjTIMEHFX1tuCU6psh/EPiNAYpq/fKHBeb6zzVmXpAlGN3AjKOuC6HZB3tYU5NcccC5h5RMsQHWikDO2Y4rVIutGHwquvgr5L6RTlHYOO30aG/bUwEGYU0pr0/iVG/0rsvR11c7NuS5/C/TAvxlVs2RbYivSNWtsTn08Nrthd3f46Pq39XRMDrUP/TS5kgvRko+u0Ksl5LYFIzQcDEH4VI6ieUouwOVVqzYxQtVIAVBVFPqpRV7HqLeZN/A220o7nB8Fel3QcKmwR0lNGqUFy1J7V/w4C15SsqqBwsftzIgI81WoI9b2WTX6Hvuk1Rt0bpOc78KQXBkwlqLhTgTd4uhM96RzJ7CKn7InYYsNmGUoYVFihk+OlnVl2ky+MIH298cRxFce/XYULUZTTLOy3Y0AZhKMslnGA2b8APZ813vJK4JvzXFRQvmfP5mf7cMc09jbMNAun885qi8nO6mMfKPW4L73wYGJWZYZkQb4No88zE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjB1VFN1UU5id2RpQTRDM2ZtdlJTSzdadWxIVjNXaUcvZXJkcXdXaDZ3NW9u?=
 =?utf-8?B?bHlJNHBVNllHVUpKdlNSOVgyWVZzZWtPV3lhVDIzcjRYejFRU3Z2Tm10WUhQ?=
 =?utf-8?B?VUVnTzl3VVY2YkpERDl0a2t1emhkNkFsR1h0eFkyVkxYR3FaaDFnUXNXa08r?=
 =?utf-8?B?RmdvVlkyVWhuQmpFYkMxR0ZNWVEwZ1hXcmQrS1FaNlJZZUF6NHhFV0FlQS83?=
 =?utf-8?B?bUN0aER2Qk9XZlpCTzZ6THNzYmhUcnczQUwrMFA2TFZpZ3V2dmIwT2RMaFhW?=
 =?utf-8?B?b0V3bklnemxKL2dPUFE5cVdnLzFOWnhYbXRrODU3aFA4M2ZDbndscW5sS01U?=
 =?utf-8?B?aVV1R0lrZnExTXBzVCs5WUFSL0xqQTRRSFQ0SytmKzI2MFd3NU43aFBCdDY1?=
 =?utf-8?B?SDRlcFZSekcxZDN1VUttN3BPeHFwSEFkdG9yTXRodDluTTQ5R3JnbDdpZmE4?=
 =?utf-8?B?RVlUSzlFa0dILzIxMVZTS1U4U1VRZVZLQlkyTitua0xEL1RTLzVFVEJWMnQy?=
 =?utf-8?B?V0RvNFl2eWplZ0ZPaGovUlBEV3RDekVvVVZSYmhmQ29hT1NqNm9hL3V2Tnpa?=
 =?utf-8?B?ZFNLNjVEcTc5bEsrOXIxR001ZE5BNWVEQkJFY09IOUxWbkpUWHpKODRRYW1m?=
 =?utf-8?B?eVdWQU1lWi8vamFWcTI1NkN4M2tqU25ab1pwQkdjQjYrOVVjd2lIMG5kYndD?=
 =?utf-8?B?QnVrT1owMSt1ZldRMTRNNkZsYkpOdUQ5RmRHa3BzeURTalJDNVF4R3RTZEVy?=
 =?utf-8?B?RHBxSnAxN3NzYWxWczg2T1BvRTRFelpzVWtpdHd0TVduR3MveVVpbUpCWFh6?=
 =?utf-8?B?RkMxaHZDOWIyODBoZGlsbnJjTEs5VDBiQ1YxZTh6OXNuMG9QMFFjN3ArSWVH?=
 =?utf-8?B?QUlvUlQrSVFVNXNUN0lscWRhRHZ0MUM0VDNidlg0ZTJrVXdOQUppc2l5NDdy?=
 =?utf-8?B?WFpOazFCWXgvVjVRZEJCZ3pIa3VOdlMwWkQ0eHdzS1JkVHhSSlFhbllyOGor?=
 =?utf-8?B?WWtwVGk3a1V5SUJnOEtuSEdXM00zTHZ1bWthaG80TURtTHZkTzhqWC9mTCt3?=
 =?utf-8?B?Rm1LaENEZW9WNHp5ZjNSTWNyeTl0blVkSVFyQVNkKys5cm1vUnMzV0pwM2tl?=
 =?utf-8?B?elZmYzJjUi84cHkxWCtlQmlWODZ1TGc0K1U0MFQ1ck80QTFMVTlKTXFQcHNV?=
 =?utf-8?B?QkViYU9qRjh1VEx6d3YxVlFGbkZFdGZVRGMzN0gxY0w5NWI5dzdkYjY0Vk1O?=
 =?utf-8?B?T0FqWlp5azM5M0tzZnNSR3QvM1Q0cndrQ2VsNWNPUE9xNXhRU1lqemRuNy95?=
 =?utf-8?B?d1Z2RFE0UHB5UWlVRkFvNjJkSkpiaWhPaklVeWt2dzB5VGxRQkNtSHJLc3Ex?=
 =?utf-8?B?Z2Z0a0VlRUZldVF2VHVzc3ZkL2VVaWE1YmFIZFFmcVErTE9aUFhjWW50YVFu?=
 =?utf-8?B?Vk9Ta21lcTRyNnVROHdtVUZQcDh2aGRQYm9rS2F6MGhzSjZTb1RURXd0RWpo?=
 =?utf-8?B?aDl0eHhIdFhrbDYxb3Niazg0TXZ2alBCZUZXbGFYVHB0dGJHTUxaRFpLUEZS?=
 =?utf-8?B?QXdmTHdvZGxNUGM4Ky9TR3FVQWFWRE9HN3ZVTlJ5WUdtSHRRWm5NekV2Um0z?=
 =?utf-8?B?VTJZeWEwVjYxRXQ4R2VxeTZmdFJCdi8vZXVTWHBFVlJ4MzJack5PZWVwbXJx?=
 =?utf-8?B?dG8zSkF3aGdFa1ora3c3ci9KTldPMkNKTmEvb0h4dmcrVW04eUY2Rk0rczJD?=
 =?utf-8?B?aGk5TWxKcUoySzU0MXdMWnNreitReGMwaWM0YVVRZWpPek1TZXhnSzZnLzlJ?=
 =?utf-8?B?a2NsYlQ0aGNQeVp0amVKUldSWEJoQXlST3BSMlVuSjc3U2FGYkF1azg4SlhY?=
 =?utf-8?B?N1dQOXpCSFFDNWdTNEY1UmZBL09xQnFZWXRWU3pwdkMzTUVubHQ3N3hlc2Rz?=
 =?utf-8?B?Sm1BSWdyV2hWWjBnUVA1V1grNWEwOS9WT2dtOW5xSFZybHc5ZldvM3ZrS0dn?=
 =?utf-8?B?eHhUd0FxWndNRnYvTStLRU9CMFR5ZVhpZnpFSkNYeUl6UTZDRzYveTVKZ2Vq?=
 =?utf-8?B?Ky9iVjhzZHpDUjg2K3FvNDRVdWthNmNUSUFZUmc4Kzh0TlVGT0dZeTBGNXVs?=
 =?utf-8?B?VFV4aTNEa3FvS0h4dDBwQ29pUnRoR3lCS2xWelpRK1k5Sk1qTEhQRWNWVndz?=
 =?utf-8?B?cFR5ZGRNOVRLMXV0Zm9qVDdtUFUvdDZiYWxobk9Qd0ZzbDQrbzVVNml1YTlK?=
 =?utf-8?B?cElKR1kzdVVtVER0bTRnMXI5YVdDRjJDU3VjMVZjM05YVHRIcXJQMzVIWUVJ?=
 =?utf-8?B?TTAwYS8yK05IVjdEYittdWdyT0htckhGNmJuVkxZQ25pa095LzJ3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa16e1-aefa-4066-a7c0-08ded5a38984
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 05:59:09.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIy27zQrmnVn6QBslIS72U39qNPvIazcYSErMNIYWY2m6/7e41UDt7R5qP5C78PuesH8O+LVOcV6ahP/y2zBMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446

On Monday, June 29, 2026 12:02=E2=80=AFAM WenTao Liang wrote:
> When map->chunks > 1 triggers an error, the function jumps to unpin
> before storing the current map in state->map[i]. The unpin loop only
> cleans up previously pinned planes (indices 0 through i-1), so the
> current mapping returned by host1x_bo_pin is never released via
> host1x_bo_unpin.
>=20
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")

This patch changes the code around the line, but doesn't look like it's
the origin of the bug. Rather, I think commit

  49f821919bb9d45de7f1cde6072de01d36235b5d

is the origin.

Aside from that,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

..

Sashiko[1] reports similar issue(s) in gpu/host1x/job.c. Would you be
interested in fixing that as well? Otherwise I'll take care of it.

[1] https://sashiko.dev/#/patchset/20260628150228.47948-1-vulab%40iscas.ac.=
cn

Thank you!
Mikko

> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Fix patch format based on reviewer feedback
> ---
>  drivers/gpu/drm/tegra/plane.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.=
c
> index 0cb30910773f..e61485ee58f6 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -161,6 +161,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct t=
egra_plane_state *state)
>  			 */
>  			if (map->chunks > 1) {
>  				err =3D -EINVAL;
> +				host1x_bo_unpin(map);
>  				goto unpin;
>  			}
> =20
> --=20
> 2.39.5 (Apple Git-154)
>=20
>=20




