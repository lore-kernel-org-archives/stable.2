Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B270C4825CD;
	Mon,  5 Oct 2026 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206071; cv=none; b=igY4bVDZtbY0IixCVMLrjOATbD8p/IXoxJcauxg/eCdoWjpzi3BH3QY5oA7N1v8Pe3cZgdS/wMADXcWFqszZQ3fVR/gDs0kh/M5kFOD3xbQj0hReeH7PFzWENvY9i8+Ma6mcZ5tF1SCAyXMieEOzWR9zPC6ZrNywNdFzFofxhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206071; c=relaxed/simple;
	bh=65VyyGajm/xg2ros0aURKRbNtrWlyUynlzIogiOsLek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6HtngbNJxsUZr9HVlO13vRmE6K6OTDGFYkZ05oAzMMRVquLoDQF1aPtGurbUUSitGJX9/H1W1GspSYfQHwhOsbiqHKUHidDBoUzKrIFozXlDAcQotVjjtdmW+iYEirYlI7rTahmZWMwWhwdsrck4AsWjyRuhA17gdd9eY9W5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Kyu/U9ZX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Kyu/U9ZX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=65VyyGajm/xg2ros0aURKRbNtrWlyUynlzIogiOsLek=;
	t=1791206069; x=1792415669; b=Kyu/U9ZXN+Igbqjk6vCB6fSM9mDnicyA6jMmgtwCzWxO7+a
	bj6eq3Tj4l8ZWmZpJ4Pqu8GCk2OGE8i6tRN/z8MY0v3HIxLj+uj4/mSWSvVaSgDBH1kwfNRRoWfQO
	cBMaf86GZmlSQscDM2+X/ZFGrXcu2k/dCot3lLIsiv1n8Ol05d5i+oToqevilpvcaZrsvXFs8DM2n
	6gKWmlmPFR+JZ1ioviFiz3PqD3jfYL+ofQAS9L3dsQTjzhpZTImwbbYdzwB4/gi5/wHs1aretD7S1
	zoKF089XOVHIZEaIHKPgrVEnVsTXFczXg1upi6NxgLSoAhJcfXTAuAyXCnrd5zGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xDiWL-00000005Ki7-1iYf;
	Mon, 05 Oct 2026 15:14:22 +0200
Message-ID: <7360e480d5eb194dc7c16c6e82944dfb73f3892f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlegacy: 3945: protect sysfs TX power update
 with mutex
From: Johannes Berg <johannes@sipsolutions.net>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, "John W . Linville"
	 <linville@tuxdriver.com>, Zhu Yi <yi.zhu@intel.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Date: Mon, 05 Oct 2026 15:14:20 +0200
In-Reply-To: <20260929181458.GA17064@wp.pl>
References: <20260929123329.2135878-1-runyu.xiao@seu.edu.cn>
	 <20260929181458.GA17064@wp.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-09-29 at 20:14 +0200, Stanislaw Gruszka wrote:
> On Tue, Sep 29, 2026 at 08:33:29PM +0800, Runyu Xiao wrote:
> > The sysfs tx_power store handler calls il3945_hw_reg_set_txpower(), who=
se
> > command path requires il->mutex to be held. The callback bypasses the m=
utex
> > used by the other 3945 control paths, triggering the lockdep assertion =
and
> > allowing concurrent TX power updates to race with other command or stat=
e
> > transitions. Serialize the update with the same mutex.
> >=20
> > Fixes: b481de9ca074 ("[IWLWIFI]: add iwlwifi wireless drivers")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

I think we should rather remove these files: custom, undocumented sysfs
shouldn't be there anyway...

johannes
