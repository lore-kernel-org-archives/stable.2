Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033518;
	b=cNXPpnTKRDKj5mKUgTFX6ANBfyq/3fkV8Aq/vFT0+ppqitNkiS08AJ/QKyBBKtFhcQRJ
	 mBOZQBMMCyrplW/OCooPMYtzKEyBkyZ7ekjpY9KhDU5ZkWDDb+G90fCNbMCiSa7k71Sxn
	 /zTEH+GwFD0td3r9dUPw+h+NuQL2OBPRMP3F4hubefd99lvjrS5JEHpBlOVev2xEBf3ES
	 T9EPXQ5PIWrSFyLwT10vewzJTgPxXEf5p1mYigqnF21PPFxeT0ISqIDZmFZ/N8z1auQhF
	 5PNidzDJh9e61eovfejbJfGUw3bbPfvRDCy906upXqxaMBzJKIfEorrQBYCJC4JsX3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
	b=dhWAMIu52TwtrtEG9QIMz3hLgHSlox6VBNTXFljtmAk3HYRFVwcUjqFuguZ46VilsIaE
	 V/ZDlMEzWsW4PltMNAFXFfWja9u7TG93Q/0YvtU661A4EjEZp816V5QFn8bXLc6eCThOx
	 4az0lvG8+BQCD2mF365/ph0Q20jRBe3YZ5N4A6hIyTnKScLcGaSvLPHKiquxjkAZSYhKn
	 fZ4Yig+EyMskAvheSa3gP3960nuoHtW3KtzDK8z2fGW5DIn+Dihtq+rGWko/MyfTAEUee
	 Cxkj4ssstP4sFDGBgLkfYpXNPfD1Cl3f4/iyjvd6kiPjYS+TDz4nMvpSwcgqlR+/q2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uMdD4p6K;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27223606A323
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27223606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uMdD4p6K
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so10711905e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793033516; x=1793638316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=uMdD4p6KVakawh179kk8FHBLF5CXO9wel4SSzout3Cv109M7RXUmUmrC9sJPIgWsSH
         9ABB0JV8Z5NUOTGY7GHDP30lVe2PF06Z5Rb3sGZu9AHhb2etfX/cHvQCyiGlPRRn3Cbe
         CFLeOIxpliD0sRukb/bWQTt0J7k1R+JKXgZVJ1KMgCeuSSmAA57l+zaNLFl6HnQ/Ahaw
         zQi33bNvGhiw52l+kM3vvg4nLkAUFO3pt8PlK45P8ZDXb1WCt8rTiBonnjcILrrKElFt
         fjlgVO/cXdwsEDjIa5uw8AyiN4qBUQXEww/1M11No4eGietgwgSL41okjBF4DwT+0EjC
         VbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033516; x=1793638316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=z54+JzQ9kk3SpBHGInGu4F8WDdLjYyPM7yX2yYq1OQkawKcDCsWRVDMJA+vdr9tnvj
         iGqIqcqP8KCsg6qTYwBnyxpak6Lhp49cTx+IdO4YdmUZpC6WG0d+ZMZyffvh9f99XkEe
         Zztw0QpxjHr/C7z3t5zcqxo6ywvr15dwmBD8uAd6pMNGZyGpbChltEvh4Pj60cWT0dri
         6TxY72Srz74J89IlCOgl8LtyRqdeXatQvBxvab+uTcTvmGBpVfZj1HTolF/oLINDpgfg
         PQr4WUu24oNkql7oS6wv2soLpTifdNPCsfatlwyjC0L0nI2xpc/XksPzrtLQLurA7/h6
         o6Fg==
X-Forwarded-Encrypted: i=1; AKwUvBxKMTUJLBDdmw2zWY7YzWVoerOv8K1oiS3k/hCjCoVcHqf6Y6cTR5rUaZXf3g7KyMArt1qL7x8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoyAi7txAM6cshV+s5NNZc+NxIt/Tlegm2cmhxTNquA4dqsSgT
	BdQt88orH7eMW5Bzi9eO+1HWRp6LfL2Zv8BrfunfcRpACZuJDYoJ3UUpQQaVZns3bg==
