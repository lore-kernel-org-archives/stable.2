Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75143E4C72
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595400; cv=none; b=ZUy4TtsFR02GP95eTeEdo7C2sd1SWh3/WwEKJ8SDfRzzAXmGbMG4XVIJha37JkoLz/zvRSKxhu702z2Nkma4vl3o71yQu16L6wbqSeWQJDvGhptsJeIEJ1JB5HJHDGZefa4sqSWxY9LS7sQ4j86UANqygDSXFOsEn4YYs3zx+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595400; c=relaxed/simple;
	bh=PARCe973XVgZ24gQORF07tKm/DVgkfoZPa/Z/xRQP24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3vetRmt1mUQuIRIzMkfIQTaJ5BBx8FOWOTboPClpKiue4KqOVdQytVh4OoStsw9RfW2FmHP5g7XdLlTO8D/xDVHJsUM8rwjjJHsYQhIgjOwtepCXBCQNqLPG2Y0pifcR4woMIgZwHvMb63GoJXdtZcJjBehEKmLwh+qIklQ3D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDLKO8Hc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDLKO8Hc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D436F1F00A3E;
	Tue, 21 Jul 2026 00:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595399;
	bh=cLagflxm5O1s38cS3GoN8Whf89XhcowuRpA5s78aJ5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDLKO8HcTS5NRxGVFdeZbL+sfHJpsd665m//mgbiEi7owXMEHA6u90toVpD8RNLcC
	 nJVF6hNmG/cIbEhTergX984ujlFU4TxRut4juWtXK4JlLx7FbNS1Yrc7hNXdTwVaW/
	 GKkrkNJCuieHDnQ5pK4xEPBe0mWTCdGA59nFaFIpS6G4yWRKeD2kcB+6hhbJSaxSRO
	 bE6I5kU1XtPBZc0+vdwERDP9Ah3b39L5wHkRuhFsikB4oW/1eFnhXbumkKtlB2nFQc
	 3POzP80I4KrdN1rKgCdpuH5UC6fsVQjvBlNDGo+I9NM1kzqeehEpw/JF+06eSdsUPf
	 fogAM3hZegyAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.10.y] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path
Date: Mon, 20 Jul 2026 20:56:11 -0400
Message-ID: <20260720175500.0004-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720135415.11708-1-kumar.shivam43666@gmail.com>
References: <20260720135415.11708-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Check cmd->flags & NVMET_TCP_F_INIT_FAILED before calling
> nvmet_req_uninit(), matching the existing pattern in
> nvmet_tcp_execute_request().

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
