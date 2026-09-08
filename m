Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45F1E7C18;
	Tue,  8 Sep 2026 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828855; cv=none; b=SQHA5zTmILlqOaLIYpdvSzBaoSD/HmKG0flIjlBT7oL4iaZmMO4pDfS9P5KGL7YXsNxjVuVFFKGLZ86yvEhBK+r/R/m1nTzCxaePPPWZTeNiDZcOfBcTjVdEd7ADSwvm7rXCaCccblq/MxrWZbQKId/H+aBV238QDneSKMtVhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828855; c=relaxed/simple;
	bh=hPmVzwL3eOmkSaiZUw8/Mxvq4YcmDwIZUIOkSs1G534=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvVOWQ/gfAFice3BmotNvSJU//0oXpt2AIN45ypWcur/1YhPjf1b5tkGx58mOV5mK80GaUggh6QNax7uNaQqgFvnO3o19EBjJ9yzccQAEGcH0u2dUL9Wlhleu7E8Qsbirewcry8toGDbw/SsYZaxqSCXooig/slmmiSDEizyAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG2VLCdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG2VLCdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867451F00A3A;
	Tue,  8 Sep 2026 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828854;
	bh=lezepxTgS7POllyZ/XNViL/Q/E+HXFBOpB5tNFaAYXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XG2VLCdbC/cs4vpUI61dxsgJz2S/Qxz+ftWxjXt03XC5dgTmbK6SYlPXo2Pr6GjKD
	 JBe4zBlXPEy4lCkJY+F0HW/PWlAZDTopm9gBPUqOjgXIUdqkvkW2gcCmIFW7mh0UaB
	 +XFwjRV7m+VMwzN56SqgbFp8S+8fI6mHwo3NIyj2P74lFAx/CR7Tio5LuD41oxQYY7
	 gqkU959hqDw44wSFELdsnV/aHZeLESXkcFmRz2QNeZaC4Kld1NMnkwAYUCJPEe2MWd
	 6Q3CWetD40RRg8ose32fVltd20GmLkMkSQwgSaFSNGDDcGglD59BpJco64NLo4xPCA
	 xjnb1fPgNYHHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	VMware Graphics <linux-graphics-maintainer@vmware.com>,
	Roland Scheidegger <sroland@vmware.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Jakob Bornecrantz <jakob@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	Ian Forbes <ian.forbes@broadcom.com>
Subject: Re: [PATCH 5.10/5.15] drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
Date: Mon,  7 Sep 2026 20:53:49 -0400
Message-ID: <2026-09-07-daily-reply-0010-vmwgfx-dma-buf@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907121751.126950-1-alexevgmart@gmail.com>
References: <20260907121751.126950-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ttm_prime_fd_to_handle() returns -ENOSYS when the imported fd's
> dma_buf->ops do not match the ttm_object_device's ops, but does so
> without releasing the reference acquired by dma_buf_get().

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
