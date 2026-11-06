Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989504;
	b=hXhHAhH6hYfGcz2lGxUWAyJANG+BOiDVchdpoJKtKu+WbRoSCt99Z/HvxWJTbftLGu0q
	 vFmWUicJINFB9eE3vqojKR+2dtGJDbRckvPol+DMg1BERbY+CPLtDikrepA7DcrzMacIA
	 uUEBQcKkxGoEXw3mOBULC9XBUr76SKu6b08UJgijbLKJaatp4Lh893RRcuJdvaqhIHY+R
	 1sjBS42kg/QH7Blyk8holj+UIJlGQ8oEd2Lpxg0uhzO8TxP9zQ48NlNCsTyTOXQV2oEyH
	 3YWQm1SAQFyMm2is+okleMVaP58Y7cu0A9pB7Il2+0F6ZF4HllaVYbn/N6z1n7zcMzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cvj48iQsAelsE18cOkmccVGHvIn+nGrcXazecv8pypI=;
	b=FSUD+qQmY9Ydg3PgQMgJ5TlsK4/qyWGuVkNoEmMpW9k7IgvxOY/KfnvDcJ+ummRMh7W7
	 i1JisIRS3+PmRpThwPP8YujGqgb4xLksdbBxlrS2QmXJp1SJxlSEoeNjIL/Rjj8wsqK3a
	 IvgafGO6gJFXQuuY/313YuVwJ3IUNuCUVDOdUUPvoSApxMZgXN0CVqKUBNlRvmcY4ylcw
	 nGm2i33lWkrKxg7fU3VMFRuGWDG8l2WdabRoGcLhxoHEThDUhvQez28yYKsCx6aV4MYOM
	 Qxjbd6Aw/ub00yK7FWh20Rdz0oQnDtpMV6op8VqhYtdGBDN+nMS6HJcgiz6l/L8AU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=akxxRCXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1D606A337;
	Fri,  6 Nov 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=akxxRCXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566CB1F0089F;
	Fri,  6 Nov 2026 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989503;
	bh=Cvj48iQsAelsE18cOkmccVGHvIn+nGrcXazecv8pypI=;
	h=From:To:Cc:Subject:Date;
	b=akxxRCXt+gROgI1PMe4pQeRo/+T579Aw5jd9+0VEJswqBrkkA1+Xci+PE1CAAwnX4
	 oGvdlWG0w7HVzl3T/aFhbV9ZHv0uwoWzar6oDyfeTdFlueh/CG6AsOwhSHxpZKApig
	 k08rykVKdOtmjj8zik6safYNQinVrHtP9663hp2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.192
Date: Fri,  6 Nov 2026 13:25:00 -0500
Message-ID: <2026110601-engine-salami-5fc2@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.192 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                            |    2 +-
 drivers/block/xen-blkback/common.h  |    2 ++
 drivers/block/xen-blkback/xenbus.c  |   31 ++++++++++++++++++++++++-------
 drivers/net/xen-netback/interface.c |    2 --
 drivers/net/xen-netback/xenbus.c    |    3 +++
 5 files changed, 30 insertions(+), 10 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.1.192

Jan Beulich (1):
      xen-netback: defer xenvif_mcast_addr_list_free()

Juergen Gross (2):
      xen-netback: Fix UAF when reading statistics data
      xen-blkback: Avoid UAF when reading I/O statistics

