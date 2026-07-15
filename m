Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904CA35966
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074372; cv=none; b=UZrr838JH0jR53IaJxj4FNu2Z5gEH9pObp6/O8cXd1zDFZTsjFf6BHrncQpbgiFYBnbbgvvtRoXoqQx47ZaB+3+N3tiiaI3JWnRI71FQDrBdw2a6r54IX3hTjir4OYIrKRIQ4E2qBmi7aY989ebYtJYB0CKBrJ0E1KWFA8MtqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074372; c=relaxed/simple;
	bh=yMRh7zQ9pDYq80ndJOXYtGLP1SzXrGP49shMnCogRH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIWrjp/tPfcwNzOW+9pTJI+jEFXeb1w83muoNs1IG14zFH5JFS0NdTBrNPxcxmGaNygNOsc9zz9271oE36qcgkNgc2XgnnqnVMRJvR/kJiYKslseMdVMflKJ4UzDAoSusZLQRJZ2vXH8s7tSZDN5E0+lTIDgzGuFxvZ8/snBqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjcXAUlz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjcXAUlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D8F1F000E9;
	Wed, 15 Jul 2026 00:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074371;
	bh=X1FzrdGVhLNSonwoOOc5oX8R/B+Hd4o54btgDTJuq8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjcXAUlzL+RQmBDqpzgkNqSVhwMeVatLmluwFNVvrew43aJ/NqBVZ7N6gz/13L87b
	 Ec4Ku7rP/4dimD8FSliLGZgIC88VOurE8Bbb798i2s3Mov/oBGVmDTI7cT0O4HbDDm
	 FUl43P19rVqzErzjSRVU7Mm/Co41JwUFjYuYvpDk9viFk88fpSuMfRL8FCniIIp59O
	 cOY18ps8xWGwaCcVsgpUZQpcKTCxosgzaI09onIQVfq2BPFEVbRIlsHeNzpL4fuKwa
	 tDuRpQM3T8HENpawhwmIc3lLAktWT4S8teQeCj4/kDwglXDMt72r+7incEWjiUZrps
	 r8ViT90w9JHjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5.15.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Tue, 14 Jul 2026 20:12:35 -0400
Message-ID: <20260714200600.stable0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713152610.95791-1-liviu.stan@analog.com>
References: <20260713152610.95791-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
