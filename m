Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EA33B6F8;
	Sun, 11 Oct 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737324; cv=none; b=upWKt/0v7Q4A8/TF41TOmWouFKW8sxNbigBdl+VzqMHw0UTvyfFoEs4spdxrVvqnoWJGrMYBwPyRq5hKJhG/KLR95RBYTGLNmOrRELKelmYB1kQae/UY2nuKKfMkBo1UZ61kvb+YnUty/MsTkgEoO9G9ksgk6Q9ezoNLz9m4Myk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737324; c=relaxed/simple;
	bh=KfFdUncOGakDrOGWnXGuehWUIfV0q57rmQ4Y7IxtqmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLYbVi4q36KiRzC6pE9C8oqUsNPl8yyD+Y03SvunRKK1JAu3ySBBwLvDVCcYQDRGZyJANw5UAr/45lY1vV1Xu87ig6ChxYfsm5mdLHw3AaWYwmOSP9pO2ssi8G6qvzfscO6SZddspw7lHwJy0lTQUcfZd/miz2J7e+4OOD6gZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXPVFNr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXPVFNr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE51F0089C;
	Sun, 11 Oct 2026 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737322;
	bh=THlq+usEucSNuEH7YcqVGREyFsNNAfJeYUlmxYPRI2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hXPVFNr3njM8PsR/stwITvDb3JjtScwOYq9tjCP5X7NE/9U8ArotXrJd7krhVCNDF
	 ThWYrsyUzxsUucrQDzIn4i9/qgk5ppe84gumN1HzzW21WPYZjmog9XmnP1GUJcYKKl
	 ECa7SgdgIJ9+9LoBjrVRXv6RoYp5+KEK8xjgHN18NIvBa6HHw8ZsVXcL1v/82xuFMZ
	 oTwqDTvWLN7HP2n4GGAlornTeHYSOl5p7OS/6PbZXuGR8dHL2500JB71YC6SKR3KqN
	 7snuPwy93tx/zaWXZWLFE1zZhMDYMHWnjfzS0Y9TrBhQWaJTWy+WHeCkKoRCSpaza6
	 AOdUH/ukBTxnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiajia Liu <liujiajia@kylinos.cn>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: Re: [PATCH 6.12.y] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
Date: Sun, 11 Oct 2026 12:48:19 -0400
Message-ID: <2026-10-11-1-daily-reply-0012-bluetooth-discovery-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022523.2789588-1-yaroslav.voytovych@gmail.com>
References: <20261010022523.2789588-1-yaroslav.voytovych@gmail.com>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
