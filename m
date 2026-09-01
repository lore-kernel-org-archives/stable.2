Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743C384228;
	Tue,  1 Sep 2026 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788305511; cv=none; b=ES9jm1MINqyggmHl3hzVFH2qvS73EWywmAhl00Xu493omLXBUUjtWbraHZzd7opdOloVud2FRimq1R0x4UO7Yoc4pZ2prOj1ZXDeK9ge0MiXSagsbPymCJ7g29bHfmkEbBmQnWkXD59Dz1oUC+L1LMsJcIEMpLxQWrWH4NcZE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788305511; c=relaxed/simple;
	bh=6xUV+x0Dv31tDxN497GmIEi7l4s6TByiTNuFDD24Oqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjd9+khibJxlfYL80jvKRsGz+VuiJJsglbNVsYGPLa3gieiimkO73oS1yNkK2ktIbmAP3K6V9GYWLn0RApcL6g/pTf9V9AZyKY8q6tO7/AhEpZnwNma3NJhayvTRtgfY1228d/WwLwrB0jhL/BntDCs7TbgVDMwjBJUIEgju8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQa+U53k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQa+U53k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3061F000E9;
	Tue,  1 Sep 2026 23:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788305509;
	bh=xTvwQIXahNVnfK94ob7iXEE6WC8jM9sp92UGzokg77o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AQa+U53kswL9lH0iiN+Pc/CcxpmWmHlPIj+AapgZIlwhFwJglXkyeYGPUfWZXIoD2
	 gtErsqoTsnzFpIZ82ytS/WALZq2h9zY5UotQPqU5a8a9FQ7/rDG7cQn5GC1eA29mQE
	 vG3PGxjvcv24QGLfENkdEOpTju5gel7IVomSYzflQwFjbyE2ctwv+xOpFchLrwQsjp
	 vk1lXXCFqIQ+KPh9bONCD8pMV6hCbKngemSdL8HjcoPH3DXIPCriVJey3bBiYsbpJO
	 KQxLwHT3xYaNRJdLzZavzXD3vv1t/KF/jQNGJctYa+SEYkcWzSfl3qNYkg7ihYBBu2
	 DyNqQbYJiCe9w==
Date: Tue, 1 Sep 2026 16:31:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "Chris Snook" <chris.snook@gmail.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Jeff
 Garzik" <jeff@garzik.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] atlx: atl1: cancel reset and link works on remove
Message-ID: <20260901163148.7b86a53e@kernel.org>
In-Reply-To: <20260828-atl1-cancel-reset-work-v2-1-1ee8a5ac2f47@cherr.cc>
References: <20260828-atl1-cancel-reset-work-v2-1-1ee8a5ac2f47@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 18:14:58 +0800 Shengzhuo Wei wrote:
> atl1_reset_dev_task is scheduled from the interrupt handler on PCIe
> PHY link down and DMA read/write errors, and link_chg_task can be
> pending from link events. atl1_remove() tears down and frees the
> net_device without cancelling either work, so a work scheduled just
> before unregister_netdev() can run after free_netdev() and touch the
> freed adapter.
> 
> Cancel both works before unregistering the net_device, as atl2_remove()
> already does for its reset and link works.

This is not enough to fully fix the issue, please leave this driver
alone.
-- 
pw-bot: reject
pv-bot: slop
