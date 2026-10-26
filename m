Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009365;
	b=yxzoxgPV1mjpFpKcxGw89uL7Fg30h+Xw6KzHOX6nRwBcw0J4za93Okp9CcTx6yynBY0n
	 4MRIvRG/mabw+ENBsocFE6m7rButcroNWyXGPYFY61DpRMvz78qC9yqvWj9Gdo4LVSO0i
	 AFitr9bnPzlGRqmVRfQVYZtpBlbw5/Kb2KVIlFB8u2tp+oXk8d/bT42KL77W40FQnzzgt
	 TsTWUPM4Npg6zAc8v6vKRy8WRWNXpqvQU81aZuKjDKAAGf/viIs8sUZb94KuKt2yrxtld
	 QY3o6RJBCtGwgGOtRhjhZqPtva+9AmhfRC163OEoUsxoYeJTs2n4VR1xUaYB1AFvF6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009365;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=HZPAnM/3U0bn/aVCKNV5zTTcDxXH/5Lbd0f9RJLHJbc=;
	b=fTE357nR4qLnYl0Yel38sf0XQ0t1UAChXEjLbaYR9SxRqbaZgCW9D36B7Z5UbWGlIQvE
	 J/UWakxHB1Bv83HxopDQ3+DPYt8klWIlPLyTvZLG/kOc2xI/P3gXGhgKeKniHGQraN7gQ
	 Yw3SzUGlx25pkBwrevQljvWSw75kxiJHYuzVLNUFD74tlXY82GBGJL5idm6Tvb9aganXI
	 vvn+HTgTxhpnPxzIE58zNfYJMCmNHeio3wtQkA0rBJhxbjb9fNxTi5bZ0b4FiQou+Bo/X
	 5pfQnpd0UvZd0LrSy96TpWqmPojeroE+nVQKq2gd05blJWLBd2T83xCnayWDekhszrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=bNMkqgs+;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9A606A31B;
	Mon, 26 Oct 2026 10:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C9A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=bNMkqgs+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HZPAnM/3U0bn/aVCKNV5zTTcDxXH/5Lbd0f9RJLHJbc=; b=bNMkqgs+mLuiDK5Ug9uSnBNylj
	xuqJD/koF3x/jNO793SOTWhQ4LWBKg4j0QvDM/UXJ1F9EEDBe08kVDJjTK4oyExWi3IiN3FRwc5Ap
	pTk4oE0dgMOT8nFoO7NnP3T8Bqzk+VGdMNO7FgT+m3ublWbhIlzkrav3I+GNDIY4Aj5LMMZxR1E83
	jraXl59OornaPJLiZ3Lv9lWvab4NOQ+y1SpA4qKH9B6rdCEKKZxJJppv62T43KqEpSiKTwlfgdtFz
	f7fWo971dKxjkjKgdNwQUH/gx3541NtaEOAumpMYL1sXJlNnESQpulFoN17n90+6yMbF9UgaE2V6h
	ed0tgLqw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLHdo-000bRx-2o;
	Mon, 26 Oct 2026 10:09:21 +0000
Date: Mon, 26 Oct 2026 03:09:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	regressions@lists.linux.dev, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: Re: [PATCH 6.12.y] net: call getsockopt_iter if available
Message-ID: <at8mjBKGXLd9JHaX@gmail.com>
References: <20261022111535.528099-1-ghidoliemanuele@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022111535.528099-1-ghidoliemanuele@gmail.com>
X-Debian-User: leitao

On Thu, Oct 22, 2026 at 01:15:21PM +0200, Emanuele Ghidoli wrote:
>
> v6.12.114 picked up commit 41fbf726915b ("net: add getsockopt_iter
> callback to proto_ops", upstream 67fab22a7adc) and commit 22ebe6ab0b67
> ("Bluetooth: L2CAP: convert to getsockopt_iter", upstream bf01627cc04b)
> as dependencies of commit 3af72bf8f73c ("Bluetooth: L2CAP: access
> chan->conn safely in get/setsockopt", upstream ca2c4c264986), but not
> this patch, which is the one making do_sock_getsockopt() actually call
> ->getsockopt_iter().

Right, if you got the protocol's conversion to getsockopt iterator, you
need this one as well.

