Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700438AC88;
	Fri, 14 Aug 2026 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735731; cv=none; b=oZziobGf2Zl0PpEF6i73gbLtIVOGydY1BHJ0HgtEwtnSE6Rvd8HQuJqU0pJ8+8RrZVTtBPVDJSySN8Tf6F4cnhBwlre600UTBxSQAyLcBFM7RQs+GLeKWj7qkl54yaPBmXv7Oa9y/fGJ+uZMtcz/p8BlZzy21AyRrhpqZN+IQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735731; c=relaxed/simple;
	bh=lG/pjZSZtGHSzn7SteXovf9+aObQvv8u9LYsSe3e71A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M11yNExaRBgKG7E2yXUMuDCaOMPQZU2MznPfe9/2Ps/H9l/KuIGZhfw2XB6xjjAJZLXMb7cq7Msx4g9a9CxT9T4Uo0AGjJxRmUylmwiIHJMqD2CmX8XrIACmsb56qdqHKisMtXygq+c5X2yfezGxtLemBuq7IZWCz2sc01c6QL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giLxFmsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giLxFmsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB621F000E9;
	Fri, 14 Aug 2026 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786735729;
	bh=3KTA9pFWou7k4BD0I50OFBJZVGzJdeantpCxQ/xUzxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=giLxFmsBcug+RdQiBSf1Z+HKoYe95INxef9uuB2zQ/dWbsPTNgEbAEZrxlBxezvBq
	 J7AwYqBRiuZeRnd8cbT5byga7e458LHoqA20B5Uh4lY+ztLy/RNhKT8U7g40RBUcpo
	 8W4jv+klCGsGoGKiXkplVOPsoXJgSmz10E/uNTuRXE7uUWYY5IaHAGdFIvClmB13z/
	 PZ+oj+xygD6WJktOfulrOkaFSSa2LZ2C895mY38BcxXSEaIApM7kYc0ZAF1MtFYlCC
	 +seMs0BNeqCgHfc6TyKtWNf6vZ9xSym+imKJ/0Ty88cj/s8QxC+IHAYudXjFRXx4nP
	 wg37KIM/rtiUw==
Date: Fri, 14 Aug 2026 13:28:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
	weizhu@fiu.edu, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: reject zoned namespaces whose zone info query
 failed
Message-ID: <an9sbzM52QqKdQuP@kbusch-mbp>
References: <20260814160954.2839507-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814160954.2839507-1-coshi036@gmail.com>

On Fri, Aug 14, 2026 at 12:09:54PM -0400, Chao Shi wrote:
> Before commit c85c9ab926a5 ("nvme: split nvme_update_zone_info") the
> caller tested "if (ret)" and bailed out on any non-zero return.  Restore
> that behaviour.

I think the namespace is generally left up on purpose for controller
reported errors so that we have a device handle for admin debugging
purposes.

Can you just skip the zone limits update when you have a bad response?
Something like:

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2457,7 +2457,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
                capacity = 0;

        if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-           ns->head->ids.csi == NVME_CSI_ZNS)
+           ns->head->ids.csi == NVME_CSI_ZNS &&
+           zi.max_open_zones)
                nvme_update_zone_info(ns, &lim, &zi);

        if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
