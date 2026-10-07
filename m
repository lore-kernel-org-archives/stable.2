Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA737DEA8
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407047; cv=none; b=s6AVS1/QMyrXcqQ0AbkFDyK8Js5r6G9Bub2cJTFWGykqYFsLnslJMfghGJhXqbkr4ESn3NoBh9lL/3djssB0n9vUeY4SWyvftvYFvpKWZWxq70ESiq7u+JCnRZ17hTABR9u7k+TAhfTO8NoQzBbE5pbeH0WmTDjBj6aceZLsjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407047; c=relaxed/simple;
	bh=PXum+HRkOV1j9zYtNQ7nkAZxGi2eiB2YH5ZSgfnT5tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AF8FzuiansqqA1Pe+359kjegcqCV+bXn4Ev5fipV1ScDY0IquOQ1mdEEkDB+VdrzsDFvm6nBND+Vk7rcynSMurBGqv9bvCY0Ivd4wJtTkaCNkinO9k+ZqkG+TkNqPLOp0eA5LMP5bdukwWAssLps3AAeQ0fbRBjXJw5Go3LYjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/WQJD/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/WQJD/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE61F000FF;
	Wed,  7 Oct 2026 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407045;
	bh=r5uw6aYoh6wMKL9N3FJA4RVAwXAWn/3Bz57MfqDppQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/WQJD/FVRMvSgzn/hod3DhF6Iy2lm8RQZTpqE6rJ6R0KNMbYmUwqcjhvpBs9+jvy
	 1MSuo/KFN/UuxN4Um5s/RrpfkMgrdl9UWHCy9arqFy2deJ8XXtlp+9i3h+dmj93NvS
	 md6JvYOkEv12jifUk9YVR5sWfBLhXV8+X21BLDS96koG27Od+wn4+XV/Rx/FJd/cD7
	 y8RV08aAN/kEN3NemGLqprXoAo5BOxx9jVskuPJJaRZIKq+xl2NPRV7mgQBGTysb66
	 WNHYsPsrvR14nXttvgI7SGt+RDlNsBJIZiRZTh3zLq9bA0dNxtsAjPLYEsfVbNRPyn
	 XFGW8B7nrJuzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>
Subject: Re: [PATCH 5.10.y 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Wed,  7 Oct 2026 17:03:29 -0400
Message-ID: <2026-10-07-1-daily-reply-0012-arm64-a725-erratum-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006115442.2223870-1-beata.michalska@arm.com>
References: <20261006115442.2223870-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the workaround from the erratum 2457168-specific cpucap to a generic
> broken AMU constant-counter one.

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