X-Gm-Gg: AYBFou3rM8za9t7oERdbwvZSP2kOEX4xRowjnOQmxwKbhdXrxf8XRVeJ1ow8hVIGtrL
	CuEMn7zLF3/8na6BrpO9w4fYsvcj8Yl3Ubc7dS0cenR/TqbPyBCMg3ngFB4AnQpoRy4TXscYS0s
	8hCjSBESrLJebJWnSf3dBa/kTitT420qn34CG7C+feAaDQrdGpct1OFEq97JMNgG6LlCQlOpYl4
	g09CVtom0CjRgboieZLbEgyESzDfObfNkwbFFAElsEzelYv0KTDGmmbjnXYoJKwlYEZRsGteFLE
	Dmg/wtxTxWby+MvvvteSQKMcD2QhYF0zsKjWA3n6C/6AlhEjdn7sL9WLSh9LtrfiRpXby4kskT8
	mY4C+hwRNdRzlaa7Si5evluUiTMDlG5TelSE/SMRYxzAslbuBz8Rnk2Ussw597bxBcScWx1LjSC
	IeYUgDAYN47STYVDxFEF+JpyKgxBx9sSoJOYAUWx04Y8mN//cO1V4+apSw67/aozhmnt4vXU3/P
	UpOnfrZRkPZnOkToHtlu4+qKnaly05QGyayrc+yoeZ06aaePO8/c9Mcqj/lnokQiEhZoSoSOQC9
	vhjtr2Y80dqFljsC5NBDceMU
X-Received: by 2002:a05:600c:46c5:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4a35acba20dmr143926245e9.35.1793033515974;
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a293sm204540985e9.12.2026.10.26.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:51:52 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <at-FKOk_-OrKTP8H@google.com>
References: <20261023145459.47516-1-amachhiw@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023145459.47516-1-amachhiw@linux.ibm.com>

On Fri, Oct 23, 2026 at 08:24:59PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> period from early_trace_init() through smp_init().  defer_init() leaves
> only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> up-front, and on kernels with large static binary footprints (debug
> configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this pool.
> 
> si_mem_available() therefore returns a false negative (often 0-1 pages)
> across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> 
> This failure is false: the buddy allocator is designed to replenish
> ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> short-circuits this on-demand growth entirely.
> 
> deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> completes (it spawns per-node kthreads and blocks until done), which happens
> inside kernel_init_freeable() — before system_state is set to
> SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> and si_mem_available() is accurate.
> 
> Use IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) to set i = LONG_MAX during
> this window, unconditionally bypassing the threshold check.  On kernels
> without deferred init IS_ENABLED() compiles the branch away and the original
> check is preserved unchanged.

Commit messages are not LLMs' strong suit.

Otherwise.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes since v3:
>  - Replace #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT / #else / #endif with
>    IS_ENABLED() + i = LONG_MAX to avoid duplicating the threshold check.
>    (Vincent Donnefort)
>  - Trim the in-code comment to one sentence. (Vincent Donnefort)
> 
> Changes since v2:
>  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
>    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> 
> Changes since v1:
>  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
>    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
>    completes, so the false negative window spans both SYSTEM_BOOTING and
>    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
>    boundary.  (Sashiko, Vincent Donnefort)
>  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
>    check unchanged on non-deferred kernels. (Vincent Donnefort)
>  - Drop Tested-by: guard condition changed, requesting fresh test.
> 
>  kernel/trace/ring_buffer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..09c02e838c4d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,8 +2463,16 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
> +		 * will reflect the actual available memory only after
> +		 * SYSTEM_FREEING_INITMEM.
>  		 */
>  		i = si_mem_available();
> +		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> +		    system_state < SYSTEM_FREEING_INITMEM)
> +			i = LONG_MAX;
> +
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
>  
> 
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> -- 
> 2.54.0 (Apple Git-157)
> 
