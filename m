Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA42EBBA4
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842037; cv=none; b=lVaVEDJNb0168hVRTpjl2ty6+xDqRO6mzTxjbp6glzfvqyXgdATVbjuPVZCL1YaIrQsLgCA39yk3IvbLS5E/+XtGTHqFCQBDxbWZFuecaGTgKIjoOPyICpbW1U99ivNtVF5Q5dbOsAclAV6lButJLzAIFwdnaAQu0fDvx79Gtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842037; c=relaxed/simple;
	bh=y5i1A0j5Ue5xq91rL+zG5hkU4sCdKTD7SWwOtmjrH1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5v+OB/eoSGT3z5WsL8iTaUCwb4FmHlQYjo1137He4wsHEX0TEg4CwLYgqzscARnvaWZyfUpdqLj0Gg8E8b4FhHi3xffzWWQKKdQldj/zvd1VDDQnjMQNpzxOQdCjc87xxaeBQMzB4ygCzd6EqRHe+z7JW8iGkBZ5mdklDiSfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrTle4TE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrTle4TE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DF61F000E9;
	Fri, 19 Jun 2026 04:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842036;
	bh=Kjc/rVxETMyiW1n5ScbNtYhHcaIzh2K10UHjHeaY/Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrTle4TENtXN8qVI8BYrngkChuj5ZAj8054D04e/fMyH+HD/ZLK6jkQRqxvPcF5cp
	 uLIAtGlPHQKjeYTLOrmW6AnJE3SJsh+I7K/fJvs7lH1RKSgDLkKeBquiQJ5Zpg4pVK
	 QCmaFI+2YAbVatN/MEoba3l47nnsaWWsZMxLuyJQ2644PcD90nDNjVCRUOeLwitEYn
	 cTdES8NR7rPBMs2Exl7aMDFZPrntHfFuhC919a5O2HU5h3zbt4V6yVQN0YreZLFPUu
	 yUK4JHulJ99HOTX7SxHcFfA86+3t2DKjG1RTNnK8wOtMPPGlwRLDeM//j7qEjTwI37
	 5zG2EUotLjfCw==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: Re: [PATCH 5.15.y 0/4] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 19 Jun 2026 00:06:59 -0400
Message-ID: <20260618-reply-item013-pedit-515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618035504.1536870-1-guanwentao@uniontech.com>
References: <20260618035504.1536870-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH 5.15.y 0/4] net/sched: fix pedit partial COW leading to page
>  cache corruption

Queued the series for 5.15, thanks.

--
Thanks,
Sasha
