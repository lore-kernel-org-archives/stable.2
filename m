Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E732E68D
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842042; cv=none; b=JjFCRGidWNxB88WEG20CK8O7Emri1VEVghcARr1Cg7II9smZkLQ5AVe8A2uW8JBN3J0S2PtniVdQnhzouZfXcQe9bDgOymf7vjEC5YERl7T/eX6NuEBty/9NHZ2vdkTob6uKBXYgPl6ZmbTikUgQfHBe/L76jPPnmQrIz92SCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842042; c=relaxed/simple;
	bh=7vfF2jCBGmuBUGARGBRcO3i2VMzK2sSB6ZEnrp9eAls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enmOqya+4IgNKhtj+GtjdDghTAoDAW29swpbG2dMXDm5zvgKhFwtZRoKgbv/IyOiiLFxiN1XTbS94CU3Ttks7hyxzeeDT9bjSSXKASjpKryyX03ZSoXfsh13Y1m/WtvBPBSthD+klMpnC7+Y5Imol5eo7mxxibOSrYj2/nPfJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaIRoLDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaIRoLDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4663D1F00A3A;
	Fri, 19 Jun 2026 04:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842041;
	bh=zcgGE5aV7/LAhe5NlFW17EdmOafMmlwOkUR0YYn0Mmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QaIRoLDDPav0jzSe0hQWvCljuGWA160FldZQGaNbMN1Hc2b985mDCIHSGt//UMt61
	 Uig1Vm9NLes+9zUi25o7csRvBjFi+apXjrPQUoWSn73AaGRPZYUd3i6GFo4Ud5DRoH
	 6AlXc/0qQmxaLc0wqPhRPnmSAKtwYUDqrlZ68LBL3fVWJbFx0wRYA2CDyCZSCY44wr
	 Vkbr2Rq067sAFE5m1v+pd1OQQx9fRPZBq2A59WA3axCUjLVo1E4HgDJDnmFvV7W2ey
	 rbNM80yHXxtFj0XhmG0z9i+X9EY2+qQ5Ll3/gpI7FQqkra2+PvCcGl5ANgaRllrthI
	 3p4FHmCvDtUFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH stable 6.1 1/1] selftests/bpf: move SYS() macro into the test_progs.h
Date: Fri, 19 Jun 2026 00:07:03 -0400
Message-ID: <20260618-reply-item026-bpf-sys@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618014033.83033-1-shung-hsi.yu@suse.com>
References: <20260618014033.83033-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH stable 6.1 1/1] selftests/bpf: move SYS() macro into the
>  test_progs.h

Queued for 6.1, thanks.

--
Thanks,
Sasha
