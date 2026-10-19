Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443360;
	b=SekIsXpzVTqdcRmmgqWVNYRhS561fj9iOvqJAK8NW+1YJ41RLsxx0OhATCSmlc9pghFg
	 jquqz8NrQl/cxBrSjUCQfQywbb7hRq2lQq6mKZr3fpCMOv43aZeuU8olIoumjmy4+wzJ7
	 0P6mtJ4U5shaNpC0NjzlCIbY9Xz265TLAv4hwODtsWqQCHgVi+OTyYpf/9/wB/4xKGH68
	 HDHnTNnsI07KTEhv0S2wWFUF8WbR4DsYX5/MKcCUwszmBQbm7g/tOlMNaTHhcAAYH1mtM
	 iuAzWhw6/Iz083n1p+y341i4ztSlss55bOfwkJ5y3RDAFNGxNR9PrlaSSRQ1xOFH8GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MfEcM7XR8BekR/lwtKAGvYyvjMj9to5P+UmTvrtROkg=;
	b=UGRWVIChejF/nJJCm2z9aM8Igqz7HYpNvT3ceVCbjo9jeb1xUwz58bqWluy85qesvGB0
	 1/0kc1Z9L6NEjTP6MAivIiQrMXtphGr0kCtA1KxVL1Xiww/Tnu6rQTHZsXjWZ4Z2AvISN
	 XgUyZs4DEtN61wyBX7gH4a6d/xe7KPRT19Ty7eGl/lxVfJ9vFBZD83QLW2aKW4a0YBROW
	 ChWfm9Cnx8oz7Tw8FtwAbSkxkUjM7smvkeADD2W5OnG5W2vZz7ePHgfg78c4vWOSxzv+3
	 mlntmyInMla1/MrtNQj8k3HFtJ22ZjtSFsa+vUPGPZLVH7A811EyG8yRTQxa3A/OMDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VE165g7t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D1606A31B;
	Mon, 19 Oct 2026 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VE165g7t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628F71F000C4;
	Mon, 19 Oct 2026 20:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443360;
	bh=MfEcM7XR8BekR/lwtKAGvYyvjMj9to5P+UmTvrtROkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VE165g7tS1lC1akeFovp3SQhMQiyKzRSw4dsEEr8Iks1pIhxUWwdwSxMXJDkEhyZh
	 U90AEeP6SBWlW/vEZFrDDas1W+cD+81/fr9p85Pqw+tWdG1SwK4c9omIsqvLny1Yyz
	 9cxpYu9RCSLeZJ+dbfZ9DNpv/BH60zc/5dTdJl2FXCJpjtvf17SD7WUBdVCKdSDskl
	 ZzHd84irM0h2yO7Xa1PVzrf2f7hRDUFSBtzQcqefT1zzHs0qSIxxXJa13TIPlZMrnk
	 sBFioypSw+CekP1UZcUchhGT7d5Qll3Ai7MHvarzyM+fZ6aK29N1XuGV7FD5YbSWyX
	 aUttUzah7mTLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Abdul Wasey <w453y.me@gmail.com>
Subject: Re: [PATCH 6.6.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 16:55:36 -0400
Message-ID: <2026-10-19-1-daily-reply-0011-mptcp-ooo-fallback-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019111551.2063200-1-w453y.me@gmail.com>
References: <20261019111551.2063200-1-w453y.me@gmail.com>
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

> The 6.6.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
> fallback when OoO is present") put the out-of-order queue check
> in __mptcp_finish_join() instead of __mptcp_try_fallback().

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
