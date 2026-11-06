Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982976;
	b=FuRw+rjqH5K/40zYQzZnFfsyA8t6rOWprRSexda8ZjDvNtrHMfCzMtwcn81VDBYnz6eR
	 SQBpQyK1lVnQ3ogL1Nq7TZeSY1Tyadqu40F9e6K+uCgYlJZTGdNlJZm2AbmzL9V0Z7yw+
	 Mrg/Mszd3qqiymmeBKQysxLYw15HVJkHh7VYVHahN7usm2H1nTrQyJKHPnHZGrigrC9IT
	 KfAZNJfK0Mnvo6sPAdeJNDRp14rPjQhSJ0pLLSHZO9aJuMGmBGnABVafThodl4L2kHKf/
	 QWT8Q+oKp2ydWG8N17kC5szAn45UmlTXoJbYhCMJD7GGOlnQXv5qWq7JT18X4lYn5+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982976;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A7WNhY5wWlNAEsh+s9vBNdrySc/MG1fIwYRbNdZ1ICg=;
	b=lXkLFB/PyFcVrt0gIFVhFemepL6hsOqPRavHWSBni4HUenGQHQUKJosAEpnZNtSXqaAA
	 F25pijYVRkmLQRErnhZRd+CB1BZz6e3NLkQAHPAD0JxBTkinMY4qEWWZDHObolHWuItcD
	 PKdLKS/gnfCLNBLtquRfjoLcFi3BzCOThfMstOeTZ3CruDqEFE5fl547C4Qycrf+ZeRUm
	 yowP+yeSAgMSFArbbb1DN1gsPNAs2TYVcCYtoc7Rj5VV6qhHc6IatzZCqDBTog2tgo4k8
	 HHKtamqwdWVidT/KqqFutVEwmVvUeLI772igsqmE/DU+pf4n0jeo3F0rwfWtZFg+hug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYOweXsj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF5606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYOweXsj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5477E1F008A6;
	Fri,  6 Nov 2026 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982976;
	bh=A7WNhY5wWlNAEsh+s9vBNdrySc/MG1fIwYRbNdZ1ICg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYOweXsjZ6fTweo9Mopj01DEFpZA0d/XkYOYI37m4002DUFzHISw9qdULRwwOhMJb
	 mkM0BmMHS/EP4mLzy4r++Ip+pnKEEWGVau81w956Whjf4phTgTKDt54QNJadyK1mZK
	 aMeyiQhzS3GaGTV8WiaFnbaJ14uxXHax0IOxs+7VgJ7Jdro/Pomdr8s0ur9XrAEmpW
	 1wrVeofCpWWhbjLTK4cNqY7UhvIXCiVUkfYX4Q5Y3EaP1dM5dxVbAczARIq+p8AW7a
	 7F+2IlodGiHnkjDy0EbbrPOTYbhygEAEiIL1vehh8mKYo6RNYcFcS659R3b5R8w01Y
	 6moNw8M29TCvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	aliceryhl@google.com,
	dakr@kernel.org,
	gary@garyguo.net,
	ojeda@kernel.org,
	samitolvanen@google.com,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] rust: hrtimer: declare cfi_encoding for hrtimer_restart
Date: Fri,  6 Nov 2026 11:35:52 -0500
Message-ID: <2026-11-06-1-daily-reply-0017-rust-cfi-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106144721.29080-1-ojeda@kernel.org>
References: <20261106144721.29080-1-ojeda@kernel.org>
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

> [PATCH 6.18.y 1/2] rust: hrtimer: declare cfi_encoding for hrtimer_restart

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
