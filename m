Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EF13AF2;
	Wed,  2 Sep 2026 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333780; cv=none; b=o/I6IsPP2BbeaB+8lZ9y9NwiUjHHLw+67bUnMC+wXMxfnBy9N1tkHjbP2FU5R/9PQVuMT/DJKK9+XaoaRImITzV2HvvkQI9VpRwbgFMQpnUh1x5VDj4RBCPG27QtaubmbZditl8Co7buoF9vY8uC3YQlfRV6pjBPdXpqL+yrnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333780; c=relaxed/simple;
	bh=dkbN5N25xtg40gagFcwFSRxhTskg73lhcRhkjKigbmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Te7lbBqqFRPNgXmqfBx5okT/S3OHnllbsxfgLHExprv7beAS4y4Xc+stShg+UjXP7nfaLRhQfIHvXj0bQ/b2yt9TOfUcKuGESkKlL5asRXVDUC5ByYPykYhS3p2X9F+aO/vTf6OeoW50zXAsGVNguc+OtHXEv6bdjIJXc3t9zJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 233B1C05C4;
	Wed,  2 Sep 2026 09:22:54 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: linux-wpan@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Varka Bhadram <varkab@cdac.in>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] ieee802154: cc2520: fix FIFOP work use-after-free
Date: Wed,  2 Sep 2026 09:22:45 +0200
Message-ID: <178833374261.3357241.2572153348381781124.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812061714.175966-1-fanwu01@zju.edu.cn>
References: <20260812061714.175966-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Fan Wu.

On Wed, 12 Aug 2026 06:17:14 +0000, Fan Wu wrote:
> The FIFOP interrupt handler queues cc2520_fifop_irqwork.  On removal,
> cc2520_remove() only flushes the work.  The devm-managed FIFOP IRQ
> remains active until after ->remove() returns and can queue the work
> again after that flush, allowing it to run after the private data is
> released.
> 
> Disable the work with disable_work_sync() instead of flushing it, so
> the handler can no longer queue it once removal begins.  Destroy the
> buffer mutex last, since the worker and the stop callback invoked
> through ieee802154_unregister_hw() both take it.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] ieee802154: cc2520: fix FIFOP work use-after-free
      https://git.kernel.org/wpan/wpan/c/ff5891b266a7

regards,
Stefan Schmidt
