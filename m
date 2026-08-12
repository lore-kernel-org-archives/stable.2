Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F54334C9;
	Wed, 12 Aug 2026 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535090; cv=none; b=pwpWVaxHwzA/jvuAkZDgPDE2bDiu+Vn01BNW1FUC9ke5xLSxlU3zp6npatVvFX/ozInEWIR2/FpxEhvUc/EIZazvXRhMrxja2Gp7wThLT369u5qF2hgooVzgE8p3uVAz9g7nGfRPKMhWmufB2sFLRI4pQnW4Az35xjJmegPwkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535090; c=relaxed/simple;
	bh=Xui0thvrSsf/DP04G6Cml9vYoxIel2q7QTyd4BWoD50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJcWkH9hTX+KhatPTLeO7/L72tMdzHgUcoL26xtWU+PKPFrKX4efAgvK3hY2W/GWMLLbaMkWvBqrymu5nKbomOcPCXO6urPo6eSScPZ2ka7eW4qsFmyyxZOtYKGPiHMNyP1/5TuVgu09e6f7nuySMhXDqDsN3qm5fY/i7BHkb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqYfzdrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqYfzdrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074C81F000E9;
	Wed, 12 Aug 2026 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786535088;
	bh=Xui0thvrSsf/DP04G6Cml9vYoxIel2q7QTyd4BWoD50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqYfzdrwIlOzaHnE4vjDsH4LiIIwiCG6wR6w1Hooj3DuiXrgDb6I1+vQU3k5muXvF
	 A6JHy4M9eTELLFXbZuWCbxrpa0bwEQlWnUiAHEdn6VPaphc4nHzZ0gPdHBqIqgxfZP
	 TUqP1PMEW5VnHJLYfG9zo1oDiwq++Va21tOa2Q36didd4sRof4SsjeovUpD8p82ODr
	 qg5rDs1CILV1r0NvQsGS4A7/ivuDgBwICqWJTl1z0lte8KSAY6Y+tkZ0B3QDoYj3Dl
	 I+OtmpCuGaEuQJ25YPWFSCE2mzF5YDblha8MhRIaqZETTb5L58jy0DJeLkbsaUzbI/
	 CozWopob8MxyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: Patch "btrfs: move large data folios out of experimental features" has been added to the 7.1-stable tree
Date: Wed, 12 Aug 2026 07:44:44 -0400
Message-ID: <20260812112910.GA1148372@sashal-kernel>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b4749071-b0f9-475f-83e6-13153ab20b13@suse.com>
References: <20260812000703.4150441-1-sashal@kernel.org> <b4749071-b0f9-475f-83e6-13153ab20b13@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Aug 12, 2026 at 10:13:09AM +0930, Qu Wenruo wrote:
> Please don't merge this new feature into any stable tree.
>
> This feature is not compatible with the COW fixup mechanism in old kernels.

Dropped from the 7.1 and 6.18 queues, thanks.

--
Thanks,
Sasha
