Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11025284880;
	Sun, 21 Jun 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049683; cv=none; b=AeuPzfZHkVDcXhxsA2ga8l7LgSMTHpagz6jb094l85tI0rLP6PpNEyWoq5EkZE+e+IH9ua+7qjKvBmBm6gIV9l1hcmXAXAH36vDipKLlcBgy8rt1Mc+n6XdIHktUqIsCUNUjZGmyskkLjXpL8Vx9pj08Wwd6yjoTlbreaPOdcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049683; c=relaxed/simple;
	bh=Pb7JYT9q17DCcNrl1y0A3QiuhVemP6/3leF5kP0qupA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxefxS8jJa6JqefKJQ2brARWkTRlvGd7hXMc51hKiFPIw9XCC/pJlwPX5BWzq0ySEJhl+Wf11+ssKxtO8VezU4GWGhfrxnNEWvfpalYOLTaoyWAPpdd2m10GI9jNXg7GEGYUKejBhzM9EYlYwEbf/1/QUehzuMN+LBdgjWy0OMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXHEHJbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXHEHJbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E3A1F000E9;
	Sun, 21 Jun 2026 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049682;
	bh=Pb7JYT9q17DCcNrl1y0A3QiuhVemP6/3leF5kP0qupA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXHEHJbdfZIO+KN1DmjpS2zYjqgc3ZK9FOvCJy/aFx2kLW/6rmM0ENj7855JQPFnS
	 hhVC7xtcF1a4tRLYLigo95IxxrDRa9gemNDFk+AS/bvej6qySrDp3kF3VxumaKTaGF
	 AcKJmspFWGMSUYQgWm3gtOiC/Xb+xQtDmLqDUBQZbAugennX+fbDjwrTapLsbOPR/x
	 PMVoZjBd85X2zRlFpu7jYUszuPlQ+TEdziOihtgH/aP0U5cPPasu9aqYK5P04rWYn+
	 QuTSOnSvggr0WlYf3ZYm9avW55QIdG08HJYHOGxkb1DvMu3oqTy8z5wN4jD5zoSAM5
	 mdbLePyC5SauQ==
From: Sasha Levin <sashal@kernel.org>
To: kuba@kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Sun, 21 Jun 2026 09:47:47 -0400
Message-ID: <20260621133722.0009.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com> <2026061625-starless-mascot-691a@gregkh> <CAFAa3YBciYSJxDT-SH=4oppyBS3hWUSEwJP_86EgUriJfYkjLw@mail.gmail.com> <2026062048-posted-scarf-dcf2@gregkh> <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I have prepared a first set, attached as an mbox: 15 ROSE fixes for the
> 7.0.y stable tree [...] The whole series applies cleanly with "git am"
> on top of v7.0.13 [...] The 15 fixes form one coherent set [...] this is
> why I send the full set as the first batch.

Thanks Bernard. No objection from me on the series. Since Greg has said
he'll apply the 7.0.y batch himself (and these come straight from the
mod-orphan tree rather than from a mainline SHA), I'll leave him to drive
landing 7.0.y first and then the identical 6.18.y batch, and I'll pick up
the rebased older-tree batches once you send them per-tree.

Thanks,
Sasha
