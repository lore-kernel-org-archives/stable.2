Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872693;
	b=a+WiZDaxmk7LqLfd7HZboTtanBM/Aq4INV3WBZXJkS3/40+Q89pL2UmM+pZfAA2YqLU+
	 9YyCkZPC/NTe/F/bfAjzuV5C9/6vxNbnZTReLGZPBU/nrO9+wGADXiXsnrcbQLbiOQxEb
	 6x3yJkj3+qayiIqqCV9GKEPNY1WahOOiX5TR83kjtUECm8DyyUmr8h2WCNMZNOiZ8vbo2
	 p0FhMf4aZPu4zLtoZpZ/eqUshuivrBjm8zjSAyKkuwPCJeclY62BCVyNpedHcp0fRuih4
	 m8MbWCuGizE10uz9+RSczFTRjGIUAwG0UfGsZ14N4hwNn/KBwDHB6otqYYVhZYaWihQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ifMdf1Sp39VsndtnroD5s3R6TXUlg35Lf5SMuYtoCC4=;
	b=o6o/LfWoF4JLTmntQrH5stvWWg+eC8Ll/bGp6au5sVLd+1k2NwSlZFAofIRK13tUUHZf
	 q3tm0LKu+WrUxKOKcbMxywF8NWFC5yK24ic22lfPHfxW3qH+pBiPtQnqMILrvzmWhOq6q
	 C1NC7DfSvgl+uZ4iunijnRhlUVwhS/sJhW3Z2hi9YRhO9Fx6b/33lAI7ZUSiXgvi2CTkw
	 St7u4HkKzQFy73w81KdwDCuUg/uguNBsnEK8YC/Rm20Uc4IHrKouvP4AjVZsgdMWPLv3j
	 fuQkem8sqm/p5lL0uyQNMrMB9B7TE4hDLof+38YgA+pYEzjJQJjZ1H09/Lnm+DD7tMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDxej5iC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA266606A31B;
	Sat, 24 Oct 2026 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDxej5iC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D973C1F01825;
	Sat, 24 Oct 2026 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872692;
	bh=ifMdf1Sp39VsndtnroD5s3R6TXUlg35Lf5SMuYtoCC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDxej5iCTN4jUdALu0nMHTSxZ6E7SKvfkmYPwlEiDYXNqgoag2TwNDbZmvJcBUZ28
	 DHVfLwSLObHdFvkm3EX0sgnU0R3bFUZFgoygUl5RZbAxasC1B+vJ+uCMVDngVpGQIV
	 HU7NMYaZD9Sis7pYkp3wWylm8tUnWkOIYW7NZ/sf2G1/RRawOdMQB5Hmjm+2PUKdQi
	 0tqYzBnIh6h9ZceXWJvBVGINt0ckdDiZzGfPPQX+jtUIsHwN1PlLbpHNUy4HtwNpSF
	 bFxozffJ5BFd3uXsd1G60nVcYQkSjkPX5fRiWzXk4QwTnQcscWSgW4k/abaHVhqKaZ
	 zPpThgKRI9K/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
	Wolfgang Walter <linux@stwm.de>,
	Bob Anderson <kernel@ametros.net>,
	Domenico Suppa <domenicosuppa@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Julien <julien82453@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 6.18.y 2/3] ACPI: scan: Avoid registering platform devices with resource overlaps
Date: Sat, 24 Oct 2026 16:11:05 -0400
Message-ID: <2026-10-24-1-daily-reply-0007-acpi-scan-fixed-event-buttons-2-3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024105710.593-3-ue081723@gmail.com>
References: <20261024105710.593-3-ue081723@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
> Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")

Queued 1/3 for 6.18, thanks. 2/3 and 3/3 are not needed there.

The problem 2/3 fixes is caused by 48fe2cddc85c ("tpm_crb: Convert ACPI
driver to a platform one"), which 6.18 does not have (it first appeared in
v7.1-rc1), so the Fixes: tag that points at 1/3 is a mis-attribution. On its
own 2/3 also regresses completely overlapping resources (arm-cmn probe fails
with -22), which only 3/3 repairs, so the pair would add risk on 6.18 for no
gain.

-- 
Thanks,
Sasha
