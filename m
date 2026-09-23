Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019F386443;
	Wed, 23 Sep 2026 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156663; cv=fail; b=FaAXzaxzDaDn7lWvnVTKl+zINPvcTcVsRA8jJaIcK/sUeP+YmnUBHRqGEKf8F4GlBKz9LVfFnlC7H0nq/x6xk5NRVkKGJjG4vS0L5aNmIWHaVtR/tquIQSWnynHsB0N+B8JDJUtin0uUl+ZHwtDDziKxpAnyBOl18DkBtsVia3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156663; c=relaxed/simple;
	bh=iDoih5O/sDOLr4HjGDnBmhaM89ouN/x4O3Sh4NO1rzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZXGh2eWKVifGkB/9w2l5kPvEB2TO7nTdt5J91f+8nLed8N6kAYgBR9BlYTgorw4aak+gmGR4/ikjotB557CyOLafitaEm/s8PakwGE8GgzfeKTyd/UIPDUJVBFSdWpZTGR94yD9wAKuTTTzsoxYZLabn34zRyoP+AhtC3Z4cMak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jxglQVm/; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jxglQVm/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0/yiTQkKnxyeKTo5P4zQx2Lajpsi88zDsU7VJfvzEDKITlCqWP/6SgNJxJaFoSyFLHRuSDxwYIhD7bICpk+I4bhNX1DGL+lRRFRybU2lVyUm4U8gqzrdrnkTLoJotrlmsn49qPt7/Mn+QpSQPGcrnSIxHtjs/PYymGu+P0foOJKQrnnzAPhISbi0L6A8XDv9GvJnzsiCimX/UC0SUuhpyRhqiwdLNdbO75uPq/W6buw+ugFdZeeMeY1/LT/bm9tAtnoUG6Tsgo+ZysGwJKpJHh6UBA0iWr6i9FlvEFzi3ZgntsiBbpbDft7w0zITJRy6m4uaaAQlohaLmXxwW7QVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8x/gPxDNTcA5keJMihtiS4o8vLC2DFNl4AZGUpHfGw=;
 b=d8U6NJSM+dhlmvje8nvl6iahjC9cSk5ZfTOToC75Vcd7ablx+gRrLvgxY3fwd791LaS9xmAK6KWaXh7tIHJYWjcsLVQSutLpDyw2DDuSy0lMxQrdUF/rlspUnWKMVC+MsGh8EtILcJYJMt3FXe706fFYXOcTfbtGnuWGzrSYhyhzFQHdkfjeWL2CeCQfcNXS5EaQtY9DwgyEpwbEUdg9hcxJpi2WzFa4dASNOoLpJbZBayr7Ks2zQvUyLpsfKdouy9K8UEA3Hdgp+gQnz3SpM91ogxdREhnCfsiPHVejpHsFyh5YiRzLQdBgP7jUacHkUUjYVHMMSc9I3s/t2+v5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8x/gPxDNTcA5keJMihtiS4o8vLC2DFNl4AZGUpHfGw=;
 b=jxglQVm/FYX9iMitb+gSiKxWenU5BSz5FjG1rg21rETQDpWlJj5s4o6FUb5mD+pGReKJNt43lk/9bv8Inj/ZDOjFYeqUlof/ewcjd6SfyYmc2fTTF8mCrQfnd+BBxCurWRTIaHBbU/eMyDbSl0nQg4yBjPhCHOSwrhu+uRnH+JmGKZt0GdvOE+hZiUfQdekw3JGDbKsDGumE7oY2xet+8rL7O7VCLFP9LSyzNdsaLEKAOq7RUdomKCbDaQlvOy2WfbNU6krdNXBx7ODdM1pJlTz1Wp+gqQmPlwF/la0pMxz1m+d3Ux2FvyyUWXoz4WoFOvVebdWDQq1HkBOKTJUY0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
 by BR0PR04MB649822.eurprd04.prod.outlook.com (2603:10a6:2c8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:44:16 +0000
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c]) by DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:44:16 +0000
Date: Wed, 23 Sep 2026 18:44:07 +0900
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] media: amphion: Stop mailbox RX before freeing the
 message buffer
