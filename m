Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989499;
	b=lNg9RolN5OdBZokoyXfCCyEgolXjEDCEGd6L4dCK8dwnNweijVJ9iLcoUAyeQX7ebltq
	 8SnAAJnjuauETzdTWJz/JUhvWa0rDzg/3Rvs77yi6wNOS3firBAWqGIFX4qvQNLeRtKhz
	 a1+eCJ9WQzuEpPNYkOH/WceEWnWL9bFVG/lrbDSBTySeRVQJhB8/11lak3QV2o7QhGVIq
	 AvrJRa4/FGmAg6hfUnGLZ4iAYyrzbwyHdZA1lY9lbo1GjliV91E3396EKPjB+fUCN0dmr
	 xgc7SgKCgRXgH4FmV2ujuhf4/ZbiVpF5JlQ6FEwePyuiK7qQFpnkRiBW2Y6Xu2kQEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZvuT8M4a+hRHT0Em5cPPU6ZYr2bIQ5wlJIOKEO0nbxk=;
	b=FwV9dVyTW+nvOb1ZKclT8n2Afce0UpGz82+574404kGNgoSH3cu8ukFCGmzBRfFBOG3n
	 t+0RThJvcE2Wu43MxjdxgvCC5urOPfWk/o1nlQnLVKlKpNgPjfPPOriX4hFZS62byOlU9
	 IXEn/o7wnQwCmEOBf/MhK4PKdchu5EzZ6bb5xhyoHmiAsvKSRHodyF467eBJNbqAdD8se
	 F4dglrGdYw67hFAUFQtDNJAhJ9eYbauve/dCfl1Hy5BMhi32k2nxOl+0QL+B/s9NPgKXG
	 agicjl75aWj3WGF6kneD1cDQMaK7UNmEZA6Zd15xdrXiZzlMHFrj+dDZX46mFWtBtbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PYC5boGs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB41606A329;
	Fri,  6 Nov 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PYC5boGs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BF91F0089F;
	Fri,  6 Nov 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989498;
	bh=ZvuT8M4a+hRHT0Em5cPPU6ZYr2bIQ5wlJIOKEO0nbxk=;
	h=From:To:Cc:Subject:Date;
	b=PYC5boGsGuZo0LMhz9lRlkri3CoS6I7rUo+Yvl8aoSslH61X0kSh2BhtmiCq9SzRp
	 233XHGKYSHdj728+9srY+2AafqbYRWsYrPnszLRHi1YRqWgoLf0KwW64s2efQ7DvHS
	 0BOZAscxo+s+Qrrsli5uRE8N2NMFB1CByrbuBLzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.225
Date: Fri,  6 Nov 2026 13:24:54 -0500
Message-ID: <2026110655-upright-drained-3d9c@gregkh>
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

I'm announcing the release of the 5.15.225 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
      Linux 5.15.225

Jan Beulich (1):
      xen-netback: defer xenvif_mcast_addr_list_free()

Juergen Gross (2):
      xen-netback: Fix UAF when reading statistics data
      xen-blkback: Avoid UAF when reading I/O statistics

