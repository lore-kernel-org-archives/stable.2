Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92618AE3;
	Mon,  6 Jul 2026 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783311638; cv=fail; b=aOLoq5YEp0F1VQ3Nl1WR5ek4o0GmQzOVvn2TBuwEhCFgWu5twyIz8Myqx/2+Eo0DM4HOnc4fgSc0YGVMdwrtGt4ZXu7S/rxaRM1TGhar03bvKw0oj/TKGWfqh8Ft0KH+U0a3YzR7DSvxbFwxa0jkLwB3gn+QF/Aylte7nQY7OIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783311638; c=relaxed/simple;
	bh=3pQbd/mRi56XFXYPOoSmyj/dnM5EqPzQ2LH//Q/TIfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CMigSphzpfnBSrbKjKiqbLeh7gjA2mh0PqPPfboBrPUY41wqriQn2IPbpbNpVeYWfAenGf+n5nbrMvCTwrWcfMjb/w4WOxrMU+8skzMcdkFBEWD+oVAloe6mVU4X9XqX7id2P0z4fRot1bjmHZkmtag5kcAsbwJSk+AR7JW55JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WNBE4nWT; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WNBE4nWT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAldE02QbPfaPSq39jHr2ApNYmfGUh9flpTZINDjLzhke8knL1EQ18iDNQxRLz/k2HH/LavGCfy2zYXq7aRrk7GvsfKhGQ9eo2EFGcXcNyU/oQXLUnmKwMvRVCoTS5uM60ZoFOLGc4tmjTFiXQ+e6ztHC1+Ct4ks+E28b9LvJF3rC7DwUH+yYSQorQ54jfjm1DdGmd/gxbDdgrlagqCQWhBIcl+jWGZzKWvwbZDqfwbKSyC1Ak4BazGrJJzC2MJggjnGu5XcmVNv1dKDfFp7OIgI2BbfQqX1tIRpBJ3wTZcQumKf3KzZbBnuXSulfbKuLGWN4zH3Zw3KfeyJwa83bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5NWTgNvAXEyhXvlYm3z9Ac0oGJg4d7MaJ83kmeniAE=;
 b=h1NzSvjxK2BmzY5DvYLDftLY9RrMN+e6+E+LhL23Gn/qT/RBfL5y1SaRZUm7jFNZ4+pDoZxYxnUa4N1TN3CCIgPOV+Q9KhhxXA0iqbbntBgDfoivTaOeWKZW23UCetj2v8RisXaUHpXCAsWCSvdvqf4momPG4i5fqeiPPq5ISxWIwXIyFCWax5jgmMSKQhFvZ27DElyGRI0tB63F7XDHhKtkuLzh3EmH74GhlarQRDj7geJv+r989gf2FVFGgf5ER+vpUCOi3uJd7n6OWBEytayAV8toCEcem66aDFCWmnR4ePXJh+fS86isYNZ3etWxVvFQoGvMfYTAJuhkcqxE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5NWTgNvAXEyhXvlYm3z9Ac0oGJg4d7MaJ83kmeniAE=;
 b=WNBE4nWTfQJdyCT4TBCcMs8FUJtCE5Mv048nIgb23IkKl/TRpv5CuHJHaLvbrmu5tsQGe+HW7Y9Njcq6QJofgpIlFb+dvc8/YM5V+hVqpn1XftQxR9T0C3QBj5Hh4sKDDhBuxc+nPUWqW5B61ApWQeyxtJiR8Pq2p5KwaN4VS8A63rHWyYgUbHei4PnvT3kxGo5eHNSq09uWho9uinFuUY7SE9SBVibP60pIoeJpYjHVfCnVorDup2axIILxKDLPfiPDBtcZiCyvkyq+VEmR4ta00l4WuMHMKBMjMYB4BFsehzC1lVUnRTLMD45H4pMN+2JAmk58iCibm8uvi+sDRQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7574.eurprd04.prod.outlook.com (2603:10a6:20b:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 04:20:32 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 04:20:32 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Doruk Tan Ozturk <doruk@0sec.ai>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v1()
Thread-Topic: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v1()
Thread-Index: AQHdDP7JT7vXPcfUM0iznBtwsRT9OQ==
Date: Mon, 6 Jul 2026 04:20:32 +0000
Message-ID:
 <AS4PR04MB9692E00192B16910C3F3C011E7F12@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260705115650.81724-1-doruk@0sec.ai>
 <f28eea1f-80da-4def-b11f-33a531a1b595@molgen.mpg.de>
In-Reply-To: <f28eea1f-80da-4def-b11f-33a531a1b595@molgen.mpg.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS8PR04MB7574:EE_
x-ms-office365-filtering-correlation-id: f590ec6c-0b33-4034-8e4f-08dedb15eb95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|23010399003|366016|18002099003|22082099003|38070700021|4133799003|3023799007|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 nWNLKziqXk1ViZWtjzykjk0dSCluaVC5TXHXSdygaugVVF75xwvclw0iwuGy9WIlHjWv3Fc0XgZTdzYFj0HxWoVCyS7UYoCWh+wQhSi8F6aqYSG6B3l8JXAlKJXICIWZLePk0k99UTIt9626CNiNAwUIAJeaSzIpqOKY/gb3HlIA1gethc7bORzn//dkyTa7c1qrD3LbVMNcp/4ROsmh0DZTbNfR1J/wBMpBZn5y5+NNiluojs0OYEbpCpeRJ8tDiTZb2/V0TeqqLPlY3oMPrtMkU1KpwgnJNV9o2tAl+04nmYpYAEl6V/tVj3H5leHmOFDI51j7BRmeLjlciVl2Km9u8EmDPA+XLLVp0beE9MPSQFrtRmaUEBwOxc+FB9ce4EBMIH4D/PpGeC/ZNb9NEefLD3Dbk9qQsX+foYORJCJxi/KVLcDktlIw28np6GBWvWtTY1S2Q31QfIqA8SO2O7K6B4lKx5rjiKyBn5ivN+0dofyeATNCOIlvl3e+d/a0P3OQe7s/TB7Sp5hWj23yK4abPi9lNJHmUq96TlZO4bYkeIzmOUf4aXZ1YB8RoIMEbZLyl4GF+WhiyhVfFohvdjbZUZGzTtSJZKMFg8uBu7erjLfvOwQTILrXjDjwIgiaVFCVikDuxRUusLvZJEVZ6htuKdo3h19cD0UfJMgrRsM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(4133799003)(3023799007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sG2EVxpC+fzukreqB82lDxA/xyBvEk5FHyWS4giF6DOtkGlxZH+Er2uIEUOv?=
 =?us-ascii?Q?WxjEvuP1BC5Mm1j3dnr4UMRohsaR/9qo4Q1mhKVUkKORxrghEBvDBZ67pj84?=
 =?us-ascii?Q?ME2xHKUkJ5O2ZOIT6hTAkvgyM4+Zj9cJeN99Uf045VfquZLf5VMklZ5Wnx39?=
 =?us-ascii?Q?hI6h3udOYArir3BORrwTqiyGpyf3GIUTwy6S/TW1mtmdQgYOktGPxrVa+h/0?=
 =?us-ascii?Q?q/4gSaq7RM1vdF+SHnsrly8mxmoUd0SjNEkFkTmtHhSzhMqnojC3gVPOXLbG?=
 =?us-ascii?Q?0U0LEjoNQatIDKYBOut93u2lhaAIw7PhJzGjz8H4+Q4CE2fg/QE9k+MbVtuy?=
 =?us-ascii?Q?tSZeFTUGIhTNSAHeXZ53WISMIzw5PuNXgaE8cK1OW3o8NvwauU1GUPaMmO5V?=
 =?us-ascii?Q?pC0JATFbcwJN2+VXyIQfGHTq+7AduqG+IVAymQ057IeMdEzMWDPUHzXCL6if?=
 =?us-ascii?Q?r7t6z31i566fvFksfhCGnYBVOXGu97D1XNVsTRC90uh78oikOYR28kiaMBaq?=
 =?us-ascii?Q?5e9jwuuV1d7+I5rhCPPo3OYDEwvgChBcSsSZzim7xkOs743+NMNjFLkj4DWL?=
 =?us-ascii?Q?vcuMfdF/nr8Cp5I9LgW3UB/yD2nCjsiBYHI3DPMgpjdMqqhqqqozXuIlctg1?=
 =?us-ascii?Q?uS1XROfm2ixNiGZz/VaShVeR96V0qL5YOQVHnol9uR/vD9dzkP7E6W/O5CZ9?=
 =?us-ascii?Q?FBjpqNFQNQDxNv6A5F3AmTRxvFZQcpmgzSU4hxHuprH+XB6EkF65rI0bEL3n?=
 =?us-ascii?Q?wLpwtpc7Y2B31zzMlJMArGHUeGTkrssD6FgvxjqmAFDsw2CmQCdNC22yO77B?=
 =?us-ascii?Q?okASccgdDSSnYvJerChL7X0Z5D2USkgQNB6gh2hdRZpT6IifGij2xBKMorHG?=
 =?us-ascii?Q?D75/vvrO1/j83DsYEPCL03z7ARx1V3KdJlZifSQGrwHST+5Rc7T0m0WaBCQk?=
 =?us-ascii?Q?xrYX7r3rGElEDzr/32jQSG6pKldVyYiVkspdwC0JvUORfTXCBKoxplSIW6pd?=
 =?us-ascii?Q?2WLqd/reI1VCmI9Psy6TrH7LbqynTWPkxw40oTEaZLj9aBh1+BGyaadBVHrT?=
 =?us-ascii?Q?6RIQF+Gh68/yp5O/iKvFlAYBqcQ/9jzZVrXoJ5mHbuFqqJLeTWCoS0coYI96?=
 =?us-ascii?Q?XtHokWe2lWOTTp1Rnt6FCrs1+6HidQ3Iaq1Cm/tr3gQX3zXlVUSJgNFbR2AV?=
 =?us-ascii?Q?AQMD7DGWKCTh5VabWxSjf5oS7LbIYjw3BMX2X1D4I0dy9kBtHkYKLwAOUDTC?=
 =?us-ascii?Q?Zqoxl2hmrTK/rAhMan5E6ht3N95JhBJfPHu5j+sa+natx4lnNlMLTBZ8UoyP?=
 =?us-ascii?Q?OlqGh+apblVIjIgv6L2C3ozz/O8tyVt9WO8zvgWSVXAWouZn6e27A8obK4Kp?=
 =?us-ascii?Q?OiOcgW3fi/OtxEFhrieT0URhyZUKnG0+Th3Hplfn1eN0G0QsEZ6f6iy08nQV?=
 =?us-ascii?Q?SlBoIejSPnkB3ahG399W2v1+hA3wMwU5Gsc8TDGrk8cdO/Co3XFAQIvxNS8H?=
 =?us-ascii?Q?tom1tuwhvMGAhOSd3EJ//tlaNlVzCYmAI2hkiGbQ+FKAdutJmZEIWNYIOCJJ?=
 =?us-ascii?Q?D+FCh8Ux9cvO/cdzGVWVNrBA9LNxHxd8beqXdZ8IKfhSIgPvhvfh5Vjg7VxQ?=
 =?us-ascii?Q?0N0clOxW7B92BcN1Nw6x48Vs4+G6+ip+9aqc2Q+64DAiNPYFBKU8BYOIs8Ur?=
 =?us-ascii?Q?GCvTb5LPpJasEvt4EfkRwEDi5KlmutdI/EkAXtCD1aCr9VHB/fAc5q3643Zw?=
 =?us-ascii?Q?c65puTKNVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f590ec6c-0b33-4034-8e4f-08dedb15eb95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 04:20:32.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/yqWfZtj/mfTtVTkXRGk9YBos1KDzWOwur27ABDten6ntm5FPNcv8CpNcaHMRCBdPqh7zasvteOHg97kzBFfEK+kFWJ9vQFMNK2sZK1tSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7574

Hi Doruk,

Thank you for submitting this patch.

However, a similar patch is already in review and approved by me:
https://patchwork.kernel.org/project/bluetooth/patch/tencent_F2E2AF1B6F5105=
77B10C6897ED768BBBAF07@qq.com/
It's awaiting Luiz's review and/or merge.


Hi Luiz,

Can you please review the patch mentioned in the URL above, from Zhao Dongd=
ong? I have answered your review comment.
Thank you for your time and review.

Thanks,
Neeraj


> Dear Doruk,
>
>
> Thank you for the patch.
>
> Am 05.07.26 um 13:56 schrieb Doruk Tan Ozturk:
> > Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
> > read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset
> > but left an unbounded read in the v1 handler.
> >
> > nxp_recv_fw_req_v1() advances a device-driven download offset
> > (fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
> > bookkeeping runs even when the payload write is skipped, so the offset
> > can walk past nxpdev->fw->size. When the controller then requests a
> > header (len =3D=3D HDR_LEN), the driver reads the 16-byte bootloader
> > header at
> >
> >    nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
> >
> > with no bound on the offset, reading past the end of the firmware image=
.
> > A malicious or malfunctioning NXP UART controller can drive this to
> > read out-of-bounds kernel memory during firmware download.
> >
> > Bound the offset before the header read, and convert the payload write
> > guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset
> > is u32, so fw_dnld_v1_offset + len can wrap).
> >
> > This was found by 0sec automated security-research tooling
> >
> (https://0sec.a/
> i%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7Cc82fdb86e33f476
> 570ed08dedad83110%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C639188819230990815%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiO
> nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyf
> Q%3D%3D%7C0%7C%7C%7C&sdata=3Dz6YC4OGfeSW45U2PbFFlFz13DG3%2FSr
> qYeFKMSNTiMBI%3D&reserved=3D0).
> >
> > Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> > Bluetooth chipsets")
> > Cc: stable@vger.kernel.org
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
> >   drivers/bluetooth/btnxpuart.c | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btnxpuart.c
> > b/drivers/bluetooth/btnxpuart.c index 6a1cffe08d5f..88d9ebf25a8f
> > 100644
> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
> > @@ -1041,11 +1041,17 @@ static int nxp_recv_fw_req_v1(struct hci_dev
> *hdev, struct sk_buff *skb)
> >                * and we need to re-send the previous header again.
> >                */
> >               if (len =3D=3D nxpdev->fw_v1_expected_len) {
> > -                     if (len =3D=3D HDR_LEN)
> > +                     if (len =3D=3D HDR_LEN) {
> > +                             if (nxpdev->fw_dnld_v1_offset >=3D nxpdev=
->fw->size ||
> > +                                 nxpdev->fw->size - nxpdev->fw_dnld_v1=
_offset <
> HDR_LEN) {
> > +                                     bt_dev_err(hdev, "FW request
> > + offset out of bounds");
>
> Would it make sense to log all the values, as I'd think, such an issue mi=
ght be
> hard to reproduce and gathering the values miht be difficult?
>
> > +                                     goto free_skb;
> > +                             }
> >                               nxpdev->fw_v1_expected_len =3D nxp_get_da=
ta_len(nxpdev-
> >fw->data +
> >                                                                       n=
xpdev->fw_dnld_v1_offset);
> > -                     else
> > +                     } else {
> >                               nxpdev->fw_v1_expected_len =3D HDR_LEN;
> > +                     }
> >               } else if (len =3D=3D HDR_LEN) {
> >                       /* FW download out of sync. Send previous chunk a=
gain */
> >                       nxpdev->fw_dnld_v1_offset -=3D
> > nxpdev->fw_v1_sent_bytes; @@ -1053,7 +1059,8 @@ static int
> nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
> >               }
> >       }
> >
> > -     if (nxpdev->fw_dnld_v1_offset + len <=3D nxpdev->fw->size)
> > +     if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
> > +         len <=3D nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
> >               serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data =
+
> >                                       nxpdev->fw_dnld_v1_offset, len);
> >       nxpdev->fw_v1_sent_bytes =3D len;
>
>
> Kind regards,
>
> Paul
