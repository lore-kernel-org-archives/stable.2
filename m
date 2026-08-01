Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663F3A450A
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548422; cv=none; b=fqmZaEpNsw33KvmC2gIy3nvr66iZJj3baPZAoQDG32sVRSRiIe2zUvVgdOyGQPJD6Yl3l3YFCTc0xrUY78icV06OX3yqmPCYUXzbeTpD/kzeCgNfylx3T+/IMS3iD/9jNXt5oY4EjvZALW9gYCe4e9E+J1VspGivo/rUL/QrECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548422; c=relaxed/simple;
	bh=TPpadGoGGVhKeXcub9GY5fYZTKWjBM6c9KDimeL+2uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udxOWKyPq8hsvzkDDWpXSlSIkSCuoYBbDB2psTUksdL9d6BSg2keb9iCPyHKCN9/dptCUFoMWjgzTAQ21q2+FkMuYimE8lfNDBymw7yAbFN+0Xf/4HvrnpshOUoA8ZWU2C6dsi+s4ccL1XS/dB7v6u+U5zlL2yS446aOixr5968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWP2CciT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWP2CciT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1BC1F00ADE;
	Sat,  1 Aug 2026 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548419;
	bh=vdIZ19JGs0ZAzfxERp5+HKiyV74KmQzTS/mkDUGD4LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VWP2CciTVuwDDZ8YNKH1qZ91jy2XMG4vJPuTE3kODvD084YYm0ufk3X/yPfEHCrGF
	 4QlhiBPn6XWBahJoqxVr7lWMHsQW6s9Gi5TaC5V0k0deis7xqcK2y3LBWafU/Ju8ef
	 XRaeUTC/+UtLDXSbDpamBVbzG6yf61r+lCQJhfJfnuMQmBHMrkwQO9TanesAY5BI4Y
	 dZWfMeE2M/xa4tB6N5mkqTfwv3l/4t1R2WsO1my65qlAN6jWrGTDZjsl55JaJNsM3/
	 8BsNHQMWkeB+jcDzF+du+bz17C8x+OsfsWMrKlJ5PzEoHUzn3faDlyD/v5XWFuoAJh
	 Ggjm+w7Lcdj/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Honglei Huang <honghuan@amd.com>
Subject: Re: [PATCH 6.18.y] drm/gpusvm: publish dpagemap early to avoid device mapping leak on error
Date: Fri, 31 Jul 2026 21:40:09 -0400
Message-ID: <20260731211007.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731111728.3415703-1-honghuan@amd.com>
References: <2026072912-heritage-womb-d38a@gregkh> <20260731111728.3415703-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 07:17:28PM +0800, Honglei Huang wrote:
> [ Adjusted for 6.18.y: drop drm_pagemap_get()/drm_pagemap_put() around the
>   svm_pages->dpagemap assignment; that reference counting is not present in
>   6.18 where the field is not refcounted (unmap path only clears it). ]

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