Message-ID: <arOb_IrqoVq9FAw3@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
References: <20260923051950.89403-1-mhun512@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923051950.89403-1-mhun512@gmail.com>
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DB7PR04MB4698.eurprd04.prod.outlook.com
 (2603:10a6:10:1c::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4698:EE_|BR0PR04MB649822:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b6a5a4-7d97-455f-6c9a-08df19573b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d1Rz/tseVzwSvhrrJMJW6DKKk/EL/Mldona43ihPZ2l5oNqs/aCTjcCLog7L17mCahPmEKSShl6lyWTFpq1KlzWt33AEU1Xt+Vsf4dzYK7XqvwDFeAQtgh7d/0leDU2A/ILNGkWWYZXn7wZWDr1P32IgtJxWsdXFr29UgshoQtqNDfoc8EZmtMnanyvRwLDYM4YQgWd0bmgF8z9VFCgbr8uS2e14bMVTv7+42Oy+IlYOK35Bn4TtIVHtrSubWUulJ0dOvOm2cxyUODaMzqBProKHc8w2DpW1HEOoVUTCZ9a68qWFDVteoXMRRwwQzI8PPQId+me6S8lB434Y6ElNbZAoRX3T4CWA76IVpPpLZs8yZcE9cuyFN1c1hdB75qo+o+W5TbLEmbzPmy15wCBcxbKF2NlWzHe1LZ6LOSsYwpxxs3KEddHGR658h7g49atTV7uubSPIi1RRjW7L+GRkF3DXlvo9O7XGNx7+Y39ypOfVuteG9DkQ+ZmLN8fsLyNDsuuCiWpK/N1tg2vyuLnYW2qZ/rivzjKVIQjU6f/m+/gRhHcJCFr/pF1m+J7mqsERlKy+yfDLcVRSIbLvKUmoM5VQiTQtSvLsMAbTIDF6zKAvPxVD+6sa88B/Xq1KAaL2J7AypKTT8wkmrp7ir6UHXnKcieUxNEDG14t7qLiTtfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4698.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/JEANT5yJPkekobKRg+We6bqlO6jnQ1b77NzwYNo/l9WZQiBDa27z87H9lO+?=
 =?us-ascii?Q?nu+XZMdbieQtc0ifTU5M9HUJU66pHZhN/LufQ/sTxJWs8OzZXJIBbUVoYG/L?=
 =?us-ascii?Q?qEdO+gxOjJPu0QuMPrkNVrj6RZp/9XkXWTcYux89iY4yIQOl5y9X7jfweSpn?=
 =?us-ascii?Q?SeLUxyh37kFJDlnVVF/s5N2s/d4LZTAeFQATJzcAAIPG1KD4Jld+c++CoRw+?=
 =?us-ascii?Q?G1PcVloLEdXuB8rQxE+EhS4TmOKmGl/15PP6lhMu0HaSK0qyiPpvXr1fZX2r?=
 =?us-ascii?Q?y6LE05Mwd7jKUX6zWPygZ/ksF2FGd7Pj0iY+O9yUveXq2mWYpN8/HPBu3M1A?=
 =?us-ascii?Q?/3rPnkUyKs31c9x0lVFPGXtKV2mWXq0CvNiUXq4enM072jVf44ayNpTtL0Mr?=
 =?us-ascii?Q?KkgpUjgh31NgQFoA2Ryi/pJp7uVjlF6ZkDeMUHutHgCAxyRP31Qoz6sJVlqr?=
 =?us-ascii?Q?5pGX6pN6hgVwDCuHLW/Sd7Keyp7eKfz+bOAljI/X1XVncEbqYYBpqbPLSS7Z?=
 =?us-ascii?Q?uzQ7sX8QsUmKu+U+C1fEMltnryhR3ZwHZdyYjz6NdDh0O0X+5qcvlC74ek8o?=
 =?us-ascii?Q?j+z0eYoNrD43ricAdOh25hYhZDgbTiWlV5wv5PY+vSxS/Z5yVH98q9US51Lz?=
 =?us-ascii?Q?Fm7E5d96xD9gbTHLQfxOnVWsdn/nJwhLyylFgTQuGFcjurywiXDqmXoZxUlO?=
 =?us-ascii?Q?CrEsaYDTSBHDzyci3FJFsdEBTyBwarega8w7RUNWaolh76T54v0/DbBNiEGs?=
 =?us-ascii?Q?D8Cc3ZveLqPAZWxVeeq20yttKKFKUe6jxfHRMqUuF+hZUZCAS1Tk0xSjQFIp?=
 =?us-ascii?Q?iB2b1/An3F9sK0eN/ZI4ubqPKHjbQ3j/ig0yVEXMrkF8Ih+RG8mDvVz9CYHt?=
 =?us-ascii?Q?7WEse20YJNhB3V36ptoKVnh/A/6uGLyn34D5/TF/i6tgE/GvSUkAnGzsNdio?=
 =?us-ascii?Q?6blOpihCNp+LQ2nH9qKAH+scedfUlkeSxBlmxcZ4KYrcvdBEuj+B2ijREilq?=
 =?us-ascii?Q?wYTNa5177nioJJVIonRgFa2bc+XMl2hhmwHiFjSSQS1Qum3RqJxsV3/5b0yU?=
 =?us-ascii?Q?2j/eTDY/Nvt0BWM8Y8kirVwR8bPu37plbCHuTj80CVZULdLcyGbMZR+Gd+nz?=
 =?us-ascii?Q?2PJ0aJo+zNwhXLbyvZZgiZ/7Obcs8ueg0712BmECxEtzam9M69a9RQm56w0d?=
 =?us-ascii?Q?8iEVCjt1NgMTk33I+YHuHIAtXwyjOEwVQOCigg/ah7z9kuch2C7WeYVoUiG0?=
 =?us-ascii?Q?GQ58jLcPhMAe0yjnoZfgFt/4aK4/fjI/wjHRpzTuK3S5g6bnX4AnGKTegvkt?=
 =?us-ascii?Q?YD+4rJ9c+/TuOAptCLdPlZLNFwA5MHdHRV/kSvq5UNUlQ5J7lfeA9rarkB34?=
 =?us-ascii?Q?hV0hTqK67vu7WVlOeloFHPaBgMlzRlXvbV6ZCX0rT2HxJPLwFRYZmTU3UncK?=
 =?us-ascii?Q?JjpPP6c6TUdp/OMp5qwbYi2FZz+VMRxlWcKwKVbRfsk9kBh+raya3b3J7vqL?=
 =?us-ascii?Q?7HO1/TEtSErbXkUFJX2NNEzI+pq2O1zOWQANC8coksoF0Z50ai8y2y3Zf4lM?=
 =?us-ascii?Q?OnbymW9lRSQSHkTPj7o+nuiHUihQyTgp7+0QnAOs9RJolUzpEmCKcdmAvxo0?=
 =?us-ascii?Q?dk61QvHhXWtrA9/g9VoNb4EihvjUwmiLVZvafs45pfIolps9lQ+KsGyFcDhY?=
 =?us-ascii?Q?l8+T3bYpwaitOvY9eYKfT64APgbxTED89t7euzASi1TvT9GlcLX4ErGtl4Vc?=
 =?us-ascii?Q?tzk9G0aPxPNFf2/vfZ1ymvmfc9jLHwbmhCl5ZaQxaWth7uxVAJ0V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b6a5a4-7d97-455f-6c9a-08df19573b87
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4698.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:44:16.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK2Tzjkf7n8H/8920plvkOBbiXO6w5A8WsIZmJZBOLRhDpuJnX4Wqks679nZkSFT0aUzsnA0IwdWkfYzG4I9Hgiv69InPEVu3K0Ws5XvidazWLjscM7jv+ZXh1eoyrHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB649822

Hi Myeonghun, Ijae,

Thanks for the patch.

On Wed, Sep 23, 2026 at 01:19:50AM -0400, Myeonghun Pak wrote:
> vpu_core_unregister() frees core->msg_buffer and clears core->vpu
> before cancelling the message workers.  The fifo keeps its own pointer
> to that buffer.  The core workers read it and queue inst->msg_work,
> which uses core->vpu and may send on TX.
> 
> vpu_isr() fills the fifo from the mailbox RX callback.  i.MX MU
> free_irq() waits for that callback, not for the queued work.  An open
> instance holds a runtime-PM reference, so remove can skip runtime
> suspend and leave RX active.
> 
> Stop RX, then drain the core workers and the instance workers they
> queued with vpu_core_cancel_work(), while core->vpu and TX are still
> valid.  Free the buffer and clear core->vpu after that drain.  Drop
> the runtime reference only then: runtime suspend frees every channel.
> 
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/media/platform/amphion/vpu_core.c | 28 +++++++++++++++++++---------
>  drivers/media/platform/amphion/vpu_mbox.c |  9 +++++++--
>  drivers/media/platform/amphion/vpu_mbox.h |  1 +
>  3 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
> index 85cc4a14f8ed..000000000000 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -299,21 +299,23 @@ static void vpu_core_put_vpu(struct vpu_core *core)
>  	core->vpu->put_vpu(core->vpu);
>  }
>  
> +static void vpu_core_cancel_work(struct vpu_core *core);
> +
>  static int vpu_core_unregister(struct device *dev, struct vpu_core *core)
>  {
>  	list_del_init(&core->list);
>  
>  	vpu_core_put_vpu(core);
> -	core->vpu = NULL;
> -	kfree(core->msg_buffer);
> -	core->msg_buffer = NULL;
>  
>  	if (core->workqueue) {
> -		cancel_work_sync(&core->msg_work);
> -		cancel_delayed_work_sync(&core->msg_delayed_work);
> +		vpu_core_cancel_work(core);
>  		destroy_workqueue(core->workqueue);
>  		core->workqueue = NULL;
>  	}
>  
> +	kfree(core->msg_buffer);
> +	core->msg_buffer = NULL;
> +	core->vpu = NULL;
> +

This looks correct to me. One suggestion: please move vpu_core_put_vpu() below
the drain as well, so that the whole release sequence sits after
vpu_core_cancel_work(). That would also match vpu_core_suspend().


>  	return 0;
>  }
> @@ -700,10 +702,18 @@ static void vpu_core_remove(struct platform_device *pdev)
>  	WARN_ON(ret < 0);
>  
>  	vpu_core_shutdown(core);
> -	pm_runtime_put_sync(dev);
> -	pm_runtime_disable(dev);
> -
> -	vpu_core_unregister(core->parent, core);
> +	/*
> +	 * Runtime suspend frees every mailbox channel, including TX,
> +	 * and is skipped while another runtime-PM reference remains.
> +	 * Stop RX first.  vpu_core_unregister() then drains the core
> +	 * workers and the instance workers they queue, which may still
> +	 * send on TX, before the fifo buffer and core->vpu are released.
> +	 */
> +	vpu_mbox_free_rx(core);
> +	vpu_core_unregister(core->parent, core);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	vpu_mbox_free(core);

