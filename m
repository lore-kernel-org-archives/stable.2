Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF430B525
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252280; cv=none; b=kPYBewdBffbq2rEcAyVJW95WnF7l6dBiPZK/PObwKzIpHUqQUg+/dVagkVxVj0m0JIcQYf80XkYKUwCsCC1GwVghHNuif5R/b1RKqG9Ba9kxUHTXifok2ot+XwRMePP8JILUiIzzHARuWacstTxzEb3wkoepoFf6mtoVdnvbIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252280; c=relaxed/simple;
	bh=GHlxhrA5kT49zgEW2z/M0n0oAsDdrFoan0qGYHzJqvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTXD6zg+ME5O6Qasi67/XBMcb9ZAeuGfznicbqNyGf9/s4j29lNgc6vHbEd1UjsSl9V0LGrXyXMQKO8FNm5Xal9BJuw5mHEYGKHBxclfkDS8D7VjDLSwlgGn3+j/yHyfvFmGiil5hKXNUmzZiOb/oMDaxpmw01QsmIUm81cBqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWENR13P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWENR13P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5F11F00A3A;
	Fri, 17 Jul 2026 01:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252279;
	bh=kpXQ5jKkX3/ZKJb1q79DI8wzOiXSEgLcgv4Kvzoh9CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWENR13PKOof0SWKhuotlES1y76Fkku4i8KnkOhMYXCJq+J1FAWIqpHGR+Tosr1S7
	 l1z0fecVtvD5hVfF/kidr5llFCajN7JW2SdBTMLkh9aLAVcwD8ZWm4qrzw+cmMctCP
	 odFr/CaF2NZlEdb0+4nZq7zKyOSIK5aFcCMVzFaAbIGGq/itoXmIqpSs2YdY9w8VlH
	 jzhfAaudvx9q+l5YREDfj8oTWueMiXi0MZqZO5NVQTOSthU8WXRv1tR97POl8PCwfe
	 W+5RZODr708FFVSXSeJdApRAhPiZDJC8881qMEUeBAr1V9khmKPMWEhni9aO+r4cf+
	 oycKTraySdQqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shashank A P <shashank.ap@samsung.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 6.1.y] fs: quota: create dedicated workqueue for quota_release_work
Date: Thu, 16 Jul 2026 21:37:37 -0400
Message-ID: <20260716232340.0012-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715125138.668-1-shashank.ap@samsung.com>
References: <20260715125138.668-1-shashank.ap@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 06:21:37PM +0530, Shashank A P wrote:
> This issue occurs when writeback is triggered due to sync call for an
> opened file(ie, writeback reason is WB_REASON_SYNC). When f2fs balance
> is needed at sync path, flush for quota_release_work is triggered.
> By default quota_release_work is queued to "events_unbound" queue which
> does not have WQ_MEM_RECLAIM flag. During f2fs balance "writeback"
> workqueue tries to flush quota_release_work causing kernel panic due to
> MEM_RECLAIM flag mismatch errors.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
