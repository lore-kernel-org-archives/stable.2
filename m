Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2122FDE6
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629183; cv=none; b=UibBJFTvhQoaNxSEoraD/5WvF7IKs5qBJf78Mp0iHP5gkJ3Q36K8bGZllQYVctEDPYMVa37uhCZVFiiJ+TQHjAm9QVgTSpu/U3X0m5qzTgNSwwnmNewf83IZIOw5UN/eOvaaVsmty6rRobKaUqk1GwRJj0fh+M+X94GTbhvOKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629183; c=relaxed/simple;
	bh=KyeS0SDcE3Bs5HQCPRYmOSKliuLOrUpXolia3R9lWoA=;
	h=In-Reply-To:To:Cc:From:Mime-Version:Content-Disposition:
	 References:Date:Message-Id:Subject:Content-Type; b=fRRHPG9+GLvVIiRMbPpvj45TMCqoVrTmYzvqoVJ+nEE7bUDrSYUbEXok2TIK9T2YpwlaL/SD5sJsblU9WT9SnhJ+Av7saeKpXbPsVAJpoecPLxgTZqQuIdHqXnoMu8fiVyCK2eHRJ4vIntmGyFh45V4Y2sfUphVsRrN4Pl2aau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=hWxRJq5M; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="hWxRJq5M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787629169; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=9hGIWtKmuPfKNxU1ZrkJYDJd8jXk6hvJToJtt6nustk=;
 b=hWxRJq5Md8x3lOxz3clKmBlJ5j4eJC+Pxt8nU0L//14h6iyx3Ul6M7L1a4MbsKsPxcSvrb
 fKu53zejRIXhnx0oq+mI/2MWmOgz0oPEduVshMm5CczrKyfIcnzbVlcoOW0BX47Pp0fdfJ
 FBnPVU80rDgXsWuacpIWc26+c9HCZBRJ0QQmlWYvUBgzyXKOunJTFZyMI9JpspUpfW1xrp
 EgbSvBxiMOq3zsPk1nbN2iqDAwsdUMrDse/AS2NhwR4LKf5NFm5iD4sP0+dVDYdU6nfN5C
 w+56gtA3dotsDZ7rrei67UnkfxMqjGFbjawn3PWpoOzEb33KnjUAIHqG8I2EJQ==
In-Reply-To: <aoz1dUszJJv80bkj@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Transfer-Encoding: 7bit
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
Cc: "Shengzhuo Wei" <me@cherr.cc>, "Mirela Rabulea" <mirela.rabulea@nxp.com>, 
	"Mauro Carvalho Chehab" <mchehab@kernel.org>, 
	"Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, 
	"Pengutronix Kernel Team" <kernel@pengutronix.de>, 
	"Fabio Estevam" <festevam@gmail.com>, 
	"Hans Verkuil" <hverkuil@kernel.org>, "Ming Qian" <ming.qian@nxp.com>, 
	"Nicolas Dufresne" <nicolas.dufresne@collabora.com>, 
	"Benjamin Gaignard" <benjamin.gaignard@collabora.com>, 
	"Philipp Zabel" <p.zabel@pengutronix.de>, 
	"Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>, 
	"Bin Liu" <bin.liu@mediatek.com>, 
	"Matthias Brugger" <matthias.bgg@gmail.com>, 
	"AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, 
	"irui wang" <irui.wang@mediatek.com>, "kyrie wu" <kyrie.wu@mediatek.com>, 
	<imx@lists.linux.dev>, <linux-media@vger.kernel.org>, 
	<linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
References: <20260825-media-timeout-work-v1-0-ebfebbeb6c31@cherr.cc> <20260825-media-timeout-work-v1-1-ebfebbeb6c31@cherr.cc> <aoz1dUszJJv80bkj@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
Date: Tue, 25 Aug 2026 11:39:14 +0800
Message-Id: <ao0OYhW1YOtnWMdG@pve>
Received: from pve ([111.42.148.52]) by smtp.feishu.cn with ESMTPS; Tue, 25 Aug 2026 11:39:17 +0800
X-Lms-Return-Path: <lba+26a8d0e66+0440b1+vger.kernel.org+me@cherr.cc>
Subject: Re: [PATCH 1/3] media: nxp: imx-jpeg: cancel task_timer before freeing ctx
Content-Type: text/plain; charset=UTF-8

On 2026-08-25 10:56, Ming Qian(OSS) wrote:
> Hi Shengzhuo,
> 
> Thanks for the patch.
> 
> This use-after-free has already been fixed by Fan Wu:
>     https://lore.kernel.org/lkml/20260623103031.3051-1-fanwu01@zju.edu.cn/
>     [PATCH] media: imx-jpeg: cancel timeout worker when streaming stops
> 
> Regards,
> Ming
> 

Hi Ming,

Thanks for pointing me at Fan Wu's patch -- I had missed it (it is not
in the 7.2-rc6 base I worked from, and I failed to check for in-flight
patches on the list before sending). His version is also the better
one: placing the cancel in mxc_jpeg_stop_streaming() closes the
re-arm window that a cancel in mxc_jpeg_release() leaves open, which
Sashiko also flagged on my 1/3. I'll drop that patch.

The other two patches in the series (hantro watchdog, mtk-jpeg
job_timeout_work) fix the same class of bug in different drivers and,
as far as I can tell, have no equivalent fix in flight. Sashiko raised
one real point on the mtk patch: jpeg->job_timeout_work is only
initialized on the single-core path, so the unconditional
cancel_delayed_work_sync() in mtk_jpeg_remove() would hit a zeroed
work struct (WARN_ON(!work->func)) on multi-core variants. I plan to
send a v2 that drops the imx-jpeg patch and guards the mtk cancel
accordingly.

Do you see anything else in the remaining two patches you'd like
changed before I send the v2?

Regards,
Shengzhuo
