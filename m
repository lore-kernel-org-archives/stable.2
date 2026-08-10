Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488C40926E;
	Mon, 10 Aug 2026 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387173; cv=none; b=AS6UaISWA2K00XfTDFobmkw1WVzdNTUurN40tubn8H2tXUj6HuTgVa7ABIJXMtcKLrDyq/Sdx4lSR/0gJlk7mRXqeIsZZLQiRbZT9jS3GQMCQIGj33UhrHEJVWEEAHSzcncUb0bX79iTrejY+41v0npOVbbxvvXj0drRxAy0b/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387173; c=relaxed/simple;
	bh=Ce0ycPjAP36Rm2gog3H2ugpIlsK6txTbVZ0b50GNR3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByrNZ0wEnOUOX1nOYra+o6XPlTaIPekaunb6OtR/4LfgMoRu0QIuBsrbIQPYjeBkJ5UnrLnSVq9nJKDNaJH+YhmTHSSnWk/7WYUdt+fx22ePfuz66gz5qGrMV/GANpJBte3SgmBgjg6SfEuR7Gv0K9IsMrDw9as3NHivsCjlEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O22cUxo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O22cUxo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84821F000E9;
	Mon, 10 Aug 2026 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786387172;
	bh=RQxQF13xpVnrXYDP2yoSgniMQGYNQCxGDPY0Sz8+SzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O22cUxo7Ljzbos/W8EPn2luPJKGiyyb/jxBnGQXM+sCt3GpQdd17W45SfRP+3Rkvf
	 E/vPLo941EQAvQtjhPI8XcHn6q25Z0kiqWTgNLzKkyfBV67Lv6YQjpZeBpAW49YttJ
	 wbM/jdd19cFL/WRLsT0DyILVWKBd93vFRPuRydRbBC9mTAG/xAtDtI+s1WEu4tz81Z
	 +Thg/sMYEPx5EVkibh0yIPmReeik0DPH3w+g00PNM2bLZ6Dq2tnvBO4wYk/sYR3eyQ
	 /MrVxeqMTY1WREyRHOnb6yPO/gxCbeNClzUoPq92VYFGTMmALeSy6AHm9NwuatDgNa
	 cgV0ETVoRIyjQ==
Date: Mon, 10 Aug 2026 11:39:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FE990D50
 composition
Message-ID: <20260810113931.43b2dad4@kernel.org>
In-Reply-To: <annMvEUa7sUvVIfr@gmail.com>
References: <20260810103409.133796-1-fabio.porcedda@gmail.com>
	<annMvEUa7sUvVIfr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 06:07:04 -0700 Breno Leitao wrote:
> > Changes:
> > v2: 
> > - Add stable@vger.kernel.org  
> 
> Why CCing stable?

FWIW now since you haven't acked the patch but asked question the patch
is going to be held in "active discussion" state and delayed so please
provide a tag.. FWIW2 we discourage reviewers (iow non-maintainers) from
asking these sort of process questions FWIW. Majority of the time the
submitter knows better than the reviewer.
