Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57633D88F7
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701647; cv=none; b=tX8590K7712vCJsRXcHkTpq9Hpy+eGy20WMIBP4yMOAlnv903k5NPlxIas2E2BqO08mkp0tR9Gf0+z7bxuZX6v0V9yrkSTzv0LGn/T6gNzOs4PWvHaG1EX1oIXc0vI9gyFkIKoE3bDOa08a5JHajojC96Sun6U5tflkPmdfr0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701647; c=relaxed/simple;
	bh=0HG7ourKK4jglRRHt4vurckh0f68eoCMTT1Pl23DgLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCu/pVB7e1gXc2+mw9ru3VunBN7UOpozbIjnSyR1XHB6tjqdBf1KwIcb8POLXCxkk1oJwhh/SGg+u3FugapjEHFFJlIfcquFOsyRUOcWik7u3SYAAwV+ZcAJVLb03niyjiBzw4flaAzxORMAWwFtdY1s8qqKrHnkPkcBMJbg8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3/fxyUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3/fxyUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A541F00A3F;
	Sun,  6 Sep 2026 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701644;
	bh=/FHxKfMM1OnUAH2sCAzMoXpc3/NPV2ODTXgrXnn7eEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3/fxyUeeRmzkGDw97SWcldZQcFZsDG+FxQStsKTB2F9PxiysiZeeO7Epeu4T/7/u
	 zu6pguVYIsWIeuQHYBfRFMiTo0iywvwWAyuB/Xro8pcLaNkpUfh5/kM5LSLEQnCb5Q
	 cWh6642/KJUzTksHn7V7mmjvBobpA9yyvDfLFWAjlYWe9Pu9oM73W3arPp313B8s9z
	 bQk2hTDFihdIaZZ7r4VGRpQQZqdyTeIn+LKpRRg0ywcYWbfzcV3TxqhU7X/0KfXLCd
	 7nEa2iKbR97qGpLECd2xus8NwkPDB/G8uE4MpSNvVXv4jkzRU7EU0zyHqvEAZ3wP/u
	 9xupp2RNNZMJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 5.15.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 09:33:10 -0400
Message-ID: <2026-09-05-daily-reply-0040-fsnotify-stale-mask-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905025913.4000679-1-yjkwon0026@snu.ac.kr>
References: <20260905025913.4000679-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains that
> bit. This is racy with a recalculation triggered by a concurrent update to
> another mark on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