This part, though, I don't think we need.

The driver assumes that all instances are already closed by the time remove()
runs. struct vpu_core is devm_kzalloc()'d on the core platform device, and
inst->core is just a plain pointer taken in vpu_inst_register(). So if an
instance is still open when the core device goes away, inst->core is left
dangling, and the next ioctl - or close() -> vpu_inst_unregister() ->
mutex_lock(&core->lock) - will panic. get_device(core->dev) doesn't help here;
it pins the struct device, not the driver data.

As long as that assumption holds, the existing order is fine: the runtime-PM
reference is dropped before vpu_core_unregister(), so
vpu_core_runtime_suspend() -> vpu_mbox_free() has already released RX along with
its irq, and vpu_isr() can no longer fill the fifo. So I'd drop this part, along
with vpu_mbox_free_rx() and the vpu_mbox.h change. That also keeps the fix small,
which is nicer for stable.

That said, the hole you're pointing at is real: remove() can be reached today
with an instance still open. I just don't think the right answer is to harden
this path. rmmod is already safe, because vdec_fops/venc_fops set
.owner = THIS_MODULE and an open /dev/videoX holds the module reference. sysfs
unbind isn't. So how about closing that instead, as a separate patch:

  - .suppress_bind_attrs = true on amphion_vpu_core_driver, and on
    amphion_vpu_driver too - otherwise unbinding the parent ends up in the same
    place.

  - WARN_ON(!list_empty(&core->instances)) at the beginning of
    vpu_core_remove(), so the assumption is stated in the code rather
    than implied.

