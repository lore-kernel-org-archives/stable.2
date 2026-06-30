Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D74657CC;
	Tue, 30 Jun 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834547; cv=none; b=M1+dSXfAZZygqQhBE1MK7Qnk84USpIo2XegN3uAEYFZngY7SrtHmIERvYqhdYYudKL92TllBEAhmTdM4PpgpRfe4o3q+DUw2xTjlK2UH4hFkG7RS5Q10NP4C7zRoN5Pg9tjJ4N9RJv5cO5lFSPXHGQ1dRvqWnG4zUr/ecCet6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834547; c=relaxed/simple;
	bh=2Ws7P6BOYP/iMzX2LpzDFt3jxCfbZZ0tRoZaRPsgeg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AqvhPc4YMKDblIx72Hq53jO5yvJyNzQJugk5wIFXUtaENkklHDTYa4CqRcgXsY4QN+QgX7q9mXE/hrk8/nThLtZBGna0Q1mue+yQQMniZeRVEmk7VOGSPCtZIh7Hv+PBOX8l78LWZ+6drOa06CZxg275xloMtr+i7+/CmuWr0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UewBZu4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UewBZu4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E783A1F00A3A;
	Tue, 30 Jun 2026 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834546;
	bh=zbDc8XvKfWhyJZCvaNUfBHlhmN+srBYnmv7WiPYXZMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UewBZu4DfaJZR3z/lfKqySeicVUNufZxMF6HaP1JEMAbE+9wgvT//86VLMTH9dzbR
	 yz82/qFpmHBKfKKna+DjuwFxjd7WZWiJDt3MMJM6zZn3B6RpLIjgHVT1PbfgdCjscC
	 2RCk3TuMEN4W8ehWGwN3GorV9ZGHnr6uIzijmUr58dWTRVIJr8a3pLeGZY9XIijHIU
	 W2LSMsTq/4U1Lebr9mwUsV6jGFlVLcV3FWM18Y6V16Q1pU+QLWGKLJVY62hFW8AXA/
	 GUF8xAkzJsamO/4MJHqpn/o10kdaYK9kqimikopoDskFeUmRgre1XB71cWM0DEt2PR
	 oVLxyVsxuFKRw==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com, 
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev, 
 perex@perex.cz, tiwai@suse.com, subhransu.s.prusty@intel.com, 
 vkoul@kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260622091620.897478-1-haoxiang_li2024@163.com>
References: <20260622091620.897478-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] AsoC: intel: sst: fix PCI device reference leak on
 probe failure
Message-Id: <178281880553.79320.14011856942727285355.b4-ty@b4>
Date: Tue, 30 Jun 2026 12:26:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2Ws7P6BOYP/iMzX2LpzDFt3jxCfbZZ0tRoZaRPsgeg8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ+Vuv8hZl91x79U9+h9u6ZEn5M30sk8byUnpr
 UxGm+c13nuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakPlbgAKCRAk1otyXVSH
 0HRaB/98TpHdgY32MfnLUEZShVWSWsp2x+bfxE+Q6uCO/2P1C7jggMiMfPVlXPftCfslNoWac6F
 SsQMlZAeSknCk80DiH7VAvZnJTLa8ai8k/bQ9g+MHzxwus9UNluIX7TKvWfvvRPDz52lhDCIggr
 7owAOPonoE5c1qofJ0fP9/TGX/e3aMSlB6JkNhQOrY5wJZ0PkQX2J4qZDrudo4rHpKbZLJHk0ea
 P+SZ936J50O7ODBmBfTUjmYy7go7mdUNsWyIh+XAVW7x4xnNJyZXSN+hMrWV331hzuO3ktO6km8
 RYE/JD8Q00STLxGhHWDkA+pY+nDiwOwu3GhKTOorVDA6JmOT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 22 Jun 2026 17:16:20 +0800, Haoxiang Li wrote:
> AsoC: intel: sst: fix PCI device reference leak on probe failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] AsoC: intel: sst: fix PCI device reference leak on probe failure
      https://git.kernel.org/broonie/sound/c/016f29997ebd

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

