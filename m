Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B148124D;
	Wed,  5 Aug 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948122; cv=none; b=GWl85XcLMLE1L+e//vncbmLH6eoXLzzA4CEoYmPKEMU2olMKDyXApYwIMbBST/HgrkqQ1yVhvF4Jkzag0zaxaV5fAzK8qNSgrfI/3b5I6xEE8+94NRu/SbW5Y+s8DN+oPYxyVzkqaYd+zlAq5XR1F20pAvbElUSRTm/9zi+xEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948122; c=relaxed/simple;
	bh=pIvkhlmqpQscEG7YEPy30f8ZYYo11K/8xXYnHhF9FxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPep0uTYDSwqoFsRnuGowwD9me8AcsC7Fka5OdhI849/0dMo52zx/eKGIUDufv8LHGdXpqjTdO/MuqsKmnOwMPEKFGdsaJC6RcIa72j/Ca7Q3LMMGC82+XhKopcjRgfhgLAygnRK6POXEgAcRRi0WlJVaQ137i3RLVfvNb4q6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpYXNITr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpYXNITr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6318E1F00A3A;
	Wed,  5 Aug 2026 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948120;
	bh=65gD8fNyTJcYk1lM1OJmqZkb61Z8IV0A3B52IuvgYec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BpYXNITrcTyP2vFBzH/7AOvjFUAUr0TMDSxSmvlx5Xg72Tlij3gY3coAzVk+4faPA
	 1aUmOJp8iTSNDc99rBjm5GR3JuU3aTVBgkmiVOe3QGdYfRkIBXKNAG5r+zdC6nShH5
	 y3XrDKib41XteRgAsa/diZNLTExfUkqtauZg6yHu7FQtkzLeZUBtGMoNyMGOAS+GaC
	 lUMRsFrm9TPmmBrgpfJ+JiQLuYokAGX2W2Npi2XAvpsICqj0xM50Al/Dx/3HSCk23v
	 PK7PrlgMs6RretpGKbYVd9R7AkDpeMhwOWtkQh6M6NG2OSWYZI2wWmhJV2UGcvtOiT
	 iw0CQRapqWhMg==
From: Sasha Levin <sashal@kernel.org>
To: albin_yang@163.com,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	akpm@linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	albinwyang@tencent.com
Subject: Re: [PATCH 6.6] iommu/sva: move x86 disable check before allocation
Date: Wed,  5 Aug 2026 12:41:50 -0400
Message-ID: <20260805164000.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d0dde845-15f5-4dac-af14-e8c770273ffe@linux.intel.com>
References: <d0dde845-15f5-4dac-af14-e8c770273ffe@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 10:16:06AM +0800, Baolu Lu wrote:
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the ack.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
