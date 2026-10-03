Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC233AA4ED;
	Sat,  3 Oct 2026 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067109; cv=none; b=M/4+7TV2v3K98x6ZW99b/e5ExAuvavGYZKo8+rFd8LgRuShoGKog5YAzdynwkESUJcZV15YMyrTAjh4IVfmNREAwRa838LVQSYZPVSSTU0AALH/LCQnDoM5ye57zHfoWXzio7ed6D85DD873t3rHLeBz5f8nLF6dwCczIJSXTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067109; c=relaxed/simple;
	bh=o20m/vyLvkXEGNSlwwMMZKwfDndAVHkNEjS3Kq+NVNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGGQiUHMRdkfbKZ4QXTwGtpCVBfvxmS3JamGpkrW//jixy084ziLsTOjtJL/ODpZUwxuxlHebkuDPI6n3etka3ezAOlFHr75PbSv3JLKzeBaxMcRYYvQIDUEcm3gtjSoz0FrkDd1ag/nw2PbXMXZP/QIsae40m81ZJu7d9Lr5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BThYNJj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BThYNJj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0319B1F0089B;
	Sat,  3 Oct 2026 22:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067108;
	bh=PYWK/vh7WiCukWTrYPPqGU7WnxK7cVjDRNd8vW5QqG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BThYNJj3zLI77GsJXXRNPd0ok6hUjbYgkCwBmnkNnfCAfj8IMCrndxH6sSspNQcwz
	 DZ2jD51R6ZIiMXp8jZvpCjrtA8DXGA9hRm/hid7LhhqRkylEC9mzNb+wLXmPyQ5Wmd
	 mttzWS8lkDHhL63NYG48I5VoqG87pkmHER38RbNl/GkUBwF5NyhJg0UCaCmD5r8VX8
	 X4NzPf7GxzJXGq8hhp1O+NMlTABeMKbJeiLyOxqRYKYl1DMp7atXeXjDMD5HsjraP1
	 RyJqTTVhyElmDlaKf9RPjVv4PQeMs+syQ8FqykNcdQAWdgkujR+YJdDmjM837JZ9jn
	 fw0ds2k1FAFbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 6.1.y 0/2] drm/i915/hdcp: guard both capability checks
Date: Sat,  3 Oct 2026 18:33:02 -0400
Message-ID: <2026-10-03-1-daily-reply-0021-re-i915-hdcp-both-capability-checks-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194030.20489-1-artem@trailofbits.com>
References: <20261002194030.20489-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> already present in 6.12.y, 6.18.y, and 7.2.y. Could you please queue both
> patches for 6.1.y?

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
