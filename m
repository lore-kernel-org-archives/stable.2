Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D08E39FCD8
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548416; cv=none; b=GaL3adPwd0TgDsBcbT9+pVx3FIJVA0gaHDpWvhbKNPbrjVPjkp002wIyxkXG+IQPg802bmMsRu+8WIhw1CbAYFX0dBcjH6gF+63AFdk2/lBDgOc9rPjbIJgDurUJ4e/HTc92tn+iymcURUzdmfHnMJ/jbB+VVLIotc/wDoaluAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548416; c=relaxed/simple;
	bh=tcFhBJGiJajPsSgj2VxRS459OTKbduk6VEohEa+KMUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLdKjCM+j0nwTsfdtawef4USViN5xKbHJ2otvYaCuTt393X0pC+vqgUbU3/8ESEOoVa53j4ue2ORlm5cDAkw39XfmkC1op/goinbCsquguNuY22Q76YwVuOAAN8blo5DLsU46hxwEDt5HVROJjnTDt3NLT89qo5MqGGYCLEC+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkTwpyd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkTwpyd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F23E1F00ACF;
	Sat,  1 Aug 2026 01:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548415;
	bh=gWaPthQ0fxvyOxl5h1qFOezCmEDqtz3E7dZLS/kAqhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkTwpyd6pQnEPGNOUI4wti7ZplIeiiYaj1p/MAmrEw71X00mFm19hSusu6XMkqyxR
	 +XZ874aLKJ644zWBnSTrwTJnuyPwjAHf319hQgQopHUNjCrbj5kEPdeRpicE1YJy2c
	 yHohr2QDuu4RL3lzN0aB6FpZLSZTCokVK8Gb/OA/Y+zYTUyVGjcX/eB5495bi33atL
	 /OQey0iQkS2J3YwPEICQafoo8sxy9FtotpqEMpnL8mnN1lDwnPBkJJl9CKWsMnOPWF
	 wVsVFVrresDLm6xXefm/9DTZSDzSEMTNykoFUqhOi+MCpSFqvWdGXq1WKloUwz2N9C
	 Qo/CxLhI18q/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eddie Phillips <eddiephillips@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] gve: fix Rx queue stall on alloc failure
Date: Fri, 31 Jul 2026 21:40:04 -0400
Message-ID: <20260731211002.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731154449.2755799-1-eddiephillips@google.com>
References: <2026072934-rule-library-9954@gregkh> <20260731154449.2755799-1-eddiephillips@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 08:44:49AM -0700, Eddie Phillips wrote:
> (cherry picked from commit b65352a1bac64442ad95e64f385b40ccb9f1b0db)
> ---
>  drivers/net/ethernet/google/gve/gve.h | 2 ++
>  1 file changed, 2 insertions(+)

This 6.1.y version only contains the gve.h hunk: the <linux/timer.h>
include and the "struct timer_list starvation_timer" member. The
starvation timer callback, the timer_setup(), the mod_timer() threshold
check in gve_rx_post_buffers_dqo() and the timer_shutdown_sync() teardown
are all missing, so it applies cleanly but is a no-op that only adds a
dead struct member - the queue stall stays unfixed. (The new member is
also indented with spaces rather than a tab.) Could you send a v2 with
the complete backport?

While you're at it, could you send a 6.6.y backport too? 6.6 failed the
same way and still doesn't carry b65352a1bac6 ("gve: fix Rx queue stall
on alloc failure") at all. 6.6 and 6.1 have the same helpers as 5.15, so
the shape of your 5.15.y patch (timer_setup() in gve_rx_alloc_ring_dqo(),
timer_shutdown_sync() in gve_rx_free_ring_dqo() plus gve_remove_napi())
should carry over with little change.

Your 5.15.y patch itself looks good, but I'm holding it until the 6.6 and
6.1 backports are ready - otherwise the older tree ships the fix while
the newer ones stay broken. Once all three are in hand I'll queue them
together, newest tree first.

-- 
Thanks,
Sasha
