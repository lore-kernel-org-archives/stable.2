Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2CE2EBBA4
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842035; cv=none; b=sj8n05ON10bOZ4Ozp4/Q9C4i/+4uunNk+6uAkONJyluDI59WPgrx95PgaAzvLk7yT/ANFm6MDd+EuDVsLKzTEAYF4KWDGyCDv4u0IsCb+lXPtEErfZmCZCPpKDgkA41ZFH1x/JjiOzu1ZY1U+X8tREXbZ9cajYP2cwC8TrxTozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842035; c=relaxed/simple;
	bh=+sjR5OqZVH0xdWDw9CFDndstLbqGyVjxUp1bbfpv38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4BJbZo8wI9dPXJWhoNiFKp7erinrtHEIxXxR2bivBUcYnO4p8mTLdo/SdLIyZEIpv9Tu2ulV+DDZpAKeqZZuh8QFJ/x4buyYldHmFRXVu/mn5dqLiHeZofaguhMSAe7I8I/56aOsmopQOlcZNIfHHK7aQ2Cp1eD6vsG+nFygkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwqe3B3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwqe3B3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEEB1F00A3F;
	Fri, 19 Jun 2026 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842034;
	bh=plrfpGS/hevj5aqwH504MZc3OKAQHQ/utB+P6u18JHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwqe3B3ObhbYHYgyOiCLBqQJ9H1I+IMDiM1Rdi/1WgAh1tTGk0iq9BJB0Hc/bcvky
	 COsSdwAclaPgBGm4FepuZTcmDe6TPTL/GXBoFfaiEW4C0FIchcqejy6tSRwWCTSsv2
	 mr30Mtwpb/sEgO0ouh4LlMjPGx28Fqu77cZNMZJziR4Mp/YIRIjtZLLKi+Woxa7pbQ
	 oyD30IX/pO8sOlHJrDD+FtvQ0/YDi/x5SIzyakf4mAz7lhu8HYv23o7Ow224woDqF6
	 xHHeDTUcESHjpWwkrEa9bU1MAfuwPdpOogCzeG2DSPB8vAENddhaCfL+a6oMNYi6aE
	 8vtjxeC787nPA==
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
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 19 Jun 2026 00:06:58 -0400
Message-ID: <20260618-reply-item010-pedit-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618075342.1599593-1-guanwentao@uniontech.com>
References: <20260618075342.1599593-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to
>  page cache corruption (CVE-2026-46331)

Queued the v2 series for 5.10, thanks.

--
Thanks,
Sasha
