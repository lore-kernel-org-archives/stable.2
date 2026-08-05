Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4E3EBF23
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919276; cv=none; b=i/tmcICkZVjFy5JwhljwpbBT/LBASMZBOOOOZX53u7ztCwW9/Kr/Iyr2Uh9ZrfmrpFL+HhikcI0IVB+jB357UOPRVVt5qmz9t/A1MU1mrJ8Xz5gZ0hBI5kQDxewmAsEpRNzDe9uHKN7yDKhXxTWpjnTs5+ufaGiGZQa7QJlRLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919276; c=relaxed/simple;
	bh=S38Ei+c21Lm+0Gv285ItkWpB1UcixQyvnhryTnK1jY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2l89aTvGPYCxL34R0yA36xDn0dL7atHylHQTwA3JyezRq+dj1wiUTJ1BiOBgS5tbUuRW1qBG7cx/UHvVgp8oPaPgRtA15sINPnrLFwZAWj2MNE/gpm3HDnQEDBrFOXFmDXtBtQtRzqZkA249+UFMOXponUJ5xM4KiE/DBBqol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PGeWpUZ+; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PGeWpUZ+"
Message-ID: <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785919271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRXZcIXeXDWkdhDpN3QIMXR/hfQIQzwwbsAJ/HYacrU=;
	b=PGeWpUZ+NvGD6QbTsGgBeXEekMXLTlL+cl4bodUSfPyUKfd0ZpmcC65uBGF59BBKl2DqcQ
	X1Q5TveqW4Uqb8ZV0V8yQfD+s/hOgUrH+eF1noLz3IEdzhdqBE0XEy/gaPGj57DJnvGN3I
	MRsFFObmkbldVSQ3TB2UVZ/c4fe7Rfk=
Date: Wed, 5 Aug 2026 10:40:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


> reg_defaults must be sorted by ascending register address as
> regcache_lookup_reg() locates the entries in it with bsearch(), see commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> These three tables have entries which are out of order, so the binary search
> does not find part of them.  For those registers regcache_reg_needs_sync()
> cannot compare the cached value against the default and reports that a sync
> is needed, so they are written to the device on every regcache_sync() even
> when they were never touched.
> 
> The patches only reorder the existing entries, the text of every entry is
> kept verbatim and no default value is changed.  Each table was verified by
> evaluating the register addresses and replaying lib/bsearch.c on them.
> 
> Entries not reachable by the binary search, per table:
> 
>   cs35l41_reg           2 (of 47)
>   cs35l45_defaults     36 (of 73)
>   cs4265_reg_defaults   3 (of 16)
> 
> For cs35l45 this is nearly half of the table: the DSP1_RX*_RATE and
> DSP1_TX*_RATE registers sit in the middle of it while their addresses are
> far above everything else, which cuts the search off from the whole
> 0x4c40 - 0xf010 range.
> 
> Found by an audit of all reg_defaults tables under sound/, the SoundWire
> codec drivers are fixed by a separate series.

Wow. Would it make sense to have a regmap helper to double-check the
addresses are indeed in-order in those reg_default tables?
I am not sure how this requirement can be enforced by just inspection, a
warning would help detect this sort of issues on more platforms.

