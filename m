Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2352246788;
	Tue,  8 Sep 2026 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828863; cv=none; b=S9bxTaduK+M4372QEhAOax8bqWFp0MELz93O5EUInECWHw4oq796wbQtvUwnozY/yC7FjL1/jSP2x+Xa5CtRvyv5QzBTYqJcWMLmAlcRKEDXoVxGDfhhQdRDpnzazBKodX0x+CVMWe01iE9Mn0v+fSIn3t+HOgekQMgpGDEBSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828863; c=relaxed/simple;
	bh=dfXKCZCTrmMHEIP1fMUzUgoaFjNRQ6/hGTnzpk3CbK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=radpBkiWNg61udhFRQV2EnSzHDSllCIlkXDdyxUMhHX7q9Y5gjecRWz6bfAa4ThA04/I+vB6ZRUQeqxSMA4ajQC4w6Ezy1QFm3kSGQU5BU0+e+hgmohO3LKo0psH913fHf7+fwHbO598xppTEyq/YVdg9Y2LKR6fDCW9Uxj+TJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGTLK5jp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGTLK5jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CBF1F00A3D;
	Tue,  8 Sep 2026 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828862;
	bh=QGb1T+uTZL9spTdO1wQjRhLL/Tbb8sVQgAMxCyYo4rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nGTLK5jprqkqqscsE9aDoRoInUVKSe1IsnfCr6glOEUgaiwT22LCPaUlZfbOTvQ6R
	 8k8ps1PZK9saMNBbMsv9LS83SOm7kxf8ywfgPawT8BqoYcrAUNnyRPGidghNrC/GoW
	 ZjVZdGxsAJG+Q3yCr5jicjJx5vICE2OOaY49bH768pvKAOpNy++mXYtOSvgmMdlp4h
	 a7hkcZkwbofaAoxa6gFYI3pGBsefPZgGXUstxaKB6e1LU9McHcX9i6CvbwmaWomjkA
	 6fYqG3PsVwma4VYEO+O3DWKChDz3J6S/qBmxDbxHsjFztdkZbE9UZNaSk5VonQcXbx
	 fdjwSh5heJLXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Stevens <dlstevens@us.ibm.com>,
	Cong Wang <amwang@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.1.y] vxlan: use pskb_network_may_pull() for transmit path header pulls
Date: Mon,  7 Sep 2026 20:53:54 -0400
Message-ID: <2026-09-07-daily-reply-0015-vxlan-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907-cve-2026-74474-v1-1-58df9a9a245b@bootlin.com>
References: <20260907-cve-2026-74474-v1-1-58df9a9a245b@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In vxlan_xmit(), arp_reduce(), and vxlan_mdb_entry_skb_get(), pskb_may_pull() was
> being called to verify the availability of network layer headers (ARP, IPv6/ND,
> IP/IPv6 MDB keys).

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
