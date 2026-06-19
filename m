Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD0305679;
	Fri, 19 Jun 2026 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902038; cv=none; b=AQxsybLRvr1DW0FQJXf8HCmOtxciGR2iorLhrdA5n7AZc9cyamru3xOAYwfepbp07OMX6L77HbGHS3mQfRpbI9oxIbGgbF30pLeCb2O1U1swhnDTPHmklv2ivsjRY+rpPasAcAOH2NGH7ri1dPqW/jbThg53z1pW/mw9+rTcFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902038; c=relaxed/simple;
	bh=W4sjcb3Prlb75DVEnVTqZCcKEmcVLgxZ4fTRXOtD4nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUQIn17+SN3tqEGjb1yfx3s2ygAxnzr5nEMrQgKaJuRP0valT5OoRimI56eACuk8CVEnd5VBdLTUHOMsIkBg6ywL8XQdttbIH3S1lkQU8NhzyXwLRLIgWJH4gUQFvlbCwroVz6F2HIQ3m3/RzPiVOPxBcHEiSKg5sSxuE3Uxaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id E2F0CC0221;
	Fri, 19 Jun 2026 22:47:13 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	aleksander.lobakin@intel.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: llsec: add skb_cow_data() before in-place crypto
Date: Fri, 19 Jun 2026 22:47:07 +0200
Message-ID: <178190201874.812652.7427337929247870005.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526183726.56100-1-doruk@0sec.ai>
References: <20260525161806.96158-1-doruk@0sec.ai> <20260526183726.56100-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Doruk Tan Ozturk.

On Tue, 26 May 2026 20:37:26 +0200, Doruk Tan Ozturk wrote:
> llsec_do_encrypt_unauth(), llsec_do_encrypt_auth(),
> llsec_do_decrypt_unauth(), and llsec_do_decrypt_auth() all perform
> in-place cryptographic transformations on skb data.  They build a
> scatterlist with sg_init_one() pointing into the skb's linear data area
> and then pass the same scatterlist as both src and dst to the crypto API
> (e.g. crypto_skcipher_encrypt/decrypt, crypto_aead_encrypt/decrypt).
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] mac802154: llsec: add skb_cow_data() before in-place crypto
      https://git.kernel.org/wpan/wpan-next/c/84a04eb5b210

regards,
Stefan Schmidt
