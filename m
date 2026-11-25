Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566566;
	b=H4DTwKjZh0fu2BkA20iT7q9ORt41OaOEUo7PW2bkIP72hVgeDDWDSOQsdEQUSSkERvmO
	 pACwpQXgHeWwQ5qx7OFFVevj5rbBSKmG4BMnZIy+K7TkQkJLGCyxOQmilPgIcvBuQ7BjC
	 FQzf8PqHxedz+nXwTR73HL8jfcuIDBaXCfrZ59GWAf6yW7Xmo1lVu3mdEfm2JCTi/CprB
	 zsWU3kYOtizeQhnSZXIzO5i7Jyg66HqTrRI0mPn7eGkmzhVylTcS11LqZA3ThAoKyvvob
	 AFVisLGTGfB63HJaMAPEtx85Kzcz4ed4VZi2zey1ICkGwO6+yqnDsQhtljyjSM/nkiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566566;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EFGoYii1SC1+bbZRrgGUgBUua7WO9ouNbjRGTkCeEYI=;
	b=2Ay0KAaOpDmAKmS/KRiOFTcb0jKC1f/kGPw5iIkWD0zjX8wGhqtpd4Rf0iqqMN18PLk1
	 c7rIj25xl/bhyUJoHa5U9ZeZa2v5/HtzYgUs1+ye2P3c5Wc88mCb99Al4XvL7sLi8i32J
	 5Xi2eKja07waLhAuSGzn9+Kh79yKCJtU2cXfOvFXIlEcdGTgSUhSLra7KmFe8u/BiYvR5
	 PnYSHEmAm+w5tK6jpNTODTBqhduoUpW1L/qz7WlE8EYLacCjMm4TMI86k6rWwrrRjs7G4
	 BswRP2k/P/oLqPauKJuGiLakZxo+/dJmq/t4XB7ex2x5OEfdAL3KKmbOwe3kQ5BwriA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVtkqYVE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA872606A31E;
	Wed, 25 Nov 2026 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVtkqYVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141A81F000CF;
	Wed, 25 Nov 2026 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795566566;
	bh=EFGoYii1SC1+bbZRrgGUgBUua7WO9ouNbjRGTkCeEYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UVtkqYVEf6NtA5gxi3S0rdQNpRRBSmEaLl1BtoFmgWy4CWWvC5eRnx1jKQOO99qVj
	 +MdqYunFW4TbGBGy7Z9umkmIjR8xsLget/7k1c3HsJdCTZLaO1mr6nRRiQOP0wZh6L
	 Bj6Pav125NsImzsgaZsLLwbPr7zZMCQUuw2i7aZaY4p5w6Htd9gkuvdTs5rqYA84eV
	 lCdbDCqe5Bx3dZbr+C6WamIXfK1zVMa+KwS50lqRDGZu/HS0ViOtFNG0SDFO7W8Mgf
	 Qio+iR8T4ev15tk648F4G7wSQm7H8/ekS6kGCf97nko82Snv9s4ssvQNrTspCyv/7A
	 Qsw4lj/7q26VQ==
Date: Tue, 24 Nov 2026 14:29:25 -1000
Message-ID: <2efd4eef27cbd033bae9e4f5d5ba30bb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] workqueue: fix cancel_work_sync() on ordered workqueues
In-Reply-To: <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com>
References: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com> <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com>
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

Hello, Alice.

On Wed, Nov 18, 2026 at 05:09:51PM +0000, Alice Ryhl wrote:
> +		if (unlikely(pwq->wq->flags & __WQ_ORDERED)) {
> +			struct pool_workqueue *oldest_pwq =
> +				list_first_or_null_rcu(&pwq->wq->pwqs,
> +						       struct pool_workqueue,
> +						       pwqs_node);
> +
> +			if (oldest_pwq)
> +				offq_pool = oldest_pwq->pool;
> +		}

@pwq still has @work queued on it here, so it's linked on wq->pwqs and the
list can't be empty. Maybe drop the NULL check? e.g.

  if (unlikely(pwq->wq->flags & __WQ_ORDERED))
  	offq_pool = list_entry_rcu(pwq->wq->pwqs.next, struct pool_workqueue,
  				   pwqs_node)->pool;

Thanks.

--
tejun
