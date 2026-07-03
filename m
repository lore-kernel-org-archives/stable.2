Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D701340286;
	Fri,  3 Jul 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062958; cv=none; b=ObodzivKuxAEwU1fSVmeDnAnbkVHJ2Ero/taWGWf35a+YLgDt364liOyHoRZ17osvMd0qIAhTBtK1kZZaE5qW41GWsX2CyrXvl2YjTpvX8AWeLfy4dhqvEJARQ2EwusqtzPH//E0F3Eq7nbZBj+bhjZpmH1YfSIgzoPE5i8K8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062958; c=relaxed/simple;
	bh=sZgjixs2xPeB7/AN+Da5erhmySpfmwoTCQk6Plg/eCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tH1o21lhJfqX9M5UaFnafvyxvD92GWaWWVA3NK/wrtcpKFsfYX0ntXvwSOVwb1bpgblrZxEZp3CbAKxbSZAEoinBFYHNvdrQ6KUSOD/TXczevBYsKu3PuF4NTrGN9Sd2gYQcbDJ3YNGVVnxvcC/caeVC4aH60Utsr09CTwTL9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BCxQwAud; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BCxQwAud"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NxjMdu5JOVdPnBPpE21xEaCGzEk7c4qDGVEijzuquBs=;
	t=1783062954; x=1784272554; b=BCxQwAud+JjqWhAUmRa6Ri5Z9Fse9AV/sxXQd3QNr9X/bbc
	ywEMkUaVEAikzMvdpaS6FiWQwYg76Ph3h3mt04GJIyQPhSCIq07Ur86gAbQl5CX1BuyBSzdZ3Gr1Z
	pZWxJYGBHCyBXJfkA1Uw0LWDthQCBOBf+kZjOHsu0scWqDC9pvis/JZfijq+7LiZ0FCHwsqSS12Hy
	Zs9dIL7P3B3W68AzFkNeWoIdHVpPiR55sZLzaNwdtmaszMjqr2rY0itSCWkCgtigoeG1msEKhWVSU
	I1QgUPebmtHDtdXgumX28Yiyu9NgMmYYYk71n1BvNGQd4YkBSMfeXZTo/M/udzRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wfY7j-0000000Eo7S-1sB2;
	Fri, 03 Jul 2026 09:15:43 +0200
Message-ID: <251c85cf04f523e6dba6c5e02e252ed6b83a930b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 ath-current] wifi: ath12k: avoid flushing scan
 timeout under the wiphy lock
From: Johannes Berg <johannes@sipsolutions.net>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Jeff Johnson <jjohnson@kernel.org>
Cc: Wen Gong <quic_wgong@quicinc.com>, Carl Huang
 <quic_cjhuang@quicinc.com>,  Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>, P Praneesh <quic_ppranees@quicinc.com>, Ramya
 Gnanasekar	 <quic_rgnanase@quicinc.com>, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 03 Jul 2026 09:15:42 +0200
In-Reply-To: <20260703060219.2998148-1-runyu.xiao@seu.edu.cn>
References: <20260703060219.2998148-1-runyu.xiao@seu.edu.cn>
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

On Fri, 2026-07-03 at 14:02 +0800, Runyu Xiao wrote:
>=20
> @@ -9975,6 +9974,15 @@ void ath12k_mac_op_stop(struct ieee80211_hw *hw, b=
ool suspend)
> =20
>  	lockdep_assert_wiphy(hw->wiphy);
> =20
> +	/*
> +	 * scan.timeout takes the wiphy lock before aborting the scan, so do
> +	 * not wait for it from the locked stop path below.
> +	 */
> +	wiphy_unlock(hw->wiphy);
>=20

No. Don't drop locks in the middle of someone else's (mac80211 here)
process.

If that work requires wiphy mutex anyway, better just convert it to a
wiphy work.

johannes
