Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DE4A23
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901272; cv=none; b=fwA6KX3DmT5hXwY6lmvx9f2hfimx8u1J+k/pGdSgM7zb5vuo8FilXanH/7ebfpchl7wZ5/uCvp4ojFkWD1suoLjVrWbD1RWAZQ6PO2beXAyGTss7EdoTXm9DDBKG3ZexDZ5EzzUXut727aHN3xwqR+EfL791hRlmOSm5q/uh98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901272; c=relaxed/simple;
	bh=/Aw9fSQRaR/46eiYnoklLkpAqGi0Vy0vKIcwhTRlvbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkqeTDQkHk2W/0cIniMjD9rCK1WgYHwMdSt4dDvidK7O6aYARE3COxvYan3JrXz1j9s/nPVvhmj5GKY+Idgt0tWg7aB1Lj+kpWJGPLWDWa2zSLRr41bIsGRO5A7pi+CppbyQzviJM+962stoUfej5velszLz38PXMSU8Esc9Uko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAb2T3fK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAb2T3fK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5995F1F00893;
	Mon,  8 Jun 2026 06:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780901269;
	bh=c7EnxnxtjLPx9A7QJohYrN5EYUj51EnyazpO1sEdSRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAb2T3fK0jscch0KNl/ttoRnPDBflo7ijXDeCFv8566ApK6OP2CpOO1ziw+5OlDoi
	 2XGmwa/S0f0PXquahNx7opEGWqRqFCy5abuld3k/xXV20fkWnWNGVoRVyVV40YzpWD
	 HCMGPnGz97WEjqD0+6UzqMp7JPtutyDTIEc+8hrmP1Ji6fgf2FrnVQCijYOybFjnIg
	 4JELWyy9nnkgqGwdGwRBHAwq99EGrQlnhNooRm2Toig2LZ52tCPxpkY7xVXf5/Q8s8
	 /II7XK/SbkpN2D9vmh0q0lKAagZCNr+B9LeeBMwKXbHqQorqb0RG0P6B+N/Gq0TG7m
	 TYYcG/eTh8OCQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wWTly-00000000Lmu-2e0h;
	Mon, 08 Jun 2026 08:47:46 +0200
Date: Mon, 8 Jun 2026 08:47:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] USB: serial: mct_u232: fix memory corruption with
 small endpoint
Message-ID: <aiZlktxkHGdTmi2y@hovoldconsulting.com>
References: <2026060400-renewal-coagulant-3a75@gregkh>
 <20260604121133.2771807-1-johan@kernel.org>
 <20260605-stable-reply-0009@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-stable-reply-0009@kernel.org>

On Fri, Jun 05, 2026 at 03:37:16PM -0400, Sasha Levin wrote:
> > [PATCH 6.18.y] USB: serial: mct_u232: fix memory corruption with small endpoint
> 
> Queued for 6.18.y, thanks.

I forgot to mention it here, but this one should also apply to the older
trees (I just verified on 5.10).

Johan
