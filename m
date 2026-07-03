Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36913188596;
	Fri,  3 Jul 2026 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051637; cv=none; b=mrBFcFo7iCf5DKfMP24HGWKZ9OGFu4mPUtnLRjaniwTQrHQCm7WjyIFXI4rPkgfRBlinCG7rRgR+TQtE7fJHFJV/3RKJJfuhpZo+/oLMpVC/7lbbNimaxUggWdhAzQ2NWcHicEMXLCN55+rza5tC+Ap6TYwxNoxZgdylhBozPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051637; c=relaxed/simple;
	bh=TVPx9+UZMgOp/nS3EIE3M7GR8OHPCQCO6F1iKYV1IsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK0HwR1joLx51OCUltsxZpxiA6IQteRcXxFQaEdmLXQKBoqJ4weXat7KBrrt+E6L9Px73KPMzBmao9xfxVCaepQ8uwvp1oFnY2x99HEOgIynaAAIdZH0pqBaVEdomPZiohtLg8YI9w/pnn6ATawHmHdWwbQU0JwyOv+Bt7rWDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opAsTt5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opAsTt5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29401F00A3E;
	Fri,  3 Jul 2026 04:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051628;
	bh=qUkFcOWdT85XkofjLzr8FixEVGk0Bvd0W1X8es58PKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opAsTt5Vh7itpJrkn9yMwAMyyh2OU1wu1WdrWfN6Jbr0t6uXVDmOC9K+ltRl7pCTE
	 s/6uDnEtQz+ExmJo3rNrHJxy6iu4/xoa6qGcUXmi54e2zB5OXKtaRIbmi93GmObJJF
	 NbHiTZnefkCi/1Qu7Mj+4q7NYNk/GvvKGWEwZ7H206mqdJAD36kg5D8F63SzZB3ULI
	 RUlKe1MxGgfQEVQcSo1Z0PequlsV0hCKvnXMwR07HBRblZJOd2oJlMPt1C5MtITEYD
	 u5ygcrGorJC9Rd2poI1RZZ3oalPXikxTfg2AoA2cWur8vKtcv44McqAgYg1GI44oul
	 NoPLsROumzZSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 6.1.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Fri,  3 Jul 2026 00:06:57 -0400
Message-ID: <stable-reply-nvmet-tcp-61y-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702123644.98527-1-lulie@linux.alibaba.com>
References: <20260702123644.98527-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 08:36:44PM +0800, Philo Lu wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Queued up for 6.1.y, thanks!

-- 
Thanks,
Sasha
