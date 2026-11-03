Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717555;
	b=hDa1U0unGkX+vbfYRCy9Rb8XIy9r0OjacVF7OqRtiDECY0hA1UhRyt5UfQZVmry5nwGt
	 d7EwOBEMvVRG8co3epCX7tJDfnzDOtBEWcRdGQaoBaAEdSVtLxmQVn7EaubF9iBb3tc3y
	 5uMUOJNC02iFNhSr902vUu9xlMkM3E5NLHtJhiXOzKkgMsWO+LX2Tl1pbQn4x4maRquI3
	 HFIBAs5IpuKhiv4981csj353xHBFKKnI8NUuPTxm9mRi0LESdoIw9rUBQECBocBYkjuQz
	 8Y2m8VGmabUnUp1LWIQJGXQUppxNqYTXkgvbFvUoX8Thwi6HbOOBAQR1KBy35/uibvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AAzIll/G3mnF5zQtYAyuxjDt0EffXJJC3bR+/g2IsC8=;
	b=ABbBRWwlN6GeIO2Fr19TyXtQCtHaEQP4HE93ox9vuP6WWPJGrsil94uELaJICnPx1fAe
	 Drh/fWRjvWCRZOi/jQgGjJszv6u/tf5w9kF7pqs2IGDXzNWI0JUsm02dcweWsSu30cDwJ
	 BB1746PI45syZVmna/IofJPuVx/NDROjTrSgvUL0cxi5GusWJPxCorxuObB4EeN9lkeLk
	 xENare2dbOKPqoSnjQFK5BrDNToRGQw7LPSBzv4oM8Q2wFc8++xwSr/ur+g3f4Hf8RXuL
	 zU0xdZGsr+KPI86/yypDWvmFwP45g7d1cPRTzT5KZTWZoOQVw1WJgTtmQN+yHuGGl2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mo2bin+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B060A3836;
	Tue,  3 Nov 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mo2bin+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8D31F000C1;
	Tue,  3 Nov 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717554;
	bh=AAzIll/G3mnF5zQtYAyuxjDt0EffXJJC3bR+/g2IsC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mo2bin+6UEhZdQFP7BJXmtl/XVg1f412ocjqydBcw/uxwQCfqxm6GvbOhhclp8c4D
	 H2HBnbGKfP9jDlHzlYRx61e504s12dwQ2/6618fKlvIvqDfhZnY+AyV8cY8ctFEbWc
	 gQD1TvKr2eBp9cq6THOQUsYOPlXbb2KSmTEMLr3QIrk+axL40W70TPYQ05Lsvdtudt
	 ksqp1O5OPrZl4isR8KHXCiE3lJV78kRfRri0OO70aDWUt2usAqsiCd6kJRGot73ZOw
	 g5Kmm18dawUazihyIar1/k0GlSwR2+02JsPLo/AQyMWuoifitt6ejmLrT+p+OjfMft
	 N+l9cy28m2mDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org,
	abdurrahman@nexthop.ai
Cc: Sasha Levin <sashal@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: Patch "i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO" has been added to the 6.6-stable tree
Date: Tue,  3 Nov 2026 09:52:06 -0500
Message-ID: <2026-11-03-1-daily-reply-0018-re-i2c-xiic-defer-rx-full@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DML5Z7RGR8LJ.1N4L196Z6ZTPS@nexthop.ai>
References: <DML5Z7RGR8LJ.1N4L196Z6ZTPS@nexthop.ai>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Mon Nov 2, 2026 at 2:40 PM PST, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> >
> >     i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
> >
> > to the 6.6-stable tree
>
> This patch should be avoided. I have send a revert earlier.

Thanks, I have dropped it from the 6.18, 6.12 and 6.6 queues.

-- 
Thanks,
Sasha
