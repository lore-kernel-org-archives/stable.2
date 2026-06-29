Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9983FD956;
	Mon, 29 Jun 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726587; cv=none; b=TW/2XAWTu2ibcQ9OK3tvdSo+EXAdiEuDHTUXM1he4xCGP8ZQSQfPe2KRPm+KeufsRePc3wrd5l8xziqPtCeYrfqMJtcwefB0GRAPsrxy1dhRRPmiBWDbYkMvDVfY7V/BQbjwTnUKCL82u3s8XMRnRqoqm0eWUvQvwHvK60OAANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726587; c=relaxed/simple;
	bh=GDTUeQYrdE/sl9WnmXD3+R0/rR1NPFXxllgOKcI8bJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcaEqZsus3+CMCXTTvpYd0IhzsBJUCnNYkuj6En3EXBY6v4yoQyDSH3P/l9gy0sx8v+HlR7hnNOWYKRWDZcY1s3T8b7DAnL+tHLEEKXrvpVt1IOB0gumTp1G9EyVLBvXMFipnIl1F2TgSxFTQelK09lk2x7jMy2j8oCB6IE1iLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com, Yousef Alhouseen
 <alhouseenyousef@gmail.com>
Subject: Re: [PATCH] wifi: ath9k: avoid device access after async firmware
 request
In-Reply-To: <20260628001350.20997-1-alhouseenyousef@gmail.com>
References: <20260628001350.20997-1-alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 11:49:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jyrhd6c1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yousef Alhouseen <alhouseenyousef@gmail.com> writes:

> request_firmware_nowait() may invoke the callback before the requesting
> context resumes. When a firmware lookup fails, the callback starts the
> next fallback request. That nested request can exhaust the fallback list,
> complete fw_done, and let disconnect free hif_dev before the parent request
> returns.
>
> The parent then dereferences hif_dev only to print a successful-request
> message. Remove that post-request access so completion cannot leave an
> older callback using the freed device state.
>
> Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw versions")
> Reported-by: syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cb7ed9d85261445a0201
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

An identical patch was already submitted and is currently pending:
https://patchwork.kernel.org/project/linux-wireless/patch/20260605153210.20471-1-1020691186@qq.com/

-Toke
