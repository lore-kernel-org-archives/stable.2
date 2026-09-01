Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2662F546D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270623; cv=none; b=DehU+73xbEgikyP27rMsuMcNyFqRGEmThp1Uz/CvydmO7CabLyVpfbrniJ+BkTq4GjTNhv7u0bKUlqHa2tKtxAlYYpLaMJEK0xg68mQTlo3A+D7aDgLgWVMinSNjUtKq3/oHUOI9PQcHvL5MU/4BeNeolzm2kXzv872Xa6yRi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270623; c=relaxed/simple;
	bh=WynuTooh3d2w4bp9yyON0x52RjuGtTuYYXM1KX5OJEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzYRiYRVaeJ0exavkKjsyA8+xXapabJV/5z5zkGW4wShuUCzRmWTjAWoIKAu9Sklky9ZvGW9hz1jeUeaMPR0XWeIMeT0htS0bs1BeWk9KsMbtf+Y7FAMdCq0nHbjsJ2y/ptFeQZ6UwJryOu40A61SxpWDeJPWWHZmli5fVqSOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gg22Jx5Q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gg22Jx5Q"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c207cb16cf5so793667766b.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788270620; x=1788875420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8+SZOE2xWNs6AbBanAPIBFLsvkxmbh30lToZDOa/Pk=;
        b=gg22Jx5Qw01lioC0iaWB8DT6B8dQEafNNz5j4qYEcayCJlyo4TAkRZnuItB6qkWeTM
         uO8TmfOeN9gDYbwXvEXgrNiuXsmI9yE/DCm9o2KXxGJ0crj0WmHy/WXdCwaW+iikD2Bd
         P9OVKmecUTFoQ8qwOYniOhCIaNgKGRkBDdfHtt1lFZs9h6GJ+Acf7GfJGp0obAQK/ffP
         22z4KWM551+UG1e/J/bTnzoYulxOhiR3YmwDJrK0KFej9dZ4tmIDctCw0tH6lf0eo/Is
         MYy/qsueTmttzEQOJskT3SB3Jy1jeSZvV7oXAp6iI4htszKNsbtSWFfcrdkOw1s4GZqc
         jvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270620; x=1788875420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8+SZOE2xWNs6AbBanAPIBFLsvkxmbh30lToZDOa/Pk=;
        b=kAdNJgkzBSyxkTwrtjqUQee7nMkh+aOlgfmirVFX9WgkjhVTB9pAWAlZ6kYXGpOGL6
         PK8CC/dZtecw4lcVFMzvCzRiFbbw3qCztVCiDJ7HUDEpsfy2g7qnwH7v3WwqK38BTfzu
         4DJgy03CQyCvwktWUmwGxJaF7uabwsBrAFLIAWZTxpjvLyUezgN04GGE5KVAB0A4ivQG
         UhWXaAy+/1ZRaaYOBiZo2mUBjxLnMPsluW/SeexD04FaJjQ+E5fKome/9tuTueQ6a0fa
         EtObfxuxSzUI9lrc+UbXhnXCOZ4tAdWA5vuYST4hiyf1o5F2yfhVpTv+LHaHDEwskz1R
         PAfQ==
X-Gm-Message-State: AFuF++mrKpTExMZl8SiznuMeWqzEd5sadCNEegxcyBMrGyBPNaMblaBJ
	wQiqrqHT10h4pyMnM4YdhufmrBn62+eq8FbaUYnzanUM9z4WTiaFg3E/9++DfeIDZg==
X-Gm-Gg: AR+sD11mbHxXrA2yJ/oPkVqpID6BzwsUseQo4icvdX+WwdCn58SweY8Fe9YM2XV0uH3
	pcLDUe2D/EJuKbASpMypTj77diNgjwRofM2CsG81dO5+Y0NvZ8ooO2NzDPCfYFldN1OUqL07x0w
	srqc2Eucuwzdp+kDKv4UOH4PKIrnlCLeKRFvaIiVbBQ/bxXGRIe0Fy62JaVLof97t/8Ijjwbx2h
	QhFudZJc0SgJpNiZy5KbeqCLA2SfDQ8gMCzmpUNi3Q50ZpzX85kTM5KMZHbBGRzKeFwBUiX4ffa
	XYIFYnTwyT4ROggIs/kHdTYTPD1pjQGhTRsOwhFqwoQv/woqTh4C6BSAc6PhhocwXPTcZwNsGGB
	DxeIiWPPU30uq/KYJwfK1I1fzk9jB2ruTuVn8YDFjVcZ8YzEBK3DKC4sPXc06AOT8hmOCeHMtKI
	9sP3BhnJuwLJnrli/zSW4W9PbnoS1QWuQZz/8XNy41/KsXWVgf1r8nNnkWck7+EbbZpR7Q7bsxy
	4bijuypaGjPrsxyjWESYvenSlx2Awjp
X-Received: by 2002:a05:6938:a08e:20b0:c25:62db:772b with SMTP id a640c23a62f3a-c25b3bb8c0emr448253566b.7.1788270619586;
        Tue, 01 Sep 2026 06:50:19 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b1443sm588471166b.41.2026.09.01.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:50:18 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:50:15 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <apbYF8rGD5EKG-oq@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901123444.GA1350131@google.com>

On Tue, Sep 01, 2026 at 01:34:44PM +0100, Lee Jones wrote:
> Dear Stable,
> 
> > Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> > uninitialized memory to userspace due to stale size values.
> > 
> > Modify ring_buffer_alloc_read_page() to let it handle the resizing of
> > a previous buffer_data_read_page if necessary and add a new
> > ring_buffer_read_page_size() which enable ring-buffer users to not use
> > the racy ring_buffer_subbuf_size_get(). This makes the spare_size member
> > of ftrace_buffer_info redundant.
> > 
> > Use those functions in trace_pipe_raw readers and handle in both the
> > case where the subbuf order is modified in the middle of the read.
> > 
> > Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> Not sure if this is the latest version or not?
> 
> I see review comments, but no v6.  Anyway, no matter, it'll do.
> 
> Could we have this applied to Stable please:
> 
> 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")
> 
> -- 
> Lee Jones

Steven hasn't taken all the patches from v5, a few of them were not ready yet.

The latest version is v8 [1]... and I am about to send a v9.

[1] https://lore.kernel.org/all/20260826094528.3738023-1-vdonnefort@google.com/ 

-- 
Vincent
