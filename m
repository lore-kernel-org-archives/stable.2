Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF11449B09;
	Wed, 12 Aug 2026 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552017; cv=none; b=FBc9JW575srWvt3xvN8I+xk5pVQFgBpHz1Lr3F0qaK2M7CPN6zuCpNsHCqyrceoHcx6xC6Kw/nblC5shNUycCrImXo4tpGHc3Qk9UXx7TWdNXe46NiKw7c8UVvmt5jgtolbu4ugcJ4TBYiaxmvt06NrdHnvZk6jDCqTfiCFKSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552017; c=relaxed/simple;
	bh=VZP2ySyYgdMklxjms9PP1NuHGsSMIsPjJm9Kvj5xDmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbpfBKNVros/e9lEzae163s5qesnCpsn6tQxKdfflegNRRKlmisTUSPJTHDgq3RX3hNfWsuf7nt7Iq8Wbl+uJWEc7pvGsAYh7gFBZy4Bcja8QfSeaepAkPcsRvCGVtYcBgVBtfzFAKbi3/aHLv+iL+FbLkeRE7fRKUMN2i+zWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTGLSFjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTGLSFjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF8F1F00A3A;
	Wed, 12 Aug 2026 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552014;
	bh=4V1+/2EJJuiGbidet3zkX6vpoQuiVaIjmr26xHx/YRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lTGLSFjnO2vlxI8q+J+3NLCgRHC47cXQgySKD4/W11jWh4qXqDMxTGM0jV54/gHu5
	 AcX/tF2qY9h9GF448mavYfJqWeQAOaF9q1pYii9dva8MgPE4Wjpg0UI+18jGYg2Bbu
	 C1+f3x6pDfTHhk0TnsDnBHJqaSF8RcjWHahxNxo8QujmfW7giN63M/la/unXNTamAy
	 WWW0lgvwj12NoGH5R87zSbObEL+lhDLPVm6RV79f2fIx0LOo2zOiJ46gFQR9OYJ4qN
	 LyGz4nLLCOILKgYt9BRWzfR9QPnuHk2D1P972WWi6zcducsq8AucWr+ya6pblggBtE
	 WOirFwz7osuHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: [PATCH 6.18.y] net: fec: do not release NULL pages when RX buffer allocation fails
Date: Wed, 12 Aug 2026 12:26:41 -0400
Message-ID: <20260812161500.10004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810123902.2611897-1-mehmet.fide@gmail.com>
References: <20260810123902.2611897-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 10, 2026 at 02:39:02PM +0200, Mehmet Fide wrote:
> Skip the entries that hold no page, and clear the ones that do after
> releasing them, so that a later failed open cannot release the same page
> a second time.

Queued for 6.18, 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
