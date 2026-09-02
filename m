Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B683B995B;
	Wed,  2 Sep 2026 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337738; cv=none; b=nBiZLKFWla3vvAPNAQFadzShHmVL2BXeFRHKLul0Yflgy14UlCaTlOhb+hhQOnRIBRhdHQSsrI7DBE6a+7UGWUK4SewCD9SYnm5knidACrq4f57eIWlQIcWn2uMsN6EONBjZy1koGQXwt78iIeQN+iHdDYAiRrRjosP0OFJw/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337738; c=relaxed/simple;
	bh=KPcY1CeLx63D3jmUUoLq6g4LUo872zJhRrfHW8jvIO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjTAnu6cCXZa8Fv7hqb81E0uXE9C6NNhvDqbw18zzOgM+ebwilwGylAL3xOeUCkXZWaxbdAi3N+UvFiDtoX+4A3by5IE9EqZbTGUGnKZi1o40unQnsV4KqKTdrt8u0KqRJx4EHro+vr2tKl7Z6aRVcbtK77/I5KoGP9UVzuVNXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 31CB6C0182;
	Wed,  2 Sep 2026 10:28:53 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	David Carlier <devnexen@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	stable@vger.kernel.org,
	syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: hwsim: serialize pib updates to fix double-free
Date: Wed,  2 Sep 2026 10:28:46 +0200
Message-ID: <178833771652.3405215.14206348137009796373.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709221858.158063-1-devnexen@gmail.com>
References: <20260709221858.158063-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello David Carlier.

On Thu, 09 Jul 2026 23:18:58 +0100, David Carlier wrote:
> hwsim_update_pib() does an unserialized read-swap-free of phy->pib:
> 
> 	pib_old = rtnl_dereference(phy->pib);
> 	...
> 	rcu_assign_pointer(phy->pib, pib);
> 	kfree_rcu(pib_old, rcu);
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] ieee802154: hwsim: serialize pib updates to fix double-free
      https://git.kernel.org/wpan/wpan/c/979d5b8de8ed

regards,
Stefan Schmidt
