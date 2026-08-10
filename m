Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3F443A96
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406285; cv=none; b=uoS+sJq+y2V18qfAM6NFpIusDv1XiY/1mG/eBjbIMJq+F3k3YFN86jT9RK9uV9fwyRj7kw4cVGKXG5zWgurf/5tcJRySwcIS0m9EbKT8ZJNixai+8X8um/Cpw01ZB5M3rUDqTGe/bkXQ9G5bLTOcNBfAR8q9+Ys/dexCVN9lP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406285; c=relaxed/simple;
	bh=e1ZY5y739AFdUsGOSwzhVYLDI2O47dNaYc0YB9r35bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdUDSb4gv6nD4l1jHdxvvfyQ3Cmk2vldDvMRKR67K7TrCt4c7lJwHCLK6jbEemFnuvJuAMMeZf0fGp4pJ/QqnNCCx5v/E42PsHLqDLVomC4brCMfw41SiKxFYAcbix+v/IfHhrDBnesLKt7PnV6rqX3K15EoBlx/z9I2NYCct4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcIWvnSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcIWvnSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0C41F000E9;
	Mon, 10 Aug 2026 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406284;
	bh=M0pzCs144/SpmB2xfIPAiaEmUAtjZvx1OxgFV2z4tII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcIWvnSuSUjwIZrIiUary772B+jPKXqgF0Wpmob1tBP0XlRc6Mq7t65doPL1t8eus
	 3q7fq23S3SCaav8ZvR7Gzy6AfaINEL3mypPrh5CD4AGZ5OcUsFEDwzPT+SlAMHhR1Q
	 qYhyx+lN4VZ5QL7m6QKdylbzt68Vm0ol05n23CnlP9On0+x49fGEnOLXlDyJGAb0Eh
	 vVaauVH0r4TZhd1g2ct6S1Ju3a1LGOX50iN0dbJgG8NmNPicQ60YykRE16iJ3SIstO
	 DcNvzfoOZFP55wtJYEsmKBL8MMY+MLFxQJbqKIxnUyNl44NnDSA1SyGoBwJUbAv5NG
	 98XWvBlwCtgfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 7.1.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
Date: Mon, 10 Aug 2026 19:57:46 -0400
Message-ID: <20260810234738.0008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810005144.2225816-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20260810005144.2225816-1-mark.tomlinson@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> A previous patch partly fixed this, but only protected the write to the
> interrupt mask register, and not the read from the direction register.

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
