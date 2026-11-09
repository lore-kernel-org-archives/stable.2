Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229852;
	b=aWFvqAk9ILGJXhWiuKtRQoVpiFld9QciLx/5QHop5pd2cv3CnD3bqewF9eGqvTFimNwe
	 XVTJqfRkLGMmjB51OTCfqCaRt77275hStMij38fy7hHex7j0sprJvJ5IHwimecLz916nX
	 KVjNHVzqUwr7Xtq4Sf+NtVnZkZ5txFH2FEr97e5UfTo7sOdlmi8FrK9b4CZ3BQ7wvdg/q
	 FJUYlQhaCmcUK0C+5M+uFsgHgx7TGEE32BnUmePa7JA9TxI/F4ahVWxoGe5JcVZfX3kL5
	 vnIun/xKYbxMeQ7B1YjfJ09R65xhgM6b5QoNIji/fXh9NQvr++QElrOzKKMWFwl6h/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229852;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=iG7IxATYQFhr9N5nGzI4lRguPVjPcmyj3wacG9KcqpE=;
	b=lAwO+wcOJB792EXih1i8TIs4EKTB78FCh1+QCQN64GUTflNT05zrBiqtdxRz8fybu4O1
	 LMGxaBe0VAi0QnHLc7xbmHUFyuvXSBDb9nPg4bgSMsDsOZEiMnZWFYAzdnYj2K+V04Ikd
	 2tlb3m7Hrryz74WDcVhc3lSDFJllKzvIL4VISDQ/LXsF/Htt2s/54akyosvoyytZ7ODeP
	 9A3yjg6rEkrWLyYyPc5Shnb1eyuv3wJVfcS5QJ+SYSn6kLuA53eWsl31M8Z98ZAqH2uKF
	 ClCnR2AynTW/1G8SPQ8q/7PNg7vuIdAVR7mY8U11qP9srahXwEt+Pdr30t2fekUHkHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=koKTttrZ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC255606EEB7;
	Mon,  9 Nov 2026 13:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC255606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=koKTttrZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iG7IxATYQFhr9N5nGzI4lRguPVjPcmyj3wacG9KcqpE=; b=koKTttrZvvSN3b8LyyQHVBrfuA
	YS3wnhxid4Iov5yOiasfDDJBRATSzYA/rI8+LkalUEGEwzsBkj2quilf2blu4Ir++Tah8tmcm4r9I
	swPG4qwfueaV77YWRQWF2aeE7+lxWBl0WP89DFpyCKc/p+TaZckwE9aWti5QW/faZQr9A2od/kpBl
	AN03Pq0UUg69n/C6LSJ764yrddB9zEm/WMDAmmNgYRMh83nTCBBCnUHMPDEjhjeB+VneQFTkchaUr
	l4LyUcoU+mT+8GrmF42CSQ6KAj7YK0h6TC6upNYCTYJ2Ppwy7LOQgm9+ihewDSSYOTDj4kvcFpNwr
	FtYk3C8Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQP8z-00BdPm-0q;
	Mon, 09 Nov 2026 13:10:41 +0000
Date: Mon, 9 Nov 2026 05:10:37 -0800
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <avHFeq9GjAVN_OnF@gmail.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
 <20261105155729.0f9c7e4d@gandalf.local.home>
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
In-Reply-To: <20261105155729.0f9c7e4d@gandalf.local.home>
X-Debian-User: leitao

Hello Steven,

On Thu, Nov 05, 2026 at 03:57:29PM -0500, Steven Rostedt wrote:
> Can you try this?
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c64e001c3fc0..f0bb2d23d818 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3721,6 +3721,14 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
>  		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
>  		local_inc(&cpu_buffer->pages_lost);
>  
> +		/*
> +		 * To prevent a stale head_page from being between
> +		 * the UPDATE and new HEAD pages, set it here to have
> +		 * the reader check always find the update before
> +		 * finding the HEAD page.
> +		 */
> +		cpu_buffer->head_page = next_page;
> +
>  		if (cpu_buffer->ring_meta)
>  			rb_update_meta_head(cpu_buffer, next_page);
>  		/*
> 
> We may need to add memory barriers here, but for now, I think this could
> fix it. As it should prevent the search from ever starting in between the
> two heads.

This seems to be racy as well. Sashiko found the race, and it can be
reproduced by adding some delays in the code.

Thanks for looking at it,
--breno
