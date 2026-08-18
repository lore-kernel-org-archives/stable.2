Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79591332EC8;
	Tue, 18 Aug 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068246; cv=none; b=Nts3Bi4nsGyUHn66ucLcpFjyY6kiugXrBWaR3HFfAbSHP8diKlUKCkYnlvrVqSQrcDGs1lZCoxwz+4QVYCco/a3kaeT6JQu3v879/Lklzv2xp200f5jRANw4lKoqsVUpL1eTsvNar2S8JiPAtxwjLHkK2/pT9KHbC9E7Ei7pG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068246; c=relaxed/simple;
	bh=fO0vk990GWu+qM19d1DAlmLcgS1lPVAR+gmsboyI+Zg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=cUXB5SmyoH9j4mJc1EBwBGiCLGANQb0ePeO+poUV7CLU/D7tfiBhluWA+lWEUXR3PY0tL3McIydwwS5cbYRosHtA4ytf5FIwb8nx+nnR3YfR17xIych+zsCcpAJOrQ7ehi4EfCuWgPYOVm/+fGIu5k1qfX+Cl+UJWYM7Zmoku8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=kub2EcLW; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="kub2EcLW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=/Is1IO0CL+6lf/eNip0kVaaOQEnMfMLHfrp7LkxjZ4w=; b=kub2EcLWjDnwqwGz9mgtrA51Q6
	FVrU6sX/NLF/UyhFlNkf6CI/g4m5i7nqb6J86TCfhY2i/D7C7maEZUDkag5H5Xmd5CBHOKLn2GYV9
	dlyzfRIFr6bDo7DpXGc0uJXl3GHBfJXZuQflyU6c1DsBmgJNDblix2CpKRZSr3654gdm4rDH39ZI9
	2mJ2SIMElUVUBkvbhr98YKzwMRU37BLFZbpmA1leXQx7KyAqbvNUD6V6A2OafpJlkzw3R4X4KvMfD
	a5jyZ/cVuFT5SaVlxng7dGvhKTliGj+3byvUBA2EHAXDD9ltd8B8kCYrIIL1Drb+fzqbHfRLmT0Jn
	qdAvcnPw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wwM5L-00000000pVs-3yHr;
	Tue, 18 Aug 2026 09:50:44 -0600
Message-ID: <d533699d-fc7c-4642-87f8-0bfed554b0a7@deltatee.com>
Date: Tue, 18 Aug 2026 09:50:42 -0600
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
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
 <20260818-dmaengine-kref-fix-v4-3-c6ef991462a0@amd.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-3-c6ef991462a0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shivankg@amd.com, vkoul@kernel.org, Frank.Li@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, Frank.Li@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 3/4] dmaengine: fix use-after-free in dma_chan_put()
 and dma_release_channel()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-17 21:43, Shivank Garg wrote:
> When dma_device_put() drops the last reference on chan->device->ref,
> dma_device_release() runs and may free the dma_device along with its
> channels.
> 
> dma_chan_put() then still reads chan->device->owner via
> dma_chan_to_owner() for the trailing module_put(). KASAN catches it:
> 
> 	slab-use-after-free in dma_chan_put+0x3e6/0x4c0
> 	Read of size 8 by task insmod/6319
> 	Freed by task 6319:
> 	  kfree+0x225/0x470
> 	  dma_chan_put+0x395/0x4c0
> 	  dmaengine_put+0xf8/0x160
> 
> Cache the module owner in dma_chan_put() before the put so the trailing
> module_put() does not need chan->device.
> 
> Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
> Suggested-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Nice catch, looks right to me and the patch is really easy to
understand. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

