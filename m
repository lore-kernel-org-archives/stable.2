Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437947;
	b=bITg6wCFR4UWobO7oigQYf8gVbPy/jMNyv4NeqA4ii3Kon5Nh6LgGJixYEpB4rBk/Tdm
	 rc0EjgQZuWRV8BNL7SPVTUPHtE8Au9Q/x5t9RgDiLCFb1JukxCLatfDzlv5dDTVtlxFU7
	 C6iCmMoLAvlzz/MvP2JX78GsM+HZe9b9HpxUAeGVF2pEcWBPqQ9I04GWn+zyy0P+WIxZy
	 TKQzZzt4vNyfmIXSVGgwg2fx6Wc/W5npWl4LoKblS/jGvsGBXhEnKcPuADw/9K7GxSqHf
	 mNN3WfutQ3uDPL3eoYi2fb55DdzTN0YZTAnynBMyrVW9xHswsS5mDiYyxDwkX2b6FCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437947;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8pi+GEizZ25vQvYlXU931oh5eYpGef8Tt6aKx91WXGE=;
	b=P0MLalPQ+kRWGeD6QM/DKgpBf1e1OJKXCGzh4aO2ft1swMRHE5ay4W5X0Yxp8I2lDbfO
	 vXlPxfbIka+PwbTUA/qGwAx0VWXKSUgPiSCrKmFfAy6eKViFwBDrpXqL/3Y7QeJBl44j3
	 fpTCcS0bVmEd7359vng8KNVTb+uvWNXnBiIEmZy1CSyZZomNJfxL3vS3UPOBt5kzM8VkA
	 Z/lfXjliD9emhY22Uc5JVD/ECQfHcxfT52fIA9lrcEYtUPA5+Wnd2ynxoKpTL3BR/eqOQ
	 gm7ebfS8erOthrf9T/MerXDcPbi8SE78rGJrkUPq9z8ttTonpAARpBxYxkwaXfqGBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdWvgWyc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00C606A31E;
	Mon, 19 Oct 2026 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdWvgWyc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A477A1F000C5;
	Mon, 19 Oct 2026 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437947;
	bh=8pi+GEizZ25vQvYlXU931oh5eYpGef8Tt6aKx91WXGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DdWvgWycvbKAUvuYBSqamNrvOuWyarf4oAwfsizEh+AFNwcYoOQYPI6ZTThZCuDAe
	 PGYS2S/H63I4Z55wL2R8dpwi/yPasC6Re5Q8WEwOUvqb/dOibUnmyQBZZ3QHkvb6YY
	 pXDzGlpY1Zzx8/Fo2G2jZhpPfm9UF9/LPWePUVS4ZkrVRDKXVu5yE52+ak9Y014H43
	 wtY8NkSq01flduDw8Q0sNCdaaJLD8Y+9lHYSqmWadwIqSVv6fiOVYn3/hRwzU4aRhv
	 hlNCawV8kYJ3QwzBLuU70hTVOfrZ4SonAiWB6jwxXgFs8FZGnyc/aKwHDoJda5QLOa
	 jBrYmyRycZ1IQ==
Date: Mon, 19 Oct 2026 12:25:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: Prevent overflow of quota in key_alloc()
Message-ID: <20261019192545.GD65095@quark>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-5-jarkko@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019181732.449591-5-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 09:17:24PM +0300, Jarkko Sakkinen wrote:
> Check that the calculated quota length does not go over INT_MAX.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Seems this should be merged into patch 3?

Also is this reachable?  I.e. do any of the key types actually specify
def_datalen > INT_MAX - KEY_MAX_DESC_SIZE + 1?

- Eric
