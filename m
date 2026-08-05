Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739B2D5412
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892423; cv=none; b=uzkmNzndRh/d5HfCSQmq4dNJRVJk381JzlED8MLQQuxHKMv9AdxsAs9T/W7Gg9kGW9zELaE6VivECxNF9H7m0gn+rWa1tVylgIo/1iE4rY0+3L72FzFmUwbeVzVg9vMpXzKbEUsT8gcDGot0a+xUxXMTK8CizAN03I2C17MnaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892423; c=relaxed/simple;
	bh=TYGF4E5a8KloDldl1Abpzw6AJ0Uxfcrxai13KetgFNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+36xwHD7nTvwMvXTnMqsa27wbBB1NF/xCopKNfnDSTwjemC9s48ocVxxEYc5TUNgZwacrrn2jBYAbYISHqOASeQANR4+GwWZMMWRZuzV3LWKvstFc1kSYbn+3khl97Pw/Qw4Asih6zYo8HmBmmeUAJP7fKfmOlzn7kyqtxC6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9fN3Z2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9fN3Z2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D11F00A3E;
	Wed,  5 Aug 2026 01:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892420;
	bh=ophNCEAH8HkzqHh4K1S2lbr8qTFnBvfsLNQ7+bgyOfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k9fN3Z2T8v1dcNO/jt+pf8kQFaDPEUAblqTl61w+eoMYwh+jMz60o5tRdK09q+Mb0
	 ekkZ84kHqIG84ZWeaaR3VGE9VfChpMH1Ct/W1U0pQ1ZPhR+EnJSBCa46+o9XFAgFot
	 wk5q5poEBGVCXV88hVkPb8ElN2eeOTlMD0k2YVzeQlo68rh/6pmQ2Ty2f0UGKXYQ2N
	 1nvN0Z/H5Z/1sm0HQxv5Ob31/0iT5uPPSQ/H4W2L9dy03gXlrClHH+3uXIRxLIIDov
	 hzxppvqRLZymchDfQwgT5Yxq7A/VWp6WTPGAA5IVKs1qwhWIMave2R2yq1XcM6cnL3
	 5XPd7XWxkU6NA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH 6.18.y 00/10] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Tue,  4 Aug 2026 21:13:28 -0400
Message-ID: <20260805011004.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
References: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 04:25:58PM -0700, Ashutosh Dixit wrote:
> Backport of the following series to Linux 6.18.y:
>
> https://lore.kernel.org/intel-xe/20260615224227.34880-1-ashutosh.dixit@intel.com/

Similar concerns as with the 7.1 backport...

-- 
Thanks,
Sasha
