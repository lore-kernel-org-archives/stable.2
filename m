Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8F1B4F09;
	Fri, 16 Oct 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144086; cv=none; b=HLi8I7yNdLCpiEpEWLuCFUIGaNutk5sNVpG5JuDP4YPir6KdJyL70I56M7Tu+ds4VdRs8UBNpAfQGR8ehgjP4Vvo0NVlbBbOWZUDvBQLKyG/VS8aofDEcZKxaAt89RophsinMWht14lZiko2cY5iQ5APTR+wZWu4zxpT2IvoDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144086; c=relaxed/simple;
	bh=k9Y5JKDvBVKJvtXWY76PAGtEovJtmZ2GwhUt1mLQej4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CHgxN7p6gjVC2OdTkEdBcw6fHchRRT665W21XmyOqSW0fAVk9uPOxeBvKyRU+z0d9qFXj9ihXka7X3aj0qx2sGPa39/spz9zyg6Bk8hP+XK9vWHh7kMwf9wcmFTJNs2R0Z62P+nHyNATGfh8bIy/pAdUubfVvGH/OqJPULfCpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJGiunpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJGiunpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5B01F000C4;
	Fri, 16 Oct 2026 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144084;
	bh=DfKCs1jLaEWIJQczKswUu6B1cbjqb3N1+xahrueGAaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=iJGiunpIwmsCpW/m778emXcxvfJZtxmZN9YLYkCLJ+XNjMRmIemO2FzNpoYcSKYFk
	 mnhu+GcTDhXPGXD28Fnen7Oc38461PlmzXRWBg449YG+rdZV5MxlZmJiIvp0k7pDP+
	 +iEpr6TynuTDf+D5EZ3n44p4gw0wvDbzqMgzsN0yIZLDFK9FtUqhXaNiHl8DLydc/g
	 QOspSoSZrfXPoG5NAdX6C1+D3RM8PN8AuCozfivmFGcreEJxvF2oYEwPsnbDuB/ftT
	 V+kvx6GH0OCj3MO8WNVNyqtdc3N5hqpt9dKOoxEsP/zYXcq46M6jrOSlaey526KtN3
	 9UrUvK4VX+Mjg==
Date: Fri, 16 Oct 2026 11:48:02 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
cc: Rishi Gupta <gupt21@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] HID: mcp2221: always initialize and cancel init_work
In-Reply-To: <20261002214416.459795-1-mhun512@gmail.com>
Message-ID: <q1454n3r-2o8r-q4pq-qp61-6ss8963201rs@xreary.bet>
References: <20261002214416.459795-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Oct 2026, Myeonghun Pak wrote:

> The writable gpio_mode_enforce parameter can change between probe and
> remove.
> 
> If it changes from false to true after probe, remove skips cancellation
> of init_work. Pending or running work can then access devm-managed
> driver state after teardown. Changing it from true to false can make
> remove cancel an uninitialized delayed work item.
> 
> Initialize init_work whenever IIO is reachable and cancel it
> unconditionally on remove. Keep the parameter check only for scheduling
> the initialization.
> 
> The false-to-true cancellation gap was previously reported by Sashiko.
> We also encountered this issue during our static-analysis research.
> 
> Fixes: 200e6c6e94fa ("HID: mcp2221: Add module parameter to enfoce GPIO mode")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-input/20260715143415.916A21F00A3A@smtp.kernel.org/
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

