Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E61A6822
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322596; cv=none; b=Oar51Hf5pUN5Bq9Z130dYU/dbZfBePl5lfcSRne2haZfgS5tSzecQWHt7BIbcn8cbumbedIKhXOOQ94Ea7qMXwgrvHfYQ9294AtJfIJdiE549kBU/DAWoA0OCQ9GptQQcMIdRtSNCADEFFvoT4rqtCgIYyAotwWMCyjK5nSv81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322596; c=relaxed/simple;
	bh=VjZa68pVAQzBOPfDuLOjORyn5fYQAu7PyyzyesV+xfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqQ6n1IS+ORRHB8qRylJame7ffCWQeGMUMCG2qXoujjyXoFqzSnNijBRMEFI3ghNtBsEERhByfbaM2PIg8yAMPdZ6JfDQmQuZuSuFDQh/nMQoocuG0Lzjwlzpoe2Tz2lkQO1pbi55/CWndyVmMIS1S+CHUTKwriUyDzKq4bGUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM1sOWHK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM1sOWHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0871F0089B;
	Tue,  6 Oct 2026 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322595;
	bh=EoycPgbfs3bw8fAPUczUDn9DV+LOQUYiFoHumeN5TJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KM1sOWHKowQTpScbu4FEyVIbI2DPF39/d/ZFqxmJhZnOZmQfEf04sRiH03ZibrJLK
	 CtQvotHePjk1me/wi5MtRZyRiBblQofTZxO503m468jEnqKqFlOWSEMq+Gk7UeoYBt
	 V+5qlrtrYaPmoxEu7Hwh+/PS37RDV3t6ltqNxhdYJlxo0im0w9IvKiJ6u4nE2tSreC
	 r/EUTeAOP4VAKj+QzQ+0pDqvCw8NyNXuJDD9yIFYBtEgy/+HW/T+s1o9q3kDLhozvl
	 lVhhcqFdxI1nGJRoFg/UTqRwk8qFksEBfSog4pIvyXAu+mSvbDPlF/wXpuB6mZHMUE
	 c0b6A3WMiBn7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] mptcp: prevent race between disconnect() and rtx
Date: Tue,  6 Oct 2026 17:35:47 -0400
Message-ID: <2026-10-06-1-daily-reply-0015-mptcp-disconnect-rtx-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <25ffce03-e064-497a-9cbf-8bcbeccf14b7@kernel.org>
References: <25ffce03-e064-497a-9cbf-8bcbeccf14b7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Same here in this version, and also because commit ea4eb2adb0d3 ("mptcp:
> honour configured min/max RTO in retransmit paths") is not in this
> version, this line should be adapted to:
>
>   msk->timer_ival = TCP_RTO_MIN;

Queued the series for 6.1 with msk->timer_ival = TCP_RTO_MIN, thanks.

-- 
Thanks,
Sasha
