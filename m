Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E62D4B68;
	Tue, 23 Jun 2026 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205835; cv=none; b=NdmY56PyAoznvM/9vhraX/EJcQXdT3VrV8ASkBpleaI01s0mjAdSGJMUY4NxEmiiebkCLlwt8UHqCprvxPi4LLjPaEUuT7nKg/p+i03LteD7fQZK1h7WdXwVSxSQk1y43xKnWBBkhciGlys27K/F5jDZJEC9Y0xfQYNVYNkuvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205835; c=relaxed/simple;
	bh=nyF+gNW8/nSCzTolTcL2Udbq/hDcUcNUOW1uk87EcHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQx4j4bEP3ZnhZGVVVsVAVMDmnbIEkdnJIaO36VH5bX391F6NhSISQe/hQemGByZknPo/ytirLMsHZIcA7EUcgzjbwhwcvORyIVZP9HBQkgksc0vP8NB8pgjHy348qwWbCygrgu6njXXJ0fa1Z/Zgqym9VEdVOiqGSFNWbZGx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wvcWqHoZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wvcWqHoZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nyF+gNW8/nSCzTolTcL2Udbq/hDcUcNUOW1uk87EcHY=;
	t=1782205832; x=1783415432; b=wvcWqHoZDhB04XqEH7qBgWhOqDD400S3TJWpbJkBXFI7Ufr
	8HQ0Wk5rz1YP2HSyyw694jZAuIVUo8RfpKcE1CXuH5zZJVMJWRQFmURz588DyOscX8bkdlKroYdDO
	1f01CEmWo3j9xU00RllUqQfAzlDP1WlvAx0MzDsNzClS1vAF923tPUkOc2U/f4nrtq6Rm/i1ZgBAG
	BKN3ztRZtb37UdZ0eTHcuRcqvRBCzacUFvKKng4OnoJFlg7c5k3quEGxDRCPwAaNvuvp+LEimqIzX
	C3euG8Yrquv9QDGm2MHOoQ3fuOU2IQs85NywnkMUngRVqFPrKZB5yXnwgwiv/4gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wbx9J-0000000ERr1-2bYK;
	Tue, 23 Jun 2026 11:10:29 +0200
Message-ID: <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from
 our own BSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Yingjie Cao <yingjcao@sigvoid.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 23 Jun 2026 11:10:27 +0200
In-Reply-To: <20260623090437.13198-1-yingjcao@sigvoid.com>
References: <20260623090437.13198-1-yingjcao@sigvoid.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-06-23 at 17:04 +0800, Yingjie Cao wrote:
> ieee80211_rx_bss_info() acts on a channel switch announcement (CSA)
> carried in a received beacon or probe response before it verifies that
> the frame's BSSID matches our own IBSS; it only checks that the SSID
> matches. ieee80211_rx_mgmt_spectrum_mgmt() acts on a spectrum management
> (channel switch) action frame without checking the BSSID at all.
>=20
> Because of this, any station in radio range that knows the IBSS SSID
> (which is broadcast in cleartext) can inject a beacon or action frame
> carrying a CSA element that points at an unsupported channel. The switch
> then fails in ieee80211_ibss_process_chanswitch(), which queues
> csa_connection_drop_work and tears the whole IBSS down. The members
> rejoin and the attacker repeats, resulting in a persistent,
> unauthenticated denial of service. Encrypted IBSS networks are equally
> affected because beacons are not protected. Since both of these CSA
> entry points are IBSS-specific, the impact is confined to IBSS (ad-hoc)
> mode; managed-mode CSA is handled separately in mlme.c and is unaffected.

Once you rewrite this to be more honest, you'll see that the whole Cc
stable thing and all is fairly much pointless?

Or have you not realised yet that stations can also trivially fake their
MAC address?

johannes
