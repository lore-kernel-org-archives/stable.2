Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685053;
	b=wlC2vGmV02zopNbMKWXlibcccwYRCtolpocYcd7Xhqmky1uqNnUmLpfPwXwnoMS6aEbF
	 WtXbHutP9Dj1vTv5ZDY1ewreOW1DABoaH/RkvLXI3d/oytFCLoivkhI//D2itB9ZZQ3qy
	 PhDuIGJHZ/TTc2NGw3lxiz9bgsaDMQm3NE/4DSv3Bz3vMbErXfz216n1fX4tuBxIR0O8/
	 CSxIudo4H/pJ/rAXWG4Ur1tONfv6DWyibS3vKB4jaK5L/4d1aqHQhBGwP0Rvv25P28ZXr
	 e6ZwkPVxGbjjcif/0CyEaAkAv4NsyjDRjbfl6NCPK4f5YGBNkRjSWjrpQIXmHZdqDPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685053;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=98AuoaBy6scAqdpD1bFpY8R263vuCvhHxS6e/zP2npM=;
	b=xTjQE0IKrkNipZUqajEbNVGXKP/+I3WVFmuxo5srmxHk2SGTtiD8SHcWTku+RI2soIl2
	 Vq00QRLz20xbtE9OL2Wy2sWNrjRjmWzoEQCxo57MZAP6eT2uV3y9pFisD5oeYxg0rlYQn
	 6RrSKhinijEiJ62ZTMI9Gk09odJ7u9Okvz+NAAZFokAoL5uZdYT9emlDeeb2Wt1oajbh4
	 0FgD02eYMpw9uI59oGtwD4MXSkVRGmpw2Uemqs+TNUF1WySBNy85fN0lZ1+r+I89uAV7f
	 XGx94FkRLouYmp97QfHe3g8DHSbRyDKIk4LYCKIwqH7vS087zF2cuRV23DP9BUsQj1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEA606A31C;
	Thu, 26 Nov 2026 09:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76BEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id EFA8AC02DA;
	Thu, 26 Nov 2026 10:24:10 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	zihanx@nebusec.ai,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] mac802154: validate pinned interface before beacon transmission
Date: Thu, 26 Nov 2026 10:24:06 +0100
Message-ID: <179568504196.1941682.10640221246377134318.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <179378621331.55520.8126896786309171541@stu.pku.edu.cn>
References: <179337523079.51423.6573078122047317758@stu.pku.edu.cn> <179378621331.55520.8126896786309171541@stu.pku.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Yifan Zhang.

On Wed, 04 Nov 2026 17:56:53 +0800, Yifan Zhang wrote:
> mac802154_beacon_worker() selects a beacon request under RCU and pins
> the corresponding netdev before dropping the read lock.  The transmit
> helper used to read the request again, so a concurrent interface switch
> could make it dereference an unpinned netdev.
> 
> Use the pinned wpan_dev throughout transmission.  Under RTNL, verify that
> the request still belongs to that interface and that the interface is
> running.  Build the beacon from the protected template while still
> holding RTNL, then hand it to the locked MLME transmit helper.  Free the
> skb only on errors before that handoff.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] mac802154: validate pinned interface before beacon transmission
      https://git.kernel.org/wpan/wpan/c/95f866334454

regards,
Stefan Schmidt
