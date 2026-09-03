Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB14FC8EB;
	Thu,  3 Sep 2026 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458171; cv=none; b=lS0XQliIKuaDDevM/AMW7BSpxf6hqsaJHjEVGI99LYFXdOnmmFaftTEo8dEsleqBLTvSDzVjggo3SEqL8FVhxywbozoC96gBANbU4nx27cLWeBQq6nB9tdwn+pvHSm+E0AMbjQoWyDZ46zJT3s9e13HCebaF3EcESctUsyqAg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458171; c=relaxed/simple;
	bh=MLxZhD+jIYxoJlzkAkjmDio0/0o1I9QFxIPQT4FpPts=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hEwDYXQXMXv7GW8WsLRoFbsjzEA5Gm3yDM00dWpJWcpVjnYesXAtq3XTmcmqU2dBaohWB9ypl8ZYAruNCJabFwH6jUmUqz9zOYAt6FyuLyMTUVo3zHQ+bqiLPGLpTWK9K0m8i430BuYByawwjQvX1nODzfl2WbLSpyuEPaJ+TVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RspqEKHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RspqEKHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2C21F000E9;
	Thu,  3 Sep 2026 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788458169;
	bh=MLxZhD+jIYxoJlzkAkjmDio0/0o1I9QFxIPQT4FpPts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RspqEKHW9C88LhVbni8zvlQ+6YU++OWW0vx6BiFXHVDPVulpQk4UhYxPeQ0an03pd
	 AnusimBtjxZPFy73M5+j+/0y1vqrZT+6972MNvx77VtyyrIS2aFi74iSowOsq3SV6w
	 midLbcZbTG5oiozWZW9hhTJCZEr7KfkEUj/NiJ7em+x9+6Gmg00hAdfQWyQSdSuGKY
	 4+knSB1j0quynETRvacmpauAhTBg7Jpa0CZaNVrvLAdS0XW8sKGvbpj6Mgyebh2JGz
	 iKFjpkury+YB+trTPat0wRyylasPQ8cQCJIWRd9dDUAqt993H47xHRgbWIrFPJbzms
	 mGbFFdgfa2z3w==
Date: Thu, 03 Sep 2026 07:56:08 -1000
Message-ID: <2edcf44237f7a5e81c6ec97a81b56d5b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Fix NULL sched deref in kfunc sub-sched
 error paths
In-Reply-To: <20260903060626.814951-1-liwanwu@kylinos.cn>
References: <20260902153640.144791-1-liwanwu@kylinos.cn>
 <20260903060626.814951-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.3-fixes with "# v7.1+" added to the stable Cc.

Thanks.

--
tejun
