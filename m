Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D7451999;
	Wed,  9 Sep 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991246; cv=none; b=Y7xRfU3ozZqrCe0y7fyMNNbh4tPVWSurjwHWgHCIGj2pkl1DP6ljFvW+JzBgP3jLcRYiph/VXnyMmnrHQyE5W3CcV/7NqIx2rc0YV5d3ZWzhAY6yd4tmmYGQ+hmev5lv+Kv0KWn0W1ikIKm0jw7jo9GiB6UO0UjFTo5cgMeHeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991246; c=relaxed/simple;
	bh=SVjowzvysgbzFGKCAu9gur7dhmuKcNdY1DrOro+kV/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfFbAq24XJsl+CmLysTzXB/KzZ5HmvimBXc/znx8rmkBvn2DpLHkQTwZjNTYe75f0lSAo7d5WuLpIAXDb50KofKQo1VRPJA2hP1a9PaEronqP5wG/WuxxfUQ8PQdLi9ZOSTQzkBq4LymLRH1+9Iyqco9CZwlg8ZU/XI6gsWrlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFs5PaMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFs5PaMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287031F000FF;
	Wed,  9 Sep 2026 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788991236;
	bh=SVjowzvysgbzFGKCAu9gur7dhmuKcNdY1DrOro+kV/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nFs5PaMr1BgN/l02sYSoAu7mqC2Jk+gJoNer+9EuINIEOy4ARu7hXlFcGB1c4s1cD
	 EjQcEDHv2AMAF2RSXt7oz3beX1+DvMAJdgyrHHeljP0LsTNl286UnSoV8AY+gqIu50
	 88vU41bFvqItBmw/XN2QE198bGb2LGCzPCvDD0R89WuDmb3NkJjHnzQ8CmNEWy0K4p
	 3f8642ca6YjrZwZX1IbJk7Bc90S7u7tI1Bk1k9KLHo9lYzDQd36q2mQjrtVSFKN6B3
	 uzmXMsjYgmrb16ThIkdSBDb0snvLlZ5gZ/hNdU5ERHe8k1vPjY11JEVCzZCCt7/Am9
	 35YbY+EGlsoCQ==
Date: Thu, 10 Sep 2026 00:00:21 +0200
From: Daniel Gomez <da.gomez@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] module: fix lost error code from codetag_load_module()
Message-ID: <20260909234838.3-da.gomez@kernel.org>
In-Reply-To: <9acf2cd9-b808-42f0-bc86-7ffcaac965a0@linux.dev>
References: <20260827030503.49171-1-hao.ge@linux.dev> <20260907213815.0-da.gomez@kernel.org> <9acf2cd9-b808-42f0-bc86-7ffcaac965a0@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird

On 2026-09-08T17:50:33+08:00, Hao Ge <hao.ge@linux.dev> wrote:
> On 2026/9/8 03:42, Daniel Gomez wrote:

> I skipped it because alloc_tag is the only codetag type and it
> already cleans up after itself.
>
> With a second codetag type the problem Sashiko reported could indeed
> be triggered.
>
> My thinking at the time was to do it in codetag itself, as a separate patch,
> since it feels odd to unload something whose load just failed.

Then, why returning an error at all? I don't see why not doing it inside
codetag itself wouldn't work but it's a "bigger" change. IMO, the error
is supposed to be handled at load_module() then, the unwinding as the
rest.