Regards,
Ming

>  	memunmap(core->fw.virt);
>  	memunmap(core->rpc.virt);
>  	mutex_destroy(&core->lock);
> diff --git a/drivers/media/platform/amphion/vpu_mbox.c b/drivers/media/platform/amphion/vpu_mbox.c
> index b2ac8de6a2d9..521fd47f1d90 100644
> --- a/drivers/media/platform/amphion/vpu_mbox.c
> +++ b/drivers/media/platform/amphion/vpu_mbox.c
> @@ -88,14 +88,19 @@ error:
>  	return ret;
>  }
>  
> +void vpu_mbox_free_rx(struct vpu_core *core)
> +{
> +	mbox_free_channel(core->rx.ch);
> +	core->rx.ch = NULL;
> +}
> +
>  void vpu_mbox_free(struct vpu_core *core)
>  {
>  	mbox_free_channel(core->tx_type.ch);
>  	mbox_free_channel(core->tx_data.ch);
> -	mbox_free_channel(core->rx.ch);
>  	core->tx_type.ch = NULL;
>  	core->tx_data.ch = NULL;
> -	core->rx.ch = NULL;
> +	vpu_mbox_free_rx(core);
>  	dev_dbg(core->dev, "%s free mbox\n", vpu_core_type_desc(core->type));
>  }
>  
> diff --git a/drivers/media/platform/amphion/vpu_mbox.h b/drivers/media/platform/amphion/vpu_mbox.h
> index 8b7aea4f606c..a934fe61b294 100644
> --- a/drivers/media/platform/amphion/vpu_mbox.h
> +++ b/drivers/media/platform/amphion/vpu_mbox.h
> @@ -8,6 +8,7 @@
>  
>  int vpu_mbox_init(struct vpu_core *core);
>  int vpu_mbox_request(struct vpu_core *core);
> +void vpu_mbox_free_rx(struct vpu_core *core);
>  void vpu_mbox_free(struct vpu_core *core);
>  void vpu_mbox_send_msg(struct vpu_core *core, u32 type, u32 data);
>  void vpu_mbox_send_type(struct vpu_core *core, u32 type);
> base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> -- 
> 2.47.1
