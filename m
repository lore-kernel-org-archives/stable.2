Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081848;
	b=qC75Q8ytW6pEwunRRTj1js3DXzppv8iuF4LJbERRDr/67W+JkmvIcwCGp/GpgjwNiECW
	 0qdkEs2Zdrm19wJs2sOb2+po+Ibu+vk6QYDeCAXpNgz8RlYExde5C83UCMRkxuzCU5WU1
	 GARXVfRuzMTFERRsYjd89KpYy1V4MOUKRNDm1LU5GRDCoTvUzRiUwzWQpYCDTFo3I4A5X
	 75dpggvP83YyyQnojj/lT2nt9Y7MnkFk7EspGHRfR6X2HnXHVW+1/BFHy2pv7rNNR68X5
	 d6tJ0ioKGLVeekVz41iAWeOTAi9UfCjK8EuVqQuNzr3pKMsd8LGbJ/9p4KDNGg49QuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q8NpgvHlPD0G07F+ilJoNNzMcnd2Ca+KKOPEVCNZy9k=;
	b=I28ZfYtR5G6D4BTKT2llRElqnRDXYKXvtQxftVbG4VlmeZzaM5TcGI32KVCXUlfWX0Dx
	 T4clpHquzwl/SuP+LH8qzi0V2+bUdsxZNkX/E3LSctK4m82Yw5LwXqYO9V1mCQV0m6SKc
	 0SqDaWpak/n9w+5Dy7x5MX8KNwhxompLeumkiEkH7ciPwwMzbM1jRWE0qHEmxypkXyNEs
	 /RwJiq5lZVZcyCWpkWtO452AGTIdeG0e3lsFLXWA89mHnsjbPnA0y9fIJ9PfPNv/6xKE2
	 /QOinzTlAr/XtNyM+ibiOdcWTUfyE7KTZW5gHLQ3Y8QZiEd7DnyhZFhRlzSAkkbtQpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3xhKYyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B33606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3xhKYyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9291F0089F;
	Sat,  7 Nov 2026 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081848;
	bh=q8NpgvHlPD0G07F+ilJoNNzMcnd2Ca+KKOPEVCNZy9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3xhKYyIukEG7vrCXb6B3AtGJ+7ZtIaTkineF7kT8nq9vVnNu16x8zVtM5lzS4cOn
	 ETJwSmh4cRMUVqhEZDeF4C9etPS1CHDdlC/GxLdglkbxeYGPxH3kyn7DZjiT6uP6kq
	 HqwZEfWqU/yQullCi9nOly9G5QPQywi2/RPY0+TznV47bYG59bLXaHmcGv3t43XJlZ
	 DiTflsJvf4aTojBq27ULe8NSNUNDclsvK+w1lH7fgWmp7H6u5FNy8g89jHAvVrJsG6
	 wZspGdzRz4xTkrFgwX2mlEE9oyh5VjMZQBt6YqBClGBnnvbKQh+7YL0WNZAPTJX/64
	 1uE+HOs522IAA==
Date: Sat, 7 Nov 2026 12:04:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: akpm@linux-foundation.org, hch@lst.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX2
 code" failed to apply to 6.18-stable tree
Message-ID: <20261107200406.GF6049@quark>
References: <20261107050910-failed-6.18-24f1241cdb05@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261107050910-failed-6.18-24f1241cdb05@kernel.org>

On Sat, Nov 07, 2026 at 05:09:10AM -0500, Sasha Levin wrote:
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 24f1241cdb056fd630e6710a916e0f7c8c910a70
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050910-failed-6.18-24f1241cdb05@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
> 
> Thanks,
> Sasha

Actually a clean cherry-pick, and failed to Cc the raid mailing list.

- Eric
