Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7AE377ABC;
	Thu, 15 Oct 2026 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075996; cv=none; b=nCMMGrq+btmaXTT7vpMcHcwIZoNfCFYHWA8jMELKzJCy/+c6uE6V8p3dFFWJT9I/Zp+QLAkficCkay7ePm6JuCHFT/GNDXsne4YX4jZQuKdElN3ugaS/Va0LkmbexDcAHD0Q4cOFbbXP+ew8TcQ6/NffNWzuBIpRX+sMSSJNXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075996; c=relaxed/simple;
	bh=RNHLIxQk8X6ooDPIH8L6s/qAd8Q+9omHz90xlgl14sg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mEHW/NhC20C7ncaoV1Gcclw93uipxlnHm12fNYZLNerofbxkoD4U39T6Xca7kxDN2s/3WMc93f6IpnFjBDq3u2fwGgFpxaThQ13ffU6/kgiGEjQjp5hpiHNj/4BUHRnfTiX6HvFYdSr1m4JhxlGICYYCzfkPLB0M+M0x1Sho6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCuGbF+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCuGbF+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F711F000C4;
	Thu, 15 Oct 2026 14:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075995;
	bh=nNFolf/5Pl7iChkD4w7HfQEmWjzsXeGSR9BvxDfi2Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SCuGbF+3BzLPq1hYhu9WvfwrXLmaTC9RkD7xRSAM9XGxwFZf9WOSMCR338nGihHWO
	 2YtQ1HHQhWee8KuU3YX/bHTXVQG74GP6t13uvcTdGLNRSpeMyQNChYnq8KgQdlUSTk
	 FWu0R8KPVq6fJ3EIqojulWvgt5gb36ZlzldJYZvEPVT259Cd1vctQJcfvUqS1T8v0w
	 Sk4s/ZSYbq0zU1+K5Gt2nRpkO5Gi+pmGSjCuhTO5cPKLpgTcuAKTq9gyYi10s4SWjF
	 mV9urKuffWOfkH4qdXy8wuBFXnRfJdu0q4lOuPcmRtbG+/5bVtzelS9JmrF5IWcSPL
	 E0UJkufitZ/1A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, tmaimon77@gmail.com, 
 Weibin Liu <liuwb@xiaopeng.com>
Cc: venture@google.com, andrew@codeconstruct.com.au, yuenn@google.com, 
 tali.perry1@gmail.com, benjaminfair@google.com, avifishman70@gmail.com, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
In-Reply-To: <20261015-npcm-fiu-uma-datasize-v1-1-7dee91cadee6@xiaopeng.com>
References: <20261015-npcm-fiu-uma-datasize-v1-1-7dee91cadee6@xiaopeng.com>
Subject: Re: [PATCH] spi: npcm-fiu: limit UMA data_size to the 16-byte
 staging buffer
Message-Id: <179207339706.134795.190497503693781801.b4-ty@b4>
Date: Thu, 15 Oct 2026 15:09:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RNHLIxQk8X6ooDPIH8L6s/qAd8Q+9omHz90xlgl14sg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuvLjeo6c2XVD5XKDgm5pNjM9fvch4rRTZ8aB/1pumN
 9U3BffUd5SyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAixc0M/+OqloVFphx/XREV
 d36BsUxy5QOra+v//vA9kOLtus5Y7jnD/8BDR33+rFiTJnQuKbB8WeQi9wc8zu+/Z0Qzqv9Xfxy
 fzQcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 15 Oct 2026 10:10:12 +0800, Weibin Liu wrote:
> spi: npcm-fiu: limit UMA data_size to the 16-byte staging buffer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: npcm-fiu: limit UMA data_size to the 16-byte staging buffer
      https://git.kernel.org/broonie/spi/c/f0be928a4138

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

