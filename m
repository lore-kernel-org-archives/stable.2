Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3C412280;
	Wed,  7 Oct 2026 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407059; cv=none; b=jNS0rgYyKCFuph4PdTshEjPUtVcWUI9N24zfiDCLVg+LcY7JOePwiBh056AwDDQUpF6XI9pPUF5hXhq2jBhtibtzZ4Ki2HzCzUYBHhqQsxNv6g0ItB2so29oJe/49kUPxT/HgPP2xE6JlcKjTHpbGQD4i1I3/GLpBBcwBZGPKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407059; c=relaxed/simple;
	bh=6rKYBbz0dXFLyL8zvM7RwRxovNu/dSGb4nNPeYx5b0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUPzA3EV25GU46PHBq77JlkU5dd9x6ZGkqv4D48PHVnD5jO8KIh8jthCNcEOTh+IEaCz1KqCPwt+8y9VOe65+hFNaA2T9ADf6Cg4FVDXp3rY+f8CCV7zzvjvwK2sr1zCYTeo7DuwIPbQhkolmc7liIELTWzbBuMnQImnM0tGjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCYUwdYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCYUwdYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00FD1F000FF;
	Wed,  7 Oct 2026 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407058;
	bh=fkc6izhgy4ZTy0BAbAAuoIWmFkGNAYTyEmilLG5+a5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCYUwdYDMsdohiQI4LmJf9wZdJNUwgYSQ/3j5JxJAz+JpIti2/eXtlb/wMiOV3xX3
	 Xw16WE+AU4RTX3mYA6vgrazJbJTPxuxkPYXVLpO5wt5y5M9+ui4FO9VPifTy1WskY4
	 sb6l08j0db29uRLw5cL2UhxFDt0F2CbGFIcH4kKCA+rVehqoOqYjHXgwK2S4RUWd0M
	 hMTSA1j7Auh4AdqmJALjSt335uU0neVcjYYZZdFk3tuH5CpzS68QQNKYDQ5+T4aYg3
	 koHM2ISgVZj/oqdkg3MbiYl1Q1CUSNS4Kqxz4rbt1MVceYgyvRTHCo5J8ylsFkQOyX
	 2LJlYATbpy61w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 6.6] fsverity: add dependency on 64K or smaller pages
Date: Wed,  7 Oct 2026 17:03:36 -0400
Message-ID: <2026-10-07-1-daily-reply-0019-fsverity-64k-pages-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006215002.53757-1-ebiggers@kernel.org>
References: <20261006215002.53757-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
