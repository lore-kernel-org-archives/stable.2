Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512802;
	b=ge1tpzti+JyCDgY3SOWJD9Y7kEKIgMl3xxZlwj6LCX8o8ZhnxjADQdLe2irOaXdHAZbt
	 oaTu/8Mwa2BqmjxoTYtNr0bd6Q5qWSKiWQX/BpRW4Ysss/Y7qZVcZVq4dvZLrOhzqe8YB
	 nT8Ft1uqC6OQ3T6GrMg5i48ZmXqtNCzOLCMjVF9M9PStkEb2E4e9qPZ9awkPlnrhQuljh
	 QaT9OdzFUxPnmOrUeO7No4hZQ2aOyIzW0PEQ555u7Sh478YJk38/7gCRa2R7SgGY8H8IP
	 7iZZ6HxzS0ff6d6bIMuclIXg7Wakl81w31qrVi4/e0eX/B9beZgouH1qAjR7AXzalyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512802;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+9Uysq/mCotcK4cVqe4SE28D+xwBYIuoWTUDfUIopk4=;
	b=X97UoNyT1c9OINoi5rhGRBCZBBOpuhFu+x9w0/4/SCymEc+fmca1JEdMrUZocDvMI81e
	 iHqjxWqGl9P8DmL3gIEN2uSAjNP7dvUAWV5ROwkqwVa0/VYQNNID0y3jFgaXB5AdyL0hQ
	 6CrTfl9tdK7nuFqlMKvoCHIbW/xiaJ10pSMBlE6tV7NGjyUm3AZpjeU6cmzAG03fanJrP
	 aPbJcWdzmYblVuuuvrzNfXKgbzjsTF/ADc3ZOItEER+Im/xovFbuf87otlUgb52WtN47A
	 5s/HQKRcMLu2TNFHK2L/mSRzQqVKH/Fi8eJgnXxqUR49lcnUm+n2biP0m4Wm7oI9SOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xjmm5CM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59117606A32D;
	Tue, 24 Nov 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xjmm5CM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FDC1F000C0;
	Tue, 24 Nov 2026 09:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512801;
	bh=+9Uysq/mCotcK4cVqe4SE28D+xwBYIuoWTUDfUIopk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xjmm5CM1kfF7V02HVtT4oCwtOJPH49nNm2tA2ktDhwJXYBZjyL6fS5SqZrNEXI1Uz
	 ivM9VNMzGFh2xzdwRvl0f9ddocuGcDMLqpcD/bi/AFDOlXKD0EkTg6NXVyI0sRIJP9
	 AULjbB715ndUw8a4kemAX1wl9PK9UhC76GXudieAPTIERxPiuN7EUVzZyR9f8cA9ek
	 Syz4igaBrE7nMLRACT4exq+loAaJ46t4m01Di2NyQAFS+CJXU2CsvTLxwtNVJ/ZUan
	 E5Vpbzn5JoqsrJy6GfCYfPviA+mm6CkS000UNW66qH9o0pZ55RVOFhZ8F3HxLqpDnh
	 IB0O/UNjjJdGA==
Message-ID: <a2242fd8-5fed-458d-9723-e57a4d9015d6@kernel.org>
Date: Tue, 24 Nov 2026 10:33:16 +0100
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
Subject: Re: [PATCH v2 -resend] drm/qxl: fix use-after-free and NULL pointer
 deref
To: airlied@redhat.com
Cc: Gemini <gemini@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <d9930eabe544a4bec5d55113ccd6b1bcd2998bd6.1793704291.git.jirislaby@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <d9930eabe544a4bec5d55113ccd6b1bcd2998bd6.1793704291.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Can someone pick this up?

Thanks.

On 03. 11. 26, 12:11, Jiri Slaby (SUSE) wrote:
> When allocating a `qxl_release` structure with `kmalloc()`, the underlying
> memory contained uninitialized garbage. Specifically, `release->base.flags`
> (part of the embedded `dma_fence`) was not cleared.
> 
> This garbage in `base.flags` caused helper functions such as
> `dma_fence_was_initialized()` to return true even for releases where the
> fence was never actually initialized (e.g. via `dma_fence_init()`).
> 
> Consequently, during release cleanup in `qxl_release_free()`, the driver
> attempted to put/free an uninitialized `dma_fence`, leading to refcount
> underflows (`refcount_t: underflow; use-after-free`) and subsequent NULL
> pointer dereferences in `dma_fence_signal_timestamp_locked()`.
> 
> Fix this by switching from `kmalloc()` to `kzalloc_obj()` in
> `qxl_release_alloc()`, ensuring all fields (including embedded fence
> flags) are properly zero-initialized upon allocation, and remove
> redundant explicit zero-initializations.
> 
> The dumps in question:
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#0: kworker/0:0/1534
>   Modules linked in: af_packet nft_fib_inet ...
>   CPU: 0 UID: 0 PID: 1534 Comm: kworker/0:0 Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  b041a6527f6e58424f4cd3de0fade8d408b378fd
>   ...
>   RIP: 0010:refcount_warn_saturate+0x59/0x90
>   ...
>   Call Trace:
>    <TASK>
>    qxl_release_free+0xee/0xf0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
>    qxl_garbage_collect+0xd1/0x1b0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
>    process_one_work+0x19e/0x3a0
>   ...
> 
> And then of course:
>   BUG: kernel NULL pointer dereference, address: 0000000000000028
>   ...
>   RIP: 0010:dma_fence_signal_timestamp_locked+0x32/0x120
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Assisted-by: Gemini <gemini@google.com> # only commit log
> Fixes: 2bcbc706dfa0 ("dma-buf: add dma_fence_was_initialized function v2")
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271081
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: stable@vger.kernel.org
> ---
> Cc: virtualization@lists.linux.dev
> Cc: spice-devel@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> 
> [v2] use kzalloc_obj() instead of bare kzalloc()
> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 06979d0e8a9f..07dc6eafe6f7 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -89,17 +89,13 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
>   {
>   	struct qxl_release *release;
>   	int handle;
> -	size_t size = sizeof(*release);
>   
> -	release = kmalloc(size, GFP_KERNEL);
> +	release = kzalloc_obj(*release);
>   	if (!release) {
>   		DRM_ERROR("Out of memory\n");
>   		return -ENOMEM;
>   	}
> -	release->base.ops = NULL;
>   	release->type = type;
> -	release->release_offset = 0;
> -	release->surface_release_id = 0;
>   	INIT_LIST_HEAD(&release->bos);
>   
>   	idr_preload(GFP_KERNEL);


-- 
js
suse labs
