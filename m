Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F424374E48
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692793; cv=none; b=WV4BESrxL0/exK1B1An5daBLI29G4Y/C9GyontbqhCoNh83F+o1Zm88n40UbBEJIXhflHLTz2BySVQ1Sv1qd0QLR1AXdBs8oSzZP6uyi0IVmeBUuCJyTDMgS0Z/i+hFncjVwKka1QfPcDY92sqDpQ7IdOUBxebm5S4DSs9AvUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692793; c=relaxed/simple;
	bh=W3qmKuTHxPlGuvs5MGtPBj1fp7H0OWScsSk7nheppEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omcNMutJQ4CnGw3iDGnttzA4E6dNOP2K9D/PRQa9Ox/Ul+eRfBxZ5guVz1DBsml2gWSEXbNEppwnfA+fcovk2H5eRYQW4QeOfXMxV1DGrJheNRYWz6+aCCvugTmnpzZ6V8a2bq0qPbaoSZFMAwJD8wFr8G58Kd6CzxQJeM7N7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUOvd7gp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUOvd7gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8631F00893;
	Fri, 18 Sep 2026 00:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692792;
	bh=T6Tak/JkDVpJcgIrScWwUpIq0/oxvMtxaK/v8MG0sgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUOvd7gpDC5v0xjDokjWsZ45xynNLB5xvobPwhVX+V7hwXRbnNqMY6nMImTag8AHD
	 LalOFvnIvG1M5G3IRhPTGf/whLAAMqarWmhmVFotSBQ4/nkdhHKUZx0ZOKgJg76fsD
	 OHGhPUdt/rWFswZS+sq6f6jEJwvgtdIHpdfTmp6l2FbMEkx4Ufbvy1KcYifDzJHEl/
	 dprXe9PKIYZYvL6txyvnfLTb2HiMHER5zd/NFFDK0rswzgfqVljlQGIFsMdDrnMFJR
	 Fu3xk1eLgE7Nkezn5OSoKSgdZJ+CgwEkF/MCJwrRX1SJiPSXJD/wY4axN4ShOVV6JE
	 32naoR+oPTcVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH 6.1.y 3/4] selftests/landlock: Add disconnected leafs and branch test suites
Date: Thu, 17 Sep 2026 20:52:44 -0400
Message-ID: <2026-09-17-daily-reply-0017-landlock-disconnected-leafs-tests@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <05c113f3f1176daa6ef68e3553bce9c53b5aa219.1789655724.git.mic@digikod.net>
References: <05c113f3f1176daa6ef68e3553bce9c53b5aa219.1789655724.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 54f9baf537b0a091adad860ec92e3e18e0a0754c ]
>
> Test disconnected directories with two test suites
> (layout4_disconnected_leafs and layout5_disconnected_branch) and 43
> variants to cover the main corner cases.

Queued for 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
