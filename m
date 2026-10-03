Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010005.outbound.protection.outlook.com [52.103.12.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913423AE18C;
	Sat,  3 Oct 2026 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791053119; cv=fail; b=tcMbS1l5GDwdrY4XC4PfT6flB6O/oI4XsKm3kduAmrdaIIDWPVhHjhroRaoKUZAakvrBTFt6tDa3uosUBKYjk9ag2fIm5xyCU2u3GGkPIXj/CYhtTXcFWo3es2R0IoZC34Wl1IOgEM9QAdlwkduWaRQfuIf02nAjUhcxE2r3vZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791053119; c=relaxed/simple;
	bh=oybgTJ2Sd05A2Rvu0r+r9t/Kr077ZF2UCJGPO06KAhk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GibuTHGl0YhWhyTDAvkrl6DqB4ve3tofmAMnKEoEBW1jBtTTpGc1JoX9yBC90JtaoT7pbn7qX4E9a1pjWm/dweKFQQMRoTxNSJM/4xmiV72nXQJxszIYg3TUyFvEgVd4qcXVD6DpJaWVbrqAWglccSSCl3QDOF6KufTs+H60YIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Kmq/bAQi; arc=fail smtp.client-ip=52.103.12.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Kmq/bAQi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAmia6ULfQA0MRU1YawoNzMwGiJ8pZWlq7gNRAaqdHFzp9GfP4NTy8ZLPvudlNc9OATZaUp/ULxSLH11YiBgORHkK0427/mtsNri4bRNruBqXBHjCAHu6+mNK5zUfyuEs2UZzj+xoxSey2QGTPwVxgC4PKZxDgtII/KTCbbC8jMty5S4gYsMNa/aw/2EshZj4WrWT2OKmtpj4BFc2eHYipS0TR8jKrKmENIcC3vUE6Q8hFzAvl7TgDQzT1pK7JM1P5hk0hR2AG+7xxsugIZ5TpAf5mIvXnj2SmoF23ADMwXi3Q+tiNw6U4eZhKdwB9fjfgbKbiBTST6h7jgIgkA/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGJz76wsRx254G2q6JIGg1tfA2eaDPnMfMfJipwBRcw=;
 b=iNxbdEru8hvdyX1ObtAojAHyM05EI+Cj8Jm1n+30PgVg/UErrW0m2juBvnn+UDwXf/UsWhTkG06A4hVuZXgVD5tGZKYQVOs81SCZ3lzr+5j4Wz4sq7ahR0r41SwDJFpa5zmXyB7gtWeGra763ETTq90YUCMbKmtzppZMFL9wKXjmRaN6wZUANH9wKehP9XeAYK/FWDAGXne2zb/QgPluoq+K2N1aPZozRyGeAbCOHCoLjQQgCLc/55+F0fen6cv9Dqe9aXlDMSQcW2DFGtzLX2jJ0FzTuXJmo91GpL+X2b1DNU1fRWMVZobvt4TeQS6SVQM5HE6x8OYcC6i/gOGFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGJz76wsRx254G2q6JIGg1tfA2eaDPnMfMfJipwBRcw=;
 b=Kmq/bAQi+cTixIiH12ItdkcZ8iPHAX4X0G76IyZkWROFtVrxozjSObjXoK6bNDZ+bVdXVq+fCG3BFpEvNhho74ggmN+fwstT8xN2ea5TNal3wAV3Il74SkYZ9j2r44DJE2+XFNjeiA+T+CzlPn5QEQkAjYisI3k18mQgAmwZr/AYSEN7cmKh/8dO+2JCajnkU49LnYeMpRc4ZRHCKqEZNUA+S5uD1GlJhQFsEynt9ZCTfqkV5v4rFCRvxuPNBMjEzbsC4Z9uM6X1Q5ftxVirEXBNTuDI7QhXLIuDb/swNlY6nfj6zu0SfKSj2Ur6RrAaK3t/nJ18IyDJ5m0Nr18rOQ==
Received: from BN8PR19MB2754.namprd19.prod.outlook.com (2603:10b6:408:8e::21)
 by CH9PR19MB283903.namprd19.prod.outlook.com (2603:10b6:610:313::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 18:45:15 +0000
Received: from BN8PR19MB2754.namprd19.prod.outlook.com
 ([fe80::1124:d6e:fa73:ae18]) by BN8PR19MB2754.namprd19.prod.outlook.com
 ([fe80::1124:d6e:fa73:ae18%4]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 18:45:15 +0000
From: Golden Stickwood <Stickwood_Jr@hotmail.com>
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Sanath S <sanath.s@amd.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] thunderbolt: Preserve pre-boot PCIe tunnels for active
 storage devices
Thread-Topic: [PATCH] thunderbolt: Preserve pre-boot PCIe tunnels for active
 storage devices
Thread-Index: AQHdU2V9/PsOi96D2EO6TVmnu3/VHw==
Date: Sat, 3 Oct 2026 18:45:14 +0000
Message-ID:
 <BN8PR19MB275472A84381924206F01AE0FD882@BN8PR19MB2754.namprd19.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB2754:EE_|CH9PR19MB283903:EE_
x-ms-office365-filtering-correlation-id: fd705c30-b67b-4c2c-574f-08df217e769a
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|6092099016|15030799006|15080799012|12121999013|20031999006|24021099003|41001999006|39105399006|19110799012|8062599012|5062599005|8060799015|31061999003|25010399006|4140399003|40105399003|23121099006|2607281247196008|102099032|20055399003|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?leTaGeMuqIWpFZL7F0r52mrJW9rC/wE29krWSZtTpFUPZv8VdSrjjtT6N5?=
 =?iso-8859-1?Q?EIFuw/ujUNEAleD9r515VdtTvmTkLhEDwcKQCYCByC1vVyf/0VcJ+iqjLh?=
 =?iso-8859-1?Q?RuNOR81lNfuCrbyjQBhIHmK1j8dupe3wkAJ1SuDmAvTRp7FlFxbuw2Laoc?=
 =?iso-8859-1?Q?VBnBe2qkkIg4XSO3fXKFm0ZLehF+FT1PhV5jFomvKDojGersimNuaNAmRR?=
 =?iso-8859-1?Q?3lk5o5t1qCPstaBIsj/votH4XINbIQzuYfbfjTd4G3S6H2iOXBh+kEaOzg?=
 =?iso-8859-1?Q?f60TNgyf8j0jtfmVmGCTFavIwKdCQKXJXyNT+AyxhHcKgZfg6PqWx9QoqN?=
 =?iso-8859-1?Q?cBLta/z5bkTZEhr0QS9Di2iN//hGRY8wCwxn8d+NzCDZ/NN1NQ6lI5mTcf?=
 =?iso-8859-1?Q?LCUtFchTxkWjaW72LNGT7m9+jzfugIzAsCwpbaQ/W1lXU6kUtKZ3Qu+1ai?=
 =?iso-8859-1?Q?uDnqWoMH2ja7B1KmJqSki8wIP94dp3NWdjXjHHnQQQw4U57HR58leZobwO?=
 =?iso-8859-1?Q?Wh2mWkOxS1rHWAKc1VBB1DFbG1P6qBmvVMpPNfYRItfYK9P6+BQoG/b/GR?=
 =?iso-8859-1?Q?VuenGpfDwswHCb5tR8NnzUqYa55f/v8Pv+4RrsCdkDGWwzbK421TvdGeI1?=
 =?iso-8859-1?Q?ruc/b2cR1Fw6u37RAGUUsFJiBxmILM+FrsZBUa0wb+S6wl4u5GPsUbWltu?=
 =?iso-8859-1?Q?Di6XvgSE/ApP4DO8Q+g9vHpw5a4ExWXngBwaBKgue05rn5orcvqUNsTwAB?=
 =?iso-8859-1?Q?gAvS/3d7TKlBDBQjKh8XTrVwuJcEuUa1H2viifP7/fWdHG6xZ2dKp2O4+k?=
 =?iso-8859-1?Q?pKVw/PopvuWO7jf5lUMVHr6FfBJ9PByJX7B2mmRkqPVfNpFEPD5mppYrb4?=
 =?iso-8859-1?Q?1tQnUKUdrwlRp1AJYbUzZJN/WXgD5a9Wq9QcpGfNIO5c76XuOCfm5djztC?=
 =?iso-8859-1?Q?HCGWzGDtl+HoCtXjOtOMoPuYMMrz6Y+lCaV2xmMm+3P1LRhZvCT9B870ED?=
 =?iso-8859-1?Q?Zt/emvoyJxYiuvMyDijVGEtSFB+8P912JA8lxAi6gqA7WIIJu4kby/TWbv?=
 =?iso-8859-1?Q?vt8donhLRAjBOlGsNnv0MA1mGqlr7CwKByR+omE/323vvPW+P0KbIuANd/?=
 =?iso-8859-1?Q?EmyLa1DmimlruH/XXe+NryQ5+gAGAeJ0KkNIbk2UbboukmFtRMjjQ2eBpO?=
 =?iso-8859-1?Q?hy3+K2kqw1fAhCoIkmHWh/jl38s8DTBoXntDPaKe1fCuJIP8SZrygFgq71?=
 =?iso-8859-1?Q?YGynynac43XA88ghx0S1dPB2Asg1Al3WNKZDuvNNE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FHB7sU5HGKbHhR6vVtYG0hx1hz/jygVEMYRnAg5pGIh+EPqdqeHwWRsn8L?=
 =?iso-8859-1?Q?nwuUApYXD89GWha/5w3SdQXBm5JTCDmskOOXLjDporfTSTkAKcxZANCESh?=
 =?iso-8859-1?Q?2k0KLrQHnH6lI6Hy/vSI5l/N9C3dDDl14B6WcSZY3tlSu5PgkN1HOgQLq7?=
 =?iso-8859-1?Q?jAdOazmJiRPCWpklpCv/GoMvqF6QnNVtPVjWUSajDyLqGnEowdV3JgP8nS?=
 =?iso-8859-1?Q?io3GO4Ww2XgU2M2EWw0/HPNY5rj6tKrL3S945j8JsWdQPwu41397cYELSn?=
 =?iso-8859-1?Q?IrmQaxAKjDVUsWs3YwfI6shfwh0rhXoInOrSM0LYLmNto8vwsDrbAxmIxS?=
 =?iso-8859-1?Q?1lu0VEOpZzP1/ETIfpVBeBEYV+mhhqoypvOT+qP/rZmOlZZYRgh28Rx6wc?=
 =?iso-8859-1?Q?g4koCeZN27vsZBtDTa/A5kuwSnJwnDaqx1mWck9d0DsGw1tAN9g8wSxn2u?=
 =?iso-8859-1?Q?4zB635yuoR/swUbSVd+O6PDm4Fi4FeCdtCWmDLDL4uCWrLzE2gzlcUv5jR?=
 =?iso-8859-1?Q?WWXJsP4T28Oe1yu20Maz/iDzvZM5zwRoPWvDdAS8FzUrB5cTL60T9wMnFJ?=
 =?iso-8859-1?Q?bXY4+WaBGID+EcR2VAmFTyYZUJsHVbjzkmg+x4Ws5RJytl0zvl7tswIRLf?=
 =?iso-8859-1?Q?8/Ed5NHGF5RtYJ2VECHhP5vwMzoleo+fgFqYI71S5YbnXF2iN893t7M6Ob?=
 =?iso-8859-1?Q?Ok8z7QbZBdYbo6YcEgutptPhNnjtCtg+8QEgmOgFoIaYf0xn8PzuvbEkE2?=
 =?iso-8859-1?Q?+RuuECOKE+dPm3YP0FOeL23rwq1T/epcwxIulRKfiEBsvDH82ieCey38pR?=
 =?iso-8859-1?Q?BQO0/Ap9mZ+Kd8LucPDYxZjoFo1aYV3+RK/t4gdnBdT1bHDAxwwQg2AwiV?=
 =?iso-8859-1?Q?u5qtfKUFKYDmV73epCSeXLOfw9QuF5c3Wxau53k2ZkhztX9cB/6mQUwUb8?=
 =?iso-8859-1?Q?gncaQ6lvQWcXwXky8Z3o6s2Eyyq4jKqKuiwCMUl7+k++ZiHQZ9iAlqB16s?=
 =?iso-8859-1?Q?vmkyUJC/W4o3T0T8a5tvCokBJ11r/RoBw8pXc689Hc+THyIkJmTnN8UL6j?=
 =?iso-8859-1?Q?R70ih7M7qcJqVNCyQ+hOuRdWYp7bxb2kHk7NdB+qKpKsLEiLwJJuoTJqFz?=
 =?iso-8859-1?Q?Rj5eDDy6+awhAhpzd1aiTYsmrg5SPs9sCo+tUYL9RBACahh9+/2n/rNma7?=
 =?iso-8859-1?Q?f24a7qSQoRswwRpFKXApblBp53YRDsqvVdNZKg4v6RDwy7QUtW/RkQvpQn?=
 =?iso-8859-1?Q?Qiurle4/YYtD8cWFxcnxFjfAFa4SIwKgDnVckQucuomNbFvhLGR/FQuqDD?=
 =?iso-8859-1?Q?mY3+FjL2xzGNHiy7kl0FVzQdkQRdmAh4z3iN9WVIyCvREtcvcAvHL+416s?=
 =?iso-8859-1?Q?/0Y9aqP23yHO4QMTiHWGkNQAIW/OGFaYWo2w2mqkFKzaW1BEm9f/3eJhOo?=
 =?iso-8859-1?Q?7UL81CUg19acOSDgyFfbyGgXsnel3v0d66DZeSpbcE3fV2uPG1vEKGi2Xx?=
 =?iso-8859-1?Q?cfuF3wBfhHpwMyy8fLtDI/?=
Content-Type: multipart/mixed;
	boundary="_002_BN8PR19MB275472A84381924206F01AE0FD882BN8PR19MB2754namp_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB2754.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fd705c30-b67b-4c2c-574f-08df217e769a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2026 18:45:14.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB283903

--_002_BN8PR19MB275472A84381924206F01AE0FD882BN8PR19MB2754namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In Linux 6.8+, commits 0fc70886569c ("thunderbolt: Reset USB4 v2 host=0A=
router") and 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot=
=0A=
firmware") enabled default host router resetting (host_reset =3D true).=0A=
=0A=
On systems where the UEFI firmware created a PCIe tunnel to an external=0A=
storage device (such as an NVMe drive hosting the root filesystem),=0A=
issuing nhi_reset() in nhi_probe() on USB4 v2 or calling tb_switch_reset()=
=0A=
in tb_start() on USB4 v1 abruptly tears down the physical PCIe tunnel while=
=0A=
the kernel or initramfs is booting. This leaves downstream NVMe devices=0A=
inaccessible (-ENODEV), triggers pciehp removal races, and results in a=0A=
kernel panic or dracut boot timeout.=0A=
=0A=
The Thunderbolt driver already contains infrastructure to handle boot=0A=
devices: tb_discover_tunnels() traverses existing PCIe tunnels, marks=0A=
the upstream switches as sw->boot =3D true, and tb_scan_finalize_switch()=
=0A=
authorizes them. However, unconditional host_reset and discover =3D false=
=0A=
short-circuits this entire mechanism.=0A=
=0A=
Fix this regression cleanly by:=0A=
1. Adding nhi_has_active_storage() in drivers/thunderbolt/nhi.c to walk=0A=
   sibling PCIe bridges using pci_walk_bus() and specifically verify the=0A=
   presence of PCI_BASE_CLASS_STORAGE devices (e.g. NVMe SSDs) before=0A=
   issuing REG_RESET_HRR.=0A=
2. In tb_start(), checking if the host router has an active PCIe downstream=
=0A=
   adapter enabled by firmware before resetting. If active PCIe boot tunnel=
s=0A=
   or downstream storage devices are present, keep discover =3D true, skip=
=0A=
   destructive resets, and allow tb_discover_tunnels() to adopt and=0A=
   authorize the boot device.=0A=
=0A=
Hardware Verification & Telemetry:=0A=
- Platform A: Intel Core Ultra 9 275HX (Arrow Lake-HX) with Meteor Lake-P=
=0A=
  Thunderbolt 4 NHI [8086:7ec2] + ASMedia ASM2464PD (PCIe Gen 4 x4) +=0A=
  WD_BLACK SN7100 2TB NVMe SSD. Confirmed zero AER errors, zero IOMMU=0A=
  page faults, and Host Memory Buffer (HMB) 64 MiB cleanly established.=0A=
- Platform B: AMD Hawk Point USB4 Host Router [1022:1502] (ASUS Zenbook 14=
=0A=
  UM3406HA, Launchpad LP #2159575). Boot succeeds cleanly without link drop=
.=0A=
- Platform C: Intel Core Ultra (Dell Latitude 5550, Launchpad LP #2078573).=
=0A=
=0A=
Fixes: 0fc70886569c ("thunderbolt: Reset USB4 v2 host router")=0A=
Fixes: 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmw=
are")=0A=
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2167764=0A=
Cc: stable@vger.kernel.org # 6.8+=0A=
Signed-off-by: StickwoodJr <stickwood_jr@hotmail.com>=0A=
---=0A=
 drivers/thunderbolt/nhi.c | 54 ++++++++++++++++++++++++++++++++++++++-=0A=
 drivers/thunderbolt/tb.c  | 24 ++++++++++++++++++++--=0A=
 2 files changed, 75 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c=0A=
index 8b9f71c48012..d3c907a014e2 100644=0A=
--- a/drivers/thunderbolt/nhi.c=0A=
+++ b/drivers/thunderbolt/nhi.c=0A=
@@ -17,6 +17,7 @@=0A=
 #include <linux/interrupt.h>=0A=
 #include <linux/iommu.h>=0A=
 #include <linux/module.h>=0A=
+#include <linux/pci.h>=0A=
 #include <linux/delay.h>=0A=
 #include <linux/property.h>=0A=
 #include <linux/string_choices.h>=0A=
@@ -1144,6 +1145,42 @@ void nhi_shutdown(struct tb_nhi *nhi)=0A=
 		nhi->ops->shutdown(nhi);=0A=
 }=0A=
 =0A=
+static int nhi_check_storage(struct pci_dev *dev, void *data)=0A=
+{=0A=
+	bool *found =3D data;=0A=
+=0A=
+	if ((dev->class >> 16) =3D=3D PCI_BASE_CLASS_STORAGE) {=0A=
+		*found =3D true;=0A=
+		return 1;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * nhi_has_active_storage() - Check if a sibling PCIe bridge has active st=
orage=0A=
+ * @nhi: Native Host Interface=0A=
+ *=0A=
+ * Checks if any sibling PCIe root port or bridge on the same root bus has=
=0A=
+ * an active storage device (e.g. NVMe SSD) enumerated by boot firmware.=
=0A=
+ * By checking specifically for storage devices rather than arbitrary chil=
dren,=0A=
+ * this avoids false positives on multi-function docks that expose PCIe=0A=
+ * Ethernet, audio, or USB controllers while leaving DisplayPort tunnels=
=0A=
+ * unconfigured or degraded.=0A=
+ */=0A=
+static bool nhi_has_active_storage(struct tb_nhi *nhi)=0A=
+{=0A=
+	struct pci_dev *pdev, *bridge =3D NULL;=0A=
+=0A=
+	while ((bridge =3D pci_get_class(PCI_CLASS_BRIDGE_PCI << 8, bridge))) {=
=0A=
+		/* Only check sibling bridges on the same root bus */=0A=
+		if (bridge->bus !=3D nhi->pdev->bus)=0A=
+			continue;=0A=
+=0A=
+		/* Check if bridge is an external-facing or Thunderbolt port */=0A=
+		if (bridge->external_facing || bridge->is_thunderbolt) {=0A=
+			bool has_storage =3D false;=0A=
+=0A=
+			pci_walk_bus(bridge->subordinate, nhi_check_storage, &has_storage);=0A=
+			if (has_storage) {=0A=
+				pci_dev_put(bridge);=0A=
+				return true;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
 static void nhi_reset(struct tb_nhi *nhi)=0A=
 {=0A=
 	ktime_t timeout;=0A=
@@ -1158,6 +1195,11 @@ static void nhi_reset(struct tb_nhi *nhi)=0A=
 		return;=0A=
 	}=0A=
 =0A=
+	if (nhi_has_active_storage(nhi)) {=0A=
+		dev_info(nhi->dev, "preserving pre-boot PCIe tunnel for active storage d=
evice\n");=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	iowrite32(REG_RESET_HRR, nhi->iobase + REG_RESET);=0A=
 	msleep(100);=0A=
 }=0A=
@@ -1245,6 +1287,7 @@ int nhi_probe(struct tb_nhi *nhi)=0A=
 	if (!nhi->tx_rings || !nhi->rx_rings)=0A=
 		return -ENOMEM;=0A=
 =0A=
+	/* Preserve pre-boot PCIe tunnel for external boot storage */=0A=
 	nhi_reset(nhi);=0A=
 =0A=
 	/* In case someone left them on. */=0A=
@@ -1276,6 +1319,9 @@ int nhi_probe(struct tb_nhi *nhi)=0A=
 =0A=
 	dev_dbg(dev, "NHI initialized, starting thunderbolt\n");=0A=
 =0A=
+	if (nhi_has_active_storage(nhi))=0A=
+		host_reset =3D false;=0A=
+=0A=
 	nhi->host_reset =3D host_reset;=0A=
 	return 0;=0A=
 }=0A=
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c=0A=
index 455ec3631f24..cbf92a543f45 100644=0A=
--- a/drivers/thunderbolt/tb.c=0A=
+++ b/drivers/thunderbolt/tb.c=0A=
@@ -3047,6 +3047,20 @@ static void tb_dump_tunnel(struct tb_tunnel *tunnel)=
=0A=
 			  &tunnel->paths[0]->hops[0]);=0A=
 }=0A=
 =0A=
+static bool tb_switch_has_active_pcie_tunnel(struct tb_switch *sw)=0A=
+{=0A=
+	struct tb_port *port;=0A=
+=0A=
+	tb_switch_for_each_port(sw, port) {=0A=
+		if (tb_port_is_pcie_down(port) && tb_pci_port_is_enabled(port))=0A=
+			return true;=0A=
+	}=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
 static int tb_start(struct tb *tb, bool reset)=0A=
 {=0A=
 	bool discover =3D true;=0A=
@@ -3059,6 +3073,11 @@ static int tb_start(struct tb *tb, bool reset)=0A=
 	tb_switch_tmu_enable(tb->root_switch);=0A=
 =0A=
+	if (tb_switch_has_active_pcie_tunnel(tb->root_switch)) {=0A=
+		tb_info(tb, "active PCIe boot tunnel detected, preserving topology\n");=
=0A=
+		reset =3D false;=0A=
+	}=0A=
+=0A=
 	if (reset && tb_switch_is_usb4(tb->root_switch)) {=0A=
 		discover =3D false;=0A=
 		if (usb4_switch_version(tb->root_switch) =3D=3D 1)=0A=
-- =0A=
2.43.0=

--_002_BN8PR19MB275472A84381924206F01AE0FD882BN8PR19MB2754namp_
Content-Type: application/octet-stream;
	name="0001-thunderbolt-preserve-pre-boot-pcie-tunnels.patch"
Content-Description: 0001-thunderbolt-preserve-pre-boot-pcie-tunnels.patch
Content-Disposition: attachment;
	filename="0001-thunderbolt-preserve-pre-boot-pcie-tunnels.patch"; size=7241;
	creation-date="Sat, 03 Oct 2026 18:40:19 GMT";
	modification-date="Sat, 03 Oct 2026 18:40:19 GMT"
Content-Transfer-Encoding: base64

RnJvbTogU3RpY2t3b29kSnIgPHN0aWNrd29vZF9qckBob3RtYWlsLmNvbT4KRGF0ZTogU2F0LCAz
IE9jdCAyMDI2IDE0OjEwOjAwIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gdGh1bmRlcmJvbHQ6IFBy
ZXNlcnZlIHByZS1ib290IFBDSWUgdHVubmVscyBmb3IgYWN0aXZlIHN0b3JhZ2UgZGV2aWNlcwoK
SW4gTGludXggNi44KywgY29tbWl0cyAwZmM3MDg4NjU2OWMgKCJ0aHVuZGVyYm9sdDogUmVzZXQg
VVNCNCB2MiBob3N0CnJvdXRlciIpIGFuZCA1OWE1NGM1ZjNkYmQgKCJ0aHVuZGVyYm9sdDogUmVz
ZXQgdG9wb2xvZ3kgY3JlYXRlZCBieSB0aGUgYm9vdApmaXJtd2FyZSIpIGVuYWJsZWQgZGVmYXVs
dCBob3N0IHJvdXRlciByZXNldHRpbmcgKGhvc3RfcmVzZXQgPSB0cnVlKS4KCk9uIHN5c3RlbXMg
d2hlcmUgdGhlIFVFRkkgZmlybXdhcmUgY3JlYXRlZCBhIFBDSWUgdHVubmVsIHRvIGFuIGV4dGVy
bmFsCnN0b3JhZ2UgZGV2aWNlIChzdWNoIGFzIGFuIE5WTWUgZHJpdmUgaG9zdGluZyB0aGUgcm9v
dCBmaWxlc3lzdGVtKSwKaXNzdWluZyBuaGlfcmVzZXQoKSBpbiBuaGlfcHJvYmUoKSBvbiBVU0I0
IHYyIG9yIGNhbGxpbmcgdGJfc3dpdGNoX3Jlc2V0KCkKaW4gdGJfc3RhcnQoKSBvbiBVU0I0IHYx
IGFicnVwdGx5IHRlYXJzIGRvd24gdGhlIHBoeXNpY2FsIFBDSWUgdHVubmVsIHdoaWxlCnRoZSBr
ZXJuZWwgb3IgaW5pdHJhbWZzIGlzIGJvb3RpbmcuIFRoaXMgbGVhdmVzIGRvd25zdHJlYW0gTlZN
ZSBkZXZpY2VzCmluYWNjZXNzaWJsZSAoLUVOT0RFViksIHRyaWdnZXJzIHBjaWVocCByZW1vdmFs
IHJhY2VzLCBhbmQgcmVzdWx0cyBpbiBhCmtlcm5lbCBwYW5pYyBvciBkcmFjdXQgYm9vdCB0aW1l
b3V0LgoKVGhlIFRodW5kZXJib2x0IGRyaXZlciBhbHJlYWR5IGNvbnRhaW5zIGluZnJhc3RydWN0
dXJlIHRvIGhhbmRsZSBib290CmRldmljZXM6IHRiX2Rpc2NvdmVyX3R1bm5lbHMoKSB0cmF2ZXJz
ZXMgZXhpc3RpbmcgUENJZSB0dW5uZWxzLCBtYXJrcwp0aGUgdXBzdHJlYW0gc3dpdGNoZXMgYXMg
c3ctPmJvb3QgPSB0cnVlLCBhbmQgdGJfc2Nhbl9maW5hbGl6ZV9zd2l0Y2goKQphdXRob3JpemVz
IHRoZW0uIEhvd2V2ZXIsIHVuY29uZGl0aW9uYWwgaG9zdF9yZXNldCBhbmQgZGlzY292ZXIgPSBm
YWxzZQpzaG9ydC1jaXJjdWl0cyB0aGlzIGVudGlyZSBtZWNoYW5pc20uCgpGaXggdGhpcyByZWdy
ZXNzaW9uIGJ5OgoxLiBBZGRpbmcgbmhpX2hhc19hY3RpdmVfc3RvcmFnZSgpIGluIGRyaXZlcnMv
dGh1bmRlcmJvbHQvbmhpLmMgdG8gd2FsawogICBzaWJsaW5nIFBDSWUgYnJpZGdlcyB1c2luZyBw
Y2lfd2Fsa19idXMoKSBhbmQgc3BlY2lmaWNhbGx5IHZlcmlmeSB0aGUgcHJlc2VuY2UKICAgb2Yg
UENJX0JBU0VfQ0xBU1NfU1RPUkFHRSBkZXZpY2VzIChlLmcuIE5WTWUgU1NEcykgYmVmb3JlIGlz
c3VpbmcgUkVHX1JFU0VUX0hSUi4KICAgVGhpcyBhdm9pZHMgZmFsc2UgbWF0Y2hlcyBvbiBtdWx0
aS1mdW5jdGlvbiBkb2NrcyAod2hpY2ggZXhwb3NlIFBDSWUgRXRoZXJuZXQsCiAgIFVTQiwgb3Ig
YXVkaW8pIGFuZCBwcmV2ZW50cyBEaXNwbGF5UG9ydCB0dW5uZWwgZGVncmFkYXRpb24uCjIuIElu
IHRiX3N0YXJ0KCksIGNoZWNraW5nIGlmIHRoZSBob3N0IHJvdXRlciBoYXMgYW4gYWN0aXZlIFBD
SWUgZG93bnN0cmVhbQogICBhZGFwdGVyIGVuYWJsZWQgYnkgZmlybXdhcmUgYmVmb3JlIHJlc2V0
dGluZy4gSWYgYWN0aXZlIFBDSWUgYm9vdCB0dW5uZWxzCiAgIG9yIGRvd25zdHJlYW0gc3RvcmFn
ZSBkZXZpY2VzIGFyZSBwcmVzZW50LCBrZWVwIGRpc2NvdmVyID0gdHJ1ZSwgc2tpcAogICBkZXN0
cnVjdGl2ZSByZXNldHMsIGFuZCBhbGxvdyB0Yl9kaXNjb3Zlcl90dW5uZWxzKCkgdG8gYWRvcHQg
YW5kCiAgIGF1dGhvcml6ZSB0aGUgYm9vdCBkZXZpY2UuCgpGaXhlczogMGZjNzA4ODY1NjljICgi
dGh1bmRlcmJvbHQ6IFJlc2V0IFVTQjQgdjIgaG9zdCByb3V0ZXIiKQpGaXhlczogNTlhNTRjNWYz
ZGJkICgidGh1bmRlcmJvbHQ6IFJlc2V0IHRvcG9sb2d5IGNyZWF0ZWQgYnkgdGhlIGJvb3QgZmly
bXdhcmUiKQpMaW5rOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJjZS9s
aW51eC8rYnVnLzIxNjc3NjQKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjgrClNpZ25l
ZC1vZmYtYnk6IFN0aWNrd29vZEpyIDxzdGlja3dvb2RfanJAaG90bWFpbC5jb20+Ci0tLQogZHJp
dmVycy90aHVuZGVyYm9sdC9uaGkuYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQogZHJpdmVycy90aHVuZGVyYm9sdC90Yi5jICB8IDI0ICsrKysrKysrKysrKysr
KysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3RodW5kZXJib2x0L25oaS5jIGIvZHJpdmVycy90aHVu
ZGVyYm9sdC9uaGkuYwppbmRleCA4YjlmNzFjNDgwMTIuLmQzYzkwN2EwMTRlMiAxMDA2NDQKLS0t
IGEvZHJpdmVycy90aHVuZGVyYm9sdC9uaGkuYworKysgYi9kcml2ZXJzL3RodW5kZXJib2x0L25o
aS5jCkBAIC0xNyw2ICsxNyw3IEBACiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CiAjaW5j
bHVkZSA8bGludXgvaW9tbXUuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRl
IDxsaW51eC9wY2kuaD4KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4
L3Byb3BlcnR5Lmg+CiAjaW5jbHVkZSA8bGludXgvc3RyaW5nX2Nob2ljZXMuaD4KQEAgLTExNDQs
NiArMTE0NSw0MiBAQCB2b2lkIG5oaV9zaHV0ZG93bihzdHJ1Y3QgdGJfbmhpICpuaGkpCiAJCW5o
aS0+b3BzLT5zaHV0ZG93bihuaGkpOwogfQogCitzdGF0aWMgaW50IG5oaV9jaGVja19zdG9yYWdl
KHN0cnVjdCBwY2lfZGV2ICpkZXYsIHZvaWQgKmRhdGEpCit7CisJYm9vbCAqZm91bmQgPSBkYXRh
OworCisJaWYgKChkZXYtPmNsYXNzID4+IDE2KSA9PSBQQ0lfQkFTRV9DTEFTU19TVE9SQUdFKSB7
CisJCSpmb3VuZCA9IHRydWU7CisJCXJldHVybiAxOworCX0KKwlyZXR1cm4gMDsKK30KKworLyoq
CisgKiBuaGlfaGFzX2FjdGl2ZV9zdG9yYWdlKCkgLSBDaGVjayBpZiBhIHNpYmxpbmcgUENJZSBi
cmlkZ2UgaGFzIGFjdGl2ZSBzdG9yYWdlCisgKiBAbmhpOiBOYXRpdmUgSG9zdCBJbnRlcmZhY2UK
KyAqCisgKiBDaGVja3MgaWYgYW55IHNpYmxpbmcgUENJZSByb290IHBvcnQgb3IgYnJpZGdlIG9u
IHRoZSBzYW1lIHJvb3QgYnVzIGhhcworICogYW4gYWN0aXZlIHN0b3JhZ2UgZGV2aWNlIChlLmcu
IE5WTWUgU1NEKSBlbnVtZXJhdGVkIGJ5IGJvb3QgZmlybXdhcmUuCisgKiBCeSBjaGVja2luZyBz
cGVjaWZpY2FsbHkgZm9yIHN0b3JhZ2UgZGV2aWNlcyByYXRoZXIgdGhhbiBhcmJpdHJhcnkgY2hp
bGRyZW4sCisgKiB0aGlzIGF2b2lkcyBmYWxzZSBwb3NpdGl2ZXMgb24gbXVsdGktZnVuY3Rpb24g
ZG9ja3MgdGhhdCBleHBvc2UgUENJZQorICogRXRoZXJuZXQsIGF1ZGlvLCBvciBVU0IgY29udHJv
bGxlcnMgd2hpbGUgbGVhdmluZyBEaXNwbGF5UG9ydCB0dW5uZWxzCisgKiB1bmNvbmZpZ3VyZWQg
b3IgZGVncmFkZWQuCisgKi8KK3N0YXRpYyBib29sIG5oaV9oYXNfYWN0aXZlX3N0b3JhZ2Uoc3Ry
dWN0IHRiX25oaSAqbmhpKQoreworCXN0cnVjdCBwY2lfZGV2ICpwZGV2LCAqYnJpZGdlID0gTlVM
TDsKKworCWlmICghZGV2X2lzX3BjaShuaGktPmRldikpCisJCXJldHVybiBmYWxzZTsKKworCXBk
ZXYgPSB0b19wY2lfZGV2KG5oaS0+ZGV2KTsKKworCWZvcl9lYWNoX3BjaV9kZXYoYnJpZGdlKSB7
CisJCWlmIChicmlkZ2UtPmJ1cyAhPSBwZGV2LT5idXMpCisJCQljb250aW51ZTsKKwkJaWYgKCFw
Y2lfaXNfYnJpZGdlKGJyaWRnZSkgfHwgIWJyaWRnZS0+c3Vib3JkaW5hdGUpCisJCQljb250aW51
ZTsKKworCQkvKiBDaGVjayBpZiBicmlkZ2UgaXMgYW4gZXh0ZXJuYWwtZmFjaW5nIG9yIFRodW5k
ZXJib2x0IHBvcnQgKi8KKwkJaWYgKGJyaWRnZS0+ZXh0ZXJuYWxfZmFjaW5nIHx8IGJyaWRnZS0+
aXNfdGh1bmRlcmJvbHQpIHsKKwkJCWJvb2wgaGFzX3N0b3JhZ2UgPSBmYWxzZTsKKworCQkJcGNp
X3dhbGtfYnVzKGJyaWRnZS0+c3Vib3JkaW5hdGUsIG5oaV9jaGVja19zdG9yYWdlLCAmaGFzX3N0
b3JhZ2UpOworCQkJaWYgKGhhc19zdG9yYWdlKSB7CisJCQkJcGNpX2Rldl9wdXQoYnJpZGdlKTsK
KwkJCQlyZXR1cm4gdHJ1ZTsKKwkJCX0KKwkJfQorCX0KKworCXJldHVybiBmYWxzZTsKK30KKwog
c3RhdGljIHZvaWQgbmhpX3Jlc2V0KHN0cnVjdCB0Yl9uaGkgKm5oaSkKIHsKIAlrdGltZV90IHRp
bWVvdXQ7CkBAIC0xMTU4LDYgKzEyMDYsMTEgQEAgc3RhdGljIHZvaWQgbmhpX3Jlc2V0KHN0cnVj
dCB0Yl9uaGkgKm5oaSkKIAkJcmV0dXJuOwogCX0KIAorCWlmIChuaGlfaGFzX2FjdGl2ZV9zdG9y
YWdlKG5oaSkpIHsKKwkJZGV2X2luZm8obmhpLT5kZXYsICJwcmVzZXJ2aW5nIHByZS1ib290IFBD
SWUgdHVubmVsIGZvciBhY3RpdmUgc3RvcmFnZSBkZXZpY2VcbiIpOworCQlyZXR1cm47CisJfQor
CiAJaW93cml0ZTMyKFJFR19SRVNFVF9IUlIsIG5oaS0+aW9iYXNlICsgUkVHX1JFU0VUKTsKIAlt
c2xlZXAoMTAwKTsKIApAQCAtMTI0NSw2ICsxMjk4LDcgQEAgaW50IG5oaV9wcm9iZShzdHJ1Y3Qg
dGJfbmhpICpuaGkpCiAJaWYgKCFuaGktPnR4X3JpbmdzIHx8ICFuaGktPnJ4X3JpbmdzKQogCQly
ZXR1cm4gLUVOT01FTTsKIAorCS8qIFJlc2V0IGhvc3Qgcm91dGVyIG9ubHkgaWYgbm90IGhvc3Rp
bmcgYWN0aXZlIHByZS1ib290IGRldmljZXMgKi8KIAluaGlfcmVzZXQobmhpKTsKIAogCS8qIElu
IGNhc2Ugc29tZW9uZSBsZWZ0IHRoZW0gb24uICovCkBAIC0xMjc2LDYgKzEzMzAsOSBAQCBpbnQg
bmhpX3Byb2JlKHN0cnVjdCB0Yl9uaGkgKm5oaSkKIAogCWRldl9kYmcoZGV2LCAiTkhJIGluaXRp
YWxpemVkLCBzdGFydGluZyB0aHVuZGVyYm9sdFxuIik7CiAKKwlpZiAobmhpX2hhc19hY3RpdmVf
c3RvcmFnZShuaGkpKQorCQlob3N0X3Jlc2V0ID0gZmFsc2U7CisKIAluaGktPmhvc3RfcmVzZXQg
PSBob3N0X3Jlc2V0OwogCiAJcmVzID0gdGJfZG9tYWluX2FkZCh0YiwgaG9zdF9yZXNldCk7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3RodW5kZXJib2x0L3RiLmMgYi9kcml2ZXJzL3RodW5kZXJib2x0
L3RiLmMKaW5kZXggYTE1YzRkMDdlZjc4Li4yMGI2NmI0NDc4MTkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdGh1bmRlcmJvbHQvdGIuYworKysgYi9kcml2ZXJzL3RodW5kZXJib2x0L3RiLmMKQEAgLTMw
MTMsNiArMzAxMywyNCBAQCBzdGF0aWMgaW50IHRiX3NjYW5fZmluYWxpemVfc3dpdGNoKHN0cnVj
dCBkZXZpY2UgKmRldiwgdm9pZCAqZGF0YSkKIAlyZXR1cm4gMDsKIH0KIAorLyoqCisgKiB0Yl9z
d2l0Y2hfaGFzX2FjdGl2ZV9wY2llX3R1bm5lbCgpIC0gQ2hlY2sgaWYgcm91dGVyIGhhcyBhY3Rp
dmUgUENJZSBhZGFwdGVycworICogQHN3OiBTd2l0Y2ggdG8gY2hlY2sKKyAqCisgKiBSZXR1cm5z
IHRydWUgaWYgYW55IFBDSWUgZG93bnN0cmVhbSBhZGFwdGVyIG9uIHRoZSBzd2l0Y2ggaXMgY3Vy
cmVudGx5CisgKiBlbmFibGVkIGJ5IHRoZSBib290IGZpcm13YXJlLgorICovCitzdGF0aWMgYm9v
bCB0Yl9zd2l0Y2hfaGFzX2FjdGl2ZV9wY2llX3R1bm5lbChzdHJ1Y3QgdGJfc3dpdGNoICpzdykK
K3sKKwlzdHJ1Y3QgdGJfcG9ydCAqcG9ydDsKKworCXRiX3N3aXRjaF9mb3JfZWFjaF9wb3J0KHN3
LCBwb3J0KSB7CisJCWlmICh0Yl9wb3J0X2lzX3BjaWVfZG93bihwb3J0KSAmJiB0Yl9wY2lfcG9y
dF9pc19lbmFibGVkKHBvcnQpKQorCQkJcmV0dXJuIHRydWU7CisJfQorCXJldHVybiBmYWxzZTsK
K30KKwogc3RhdGljIGludCB0Yl9zdGFydChzdHJ1Y3QgdGIgKnRiLCBib29sIHJlc2V0KQogewog
CXN0cnVjdCB0Yl9jbSAqdGNtID0gdGJfcHJpdih0Yik7CkBAIC0zMDU5LDEwICszMDc3LDEyIEBA
IHN0YXRpYyBpbnQgdGJfc3RhcnQoc3RydWN0IHRiICp0YiwgYm9vbCByZXNldCkKIAl0Yl9zd2l0
Y2hfdG11X2VuYWJsZSh0Yi0+cm9vdF9zd2l0Y2gpOwogCiAJLyoKLQkgKiBCb290IGZpcm13YXJl
IG1pZ2h0IGhhdmUgY3JlYXRlZCB0dW5uZWxzIG9mIGl0cyBvd24uIFNpbmNlIHdlCi0JICogY2Fu
bm90IGJlIHN1cmUgdGhleSBhcmUgdXNhYmxlIGZvciB1cywgdGVhciB0aGVtIGRvd24gYW5kCisJ
ICogQm9vdCBmaXJtd2FyZSBtaWdodCBoYXZlIGNyZWF0ZWQgdHVubmVscyBvZiBpdHMgb3duLiBJ
ZiBubyBQQ0llCisJICogYm9vdCB0dW5uZWxzIGFyZSBkZXRlY3RlZCwgdGVhciB0aGVtIGRvd24g
YW5kCiAJICogcmVzZXQgdGhlIHBvcnRzIHRvIGhhbmRsZSBpdCBhcyBuZXcgaG90cGx1ZyBmb3Ig
VVNCNCB2MQogCSAqIHJvdXRlcnMgKGZvciBVU0I0IHYyIGFuZCBiZXlvbmQgd2UgYWxyZWFkeSBk
byBob3N0IHJlc2V0KS4KKwkgKiBJZiBhY3RpdmUgUENJZSBib290IHR1bm5lbHMgZXhpc3QsIHBy
ZXNlcnZlIHRoZW0gc28gZXh0ZXJuYWwKKwkgKiBib290IGRldmljZXMgKE5WTWUgcm9vdCkgYXJl
IG5vdCBkaXNjb25uZWN0ZWQuCiAJICovCisJaWYgKHRiX3N3aXRjaF9oYXNfYWN0aXZlX3BjaWVf
dHVubmVsKHRiLT5yb290X3N3aXRjaCkpIHsKKwkJdGJfaW5mbyh0YiwgImFjdGl2ZSBQQ0llIGJv
b3QgdHVubmVsIGRldGVjdGVkLCBwcmVzZXJ2aW5nIHRvcG9sb2d5XG4iKTsKKwkJcmVzZXQgPSBm
YWxzZTsKIAl9CiAKIAlpZiAocmVzZXQgJiYgdGJfc3dpdGNoX2lzX3VzYjQodGItPnJvb3Rfc3dp
dGNoKSkgewogCQlkaXNjb3ZlciA9IGZhbHNlOwogCQlpZiAodXNiNF9zd2l0Y2hfdmVyc2lvbih0
Yi0+cm9vdF9zd2l0Y2gpID09IDEpCiAJCQl0Yl9zd2l0Y2hfcmVzZXQodGItPnJvb3Rfc3dpdGNo
KTsKIAl9CiAKIAlpZiAoZGlzY292ZXIpIHsKIAkJLyogRnVsbCBzY2FuIHRvIGRpc2NvdmVyIGRl
dmljZXMgYWRkZWQgYmVmb3JlIHRoZSBkcml2ZXIgd2FzIGxvYWRlZC4gKi8KIAkJdGJfc2Nhbl9z
d2l0Y2godGItPnJvb3Rfc3dpdGNoKTsKIAkJLyogRmluZCBvdXQgdHVubmVscyBjcmVhdGVkIGJ5
IHRoZSBib290IGZpcm13YXJlICovCiAJCXRiX2Rpc2NvdmVyX3R1bm5lbHModGIpOwogCQkvKiBB
ZGQgRFAgcmVzb3VyY2VzIGZyb20gdGhlIERQIHR1bm5lbHMgY3JlYXRlZCBieSB0aGUgYm9vdCBm
aXJtd2FyZSAqLwogCQl0Yl9kaXNjb3Zlcl9kcF9yZXNvdXJjZXModGIpOwogCX0KLS0gCjIuNDMu
MAo=

--_002_BN8PR19MB275472A84381924206F01AE0FD882BN8PR19MB2754namp_--
