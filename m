Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EB34D916;
	Sun, 11 Oct 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737325; cv=none; b=mdF3hf4w/OZEwDhTf0ivCIq4p9RWKMhPiKEioooW3fMtMK7caL63tXT1tBc35PjGXLAr8cs7PhpGRoU8mOTpq2UG3cEo5WHvNQAFiDFjXszqL9edEvLtQdXNPQsnXySMUqQfW9gMwouR8AY4cQ3p7bChHSCV3ZfyWtkc//75Es8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737325; c=relaxed/simple;
	bh=tNt/b/zUn2JZC6be0ErgpqMg4Tr3fZavPmlgJCC00Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aACV3a5O40OuDNnHoLvpNyzU0+85pujMR1k6lLEdNqajLbpUFbIlzlihoV+4q7I3aFS2ZKRSbJpIAhVNLK6dWlIbZ0hyBZnfAIbFUBEo24n/lGXMa+ojXu5SVwn3B7VoJbbSPbxeiXPtUrg/AW1E2+lnYUCRYXczrCcesJ67LVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q428COCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q428COCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C171F0089F;
	Sun, 11 Oct 2026 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737324;
	bh=BjlgvVnLzY01ZyeiE+1PmeYMU0lCokcMwfZlOx6x4Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q428COCrPLFePCb4vJae/7gzUMpJfmiOLSd7jz/lIe9fUR+Odwr99NELEHY/MoEYJ
	 2e74p44+mmgHbBIefKsX9ulPlVfo6StpFha3Em+tSaWQd4MUn2fZboAjqbdjBdFdOl
	 WtKbJ9HhwoWlZLBxYcohJYtoogaSjIm6w/AC2B2VcKM3uV8zpEywoCmfTE0h0PVcyz
	 EMzo/jkCB72E3GkdYSvSbJTxFQQVJ1gsR110I6xfPFU5RDQz5jgzaOCF2FqUmZSUfJ
	 pLo8O1AISQiqSxN2+J6JuDPelhF68921UP1cBKUHWD8gByKFqriAwXlTkPBY9LuzUJ
	 tOvuLfzqnG2uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiajia Liu <liujiajia@kylinos.cn>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
Date: Sun, 11 Oct 2026 12:48:21 -0400
Message-ID: <2026-10-11-1-daily-reply-0014-bluetooth-discovery-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022523.2789588-3-yaroslav.voytovych@gmail.com>
References: <20261010022523.2789588-3-yaroslav.voytovych@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When hci_inquiry_complete_evt is called between le_scan_disable and
> le_set_scan_enable_complete and no remote name needs to be resolved,
> the interleaved discovery with SIMULTANEOUS quirk gets stuck in

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
