Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785777;
	b=xIfqnKQnPAmmsNRwkkc6i7ddT8sL7lj3T5bxfYf5n6dxIf4VWzOuewf6X6U3mmyIkPe9
	 Q39h0/VP++9GPYrJMnAypDxbfyVetFvE30xD5RCN1GBT5fGyL+MH669+I2xmfzCiyocOy
	 M/qoiLxrd4jrIdGD4z/tMPCIfXcMbTtoujuXhf4CQXAypUxmJugtLMfF3gbfEY1+dyNi9
	 YVwrAH4WCvBVMAvZew8OYLeqa8ltt1KEchz3cGzSpf7J6ZixcCRjKtP5Pm9tROx92DeK5
	 npC+KZnvvVbk5P3TguoIRf9WztWhMHAIdbA8oesseHVmjoUB8ZQmEc4pD23PESCc9iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785777;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AC69eK94oMq6bejAG5uwl7cQ23sJuxwk1dTLkxsQNe4=;
	b=KuYMGMOMHCx4bZW2m5pw1kWYDTYF/9hI6b8JB9KCdTw7jKv1LdhjXqPYGplAg2k/T/Da
	 RxBylWw+Oyc4OoPwpC0bIzBo6TpWTt39UfTM+2Fb130AzpLrdbq5+gmb3tlGBg4VlvgBr
	 duOPUusIe/i9zOfOnyjj3DJeoOyGbNDLQ6ZUxwdqYGU721Rx0Q30iPh3iUQ80GZhOMtmA
	 /U4go03syElhZwE7JVTFMcmExhY6EZFPzRwXotTVXA7SrDHP9DexkfhGiRtyTTUNAV6Tb
	 K/32PshpxWZJCg52oGCR/pWgsMjckIlflBjWk6VKwb4ZfFBthlCIDT5Pbl8RCB34BGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0nZr2vS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56502606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0nZr2vS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585C01F01828;
	Fri, 23 Oct 2026 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785777;
	bh=AC69eK94oMq6bejAG5uwl7cQ23sJuxwk1dTLkxsQNe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0nZr2vSTz6ZJEC408QaLd66x2eEQqwvR3lAZasoTjfo7CUFGT8UEiEwdDZ4aGTI2
	 MRu00BWZIa37gw02/kPpGYhSXteqOyLfY1uXR81cYOTUpdW3NRBxfiBKfB0eO9Q6+Y
	 QhN2sLt0UHV/t8FUJXjv3RFjecPST6aJ3MsFg3xqbeBhTiUL9mFNdezy0lXv60MZZr
	 JhY7X3eWvEgd+CN0mMINpERbuGakQFmdWt7Z9X9zlUiJejP5g7Gw4R40xCtxiCYOJb
	 DNMCjF+nE/BzJyoGREu7uSUIQQ9N2hYp8SgDVQu86FAlUaE1lSoJTwNyO6Rdfa7ArT
	 SyNBviB2EkyzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 6.12.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Fri, 23 Oct 2026 16:02:37 -0400
Message-ID: <2026-10-23-1-daily-reply-0001-scsi-st-uaf-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021155547.2740356-1-loberman@redhat.com>
References: <20261021155547.2740356-1-loberman@redhat.com>
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

> st_remove() drops the probe reference on the scsi_tape with kref_put()
> and only afterwards removes its index from st_index_idr. If that was the
> last reference, scsi_tape_release() frees the structure while it is
> still published in the idr.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
