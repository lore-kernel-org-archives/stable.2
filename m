Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9442ECD32;
	Sun, 18 Oct 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342458; cv=none; b=NaDs4fmbmzPHJUwCP3lzpa0vtGmyOKVqR49i7TWTqxcPRh6Aj9ElJxdhK3pSrgw8rzCoMXsO2uB8NFqw+SYHlh+jV88o+ktxZt9ELMZz14gK+soiptuiggWtyn7iSkg/ohsJWd2ePYX7dJMZLnFruQ53kQRSL5kdjv71MTKlNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342458; c=relaxed/simple;
	bh=4qLbczrQ8ECFoYsQQUuI+Bo0Osvq2lOXDHVkoYmJZ3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY5Gcfzm005f+u6wBPIwyivm6twQwq2pU+f4rKFgMNW2WtZKsLq/I1pm+SpJAMySjHlR8jpIga97NaPTN+2FVxl0CS7luVn9cpPOGnMxsfmYq4CTW2JsQKAbcyydQgHWX/5s96VNGzI92JkTYpgRfXJ+g3mX2PwOP1ZKdvMrKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTCttBtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTCttBtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FAB1F000C5;
	Sun, 18 Oct 2026 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792342457;
	bh=4qLbczrQ8ECFoYsQQUuI+Bo0Osvq2lOXDHVkoYmJZ3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HTCttBtd8x8SdZRYFlvRmM17jhS8ReOxGAUY2fVav0C/NjPajimZ2o2MUevagcTGY
	 WOhuOOYZBPsbAeRtzLc+vjkwgxzwAsJs9mHmKQj16+nC2OqWHGfIifgVzHT457IIym
	 d/SJG/1mjVzkcG6ny9g4fX83aPOY3F66bR3HnPZLrqK0DQToxQFAG0lZVefhebuO85
	 udTBb5L1JD1FXWm5qWQ0k5C67m/KKUnyBFWoM9/vtBfxifn7N9mS1i51ErMsjE3hhO
	 65MHG7QE06//b2R3XShzTMXVsoPgyyp4XVNvIbXCDosUoMpbLpo3GuLKoL30AzOWR5
	 ZMSXYX027UndQ==
Date: Sun, 18 Oct 2026 18:54:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Neil Brown <neil@brown.name>, Jan Kara <jack@suse.cz>, 
	fuse-devel@lists.linux.dev, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/4] namei: check for names that lost their mounts in
 every refwalk
Message-ID: <20261018-matschen-sinnkrise-dissonanz-3c5ad668e18e@brauner>
References: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>

Discard this series. This is a whole class of bugs and I hope to have
something we can discuss soon. So please don't anyone waste time on
this.

I'm back from vacation on the upcoming Wednesday so give me a few more
days to keep pretending that I've never learned about this bug class.
