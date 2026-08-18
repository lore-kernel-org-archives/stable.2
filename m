Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BC3A7595;
	Tue, 18 Aug 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068144; cv=none; b=dAu9CtMzGNzbnZoqxYXUfpHb+grK0QjBRZ5RH8nWKg2AwFC5DT3dgdr28Evv23XX+1aTXy1VU+H46sdSziKxS0lrtAqAWlZRGwch+BgYQcGkr22uLqDIhf5Ohi6rM9XnZ8vEZWoRt+EEhiZtHaubfSZm8rB68JwGRC2SMYD1oK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068144; c=relaxed/simple;
	bh=V/NRxeVcfW2CQSeGnS91E8UPj5DwIvIpKXOuoQXLKaM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=YreZHjMCcy0Gw4Epg62aPliiEahwqTqahnPrcMXLkmc9lQvEnczinV395kaNMwL1DUSLURZvepKB+0cHxeJ2klOyhBmMXQSqowDPWKFavbgPU6Pk3F3pr948NuZWtzIjaWBp/p1QZx84ZIp0PUPXYqXaw+OMbSXUFfHl3dCpBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mnmL+pJt; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mnmL+pJt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=b/Ugp6HvGaa1Sa4k05hABuAUnC8NipBG+uwvZnJYsUU=; b=mnmL+pJtTUgDaEyVe+ZO+rMHQH
	U+9HSRP8SqJJoKHsE5gm7xGKfxjeRAJPvfP6KpbG0Wn8VkZzr3Qet4MdnhlL07HgzFTIoBbzCzcax
	9KGCd4WJejR+qofbun5L767NVfDjElTjZVeiRzqdPeoGVZAIxr+BxfWGL1D0MPtkLpinitgj4CW3+
	AWIVW8tqTjup8ruIdxhlsRsyREi7xjRZz7Szm7mYOH60SZZWFqyDavbJZlJPVfGaAb62GmOmOLzRF
	eMRlK5uszvjFNX39rq9hxOQ7hHlrIWc5bYWrIJr72ZKsO5J11VZF558I16bHN+Lk77jdcdYWs+Nl6
	PtH9oGcw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wwM3h-00000000pV3-2Oh1;
	Tue, 18 Aug 2026 09:49:02 -0600
Message-ID: <70f33fea-7edd-4698-b87e-9c6a56ee4040@deltatee.com>
Date: Tue, 18 Aug 2026 09:49:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shivank Garg <shivankg@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
 <20260818-dmaengine-kref-fix-v4-2-c6ef991462a0@amd.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-2-c6ef991462a0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shivankg@amd.com, vkoul@kernel.org, Frank.Li@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 2/4] dmaengine: Fix device kref underflow in
 dma_chan_put()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-17 21:43, Shivank Garg wrote:
> dma_chan_get() takes chan->device->ref only on the slow path:
> 
> 	/* no kref on fast path */
> 	if (chan->client_count) {
> 		__module_get(owner);
> 		chan->client_count++;
> 		return 0;
> 	}
> 	if (!try_module_get(owner))
> 		return -ENODEV;
> 	if (!dma_device_get(chan->device)) { // calls kref_get_unless_zero()
> 
> dma_chan_put() drops the ref unconditionally, so every fast-path
> get/put pair drops one extra device reference.
> 
> The bug fires when two conditions hold together: a non-private
> provider has a persistent client holding chan->client_count > 0
> and another client cycles dmaengine_get()/dmaengine_put().
> When the kref hits zero, the subsequent dma_find_channel() returns
> NULL even though the provider module is still loaded.
> 
> Fix this by dropping device->ref only on the last put, matching the
> single slow-path get.
> 
> Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Looks good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
