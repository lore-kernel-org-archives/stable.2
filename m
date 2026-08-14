Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B451FBC8E;
	Fri, 14 Aug 2026 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728668; cv=none; b=kHXOW6AytDHSGl0WIF2hTRUZonKtS9D0kEnA9R4bV8KxirFn6rkSzgZ+K9orHbp9BpUmjjQaz7uoxRdWbl0fpbQooz8fdJpH/maFBDCubO+W5CJtsFBqVWNfGZ60DahkgoW/qnOD2p8MRYfyS04fiiWOfH1qUYiUDGNr5yEEsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728668; c=relaxed/simple;
	bh=cvxnz7KXDHrkwfkxnBG9ncWYHyaIUJgFITUptxeW6oE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lwp8mQJr7c60vp1e/jDQGC17NBklcRVJ+w+pV9JlpqY/UZmMWtuxvxc0NtLoQL0QkrRCwTPPcqrmQ7fZNeleH0q9JqHIVTXNHphESI4Mp57wlu8cD48JYt/Us8jPsyIy/82SYmrq0284+0cxAKENxBj7ttOUB5kRItDD69pTc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOoQQjrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOoQQjrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03FC1F000E9;
	Fri, 14 Aug 2026 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728667;
	bh=cvxnz7KXDHrkwfkxnBG9ncWYHyaIUJgFITUptxeW6oE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bOoQQjrmoDhnmeQdZfa9EvRn//ebeE4AckBE+s3QTdeomyogYgdiTkjPXY1Oh1GKk
	 30x8abuNj2t/Kid9S+nI7AQosZGTXzDCGduoZEifbvWOdlw4lWjZNm74VZmZPFCJPX
	 uinAZHyDc4mN8pdRR3hqZkkV78GfJJTLewVvH68F61EJ54ebDj/nTPPk8STbd9THbQ
	 e+aptXge14IVI4cEaTS1JhCM+x+5pQQlskIr41M0WyvIn8HoU/EsEmvVIAc0YeN0Ju
	 Hv/y6szcFIrIaTyManSEg/wTkS+gH3rFA5XzFhy9EULn2JjXDCwrsEPXKO9Bc6h4Wx
	 SdackYvC4XmtQ==
Date: Fri, 14 Aug 2026 10:31:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: Shannon Nelson <sln@onemain.com>, "Creeley, Brett"
 <Brett.Creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Leon Romanovsky <leon@kernel.org>, "Joyner, Eric" <Eric.Joyner@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kees Cook <kees@kernel.org>,
 Mohammad Heib <mheib@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
Message-ID: <20260814103106.7d8a23ef@kernel.org>
In-Reply-To: <DM4PR10MB61118B1CBA5845B1502EA476C5DB2@DM4PR10MB6111.namprd10.prod.outlook.com>
References: <20260813051315.430146-1-anand.a.khoje@oracle.com>
	<5c7cf96a-74a6-46c2-bde3-f39b25a2d09e@onemain.com>
	<DM4PR10MB61118B1CBA5845B1502EA476C5DB2@DM4PR10MB6111.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 08:17:27 +0000 Anand Khoje wrote:
> Oracle Confidential

Please configure your email client to stop sending those tags,
and to properly quote the replies.
