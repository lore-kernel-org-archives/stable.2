Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA271CAA78
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761208; cv=none; b=CXbLoLJEjTLiKjf0qpLQ1NQ4xchfxgG0kBu8uNslZyiO04aZGUxX+eNBqJzx8QOB18N1P/JFOkqCAO4gBoCFkV8gH+LwL8/xMGyub1uFrIk5H6NfyV8NXOGl33ed7yEp8wJFChO3lc3JAN0aNGTq8GBJadXgsfZkKAPDf1oExM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761208; c=relaxed/simple;
	bh=WGLxPf9BXRWg13VJF+sVptCI7iK+FyeuVOfa42Ocqzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2hUVLV+PW7js8ROnpgHyGsFblxvZegNZgA+YFNiwyBuJgdUiQ7J3kCqjZirdBVWAxqPe+SrjCVL+AC9ohBOwEJRpXJyLOV7JbjpAGwdjlyezzyOwaqJeqcHS93Oagr8CuRS4BA65RXMeAqJ/qRV7y/+f9jaQ54DBm0zTXjBPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7pSDBhD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7pSDBhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A47B1F000E9;
	Sat, 15 Aug 2026 02:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761207;
	bh=bmDzxUx12ZCp2kzKjcEA2gqeYBb10jFhqZnk6fSpmMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D7pSDBhDmFY7cTXFWYg2Mcpuw+DibHa93gJMlfGzLy2klc9yGs8Le/mzYEbtWB1IL
	 wlGcKcq7OmHthF8m80HfmXLhwhgotuAaZo7PPtx5rA5ck3ttg3GWaQYDdwC+zoASdc
	 /DFCBHqPUFWQZz//3KX/9So77RHJ/w6P7qD2GCJbYXzIKFIJnMK6knbDkcnqrwzxu8
	 Fcj6qYbslkh2Z5HCSlX0JLWJ9D8ce07HphzPIdsmYtEtxFaD4YplrOAgft9GfLFlHZ
	 8qeJPctlS4Qu8uy7ScsZBRA52nVNgMrX3Wr6QbewUBI9r4ZYpgz/J+mA70ZUEwkvwt
	 j72ASf/kV+jfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Fix backlight max_brightness to match exported range"
Date: Fri, 14 Aug 2026 22:33:01 -0400
Message-ID: <20260814193000.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812144901.2154412-1-alexander.deucher@amd.com>
References: <20260812144901.2154412-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This reverts commit 1191285ecb4233e5bf907da7e9394d7999055566.
>
> This patch is apparently missing a dependency from 7.2 as users have not
> reported any regressions with 7.2-rc, but there are regressions on 7.1.

Queued for 7.1 and 6.18, thanks.

-- 
Thanks,
Sasha
