Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239613;
	b=iu6oPSvWP4DifKSgcZ3D6XFe6qpdykcXv7DXuK72hERtAWsg/xi+ZskB4rcbaqquGnSO
	 GemvgoUU7tI1OUJ9eRLP73GPmDZxsE0IaXAc+L/whko/aO2Fpg2cT3FAmESCBzhfVmfdU
	 6GC7GALXv9beC7Y/3S5GvoIdj9HjV0UKMKOZjoj/nrxKsIrL8+S+E8t3oVI4lPqBFETyw
	 Bz3rnttjdWOUy25Fxy2XRo+SbhK3x1fN8/5QaOMqBWIdj4WVciirEzObHkXADMe5zIusK
	 5dtm/E440ldeHrCgCFneF5BDcuB+5YbOn+MaAWvixyt9/GWID6rZptG3QiNXtytyINg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uEC5VBDDnoAmoFMJKKnFz72BBubfiyDuPbecY0TOJa4=;
	b=liIKz7K8nu14fEb41tW58BJ6BMJaGSD37FIMqooKpuKoA2/CCIBHJZm07UH/LhCvr9Zj
	 wr5M1A59hZeBUVLv7cRyhYNuCWVQjBO0QA5VjpmnI1NSQrZpODW9scRGUybaIkw/RShUU
	 dDuuyA51lCslGgkc3YJq8n8gZFfwlI5YwO/VNwJlWrsDQARc7KIO5NWIgNc+F6HDB2dMv
	 YtPcBKlzHedUkWdhQ9IIz7WFKw0jCl1bjPL9aBDgM8oEVRK1+LsL6rEENwr8dEe6yYz3A
	 8bhxDTb9Wgf3joYTmlUNpBv4eOZci2XxxOMqs8L0kpMES0uRYdTP4uJb5ksrensLGLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAAmaYHf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F7606EE80
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAAmaYHf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78EE1F008A2;
	Mon,  9 Nov 2026 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239612;
	bh=uEC5VBDDnoAmoFMJKKnFz72BBubfiyDuPbecY0TOJa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAAmaYHfJ6YDN8lE6u/0CQBiDbbZ1Yuc0O2xmIb+PkcFr4VPmFb8iQDJaXJ2bVQOo
	 E86DSIC/5QO46+lMLoMHiU3bk1Q4k6qXEnE4s3JMizmK+toQxLJaxPhnDAeXpuDutC
	 QP/YtbpvZPbyE+W1tOTScHzU6olaqI5ajF4Jm9lvfsIA4w7QZBgIbp0B/zEA2PQgTb
	 +rd0N+xjc5pjhBk11xwzPzQh6F+wxi+35zEfEjuVnraOUVbnLVg+agJeykqgu1WNiv
	 +W5oyn/VCJUDTqsQEaOGsCj0yfrGcKLyfOFnnLHfTEOUbQLmGH5z0eVnNnH+AAtqy8
	 WMCNplktdVFJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 7.3] cpufreq: CPPC: Select the frequency-invariance callback, per CPU
Date: Mon,  9 Nov 2026 10:52:48 -0500
Message-ID: <2026-11-09-1-daily-reply-0006-cppc-7.3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <55e7eec2-1ccc-4645-9785-ed0b42421e01@arm.com>
References: <55e7eec2-1ccc-4645-9785-ed0b42421e01@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> cpufreq: CPPC: Select the frequency-invariance callback, per CPU

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
