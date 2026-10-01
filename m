Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967651813C;
	Thu,  1 Oct 2026 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862766; cv=none; b=iBf7tvtS/rsmVIwcIaCTi2idLlbHDZ5Zfke/z56Ngy5O1wqBOPpA+l6qqSLbZtBAyB5Yk758nopW9qDJLexhIvETJYyKaRWCbC6VpeRM2NTq3eIGF2RKu/R24FyyBDCYvbPy2VpNlZ66gt75PA5+Un/EDTuqeutbOFjsKOfmj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862766; c=relaxed/simple;
	bh=oGaivbGGpG8cMMyYOZHrwB0ssaCeaq7Ef4nQqVCKkUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECw80E5swAgxnynwwJy4NiYZo8T+m9i7Yfk1o1cgZiL3pB9ATGjsZybWBNoI5vHunmi3pbmIkaFBFAvt9g+AOLBXUv3qHtQsPO/5yPbIZm6DFG6hpOeprDEJPsvdv7L83EPDNAHXDnoAsXFb7y0A8Zd/HMPxC7WEy/WbjITYnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM8eYvA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM8eYvA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597AE1F0089E;
	Thu,  1 Oct 2026 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862760;
	bh=2UQ2d/eInSoNKLD1if8zl9YzeL4EqylpYk3DXqsT4nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KM8eYvA9iOpKBwcdiqGAuA7c4z4xoT7RY8Krsxs7w834zArwmDZEfml+LRp8H5aKu
	 livxL/Cc1VD9qNiDb7nXMd7ge8A85zYZPSSOo+yEc5aO37cy0X6nsaZFNU2x+OcU02
	 wPa7inx/hrkEp/QYrkC+D47UrPdL9YxkhlRTJRf2ORilxI0rll0HaY6QB1GgP8o4Mi
	 lMJNaqMNsF3IOG2XagQl4dqHkMR//biy3zsbQ8p+Cb44vvL1faIg+O+dTXL0KS3zEP
	 ozlCdH/zV+UO8uirQNAMmD/IYvT2CSR4Pb49jG4k009KOkAiFJhhsqPLLZvCi9Voec
	 /y/mPJEot3hGA==
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
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y v2 0/2] drm/i915/hdcp: guard both capability checks
Date: Thu,  1 Oct 2026 09:52:14 -0400
Message-ID: <2026-09-30-1-daily-reply-0010-i915-hdcp-both-capability-checks-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930010323.93999-1-artem@trailofbits.com>
References: <20260930010323.93999-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Together, the two patches make both debugfs capability checks return
> false before converting the missing encoder to a digital port.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
