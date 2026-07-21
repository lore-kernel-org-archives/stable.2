Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35813371889
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595412; cv=none; b=l0HNAvi8tM56kmoO5LQYdfWgE6/krjweAEaToQ8n/aFl8JY2ImJn8y8k0q9FVtyBcBdCpTUIT1isJTxtxEC2BV6T+dmbM+ybTpef6wKGsNrbEImUmhfj7dw9UPsKy5gbmkO4S0myRV/gD4EdeZXroSPWLuyB3sauJLbLbuUdkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595412; c=relaxed/simple;
	bh=OHdqlS7K2wjUK5XNhnlpqZ+h1zL1ugciFsJui/WGsjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/MUSUKUrCX+CL7XfusAAyudSuvEzi3kevXgzFrKs97cV6KxcZZiu+0b1LY3jJaLjFKWxpF/rfw57GJJWfypf3RAiNhSp4YKIBccGCs0j1pAB1ot6/0GfrtXFRXsLSLgKgbQ4PfJMYXk3ruQr/PyKz3cFhr2cQGZkb8djYVXkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV80nPey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV80nPey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C72E1F00A3A;
	Tue, 21 Jul 2026 00:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595411;
	bh=hfb2MTy63sot2TjlfaCcswlJ5dsAT4UlK6HnI9tdPFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GV80nPey6C1v4s6XHKkckkJpxkU7QORhKFlFVQLcsn+F6n/qsxXCuWZXcX2nODrN2
	 +jizDLDcUhgvrQL6s2IV8BA4t2DHSvgF3wSKoytLaWLCaEZxvK5Me09Bgj1Q0YNoJr
	 TX+3wp/6Z3ku8WyvOwgXS89gwRiLpDPq2luBc5r7xetnKhc1z+5vOOrN2ui8WZ6U36
	 +i1cBik9L6BeHWWX1XtQJ+K+04cw7pbB2yMlULRNP+qOhdwEa3PvZZW6QyRTiuN+PO
	 Uh+gOjmgnZSxsl5sFaRc/8sOPqLcOrXpneGNZfTU6BNDfPsYG1VayxbTzI2NDowBe2
	 RUhZRoOclACTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.15.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Mon, 20 Jul 2026 20:56:24 -0400
Message-ID: <20260720175500.0017-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720140354.15968-1-kumar.shivam43666@gmail.com>
References: <20260720140354.15968-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When data digest is enabled on an NVMe/TCP connection and a digest
> mismatch occurs on a non-final H2C_DATA PDU during an R2T-based
> data transfer, the digest error handler in nvmet_tcp_try_recv_ddgst()
> calls nvmet_req_uninit() - which performs percpu_ref_put() on the
> submission queue - but does NOT mark the command as completed.

This one doesn't apply to linux-5.15.y: the diff context assumes
4606467a75cf ("nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in
digest error path") and the nvmet_tcp_finish_cmd() removal, neither of
which is in 5.15.y where the ddgst error path there still calls
nvmet_tcp_finish_cmd(cmd).

Your 5.15.y backport of 4606467a75cf was queued today, so could you
send a v2 of this patch generated on top of it? The end state in your
patch looks correct and can stay as-is.

-- 
Thanks,
Sasha
