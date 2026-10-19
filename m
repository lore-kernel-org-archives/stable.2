Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428896;
	b=cy78rD4YLfZ7dc5p/L/4YXKdVd36dhWtqv5SOmWLSXq3tyoyJrltdlaT9Fua2MGcnnqr
	 zVR4k3cQFUcPkQzR3gB8yP3CHStrBTQFgKmb7auJVo4+ccnYdhAjlmrmKF3/C4WrKDYKX
	 YZLYVu/2Q3UXcu5Ni/kRh0ZBlbmQrbquDzJNVjS68YZFVgQBDnogZ8fvfs6HD+87Xo7da
	 eNaEfbunOMr81Ky961Ft4R+YLlBJLOyUrKuGyEHnjseq6B3YMn742sEVwctYWypNwA5k7
	 KzTqYQummp3RyZLJI5vWpyUyr+MOof2TQS38r8Yj4zTxwYAk32aZAW/ZSycg+OzW8VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lxpRwCCvswaeNGSGCQHd9d171tlIucfRlQKacrxY3lE=;
	b=18v2LCKgluOsH8LwdtPxBQD1AYlZQ5z8ifH8ig5NFnv0wUv6zmO1siQomeZpX9R+TZ2d
	 J3y7nmkBccrxUIfXsHYizccQLRHATCyNfcNESoZiIYnwasZcSLFc3Xwmb2l7UcvJtitEB
	 3QTOEum7ZsvzbgTKLPP6e1gxrpRamV+31dQe6cN1ZShrfDgcj7cPPYpReah4xCT2t4iTL
	 C2uWaS3Q1o47XuWXPu31uSWbpcXSpfbRHHhBtih13b0BUxzC+gAO2TlIUBnlnfn35Uuua
	 AYd6nIS1lLfN6mUmFxp6fwez3O6uhTRRPOkU5C0WZW/1Fo26x/J9o2jTp6DY01kEfNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2rYqsDr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF601606A319;
	Mon, 19 Oct 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2rYqsDr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4638B1F000D0;
	Mon, 19 Oct 2026 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428895;
	bh=lxpRwCCvswaeNGSGCQHd9d171tlIucfRlQKacrxY3lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2rYqsDrXbsudWK1jprqgKIduEB7qdnTuytEWMnNbk2SW1oqb8A4vmProxtilvcNW
	 tCRliMFqN1ItvKHMsksSk+jnXQR/VtfxLqILpW07rpSPODNwcoaCiYE0Tud5/ocAIQ
	 iJg9n8Y4s5A+za9iTWf0O9DlSZJG2P44lPg7WVAOH1xd08igNg82zEtOiX1lMqP3kQ
	 E6sg5ZlUSz9h/ZxNsqljVksYb7HQrmI+f+96M1Xpp+Gu6YHoWEpeESXhe7H0DIO+ps
	 FL4L2Wuvp5xWn63C6JeSYuCBYpiiAKmYmsJiZcSrlym3Etq9cGC+Q+iudgA6HZf3e5
	 uZ8JaiSWfUMIA==
From: Sasha Levin <sashal@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	stable-commits@vger.kernel.org,
	edumazet@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been added to the 6.1-stable tree
Date: Mon, 19 Oct 2026 12:54:33 -0400
Message-ID: <rc-reply-0005-759883b4df64@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atYeWYox-fcuEHX0@sgarzare-redhat>
References: <20261018131321.3798770-1-sashal@kernel.org> <atYeWYox-fcuEHX0@sgarzare-redhat>
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

On Mon, Oct 19, 2026 at 03:48:24PM +0200, Stefano Garzarella wrote:
> Be careful with this patch, this caused data loss. It's fixed upstream
> by commits:
[...]
> So if you want to backport this patch, I strongly recommend that you
> include these others as well in the same backport.

Thanks. Dropped from the 6.1 queue. c6087c5aaad6 and 2a12c05aef21 don't
apply to 6.1 without rework, so the full set can't be taken there as-is.

-- 
Thanks,
Sasha
