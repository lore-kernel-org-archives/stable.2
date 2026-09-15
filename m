Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F93EB0F0;
	Tue, 15 Sep 2026 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463428; cv=none; b=n7H/+/RF031PKaRRvR+6oYrUfWwz3pq1iUxkOPe8ABqeJAnIl5Cxej2GcrQL6F83Zm0mVU33bS8Jocnsuy8PzcY0OuA5hwRxHcz8zLws+HR0ojcg52nh0igvgbXVq4X1U42F0It0z0vtw/MnLNltsI/Nm1luTpdezyIXYacWglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463428; c=relaxed/simple;
	bh=AO60Q3QxQLSX5nGXdAEMjIA905O1ARI+jXUSfoFnJrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4llj2lc6nXWVJvAELKJyBnkY3O8Js+ZLbxCalwFJnGaXjPEk/sFs9ibCXm7FpQVumT0oSmcq1QkGeCSvk4sxMseLSbQcdBrNJ22ZA3aKeQQFXevGB9E3SV3w2noR+qt5Atplh+1QXp7s6kmHHJibJCcVfKex1nrzRPb84oSO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xwylx1WJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xwylx1WJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789463423;
	bh=AO60Q3QxQLSX5nGXdAEMjIA905O1ARI+jXUSfoFnJrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xwylx1WJsWjs7MjUahl3hMJgjNdBKksZVvff0H5iHgLG5qB45ZPQlYCiwXIMsK3lK
	 EZp6eOzWoCZpPaNUCvLR4bCpYogaJMmvRz1qFtf4/PskWxVaX21htGMHxQp2fnDg6c
	 bfeXSw8W/FbRrf1NIL/bjlKtvBJCme4aAAgrh5HC7rr04ntAe4n30GLO+92SP1MmoH
	 xvb3SrMRi3GdCxxpR3mNL9QMvMjJRBGO/IAdmt9mTstkO9gafUbmkwEeYCMGzaDTam
	 ZNVW+AO4KMoS442wy7WVDoAo2fzyuStsm5Uj16yFQ5YIQWN6B9wW2kjhusekqCAbam
	 7Z0o+5N/YlAyg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 70E2017E090C;
	Tue, 15 Sep 2026 11:10:22 +0200 (CEST)
Message-ID: <2506620b-a89a-43c2-bb86-ee4a136d3719@collabora.com>
Date: Tue, 15 Sep 2026 11:10:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] usb: mtu3: add missing
 pm_runtime_dont_use_autosuspend() calls
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
 <20260915090223.1346-6-joshua.crofts1@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260915090223.1346-6-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 11:02, Joshua Crofts wrote:
> The comm_init_err label in mtu3_probe() and mtu3_remove() both call
> pm_runtime_disable() on error or device teardown, but don't call
> pm_runtime_dont_use_autosuspend(), causing resource leaks.
> 
> Add the missing pm_runtime_dont_use_autosuspend().
> 
> Found using Coccinelle.
> 
> Fixes: df2069acb005 ("usb: Add MediaTek USB3 DRD driver")
> Fixes: fa6f59e28c61 ("usb: mtu3: support runtime PM for host mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
