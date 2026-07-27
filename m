Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959463BED11;
	Mon, 27 Jul 2026 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785132742; cv=fail; b=dQNcuaOQPuqYpITKZ1Aqw019pg/QovNaftnQCIWvSe/IhHC/mdOEF1udSIM1ynIshV9dvTs9LY/k12F2iWWct4Kd+fkzR9zUstBAul/qT0X+JcRJQ+EPAiqatC0yDHfHRoPpfkJEjF2S4VdDBZ3kuXWIsT8imeR5hSPFjX9Zrys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785132742; c=relaxed/simple;
	bh=ubTYq8g5PenxI2YIs9DpTVTA7q4vXNLD0lZpxBaYJVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeIBPhTQNedwcEjY44g0sR1/AcnKgZ54u8qQoFi94yCa1wn6XldBrmWgEjX2B4XMknPYVdaDqtFbIS7h4t+IbC6Og5p98PubAd8rOLoDv61N/zK+bmPw7syFKEy0I1SK/rvWWtOlQIqqLZ9vvtMqZXHH5A5Dv1yGyFoLCl33L/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=atqCGqKE; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="atqCGqKE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq9coKPT6Z7e7vwnUXskpwbzhhXixlvB1iwzNEXwID/UXBGWDZ9SV3AXVU7/PqU5V/rvhAd9ZUeE2yN6gcPxK0kjF4x9iMVLIEFDXxvs6bMi8iqwH+j9bmP2Nsr+REVE6TbiSBIKKQGhJyDMa6TgIdQbIjkvSXrej3/OUEZhkq3d9nYxuDJm9K+mEas1QzMvcVNMrJRKyHpO8YmZTT+rfW2ajw5edgxZ31SQncaIcrI1KK6g4wLh9vk2BPyzdKEioXqI6MrNgqySsRZtvqTrvX5Ey6x7ayuz9TJLGGNx/7/BZ12mCrY3GzmX62UBL2K7tH5uFetGUN5AmwYR/xcclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2llnRAzGH2hnu2Gbn6FdKakTsHY5x95mrZmFZgP5P10=;
 b=c8JoaJjvPSD5YKYIGG+j6BzLJW9W7det/uBsyTdgbg9aoNMrC5bJjEnohot6UaZZ4xx6CjaMAiNRqHPl8XAYEQSaKEvbrILr1Y0+xv6bkZoXBo5qrn2J4obW8svxFR6CfYUNniLVgl92Grj65RUzMi+8200ArzwPBRTFYXBQUJea/LtHVsZ3FcRrQcCWtsWghGNGt79CjYHOr/OuMJDGI16GJCKyqs4+0Xpx6Ctl/8tw+PaFsmsUr6Im8TbGJLVhuzy/8r74HEaKLEoccTItANtKBNiEaY2c+VJgnZgS5By20FtD8s3KQHq5jaFVfm+baeWxzhI/tcwGFVMUgmyTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2llnRAzGH2hnu2Gbn6FdKakTsHY5x95mrZmFZgP5P10=;
 b=atqCGqKEAirtq+FYz7VYVG0SVRZc76GKM0Onu5PnzsyQUM47y+h3pxafPJZBbIoA4g+NLK99CawxGVUULDKmD8/4XkbLdwIVo7h9cfvHERt/dagSjXlGjHxmMG+frzNFe8QOuzoeec78nHweBZH9bDCYpRcdb4WddJuiMdniLbXgzaV+D+E8LnUgBoKE1UXNDlXZduO9UcQ824Jzm1M4zYM68Ho1pi/9/cFBsztKtb8VgS9IoAgUGb+3QGEZNb+qV7oKx5re2SpQAoMc6QaVM+youLY88rAH35hN5EnwFOPVOHeqmhvc+i9fmTTCnXIZTzqChfUrfkRAwXz4y6nNDw==
Received: from AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:12:15 +0000
Received: from AM9PR04MB8570.eurprd04.prod.outlook.com
 ([fe80::c9cc:24fa:6f6d:fb03]) by AM9PR04MB8570.eurprd04.prod.outlook.com
 ([fe80::c9cc:24fa:6f6d:fb03%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:12:15 +0000
From: Ming Qian <ming.qian@nxp.com>
To: Fan Wu <fanwu01@zju.edu.cn>, Mirela Rabulea <mirela.rabulea@nxp.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXT] [PATCH] media: imx-jpeg: finish the job on device_run()
 error paths
Thread-Topic: [EXT] [PATCH] media: imx-jpeg: finish the job on device_run()
 error paths
Thread-Index: AQHdA3EQhz1laA4FzkO94Uiy3mwiK7aBFnNg
Date: Mon, 27 Jul 2026 06:12:15 +0000
Message-ID:
 <AM9PR04MB857016483639B476A396CE45E7CC2@AM9PR04MB8570.eurprd04.prod.outlook.com>
References: <20260624003208.12400-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260624003208.12400-1-fanwu01@zju.edu.cn>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8570:EE_|VI1PR04MB9980:EE_
x-ms-office365-filtering-correlation-id: e2a8ca60-c456-4402-cfd7-08deeba60191
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 EUqzeuFPsL5sAykamfmXlJ8FHO66e+G6ddGuXrloymeQpoE7IkPAf/HzzgC+/Ae4exNpKQZrp19aAIaLHoXe1xFfRrnS31Zig7VT9putZHwD8RlUT8x2hgi2IZGAptNUfuNLp2i4HOdrd0y5h49F972cZJfNjZSvKsCVXdYmmdbywc1tjQ5lTFR0gv6jvMYZqM0VmxniLL0pgpH3j52bY+xg7wVpcmQjUN9yXi0dTpDuc4KnNNZXvhwVRS4Ynm1K/RVAy6vEeu6bTPB/ExTQMDSMzK4uq8oKWXQgBhqM5GgVkGtJzuaMW9SoCBcsq0cRswKGDqNKXf3DEqQpExANxuoCwHF5p1jNiPsTK3VMwSAXiP/lFKU6bbNOn8To0Ep9mxxyHa48/ykcgfQSTg9oqyPkysmbpggG/U1EzkpYAPWnJGxE6C6Gd84wlanvQgOOJG7pss5K4f7C6GK/gA8mgCKZFaBFY0cJkkrkQsHTM5SgYklzKHNK4Z2aPF88UgtkYnYiphNATBBeUqQBatk6EoQwvkudycg/gz3Yh/ShboHb+ztDup8m38iCURlg1p5FPbPTw7d6X2+jbdLgtterbIs/hXX4MtWTpGz3FmTaXWJK4GiJ3tR4SYFjOD440kGf10rj+dJpJDEYxRJ4sriQDDFHOQldjA22blz52V7z/li1BVnNceak2sOIvVF5zb0f1boaN3lIMN2Ub6EN4fMFWsdpTg4qWCziAhoUsj3cGA8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8570.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iAjwwkrQYwgvf44EdOJxz034n1ngkIB96saWGP7uLLgK8bVvpyVxBEuitZVz?=
 =?us-ascii?Q?TSpWfjKCaXsfaqWw8fqAzm5QM53T3R6mc+jzO5Dzi6xh71mfhK9yahJjrQXY?=
 =?us-ascii?Q?mpkZjwwTNDqjbInFZUgHykgN26f06G+ZlIVVqi2NjHKoEgAZZKDcStOUaF2I?=
 =?us-ascii?Q?kQMPar3/x9K1XCRgUL5G3elCT1+FdTq2cCKID2R0opqcvrWl/H5X4yHzqyqZ?=
 =?us-ascii?Q?X5jy7dT/Z6XxKWYQwsbR9Bfm5AFjH0sUJGa7/pt9wEY8pbpvpxRPmm8ZU5an?=
 =?us-ascii?Q?8xv0JZeC1p9xz9bUtol/hrtg9J8XQxSoscIEZ8uj6W9oN3Ys4OovekocvpbV?=
 =?us-ascii?Q?KAklDAYhRnBt2rR4CRQRM/GDEpKwsB0xzz2Cyug5lxvqKbKxr+rOQ5aWViX8?=
 =?us-ascii?Q?asLbQcI3M6gAVpxOjRPRA6e1QrHwMPtCb/ki9DPSaijnArqW+ATJ5z4CT65x?=
 =?us-ascii?Q?xU9i1kpsh43+omxoCKGzttzVJjzmMdau95sgv//+ePriecjbl5eVl9wJeZ6M?=
 =?us-ascii?Q?thUs+Jpk0PJmpWX+gTByR8/QrDSMkO2dz/zjGyaX6NOAiPKvv9LuHSWdmydk?=
 =?us-ascii?Q?SF10QK9xURbRzM6ImMX737Ur8koxYjsWOVnfsgy32PcZEyB+LazyM+Bw9tWj?=
 =?us-ascii?Q?tqntU6HE2TdDGmPMHIJ8OERD5LKWz8sMpsLO9+zKiWbbtaxF1iJPhFUSm/8n?=
 =?us-ascii?Q?HWi14WjAwi3bcgDRi37SuSTd4MlMRJXqL1oCIroOqhJnm3hXe/FUsGH6RQzR?=
 =?us-ascii?Q?qEkK/lc3u0savWzcNAu3sYZQfL2pvj3s2xlJBaxOxl2D9r8gzzazo0V5NxiN?=
 =?us-ascii?Q?n5BTEYyRuLGq5ca5LudQ7e1EA8VZDmoj+GbPLHcdJJDVbUUGNBsDE0YEazBJ?=
 =?us-ascii?Q?JlsWb2Qxsr2pqFUyEFQcz+9dxcA72NXUaPDldzx4iHTpSr7pIiUTXBtQ2jU6?=
 =?us-ascii?Q?Brh9g0R/a2Zndw7u1DprUJKjMkoYSnNOhfpkU4wJCwzmJUKoPEz3hN2Bm0od?=
 =?us-ascii?Q?Bs4V4evFhoYADK2OrNBB07xA+ItfX/N1TzHxlgF/FnEJnFCy06p+se9L62/G?=
 =?us-ascii?Q?37Gqh8UFWi7MAsAex1rnyyginr/kQruv7bh9UGPAeAgOQTpUW4gyW5v3SS//?=
 =?us-ascii?Q?PvGQ322gfB3VjaI3Np9JHcyTO+GMz8/NMrNS2p+02QkX+kGwDXwk06SHU8e7?=
 =?us-ascii?Q?0tkBiExJFC9lj3RTyyF6iRasaHSHraH1KD+E+asJp0hH4sXKlr3AT0oxyLov?=
 =?us-ascii?Q?BNfadyQUTiuxBl3frX3DyhGHZSD5ZoECL6Z1HFLSg0gcKM+/ENXnSZ2UMilb?=
 =?us-ascii?Q?UMUQ+HbtXrSSJN1QFmhZvMCs7e+QTDkoHfhXbXuGyfsX8xZfha9VP8X1i293?=
 =?us-ascii?Q?g1Uwp8MExYo2shbddXh9a5+hovoxbee+ERE5MvSnm6/tFkXMNWw8X2wjQ4GZ?=
 =?us-ascii?Q?dWv6dp1Q23QLAyVdn4IIIJ/UvdTEGyrpT+/1XeQteX+xx/ZpCXMcLtJ6El1j?=
 =?us-ascii?Q?q/rsnIcvWhhEqGgvtVh4tpyQ9U/rnS/cp5s4UuxCXI0MMte1qdoY9m2O4MA3?=
 =?us-ascii?Q?Ofn+9dWrplpkhFbaPq3c5Zx1GSxgGq4mlG9V0EQxbnjGGSP4qsPfPncxWJ0o?=
 =?us-ascii?Q?Xde9WMLxAuCj3ORpr9eXzGlQqsGDUkJhuOCP4QlpPAuDOAQqjnh8K59q0g33?=
 =?us-ascii?Q?9khaL1dakdBGe0f2+MIGUp04k0kOcLufatC4eFZ1JuKU8AZH?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8570.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a8ca60-c456-4402-cfd7-08deeba60191
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 06:12:15.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNa+1JOHZoqqpsIc0ZF+IOePSKJSNvWqU69vZOJ26txr5E2HEjTLmixVXP2WUda8gL8kuz4QnTSW3I1v4dwEgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980



>-----Original Message-----
>From: Fan Wu <fanwu01@zju.edu.cn>
>Sent: Wednesday, June 24, 2026 8:32 AM
>To: Mirela Rabulea <mirela.rabulea@nxp.com>; mchehab@kernel.org
>Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>festevam@gmail.com; imx@lists.linux.dev; linux-media@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>stable@vger.kernel.org; Fan Wu <fanwu01@zju.edu.cn>
>Subject: [EXT] [PATCH] media: imx-jpeg: finish the job on device_run() err=
or
>paths
>
>[You don't often get email from fanwu01@zju.edu.cn. Learn why this is
>important at https://aka.ms/LearnAboutSenderIdentification ]
>
>Caution: This is an external email. Please take care when clicking links o=
r
>opening attachments. When in doubt, report the message using the 'Report
>this email' button
>
>
>mxc_jpeg_device_run() returns early through a shared "end" label on severa=
l
>error paths (no free slot, mxc_jpeg_alloc_slot_data() failure, or missing =
buffers
>or queue data), and none of them calls v4l2_m2m_job_finish().
>Since the delayed work is queued only after the hardware is started, those
>paths neither finish the job directly nor queue timeout work that could fi=
nish it
>later. The job is left with TRANS_RUNNING set, so the
>wait_event() in v4l2_m2m_cancel_job() (reached from
>v4l2_m2m_ctx_release() at close) waits indefinitely and the close hangs.
>
>mxc_jpeg_alloc_slot_data() uses dma_alloc_coherent(), so the failure path =
is
>reachable under memory pressure.
>
>Return the src/dst buffers with VB2_BUF_STATE_ERROR and call
>v4l2_m2m_job_finish() on those paths: paths that have buffers use a
>"buf_finish" label; the no-buffer path uses "job_finish" directly. This mi=
rrors
>the existing jpeg_parse_error path.
>
>This bug was found by static analysis.
>
>Fixes: 2db16c6ed72c ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG
>Encoder/Decoder")
>Cc: stable@vger.kernel.org
>Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>

>---
> .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 21 +++++++++++++------
> 1 file changed, 15 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>index 9e4a813489c0..6b224a19f40e 100644
>--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>@@ -1525,15 +1525,15 @@ static void mxc_jpeg_device_run(void *priv)
>        dst_buf =3D v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
>        if (!src_buf || !dst_buf) {
>                dev_err(dev, "Null src or dst buf\n");
>-               goto end;
>+               goto job_finish;
>        }
>
>        q_data_cap =3D mxc_jpeg_get_q_data(ctx,
>V4L2_BUF_TYPE_VIDEO_CAPTURE);
>        if (!q_data_cap)
>-               goto end;
>+               goto buf_finish;
>        q_data_out =3D mxc_jpeg_get_q_data(ctx,
>V4L2_BUF_TYPE_VIDEO_OUTPUT);
>        if (!q_data_out)
>-               goto end;
>+               goto buf_finish;
>        src_buf->sequence =3D q_data_out->sequence++;
>        dst_buf->sequence =3D q_data_cap->sequence++;
>
>@@ -1571,11 +1571,11 @@ static void mxc_jpeg_device_run(void *priv)
>        ctx->slot =3D mxc_get_free_slot(&jpeg->slot_data);
>        if (ctx->slot < 0) {
>                dev_err(dev, "No more free slots\n");
>-               goto end;
>+               goto buf_finish;
>        }
>        if (!mxc_jpeg_alloc_slot_data(jpeg)) {
>                dev_err(dev, "Cannot allocate slot data\n");
>-               goto end;
>+               goto buf_finish;
>        }
>
>        mxc_jpeg_enable_slot(reg, ctx->slot); @@ -1597,8 +1597,17 @@ stati=
c
>void mxc_jpeg_device_run(void *priv)
>                mxc_jpeg_dec_mode_go(dev, reg);
>        }
>        schedule_delayed_work(&ctx->task_timer, msecs_to_jiffies(hw_timeou=
t));
>-end:
>+
>        spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
>+       return;
>+buf_finish:
>+       v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
>+       v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
>+       v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
>+       v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
>+job_finish:
>+       spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
>+       v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> }
>
> static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
>--
>2.34.1
>

