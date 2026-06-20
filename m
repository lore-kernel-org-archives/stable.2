Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F110390CBA
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956513; cv=none; b=UwfDdJo0iAwAbRM01MFpF6XmdIDPvt0O222jPLG7tnH2APR0R3FsWyziAAIAl/5nmRppdR7fOkdDBg3zSZJG/KuUTPtncndLeSl32+plrJpy4rmGZg5c4xfzBHjpj87ge+uUD2dCahuwKFUwAhdVqQfDc1enuxsQAv+BBLZBGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956513; c=relaxed/simple;
	bh=ACIM8gGhjDQ4fawfyBNgUhRTNNeQf8IMvcoE2JeAr4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCLTf9Jh/VUOB4b0ml34Vg0N+yfuQ1SfBgc0xGEl1a0J+hGqeg3VJFv8qLrzc1i6BOBxT6DSBxcddq54CT3d/PR2QHg/p5CsBiftU+up58IGvte5KpJk/A94l/3mOczOS5UVJbtQVIay25sIUSt/Cj9+zq3agZwSy3U+vNrK3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQNIlhM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQNIlhM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D276C1F000E9;
	Sat, 20 Jun 2026 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956512;
	bh=n9U074eutp+M/DunrtZnUDCzS+yBtCfoAlOQxoPKIa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQNIlhM7ZaNBx4stevgrtGTLp0qualX9UAIgo5H7BjuCiYHRKivAX5N4oAwOMFJng
	 Af8a0VFikHKpNQ6Bf/GtCsFFmIceonkJnoj4FN+zXm2Mc5b65y7yQf+PrA+V1rnlVf
	 7WxEikSK9Ky+Lnh5+8UhXs1trXV6cErdyti2Da+KWvGE6Mmfhwg7PvJlYbLL/EA2zl
	 NDGNEs/rNF5UDpoHrNJblUV6YX1aF+kCwn1BBsBDi39JCfynaI/zTt+b0n9FV7XQ0J
	 EkdFXwZM/KY7soDBzMyCV9YAOdC2Rsmbbn7ViwokGZZPWyZhhZbl6H/SQqxqs7vUDi
	 pChlI0shtlWww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH stable 6.1 v2 0/2] Fix perf_link failure
Date: Sat, 20 Jun 2026 07:54:58 -0400
Message-ID: <20260619.0010.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619045949.14013-1-shung-hsi.yu@suse.com>
References: <20260619045949.14013-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH stable 6.1 v2 0/2] Fix perf_link failure

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
