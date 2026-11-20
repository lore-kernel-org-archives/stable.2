Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207172;
	b=iCWpK+GZyN2JX+XVzZDotNm4rG/zN5SQfyj+JKPDeE9lpXNWICBSvFy8qVKO670NR7JE
	 RFERk0lzZf7sXKyiFoqUIWo4cVZhBc8lg3LfUkq6b4+YaDNfJOFiYoW5FzgPlYjIHYZxi
	 wZbjbexLqvARum6+dxzaD99BA/ZTXqpMAEXG9e7lykdQb7Zx9PScGs2ciVFXh5iLqfYOy
	 QLiaORXpR6nbSnQ7MFlnOWqap5JulwfBT0Vn67+cumXlMBy/paNgYkQjg7KODHtlN5dVV
	 bRLvmQag6Qu9hKQzlFTU0cD8L9DpXA86OyHyrh/Bxl2Vl0Oo4Xd/rivDCcdAZ+E9ofw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qsRnFRVqi8iSZhX8tc9yhC2RCaX5Z0SMo8XbBqe42dQ=;
	b=f1ZQNkCW0dpJAbldVh3ZXj6KZXtWdwCIFFH1ZBRjZ12Lop0niLKsV/S0xGv8DQqRKw+z
	 zBAGYN8LXgyG4pgKfQTE9DJI1jrHACI3muQKP4hLi6h8O8rTGn8fRF6B0LneFUWz9T6uF
	 xz78bgWnp9L9eu33WfnRs7gbKmn/9zrzXa3V3NpgsKerQ4mLzMolb+MaDbwPF8kMyRfno
	 k0wDsL3Gt8Ae3eEsMb/qv+tjSgveZK0o9I626hxo5CEsnGXtxpu+q6hUQl7ug++3XoE6S
	 KWYNdQ0kbV9ek6xMCN0XDVGVrAU/pRa1l6tP2O9gZlCXhYYI5nmyCJrpMWA4gwmEXmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJ52gqzQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D1606A325;
	Fri, 20 Nov 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJ52gqzQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8253B1F000D8;
	Fri, 20 Nov 2026 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207171;
	bh=qsRnFRVqi8iSZhX8tc9yhC2RCaX5Z0SMo8XbBqe42dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJ52gqzQ5FO8PKIe0gqMO/MRN08d2CsIBmGKtg2CTe1194haWPfMacQ7jRhtYwJT4
	 Bsyr5mrSHGnfhHmCg2vIcCSeBlGjaqmJXE4nRNIXJxGEPShHBRQTsu+jxsvegji+C9
	 WslOEWRD0r4iLO3IYCM1YOMwogUtgkX0cRqwXZn6jVL5KFd8uK7t4N9uLEAOuxvzkn
	 w+/amRrUbtWteAeGIaV21HZt/KXF5ZxO2ljLwt0DDHuIjKj+eqaNSUMIcUlqOPj6By
	 opiGkc+KvNC9J458YsR77S6gVBCX/sBVtVMrKhHYK3BdQMnbRISdK7JGWzLImBxgju
	 oCZf0z/pVB4Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	James Morse <james.morse@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 7.3.y] arm_mpam: On saving mbwu state read the monitors before clearing CFG_MBWU_CTL
Date: Fri, 20 Nov 2026 15:38:54 -0500
Message-ID: <2026-11-20-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119151931.335561-1-andre.przywara@arm.com>
References: <20261119151931.335561-1-andre.przywara@arm.com>
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

> this is the backport version of this patch for v7.3, as discussed on the
> list before.

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
