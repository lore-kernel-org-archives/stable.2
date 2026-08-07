Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C663E9F8D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094437; cv=none; b=N29Z7qi1XtrO95bohcBR1vJQAt+I5WwJM8Q8vdUosLzua6ToB/A9DA4RKctPvcvU5MPlBjLsjV8hRWXwulXdFZnk/JhjJNpAVmW11MAwHsQCNNSUj6MNkInCUR/7HgKj5mPkXHOl0LUJp9M/+YOkpwMdGGlA+cQNX/kLf/7Cl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094437; c=relaxed/simple;
	bh=BvB6o3HJh9ppFH6/6v5d+8ZnIfpEuTlcmekwzBOaph4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqdenoCT2LcmWIYltwWvIF2xnTDSVSbskV1o5MNXTpdWvyZwPGI9QAj1JQdwI9gUtDoWmN0j38KiAIjB42x9bdptRtMMCLhI6Jby1aAM6D307r6hUIP9g8xXVNBHFHKlRK/9QBcAlwdBt2vR4f8ujk49Pj9kcS8wL+BkFatjzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=boDauy8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="boDauy8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B6A1F000E9;
	Fri,  7 Aug 2026 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786094434;
	bh=Jn+fiI9qmYUQjFZpzjR7v8a31r2Lb/Xd14bKyYsHu9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=boDauy8KYulJNR81WiYKgIA86Tp7nsjT7KTsnzGIiay5RmkWKEI6iYogt7ZaV6CYe
	 GqJvnT+MhSZOe+erce3CR1Y7luVIRcaEjvbADGlNncVngU5m81plYQx9QXanLN79of
	 c8xgPIQGKNp1qPG0oGPby/cYfFnGG1uPL6JbHwT8=
Date: Fri, 7 Aug 2026 11:20:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Leo Li <sunpeng.li@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	David Weber <weber.aulendorf@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before
 programming
Message-ID: <2026080707-deem-ascend-927c@gregkh>
References: <20260805163314.214623-1-sunpeng.li@amd.com>
 <20260806021809.0021-sashal@kernel.org>
 <ac4c0e75-fbaf-4264-8794-d3f86eebb014@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4c0e75-fbaf-4264-8794-d3f86eebb014@amd.com>

On Thu, Aug 06, 2026 at 09:42:42AM -0400, Leo Li wrote:
> 
> 
> On 2026-08-06 07:36, Sasha Levin wrote:
> > This doesn't apply cleanly to 7.1?
> > 
> 
> Hi Sasha,
> 
> Looks like the tagged "Fixes:" hasn't landed in 7.1 yet. This patch depends on it.
> See the 7.1 backport of it here: https://lore.kernel.org/stable/3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com/

So what are we supposed to do here?
