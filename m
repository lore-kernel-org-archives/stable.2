Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894883;
	b=hK2THx4lFA6AUYKPLm28trdvAEqrN7Ir6CYTaafoSMMXEPrez0+m0YM8fxvN+uByslkr
	 Rlsq7X6t4/scn4BxWaprZFe4J3eLrKp0dwuFuwoXyDzs1fWRbX8Aqp56H+y/5KSM80iCJ
	 04I6vmvnHkNZ6S8zHdj8DOJJ75A8C3t7jILnfvJVsI3INNoz+MOea+ZEDeBBIh7zFJt4F
	 W0PTdZyN7EmucgRRu3nUahCbWQluNk3pYbDE/08rob8RwYu9MAAbiMjIgf09kSP1avGV6
	 i+neNzVeL+ugXH35UJLoI5W3CWMIghjx5aAKF4S9V+Rd/vvmGkpUqE7wU+teVytWGOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894883;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tk1nNKvu4gh+/6cQpDYde1nK+SUWzRQlVwuGvyxxZfc=;
	b=0KHlcVGkIi67pgo+ZLnrZ2U5xKPGz6m7xk/VbSC7jlkXD1XesppDvElFy6LZANqISs5W
	 1Jp6vQqMFP5VolDBzkXQXIq35ykGNczsAmpX0dL2CBL91ZWkgQHf7JDFhE4r93U5j8Bes
	 WaWSp8VnNMJOI46luwHjY6FsDnjq7dHSvlJ/CUc4Nx2o9pDPI3Q5YWIiGBUCQHJZutalp
	 Q4clTt/jX9LSmQUgAMlYc6jhm01Wypm5AvThqnjEEPP8BwqfleeJb0Wkl2MeVwBHxzs3K
	 F5vX2qhuIft2xPJDYaBGJYkVNPkfxZFqYK/2sM9JAUXyCnhTFy8aVuRZb7PRTZZ0vTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSka3LFL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AB606A32E;
	Sun, 25 Oct 2026 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSka3LFL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA401F01825;
	Sun, 25 Oct 2026 02:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792894883;
	bh=tk1nNKvu4gh+/6cQpDYde1nK+SUWzRQlVwuGvyxxZfc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=OSka3LFLmkiQLqEa70/pTPQS9idWYgbeWk/LwcTeJ35OvI+2DknedSsgSj1VD6DP+
	 8WTrtbdgwG4TlzkuQmQV4fhpLk7/tgW2c8AFM5YpmbqM4SzEYQLDs68Ea2jOecQjse
	 YIymUt3ygNuxu6M3+glYkMqwOncXIZGcR17WvKaDFnb523mKiuAxYQWHBoPXmQuXgb
	 Af9Q6csQyf5AnzEX6rndObQsxAEIXhnt8vz9poR5suZo6DRBK7hCzTCG0bN5xchi4T
	 wjZCJzSHM3+OqVrKIoqfjFJE8aQzbE5qxiNTQswDSSRzpAzZOGCFbNi3EJipYx7ph7
	 dOqtTXu00gAzg==
Message-ID: <22cd38be-5f6e-45e6-8042-9ad091089192@kernel.org>
Date: Sun, 25 Oct 2026 10:21:20 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 YoungWoo Rim <xsapiens75@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] erofs: hold real inodes for shared files
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20261024192028.53932-1-xiang@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261024192028.53932-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 03:20, Gao Xiang wrote:
> EROFS page cache sharing uses shared inodes. However, a mmaped VMA
> keeps the shared file even after the corresponding fd is closed, while
> currently the real inode is never held by any reference associated
> with the shared file.
> 
> As a result, the real inode could be evicted and removed from the
> shared inode's list while the page fault can still invoke on the
> shared inode's address space, which causes no candidate is
> successfully acquired by erofs_real_inode().
> 
> Fix this by simply keeping the original inode in the shared backing
> file's private data.
> 
> Also replace confusing "readinode"/"rf" names with "sf" (sharedfile)
> to unify the terms as well as nullify realinode in erofs_real_inode()
> to avoid returning an uninitialized pointer.
> 
> Fixes: 5ef3208e3be5 ("erofs: introduce the page cache share feature")
> Reported-by: YoungWoo Rim <xsapiens75@gmail.com>
> Closes: https://lore.kernel.org/r/atzSVuvqYKgmvDmO@MacBookPro
> Cc: stable@vger.kernel.org # 7.0+
> Signed-off-by: Gao Xiang (Docker) <xiang@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
