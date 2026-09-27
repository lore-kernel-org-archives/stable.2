Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE722A7F6;
	Sun, 27 Sep 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521355; cv=none; b=GYhQO5xjsmxqdwhM4i4WoGeZNi7Q7/RXbHnLbywgSkM/2EdmviGa7YcvbMq8YDkL6ZEtoZ/monBX/dl2RcNE35jngXkIpxlSK/51fRhUPLk1iuUyDcTcEmEtqOObUbjChE8zMDkXZsF0pa311DkNQWaenOap06erzCVRFEYL3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521355; c=relaxed/simple;
	bh=dUny5UFNh2lUaZ/3G4GgOf3RokdXcy6ycG+iKo+Z8qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFNCw6XOFPXluJm18tqMU56MAO/ak8wHnDWtEdIo9Kf3G7P4lcg/rH/zlmQvoVnRElxFfBkiRRa6KKNO5JgxaOz6/HrQ1ia1DiHXLhBpAoaAxHKg9caOLlP8Q0b6kxRpL3CfKSSB+HysI2mbTHTiOyZeVAqGOnA/8EMnUEtHkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2zgL5m+r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2zgL5m+r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lZBzZLelv8bxgIGORwg1k2Deu/gGC13JXrGz6DbsOcQ=; b=2zgL5m+rNJLmSzZdAS91Nytmzd
	P9GBP/uhTb7uagSVgd2HS1IMiTFCuIp0zEIDkOipuj06LS0qRMTrr/BtjI7TFGcWw3Q1LPxyHdp7b
	+TuLE8M4kN02l9gC15qYctUkFlmfCz3p650ZSXMEeJP0feF3wAjRaDEbxUeBzfr7xwRM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAqOa-007Wdk-FJ; Sun, 27 Sep 2026 17:02:28 +0200
Date: Sun, 27 Sep 2026 17:02:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-leds@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] leds: trigger: netdev: Put netdev on activate
 error path
Message-ID: <13e58137-2104-4ba4-9d41-e30ba5dfb367@lunn.ch>
References: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
 <20260921093249.3481413-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921093249.3481413-2-alexander.sverdlin@siemens.com>

On Mon, Sep 21, 2026 at 11:32:43AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When hw control is active, set_device_name() takes a reference on the
> netdev via dev_get_by_name(). The register_netdevice_notifier() failure
> path frees trigger_data without dropping it, leaking the netdev.

Maybe it would be better to add a unset_device_name(), which releases
the reference, and does anything else which needs to be undone?

	Andrew
