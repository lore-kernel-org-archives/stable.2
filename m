Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7E3DAACD
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883170; cv=pass; b=gVZyDbTQx2mP7XDHdt9i13MhlDPDdVDoNpaFBMeBD8ybQX40g9ndKQ7Q/E1ZuTzTQ6OzphtNPhDGXmmKUzcO/AssuY622A0cm3UmgTXKX53eB/fbocwvQ36X60/Y7xszPRK8fWZWa19k7ff0xhiA1ZTDTPllW85jY0pGEkVCMrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883170; c=relaxed/simple;
	bh=QW2LFLdgYJy/+P2ZICbACBeKgHZ5HJ5d/6LZ2rHESTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uejeRyXbCj95/h5lLiGA03URLoN7stVWeQeGiReBRfgIk4WuJzg6aQe4zeww5P5eW3Odw1SOOpGwbkHxHYplFsxWwKpwTwXFzq8z645T7dm0kWuvEpia7FhtWE1IzP8DjO4pKfqEDlfnCqS0MJuweBvudyqQn0wyYqMidJNiFIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UauOKlWP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=R4PktPBS; arc=pass smtp.client-ip=81.169.146.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UauOKlWP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="R4PktPBS"
ARC-Seal: i=1; a=rsa-sha256; t=1784883165; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m2CWkahNLjkXzZcIHUlcszicahi8bBmW5nGLjUzJdbYmccs0xPsCIycnrOakqcrSLP
    3vkbrwOQy6iXLdvsJPpt7+IoJS7Dc5RFlh0jA9CZaK+SxIk2dvCG0wK2jw92c8avdrye
    fsfgi49tj8jhOvzDqU1uASfKmSkqyQcEmCC8twNl0it6l300xSGWp6Azzk9wiveswb0D
    RCoYfzEDE2ZiTJ4XnKoKEs/s4GTaTLCv4iQdH69kEspfbnUuSN/f68hjvx4eU2YQSVN8
    eHM9SqWn5XP0VPbHMPvPXg7ldHISoHEHed0UfikBTDVI9xuslxE3+pWcAgB4Qgl1jLPL
    wZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883165;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wYrHQOOLqfmLBZ1178OQU6JGIQSEd3fV4cc0RNvadCE=;
    b=OycnrTyFpEQtNu6GxRJGGHhPx2ixkst7jwYwr4mC+SdX3GgA4sT2KbR7fPenCYsEam
    I8H2j10KwG6MFowkUAcjBssXQ9m87hmUYH5aeMPUrn2eF93O/ZvPxi4lCtiyuPZ2OOYp
    F6yQ+LPLuJJM46nJYgne86VvDvqPsvhnrtlkgpcCxC3oZ04fLiXR+bXZ6umn8H/x+VHu
    n55XWKNC601M5jmkOvusTvb/PX7iXhQ8YEXpCiCoTRZ+t36ChrIPEck2KX0eQhWUqyGp
    PeoLjGJKwW10hYlY9nNUQeIEVJnjigqlrb3wysALyTlcbn/N7HQD/WcY/dshbzUVVLdd
    A8gA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883165;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wYrHQOOLqfmLBZ1178OQU6JGIQSEd3fV4cc0RNvadCE=;
    b=UauOKlWPCFJbB4k2P3MMpfSWCW80yfGN9/MGV+uT3nfguTLZKriEA89vspttwMKIcG
    NO8DDfX/+B+OyRi4KJWEQuuRlrt/+ZevDEoXYwUCL7KQLpwW8YsPkxaY5dey6b3r2Q/z
    nuepL9H7V6joO9E60JqU3+1+H1AFL6+F8nSf4Y9l4Adteu6OXX4dLR5DwEajN1SukZM4
    wx0CbEt3ldGwbvrilF8l9bny1FEjqTh6mmDvMCdIeS1Kjc57nP3BVl9JrTQeMT1D7XMt
    HuDRcRyHViw61Q+Y9HpPvQ65tzkqsqT1rmBlvks5vc7wFtdN7PUZf1hTCTlKOOYXDKM/
    96EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784883165;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wYrHQOOLqfmLBZ1178OQU6JGIQSEd3fV4cc0RNvadCE=;
    b=R4PktPBS6yJOyktzcLpoNslIRqjRXGLXIf0AHwSepiYDhXGLztDTzFfXTphXeayUfL
    gyX++1LU4c8kAlyfj/CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8qjrjr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:52:45 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1.y 0/2] can: isotp: backport of 2 patches that failed to apply to 6.1-stable
Date: Fri, 24 Jul 2026 10:52:36 +0200
Message-ID: <20260724085238.13886-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This resubmits "can: isotp: fix use-after-free race with concurrent
NETDEV_UNREGISTER" (commit 20bab8b88baac140ca3701116e1d486c7f51e311
upstream), which failed to apply to the 6.1-stable tree, together
with "can: isotp: serialize TX state transitions under so->rx_lock"
(commit cf070fe33bfbd1a4c21236078fadb35dd223a157 upstream) from the
same upstream series, which builds on it and would otherwise fail
for the same reason. This is the full set of 3 upstream isotp.c
patches from 7.2-rc3 minus the 1 already queued by the normal stable
process for 6.1 ("can: isotp: use unconditional synchronize_rcu()
in isotp_release()").

This assumes the 1 already-queued isotp.c patch for 6.1-stable has
landed by the time this is applied. If not, please let me know and I
will rebase.

Oliver Hartkopp (2):
  can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
  can: isotp: serialize TX state transitions under so->rx_lock

 net/can/isotp.c | 280 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 213 insertions(+), 67 deletions(-)

-- 
2.43.0

