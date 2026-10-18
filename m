Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CD43B4BC;
	Sun, 18 Oct 2026 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356094; cv=none; b=pJsoe9WgfWIJEPMPowRutgu9UPao18Dmr41eLi9jqjtB403k4biEEFJpBDgKmUYXvaKDlHyDjhPU8DjKVKk5Rzmuh1d8BlJCuAVgwtuDLKT89AnGQdeNsdDs+q1wKCf8ZONMgdbp3ouKlOFt4xypBippLH1zozE5KqvNXP/zkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356094; c=relaxed/simple;
	bh=puRJF6b4XSquydSVBlYDP3nIomGvJq/gteOjU5paHDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lTvIW8dOEn2eO3JfD2rFo3i6pAqo6d4IhZdK0mFZC19S0j3aL8l3DMMYaaqt7yGRaArd1ZLQE26Ev3OWzWL8+HCczOjVtEYha7I7MtuIh3QNKLaETGCbV9x3AhyDVYG7HOAMAUxwktV2vpe3NnL2f21qasdmsyqWFMOl8r8raQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+Iq1pBt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+Iq1pBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04A21F000C4;
	Sun, 18 Oct 2026 20:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792356093;
	bh=KZl1E7ojGN4UcuQl+IdP+UtPm4+3Dzwnc6HOFL1y8LU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T+Iq1pBtHwyque6J9oxwUmCpSdytj3Ee9KHh2R2JfnacRVOaHb9vfVX6xlH8vLh9K
	 sfpn6ZfkIli/NCGK1hhAQ0i+6f75kO713KyLgZTOadD9wXcAXW1RivzHKE8dFmJHeR
	 ijg5G3+bzbNVAvI+ScKXS16+gkyod22KBcQePHfagmPy1KXraHoB5iIjSuLBCrrLvI
	 nGJNqlivzcZA31JBlw/7hddeW5yH+I6BxtmQuhOZ6GjBfsv/+GgDaZeW5jeRqZxUAI
	 sdjvRgFNRU6p51ddQFa+E5JYLMWJ4fF0KB7YWwy4iNBtgq2Lfj0l/SrkjHtz+3Pbvb
	 az5gF6M9q6Yfg==
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: jth@kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261013054339.77477-1-liuwb@xiaopeng.com>
References: <20261013054339.77477-1-liuwb@xiaopeng.com>
Subject: Re: [PATCH v2] spi: ch341: handle transfers without a TX or RX
 buffer
Message-Id: <179232568178.3162228.6393530462413113880.b4-ty@b4>
Date: Sun, 18 Oct 2026 13:14:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=broonie@kernel.org;
 h=from:subject:message-id; bh=puRJF6b4XSquydSVBlYDP3nIomGvJq/gteOjU5paHDw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLKu6n3WP7y2bdLSeKlfZ1l3mGqmfyldFWQieP75oW8m7
 hm1FYc4OkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRLCOG/7kbfnBxeex30Jnk
 bPYp4fPLkD2p4s2FtccF/8u2vG7w1mH4p5A5+Z2J9ZVD/Gmrmronh36fuMk4vi/9SM/zuric0us
 5LAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 13 Oct 2026 13:43:39 +0800, Weibin Liu wrote:
> spi: ch341: handle transfers without a TX or RX buffer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: ch341: handle transfers without a TX or RX buffer
      https://git.kernel.org/broonie/spi/c/84182c48999f

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

