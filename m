Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597007;
	b=Z2+2q/+Nm6wBX+GBSwDijO32LhovPRetcVJULxKc2zUC+tejvztCXNRcm1QCLqh+FEJB
	 pvQa5Tl+AL2skk0aY1vu1Hg5KYoijVaTg4YN2zpALXECECJPvFNAvU1vNAO51FwWMTnXb
	 87wG9Ztx5ljz2xkfVXCDtF4LvyClFNsGLgaIMs5PzpD+Z6yE3urZuPZPohqlorCWxvHsc
	 7l0Te6NaYbttwCikNUWEctdsaB9yPSvhoSoCnuqQnZBDPbj/joWSPZU8Q09Dtg/LeTHyH
	 IVN7ANOLFbCbIq6b7gkb77cr7XC//hzrix15idzRDUi7y69QtwEY0hnNiyw/1qJVb/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GGj2NfFfsXFwBb4hhKl7zVm7BZxaTqHG8+VoAKawnf8=;
	b=VYCr81RSLVjdZbLH3nU1KZyXy9MwhzLGp7zSVuDIabnInhKOqbiZ7qhYAFoz9ZtL4AiB
	 yxlfKa7EZ32kIA82HvWM00+CoUHPKIE3N2Vtcm9cMAVKA/2XUEu9a4ZFYF250VOZM3Ral
	 uKLK2+/JWXAWIMeuLPR9fUeo3KXfSYUu7t88MzWqxjVREgZbGrkb0DsZ9yuLt9+TOs7nU
	 hapk2etMVQZ+e72mqgecAI5FUej4egdU6KFuJx3cZXTrGOrncEF14KeneJttJlBYqEkX3
	 ACrxewIqmgv7F+xx4vmKRiRfSxyrnIMRPYq2VtUM7URzSDynWQs5+aAwCspz7gTTGjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBEub0VA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A5606A331;
	Fri, 13 Nov 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBEub0VA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E14F1F000C5;
	Fri, 13 Nov 2026 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597007;
	bh=GGj2NfFfsXFwBb4hhKl7zVm7BZxaTqHG8+VoAKawnf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBEub0VAY7xWDZg9vhFfujZL+bgnhkbPXCxjlnY0U7ehk+EW6I2kd2gXtht696SC0
	 SJFibHf7Rkn1uUJoH28LzphLmdKfMmvU8dhHZbrv4zBnq7czBXS3KMmHIu9ucyUqcb
	 nYiiVqCe+jepWesI8hYqaQoRtxd3ZILWlIWd1qf2U/C44FsHEJ4nOafCF4GI6WTreD
	 9reX+NjPE78xFuA26GE0lJ1e/3+piaaFMTm0Ao5VH8OXLE+971m/0OGdPOShdDj7+G
	 VnxYN6SLIgabWu7GoFg+Mu5j5oMEB/5oXLp6vaFy9jIHjcbyRFVqFRs8taDIqF3c+C
	 chOH9ylDz2QTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 5.10.y] net/packet: check TX_RING fragments before memory accounting
Date: Fri, 13 Nov 2026 14:09:52 -0500
Message-ID: <draft-0002-redoebelpacket510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112202259.1603271-1-doebel@amazon.de>
References: <20261112202259.1603271-1-doebel@amazon.de>
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

On Thu, Nov 12, 2026, Bjoern Doebel wrote:
> Subject: [PATCH 5.10.y] net/packet: check TX_RING fragments before memory accounting

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
