Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50324DD17;
	Tue,  9 Jun 2026 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966333; cv=none; b=LVJyZPdQyDX07CdIXE3BP83SJKKfFlOasZjZBOp1suaRCeCyLVRwmaSpMKxE22QWwMBWyIHoWdHQcRJoJWUcyrUC1ZiPYP/84Coir6NoUjdCB1E73FctKHC521yaN7HvP9XQL+MP9pKKEDvc1SQBXbNBgUFbrmijWIAQr1gYtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966333; c=relaxed/simple;
	bh=B3Z0yRdDI4TKVLCjQtC9b3Lr5dAT/V4xp1751/shaAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYZd2pz9BXycl0a0/ex/GngMpNgiCWl+R6qZLbm+4lpzE99GqEkcgywpkQj1sZt479H5CVp1sMKcwwJ9Ps4xApQ2FanSvu8+r/TpYj0/fMu72OAcfm0ONnAuL8euvKSk+sFbWkt17IhKSMzcnaOER/pFWbQe9ggCJVf8aI+kqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhBY/1gU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhBY/1gU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A78E1F00893;
	Tue,  9 Jun 2026 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966332;
	bh=B3Z0yRdDI4TKVLCjQtC9b3Lr5dAT/V4xp1751/shaAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MhBY/1gUADKSrb3i1kWM+R8/ma9lABVRWx0j8olVnB/sX0Vez+R5vjzncBctS0Fcl
	 LzwpPsTKOtiNy2pDL65rkVJ9YxTJFjX3pvyj7zfC8BCFVW4s8cZjsZe4oDig2Xo2Wa
	 TMKjbhgB8jo59l8eDS0j35ooTEvFv2GHn7Ju6ILLqPMY3o+IjD+ZWIOQlNXHmQq8Ti
	 rI9eIbO+KiWbtzwkJNnbcoQp7VHXmxG1qmCOPXzELs7x1Kw2X9FzNmYaTSbaDcVjGc
	 WS9JELy9SA21JrEFhyCID+wxgj1Gg4G7T9M1zm1gIGnYmQlkhJR82nZpqxqt2G5sVd
	 rvt1h9H+nD6Pw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
Date: Mon,  8 Jun 2026 20:51:51 -0400
Message-ID: <20260608-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
References: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync

Queued for 6.6, thanks.

--
Thanks,
Sasha
