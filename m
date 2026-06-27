Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91331E822
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578140; cv=none; b=pDLeU0/yF1lAn6vq40+iOD69IF/TAQb9pT1uKuZh3XSBak+cv8tswkAyOCPB8/WTxVXXGxa/SwOsCU4CEOFNW5nnKqfFFwZMK0xb9T7/hLQE6ewiDtfuJhNMyzoRTI0KXV9we28OWRq5br0r3qvbfjb3oqw/de3KPKEqVLhXTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578140; c=relaxed/simple;
	bh=btxo/cGk1zMJFdLqI5drnBrxbMTaE6XQELwJhTyXIfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXd8awWmxnfxgVGhcvhYqWEPQ1FmnI6jPZgBoBF4nYQ8CfbA51iuxUfCqUQ5CkW0qZlGySk38BjOutazQn950G5BhdbMvhH2adGtl+KL4eCWn7j6XAKIqaKaYrKqW4iCbfX9hKQlpu0Qpc3s4/Dvrpw7VELe2sIZO8phTYIwsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKs4MGZ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKs4MGZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8291F00A3D;
	Sat, 27 Jun 2026 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578139;
	bh=XdJL3R9yejRmvEHn7tZkWYwE204+inrvCodtwhhdgco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKs4MGZ3jTawKvVRRuLhJVz9W0ZSviET+RSZrZB2PfUUSDj2t+RV97atMr2vnqksj
	 8Eb9OjTRMavmS+kUHcouHK2HE612R0gUK628nRx7rGS53Gh4u/t+/b/ih2Slc/6nXB
	 qlDaMoF36iRKVlbilDe21uPQ5S0Ur7vuRzfa7KiGGHeVQ4TKgdMaV6SQFtefrRwRYh
	 yiY8H6Q8nf4oZhCjISwEPis5ejjAC1dur4Wi36UIzD1jXy041DEoyssdUuONvu5bCv
	 HJGNNtojTDLXTyv2f1laxLuK72Wgl99CzSDnH6Zv91yxPeBwzYaJhVbQk1Y7bGpTnX
	 WecKULuNzi+1w==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: Re: [PATCH 5.10.y v3 00/10] net/sched: fix pedit partial COW leading to page cache corruption
Date: Sat, 27 Jun 2026 12:35:26 -0400
Message-ID: <stable-reply-item010-pedit-510-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <20260626180735.297017-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 02:07 +0800, Wentao Guan <guanwentao@uniontech.com> wrote:
> [PATCH 5.10.y v3 00/10] net/sched: fix pedit partial COW leading to page cache corruption

Applied the 10/10 patch on top of the already-queued series for 5.10.

-- 
Thanks,
Sasha
