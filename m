Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EA149DF1;
	Fri, 31 Jul 2026 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785473661; cv=none; b=s+g2Optfiztx4xqrR7VhX21T1CNnjiCgNXG1xJ7saMHffDlVdiBO18QAQF3rmfGUFLga0TRqQi8e0B4DWt38Tn4b6+scTTFxrzP2K73HFmKhPqg5H/YFhUujDw5SgcTzVJ+fAJLZXRQEuTHCDsmjZ0W862A7A45ptJZHZS0FF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785473661; c=relaxed/simple;
	bh=Vq3HJVDt0DwFL/gOPjNltFTZh9zdR7Okt/zzpBD7QBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwX7ubEGfh9zAVgLiITqF/Gf3FDJJB3XyAKYSklxyTUy9HphzIZMqvkWwygKBFgFBn799nBwP1aZ9I2vaf/WRbhZyBslJ91rY+hNWCjCp8S6yyh3s5yKcGiHNwSdxmcGlhVuajpEV1ygtUoCdX4hjgCiVZOQEydSrOqKdnlgprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW0XC/cH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW0XC/cH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5681F000E9;
	Fri, 31 Jul 2026 04:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785473660;
	bh=gz9IeFPSoLgLBkMqwdQbz/x2Xq199GuCvUcOcn38T20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DW0XC/cHHatdpX53bCvejWdsEzoVaBGi4E07PZUFINZ2CAu+Oc0S/269e0/BuaWoW
	 3/OZlxu0asNybkDArSeEX+7NdLjSjM8b9yDpUjpr6rRtdBe0GnXRLQSCaAc2Yal+PB
	 rlrXmjvNteTpx5oLuJKlkcyGqQpkvLgwOOBTlc6DXfJhE64NmyAMXktoeSqHc3wTrK
	 wqBkRLVTAA+rHKRZsyfdbr/0x8C2qHNvQM5KXzYkB1njbrmv76T3DOcsR+RrwapGeb
	 8mL0yrXMio/Z1QNIINlmLKrpz9AZHkvbncFWGMxJFJlDe/hZhby0z7YTX8aedksU8T
	 qxGINhKxMt3Gg==
Date: Fri, 31 Jul 2026 13:54:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: lizf@honeycomb.io
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>, 
	Jon Nettleton <jon.nettleton@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Message-ID: <20260731044456.GA257970@rocinante>
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>

Hello,

> Assign the released BARs directly from the root bus windows when there
> is no upstream bridge. On failure, roll back through the existing
> restore path exactly as in the bridged case.
> 
> The root bus path also had a locking bug that any fix here necessarily
> touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
> matching down_read() (as does the "goto restore" taken when
> pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
> before the BAR release loop so every path through the function holds
> it exactly once.

Thank you for also fixing this pci_bus_sem imbalance, appreciated.

With that,

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof
