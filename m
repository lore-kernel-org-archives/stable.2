Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9D38CFE4;
	Mon, 31 Aug 2026 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215513; cv=none; b=XUaRl3JW1xp1tvkvVnTxIcuUqIX5SsPlc7E0pfGh0q93aDESRlDX8y0vh1/r6MLF1qs6dmXdD8q03pvYPITOv9DqiZ9gr2uqHU6z00uZzFA9SK6/AhsBxxdEa8Qr+etB11O3dEgDFtjhVDDUVhn/Nt4eIACWS28XSsYo9WGzCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215513; c=relaxed/simple;
	bh=Oso+dgHGf9ngPqwwYgqk/cGH7h4Kdl9mR5SdFWHjxQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hEKse21paco+NnAT6htl5ZPqTGg2OdM4nYXHRJKEzVD1ALwlz/DXM+Lr/hU4XcHl5c+72Wx/0Uh8BfY3QEd/iPomJx081dzJj/ukE0uVvVBIwfYb8hwZJnnAiZlICiBABOLL9jbLbVUoT0cGgNYaRMZYwKqyy7FWJZ9klt4ZVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVPDB2Da; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVPDB2Da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9986E1F000E9;
	Mon, 31 Aug 2026 22:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215512;
	bh=8rDXhVjfe3+sYGPnhHnPLjgMki9YslWI3MwExCoxuMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YVPDB2Da1AnXIe3zjCNpmblIgAVemP/6eYWXl+U8VtGoVdg5KvUhVCUfYKbKsyyqS
	 nBAE5DWKi3bSAZIWsaxk8A+3EpPDZ2qLUHuHrMndQomBo2QJNI0gN6By3Tymk0WnKd
	 520bxYWtxyotXneY8YvID6ms0v5MR5Fpk97JUX/3BhmuOXb93LfK7eiHQx9PhtI73y
	 bevt/vL+V0Zy62TI/ldTW9D4kZUvA3dOWYNsHJ24aMqACKwcPPEsGU9YpOQzwvJ6yf
	 fKVWbgnJ1k/49J8GDPPNYWH5G2h7EsGQ+ZfaWCM1hc7hyKQGXin6+/M/6pUNl7uhVB
	 ak5Ac3JqG0Dyw==
From: Mark Brown <broonie@kernel.org>
To: arnaud.pouliquen@foss.st.com, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
In-Reply-To: <20260830142026.2666914-1-runyu.xiao@seu.edu.cn>
References: <20260830142026.2666914-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] ASoC: sti: initialize IRQ lock before requesting IRQ
Message-Id: <178817936971.141190.12027742009257573747.b4-ty@b4>
Date: Mon, 31 Aug 2026 13:29:29 +0100
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
 h=from:subject:message-id; bh=Oso+dgHGf9ngPqwwYgqk/cGH7h4Kdl9mR5SdFWHjxQE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlgDUWo5cznnMrRhO903oDI784KqcpSLgQ16Wd
 cA0h8/wa1iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapYA1AAKCRAk1otyXVSH
 0MvRB/98rVEgpzPAjhGDfqC+ZJXJILAo46BEza3lgbS4ZqyUVD1Ku/KPXCJpT6++pwvNCGeON7v
 ZJOOJmLTjEX8SZ5JMBDHYorwscRMrW/QSVvvr9RjbySVSx1R90NZ9R1QEnmUp6KdyS+YaMlINHy
 pLZoPlw121b09oHzs/UpFEDCEip6CdtznhSEVM5Dx3z7E/MTVuKoiSee8HyfnNnPIVRWACMVnNC
 RBd4b1v6EbDAQjwbJGIoMEI4Q5mgkU94wLtMvLLns2Ujl9WkU8QXCxonielwx8h/rhQlQtCj1vT
 QBsIORISausCrAb4MU+ChrcnYL4/oVgHYGhCou6LZgDuDqty
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 30 Aug 2026 22:20:26 +0800, Runyu Xiao wrote:
> ASoC: sti: initialize IRQ lock before requesting IRQ

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: sti: initialize IRQ lock before requesting IRQ
      https://git.kernel.org/broonie/sound/c/04405aeef4f8

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

