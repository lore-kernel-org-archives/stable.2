Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AD421236;
	Tue, 11 Aug 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441644; cv=none; b=eak3JGxCHjUGXVsDsesho1Ru917Mcq5/iYq4YSetyhfILSyf1nWSGCNMXaeiXMykD9+/zKB3lQCSDkENysqOOIc/JVI13TGVQl9HmMId+LdEnlehtqNtMIenRBAzsw5bsbq3kvd9JifJqjIjm1WE21fdF4yXO3lc64MWE1bifEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441644; c=relaxed/simple;
	bh=WsdwV8cgGCzRcVc6/Su3UP/M+rCHofFFCa7cUwLLN5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR1BRQwZU/jGnzES2ygHyfF6+enG/9acMOPlqFxxNar7XfwQArd9LB+BxX/hNq235ap59MtbXZPZj7Bg2PuO9YJa0zNBvcPIrdKXf9Z4A+TPNVKGLbPo///KJopwMpO7dQskoigQVicMVv2Fzt2U2BdtWGMRNEaOLZPqDL1SV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DqE2Dhdw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DqE2Dhdw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zDof1we58wKax1h91I1P7AXDV0lW9jjr9oYw3fOKD9Q=; b=DqE2DhdwxRI7djw2qENWZPZzOd
	JgF8hrvhxVxgcVK2GwD0cc1rXCSA7QmgiF1m3dw9Pwt/m06igSULDEgiVfeA8oNe2T/IUKN3Pponx
	Xd9TKM7sGgR/KyAxccWuGmK/nZvyUi/O9Jf+Q1ubTF1x0Zc61B6cXoaEcTn1AXw3KatQeUhUUmjw3
	6i88aKmCn3Y1qHoUCGufqNQ8AEAPQu66bSPtDOaRLtXYQWBtFRBVafs2y+G9faDFpbIWnuUNPle+P
	rGtHJOnbqDW7Q+AXaBYXPWk4illZDHt5RG+oZwbjF65mKeyGjIJBVzWcSUdm/YSvtkGxUAcX79ruX
	eE2oawYQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtj4k-003TWy-2I;
	Tue, 11 Aug 2026 09:47:14 +0000
Date: Tue, 11 Aug 2026 02:47:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>, 
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FE990D50
 composition
Message-ID: <anrvb9qW92cr7ahR@gmail.com>
References: <20260810103409.133796-1-fabio.porcedda@gmail.com>
 <annMvEUa7sUvVIfr@gmail.com>
 <20260810113931.43b2dad4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810113931.43b2dad4@kernel.org>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 11:39:31AM -0700, Jakub Kicinski wrote:
> On Mon, 10 Aug 2026 06:07:04 -0700 Breno Leitao wrote:
> > > Changes:
> > > v2: 
> > > - Add stable@vger.kernel.org  
> > 
> > Why CCing stable?
> 
> FWIW now since you haven't acked the patch but asked question the patch
> is going to be held in "active discussion" state and delayed so please
> provide a tag.. FWIW2 we discourage reviewers (iow non-maintainers) from
> asking these sort of process questions FWIW. Majority of the time the
> submitter knows better than the reviewer.

Ack, sorry for the noise.

Reviewed-by: Breno Leitao <leitao@debian.org>
