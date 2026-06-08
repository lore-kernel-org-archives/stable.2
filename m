Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB33DED9;
	Mon,  8 Jun 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919014; cv=none; b=CJ177ozlbNDBPQ/ujM9IeHD5R6hBSEJnFjlZAy187PzmanLcPzptYIVMni6rRvCGZ5xY0afxW0q5vTLQSRnSvyl28ZKzhsrPAzjQ4SeREE+gDUWeyvBqWK0hoo0H5xxJDOAxg+puJhNZRblDHI+I/asAsz/gmTOd8csjjhVIKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919014; c=relaxed/simple;
	bh=NsuGiHwdu+aQ+9U789licK2umfvuTZy68oIxrYbfUcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/gvvfqS9XcsW/VC6Xv0xhVA9qU1JdXGNErFfgTH9WMujeEEYXomf6SmaZpprp+zN+sAxBnkSO8IoY3xPp2eMpdv5HvrDybLRR2nsqgg6g9LUWrBhqrmbmeNiJz98UdirSQTW1PEyuQV2C+3O6KVQjujH06BTs6CQCNapWzmURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWf5FjWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWf5FjWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F081F00893;
	Mon,  8 Jun 2026 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780919013;
	bh=c4KQmWAFbwvAHdHK+YZw55+mKgkoGrzLFa35PKtZIxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bWf5FjWxSQW1bNKfipzPMcrRjx1FScPh3uSDFMNZcA/Unc8xmjsGJG2YJ8DZWlpl+
	 DZ9JUAM2hOQ5YjtMWNDInxKl6aHc9irZ7sVGHv3acKjxWBS2JUhsFkw+aB2VYjxO0M
	 hChDHgDcUdRNP1TlzWe0AgWKcXsmn7d7o2PtcdDrA+V8OqnR89scuG0Mhf0C60StI3
	 wlM4h6RxDpFxDlfUNU4iPBSdtdTf0p3OGrGz5qZjPRk9RFtgeV1c4txl4walZ0XeZx
	 RZhK3s0gjChBixZ2zkbf8dLABDKOXP2tFPrOHigP7wg/qHdiU0zy6l2Z0u1ri2Wsz5
	 KVCMd9ttpuGkQ==
Message-ID: <6f86dc2a-27c0-46a7-8d28-8e07ecb77566@kernel.org>
Date: Mon, 8 Jun 2026 19:43:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_legacy: remove documentation for removed module
 parameters
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org
Cc: stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260607064053.195166-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260607064053.195166-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/06/07 14:40, Ethan Nelson-Moore wrote:
> Commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
> several module parameters from the pata_legacy driver, but neglected to
> remove their documentation. Remove it.
> 
> Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
> Cc: stable@vger.kernel.org # 7.0+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
