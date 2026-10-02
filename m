Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D654BD781;
	Fri,  2 Oct 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950807; cv=none; b=SZGeVKwha7ZoRIU4MgaicKQnaQGFuxKlglKH3+0zBByEnUKc7wrAC9ryr/b+JsoCfUa8Qf5/3MhodTJX3941hVSbcIHcB1CG0wPpHqMtl03F1zwU+7ndVg0YxW5GQPKhnjveX9wHdOHXdncPvjX+odha7m7KPlFDtRdJWzGj77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950807; c=relaxed/simple;
	bh=RaLGOcBTnNqyC/FwJ5Y6TZ72DITe5iTDm1VTHdQSrF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpRFjLheul0eNX+kPR9cbGD2+gSjWeBaS2CUHZEtoz8R9RLkx6WUNnX8CPJoiCzMjUFJ4MQmPKCm15lKaXVp5kFZ6/O78TAdec+IPtPKd4K2jyUBdR2MSCip7ouO9wyUpgM7wIZCDy9PeHszBdFoRbEk3MlH35Zvh0Rrm3sFNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar1DeY8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar1DeY8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7D41F000FF;
	Fri,  2 Oct 2026 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950805;
	bh=qtC2TabtajIOo5bbi3SCCT8t/kgdQt83zqm+mUVA2Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ar1DeY8XxLuLrXxJEW9/4OFPMhJlNRk/N1nheUowyxwIWUyE8Ir8kPtlk+qW/yn+P
	 UU6Ge+/vX9jq5IG82kmNQE3OV8LGIh8lsSAkbp5eBb4aWvMR6utYMKJ71cYKSfZ9lk
	 KaIWM8HxOnZIB18mI2dUcpmDtgdcpssOk9xS9Zg0cq6iqRXwT/DLCofvO/ZJfRsU/1
	 pC0lLCc45I34tOPOQNJT+wkODb8GbXq6e0lGcUgMD4ezJ3Ptok2Oq6DfgXhE/qh1o3
	 Lbr+XsjPEi2X10miwVNxEJJvErG0Y0ivF1XNzOOKPLVgdpnLou9Cv690/RRAturMi0
	 bUyzV5cklQNXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  2 Oct 2026 10:19:49 -0400
Message-ID: <2026-10-01-1-daily-reply-0005-re-damon-skip-last-region-v2-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930101459.56041-1-sj@kernel.org>
References: <2026092948-agency-overhand-3fd1@gregkh> <20260930101459.56041-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by only resetting the charge_{target,addr}_from when last region
> is reached, only skipping when it is applied or cannot split.

I'll hold this until the damon_split_region_at() failure handling fix
you mentioned is posted, and then take 6.12, 6.6 and 6.1 together with
it.

The 6.18 backport that is already queued has the same split failure
exposure, so it will need that fix too.

-- 
Thanks,
Sasha
