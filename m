Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451263E5574
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186569; cv=none; b=E2jE7D47Js0shB46QsfXR/cdfXKhaYGSH4+Ow4eGNVOAM23pPvAWqmwycqpH2VcKbm0UGUeaK5hahE1E83MudSlbetbt5SJPNhD2jHF0oi3FuVq12c3PBXalv97yQa+Yuc43Ea+hC0iBYxUHwRfSP7H6FKRYgsOby3r+9xwETTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186569; c=relaxed/simple;
	bh=bk5J2/1//KFgntazjs0qFQcIrr/IM1cHvQ/frwpKyTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUvUjPMR6oCoVowg3weMQUwuc9ArLMmsQDdsIMP6Yt7D/ZDSGVWzBmgcFO869Y4+GHjSCHRxfuwDgNcOPau90xREXHm12Rwhl3s38Gk0OjMvCXXOCL83w9Yg76wm6X3EDwehszUXZjrU7OuYl76pe6Pkw4A17Q95a3eKrJDaLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxG2TkVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxG2TkVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABB91F000E9;
	Mon, 27 Jul 2026 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186567;
	bh=A1pJKlqexMb0DOjMJjYj4PGZOgmcClxNQ5BnFJCIfbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DxG2TkVA91smmGLDRuxJI5Bi//J6+u9Vae1Dtq6Uk2hY0y6tm1EQTGX43hW9PBnRy
	 1EQnueAkBKY7vTjVyaPAMgqTiNB3s7gvnfPs5LbCIMJBhei4ci1Mguq+fK6KztIRJB
	 Ch1u0sV997cndKpRIq006d8j4oUZJlOM/h7F4ePvjQ7//IPOnSPxXf9ET9SuCJ0os4
	 6wRYnePP1OD8yZb4rClZZPUoJ9DheY63tCcBRoMmLM13Dzcuu6s9ulitLQ16HV63BZ
	 3XXkKvkkb8ZdQL2CBlfFUW5GqUClAv8tbxY6zi/FqhlZc9cHvcPZSL/ylFUypVRrSi
	 0V0BKoKrv2ocA==
Date: Mon, 27 Jul 2026 21:09:26 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 6.18.y 1/4] dm-verity-fec: fix the size of
 dm_verity_fec_io::erasures
Message-ID: <20260727210926.GE1021387@google.com>
References: <2026072004-monitor-wolf-7764@gregkh>
 <20260727210011.1929439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727210011.1929439-1-sashal@kernel.org>

On Mon, Jul 27, 2026 at 05:00:08PM -0400, Sasha Levin wrote:
> From: Eric Biggers <ebiggers@kernel.org>
> 
> [ Upstream commit a7fca324d7d90f7b139d4d32747c83a629fdb446 ]
> 
> At most 25 entries in dm_verity_fec_io::erasures are used: the maximum
> number of FEC roots plus one.  Therefore, set the array size
> accordingly.  This reduces the size of dm_verity_fec_io by 912 bytes.
> 
> Note: a later commit introduces a constant DM_VERITY_FEC_MAX_ROOTS,
> which allows the size to be more clearly expressed as
> DM_VERITY_FEC_MAX_ROOTS + 1.  This commit just fixes the size first.
> 
> Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Stable-dep-of: 31d6e6c0ba8d ("dm-verity: fix buffer overflow in FEC calculation")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

1. Missing cover letter.

2. I was only sent patches 1-3 of 4.

3. Missing Cc to the subsystem mailing list.  Needed since these aren't
   clean cherry-picks.

4. These backports seem to have unnecessary differences from the
   upstream commits.  DM_VERITY_FEC_MAX_ROOTS in added in the first
   commit, but upstream it was added in the third one.

- Eric
