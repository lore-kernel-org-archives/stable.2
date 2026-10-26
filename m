Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055369;
	b=jpImLhuCgG+4GXAVkJlAAUOkULLOQ1eHtnCpm7Nvok65AAXTUBNgtdOZByWDMAMuXd2M
	 PINwIu2AO3hEzRP8Cad4zSN+KbDs0PBPIOsXlOz6m08f/PWYfA5dVGFVqyz6Am6hhHpeP
	 g2nrOhqcMVMJIhm/3r38p1pEewLknbhUBM8+my8dVUxjkTjtShpsqfyV1T/1pWPGezllD
	 WVPSnAiz9dqgFvidrWtHT3XrQxvpBuNhpeobnWW/UkJyTF39G4VkSyKW8PutjWkmstMTf
	 jCQSQH3m+Yg9xOe4srYI2dIW8XEDU8BUfijIquOnaxxoLB4d3x6PnnGk98a/iaA4FeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OOBTBPuaXKLXV+zGmde3V82GAJQ+nF6xNw5pBV0Kj8E=;
	b=YE3Nf24V/gRhC6fnbq9ObYg7YnETh3fkB+coejNtIoP8xXfNt4OZ9JWafQ8DLo9c/1kS
	 pXmD8ysYoXW0BdA5aRMw9NU49sXKT9FiDV8xZcgcN5239OI29odenOZyeHxAGDKa4LgtN
	 RFHZniyXYnSXss/xziDhOErgjCST5m2tS75HcRksaWrG9pg56cj0iCPcApqpvp054ZkWL
	 FPe/wleie/PSSTWAow1v/5S+VP4DI+IOlwkIer1S9ter9nJiWBbCM3KrL27IDZNn8Ob4X
	 RXfLHQmmPZb2qccRoK34p/LuOZ3he57WOyY8uf26jCincr47vF/QoYxLMo3NQAT0UGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6rCgVOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E433606A31E;
	Mon, 26 Oct 2026 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6rCgVOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22EC1F031E0;
	Mon, 26 Oct 2026 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055368;
	bh=OOBTBPuaXKLXV+zGmde3V82GAJQ+nF6xNw5pBV0Kj8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b6rCgVOfmjpEZtaPMJP1qXkQViIMdl/xQ+hQBoZO0h0mNS19cTVL4/zQ6iczJi0xi
	 /TyJLGsrPQplpPZg1vIssfjzcKqMVRt8r+0nrWtIFWTxNjZ1q29oXFotq1m2VhbUQG
	 GPEMg7bquk6g1GB7jCqBsKMBvRZ0nLTKd6AkdA+RaTdIdWhJnOZE5Wd5aymasZrxKa
	 Pe9otMmRlpzgg/tgfffm9BXAXJiKpGMsRjuGka2V5SkdYbSI3tGQnaViOg17PQvyqf
	 e02ufiFNikP6NQPkKDz6a+JS7nDVnXpIXJQilQTajzJru6gg1wwwqmguc7xqon4rHJ
	 hOhmTTB4cZTSg==
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 7.2.y v2] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 18:55:56 -0400
Message-ID: <2026-10-26-1-daily-reply-0005-damon-zero-target-value-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026133645.119485-1-sj@kernel.org>
References: <20261026133645.119485-1-sj@kernel.org>
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

> Also, the upstream commit on this stable kernel can fix the issue for
> parameters commit paths but DAMON start path.  That's because DAMON
> start path does not invoke damon_commit_quota_goals().  To fix the path
> with minimum change, add a new small validation of quota goal target
> value before damon_start() call.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
