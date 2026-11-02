Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633628;
	b=NQH0iDaI0aKYUL9zIJH18F7g6CnBE0taS5frLYBVmyafELzkKb15tQT/8dqjWBNLuuG/
	 nhO6WVtxnAvKrfzEV3jIRUds1xINnA8UUjRyPu+lZt22633usrSwq/V8qIBA4NGuBgZ9g
	 zf+wUxVtqcc8sb1TZ0qPkL3ZSZvvCtweZQrthP5TAlR4MhDTF9dwOR6g2irzzvOzV3V+z
	 Mwzg49qV5tgEC1n4wgcl0sFeOvrHvxGmL/I8Zu/i1Dl8QnXV4cZsWpfXE0JLk+lvc0F4u
	 uJ4Y6JZflF/y+OsCoxxfiF6Uq7ICmxc3M11Ih4TXqkHWq91PXs6AV5H1g/kgOftM8Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WtP2ksi+Dy0SG9yxXScuKNQEOmyyzscXTBKAm6RPRwY=;
	b=HdsC84avN8BUHJ9rai1D7p3tySzHX1eJDtpeJd9G+W9iZcfVvvTD8ifRalPjl1t47TNK
	 eyS4Ig7jZNRoWVHr2u/gOkVPz/SeHEVMTpqMWcM5xfrc21CrQhhLFjjdwtqRE/OiffdMa
	 mwWPQIvCJowZsm4+GXqiz1eCLqidPtKjFwzoGpRTPWe5Umw6684OLMJjfq+otAa88aiLL
	 BFKQbxFXXC3YYco1AAZkBjRMazgCLM6VazljEY7ajNAvzraSXmKvRuKc6P+g0xeRnZDtP
	 Ji1+9ng0QykdhQq38Y1mz5c+NZiVEVDI46FSConNUg+vEbi0UwE9msQiVj4AynhOR7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwIVYRyw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BD609FDA7
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwIVYRyw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2EB1F00A1E;
	Mon,  2 Nov 2026 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633628;
	bh=WtP2ksi+Dy0SG9yxXScuKNQEOmyyzscXTBKAm6RPRwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwIVYRywJRGdpxz/CNfl+BgoBfBkF1Yh//PFE2FGU9R/e8rYfOleDvoIsDEM/zLzJ
	 Jv2NR83LmgP7m6Mvn1uvMvaLpmYpg6MFz1TqerxLPlg6b5KAee1MHYgvCP23MkPjCG
	 /U1KudqjN49uqadu9/cChfmfotZVPeIC6o/cMxTmWnf4oCWBcZsFYUlL1U8e0lMO/G
	 noBAzY3aefD1/jChFc5B/5FwvARgR7rWmvhHPltipfHhs9BWpyXLxdEPwRxJeVAwbG
	 /TOSv+x3zUf9OMLrXjsSnSNSAT9Q0rB4NYpeUxpVkFf242vRdWmKYAbngyHJRw5d9o
	 HDjP+i9YTZ1tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Qing Luo <luoqing@kylinos.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 6.6.y] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 10:33:32 -0500
Message-ID: <2026-11-02-1-daily-reply-0006-sctp-auth-chunk-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102095612.1536236-1-harshit.m.mogalapalli@oracle.com>
References: <20261102095612.1536236-1-harshit.m.mogalapalli@oracle.com>
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

> Discard the AUTH chunk early via pdiscard when skb_clone() fails,
> so that the receive loop can continue processing remaining chunks
> in the inqueue instead of stalling the entire packet.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
