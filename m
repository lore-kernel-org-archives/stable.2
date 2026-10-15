Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75AF559C9F;
	Thu, 15 Oct 2026 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092987; cv=none; b=T/f2IW1U1x9R+LrOODB47aEw6GbSz+xEFOI1ozrqD7pXaUpnx5XSQ9thoJ9n8vV9y/lTzP2FVjD9jZMUurwfHsfSf7kG6uQTmH0fUd1pIBXU04doPi6fcFEtdFvgFU6UC4aXSVc6l7U1BEZuZUd317PwkWpfBqHROILckq9K+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092987; c=relaxed/simple;
	bh=b5p3D9C4/n17ZAQv9bISq5HIUjHDUVL/oArH72EtRYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSTxWfAd+ADP+xrmTX41u1c3d8ZBsvVjqll453LFJlXc4okaXGBurYetMsDKIDE0PwgXeOmV6xypHOgVup1/agmXLb2YeAR6dXz5lhAa6O2e+ctzGC5F/LsHKU9383+W1ADSlUONtVNX80ht2ViI8jzV4LpA6yTGTxFvq864iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fehQpOdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fehQpOdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DDA1F000C7;
	Thu, 15 Oct 2026 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092985;
	bh=v9hDISTkD44YeGplpGIGuc0gOeozoIU4hdy1VINfeOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fehQpOdxJ92zBZnAMvWcvMcU7Tk99+PiXNAJl37SR4ISj+meCRk80MOU2i0r1E0qY
	 idy0lVBW/b2B41jQJcKKPkFwYAss5swT9LHvgv+d8ea6MAPTYScFCxlYL2SCHyWDp2
	 reVokB79b4A8q/zBOkF2LqLHF9a8EGKMbqqgtKDjISrUKEA9PmIqgdA0OmBKGTwOV4
	 KVsNIGQTMVnAPwEyyS43RD1OnzzMZIiYnzbuOcsbJ/l+uck4z7i9Qqp3MgIdur2EpX
	 kEoiMYS3NBgZKkgS3v/jI+ySW6TI8CvtMp/Ig/AVbGjzx0NjhO+MZKhyouNnfO3u8x
	 /Q2O+Wr7utxHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	axboe@kernel.dk,
	cel@kernel.org,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	neil@brown.name,
	sagi@grimberg.me,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y 0/2] CVE-2025-38264: backport fix series
Date: Thu, 15 Oct 2026 15:35:47 -0400
Message-ID: <2026-10-15-1-daily-reply-0004-cve-2025-38264-nvme-tcp-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014191236.23696-1-artem@trailofbits.com>
References: <20261014191236.23696-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider this backport series for CVE-2025-38264 to 6.6.y.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
