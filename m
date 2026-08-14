Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020082.outbound.protection.outlook.com [52.101.69.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E02F1FEC;
	Fri, 14 Aug 2026 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702050; cv=fail; b=IFdrpBTx8S+CDKcyEbPc316wEBcGNmovIvHHBIhtSotr0uoh+K20bKgkUwfkGr7BOFV6xkarpukXPLBk6YgJ8He/qPi9gr5/yvGUGqIB2JXQd/rm3dvqmtVjpW4wney7cB3m/RnyMP+ZmWTNGtNgjzpD0kFFpTapdW3OqiDREEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702050; c=relaxed/simple;
	bh=PzLQY0PbZiCpStCJumUjGHsFndE7EIe6G0+XTm/GB68=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H+0IDgLiR4ITOqUGZOk8Mnjba+Dx4aflNPHZTf6qxeHki94+OZ+sZQipOHvfTm/82w3YZv5AOw120gYdnmze/b+qlb7/iJOsDogr+ui9pIv787vXQ41oR9RidBA5O84teVy+pQV9PLOQLOFmdSb0Agh9+3kTE/vOJSJHQsHyxKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com; spf=pass smtp.mailfrom=nebius.com; dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b=FCPSRrMY; arc=fail smtp.client-ip=52.101.69.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebius.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b="FCPSRrMY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXkEDfCj3lGImv+rL3HR9tZJZTOljy3UkXnLXkh2Dxvdf0vUiLfW6RFH4gcB+5VwgBbAiUfSBkQwr5U2+Nhm20tZ72BlGgdWTM5rThXKFWcAzQhTC6fXlEvdpGc61IhDnOURdBWsLwIL1UTZ3zgLmuJDJa8SRQDNvtOps534ttJzIjC1OAC57l9aU5PYRwwZfs2Lm6BjDrCxfzTb4bQKmykzwuXVLAEcPRpAqogpBHQmkEDV+3fyWn2fNNK6sYr7bLC5rF1uy2jAtqI65xgyTorP6aVWIyUmAUPeqxwSGZAvsvgrPQ/Jnjp6KmSqw4LvPM+dx8QK5O/HdgT3rPGf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdlqEavdjfL3UY2cD5+peEL6MpK24oKqFs7qTOpklxg=;
 b=JeACh6BPI9GNnW7kQ0SIQxdnvptdcmNK/NQoYWOHS0SZtu9PKN69rhC4ihwZiLaOYEn4DmrzDB3fnk4/s/AYy9Yq9xsP67KX6uYrx0FtnG3ASrw+iMNArYyGqVS4YroG7tjATU9i0rWUm5r5WafuoKL7mQTM9rTXlC6BOEta3xIVKxxFDCCyoiAnHbicR0OUgCstvF4PedaJSxtf2MYXziXrP6plWsy0FNmsTY8zvQylATWYBHA1kSised73sFkZWTI3CTMFwc2h5++dvl0+zdrbgM0TI/BYw1vTQJtdHd76BmlZQNacVaxbKnP+1ZiVUv+pq7YQFLyPTUPxgHpMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdlqEavdjfL3UY2cD5+peEL6MpK24oKqFs7qTOpklxg=;
 b=FCPSRrMYF9GmDUaz2V0zu+8pmzuaG753jvUJseHT4SqPTRB+jVxJbIg8XJiQnsjOoXqyTHnxKo8RrcN9yHwUVNgMIkioUHSkKHeYcMsyZoy33qv2zaHNehhe0MLVpkSLuLLGtQR6VHBiQtV8cBerAxjJypJJ+1QU1mk/gzLLrIme89Z+vRRJz8lOKT0508JyDp37BRCUOsV4lprIlgtPEElElUoc3apWOEIunePO4N0q/Tawdr/UWgTekzdStFIbPEOxIDR9oJx6mGdeR7MPLj2CM1Fx9dxVXSK0p8kdyVd2M48KJ39InT6LuC7OHbjCLMnW3hyUdYkXlAPQAMDyMw==
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4fb::18)
 by PAWP190MB2206.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 10:07:09 +0000
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0]) by PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 10:07:09 +0000
From: Dmitry Malkin <dma@nebius.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>
CC: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI bridges
 without vDEVICE
Thread-Topic: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Thread-Index: AQHdK9Pu+fg3Gt/XVU6V74nnaDIiLA==
Date: Fri, 14 Aug 2026 10:07:09 +0000
Message-ID:
 <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1P190MB2557:EE_|PAWP190MB2206:EE_
