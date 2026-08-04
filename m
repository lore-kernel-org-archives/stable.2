Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06C23BD05;
	Tue,  4 Aug 2026 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887095; cv=none; b=SgKSY2esl+h7tZg0JCKp20W98fUhnE/yDBo96X9sLk2a2IKH21+xBbgtdGGbuAppsL0GC6EXVD6npG8xsYG2zlhnqdKZFwk+FGHGn6Gk83TxKE/k2Z6Elv/MgkitCDM5esXLNoEoYxtnAQoueIV+wWEU6MMQvqJCE10HMveOqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887095; c=relaxed/simple;
	bh=JFCnwdCMhDCb+o4Q05BDDzrxjEE5J2ID4Jac5vGs3io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXUdHU6nhVn/zu8AiODewNaxmCWZ8lMXvwJBzdALWFJqmuIejKH3EAKu9zcppo3wWC6WhmtWNc75ovlLeEilTQ6pHoC6/oUfTvhtsphb19i/Jexqfxh1Bp+PaePGT76inRJZ2CbMMp55M/7DpnRhtJveGWAdpBE02AbdN9FuAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHV1No0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHV1No0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B631F000E9;
	Tue,  4 Aug 2026 23:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887094;
	bh=9ZiWX2xhrqYCharb1SdbV9Db1j8riVjjD7LDQvjEDPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZHV1No0ixifSHjv5m3EGbP4rDkQVg24V1RgGioUj+NxZYKnjkbtn66DiSoaTocV93
	 Ia1NMxn7L33H0jPu3gjgIRaRSbTlNYrLz+4KwqAhMNJ2qlBbzcnxXW+Hyjau/bY8jA
	 PxPaG2f4/GBKtP7nzWEw3J4Ssq/lQkWcteVsFvltTtqLXwxzalUF9VrLsLNKw1CIKX
	 4v8B6Fg+V5bCt8TudA2lDE4ktodV4AexjAp55W3rR66xf8zo9r7QqSnR6mJQ98oL4d
	 k0UQPEyYN5gUhDJ2MMv+T/2XKx8KrGyQAn3WP4gWNNuVoxI4rQ1wRgMP0XCkYH6vop
	 eukARl6L24Atg==
Date: Tue, 4 Aug 2026 16:44:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6 1/3] net: remove CAP_SYS_RAWIO zero-padding in
 dev_validate_header
Message-ID: <20260804164453.0041e94c@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1d1da452d95b8@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
	<20260804090016.33353-1-q.h.hack.winter@gmail.com>
	<20260804090016.33353-2-q.h.hack.winter@gmail.com>
	<willemdebruijn.kernel.1d1da452d95b8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Aug 2026 08:16:35 -0400 Willem de Bruijn wrote:
> For future patches: don't send new revisions as replies to existing threads.

Unfortunately, in this case patchwork was not able to process 
the posting due to the incorrect threading. A repost (after 24h)
will be need.
