Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E13C9EC2;
	Fri, 18 Sep 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720792; cv=none; b=qcCidCql26i4v7u+wMg3hOvVocO2YBBCWyypbf9JkSojMCQ0gED9X3kyEmlAkeNY7Lha3VY9IDNzUSOVgpI8UQhAaRYZ0g5yx4SHlSEhnJtbqdKX1Aamzo3UKkCdSg8cEIeQQsEIo5jHQusR+NwL0J0UQO7MTGFYSo4728AGSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720792; c=relaxed/simple;
	bh=3Dy3YtypLKkP6JwV5QFwiqAKZVgzsNJ1z8c5ksVcBsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PO3jjO8XoJwmsOQSBhWy1stUE96pYf16Xm26RJrFlM8Xsoz+I85/vKATRi33+yvh2duqZ5Y67PUxTII7cJTs78pa8Ubz+ir6Mdpc+fif3xCs7LsURdwDS7gk44QQVxSLvH5zhmusajKPHfuUo/o+j8vDWrizqdggfvadQansBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj77CiL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj77CiL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF931F000FF;
	Fri, 18 Sep 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720790;
	bh=4NyvQt/xrr7/J2Rj9IMwy3V+McdYcbrXcfwVdArfFoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oj77CiL48FknHrG/C+PhbXizZUrccbyaIuo3sONdOz2U0EvXATU7wC8FbnrJo60pH
	 QpAm2SeEbdoxJ/yoATNd0P0VxnhXE6fJu7qNIUQ2UTuBxXG3u/MFGuSliTvss13rZF
	 v5pAsTYW3qNHQ56yCV6KcYHzt5z9hfjHNxw87z+4T6hpY6dfai1Zr3fgq32vL5eG7L
	 HsGhskkQPvusqC2fGVVPyVjpqnLE3a0QHxAVnXHiXL6Qb7G30yPK7oUIe8l87lgHeN
	 ltaNmSB+jSb8Z8G7ksFALjofzsIkOaju8gcqyyij9pL1VP+UFwqeUouFc2aB/0ZeMV
	 6kb8zmJwnr0OA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: broonie@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: Christophe Leroy <chleroy@kernel.org>,
	herve.codina@bootlin.com,
	leoyang.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	qiang.zhao@nxp.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
Date: Fri, 18 Sep 2026 10:39:38 +0200
Message-ID: <178972077003.546774.17878987805855996127.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917152719.2160395-1-vulab@iscas.ac.cn>
References: <20260917152719.2160395-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=614; i=chleroy@kernel.org; h=from:subject:message-id; bh=pC3q+eVOwKtbzxx0BZcSBlwLSzb+dYpbfXOvP0gz5ns=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSt+XH6buLtv9na7FOKuo6fmv0y1mOv4ZXC3YLNRmFf5 xSlCDU86ChlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATOVrHyLBd81a/VUC7/Lvs V8wR18VXh8btmL879cL1SyfqXllejt3H8D/hjcFkRYddXBcy5nGpc3U/+rEidmt79dx94flrQvX 7r7AAAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Thu, 17 Sep 2026 15:27:19 +0000, Wentao Liang wrote:
> The error cleanup loop puts l1rsync_clk and l1rclk_clk a second time
> and never puts l1tsync_clk or l1tclk_clk, because the branches that
> guard the transmit clocks use the receive clock field names.
> 
> Use the matching field in each branch so every clock acquired by
> tsa_of_parse_tdms() is released exactly once.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
      commit: 7b3b0598c00e67f2df85d0b4cd99eaa3be6c9bfd

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>
