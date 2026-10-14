Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE63563FA9
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996813; cv=none; b=e34mynJ9K+tUz6kyo9fHv+bGbPRSKKWkZe4CG0hbBJQdNM1ahtSQil25C+fkicDCyAAdm2R8dmEg8M/o5666UBolmOftvZVmkapuTTNGYeWRUHpgnB+DMvX7TnQC5RvSRovneN4HRYl+6iNmaKbZmx7B4OlF/7dJrEgFhm7LALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996813; c=relaxed/simple;
	bh=90ULz6Jc+6CPxNa1+sqnAuOPZC4Ld8RyStb9nXcghKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ7jCSRQafig4obvxwWHwW1zcMibpOLJn11GfOkFMmB2Lu7OZQmcLx/EU5jH7XEiJjpKw1ocrlAYv31uw6vi3vvJTFV3SUD7QpOVl+sxHYJRusmBPg38cgp7szqTP7FL3qru6EX+nF5EVA8enR/L3kmlsyP1tT70aw8UghqEvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofUq72C6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofUq72C6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1511F000C6;
	Wed, 14 Oct 2026 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996812;
	bh=Ui/dXR7XKbCgEMM2uXOOSrt52uWIYip9y6DHtenDK4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofUq72C65xozNWYM3S+9LUCFVUFtOJ2CfP1PiG2X8evnaEQD4XVZ/GV7CTu53UwtJ
	 95kwL40qK/tndbM0xt8WmuE7Wy8IIoxPlRwBt0LPx7uOW7OdjrDZdVX/fOcjllSSTJ
	 DGc0Ywgk9KLjqO80Z/GmJi5iGI5yd8R8WNWhHKZ4QemhKavwnJfEjzKo4si65FRnpr
	 sJWEotI0e+yJhOqRinlR4Aj7eSWWE0BPffAf8O+f58aIKIdrxYcAfxR83lQAJVzDU/
	 C/sZn+6mJIqC7hI4/fFqiQ3OOLKqP3LIRbrCqXrSgtAsdaGwgKa/oED8ULwX+QAK5a
	 G4q6q2YTHkTGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Wed, 14 Oct 2026 12:53:14 -0400
Message-ID: <2026-10-14-1-daily-reply-0011-mremap-dontunmap-self-merge-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013164837.2509912-1-ljs@kernel.org>
References: <20261013164837.2509912-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix another of these - self-merge.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
