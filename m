Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE031353B;
	Fri,  3 Jul 2026 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051640; cv=none; b=RWDS2xQLaon5oaXdunhY/wi8bahHjp9eAk8Y/nl8Jaio6ueILIHY57rRtaWPQrhdZXuIQVtMx/tDxfboa2cpa+4/Uwqc+y1cOIogHTcm1XEoYqcSBaI4Uo0ourYoWyKOL6oEeuKHZ2SYirSjIPe05/dbP6cIDaQV3rgC1RbAEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051640; c=relaxed/simple;
	bh=P7UnZaVTvT1shTbdhfVXgrr+cURpG3bz3CjfNhgr/9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QScWEOJ9E3ZP2SuqSYRt5obrYpyqC4C8t6LYpRAxeS8GWu3XjpjB30xvg1IQ6lwB6/6a1ftuUaR3AJXu2rQoRckU0q1vvakgFEMzZljhN4oLf1vig/DVg0mCTMQfhJnTWj2FAs+yxwOdDt7hqI1l90NkRA93WON53wAld55Lr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0bPYIpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0bPYIpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4816F1F00A3A;
	Fri,  3 Jul 2026 04:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051631;
	bh=5Qah2y0SaLCXR6gXurgUrTFa2uLuL2kbocBKf0t1JfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0bPYIpjzdvKBwhg5G66h4Ux870rGhANqAOA/XqIESKk0Y0kO9yyWoZymA+aULZv2
	 wWd6WdIIOZlm2oZdL91wod4+VKf4QX/IP36r3d9h76VrDAmTuOCBIRcjCtpRDFdw4I
	 v6wVXaR46H3KqI7xzmGjnWpggmdMBCy+cNr9XNwmfacPjkUBo266DWKt3ea7D3VK97
	 tZ2jGUpZD3zZslTFA4xHXBBWs6rBXhuWfsHtIksaxmJgJdez879zRdvurz1dxryCJR
	 6v710lolvhf+CyNlMp7U2jlNPi3JxCh7J9rh85He2X9gIlYaRTSzunyqP+Nvc5iI2f
	 qQ2GMsA4n3Raw==
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
Subject: Re: [PATCH 5.10.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Fri,  3 Jul 2026 00:06:59 -0400
Message-ID: <stable-reply-nvmet-tcp-510y-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702123839.100640-1-lulie@linux.alibaba.com>
References: <20260702123839.100640-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 08:38:39PM +0800, Philo Lu wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Queued up for 5.10.y, thanks!

-- 
Thanks,
Sasha
