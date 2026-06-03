Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22555367B90;
	Wed,  3 Jun 2026 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489448; cv=none; b=Q0q7Gaup7TilSdRzkZ7hFp039o3awxe6nBAkEW66/7IOYen7DuJYT/6fFEJoxAQNil7LWAdi8Nfgg632rBygylGSbD5glFgxqaD/rVk4Pqff0yNEcsrYbXqjKljWwTR2RC2IOUEVO2Lpa+VOtQfrFIKUFuAPgAdQxeLMFHmsbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489448; c=relaxed/simple;
	bh=fhgpEIvNeyfQKRYomQWaRlL99rmQ0rQnJNsvUCdcMvc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bMfDADaDsoSAzu2IH02od/eV0UdvO9Oxh+6LnNsyrSiU6POc8ht0ZPN30K1AzykLeYqDY0rL3HLMhx44SCysdm/hzWxECMVcy8HEwXTxCUCWijNprjbK5Z8QYsJfQvBb4yYmAHDyZo5YwX4BntmFPFNpLsaWIg8KzbOdlUm6JD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO8p5ibD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO8p5ibD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346F21F00893;
	Wed,  3 Jun 2026 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780489446;
	bh=hXHl2kqJr/S0Wgp1udof7iRvEicwkY2guHehFWaFpsU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=iO8p5ibDLCSM+5JybV5K1CNtix4uAW5j922nOHf7n2wJpy1egElT+q+oQBH3H7oUu
	 ky1Mwq6Yo2U1xISpBK7R/iS/UvldPaaw0pY7H3jWNBu3KPixstrx7lFStW0klZEQ41
	 nsV9QJNeELkoPruc7vju0nrzMo7es36Cj3QO5OUQr9ZjLWgvSd5OS8VjkK22MOPns6
	 BHlHj4JemmiLSu+lAgFYN8DlsL5+eF4Q+YbRsjWxO5UM9jG7fjxm/LN+0l/HiNzZ59
	 I1WSou96FSYbmK0A9I6v8pnNTGbhTotZcVCQCGp8/2ZxpYpqBTynGRo5pAEJo6yF7v
	 IEWpNAzMFWTsA==
Date: Wed, 3 Jun 2026 14:24:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
    benjamin.tissoires@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in
 wacom_wac_queue_insert
In-Reply-To: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
Message-ID: <7970933s-3os1-595r-54pn-s6s36n019626@xreary.bet>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com> <20260528175945.2987781-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 29 May 2026, Jinmo Yang wrote:

> wacom_wac_queue_insert() calls kfifo_skip() in a loop when the kfifo
> doesn't have enough space for the incoming report. If the kfifo is
> empty, kfifo_skip() reads stale data left in the kmalloc'd buffer
> via __kfifo_peek_n() and interprets it as a record length, advancing
> fifo->out by that garbage value. This corrupts the internal kfifo
> state, causing kfifo_unused() to return a value much larger than the
> actual buffer size, which bypasses __kfifo_in_r()'s guard:
> 
>   if (len + recsize > kfifo_unused(fifo))
>       return 0;
> 
> kfifo_copy_in() then performs an out-of-bounds memcpy, writing up to
> 3842 bytes past the 256-byte buffer.
> 
> Add a !kfifo_is_empty() condition to the while loop so kfifo_skip()
> is never called on an empty fifo, and check the return value of
> kfifo_in() to reject reports that are too large for the fifo.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

