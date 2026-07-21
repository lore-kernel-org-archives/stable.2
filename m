Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF53EB7FF
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595417; cv=none; b=TwInDb7y2ihWakg/dW3BUPV0OfEdMHCe31yusZzBo97HL8E6AErfx7jG3kpS1xEyWx0+ryZ+CnINNhHA97x5djMwQF2vo/muPoqAqd4vQY8r7slk9ZfQ6Ltiy3EkbElQ/y6Itc5K+U5Fj/DvdOgdj0mWpd8IWvneZ/6sDcrEA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595417; c=relaxed/simple;
	bh=DIvcXvuMvNtZ4Z4564/GKDmEjX0+5w7Uqa32I9Y9hlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6gZjaHvqk6UgBjJ3KAJvG7p9kytZQlmoJ+9sPQuOw21fLlz4wffIVVNNKCzRUjMQf3bfMQdw6ZOxZvrJaqq9BIjo07wrjsPQB/ZxrF+mInQ2LWhlFTrV+DRdu1ACk138z3vThYsfSqarAx43B+C3bxW9OU8EiD7eUf2RlahHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdgtWgdt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdgtWgdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFB21F00A3D;
	Tue, 21 Jul 2026 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595416;
	bh=Dyleh2coRV9Rsc79d4xP01hH+yrzB68aHD4yucqdya4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YdgtWgdtTTjLK5LCRTtBRlkJAOeq7upEn7rwJiUtVen/XLGv83aEQptBOgwXHqweM
	 BwIt8/7HEYYlU6Sz5VPYdcXgTGaSt6m1n9bsEbJDsmk3DaUZmgUuc4XVxNHF9OGfEp
	 5pXOgmBcFjJVxAO1+N1grR9Bv1stsdLx3Ty67GBEHDXU44xMaPHD89VbVcOzXwzzWS
	 GXkgQw9qzcDW3liXiBMdKle/xhaEviSHwbB4xCasU70gfeVIB8j7OgK0E2mdjw4q9W
	 8Hd7rwhqaH0F0apAIdFkUNzpx7w2qmNo9SXQVqVZ1qrXLUmDFpcFKoFnxZjM4M7Uex
	 gPjbTSJz33FLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 6.18.y] KVM: TDX: Account all non-transient page allocations for per-TD structures
Date: Mon, 20 Jul 2026 20:56:31 -0400
Message-ID: <20260720175500.0024-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720030329.744758-1-binbin.wu@linux.intel.com>
References: <20260720030329.744758-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Account all non-transient allocations associated with a single TD (or its
> vCPUs), as KVM's ABI is that allocations that are active for the lifetime
> of a VM are accounted.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