x-ms-office365-filtering-correlation-id: 64beb469-0f6b-42f8-fdb8-08def9ebcdc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|23010399003|366016|38070700021|6133799003|56012099006|10067099003|11063799006|18002099003;
x-microsoft-antispam-message-info:
 P9eyfuzKM4h3zKBw1cEU6ovkVqf6q4XBDla206sYC0sjH8TLS2T7i5AMNptBjAzxopoAmiMXSfKomiVg0z3Aeto34GsSs1FG11vM4OUxvka/T4DqMkF/Ed+HsZFXv/uS43EnwLHpk0OBQjQ+xF3Ksy4d7HoihWQ+j0a8qOV/AUPHkKvvRx6Efb15Shkv9f5v7LVyeHf+5H9wEr5okJQYmxH/Y09MywTTpREGRSG+3PUnxk1g1ncUhUuqiYnGFYTXfKx3bdrWc2HxVrXpYB6FWcvHVmdIR63LgbjLPcnU5DX7/+0ePVO6eOcJz/cIIJ+d2/veWEDpaVQDGl4pgUUmJfDSoEGzPnFs2mnodbbafG//ERiRaOeNprZ8GzSceniURRcJOZGo6dgKQ/N1AwivwJbgM3ojDX5W/bTkEqBnFnuCNCGH/Dn6MSLvkl4WPLPIShuU050dWVyIRN13NSS6TpSPpwXOTzouxUI23dOw0O/x6+0HK2hFni5zy4bMWMkT0oK/kvB/QBxrnr1M1VaOwJIoXWVhXlCxVzF22zt7Mv2qo027qHgFSlk8x2WcZNa2fKZKZfRMgOZcD4VkALJobu0xZdpfEwoOzCeUb1QWq5jRY5miZfLvQ16SxaYV7qfm+vMBhyrW0LNdf3SdyF/Y9m+ZdPC0eabZE7F0FuV/CLB341zFoxAw1cekCUq2d1laB1bBidYOkIa1hJZ3u0N20WEEdT58ZbI7ifLh63zdLL0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1P190MB2557.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VucccvlxsLuIZehIXaj2vk09SGlrD6PLunsVFIzg/NbSVCRbOIN9EP2TNT?=
 =?iso-8859-1?Q?EyfA28FlLFu6rfq8GDhvvikjDu6hTljZBNNVTm/8NFip7XtqLgG6Mnj2qJ?=
 =?iso-8859-1?Q?eRMrrX74A2MTCQDBpc1ybo92j81HFNcMAiIaXx6b+2faQ4w5+bWIBLcda3?=
 =?iso-8859-1?Q?op+gpNTVP071WDDgltMOT70Ruujmi4t+X/vZnV6MuUXvyHOubBRcvgBRPZ?=
 =?iso-8859-1?Q?zvKcav8D64AvGr1Km1QQJaX7irM0NeBKsfaDEuaw+2DU2cTTDwyyO3j86l?=
 =?iso-8859-1?Q?pq6uVzxLEQjW209fvGBQDW2K6GkaC0aR+mMtneJBCpZKNvQ1+WJY799KsN?=
 =?iso-8859-1?Q?mbTevgQtwtvxnc+78mDQmIxWh1ImMt1RZtQbFHdGkTB7HzFZY4Zeoc/W4p?=
 =?iso-8859-1?Q?jqhnCyf13rMyRBkcaRFWlWgc5CrvLDra/Eyw0X0Kqfv3NNY+pLZ6Iw5a/J?=
 =?iso-8859-1?Q?4eK05SUwZQgMSZPHu3THpUcoaf11R/m4Y9F8hNQhC5kDg/xtaue7JqA+PV?=
 =?iso-8859-1?Q?PXubCtolIKZfTHvf6BZYcHGXb2lmYlgwBBeJvnv9l7ycycj0RYDXIJqtXc?=
 =?iso-8859-1?Q?OENRovk9rFAuo61bD1YIpHbIRK5jFFuLfpx/c6A+zyyZpR3+l/l2HS2Xlq?=
 =?iso-8859-1?Q?EybXoXXKFLLMMQIXGOBrSjqsDP9jflpU2KVbxhdH+dXB6hdP7IJl/Of9N0?=
 =?iso-8859-1?Q?0Kfb5pF4DvJYPflI4etycHTlk4VRkp9D0xbGI5CetjeWTIMcXqYYM/Mt/J?=
 =?iso-8859-1?Q?rkAECOvNHSLvZi5mzghNeG1GRQirRJzNhLuavWRgOXXDw2I2sXH5tNRlKt?=
 =?iso-8859-1?Q?8QqefNawJmyttwUFGptFZFE6Ppl09xbAF+dFCyk9DSUa7mNr6lNqstopt4?=
 =?iso-8859-1?Q?62Qk1p3ds5xKhgyWsOsVXXcLu6pOo/zbTt/2sIqKFVAndlYR/+FXpifxgX?=
 =?iso-8859-1?Q?6O+8EWUfd5S3ZI/Z5YzWNSJ8qoUpZyhvn2zei0hi6V0J9rNEtrFAOK2gEz?=
 =?iso-8859-1?Q?q/XPNiVRde7TxMGYqhPyCvqVSnu/eVqMhxFgxVNpZKYpaGS8CbK71pt7KL?=
 =?iso-8859-1?Q?kbDbGJnERFGtiMXQGeNP0+vlghux1V+twbMUI6nxp2LOvAQ4CyWDXMfHXk?=
 =?iso-8859-1?Q?xNufCennHyzzEGS+QcKzKQQ7No8PB45jo+pQ/+dTKI+Z11GENBbJcdUsdg?=
 =?iso-8859-1?Q?kpSz9NyGalf4PVxEd+TsNVfwdBQxr9b/fJgCNwCyw0rttjxR2EsM5WxMS1?=
 =?iso-8859-1?Q?vFKuUIM0V/Rv4QxIGPGNuo5+WXMO3shK6BLHp0bGN6dv1R7SC/Trj7zFNX?=
 =?iso-8859-1?Q?bjlRXJd0ZpTfxnkv4UeB5Zi7dOTpayxsFadu/oIsM9RKK82693ofcNR7Tc?=
 =?iso-8859-1?Q?IwM07xfHfvl5LZhVHenlouxX/MiQAyCzzUD10xJx4e2BQwtyKwk5l4vdWL?=
 =?iso-8859-1?Q?5byccgHG+QtBEc7YqadB/Y2yCdTJ8Sw5bAfRh9Gsf18kv7bREE8OrIxkBF?=
 =?iso-8859-1?Q?AIj25NLlZ6r9DaO9qIwLXIoLXnUXfemMJ6vi4tboMPP+CrpLEyaoTfAX4c?=
 =?iso-8859-1?Q?CdmyY5/4pFyrIQNGYw6/mWdZ4DFLbjOpSFFXPPdLzh+H6J6pLKCoASk9zk?=
 =?iso-8859-1?Q?W50yMkxQtY6D6vpVw6YLy3GFcFiotkWdJfg/DbNPraA5UqT+ZLQKk5V4L6?=
 =?iso-8859-1?Q?5KIh31zjjGIdxWKzFUoW+FqMytI7TAWp6mcr7q2gsxVh9w7BdHs9X2D6Lr?=
 =?iso-8859-1?Q?vg/vgW+mnDks09KJFFHQthO5HTQi1rtiFYlTgczpmCC2NkCSeKaHvHrrzp?=
 =?iso-8859-1?Q?hgF0i5iZ0zpo4hMTowCfMotsqLE7VfrvnsDwcCfdIXGhCKqDPLuN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 64beb469-0f6b-42f8-fdb8-08def9ebcdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 10:07:09.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v00zvtvO6N6FeftXyMey2WViSdTpbMrpAghAn0BOXMBBbp/gmhQR1KyOYNKXTgd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP190MB2206

