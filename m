Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3C2D5412
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892420; cv=none; b=m68PYofGN3ZMhpyMOSXYp8PStdjGBo+XGD04getW63JWHKZ1GaVKtgELzy3R4r003yafLiGZAhcmFcOT0Nh6lOfAWOwtTGJkz0GgAYn5MNtjIXqjYoGup0YOJSrd/pz37fokYpAZPcSu0SOQNj/nKRKVO+U2j4tl2BbtlUfw8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892420; c=relaxed/simple;
	bh=5cERNV2QF4/I2LIss0p5JY5BHDzEY4eEARx9R7Zabkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJCo4wtjDMMo3pypXQ6lZhE2YM8Zk4JhmFI6/aRrsxJy32qDCo+KjMQKvEBE7MNJiqih0y7KXwY1MsDO/utI8h2y3+LHLC/MHSuMnl/Pos0XAoZmSH3oxmdT6b9ZmOQTcZUY4pMfiEn3pX4B5/TWrU55sdhnGCkc36rs/Ja2LN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUw4jk3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUw4jk3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CCE1F00A3D;
	Wed,  5 Aug 2026 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892419;
	bh=ImIv0AESi0jofqvWD8NcRmjtTM76jxaDmaRd2fOtnrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aUw4jk3vCrMlMIx4Id3l/s6C4V/OQIEiIhrnVpffDkiXWb3O62l9PX9Vl78RuLWCh
	 Wo3sRGv0LamBhOMd9tYZL2nujF3PRQm9Dcxp/39G1bPSBKtWnjgJJxj14sIoCeFqf7
	 broa9+4+k7/U1l+Ryk8tYSqSBZICZ6Buny23eyBpKU6WsDQhLrch69YpC9jnyZVkf7
	 oecS1xSRCQnV344/7Xuggbj+PM4ZSsdLIEi8k3LZPA88UKp7pJYTryhAidnQm2VbGl
	 jt1dz3H6bg0mwgF79aHFfiaLUGief+PL+5lDFd7krq/gyWCgk8zftXbqus+0qAUDMr
	 M65qx0bDzL/8Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>,
	Cen Zhang <blbllhy@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	NeilBrown <neil@brown.name>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Please backport commit 8173f7e2ce67 ("rhashtable: clear stale iter->p on table restart") as well to 6.12.y and below
Date: Tue,  4 Aug 2026 21:13:26 -0400
Message-ID: <20260805011002.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <anJCDeWQsBFO_GYV@eldamar.lan>
References: <anJCDeWQsBFO_GYV@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 09:48:29PM +0200, Salvatore Bonaccorso wrote:
> 8173f7e2ce67 ("rhashtable: clear stale iter->p on table restart"), the
> fix for the recently assigned CVE-2026-64563, got backorted to 7.1.6
> and 6.18.42, but would need to go down 5.10.y branches as well.
>
> Can you please backport this commit as well for the remaining relevant
> stable series?

Queued for 5.10, 5.15, 6.1, 6.6 and 6.12, thanks.

-- 
Thanks,
Sasha
