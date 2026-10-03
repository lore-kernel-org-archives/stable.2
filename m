Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D463B0583;
	Sat,  3 Oct 2026 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067172; cv=none; b=D6yt2XSdq1hs3vtipMWaZ07d8sDi7c0ghEV8BTrrdHl8ZCdJTQKtLjd/IjBhrjG4I3P240ZL+VmxhI/WAznZJ/5kG8bC/RBmujq/Da9YYoc9NTbeECmuaaHtMkw6hgrpnAq7rgZoLWltnuR14E2CrsjmUtCSHVQUpEfa+0Sr7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067172; c=relaxed/simple;
	bh=HuVUuCJmc4v8sN+vlGE+8WMUaiSX19YVimwbKUk9Zlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9DCpjFMNceSnfLhNqCHyhpoYlXKPBXvLKtPgvyOs92E0qSpD2JqPXcGx1FXeDJ/mPpw6D1TpiAQ2P1SPmJzBF0DVQzqKaknSi/ljWW+EKiDUfQHtIBW+ivgKsxA8QNSekTAYGAnsWCWXuWGuVYe8sY7a0ZtnKRocjHxups3/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKj1Yg8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKj1Yg8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4235B1F0089C;
	Sat,  3 Oct 2026 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067170;
	bh=a5E7aBxjkua2vJ6YK/zdeFq43OGLBivFfp7BcqdLzWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKj1Yg8+c+iwjBp1N9MOweUVm2LOvzKEHkHYCgEDo9U5amASCATbmUbJG+OFBy24E
	 3UuT6RDClopk38EnlGpd5HyePoQ5hKzVVO6Bl9V2UvDmLSCt1kqTyqWZV6t9ZH9Q85
	 9cT2qFjfdXj2Z+5z3oEYkSMO+aN7PKiACqZcg56hC9PVEyTrdpsylONYPjOGDla4vx
	 pUzLwQJNwjMvL+h65NjdgprTkun4WeLsbe/8bkVzFimSUt36qIj3LTnsa5ZIo1MBRV
	 op+XbkvFTpPIum+39+hZKKmtaZoYxJXL1675gZe8hkY3Xn56DYOtWgFRVog9jf1A1h
	 lJBQ5GFGOwa4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] media: av7110: fix a spectre vulnerability
Date: Sat,  3 Oct 2026 18:33:05 -0400
Message-ID: <2026-10-03-1-daily-reply-0024-re-av7110-spectre-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002195016.21386-1-artem@trailofbits.com>
References: <20261002195016.21386-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 458ea1c0be991573ec436aa0afa23baacfae101a ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
