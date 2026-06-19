Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85857330B07;
	Fri, 19 Jun 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901437; cv=none; b=goselWMjCgCk1DzgTbBZcwxI282HpByTqMTB2CN7jdRLp6+HIh1HBPtsVso8wG6ZJZyOlq3N1WoSfKnNzQouy98JDfJ/X4jKQVCOTtJaztNEEfcHLI9fw7wEm0Byb90dKIeC0YH/t1Q22wrhMWzqfeVc/zlZ0sejN4z3QRdUZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901437; c=relaxed/simple;
	bh=iFfs3WLa/OJizP0KzsUBLr3lLPEkBA01wgfbq3aVAj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vhqn4iG/ugycn8BPlfIyvvfX3FDEK5fo6F6CGr8QKzyPgVbxD3TcMHl0+ze4kBpO3vyIrkfeWd5wMu66rQZ2pAXjm5YYxch98k2W5or61jKhIkcurhJLznMfaC6Kl+sVJgs8EutzvKT3wAcBdVspfAgh3IAroOwwJnq8VYR3aBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 895C1C0879;
	Fri, 19 Jun 2026 22:37:11 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH wpan v3] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Fri, 19 Jun 2026 22:37:04 +0200
Message-ID: <178190141126.801651.17491492135340386862.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520105750.30144-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260520105750.30144-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Shitalkumar Gandhi.

On Wed, 20 May 2026 16:27:50 +0530, Shitalkumar Gandhi wrote:
> ca8210_test_int_driver_write() and ca8210_test_int_user_read() exchange
> a kmalloc'd buffer pointer through a struct kfifo, but pass a literal
> '4' as the byte count to kfifo_in()/kfifo_out().
> 
> This is correct on 32-bit (pointer = 4 bytes), but on 64-bit only the
> low 4 bytes of the 8-byte pointer are written into the FIFO. The reader
> then reads back 4 bytes into an 8-byte local pointer variable, leaving
> the upper 4 bytes uninitialized stack data. The first dereference of
> the reconstructed pointer (fifo_buffer[1]) accesses an arbitrary kernel
> address and generally results in an oops.
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
      https://git.kernel.org/wpan/wpan-next/c/6d7f7bcf225b

regards,
Stefan Schmidt
