Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186998;
	b=FwxxV+0EQMHYA+LbDRfzuRV7VzB+VzfT86uczbnmtR7Npha4XABJKKGB2rUGdix1M79v
	 qBOq39qZ9QhXBZscgsjD0qH/9Hh9zFhJTVl0efExqZM1MceCYF/tFjQYfSdEUtGWlSbbx
	 7A5j2VnKuakkdH4oK8MLJn6nf+9EsQDFKuId88ixMWd0f9Hhe6ibt8vUqIn41T7bAfZFE
	 +PsMxp8cSXhOMBmevt0UTlEgU8lWYoTmxL7/k7nlang/CcQUH6aa24iCgC7CmLns1rzep
	 tMp9p2YoLKyufgWi20VfhLPn1yoqudqLdTx3H3GJ4XyRLszCpvAh32Ef4QW7Uy/aGIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186998;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1JNEW8HYvKizQjvMBvCBCVcaKnMKRs6NVB4+hVWjxFU=;
	b=F28KnsMer2Ci4GXjDLYfVrojFyH2bkd5RisnhzWG2EJYBCEqSNq8CzWEUVMwCYtchDdC
	 rRr1Mugmk+Bjx3EjfzI92nHj+QQP79h2wFOLbX0bbvYM+Fbv7EnlVlXb49w35EywDRPgn
	 xAQnRMABipk6nFw+dTlqNxT2f5RSBSIj/V7XHD+Q972mp3SCtmhS+7Uk1wghw0g5cTyIf
	 X12d2CzW8Gik7QccwHGIlEsPqGQCvoAdWrgfxdviJ03cd+fsfSMBtKRhZiBrm4zHA8HlX
	 7rBopePutSEoNILMFgQMMs8b5Gxg2R+trTwZtH/7Fp0NPprCJ1+DYUPlOJQ5lSTrTsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="faqz6oT/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B163606A31D;
	Wed, 28 Oct 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faqz6oT/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51221F01825;
	Wed, 28 Oct 2026 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186997;
	bh=1JNEW8HYvKizQjvMBvCBCVcaKnMKRs6NVB4+hVWjxFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=faqz6oT/ri0wt8eoSK6ioOgDFgh9ZvAJAa1CKbOnfrClm+6aij041uZW3YtcJbNnF
	 W/AgVn1gBM35OxuIe8YWZJP3W3vhhdVYZJVoTv7CTyY2spKNND1OVEG00KThWZeLZG
	 kzRv08m+QeFeMAEjxbWCRCFA21xbdokB0ioPC1uMeqxDJb6wnzdVU3hpI+DhujgDHe
	 +h2kub+2REIjiwAx95+YKz7HvFbaEkv17AzSpxrdKDYaZGcjJkGPchSV0/kzjNbBy4
	 mikAWPfvGxYImEiMhW+5n6ObFWWo6T6KRi0mMAF+YIu5gwAxT8p8TC++oTiumqrzoV
	 7cSLznagM2CqQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 06D4A1FF2804;
	Wed, 28 Oct 2026 11:29:56 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, stable@vger.kernel.org, tiwai@suse.com, 
 perex@perex.cz
In-Reply-To: <20261027144655.31988-1-peter.ujfalusi@linux.intel.com>
References: <20261027144655.31988-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: hdac_hda: Keep runtime PM state in sync across
 codec remove/probe
Message-Id: <179317803129.199157.18051933667376321116.b4-ty@b4>
Date: Wed, 28 Oct 2026 09:00:31 +0000
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I1zDWshIiKrvzWcZvIZe162fxBcerYrg3VGUYq0/AUM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIe3tlssynr0+UVxVG8CYtVf979HRdp6/qspOAR266vt
 5XS3kjO6ChlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBErpcx/NOy3/XfQWcpk2HO
 cuNuWf0nXio3d23M9mk7f2h/KbPXv3yGP5wP30x+bV29XkfeT/X3Up6sOMfXvplXlVg09uSuE6p
 NZAQA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 27 Oct 2026 16:46:55 +0200, Peter Ujfalusi wrote:
> ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe
      https://git.kernel.org/broonie/sound/c/99203e8d8968

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

