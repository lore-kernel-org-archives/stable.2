Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738847988D;
	Tue, 18 Aug 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067872; cv=none; b=qXlvxIDaBo5sru1/rmEV6kSWIOBmwMwsG6fRSu2Xy3GVHJb8Kzj4vNmAYHvrWstZH0es8246fRtGBeLB7goXej0OwhWkKPnVdHppfbc9Q/zX6fdz3j/K1TyBxf2kDSKRQNZNNW7Dy5n13j+JdBhVbw2JLnqlRv7GmCV4YvLbDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067872; c=relaxed/simple;
	bh=j6a/TKo4wzYXeE/XNpP/Oj/MaS7md7ltgCNAvg9SZrM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=PrCgpyh8AyUHlAGof6n3Ayi+Xv37nu4UdRdNI5aTxSY6azwJ5kL05j+Wp0x+UHLmulJY3P7OLPqCfJjBnQPmslgI4NqY+Y3Jq/slC9ztvSro+nSIUsuY37nu8USdiHCQ6SSZXGLrid1VcRvEg8Xk+52dEQ99ORKK/3HRz+vjAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=NH9954Hp; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NH9954Hp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=KsD2i9Ar8nxuH1dWYfEoPuU/VRqu8QuRIlcqAWHF43c=; b=NH9954HpkDIFFwD8pXXtVMgye6
	AmmV53d1rMy4anmDuFkEUOxTUG9ROjBXQqS8dCzqm9L+rgNYe38rjKwrmmsOSEkhXmxqeE90cBpSH
	+fe6TbmiMBCkcOu+9zBBrdpbwmkNw0IfvlHt12g8fnN0YtF6k9mIVGu3EUj9wkTpmfPzud0EAwu+1
	ok+ul8IXJ2ObQK64LImKJy1eCiD3vWQdFfSrnU3r9F39yziKYE9ebQp+h/9SrYhGFdjK0AO5m2ZqQ
	AbfRzYfeKVVv3JI/XW3LXVh0SpCsY0lnCT+DSSKAzuDKoDPD+DfUsT47s2wiO12A+sSn2esUZ3j75
	DJCX7a1w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wwLzH-00000000pSu-456J;
	Tue, 18 Aug 2026 09:44:28 -0600
Message-ID: <8b8979bc-a56b-4a3d-a7ec-5b32d225eda9@deltatee.com>
Date: Tue, 18 Aug 2026 09:44:26 -0600
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
 <20260818-dmaengine-kref-fix-v4-1-c6ef991462a0@amd.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-1-c6ef991462a0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shivankg@amd.com, vkoul@kernel.org, Frank.Li@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 1/4] dmaengine: add dma_device_get() helper
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-17 21:43, Shivank Garg wrote:
> Add dma_device_get() helper to match dma_device_put() to make code
> symmetric. It wraps open-coded kref_get_unless_zero() and asserts that
> dma_list_mutex is held, matching its put counterpart.
> 
> No functional change intended.
> 
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Makes sense to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

