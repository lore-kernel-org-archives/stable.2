Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877392;
	b=0BFhZtgAZyWMZfLbsLS8Jzm++MrqpwbLtQe6daDgHHmpBRCj7d4YEyVhyxag0r3h/rJz
	 lpJrfrI1DVn4Y06ZDwF2l9uDTp9aIWzJ0Zj1oHw6RQiskLVShszBk8Cu9lydMODqChjnZ
	 UePCO+dsePJ5CYg42JVE0+TgWnMtnwHd4T4JRtvdDyFOaoJ8iqgF3WehXeFxVTqk0xnd2
	 dlQ+15AT4NaSXlB6ZopDQfr05kGgYEW0e2G/16zrUKByvURsDPLKx5C5xR01Ey2wgR3BD
	 hKjRUsj2kHXcS7sQM21ApiXM2EG4goxGBY9L+v353gkBIPsHedtueEBCTC1HKiNsAsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LyJpGAqYFioiro4apH54eAeedZMDD6x6P+0TzzXpvFE=;
	b=GP7/gfGR84MVNErvVuKDq2ngtW578GcxpPNRxpjMEt9WLxZL6uvO1FXktGj97hMD3/57
	 mjw85gD+gVW30OtgKnH61nAAUJRTT1BwcZLHxLrjbodmJ7SYxADC4RYCloiVzOjXh7ZJQ
	 Uy29A16EVlNa/fw3a2oILojRrbvaKb4eeC6kQkvdwNcFbtaaevHQKwE0yBNck6UemegWZ
	 lvfNyvg+9P5FtJT1X6AyTwU73vXhgfpYAGoC/jWxb/hbGJ/QwHDG3Ww4XIn4cr1KKWkXx
	 Xyo93T5KVARVrGkqXsXIuqCst/Tn60RiFDqd95wej+CQ20NFL1UXVfTl5EbGsAuvlSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzfQr4W3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB1606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzfQr4W3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAB91F000CA;
	Tue, 17 Nov 2026 01:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877392;
	bh=LyJpGAqYFioiro4apH54eAeedZMDD6x6P+0TzzXpvFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzfQr4W3A27gmgc9s8C4xNHICDCikwdSww3UFg8SN53n/SAupGlHNTxLpSSvOuJYB
	 ODJBv0hbEawWPG/1ricUbd85WiZeLC+vocdBDY3Pz3Bz916q2jowjEH9xGOHWLwz32
	 KFRN3cXFgyY4dgxvlrv4fuNwqKgBFLKDBcc8K8+zIVx32G4UJcaYS96fXMjBU4aoun
	 y+3Z99XDKPspxydGuDdMRjM4lI6HKqpxs9Tzbyh/6+D5N+AEspN7UvV2x3hV06J5os
	 P+uiQB5CVWB3M0eXzS0TVRwZImrUbVCRv6ZfjaDqJX3iFb+YzCNnEX1d+FetB3dqPa
	 v2UKQXN9a9A1A==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Andrea Mattiazzo <amattiazzo@suse.de>,
	cve@kernel.org,
	Petr Tesarik <ptesarik@suse.com>,
	stable@vger.kernel.org
Subject: Re: 098bcea71b8d security relevant
Date: Mon, 16 Nov 2026 20:03:02 -0500
Message-ID: <2026-11-16-2-daily-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116114902.561ada6f@mordecai>
References: <20261116114902.561ada6f@mordecai>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It is fixed with 098bcea71b8d (by correctly updating the AP microcode).
> I guess the commit should be included in stable branches even if it is
> not a security fix.

Queued for 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
