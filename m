Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E82C3268
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966337; cv=none; b=anort0ROhmZrck7OOkWqBbemLoJL9ESPPTL/UeEbS4o+aTeaOfdBzXiwSXdr3A0T0n/KB7kANPU/XwB/+x8EqQ9WPGcXQMAQVYPdqBMpp91iIEBh0WJtlYLQObtP7UwKEqV+ijofPNKeqxl+oYMt602gB2CveehFShDJGbCjc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966337; c=relaxed/simple;
	bh=IZohjaCcbRIaSbWG7RnPddL8tI/1f6Qj0X0gSD2ic3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dId+9rYN9H5rtBgReLYP0zKqZESBdQnZFJfWG7XrEQebetm3sfs4brL6MbAe28Rz/8sq7HG5VGtgiGPNWDXB6KWs/zPcHYAgt877ZcXsBio7KSPahDhIfAsQ2CfcHGCf4tTVBuH+Z69XIze4qp4aVeb89tAe46YW5vrL5upRSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCYAjcCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCYAjcCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E5A1F00898;
	Tue,  9 Jun 2026 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966336;
	bh=IZohjaCcbRIaSbWG7RnPddL8tI/1f6Qj0X0gSD2ic3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KCYAjcCbBEhuVatAroBkLaKxBDloK722qCIijqfhZLL9ybBZn9/B0Qa9R+32dhhdU
	 YxsYoLlihekUNsRVi1ziJCGFU9AnxUkG1wPjPyYZwo6pHiGuYNR0Bbu4NAYjf6albm
	 wwM0pg6tdxIxu1EzwluQH6X70+3D5QDwfvfikfg05bn8UFJzVIZas8w8WJPlumxCu+
	 G1I5UVmkB7tmo+KOTkXFt/N7waXb+VvoTH71nADWMf2VBLfwcV4Q7Mr2CQnmeeCmPo
	 y+Tb2uJ2uo+vWhyOHtI3hMtRnPAMAnsupRvlWogvFeAForGIBotCzrbU2wowfZawfa
	 E0ku4Yb+7oHTQ==
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Date: Mon,  8 Jun 2026 20:51:54 -0400
Message-ID: <20260608-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060832-extortion-cattail-2467@gregkh>
References: <20260511135357.2786242-1-bigeasy@linutronix.de> <20260608082818.LZiPJ9ot@linutronix.de> <2026060832-extortion-cattail-2467@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > This is a backport of ARM related fixes. This applies cleanly to v6.18
> > and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> > not apply cleanly.

All four queued, in order, for 6.18 and 6.12. Build-tested fine.

Please go ahead and send the v6.6/v6.1 batch (with the PREEMPT-RT bits on
top) whenever you're ready.

--
Thanks,
Sasha
