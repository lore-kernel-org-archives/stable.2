Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8244248A9;
	Mon,  3 Aug 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777670; cv=none; b=V16ZqkQ01WjxiQAtI3swaC5t16hDMikTGcJuLNMNAo9Tlpi1HaojpyNbDahDajbYoFFleOCStyM4HyzcXD+g3DOJ3PPTz2HQm69uEm84ahtyB0eDfTBO0ixcCRyY3dPVltxUJrLl/ksYGx6PTCLdVKxQK5foSuJLVNEQhy5rUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777670; c=relaxed/simple;
	bh=KSByC83TNLIyvp/ZfybPH/UTua4Mm8Ekf9qt7gTaTvA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u/2/jSlPZt7BpzGHdXqDp3VIN/8GZi97ZAsSJHVMDOI3SUGU0Okl7Qzw2ishm3SwBq+7pLgpftozm/dcOJjjO9JVnrbwrCGxXKwvdZOIY3w/0qZqLR0F6TNihpDWgdy0Dy9nO0avx7ulezEGUTxJ2aGYq9w3GWRmKcpTJrErsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaLE1euk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaLE1euk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C181F00A3A;
	Mon,  3 Aug 2026 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777669;
	bh=/kmsI67Z2c2CDSUl1Hn4hXjxCks4WaqNMw78U/QdWNc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OaLE1eukjNchfUBXBPtcbGdK74dloZrZSPvYS2YwaOtpLyXQ5I9Kb/I//x5o5knac
	 N30MOaIxbp11Jd5JlALr3xsPGpCeUoWtoH4t2UL5Moq40FGd/EBOjRZyCD1VqcRz0I
	 CYSvcNZ8XOiUyNHb/tAV6WRCjE1Xf1p+QctEQ/S0XsCwedxB/4zzDAsrAs/5jLh0GW
	 wru5EjPjhYAr+Bo+EF96LhI091xyCCdFRVRIfiSFdFbnuwWg4WP4v1S0+8NF0w7Hrh
	 EF/SIKAUONJptW3XXcafHjJBc3HHkZQCz4NSzlVPbugsKLz3aX/62+EcHO+sM1kn/W
	 bLmR1zqy5ebKg==
Date: Mon, 3 Aug 2026 19:21:07 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
cc: gupt21@gmail.com, bentiss@kernel.org, hamish.martin@alliedtelesis.co.nz, 
    sashal@kernel.org, linux-kernel@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
    13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH] HID: mcp2221: stop device IO before hid_hw_stop
In-Reply-To: <20260728061919.310367-1-yijiangshan@kylinos.cn>
Message-ID: <oq501p96-sp97-1136-p19s-p96p3no031os@xreary.bet>
References: <20260728061919.310367-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Jul 2026, Jiangshan Yi wrote:

> mcp2221_probe() calls hid_device_io_start() to allow synchronous HID
> transactions during setup.  If probe fails afterwards, the devm cleanup
> callback mcp2221_hid_unregister() calls hid_hw_close()/hid_hw_stop()
> without first calling hid_device_io_stop().
> 
> hid_hw_stop() does not stop device IO, so hid_input_report() may still
> be delivered and access driver data being freed, causing a
> use-after-free.  The same window exists on normal device removal.
> 
> Call hid_device_io_stop() at the top of mcp2221_hid_unregister() so
> that IO is quiesced before the hardware is stopped in both the error
> and remove paths.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

