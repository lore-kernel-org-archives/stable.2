Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F15328A8
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169863; cv=none; b=SSkwDm6zowhrv4dl1AF3+tF5u3tDV1cS4W3Xo6NHtGL0i3avl121rXo5T/gfeAb6GMXwzMr2O2I4VdQOqk5xBfwr8SW8hTOMLVPyuXFUW2WaBfqCChIRVHDiWs4WTQqtIhutqv/wQQmXyDnop2aVO0ffpn3y61VB6UOlNN6ksXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169863; c=relaxed/simple;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Message-Id:Date:From; b=lo9MF4h8AGT6Txd/IByXU/FcLSGhioGIn8z7j+G/iVjcGta4USebWzQ6WN8fHj1896YD6bKeWWnDMNnQTtuW9zekWxMbvQLqwi/e62hIgs1xLty5fhJV1q2MiVA5PtaIhV42vY6FOUTigc9F4Jp8hgn0IvH8yXzG3xvZY6SLHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=FqGHxucR; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="FqGHxucR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792169855;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Date:From:From;
	b=FqGHxucRveVAhpMvGu8MrfMc16UK/Vgd/un3spiG0WB5csB+r5CT5nrxzC2khAZCa
	 7Qfr4fbJHmRA1LCzHK+Oz9WR+O1kbd5Rhu9Mti8Po2hfgP4YTr8ZKz98lOa+o+GtMx
	 kvJaXUnZ4n4RpT62AL/ODX4IqAU/LSFNkDj7jffs=
Received: by gentwo.org (Postfix, from userid 1006)
	id 5EF6F40B13; Fri, 16 Oct 2026 09:57:35 -0700 (PDT)
To: stable@vger.kernel.org
Subject: Re: Patch "refcount: provide ops for cases when object's memory can be reused" has been added to the 6.12-stable tree
References: <20261016165727.3959256-1-sashal@kernel.org>
In-Reply-To: <20261016165727.3959256-1-sashal@kernel.org>
X-Loop: christoph@linux.com
Message-Id: <20261016165735.5EF6F40B13@gentwo.org>
Date: Fri, 16 Oct 2026 09:57:35 -0700 (PDT)
From: Christopher <cllinux@gentwo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Christoph Lameter <christoph@linux.com>
Subject: Email address change

My email address has changed to christoph@gentwo.org. The email at linux.com will be decommissioned on May, 1st 2026.

Regards,

   Christoph


