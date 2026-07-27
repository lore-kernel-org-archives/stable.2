Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DF221F0C;
	Mon, 27 Jul 2026 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131980; cv=fail; b=ZAyOFX/8WZ/9Gc322Rn9GdvIyMmjTrvJqqQQEyuWWoVy0XqJDZf8YKjzy+wVK3qT0duGja/CTb63IfcTMhrxKKarUhAjfh4WSUjsM/wQvBj/7R0eNnKy9ZLxVGpTAwqaZLvcmc8L8l/JP2o+ltPPBNLD6wWMGSCfQ0LcMq3Aeng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131980; c=relaxed/simple;
	bh=63waxR9tvbXflbHHz6JVP49ydhrttvemaYn/LFQgls0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJAF9iQGyIXdJeeP7aTAaArxDl/PRz1EJ36Ew/7BFBO/NeZtpyywJrKjHG/g2ZBhPZVyX8QyqqD9Eon8jIad+T9/vXGz8DjoDpJRhi/7V/NLgUQds9fVVlrOcfwf0NLWCN1vRS42++j3gMkW4oACUlSxuHqRFPSxbZ5e/LVuD3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YtJZIuT4; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YtJZIuT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcv+5GWxiSA8oTwyd+n2nrQ+VtX7+j1YEFMf2dKJs8dwKAuxHFYSLijeTrjtq2Y06GDbAgKKaX50I6dGoynSLXwmshG6FaVFjTMCj91n8wbZyy3Q+GjIaYfvC28Bw5wRCpvjVcM1jLz63cykrvsN19yIi1vcZjrIaG1hio7OXSMipB/3W+bMxhNLSBl4vWFdcbLI5CNOcfJXY5MnRVFyhO0C5HtHjpbzmzldSdJfFmro26jNDjMWOIfGUwycqwIY4JgMd6qXRhXFqXFLQR8+j4FpMFVUU2T4EnR216zlos1Zw2EivPAPyrQ6KCB3YfS9Fy0rukpQUjSeYrE4cM/wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoZXYp+JA47fX37Dwu7X2/DyJitVNezjqQuaMrerkDc=;
 b=C/UhlXLTZO6KHqX8rJI9t81eWzMLsXiTOTNo85LdZT2Hm+8qFXmKmeOBpkhbmfwbwQ0pJeItjuesVnQb/+4bt/zwI2bpBbCxLMGlSaPYhwUlsqwSWbxKOVoxepyLAj5Zh9Dm67YXG35TT62+6hTzA7hZPqEk36A5ygMq1yuW11Tb5Nj4aMhO9QyT4pyGaj6e56Jktdioz2C3wVk3X5Ex7ndzB/P3idW7xys/b282VsLh9AN/liH4dX0KNc7yX40xr5J0GIuGQqSdvahLcqysqeo8ViVT/bZea65E04n/sMryT38Zg6B51y0OI8ZhxufEG0w8n4QXIRSbIM8L6bEW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoZXYp+JA47fX37Dwu7X2/DyJitVNezjqQuaMrerkDc=;
 b=YtJZIuT4EHeh6mmDhBXpc83dljT7CsmGPTO+HcuHym/KQpHw1OANhwibLlVewNnRPuexkCBIqA/DUV/mYrkmvPCWLiqA1MegJzgHkmaYoSJCAvHbmFxu3FCeY+PVT3aqK5WCuosKz6NnB5Atwu2i7ato6mJUPd/IPVdQeNPD6EqGyEFZTZLkNFn+v9dp+fVSOZHFSIDO5kpxW0mY32G46kSsf6JX0MgbnnproXqzrne3dmd12fpBl9Tz/u/TrVZTL7Grx9rQ/xjyKwnTlyNPtUMg6YKh7A4SoXJvbs81Wa1QRFAC/dHSKuJNlhQonUiNuI8wza0UIDNS1MWp0jPZaQ==
