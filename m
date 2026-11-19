Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104536;
	b=hJb9oCJx2twCP6P8nOMzheXYO2D3ZXHt5THBPGwr+gxhs2qu9bPkv2EQcgAjmwE6IKDP
	 fDoXcR9elhDY3cAHFOXpamJoMwHAAuNvCs7pu/ojKbNKq8GH0g0edS0q83rURkhmEn0M7
	 KmhRyG7CvcnGq//DsvAAG5GfbyRQMatZf31/XXNOWTk8n8/Q4cA+VbfVf5tUI9Qk6s05g
	 Owj/4Sl7AxVc45ShVzUxrvRW+iv6MlNAsz5d8oB6rlcF/HBZ9sdtJxWxrABG1Ki3dsNz4
	 sxkAOTDrxyI/U5eqZO/qEiDLB0vnEmCl/jrq3AGCPLxS9L2fKu8xSS1/Y1CNaFse7vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104536;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TAm0qtfkHnOKChRqFjAazen5qd4yQ3ACm8L6uT3bL5E=;
	b=bAppjllPxYqWzCLj2JGHuczo2fNUoauxhHy9qnEg6QlmtgL5HDG1F6vS9Vuh+IyZ3t7A
	 hLGGJKSgykVV8hPalI5Tpd4gkFET4KzYNdXVBVtixxxZK7dUqBGA96a0zRO7PxngVCSjN
	 aR9Xt9EC0t5lGULF598570ZMLqv1vxj/0MGhhGZO9JtER7xCCZoXT34owC9QpMyPQj9UC
	 jusdSspiwiRcYjDL2K1/rhTXD07YV6yeemacKUs0Rc4Dnj0z90pI4ofRxcL1zlW0BaGs0
	 lgUgA/kVZdsG97b6YIx65XgJuOpmUrWH5VgIBIJYAWrCE1YmFmsPfvpGlYPQP4XB81w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHETkRDE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955E606A333;
	Thu, 19 Nov 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHETkRDE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B9A1F000C4;
	Thu, 19 Nov 2026 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104536;
	bh=TAm0qtfkHnOKChRqFjAazen5qd4yQ3ACm8L6uT3bL5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHETkRDEfFV6jh2prfyi9QP1I+F86d3HOaRr5sCMMKiPf5H0REw6IoX1KIYsm/Om6
	 qd4XcGZ0CkBTpH39Dbb+KSH6Fyx/fr2oj7jF2cF+RQeQP//s/aww7CoC2Tuk2JxLGW
	 hMKM+h4rMkdH24ETJNe4G2LQtsGLC0n2TCtKTM4rUleYGxjIFNUJCSBWK0hySHFjWI
	 sx0gzRMREJXFgRj5jQTo+fYCQzpDEyeDhyf2v0zxXDshInux3fVqPesdDgMvPXVrvp
	 027HcjhFMN8FEyaoonw5ttJkBMwLQpgU/i8Z7fFmrtFBs+vAdVwcgBpfouOqjaCXbb
	 w3teMuB+JAjYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: Patch "irqchip/sifive-plic: Cache the interrupt enable state" has been added to the 6.18-stable tree
Date: Thu, 19 Nov 2026 11:08:23 -0500
Message-ID: <2026-11-19-1-daily-reply-0021@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABe3_aGGSWW2LrPHNtAU8Lc2NqgeOQJrZNma2WzQ-JH+vFyWJg@mail.gmail.com>
References: <CABe3_aGGSWW2LrPHNtAU8Lc2NqgeOQJrZNma2WzQ-JH+vFyWJg@mail.gmail.com>
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

> Hi All—
>
> On Tue, Nov 17, 2026 at 11:28 AM Sasha Levin <sashal@kernel.org> wrote:

Queued the BIT() fix for 6.18, 6.12, 6.6 and 6.1, thanks. On 6.1 I used the
one-line BIT() form from your 6.1 mail.

-- 
Thanks,
Sasha
