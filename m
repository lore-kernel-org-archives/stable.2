Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623384;
	b=jDGRcnR2J+Kww7ZE8c6kbIh/bOWXL3mInC6PHCllnGZWps2iijuxj/lgkpF88DsteUow
	 SZjWYKbH+WOA//0YDe2viWDpA3aNGNvXcWRY3iaqwQyGbjqkkvO0OdfkXKBtimag09Q9C
	 L5+R7SCLaNcPoAtz5SRujTcrA0TonTGIPnA7UD0Dhd2pJIAwSk2B4qdQXF/fwxTDSQSsO
	 MRCrn557MWc3xAXEPZWSR898EMhjGmtNU2d6+5BnaQ6d2TuThV5EpaBo70RtYSGGUoOj7
	 Ev08S4yf5VK2e0Hrhq5WoWXkxXs7KSGUKivm8rgm+6YH4bVJ+LpiKU0y0AoKF69M8+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623384;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=YfQnjtfObBvofioEDPLC2oMr5G1S0KeEw5o9b3Fvb10=;
	b=vmPqHu0vyWPb5UfQYiFT4cW8qZu50/hkda+Cld9LHe9dB+5wWQXJiBE9E93IDxVdehmD
	 uQtD+1eHvxqxbPeFdymIwj0Tv/PcgOnHHCd3tJCJVkHP+oCf4dJGTPWVE7nbY2DXYPxv3
	 wD3pP7896JZIsoc9M2CLV9SbMv0XkgTnijY4436qA/Ux7TVzHpArTF7C4SVFh+Hp0wgD6
	 nlsJgSNSavgBxjiPX5jJBgoQY2YbzAtYfiUF2g5aNl2je9n9D4LJq9V829btZDeClczBO
	 uTleXpv8GJ4TU5K0OZd5PwrT61YHZpdL7SiJ48pxpbsYLwtWM1C4Y2ZMprcj2Nbm5Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAdIqlsZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B8606A327;
	Mon,  2 Nov 2026 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAdIqlsZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA431F00A16;
	Mon,  2 Nov 2026 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623384;
	bh=YfQnjtfObBvofioEDPLC2oMr5G1S0KeEw5o9b3Fvb10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UAdIqlsZQ9uxtM+3eF1J4bYCsy2DunJl4W+UcYLCVWq3+lVSXFTELovnA0stYV0QU
	 OAt0kWFqysgeCvRH1U/T/EzDSBytJHbGdnjEwWIjo8/dNvtji3txz40cPH1TR7Rhrz
	 vwm2rjeUkAcoZaRcqHZh5dmHJeMofhGgJ40rETBDfq8fPgKoY1zkqTop1DrXJRY0KE
	 tbljoQ9Kb0AQim6VyxmvuesBaAKqr+siTuSPoybICe/XmKS83Z5far4tMyFFSi4Frb
	 b5OTxkYbxjtwrv8ILhWC9ud1Ola0kM5C9lf9SX+Fbs+2gCGtbZUwLGk6oikknO6e9H
	 CDTRcYpbdoalQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 763E2231051D;
	Mon, 02 Nov 2026 12:43:02 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Weibin Liu <liuwb@xiaopeng.com>
Cc: grant.likely@secretlab.ca, linux-kernel@vger.kernel.org, 
 tomoya.rohm@gmail.com, Liu Chao <liuc63@xiaopeng.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261014-spi-pch-bpw-clamp-v1-1-3e04b3ac5106@xiaopeng.com>
References: <20261014-spi-pch-bpw-clamp-v1-1-3e04b3ac5106@xiaopeng.com>
Subject: Re: [PATCH] spi: topcliff-pch: clamp DMA bpw_len by bytes not
 words
Message-Id: <179357725181.1716893.15329166806958652295.b4-ty@b4>
Date: Sun, 01 Nov 2026 23:54:11 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=35pXmCs8iepxveQPbEokYq5eBfB8CGZkg+WfYlZ7sOI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetIatu3lH+eHjvJtn5sjLbHr3uG6iY5Hy69OPv+pLX
 hBYGeDJ0lHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJMNsy/PcvsFBT5PcvWu3K
 UcrKPue28xf5aO25/9KvV95gevLJ/CXDb9ZFlxbOntBeGJSdznq7cmKiUofx/LoXV5onrJLft2M
 mJwcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 14 Oct 2026 22:12:38 +0800, Weibin Liu wrote:
> spi: topcliff-pch: clamp DMA bpw_len by bytes not words

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: topcliff-pch: clamp DMA bpw_len by bytes not words
      https://git.kernel.org/broonie/spi/c/3515e312e096

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

