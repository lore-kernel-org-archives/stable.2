Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA346D0B8;
	Tue, 15 Sep 2026 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463426; cv=none; b=gjodQDTVHsk+qBFi8CdgaSpKB76LwO76gg/oh+nLnRz1oqT7X6yjLCTyjbXe0SjTKVn9qCIRp+Tiojg2a0zLXVp7vHJB6x1TRA+m0LFBjoPcncXmPFvxXMNIMjGokxV7gc5wHMVcxpKyYH4ZcGnG3ZRglumuzqZ8YMtNITg7HTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463426; c=relaxed/simple;
	bh=oqoN/3yz4EQxlXhOpEcskoCheM7vuoIJRO+Ry84Kz/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTL+GmgVe9j8m5DPpRGo1m1MArbKJda/s1O32gmjCCwjVGfRvxeYzYUAPHi/CnNBzztJEkUmKIaZDcHh2dgI9w4jhWy+VngbTbLgYiTJOed3hH7ULG6A7Sm8bmuLtUmAYZy0c/t2/rcW+3P+BhZSl75Ki02MF1QKpS2V2E2L10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OdfcTdMP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OdfcTdMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789463422;
	bh=oqoN/3yz4EQxlXhOpEcskoCheM7vuoIJRO+Ry84Kz/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OdfcTdMPuW+Kr+zHz0bsS053VjlAdz66WEMDa5967bszQUarPcPffVE4z/8hoX0CC
	 J9xlQbaMP0NLUt5glOMNlO5Vu98yIjuHq7BxXBDwBnWsF5omdGALTsVnllycbYDr8H
	 aE/W19nNntQSsG7j8IzBIPF8SO3a3qN0b0WMgzDfpask41c0sXEyS2TEV57zBtyfhj
	 goViAoBqIMQ+8Uo/mcfcath0bxMTlM0RCXlfUaF7lM7iTasxEVZhkWLy7CSeoTvz2h
	 jxCxG5/7OnnFbE61g49ROG4hJBp2DZG3iKfDyXp+Hom1mrC48F0msS2ubl8rs88N3i
	 Z3feuKnI4CIHA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 33EEE17E07DB;
	Tue, 15 Sep 2026 11:10:21 +0200 (CEST)
Message-ID: <409f6896-8d69-48dc-b784-a38f50cfb07b@collabora.com>
Date: Tue, 15 Sep 2026 11:10:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: xhci-mtk: add missing
 pm_runtime_dont_use_autosuspend() call
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Roger Quadros <rogerq@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
 <20260915090223.1346-3-joshua.crofts1@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260915090223.1346-3-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 11:02, Joshua Crofts wrote:
> The disable_pm label in xhci_mtk_probe() and xhci_mtk_remove() both call
> pm_runtime_disable() on error or device teardown, but don't call
> pm_runtime_dont_use_autosuspend(), causing resource leaks.
> 
> Add the missing pm_runtime_dont_use_autosuspend().
> 
> Found using Coccinelle.
> 
> Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
> Fixes: 04284eb74e0c ("usb: xhci-mtk: add support runtime PM")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

