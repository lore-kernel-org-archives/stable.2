Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797134;
	b=R0OhZnuX7AbgvWNb6S5z9wPjBPDbq1m4r+PmSmA/FUJrWYHRDusiQTx7nwmQbQZAiM3s
	 IxsUQNkUpYdMZGDAvopWLIhHLX43gxDDYhTueWpqnmVCNk0QpHrF3/xUtzpGQkgXXZwv0
	 fUI8yCecrMX9+0/picMEA5wW09OmuEDx5ZI4EExgOPoZvAEtx94oOnhBdWVvKqtO7iSu+
	 9FOXX8/FdNBHAZL/qfbggSY//j9ocRm+l0qtEWTzdVU5p7VZPqlDNibuP7J9VsoMkYMDX
	 XRkFwwHCkr39nv9mCssdeqMWayJhmpyalprGg4Tm1RPYqhv+O8DGZ+tNTJ66cDXHN/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797134;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BQiokQz7+NHbLU1YUgJvJRz+8rmHmPrtiNBnIP9oN2s=;
	b=ReEy27qFMiTQw/nyJKvcAMN8yCbmGo86GVAbfWdq6qnj/GWYxXy284mMgtdgDbSR7Ae+
	 zfz4z9EpHaKkKzFXqTUSpSG2uDFQS133EEFSJmLBlcYI0tdUZbnPWtR5Cn/F9cl6DcDZw
	 99mXIrpa8D2nwPXYkMMBnrE0uKzK9eaZiJLdu0cOttkBUt3gNyy9MsB26iw8njR6Wv8Q1
	 c7oSPIlorDTcBAHGdKR8YePCWo+mP3jtoCnhmxh6ckGvjj74UBhUzganNmqqzto3cVtWU
	 6CxfaSOe2fO+bmsFZ2Jzw5MFqfCxzaHwCGjum1Cg4JqWGDOGL0iTl7MrznETDcqoT9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Auw3Hr+A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748F606A31A;
	Fri, 23 Oct 2026 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Auw3Hr+A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D8A1F01825;
	Fri, 23 Oct 2026 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797133;
	bh=BQiokQz7+NHbLU1YUgJvJRz+8rmHmPrtiNBnIP9oN2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Auw3Hr+Askp6mRbjjuPJMs0tBFF1JuRnyVrW7tUx1pIBKHJKfS8H0zGSYfxTc9KWX
	 dkPk6GBpFWHzwCfDvHQE804NfgFbSBp+zTPEm7MwyMh1YyhO+XJwvdwUUPaNHctYI2
	 waamrRZhZsMkl/zsHCeXH7L6tqdNFdhoLrfjnpGLdgs2vfdZXSNQa8gnG49Tq3mnu7
	 2S8knSjsFdW5w/YWqBWL63355f+/lwEM1oOnZ5ZzvBp5xcRY0bQqY7nJRARocwSTMs
	 qIOOqAv8iXQ9c5bznIefJaoQznc34M+gMJ4ezuIFJmVgOy2YHZohxFCg2J8GMfrLQf
	 lERdhpM1sE+tw==
Date: Fri, 23 Oct 2026 16:12:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Paul Moses <p@1g4.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
 <edumazet@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH net] xsk: restore UMEM flags after failed pool
 assignment
Message-ID: <20261023161211.74b2acb6@kernel.org>
In-Reply-To: <atpDcGN3zWhixRj1@boxer>
References: <20261021224705.2078753-1-p@1g4.org>
	<atnKf5dNv0Vk1sCo@boxer>
	<xFs3DcEr8aRQdjIeuzTZ4fmeQ3Ay8_x_94KB387XkLZDamj_rLyn4IGiFdZMi0u69fpiYrPQq9P6o1j_xixC1WbF-tl3JxDLmcMZZkPk70k=@1g4.org>
	<atpDcGN3zWhixRj1@boxer>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 19:10:08 +0200 Maciej Fijalkowski wrote:
> > Right, evidence suggests igc handles it gracefully, I had attempted 
> > to provide multiple examples of real world impact to satiate Sashiko,
> > but only igc survived final edit. It needs to be open for the failed 
> > bind and successful retry, it can be closed after and bad state 
> > remains. If you're looking for greater impact, look at stmmac. I'll
> > send out a v2 without naming drivers specifically soon.  
> 
> Not really needed to go with v2 with reworded message. Let us wait for
> bot reports first.

Bots look happy, but I'm slightly confused by Paul's "only igc survived
final edit" statement. Was this issue discovered in normal development
or by an LLM bug hunt? Was it tested on I225-V hardware, or LLM just
suggest that HW as a NIC that would be impacted?
