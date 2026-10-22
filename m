Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634648;
	b=L2KnsUT9OgVymS97wdBK+9aVDDpUy0mmLFnzyT9i5hhfOMzGMHmOMaijXzUX6wuc4N4G
	 kn80N9Srdh32fwyj4y4MLNDchmIeRWO6yhNfKI+IQiKhFJ6gLWpl2xA4GAsGMTKYFihV8
	 IofjI49j4uwoE/z7j2SBnohsI+0gcjWQPCBQvIoio+0dtoyyjlh0SnoFNySKN6nfoSfG5
	 WIBRFy4j86PeKRo8auaLuFukkn97qo3KNJnTATJGQKJ9SN8pEU+dIwAseh2Wxay3GCZhP
	 JeLCrJB+Z8b+BoMXilTCPOLu0htj5AjZkxz7HSwVoq8hI+N/01351iW5FVKDUBBflxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634648;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=31fjzAaMtK+Xgn3e4J5pgoW/YeJYnJ0ajB39xEbrtBM=;
	b=lc5fhEr2DW0QestJxU+swfep6JEMs+t4Q46GxbIKP8eobALKo9wiKSZYpmPxTy40djLg
	 cqSrXylR1tOB5W36c2Mh6HGYMow8tghnSDt9QGdOILhi+1cCfPcSQBUgeItHwZi8SPIor
	 cR4l7WIZX7k8uuyZ/tZ5U0Ic+Fp3ZiNvmhlF726ZEPmxjuPAfSgUNoZp0chxE8igcXwvy
	 8tm3jDex3x254/7/kxl6CQjod3sLvPhq2+JL+7GSqmwCFEgpKo3Q2bwH8vvSybB8sK0zW
	 SNsKQC/leqeGqwg+H6BjyAStxyGEQa2Zb5v7VJP+cG6mVVcfICD8trUo/n/060lEQ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VvblMpP/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485E606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvblMpP/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD09A1F000C2;
	Thu, 22 Oct 2026 02:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634648;
	bh=31fjzAaMtK+Xgn3e4J5pgoW/YeJYnJ0ajB39xEbrtBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvblMpP/Y0DdbBCo4KgtPINIUUAQ0mIEq9UgC7M27VX/GushwUrRQ13KI6aJ0ep5h
	 HfUijkArrmRw+QpVC3LfkO5krjlhgkkv1KhIQyZWNzaYseFWgP7rorVkEFVXuyV5We
	 lav78k1D5E79cveCx4z4HKI+l/dwLf/ipEmjgbqXJVGd9Gn4RxG0LMAHsBqTdPh9UP
	 hRZX31BORr3dxRxrRR5N78PpMgGzugkYmxiy/e6FfaJX1d9RPfHj0HxPj3Pm8JPObU
	 +edYNwoESSUt/vRJ4gzP0lFdfvIPFA+sx6KmRVCzAsH2eI5uRRwKg3wjQH4gqPysL9
	 YVC7WKYY/KPQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicholas Carlini <npc@anthropic.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.15.y] security/keys: fix missed RCU read section on lookup
Date: Wed, 21 Oct 2026 22:03:34 -0400
Message-ID: <2026-10-21-1-daily-reply-0009-keys-rcu-lookup-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-64015-v1-1-6b1010633008@bootlin.com>
References: <20261020-cve-2026-64015-v1-1-6b1010633008@bootlin.com>
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

> Nicholas Carlini reports that the keyring code calls assoc_array_find()
> in find_key_to_update() without holding the RCU read lock, while the

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
