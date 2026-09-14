Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA7331A63;
	Mon, 14 Sep 2026 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360371; cv=none; b=B3blfh8HFLoL8aRqvVPdeET/qH+zdb5OCn35ve5XcCWPECRMa8XAw5RXZ+hBlxRJPZqRXVJdkfCGE+bSLE4ZgUPoFdNQvFM/K6J+mhQhkrvO+kLHjMr0FVqOqpCAxHo2NKzgUn1rCv1qrR5wiig/65jI+PE5K5Xm2QkRvFhglog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360371; c=relaxed/simple;
	bh=ebUzZYfqJvoaNtUcw2lFtwe2BilMy5OTQtpgRT6xJJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksRcxrLjBdiDYifjCKCHabqyEWuW+GJKC0/lZoKjZagcgIwHP1arJHOgklE2z85ebhZXkeSrC7Wm7Ib+YWWO0UiAqn7hxa6+J6VMqRlcByMp4D4DFMXTSW+Vb8ivA1+Rv6yJYseEc7OFVLRaEgk06JYKC8yMPE2d7WK9O+9nqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KN315nW/; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KN315nW/"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hjshG0gsNz6NYq;
	Mon, 14 Sep 2026 06:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789360366;
	bh=ebUzZYfqJvoaNtUcw2lFtwe2BilMy5OTQtpgRT6xJJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KN315nW/zI9iny0dGLRHIPaCnoGcpgMzqClCQoqexzsWQQ8QIXZg0mYVnbx5Ld4uK
	 ICxaswFt1xID/f67P/MVJP8ssVrRDeBUjMelxF00g4hUqKv+QRLkBeT3Y8IoEk1jZ9
	 U6ijuIpUVzQ8HXzrlbRwFjUr1mL9t2wgeDHXFF1ScW8gsueaF42lxux8S4/wKvAk2W
	 9ZeEjFn57ijuLYnmOohBHesTTOT5Pk2HJHefAiFI11WCQvYlZB32illDN6TMGMwt8a
	 xQmaf1863JjeFhtL+ouWYYyWAoIaziuLt/Y5XxwSDdYlCW890cwYv6OKkPcJdDv/SN
	 xWxbITgnYhw3Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hjshF74NZz4xjV;
	Mon, 14 Sep 2026 06:32:45 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hjshD66Fcz8svG;
	Mon, 14 Sep 2026 06:32:44 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id C4EF75F9F0;
	Mon, 14 Sep 2026 06:32:43 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <bf269f69-2b22-4b31-8ef0-48fbd8d19865@leemhuis.info>
Date: Mon, 14 Sep 2026 06:32:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: ipu-bridge: do not use the CVS device lookup
 for IVSC
To: Sergey Zagursky <gvozdoder@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Miguel Vadillo <miguel.vadillo@intel.com>,
 Mehdi Djait <mehdi.djait@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20260902211524.5572-1-gvozdoder@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260902211524.5572-1-gvozdoder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178936036425.723339.344260528783743414@mxe9fb.netcup.net>
X-NC-CID: OA7hWtdI5LV0t/nSGqSMt6ZGfUpw2n9bcbNdbzcs9WFZG2xEIQU=

On 9/2/26 23:15, Sergey Zagursky wrote:
> Since commit c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU
> bridge driver") the internal camera no longer works on laptops where the
> sensor sits behind an IVSC, for example a Dell XPS 16 9640 (IPU6,
> INTC10CF, ov02c10):
> 
>   intel-ipu6 0000:00:05.0: Found supported sensor OVTI02C1:00
>   intel-ipu6 0000:00:05.0: Connected 1 cameras
>   ivsc_csi intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: mei-csi probed
>       without device fwnode!
> 
> No sensor subdevice is registered, the media graph has no sensor entity
> and userspace finds no camera at all.

For the record: Linus pulled this directly from the list into mainline
yesterday after I pointed to this patch in a small regression report, as
I had seen multiple people reporting a regression who confirmed that
this patch fixed things for them.

Bypassing subsystems like this has obvious downsides and risks; hence,
if that got something on the wrong track, please speak up -- or ideally
send patches to set things straight again in mainline.

https://git.kernel.org/torvalds/c/856c562c94964a74f63c6d5f38a1509a59a2357d
/
856c562c94964a ("media: ipu-bridge: do not use the CVS device lookup for
IVSC") [v7.3-rc3]

Ciao, Thorsten