Received: from AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12)
 by DB8PR04MB7099.eurprd04.prod.outlook.com (2603:10a6:10:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Mon, 27 Jul
 2026 05:59:35 +0000
Received: from AM9PR04MB8570.eurprd04.prod.outlook.com
 ([fe80::c9cc:24fa:6f6d:fb03]) by AM9PR04MB8570.eurprd04.prod.outlook.com
 ([fe80::c9cc:24fa:6f6d:fb03%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:59:35 +0000
From: Ming Qian <ming.qian@nxp.com>
To: Fan Wu <fanwu01@zju.edu.cn>, Mirela Rabulea <mirela.rabulea@nxp.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXT] [PATCH] media: imx-jpeg: cancel timeout worker when
 streaming stops
Thread-Topic: [EXT] [PATCH] media: imx-jpeg: cancel timeout worker when
 streaming stops
Thread-Index: AQHdAvuAx5vWS9eFlUazwMWcxSq8PLaBE8aQ
Date: Mon, 27 Jul 2026 05:59:35 +0000
Message-ID:
 <AM9PR04MB8570B0F336F244FF5F96253CE7CC2@AM9PR04MB8570.eurprd04.prod.outlook.com>
References: <20260623103031.3051-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260623103031.3051-1-fanwu01@zju.edu.cn>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8570:EE_|DB8PR04MB7099:EE_
x-ms-office365-filtering-correlation-id: eea42fa6-de41-4d09-2416-08deeba43c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|7416014|366016|56012099006|38070700021|10067099003|18002099003|22082099003|5023799004|11063799006|3023799007;
x-microsoft-antispam-message-info:
 jX5WY/cdJKoVxS4erQR8A3S4X1sV9usH6zRvgTbUp9NNsNpEDfLLZULJWTnmpPPyj3o2Qd2hWUytf45Pd4VDaFAf2aN6UAW4My6naD/R58DuA/cGYNH1KUyq8sSJiYTgmXqCsTr8lP7AR3Ldx+lIo1VVwmPEUhJmNJd7IE7ftu7Amg0CqYuEzaEQvw+aBypnK5MveD3+U/SX+R2BQ9uwus5UfIPjpj3Zaa4m71peiBrZMmgEG1g2IKRizqF5MTB+P+V8vJMMeKVHG05xLIieklfcm38im8raX4sN6WDS747/pHqoVoXuUjbdmHIksi8PJHgvfOQTcwhuRy1Aw8vdJP/LUkbB2Cuy4OBTNXsWzZDdjsX/DJhTCG7txCWtoTUenDIJSw/hkA9J9J+sQS+dVVdwypYxV5FVyE4y7lMNZIV8Ah1SIo7BpC5+IU7apaEIRA7IwDHFkMeyUfMHrQ8UYv1le32DKkTnU5R4GeIlqsAFIlOF9l//ANR0ubToqxBpkLyJ5Fpg2EFXKv5fjQClcY6tsBHrEAgyboywcPyIj9TrVPeZeDz2zn+PUqb/DAodLawG27zvMP1eYBOLIuAyYi0rjUjfl1ZO2v22upjRV6CefCyk1uS58F9+kCpdqpzEa+LjRmLtWRElDPyatF5mA4yX2s00XRunxS5Kg/2PkYJS6F0HIaZ39icJPZMBHC9Ynd5pCVVxC1j6oJhaskavbtMLMXZBgaWGxABn3dHNMOU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8570.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(7416014)(366016)(56012099006)(38070700021)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mP9ki23FjUxd5YeuX3s8FYoL+Ttclvczd7T3OYBGzSemVIqgnbg1XVXOxJ0y?=
 =?us-ascii?Q?SfgaCcibGL/ynYFwrCxeQobEh/aEat0lY1bmeQo9cKvkaoCZMKhckheHsqNO?=
 =?us-ascii?Q?9/DoNVuP6ogkthucDsHZ0yIfFQIjojEQhqV/UzNLRZfH8mMomYHaTB5oHelB?=
 =?us-ascii?Q?AJ6pj/ULMSfZ2599c0Rwyna6kGAgmEKXAPIGNCwBK5upImQLU2NrMkhQoB2u?=
 =?us-ascii?Q?7XXUavj78h8clUsA24LtsYWFq/GBxJhpaoVOHMTj/YBeKwo+zz3J0ikDGLBr?=
 =?us-ascii?Q?0lTGJBcBpb2VpNpDgtv052t0cVRd6gV9U7jUKc+7KT0C05sedprzv6Pzr8m+?=
 =?us-ascii?Q?Rq8qyTVtTBDDRsY0O+IOkIGxAjKqb/OfLt38xDw5Wt9orMBkHiu8AVakJt+C?=
 =?us-ascii?Q?uscrg+xUAQ7t3Blr5ILMf5iJUDtyz8DNdNAm8Wd85/zW6l1W4qFqDdDn4BcZ?=
 =?us-ascii?Q?6nEvW/CkKbl893jhqQbkEcCBbYelqtwoXe6+nE7/uHQxB/0CFPqprM+oMSew?=
 =?us-ascii?Q?khGYdUt7vJDx/W4jy0LHRCQ3ly/Hx5jBuF+MR/GmvVlwd5CKMl/1S7L2DzYL?=
 =?us-ascii?Q?bgQj89IwX39xjEui3HUIPb/zvE25jr2ue1K2NjETngQCxWd+P5RLcS1DHixU?=
 =?us-ascii?Q?fchViRuiuFa/mPItF62ffat/YAcqyRTz0sYgpi68vk/JT7t4GiQZUt/sy1gT?=
 =?us-ascii?Q?rKn9WGAPzKxLAunMHmhSmNlX2H2KrVyBnqD/MHNcaIzIvYghz3EPC85HpbGL?=
 =?us-ascii?Q?M8uY1dlcivMEZB+u0bXIvJj81xVdCv5sxZd/aPPUBM/CkEQvqSSz+05Z0ryv?=
 =?us-ascii?Q?5QHBUXzLlT0Gt3c0yACZxkPcOJFPZH+dX6v/I6lKtxd8xFYY4iL/kQdOrslE?=
 =?us-ascii?Q?hxgvAiUTHjxiFjAU86Jhifim6wrFP5vP7jzgJVS9Up48PyqW4uNq6Edv6o78?=
 =?us-ascii?Q?hKDWrpZz/DBDZZRzjAvi1h7OIzVunSlcsBuLKx0AQHw48HBYrpUn/JqySWxA?=
 =?us-ascii?Q?f1TBIiEcIefsb/ZghmW0gEKOCPg2DiVkdCzGlhRlfc+Rc979Ze+MNspuekB7?=
 =?us-ascii?Q?LXSZ2T6mVm17lYNu71NKQueKuQtBwDmqEGo3FgcR8kGnuLmxtO5+oOMuUoFM?=
 =?us-ascii?Q?oskfD5LAX6zTfVjgMy32ej+pwGVU4sS1kA155AhSJ+/b80oDuKTBYMw1/8cG?=
 =?us-ascii?Q?5NW+Fxn+p3KJQFPI9UMMOlH3/F/BLpZvCQY5Ry7tfZEG1MExZmx+ymZHhkaY?=
 =?us-ascii?Q?+8vKdYNd/R1on8HT9mLjX4F1MkGLPp8Uqdu8uh9Zm+o3Xsc5XFJKS0Fi4Bza?=
 =?us-ascii?Q?pLVn1CNsfQKOiFULQYyU8sWTQWLdOiNWNwJ3XjDPYSl2DoL94ndeowCDJXiC?=
 =?us-ascii?Q?CGlcC5/NTwcJcOCwWQcjF6v+NqM/7t5uLqQReN3nA2aKELrcOswoamYB65Z9?=
 =?us-ascii?Q?rz9h/yfTz9FHo6dsSY8M9PVQ0iXSl6Ju+6s34SRtuSz/dEUMUmL5FzGWXHe/?=
 =?us-ascii?Q?seo9i9FLb/Ukd2BJJWKdTBIykD9V7zoPjwO874SxMvXEkGNLJc4Qmumi1JrC?=
 =?us-ascii?Q?NSXWBHJZC6fXY1jQWkv4yOaJrO1Cx/Nj9CBdoO8woxyAqRvT62j3jxLwMVQR?=
 =?us-ascii?Q?Ia0yXe59ap/9ZDTNmrRn/4RugsnlcGI/AFCTKmRztIO93Lv+6qyADjoBxPVk?=
 =?us-ascii?Q?luGWgQjA9/hXbH2iXd1chLf10Fp2hnyfreSHE6x+5epnlrxu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eea42fa6-de41-4d09-2416-08deeba43c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 05:59:35.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whor/pBnoVMUL1kzceui2+zeIw8QSXHXgmRuhJN5Wng5jwd1mQxBnvAXXWSgIeFJ4QLUuftHgBe/4HDUa+ZsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7099



>-----Original Message-----
>From: Fan Wu <fanwu01@zju.edu.cn>
>Sent: Tuesday, June 23, 2026 6:31 PM
>To: Mirela Rabulea <mirela.rabulea@nxp.com>; mchehab@kernel.org
>Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>festevam@gmail.com; imx@lists.linux.dev; linux-media@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>stable@vger.kernel.org; Fan Wu <fanwu01@zju.edu.cn>
>Subject: [EXT] [PATCH] media: imx-jpeg: cancel timeout worker when streami=
ng
>stops
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
>Each per-fd context ctx owns a delayed_work (ctx->task_timer, callback
>mxc_jpeg_device_run_timeout) armed via schedule_delayed_work() at the
>end of mxc_jpeg_device_run() to recover a stalled encode/decode job. The
>only existing cancellation is cancel_delayed_work() in the frame-done IRQ
>handler, which de-queues a pending work item but does not wait for a callb=
ack
>that has already started, and it only runs when a frame completes.
>
>When the fd is closed while a job is in flight (the frame-done IRQ has not=
 fired
>yet), nothing syncs the worker before mxc_jpeg_release() frees ctx with kf=
ree()
>after v4l2_m2m_ctx_release(). A queued or executing
>mxc_jpeg_device_run_timeout() can then recover ctx through
>container_of(&ctx->task_timer) and dereference it (ctx->mxc_jpeg, slot_dat=
a,
>dev_warn) after ctx has been freed.
>
>Cancel the worker from mxc_jpeg_stop_streaming(). The cancel cannot live i=
n
>mxc_jpeg_release(): mxc_jpeg_device_run() arms the timer while holding onl=
y
>hw_lock, not the mxc_jpeg->lock mutex that release holds, so a cancel in
>release could still race a concurrent mxc_jpeg_device_run() that re-arms t=
he
>timer afterwards. mxc_jpeg_stop_streaming() instead runs inside
>v4l2_m2m_ctx_release() -> vb2_queue_release(), i.e. after
>v4l2_m2m_cancel_job() has set TRANS_ABORT and waited for any in-flight job
>to finish (so __v4l2_m2m_try_queue() will not queue and
>v4l2_m2m_try_run() will not run any further job for this context, which
>prevents
>mxc_jpeg_device_run() from re-arming the timer) and before the m2m context
>is freed. cancel_delayed_work_sync() removes a pending work item and waits
>for a running callback, so the worker can no longer race with the subseque=
nt
>kfree(). The cancel is placed before the buffer-release loop so a concurre=
ntly
>running timeout callback cannot race with it over the same buffers. If the
>frame-done IRQ canceled a still-pending timer, this cancel is a no-op; if =
the
>timeout callback has already started, it waits for the callback to finish.=
 The
>same mxc_jpeg_stop_streaming() call is also reached from
>VIDIOC_STREAMOFF, which drains the worker early, although STREAMOFF
>itself does not free ctx -- the use-after-free arises only when the fd is =
later
>closed.
>
>This bug was found by static analysis.
>
>Fixes: cfed9632ca8e ("media: imx-jpeg: Add a timeout mechanism for each
>frame")
>Cc: stable@vger.kernel.org
>Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>

>---
> drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>index 9e4a813489c0..d85a9d196269 100644
>--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>@@ -1735,6 +1735,8 @@ static void mxc_jpeg_stop_streaming(struct
>vb2_queue *q)
>
>        dev_dbg(ctx->mxc_jpeg->dev, "Stop streaming ctx=3D%p", ctx);
>
>+       cancel_delayed_work_sync(&ctx->task_timer);
>+
>        /* Release all active buffers */
>        for (;;) {
>                if (V4L2_TYPE_IS_OUTPUT(q->type))
>--
>2.34.1
>

