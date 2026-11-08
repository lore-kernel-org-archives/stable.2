Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=122.28.128.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794107489;
	b=cxcBulGZjbHaSdAv/e8A7zjjtHpL4tgl0YJyZMpyGqAszbR8bNQxNDi5YA09S3Q2Sd/B
	 V72w9+BjBV08jJ/u5S4bdL/+zLizdyU6zV7iWrkhv7+tddGbuDVgfGm99LzcuoHkQSBym
	 43Z2u+wMgtKwhtDcysCQ8T6JPQGSADULuc6rrIZ40vEbQciQozVG1TOszPa+2TjvAM2wl
	 fE5GFnFsMej9ux8T10epaC59VB2LZZl0oCtNIFP6xkioLzJPm7yUtycIEO9UbhJTSouSv
	 0l49nZc5WDUEqiVZo7TiXFP60i/NNVmmm6rhkUrxZyT1VA3LVxyJ7e4NPJ3fPPFerDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794107489;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:In-Reply-To:References:Message-Id;
	bh=GQvfNp65FBXmcF3uK/s2GXnfQ0y/t47EhDsCV7hVUL8=;
	b=PMuMjdQGVM+OyDsFoH5qCVa4dNwGF7af2QKAzFzHFPhSBGHcuhFs6kITX2nM2PzUVvy8
	 nUpI+hgAjcaAWT4WiEamRoiW8vjhMfzzJWU++wFip1X3Hnup7DOziQIO280Cd2/cZJCpc
	 oSpjdBMbZ/u/Pd/wAvkX9axOx/dXo7T+ZVzx7zogAL45QxNw7dgNqDB991JI3rJHOBUGG
	 XPjnj/dDe5Ewgky8iQIwmsM6wDQZbIiVl7uguGQTAWQ08beCFNIbpYVAnP7DkMJPdAv66
	 MkW9lzJ0yZv8+B+B85gYDoPVTYb06Lp1atoMZlqRJra8jHLneNz2RiZL3vz7dy0rHTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=docomonet.jp;
	spf=pass smtp.mailfrom=docomonet.jp;
	dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256 header.s=20240125 header.b=h4Yto5rt;
	arc=none smtp.remote-ip=122.28.128.102
Received: from ocn-ckd-mts-117c37.ocn.ad.jp (ocn-ckd-mts-117c37.ocn.ad.jp [122.28.128.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31430606A31A;
	Sun,  8 Nov 2026 03:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31430606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=docomonet.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=docomonet.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256 header.s=20240125 header.b=h4Yto5rt
Received: from ocn-spm-mts-103c1.ocn.ad.jp (ocn-spm-mts-103c1.ocn.ad.jp [153.128.190.230])
	by ocn-ckd-mts-117c37.ocn.ad.jp (Postfix) with ESMTP id 974F34003112;
	Sun,  8 Nov 2026 12:11:18 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
	s=20240125; t=1794107478;
	bh=GQvfNp65FBXmcF3uK/s2GXnfQ0y/t47EhDsCV7hVUL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4Yto5rt/S4/h7ZlyTQ/vq17Y7qA0reVKb/xAGxFXwDU7A8yUz95Z+5WvGn+N6HvZ
	 A4Nb2mHlH8YR4FyUQuYE4QbF5Fe1JS6fqqLrQRpbuIGoGdeQOXK7NAL+pgf/Ih0UO7
	 eNPJQblhEB8UR0kt1UFfFk/Ggo88Zgy27JSjtSmg=
Received: from ocn-vc-mts-108c1.ocn.ad.jp ([153.149.236.202])
 by ocn-spm-mts-103c1 with ngmta
 id 811bd508-18e5f33f0194fd6a; Sun, 08 Nov 2026 12:11:18 +0900
Received: from ocn-sdpx-mts-113c1.ocn.ad.jp ([153.128.117.211])
 by ocn-vc-mts-108c1 with ngmta
 id c06a01b4-18e5f33ec017da7b; Sun, 08 Nov 2026 12:11:18 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
	by ocn-sdpx-mts-113c1.ocn.ad.jp (Postfix) with ESMTPA;
	Sun,  8 Nov 2026 12:11:17 +0900 (JST)
From: "Shigeaki Asai" <y-asai.0816@docomonet.jp>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Nicolas Belin <nbelin@baylibre.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 John Williams <porschemad911@gmail.com>
Subject: Re: [PATCH] drm/meson: encoder_dsi: load ENCL gamma table while ENCL is disabled
Date: Sun, 08 Nov 2026 12:11:16 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 7.47 (WinNT,A00)
In-Reply-To: <022f5372-7963-41b1-ba76-2d89c51aa8c6@linaro.org>
References: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp> <022f5372-7963-41b1-ba76-2d89c51aa8c6@linaro.org>
Message-Id: <5DD6F2ED1CC4592F3006A@docomonet.jp>

On 10/4/26 17:31, Neil Armstrong wrote:
>Thanks for figuring this out !
>
>Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
>Thanks,
>Neil

Hi Neil,

Gentle ping on this one. It has your Reviewed-by, could it be picked
up for drm-misc-fixes? Please let me know if anything else is needed.

Thanks,
Shigeaki
