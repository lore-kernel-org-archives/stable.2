Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583517;
	b=mZ77rvwWn6n0rThfiDf94fX57yWRJnL0eiwEkwdzBa15vzY0wPWUYg72cffG3Dxu7xn0
	 Gsbo73seMBlYTEUxvPD9LEKlXN7w9hfRueAjGU5/2IJWIpamIz4gSTH6N2fJTpbRGwnzv
	 2+RFoh6RMQXEjWEolh3kLXpOl6YPtbds8wac9Wbg0jO6Dn5E2a6HmN2WcezpgAuxLNt7w
	 i4Np7DPGAYvQDANvtnBCaA7oQJCFHruXxA1bq3pP6MvVLP+GvwIXZp+ojV4KWGtvfmZmx
	 18nhwyGVUjrLZwPhA1J6GhMQMRNMzhirpfrbRVcdhzvm0VbY0fqr99pU1KdXIydvY5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583517;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=98ogIzUPGu7VLgOlc7jyEjCqxoUMXHaR5mWvZQJYWL8=;
	b=CqBzqGs3VC1trqd/ei2U3axnbOLhqhENBGJEMCNhKxnPvyjjAl1YPp3C9+b4VhC5E4ie
	 XoaY3VLMLwRNC4XCaNvFWZ1F+G0E+q6g/tJF4/hAX3rz589+T5n9PKsiQ0TvvcCvCu5aA
	 ejH/e5N/esmX8pUvCSJMifvYAXQ97/eN5Sj5t1/EtN2yc/yjc7wcXq8xvZoaNMHj2sht5
	 Uc6js99uq/NKojYOBpUaPUgX48o7+NNdAHlknsr7mi6l83GXXJVwoLFdd9nOSTQxezdID
	 VANQqIfliBIH61/48lZ6Xc087jFL8Dl5Z9vFIdhM7qGJuYx+VpP/6ZR1P1Wic9pc3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgxRHqvo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464E606A324;
	Mon,  2 Nov 2026 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgxRHqvo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33661F00919;
	Mon,  2 Nov 2026 01:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793583517;
	bh=98ogIzUPGu7VLgOlc7jyEjCqxoUMXHaR5mWvZQJYWL8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=BgxRHqvont4YB9LXG3eZLOBq3ZiQb0j1cjZxAdkrye2De8wyxLDkF54eNxN/M7dcS
	 HnW3ia5/CGadudrItMNG2I1Wipk5ZCM2zlrD5CgXTe5x7VfhoVs+mkqzV4XzkUnO2O
	 8rxHn2IYJ6oMo45GVAZVADPt2OFOQ9axX731uL+6wNalc3aPiYb4Pv7uIMRLQQ4oRU
	 8MXEt/o+xIO0Gc3HsiaMC/uYGRu7DasomXyF1QdSQJqk9E1mxOeRTIPUfI/LTBKab0
	 cWoYg+gkCTF2KO0qmTf+Zq8KgReH0iptTuUiDnRXhp63eLWi9d9IHwWBhM8EObTuUM
	 10KRx37o8Jusg==
Message-ID: <87d3a118-c6d1-4c8b-b88f-25f54b7418c7@kernel.org>
Date: Mon, 2 Nov 2026 09:38:32 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, lihongbo22@huawei.com, sandeen@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com,
 syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: free the quota file name that remount drops
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, jaegeuk@kernel.org
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
 <20261030072423.197883-2-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261030072423.197883-2-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 15:24, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Remounting with an empty journalled quota option such as "usrjquota="
> clears the name, but f2fs_apply_quota_options() overwrites the old
> string without freeing it, so every such remount leaks it.
> 
> Free it after a grace period, as f2fs_show_options() may still be
> reading it.
> 
> Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
> Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
