Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E23D1CA5
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883305; cv=pass; b=EKIl2VBbZdcif3vkHNJlDX9xNt7cIttwrRnZUgsetFyJs+u4stZIblrqjvGtFwjQsKG5VYViZ34qikMlJhjt2P0YNWWsVaXt3rILqEom2dDArwTPqXSGnso9Ok8FeE0Kd6BsCPfHAvFn5sA8SpInB2+F3m5HiOb2WKwZTJHPZ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883305; c=relaxed/simple;
	bh=oyMUeXYKFEbJhSnscvMS57tQaJnf3q6yjGRq18036RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=buk2P2Y9FkbsM3RmCGPRH/ef0JTlqneXYr50K0QF8hsAzgKtIXHjQQ3umCaOmd01D+a8cDO8PvrQfr6VgAlQD3L4GZ8trJuEmkhOC3dQ1UyoHOtkaS/Mc2bPrNNJCmbtwSfDeUcxcAhliE0OV55IYJaWx2COjFh/QLYAo/GPNQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=skHVYdE5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SBTNwXVX; arc=pass smtp.client-ip=81.169.146.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="skHVYdE5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SBTNwXVX"
ARC-Seal: i=1; a=rsa-sha256; t=1784883301; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HJwPA2E3GPnPtjGazWaROYpe/s9igXEEYMsr7cAxBK9NQr4M4E/kKe9JQJVlNptaOx
    PTyIz4hxXt03sa09IK3uAUeJ2VvaFgtklhIel6ba8JxrD7r2QJg9F8+iSKYjruMoEATQ
    wqQeuw2G/L1DooVhn5of2j2Nhjad51puWMtE3Ke7lupkyjm+H/Ij6SSqkk1pJLgeqxjm
    M57wqQwt/0FqfzIs+mNbXmaNPe82ZSACjuLa2f9hVzJ8Omj3XBUgsAmzm17Pz/58AmNE
    mr42ebs+S8PEwr876UoUV/HgcOigc6YAqOocviWJPfqbaOTwjt5H0IBGX03LfkQX0FUa
    zrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883301;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yAQ2456XsdnA5StaPQ0mqrtoAmWzULdDn5N0LU226ss=;
    b=HEMN8Yqnmndr7a6dJPBeYQeGAg5hd3Ru92GiWeeghWYZ1N1ywdxO7w2gr/85wvYmjQ
    CSx3ze6UED0iGnMt+qSN+VWlMSNWlzsb58QkWRJDgwHLb8U5gexfS/7XaW6RYsF30k/M
    KvoCqTP9p+64H5o0e4trYEIy+iI3r+bU3C/4DZbsQ3WjSx+Xueog+Sah9iUtFtk+/Xy1
    ig+DsUFclgur0XXkJcR0j7cLpDP0R5yDcRahqr4B4O+yavhqgKKR9jh6YOureauVJF8+
    McG7eLOP+/rcJiV0Vu77a6nTi8gDcYsjCt/syXeXnHHMSD0J5zfhv0Mtnlwawa8j/XEf
    OeUQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784883301;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yAQ2456XsdnA5StaPQ0mqrtoAmWzULdDn5N0LU226ss=;
    b=skHVYdE5PKENtrrJieKA+1tmpJ44KC2cOREZIYHYVMprYAoHK1hS1GygUy/mOGG+Cg
    Pm6QtPqpcCsX7KAn6PTzo/ZaWSiYOWt7HB9oDfehMU76KliKPkMl9yI/T11ioN6TLLjy
    XdHN7ke0wNbuHSBaJeq3J1cPHxHDQH3KlQeZRHNnKpw6buNyQ8W8ReoRAfuYiVil54tV
    tI4RGl6U94gIsELTNyxKHMrPLhNCEIiZhDA3o7JNY17TRozAWAxrC4AodpslvEEVYwYM
    zt/IeOCB1jrB1pOHogkpIm1oxkPoXwhktm5almG4WmzcK3WLD0ILRQAWcu1MU+2Lcv1p
    cIpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784883301;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yAQ2456XsdnA5StaPQ0mqrtoAmWzULdDn5N0LU226ss=;
    b=SBTNwXVXOqC3JJxHcXJZIMNN3qfUwQdBJucvMJTR/05Alv+GaTYKFLuEKOYWtg1J76
    gwNP3T4mYJf27xEzYYAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926O8t0ro9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jul 2026 10:55:00 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y 0/2] can: isotp: backport of 2 patches that failed to apply to 6.12-stable
Date: Fri, 24 Jul 2026 10:54:52 +0200
Message-ID: <20260724085454.14263-1-socketcan@hartkopp.net>
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
upstream), which failed to apply to the 6.12-stable tree, together
with "can: isotp: serialize TX state transitions under so->rx_lock"
(commit cf070fe33bfbd1a4c21236078fadb35dd223a157 upstream) from the
same upstream series, which builds on it and would otherwise fail
for the same reason. This is the full set of 3 upstream isotp.c
patches from 7.2-rc3 minus the 1 already queued by the normal stable
process for 6.12 ("can: isotp: use unconditional synchronize_rcu()
in isotp_release()").

This assumes the 1 already-queued isotp.c patch for 6.12-stable has
landed by the time this is applied. If not, please let me know and I
will rebase.

Oliver Hartkopp (2):
  can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
  can: isotp: serialize TX state transitions under so->rx_lock

 net/can/isotp.c | 280 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 213 insertions(+), 67 deletions(-)

-- 
2.43.0

