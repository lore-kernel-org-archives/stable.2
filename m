Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785781;
	b=Q71yUB5yBHENYzMvmC0YVegjyhh9SlQXkX1o55OevN3K7nQgYVKWe6V/Y8oRvLePhNSV
	 0soPT0zVsIfUeuflGYElrA7I3Li+dDPcma5/l1Ko6EHovBeQ/BCUY7QrqA6teIwpX4k/X
	 kk5TI4f7Hb0ds7cWs3PY2PLbziXp3d/CXDpmXglbEAiT5vWSZBOL9/ikbvWFwDL+UQAlx
	 d1zEFQB9yiD6pmHZB5fRQA/dJnNDTMksux8kdk5RUebMu152vgcNU/XgroYvzl6a4P7sk
	 zBfq92ZRvQYGyGpYopCnUl8n3eHzH/teRX9DAxFPPsRYq9A+xrdbd0Y3A88W+Pr5FSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785781;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JGa/DuvLtm4qqJKCfYwrVbgsoVIqIB5WBCSjE6SO3NM=;
	b=dHP7y6pTfBDyNkZDNxpCJbrIGBZcXd8JSm6c70uM9ropZTm5zROCb+XdzonOFx9oQArh
	 dCr4vR4SicVW0esWmPpbNTfm2yjIF95hDjLD3J6dfEFr86D80bmrRnWdTUThotkDCG6EA
	 fNHsmNIqCqikRzvjzm3RtogqE7n4luqZvc5ZNdpS9w4wzxWTs7Y77ZhkAf4VWz6LPGOra
	 NqrH1sFnDVl6IgQb+3XvrtBZ/FJOgLKO3KUwUbrn456K+xzfIYmjJViMzyEvhnqtcEvLL
	 VYCpznHQgb1YkJQYd0j5jVuOiNTfhWtCyWJIAzfIEtfsovPVTcBjV+HyUm2FIPShrUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajPxG+Gw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B9606A330
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajPxG+Gw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265911F01828;
	Fri, 23 Oct 2026 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785780;
	bh=JGa/DuvLtm4qqJKCfYwrVbgsoVIqIB5WBCSjE6SO3NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajPxG+GwzaDnGuQBbf9zBM/hCs7bgDsVppTaoBWyO/TMfJxCm2mMVSAjwf+XKaqcV
	 crVUCx0LX/99DAWjPzNtRnjW6ZRhU5FFeX32BPf6vaAda4e8ytQibqi5pNhyTQKdei
	 Vbr1LGYUYYR+Q5/S+fioaa2YUxL3Da2+1k1e002YvODOofZjFTBBwjUCy8cU006L4N
	 ihw8CihXe1kypYLLSHkNwUZ9FPYXnvFz8nWNHGKfBqrZ19ftpRgm6MjMTmJjiapx5y
	 CJ+UQtZeW5bLU1KZI6G/8lBuzwLEfjjLE5k0lUE75rnvSQ8PgH7077KuC70AgL/G5X
	 28OGDQ9H6X0Mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 5.10.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Fri, 23 Oct 2026 16:02:41 -0400
Message-ID: <2026-10-23-1-daily-reply-0005-scsi-st-uaf-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021154705.2737365-1-loberman@redhat.com>
References: <20261021154705.2737365-1-loberman@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> st_remove() drops the probe reference on the scsi_tape with kref_put()
> and only afterwards removes its index from st_index_idr. If that was the
> last reference, scsi_tape_release() frees the structure while it is
> still published in the idr.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
