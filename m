Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6E497391
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591364; cv=none; b=iiTUXyqIHG/SzZo7jqgC3ADrc6oniBByLA2eXC288Wwqn3biYjFs7ui72rwKDqpX/qQI85AU8oCg/5iaH9muK3+ICDW12yR3/4TsGOuZicf/hxOgh031PFe7ru3SfxGh6OgpbP87Zkb31yY5wPxOHLevVs7AK2+A+F8hfkwH1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591364; c=relaxed/simple;
	bh=sNAPtxXZf1FTE9hYHcb1uniedqTwTRiisvbe7zUL8Xg=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=KOG7+IazV7nAfiuIb0XEeQur9o6fvLwWYuFtlvb67W+sMjSSeOqolGnl3U1Z3dDL8+Zxi8MN7BE0R8NZrkZ2dnY2UzAh/1JnB39JoXsx2ckQ7wBNQ9ok+LkaCbcYW/y7lQavMjga6qTtacgfx2lbLnZLAKaiFjqQsQ0OtHespQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=KuZuK/PE; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="KuZuK/PE"
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id 083F02E5E58;
	Mon, 28 Sep 2026 11:19:18 +0100 (BST)
Authentication-Results: nabal.armitage.org.uk (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=armitage.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=mime-version:user-agent:content-transfer-encoding
	:content-type:content-type:date:date:from:from:subject:subject
	:message-id:received; s=20200110; t=1790590742; x=1791454743;
	 bh=sNAPtxXZf1FTE9hYHcb1uniedqTwTRiisvbe7zUL8Xg=; b=KuZuK/PE/LvH
	cVYm/Oru/GhjW7vfGx7AFxfIepUftQY5h65xR6P60XgHFXqD2MFJyKM5OJKVrAAw
	iMyFoWbOgL9MujaaiPldL5nSTqqGHedMo+By3v/N3qtfoEakcIuOWAp89hhJSwjH
	/cg0FoUe8N4uHni1AAiuqoUcVqMephQ=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from zarepheth.armitage.org.uk (zarepheth.armitage.org.uk [IPv6:2001:470:69dd:35::124])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id 066532E5DD9;
	Mon, 28 Sep 2026 11:19:01 +0100 (BST)
Message-ID: <98db080b41f533cfc4abce84b6b04352b535c5d0.camel@armitage.org.uk>
Subject: [7.2] Please backport 6c096bb08de9 ("net: allow IFLA_INET_CONF
 messages when NLA_F_NESTED unset")
From: Quentin Armitage <quentin@armitage.org.uk>
To: stable@vger.kernel.org
Cc: Quentin Armitage <quentin@armitage.org.uk>
Date: Mon, 28 Sep 2026 11:19:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Commit 6c096bb08de9 ("net: allow IFLA_INET_CONF messages when
NLA_F_NESTED unset") resolves a behaviour change introduced by
commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly"),
which was first included in Linux v7.1.

Please backport 6c096bb08de9 to Linux v7.2, since it causes all released
versions of keepalived to function incorrectly with macvlans.

With many thanks,

Quentin Armitage
