Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD54A8FE6;
	Tue,  6 Oct 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322582; cv=none; b=VtSVTDvUiWV1Gptfx8wjjTJeANZywr0z/JfzSgMLhLswB+oYDZ0IHszmDhFNluH/7YXkg2QSB8VOrs+jyBBZz8A0VGxCMZDUaWSuIbsB8QAviHpolN79fMkZAjWh2sjcMcf1OsRfgmuuifVG838LviiMdfG5nyTs8iHOtgmaV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322582; c=relaxed/simple;
	bh=J66CZR59vNMRlIt5uvApaY2MiJjDelauvSY4Wm0/1po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIqlFH8Xca+ORJSbEp/dpc4eJnQKftqyz3qofRErN+FtWSmHmQXBYJb47w4+3jT7M+9SrwfjVetKUzfGSWIiqoB9vndAL8yQ1jl5+9HynpRKEjolVSBhzSaLUQ5sPs+nfMJpgYUJhm7yRTHM4TyKqI+tKPJwiBdtQH1bAttanl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9CebVIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9CebVIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C98B1F0089C;
	Tue,  6 Oct 2026 21:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322581;
	bh=MraFjd5/uuf+kH2m1dbbbSfkb+xOzImpsJKrWy/tKIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9CebVIK/m4kV0xM1rwKXxQCuKvDMmISSdRXs+ghRUQX5x1RlvH8F3Uy41gLhBF28
	 At/sz771s971gKdj8x4c0k0x3uPVRLY9Tt8pavRbsffiFELFAfp0+bInf/a0NBA3Zg
	 rcJZwKOsMY3cdlNzuMfFEYdVcCVBAua/BQ11PUnzr9eZGwqK9kjnWQBZBHrU27zj3y
	 wrBJ1NzGHJNigzZQgKvVpdiKzirZ8vhAp2ys288ZnarQqtbqcBYuiHj6expsHec9zW
	 hvFzH/+qGlGNI6me/qntXPQjFwkL0E8Poejxx/C996UBD5tqSfjF+BFvJcu2r+m06m
	 7e2A6SCX6pRoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH 6.18.y] mptcp: fix msk->timer_ival reset
Date: Tue,  6 Oct 2026 17:35:40 -0400
Message-ID: <2026-10-06-1-daily-reply-0008-mptcp-timer-ival-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005174116.3521187-2-matttbe@kernel.org>
References: <20261005174116.3521187-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Reset it to TCP_RTO_MIN, which is how msk->timer_ival is also reset in
> __mptcp_init_sock() in this version.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
