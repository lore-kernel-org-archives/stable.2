Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971001;
	b=cAM2oa9jccAbw0uqh+MrcYtNccLjgqUUmrp+W7kfuEZcAsERWj8pgy6RwMf+fmtJavY1
	 zWbS/dABEPgqkcMuKr3DzyNjWgBlXzzYIZURXCNBPfYad6gR0yo4uJakYBKUZgyUM33e5
	 ZeEVBcBs/mbpSNHmTOQajhqc3zC82js6y/WxI4UoLcAcet6LOaZr/3BT9cvuat5meWNmp
	 EVsl5zT7QtV7at74Be/S5TTa20whbJ4LNtecF0EHzA+oGmhhHx7jG4sdoskzs01dtrSzu
	 ZxvqvMkl4DVnjmtcPzJqqTNmj2Y1E4qBBbjNBfMiZ/90USHWHrjShP3oaeUpHLfivKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oPk+13ymX4PLpE74C8jqcYTF39AF1P9MBCFW7zQagVk=;
	b=IOIFiXM8sg4vY47i5YMmjh2uJJj8iZB6jJVcDx6G0OyLiGktDgWnsgj1DHuLQQiR5om8
	 KM9NsWX8gXi+TBtCQwKp9T/1b4IjcNiwlnjQGU6ufDn0vE6WSihZidlmpHQxyRycXA6gl
	 AF5lof80XChenqyfxFiWBwiu+jV4AgNdKJnfPqQ3qDI4SWaYSq0CmNGfjrcw+zj7P49s2
	 BN+9UUwJmnLknR2CoBtO9Mb8iz7mErTYkCXJOxe4ZdUSFBFS+NnDm3qxtwHApZFVfNxX3
	 lbJPbAwg3U+jWiUz2gsEV8UZh5tKw6EzCRRqHYez7X6VF+u2Ranp/5pE3xJ4T30b7pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bs+RFZ+S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F0606A31F;
	Sun, 25 Oct 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bs+RFZ+S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6551F01825;
	Sun, 25 Oct 2026 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971000;
	bh=oPk+13ymX4PLpE74C8jqcYTF39AF1P9MBCFW7zQagVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bs+RFZ+SHyompnFdVCzQa9b7oot7zr8einZ6n4LLoXrXjKwDneXTnf0/BY9HK80rS
	 K4EulxgrMpYnmJCrDDY2cRdDnB3gA2w59p2c7i7UscPHqHxBDObE0dPdBuW4aUSHf1
	 Zt6vGvnmmP5w7KahsFq34qo++lxtHfrVhvq9OLg4JkpEshoNsItTGAVIE7JFbeE70t
	 5AezGdUTT2Q+oQyRSAMmQg7ylwxIHqCE0ssloaiAcFhgpHZoSATpxTwaVkubvUjF6z
	 HDPgUGTQqh2ttytqqqlMMUh4JCdm6rXnBGU5QgRNWM2PwI/UX+tJbQdPKf8IgfZdDt
	 YLOYAPoJFSIhA==
From: Sasha Levin <sashal@kernel.org>
To: Bernard Pidoux <bernard.f6bvp@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Sun, 25 Oct 2026 19:29:47 -0400
Message-ID: <2026-10-25-1-daily-reply-0001-rose-ax25-netrom-suite@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YByGZdwFd-krYza5VMXR35-Lv7x0A=2OWi5TdSzZ8TM6g@mail.gmail.com>
References: <CAFAa3YByGZdwFd-krYza5VMXR35-Lv7x0A=2OWi5TdSzZ8TM6g@mail.gmail.com>
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

> v2 of 16/26 is attached for 6.12.y and 6.18.y. The loop now tests
> what skb_dequeue() returns:
>
>     while (ax25->va != nr && (skb = skb_dequeue(&ax25->ack_queue)) != NULL) {

Queued the series for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
