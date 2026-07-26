Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FB379C38
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067514; cv=none; b=Vnsb2bh+elcvbNPMxr7aDOv4loqSmTCXdTpPsX5kdmmwwyzFc6+Xe6aXpBigX0LW6wwON/pWKn3l4VvKO1xmj0kOHthnxC0wiuhLZQK7HOUhf5mDw4z/pibOd7qJ/DDK1yVtHlJq8+K3ON3gWk/p34iI2wLCKQLuX/IYWp/2cYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067514; c=relaxed/simple;
	bh=vrBmAuUDTDxe23dYHfODu+87UBYmiuGCmPf92l+2r8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oyg9Q6l5FF4GVY26hqquFCYeyCF6ii9tKs4yEZAxWEQpyqsXimZ6OeNgYtODVX4f2P5Dj6i6GqBkfteUxgdhVNn4BdtAAFqIzqujiQjTxU41KO/Wn4c8TDrs6wOEY7tB0wdRndaLf/txIgbk9TfmM4ElX3UtLFUoAOvx6+hXh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOurqjuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOurqjuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3E31F000E9;
	Sun, 26 Jul 2026 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067513;
	bh=yfkgCGoqlnD5XRvgNoVLWj93iEhEgRJ0/ieNYvohhjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HOurqjuR3IlYt4Ga5Az74Q+Hoj7xmzLOP6nxro4SKo+k7BYmG06xPzo51KWFEimXD
	 0dhZtEoszcJJyqT8dTlDYvmblhoFc1kTvULgKMBdzAcyAkJdaGMHdfhQN9MfoJ4I6q
	 Z0aF4YFAwLjmvd05Q71xA8qschGQ/wiLcPijhCxMX+ZO4vKHzUt557KZzEG40G/XzX
	 /nOZFw+dZVMNY7A+pDl6/7eAzEB8hqwt600IYAIdhJ0Fyxpac+JsjImps8Se6kMS+r
	 PXQFFBgk2UoniVijPPjkN5qx6nkXAKABhjmYa3R9ojMjEQtfdCTLklPodrbwSGvQRR
	 eqrHATkg8SrSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jhonraushan <raushan.jhon@gmail.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: Re: [PATCH 6.6.y] accel/ivpu: Reject firmware log with size smaller than header
Date: Sun, 26 Jul 2026 08:04:54 -0400
Message-ID: <20260725192000.stable-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724055341.200840-1-raushan.jhon@gmail.com>
References: <20260724055341.200840-1-raushan.jhon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> fw_log_from_bo() validates the tracing buffer header_size and that the
> log fits within the BO, but never checks that log->size is at least
> log->header_size.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
