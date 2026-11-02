Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643695;
	b=iuYbtCDNOd+WhhJ7LOBb/AG6y6xcFMTa8RtIYPKq2i1SOpUxFVemuGcgyFqJuhq6+Y/B
	 74lEQWSEvPn9FeQdG2WztPVLehy76bQd1rsAjErlulOvSvxG5/y0D3BOM9cHGW7uUtqKS
	 MzIMxSFcdVkRIU6erZkQXbJ33fmbVvKaRo4WbEMHRF+XVEPXb5U4J8A0C/Pfl8KZ1OUQb
	 ez5ZwyWOHC2GAnQPYfsem78+rhLxECJsIsiOMZwfy/nwtvT03un1d5Y36uLcYvj13fOhX
	 lKoYoc8DuMu7hvTrxP1ln514kNkLbfYPW7URvO5fIP6W2MwGWknZ9QOBja69158iU7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643695;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Sc8LrOUpwOOhbvkPiYsmRMHyXdEiFgc947D6mXnw9cc=;
	b=EXEh29e3lom2kVV6DqL2+3tX3RuGr5urstVK1q9SvxFm7WXEJ9doINfOJYTeVUPJ515W
	 nHuvKc3cziXwm0UHutd4+EoSskvIshafLADSipn7dCLYWrwe17e4fKjSZ6VkspChCaYZf
	 Pr/xbp6i33TP4NMpC4WrChPrK8LZ5yXSAWFOvXXc6Y8FiJtJQD+Q4Lv7FS6089Qsw6gHj
	 +KXDVEJ9whqua5DNzMS1lC/vw8sAQf3xpQVdl8cN+sUc1udHT3plPhEsxYRIgoTSR+mVv
	 jmfTcjtqT27zzUS+uJDyi1nFpTbjcmipLQf2uknxsE45GgcTCdduFb/BwBeWwoxRbDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnuMUwn0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F89606A326;
	Mon,  2 Nov 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnuMUwn0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4311F00A17;
	Mon,  2 Nov 2026 18:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643694;
	bh=Sc8LrOUpwOOhbvkPiYsmRMHyXdEiFgc947D6mXnw9cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DnuMUwn0vx/KyuNCyVXT8mH7UGDcgJkGkYnsQoQyuRHu69eJ8ZxiMQq7ZYN3+1Oiy
	 PMbLFjy2xGQiwOi6lOjtjHdcfL8yEe9wp7qKbhy5cEPN6YKJd6qWmMWJdLPuqJwMgX
	 zyYtMtOzHfV8eztlps+e+/qDWQexuZEWnA3ukEr7F54go7QvuE7ehXVV4jelZ8ExoD
	 J0f2GjLa3JaM8a6BQVsbWWfKjoXZctTUBBMGwG/S/qauMWWTPJ0sB30dgbIT/3uMBe
	 X+tJxphc5MqyAdHWOKmRmWcGLnrwp8ZIqvR8z7hlqrBGImE17/8VtPQx47XsmCtTQe
	 Ch8r3vtcwnYZQ==
Date: Mon, 02 Nov 2026 08:21:33 -1000
Message-ID: <36ebbc359b76693fcbeecbfdbed5ca41@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH wq/for-7.4-fixes] workqueue: Fix drain_workqueue() missing work items chained across pwqs
In-Reply-To: <20261030164210.3735018-1-tj@kernel.org>
References: <20261030164210.3735018-1-tj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to wq/for-7.4-fixes with the following tag added:

  Reviewed-by: Breno Leitao <leitao@debian.org>

With this patch, a work item that keeps re-queueing itself forever
makes drain_workqueue() loop forever. The current code can escape that
through this race, but the escape still trips the WARN in
destroy_workqueue() and leaks the workqueue.

Thanks.

--
tejun
