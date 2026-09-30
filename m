Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF003A2543;
	Wed, 30 Sep 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762890; cv=none; b=uHTcj0OWel4kJiBh5NZBFnjFda7jn3wmm4TAjfzRm81I/Ly4a/roc+uZb/B3Z3ZKz0efJwuSjl8X3fJs+AUIvwIlpuaGH+jYSbKOeXVVv/J1rQeVdYi1XLx2xUDSiuBC/8u+0Y8XYcTZzGrvdOEknngrL/iN/+dSc3f1DOFqOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762890; c=relaxed/simple;
	bh=EB1AQ+zaQ4k5N+uF2O+4pItQZHZPlxUMVV/eFUCV8ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8V/CR4V871JOS///slgNxaQ+8Igeds/QADbb8GdaJup/PSSJKY8IbpH/e1tpTXfqfkX0k+N+UcLsdfeZY7IfK/CgHDhtancTwgLoizKccoVbozUYEXa2f5Icb1HrzSLU2cGSTHRRmunVQYZ2TlUwZ4CHX7Ey3QkoT3bR/Rw5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbtWIhmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbtWIhmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E511F00893;
	Wed, 30 Sep 2026 10:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762888;
	bh=yfJmuDPdxNE8C+PExWsEviycxTomqp31EzyoEKfzxHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbtWIhmhnmrKsJcOYzIQb26rWfdnZFJY1Y/Ok3/rTHVPNHkZMH3ons1QSblsNzFq+
	 vcnhBWJOnEbwkGi3f1Kcqv7gs1ZXRHqed9edqUc8fM+8s5d+qXqG2ZVjSt/fAPg/0v
	 JSuIYA9AOtZL+HS63IQoT/51QLizRXUquFksQrolVT8uANc3/jwZJcV8bWaihkqmcN
	 jz/QExHdhuOB1mWCGZ0pBxAmjlicDzR+nl5Yj2fVzUxbT/qs/rCnzGVenejv1Ihqil
	 lHYywwYmdGEyfTDchcQKIqZZoHh7t8HLll3G4aLMuVJMVxQR2rGHeQP9U9CwrP0Kbh
	 vpttNzXVg//Gg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:08:04 -0700
Message-ID: <20260930100805.53503-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930093707.48739-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello stable team,


Please ignore this patch.  I made a mistake while backporting.  I will send v2.
Sashiko found the mistake.  Please refer to my reply [1] to Sashiko for more
details.

[1] https://lore.kernel.org/20260930100637.53340-1-sj@kernel.org


Thanks,
SJ

[...]
