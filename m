Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DA35DA78
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774733; cv=none; b=OeiEEkOmFJpFLIKzDJJ50VQ/29aqc+UaA9kCjikBXfUp+8MTH7jlCMuUCh1hDUnjk78G6k5t8MCMse31k28W+fyPXN/0jpf5jEfhQWz7WhQJohq1pmIen85koweva204CN0I7Ofmv/LQ381sLheiyxxZwAHe3vj46xSXj/aOsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774733; c=relaxed/simple;
	bh=gwAB4OwfVakvBvVedSQuyxWIuzG2jaSGXmjvv/wp8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVKQgezRxSZCjKdYVQ4HPKv2PQS5Jn+uJlm5Z2RzWk2aqG9fbiXvDg1JGk0m536fOVmy9t8jUi3DQd4PJy667TjvMSsdnUN5wP4KRpVoAeJMksXZ+pQeR94ya/eBuM9xuD566avtouc+dwJxbUYtdKCJFBzojZLsCoe+HcyPDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DDj3wFHY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DDj3wFHY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so293325a12.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784774730; x=1785379530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9sK668n3D1PnSvw9ANxNFxUL+qMcnmKn6/m0aO8lejo=;
        b=DDj3wFHYc972Qe1YtKKg9X4y1gUtUcoMMer/CK8eJN4X+hVOWyGwTnf2bWtlrve3wq
         nWOjx4lBEyHYcVGl+DsZEGL78lKnaAosa+C29AlBmvbu8mSqw9Oc7cYq9sdF9+3EXer7
         EqfXqkBKUYT10gMPFix77V1sq8TsHqmbj94J3zqRup5a5f/5jfeRfBeIpDXvvTs28kKX
         L4TWJG4fVnyHttQAysFGRddMxgiuikwUDRIuUstRdszjGOX/SSO1il31oJ3Ed0h4pGnR
         OgZoVZFNzn83Z9n4nupS/wx0zgZUXdkuqEa0bTciWGH1JyvRjLZBaT2IxwFy9DIecvya
         B6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784774730; x=1785379530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sK668n3D1PnSvw9ANxNFxUL+qMcnmKn6/m0aO8lejo=;
        b=JWcc7HGEloyz7mb2BaWkaZ+UFnDt8F2N+GffQDx2bO1xHs9evM/VcryJrVAb79mXRv
         fjTpSeNikf/4KIxmwV4+qP5L/T8vXSt+Fr0PTb/S4YAf666Iy1Dz2ZN47b8zeRpErdg5
         o6LqCAf8zt2RrQ+3VgO443F0mwIFSRwN8nLcroZHhb0dmmztVxhu7GQvzhHDO/42dmVx
         1xhAZUOgnPye13XlXlkcwV7p8L4SKwGNJDEZiUNJPkS8IeIiKXpI3TWzHxJY9XyrPd12
         3yABXW4TB4KlJIJWQ5q67mwC2idpUiYU2y6MnmjSoWL1Qucj8yoy+x0APG/kwksJ4/HL
         x3CQ==
X-Gm-Message-State: AOJu0YwWHSY5AEyysL/HvDN/NRPjDNJCkpB3yF02YsFnE4cnuVC1a+v2
	YVhtoy+Lpiw7XVcufsX10JL0pNTtrDQNq5wqLeN14Jow8SxMbN2Uev83gF4R1XTa2DwJ6klqWe2
	uLHBBlkUaEw==
X-Gm-Gg: AR+sD11Q/oiGsPCzGcvJWkwZQafsX1sUhZ0eH7C3FWC79eHInMzxbjqnNhcwoQz6oDs
	xUIdKG6xNkHfUoKDFdWVGES/4MPpnS3HiY34fsL28FNcjZhoIJyix7ne8m7FPpodgqa074Xfqhx
	Zp/SZuU5d87CwR/7nYDjJhlNQobITeGkMFTjNSVx+VUlf+55fm1V51sh56kp39pEJDnd9gTRc3t
	XKyee9/vkGYtYI/N/Y4DjV6wMEkkR7dwxY43gdicdgj6eqGku0eQRa9P1meKvPJ/3hZ5lPHWkeY
	qB39l/sDNEHoBkYG3k2fdq3e0TSmOtJRd5fphggq0Q2iZfiPLBvGmcbmXJr54bqlyo7hey2Hqb6
	z1pjuwPtcPBnvx7/+eUAO2c0GX/bIQmEmFGP1QWk6PtcP353cDwDbqAjjc9vsplUIOr9AHUhRua
	lVuH3DwQ5ppwFcslbdc+wLUOpXMrQ65w==
X-Received: by 2002:a05:6402:c44:b0:69a:9355:d1c7 with SMTP id 4fb4d7f45d1cf-69f6cd0be23mr404434a12.41.1784774730165;
        Wed, 22 Jul 2026 19:45:30 -0700 (PDT)
Received: from u94a (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175cf946sm2206405b3a.49.2026.07.22.19.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:45:29 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:45:24 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: BPF selftests compilation failure due to
 selftests-bpf-initialize-operation-name-before-use.patch
Message-ID: <amGADfkR1Z3jkEB8@u94a>
References: <al8dSv_OvhwxFCar@u94a>
 <20260721201114.0011-stable-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721201114.0011-stable-reply@kernel.org>

On Tue, Jul 21, 2026 at 08:53:58PM -0400, Sasha Levin wrote:
> > Can you pick up commit 63c49efc987a ("selftests/bpf: Add simple
> > strscpy() implementation") along? I think that should be enough to fix
> > the build failure.
> 
> Greg has already picked it up for 6.18, which covers the tree you hit.
> 
> The offending selftests patch is also queued for 6.12 and 6.6, and you were right that they're affected too. Unfortunately 63c49efc987a doesn't apply there as-is: it depends on 9a6a6a319157 ("tools/testing: add linux/args.h header and fix radix, VMA tests"), which isn't in either tree.
> 
> Could you send adapted backports of the strscpy helper for 6.12.y and
> 6.6.y? I'll hold off on those branches until then.

Ack, I can give it a try.
