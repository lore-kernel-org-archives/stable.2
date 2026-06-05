Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3323093B5
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696087; cv=none; b=XdEW9o027x3qxvGgLfEecqSq9vyMeY2DYy2AkruG+7W5tujzgBZ4k+rFc7wLJxm57peQfZdGfZQsPuldpETwm/c7rB58mviDWOy+y+LzBXa+3cBgKmwBHf0JwnswN+7E9a2BGi10Tb5I7mKuPTvSOi2patjDFfiy0d0sN929bZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696087; c=relaxed/simple;
	bh=LtptUCI3JffnqNg7rNgmpJ0BvPCy+TFpdB9SgPV4QsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=red+M5Y9vUnTElDaYzN6dsevaqxCNxqY9YdAY9pzP3++CpbRUfekD/eZZiNCwxX2ab/dszBv6D4DwPD5ALkPfG95zNAAZZ5xtmlqBjTD7iyVdr5VQdmBbMOPlvZPrX8FEUtPOCzUHfMwARO7OEmQrVtd3QsHVkA/X2ZyraGeSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=EJ9inlkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGppaJMm; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="EJ9inlkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGppaJMm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 920E47A0135;
	Fri,  5 Jun 2026 17:48:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 17:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780696084;
	 x=1780782484; bh=dcWtqG79KmB6FQQsDi6CZen7XJy9Ri+1OdOnaAA+CW0=; b=
	EJ9inlkdZxTWgGHZ6UDls7BrQfZc0V7jQu0E2tLkwa8Nm54DEwuRX7eFMrxTP57h
	zhhDOGTyO5Rj3v4dKemqImymJ4xub+F/mPdg52/vJJlV2Z2DAIO6fe/Qx7Gv0J3/
	PR/foRwHqLkYMlwyO4TyvUKC0Eltf+wrFS+DteYXzqPQM4NygxgvNC/b8RYeOgCo
	+YQ2Pb8QDMJ+dzGkfcZ4ota5ySyAHG4NZIohgWQBu1lfN9Xsa5XFved7n7ETpkXz
	Lihr1OODQA0GD0q7K3bQCyAbtHfJVepyCv7dS1vFQRX2sFBwvIoy7JTJGjzyMF3B
	Qivyz0WEd9Vz+t41Bx/WbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780696084; x=
	1780782484; bh=dcWtqG79KmB6FQQsDi6CZen7XJy9Ri+1OdOnaAA+CW0=; b=H
	GppaJMmgh7CzOy2Oo0FOixBF1T4Q6A7T+Odi/5LWwIbHhYwwYs/Boi/XatQ4Kzlk
	gSIYQuekllfp5QX+H7rA9o8ON8qHe9A+dPrrUz54Q9gU8Ms8q80XIkgfNaRaww0x
	UflUuvMDCjqsdfYuTRTPUaB+nThhYuYiBi2UU0HRNoxL7qZnr5x1TdeJ7SZ2O3Fd
	Jy8me0Yj0FvsfkDGpeo14kTIXiFNhaPDNkyrK5G9My6bLLZa0crI35P94jZU9/b3
	RNFqX0GGJA51FVVVzmbVMyY3IWaPkwQr69PBdkynykC0dxaIu7sDX0hg5gRbsI87
	P6kMTqcRBG9FNXtoxPfiQ==
X-ME-Sender: <xms:FEQjaryAaJ0zs38MJohaMY51iQGba9jZpLY1ZY_NreRwBuCk2AJTVA>
    <xme:FEQjakziGCQPPCic2Dgubvd4YCPulKtQldcwvZiJrYSNzeWDTehYKTL2XMOnIXYSy
    j5luDb3ZnTdr_DvPFikvdi-qwosx_YqZdfkAv86qKkeiyOhsv6x>