IOMMU groups can contain passed-through endpoints and host PCI bridges.=0A=
QEMU creates vDEVICEs for the endpoints, but not for bridges that are=0A=
not visible to the guest.=0A=
=0A=
Since f0ea207ed781 ("iommu/arm-smmu-v3: Introduce struct=0A=
arm_smmu_vmaster"), group-wide translated-domain attachment therefore=0A=
fails when the first bridge is visited:=0A=
=0A=
  pcieport 0009:00:00.0:=0A=
    missing vDEVICE association for translated nested domain:=0A=
    cfg=3D5 ret=3D-2=0A=
=0A=
  vfio-pci 0009:03:00.0:=0A=
    VFIO_DEVICE_ATTACH_IOMMUFD_PT attach failed for pt_id 19: -ENOENT=0A=
=0A=
The same configuration worked with Linux 6.14.=0A=
=0A=
Allow PCI bridges without a vDEVICE to attach without a vmaster.=0A=
Endpoint devices still require a vDEVICE, preserving vSID handling for=0A=
invalidations and virtual events. Log when the bridge exception is used.=0A=
=0A=
Fixes: f0ea207ed781 ("iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster"=
)=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Dmitry Malkin <dma@nebius.com>=0A=
---=0A=
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 +++++++++++++=0A=
 1 file changed, 13 insertions(+)=0A=
=0A=
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/=
iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c=0A=
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c=0A=
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c=0A=
@@ -5,6 +5,8 @@=0A=
 =0A=
 #include <uapi/linux/iommufd.h>=0A=
 =0A=
+#include <linux/pci.h>=0A=
+=0A=
 #include "arm-smmu-v3.h"=0A=
 =0A=
 void *arm_smmu_hw_info(struct device *dev, u32 *length,=0A=
@@ -118,6 +120,17 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_at=
tach_state *state,=0A=
 		if (cfg =3D=3D STRTAB_STE_0_CFG_ABORT ||=0A=
 		    cfg =3D=3D STRTAB_STE_0_CFG_BYPASS)=0A=
 			return 0;=0A=
+		/*=0A=
+		 * Group-wide domain attachment also visits host PCI bridges. Such a=0A=
+		 * bridge is not exposed to the VM and therefore has no virtual SID.=0A=
+		 */=0A=
+		if (dev_is_pci(state->master->dev) &&=0A=
+		    pci_is_bridge(to_pci_dev(state->master->dev))) {=0A=
+			dev_info_ratelimited(state->master->dev,=0A=
+					     "skipping vDEVICE requirement for translated nested domain: cfg=
=3D%u ret=3D%d\n",=0A=
+					     cfg, ret);=0A=
+			return 0;=0A=
+		}=0A=
 		return ret;=0A=
 	}=0A=
 =0A=
-- =0A=
2.43.0=0A=
