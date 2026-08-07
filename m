Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A93D3012;
	Sat,  8 Aug 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191901; cv=none; b=MgXCAC+by784119WLa+0swlcivQffcwFkT0Dk4CWGXA2a9ReII5+rZAG3nEPmM9MdHV6ns+schvz1erxxgFg3w0PmfMHbrDnsSwD9wOs1JQp23Ii+4TSNMbCJoD9XILwMNKS+cWi0TpbXfy2fy9qVQTHyOMM4x5dqIOWA8sPaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191901; c=relaxed/simple;
	bh=u6OkWdgL9IIkg+Eo0JTn9YR3RdOm3oe030uRK54blGY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lrUxWz9b+Zv/L4ia1pz6l4XYZIfCNS2jteAoB0tVJfzwYruEF5akCfzCWhA3kixuOkYywA9t0//lIDwdGqJ/nvpsM05Yayh5t84enRaLADmjwcCCif5UUd+4qXFM0L3mOFicEK9Jgciwev6DFsDNvD1qnnv9+Qw73Xonfoj5s2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXUCxO9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXUCxO9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBFE1F000E9;
	Sat,  8 Aug 2026 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786191899;
	bh=mzVBl53Epi0FUdH9E8YWWkCnOOfHEhABPUneBvvcFYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FXUCxO9H+bF/FzRVocEE+nxwknE5wf+FE681v2UY+b8Horxb8hXlgHu7PeQQivzqF
	 ShNdPnXvGjiEocQvWa/wO5O7ZAhbeOh1BoGizgybcxMeyLr7mKhV9cBmYJiscyhvgE
	 oacDUBDTOXi4l0FFiL58M0U03ltwmJoVWWbRbJvUxIvolc+rlxumHoqKNWylFagMe4
	 SrOd1MPKfd8sRKuBqvlqj6pdmadot0SXmgEom8Vxxec0HpNVbeJoaeekfcyi0Ltb28
	 +/fHkt0SkdQnQDhKtT4GMFPiLqKpFdo/AP/wOd9KKLbjxqO5mUau7c3jsdChOCTmQ5
	 ts64hgEyy11sw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805104149.9795-1-peter.ujfalusi@linux.intel.com>
References: <20260805104149.9795-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: TI codecs: sort the reg_defaults tables
Message-Id: <178611434428.279158.13806880797963574362.b4-ty@b4>
Date: Fri, 07 Aug 2026 15:52:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u6OkWdgL9IIkg+Eo0JTn9YR3RdOm3oe030uRK54blGY=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGp3IBigsvlVYSNdeHPw192rhuZxUkd+CS0FK8M41ME67rfcO
 4kBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJqdyAYAAoJECTWi3JdVIfQTcIIAIMs
 mQMcwf9SkjonLd2SNAGqePAAAyj71+m2LL4T/Ucdhw7O8n8DfGyazoY7f65O2r4iIsoiUa+y2nB
 U73ojsHC/BOI+1eDkDFB9JFLIvRyYyhC7Rm+PCGE419t/5gyLwEK3HP9kMpnjJdsZOEyUNpUf5L
 Y1xZ/M/ZljNCQoKlEMDxBv4VNa7Xnbw2rhGVmCLZLdhqCmIIstjVUlgEsPukHfi3Im9JuDceAE6
 LVDHIhQEVCitMomZ2wx0lWoRATA76ZX2LNCLrU7UH6LHV3VAsl8d45Jiuv0uWqEzSWsv94GJJW7
 Fi00w7+4FEGfscuZaTyR7DMxfq0nObdEXn8hXjo=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 05 Aug 2026 13:41:44 +0300, Peter Ujfalusi wrote:
> ASoC: TI codecs: sort the reg_defaults tables
> 
> The reg_defaults array of a regmap_config must be sorted by ascending
> register address: regcache_lookup_reg() finds entries in it with
> bsearch(), and regcache_init() only kmemdup_array()s the array, it never
> sorts it.  See commit fd80df352ba1 ("regcache: Add support for sorting
> defaults arrays").
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/5] ASoC: pcm512x: sort the register default table
      https://git.kernel.org/broonie/sound/c/767d9ae714e3
[2/5] ASoC: tas2552: sort the register default table
      https://git.kernel.org/broonie/sound/c/1cc0cb62d306
[3/5] ASoC: tas2764: sort the register default table
      https://git.kernel.org/broonie/sound/c/e7643c3f7eb3
[4/5] ASoC: tas2780: sort the register default table
      https://git.kernel.org/broonie/sound/c/e725093e9e53
[5/5] ASoC: tas675x: sort the register default table
      https://git.kernel.org/broonie/sound/c/3521d209ca70

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

