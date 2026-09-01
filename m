Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FA367B73;
	Tue,  1 Sep 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282157; cv=none; b=faIfLOsSmewQl0w5Jh5tvOQJvll9M/sts7UC3brAacQ7jWowxzzK88yZDW6+cJQjdrk5YVloW3zvg6FQMzNIo5iwOUT+y64e1sq/UdQeiixNUwDVcEhXP9y6Q+QHG0DgwNOC5C/RMyMpeoKD2cmKf/fm4EV6UxEeWCdbHax6t3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282157; c=relaxed/simple;
	bh=WAtH8ikAflpYjt6Ojkz8d4vYS3kGjxF4Ei9VLEAaMFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/aK8trB4k5ghKk1/1ZyGDWTkIJOpOzI5M2u0hbpaSH/UeLu/5ENo81D2ZaGM/QiCiru7+bfPMlnXCkhHILqQAbICPGVrzij7+OSBnca8KnPGcxBZuzjFgmioAFdk8BVCZL/3DUiVTz8rys0FuxaXhNM6URMLowtfQ94miualiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=I0d9iY/m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="I0d9iY/m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zq3ZKa/atxerNogsCL/cSK/bDB3oFWO3gxOmGl3q37M=;
	t=1788282155; x=1789491755; b=I0d9iY/m/4pJYfXFqP/k3Cj1K5bO9tmKhaNQ7z2BpvF2gyZ
	XU4dVOQLvB2uBUAqtPurTOASU8MImQe+ZZLILN/OZHl9T1BL4cJQGcB75hVBiXEuW5sSy0PJcG2W4
	4MUBSWnLhW1EqNRrNk0qSOsW71kHnDatWfgUhLxlxlnkbJrOt8Ex2up8FzVwYSNqF4w9kUbf3A6Ca
	glfC4+ergwf0vvQmZ7mWYwqmHKqyxhoOhVlVrv4PPw9ZqBFJ3V7ah7QXWingm7VQ6Zk0Ou1Ln1kBO
	A8323ERTPgSVPpWc6hbPe6wooOcbU0F5p/IQwiBvUwtb6jcShP3OV8xETYI2AxFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x1RsR-00000008bCc-2iQN;
	Tue, 01 Sep 2026 19:02:28 +0200
Message-ID: <1a2c11d47b27dfd8a246300ac158d25cef5abf35.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2 1/3] wifi: iwlwifi: pcie: don't infer CSME
 presence from a failed read
From: Johannes Berg <johannes@sipsolutions.net>
To: Bjorn Helgaas <helgaas@kernel.org>, Navon John Lukose
	 <navonjohnlukose@gmail.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>,  Nika Krasnova <nika@nikableh.moe>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, Mark Pearson	
 <markpearson@lenovo.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 01 Sep 2026 19:02:25 +0200
In-Reply-To: <20260901161736.GA1883420@bhelgaas>
References: <20260901161736.GA1883420@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-09-01 at 11:17 -0500, Bjorn Helgaas wrote:
>=20
> iwlwifi has a mix of checking for 0xffffffff and ~0.  I don't know if
> it can use non-PCI transports, but some of those places look like they
> could use PCI_POSSIBLE_ERROR().

I believe the hardware itself never generates ~0, so yes, it probably
should use that.

johannes
