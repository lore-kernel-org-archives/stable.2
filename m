Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54893D9DD3;
	Tue, 15 Sep 2026 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437846; cv=none; b=PLckiPmqBM79UD/5FDCsDS3qTeQyadJfyWmnQpJv2AMk/4eiPJdfQWp0hqeh9BgzM6kRRCBH2yi+p1COzkN9jv1LvvWtuRu5jfDb/kqVp5tiQR04qJ/5b/rXfcCqlstiKCbpTvMn/qgAvzOee9e743kQ/8eAJDVlnKx5w0cW27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437846; c=relaxed/simple;
	bh=p0MbouWlVR0R0mI83lVTDJYVn80DEO69qFKZ+8XS97w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6OJ6LoPcguwgtgFecaMheZcoxLqxOq/nvAb2lu6i7xD1Lg1njIPPwvz9bpGXGwdXtA1iRBFnYEZp76uYpfk/dNTiwc87Vf4itj7hwrW4FbC1Lkc4zgvLmUi8yGbfEVgIZ2XeI3WKDNR8ftxPPZhfK9LatT7/mqpl1eQX2YHDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NciyOxzy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NciyOxzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3D01F00893;
	Tue, 15 Sep 2026 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437844;
	bh=sCU6vGF9lGfhbfY8jEJY144zFOu10cMBtuuVnQX97wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NciyOxzyqaOlM6m9MdgpLZraX3p7PtjXNOo2h3iSy9X80Sj/hNFYnWXPtqP6UComT
	 ce/Oc6MwpKJkeolqVgL7ojWBbwbX+TAqX66H+FO37KCQGvoHFKGvhtPgZWPEftFaVY
	 nd38/DHYmiEuoPkPgjF7jvl17vx38ARgr+qRUGehjJL50KWIWO/hjED+fy4QmFe7kV
	 P00CQMOWfwzrvubcdBSRTswbyjrAF7c8rMj8HfjKSSDID9R/sRijDG8wOCF5CZ9r6c
	 K9fnLXJ+/ZjrrGZuZvOQ8R3Yl+oAyOMDKn228L2qMLvIGSsxNUQS3rljKD2sBmm3go
	 b+rw91EER7Cyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Roman Demidov <roman.demidov.nn@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Kailang Yang <kailang@realtek.com>,
	Zhang Heng <zhangheng@kylinos.cn>,
	Sean Rhodes <sean@starlabs.systems>,
	Damien Dagorn <damien.dagorn29@gmail.com>,
	Martin Hamilton <m@martinh.net>,
	Bharat Dev Burman <bharat.singh7924@gmail.com>,
	Lei Huang <huanglei@kylinos.cn>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Lucas Tanure <tanureal@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Arefev <arefev@swemel.ru>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6.1] ALSA: hda: Fix missing pointer check in hda_component_manager_init function
Date: Mon, 14 Sep 2026 22:03:35 -0400
Message-ID: <daily-reply-0019-re-alsa-hda-component-match-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914080546.11947-1-roman.demidov.nn@gmail.com>
References: <20260914080546.11947-1-roman.demidov.nn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Roman: Instead of modifying hda_component_manager_init() (which does not
> yet exist in version 6.1), a check needs to be added to the
> cs35l41_generic_fixup() function

6.6 is missing 1cf11d80db5d ("ALSA: hda: Fix missing pointer check in
hda_component_manager_init function") as well, and it is the newer tree, so 6.1
cannot go first here.

A 6.6 version also needs one more hunk than this: 6.6 has a second unguarded
component_match_add() in tas2781_generic_fixup() alongside the
cs35l41_generic_fixup() one.

Could you send a v2 covering 6.6, both call sites, and 6.1?

-- 
Thanks,
Sasha
