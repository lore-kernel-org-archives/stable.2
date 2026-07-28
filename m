Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1F4399FF
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244217; cv=none; b=Mj1t4wp82mGLGTD/c/jsko47g2ywzs6X8AXklWGMKLGLmc/eaerFJ1LeeqgkTg8rcubRdryxLsDFMgiCMBCsxaj1H1OTwQMGKku+ah6Gl7RcLQftDVJ/JZ6Bc7A2Ob/9WOIeS6E8DHCTZqU1QyvJoIEYv674NKbCNyjf9zpo4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244217; c=relaxed/simple;
	bh=7c5uqTK9NyTTXKowtFwnOm4Lw6gtNHzbhy8dbghEnRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIEJiUksK+Ru3BFy4K/qNgNVawH2VugLi3oTDGOoOvQswqqXErfJ+VEME2laCZaFfNTpnjynykkNdJ4ZgDfEfjVKMMpcfYU+0wK9GnVNKgnlD6nO5SWZvZRRaG9mv2oXfvKP65WlR9LZHgl8duBnwePn+K9YykOWp+E3u/4Fr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QoKL9wF/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QoKL9wF/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=ggkDTS25iVuQ4Vu8Dt4p0Ph4mLlzKM9jCStFhPHliQQ=; b=QoKL9wF/N842rV3nGI5NsLggYe
	61+oVm2RKiw/chtu3p5xPd7QuSGfxZmaTAp4HxqTFtrij8LtVhjOF41ZAH71zTR7N6hrerHf6d4en
	h+BM3Lkqxhw3SqTjsTHIi/Rt8g91oCWUbgMiB1IGHhxl2Tt4+0xxlcukBWDkX4ppn9WTFp6o+7H3N
	CvxYS64l/fjH4710FCPbIF4b+TVV9h0h2rjmNzbvZJFWEmnSTn/qQn2yXZVwbvYK9a6gL0MTCJ5O4
	2b2s2TjViPclXZznyOoIHxI8TLZpzOndYibFpIXZesVBqrGZMK2Z1qq3B0GV06bVumD37btIA1SFU
	kOZ4KYwA==;
Received: from [187.36.208.132] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wohZL-006zoL-UI; Tue, 28 Jul 2026 15:10:04 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Iago Toral <itoral@igalia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2 0/2] drm/vc4: Fix binner overflow-memory corruption and GPU hangs
Date: Tue, 28 Jul 2026 10:09:41 -0300
Message-ID: <178524417787.535318.15309615931071494842.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
References: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Jul 2026 11:32:27 -0300, Maíra Canal wrote:
> This series fixes two long-standing bugs in the VC4 binner's out-of-memory
> (overflow) path. The binner writes each tile's binned command list into a
> per-job binner BO that is carved into fixed slots, and spills into overflow
> memory whenever a tile's list outgrows its initial tile-alloc block. Bugs in
> that path have been reported for years as GPU hangs, userspace heap corruption
> and occasional full system crashes [1][2].
> 
> [...]

Applied, thanks!

[1/2] drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size
      commit: 6395789e4739aa5177bbec0fa0f07ccc38d249b0
[2/2] drm/vc4: Zero the tile state data array before each BIN job
      commit: 48a570c964d8e37d353381e4195106277e17f5cb

Best regards,
- Maíra
