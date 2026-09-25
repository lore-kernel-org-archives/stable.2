Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6A377ABE;
	Fri, 25 Sep 2026 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363054; cv=none; b=ghoONHI7p2xsGmjnt9i91D+svAJp8vgjrnhU21FIUUow6gsZ4rHK3MA39bAK+BR96n0Z6bNDUSs3DelsRvh6+ZxgfrcylAurIq03vUV0KDqOzrj6bYlrCUlMY7pMQP4RyTndARMs+N5mLo45mRVOW4uw7t++G0eYZT4KaUYBiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363054; c=relaxed/simple;
	bh=iCt5TZQAtj9d1C1l5TIWWIjbooQSUKzP2q5dUp5sn60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMnTGCgIxKld8nSaXGGWu84gRqkza6NFW31zbddyr/bBVsbN8ajUxJfawSUsVxJIhw1bodXRijuYrnA/xaQRP8tmwWkL7/Yu7nd4xP8I88JB40T3o65oOHdOvqjm5xMSVSi1ltSA44zfz9SWxt1B4AxN8PjAyk7+RzIsx5GySRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtyShUz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtyShUz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DD31F000FF;
	Fri, 25 Sep 2026 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363044;
	bh=livvdnqEd+WVxbiiwzLe4r186ZBlnv095MEGPZvR0MI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YtyShUz51L1+QKfkfJzyhnCrD+xr4Cdzxgl7IfUwFzAr5yYxd9J9feE2F41o/roWN
	 46OGOQSTajr7y0ZrRBcHvJOR9KRY4Fw/mbZiRLFVxLshrM154Aoo0+PZEjy9CrOmE8
	 krw25hZfY+ld2RIKqYJlJCvDS3ZHSlTUvkcZgQm/cIshUkcYX+N/YgMbShipbjJZeC
	 9HG4Gih1XB9gb3BsqL8ZJuEjuaLuTiPZ7+XkaXKa996ovuoa4I/KZb1tXXCpDQxjDm
	 NdVprzEQSgl6yiP1F+3zLy3qxdHTXuy8cxeBZ/IQCVUBxO2nDFhuwMueCZ2h/AoUo0
	 s3UhGo7+qBH3g==
Date: Fri, 25 Sep 2026 12:04:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 rafal.romanowski@intel.com, sdf@fomichev.me, stable@vger.kernel.org
Subject: Re: [PATCH net 1/4] iavf: return EBUSY if reset in progress or not
 ready during MAC change
Message-ID: <20260925120403.4104fcf7@kernel.org>
In-Reply-To: <20260925071850.53292-1-jtornosm@redhat.com>
References: <20260915092418.0aafd079@kernel.org>
	<20260925071850.53292-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 09:18:43 +0200 Jose Ignacio Tornos Martinez wrote:
> Would you be ok with dropping patch 1/4 and resubmitting only
> patches 2-4?
> 
> Patch 1/4 was originally needed to avoid the 2.5s wait during
> reset with netdev_lock held. With patch 3/4 replacing the
> wait_event with a synchronous send + poll, the original concern
> is already addressed. During reset (if necessary), if it times
> out it will return, same behavior as the pre-patch code. Patch
> 1/4 becomes just an extra precaution, not strictly required, so
> it can be removed.
> 
> The core fix is in patch 3/4 which carries the Fixes: tag.
> Patches 2/4 and 4/4 avoid unnecessary VF resets when changing
> trust, reducing disruption and wait times.

Yes, at a glance 2-4 LGTM!