X-ME-Received: <xmr:FEQjalZfDnUIEh5ZMfdnLiKbc4ujHOoOsLEaVc7igtRtIdheiw3U7d53YDgfXLuECDqvuoEsmpEBRoD69d7oyzSREF8YBj4H7e_SnigTEqAfY1y3ag>
X-ME-Proxy-Cause: dmFkZTFaxYP9+7VZYcdCdFkZxZxNr37jXOmJRdFW5pi0t0ZkIQMWfwT7M542WIVA6Butd6
    L3LpujbalnFAMSrrsXyLHiJpBZtIbqjpLlXCIhW2nmlWHxGyF1YhLex25wLzGCza8DSjqa
    7OAjOFTqKcjA6w36KXuI/JxtbNoEP2fr5y+bCtdOHK/SAnlPyY19oDf/p3F9BWkjHf7Se9
    9n9E+4aTghnLtunIoWwMPyXg83QnsNNHp4UlSO27a7pthKIrxeAshAP3E6w2nqjZL/Sgk6
    jwYKXe5buxrgu5fSXWry13gOog1OEQ48eZvQch+FUSvm9cRemcIBMNJNXIn/5/XPIC1kbw
    p71ZkBuAmb+APaK16oOqWmaXXYjXXDbt+RTFiVIoreuc6Cz5LtRl3XDdryMHcHJ92EXvQG
    3m8qJ+gH6rsbCWJNqNQTZFJ6kq+OA3fWqTAhuqUQoNrSR5N9/qQ3Z3mrMa7NNYdQ03mFI8
    kFBiev9vKhUnPVDEGAlWyfjzz0vd8D5Ls3jzlAvnzLSDOedpu7fW+NWj1ikQGxuL4VdwIQ
    rFxTswKsRcvSrB0Z8vEmDPv77JacUUN0JRDZwkYjPSRP81hTPs4VugYSR5JwGfV7suP8nR
    rALxZxixqlWzb+Z+h6R+mfDeQtb/69kZAkZnXKGCVeyz50uRA7j2aR4zwe6w
X-ME-Proxy: <xmx:FEQjalU1CjxxbcyRIPU5y4LUZ1ttGjcMZyjMmysSqJhZZ5xxvG2NAA>
    <xmx:FEQjajhb2PJmCnZI4d_7rMejccA1f4r3VC-I9KbQ4LjH5oFzy8ijQw>
    <xmx:FEQjajtoJGcKPbHKTEib5Kec2xr7iJkEiHde4FmUkj9K2YpTOG2f1Q>
    <xmx:FEQjas69TCm_5NEQWyncR9XtLHOY63vJ6qYLMU1u0nGhffHjFkpbRQ>
    <xmx:FEQjaoR7AR7L8I0rWNIi3S5HqmUSHngdVa7yVeHptJ_uvolnqiT7ANOS>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 17:48:03 -0400 (EDT)
Message-ID: <fe64cddb-18cb-4c99-986a-27233e829a87@bsbernd.com>
Date: Fri, 5 Jun 2026 23:48:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fuse: fix data races on ring->ready
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>,
 stable@vger.kernel.org
References: <20260605192708.141921-1-joannelkoong@gmail.com>
 <20260605192708.141921-3-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260605192708.141921-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/26 21:27, Joanne Koong wrote:
> From: Chris Mason <clm@meta.com>
> 
> On weakly-ordered architectures, the store to fiq->ops can be
> reordered past the store to ring->ready, allowing a CPU that sees
> ring->ready == true via fuse_uring_ready() to dispatch requests
> through a stale fiq->ops pointer. Upgrade the store to
> smp_store_release() and the load in fuse_uring_ready() to
> smp_load_acquire() so that the preceding WRITE_ONCE(fiq->ops, ...)
> is visible to any CPU that observes ring->ready == true.
> 
> Additionally, fuse_uring_do_register() publishes ring->ready with
> WRITE_ONCE() but the fast-path check reads it with a plain load.
> This is a marked-vs-unmarked access that KCSAN will flag. Wrap it in
> READ_ONCE() to mark it without adding unnecessary ordering.
> 
> Also wrap the fc->ring load in fuse_uring_ready() in READ_ONCE() to
> prevent the compiler from reloading it between the NULL check and the
> dereference.
> 
> Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Assisted-by: kres (claude-opus-4-7)
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/fuse/dev_uring.c   | 4 ++--
>  fs/fuse/dev_uring_i.h | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index e33847436693..7cd50990b097 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -986,12 +986,12 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>  	fuse_uring_ent_avail(ent, queue);
>  	spin_unlock(&queue->lock);
>  
> -	if (!ring->ready) {
> +	if (!READ_ONCE(ring->ready)) {
>  		bool ready = is_ring_ready(ring, queue->qid);
>  
>  		if (ready) {
>  			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
> -			WRITE_ONCE(ring->ready, true);
> +			smp_store_release(&ring->ready, true);
>  			wake_up_all(&fch->blocked_waitq);
>  		}
>  	}
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 368f4d0790eb..6af604e17b2d 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -167,7 +167,9 @@ static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)
>  
>  static inline bool fuse_uring_ready(struct fuse_chan *fch)
>  {
> -	return fch->ring && fch->ring->ready;
> +	struct fuse_ring *ring = READ_ONCE(fch->ring);
> +
> +	return ring && smp_load_acquire(&ring->ready);
>  }
>  
>  #else /* CONFIG_FUSE_IO_URING */


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
