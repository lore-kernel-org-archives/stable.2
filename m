Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804A35C1BD;
	Sun, 11 Oct 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737325; cv=none; b=Q4wz/Lf7pECN5dEr96ik07tTJZnpb4z7UmACuaQtWm/+l+SL5CHdJyNPKPk4dUcJBsdzwX0AlIdw7VB07A5npwR72+vl1gJoAOeLzIDemQl+qLFE2f/bw/QIh/vuBopJhhvfTYAXtadC/u/GI4rFsBdlByDnEXix1dlKik4l9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737325; c=relaxed/simple;
	bh=PXyzrqM219ISwJ3Yxpzsrt0S22K/S6fWVRLbhbpdZI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsBNuP8pRXppQEdzTiqIF+b4eZjfrhF7s/nqb5BPvXaadQdzRnzAn8pYAD6Iq4P3rKTjbA5hu72qAznAapemN8gDW4zUMbsd2NIahpTcJMtWW6WAl8o1iFERUP0408+nmbYBlQzrfJFoKsuuOJ3qJeT/V0Az97S0Oava5RlvuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECEvyIn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECEvyIn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49B81F0089B;
	Sun, 11 Oct 2026 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737323;
	bh=jySltK3A4BICsGkWdFJ7nGNZOjfkHYzk4yQ3dADsiJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ECEvyIn30/w12EikD8rJ87ze8XfWUSolTr8MhEL+fE3Zkt3dXQs8CTQKPmXvY6n12
	 2bCabcLl5MjjwK8sISt8mx5fyUln2hNQUrutF+5qqzmx3pxotMHWr9WE3/7yh91VtG
	 w1HxTwEXFiWnZ5dj6S/LCepLIYrlqUbYmFvVzsfDKJoAJTkLjLd2loZQDLqVMm7SZo
	 VBePuI/EJ3J/RYQq+jKhdQ+J5DAADRx/yFnlrG6+3r11Bgeug18NouZcFq+sIY67OJ
	 43bMtS2I6+YZmHiSunr4nuENLFli5eEtbosdYEAroTz7p9O3n9DOXchIXBv4ZbNBN2
	 CmrAJJyS5OPeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiajia Liu <liujiajia@kylinos.cn>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
Date: Sun, 11 Oct 2026 12:48:20 -0400
Message-ID: <2026-10-11-1-daily-reply-0013-bluetooth-discovery-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022523.2789588-2-yaroslav.voytovych@gmail.com>
References: <20261010022523.2789588-2-yaroslav.voytovych@gmail.com>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
