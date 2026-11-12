Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484296;
	b=dkVUuFnlYU6nF3JEEM064Pq01gAATPBNqfpQJDUbILsnKoaAb00327M3zQymxKqeB/tt
	 fAprIH/MVsLyfbDLw/N0M74Vd2p/38EN9Diu/MruRjkc5QHpm9bwbd9UcLqapXsp/8pkU
	 KhSgvk4cA1uyFNin/Z69OoZvKA5uDg1G7ndt6EcHnqiIvts5e8+vuDVS9z+HjF16yrUAP
	 sXQCxABLsu1NpCxur/AchV0CXKXjyvyqZri9THxuj7Uue5ApV3dKXKeAhRUlxD7JiYSdp
	 t4l3jACpu1jCsJmZsjX32+EwY/1Z7YQm1F6UI0+rHailS+DUcN0ybEygpIkkSKr/YKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=L+9OvAGkA5co8PTaVpf/WHREVpFJgAvJ9utwws7KxK0=;
	b=2ouUV5Gd9l3gDAM5cir6rUvJUZ/Ih5O64nbbIpQbBt3FZ/ZqftttdguHNXhknb/kvOQV
	 psmuhgfjC522W3Lb5P4IZibs0Lh6M8tTA5XzAzSXTZwvAzDlGuDKSsdpEcjDIRS5uSyi3
	 UO8okGV3IYd6FRtCuCTJ+OvNXk3OMviWeXGGyTSiI8lbBzihKH4zLddd+pDuAYVdJYAHI
	 eLGKeqaTSQj1ZXK5cxgorNUt+Nx9sd0tN2lCceX+R1/RhkbWHwxGkVpyWjGSpSELKE3hO
	 k3pwMBnX6qYUJJYZMzCwphk9aPT1auh6Feun0AUiMe6u/cvqjW5pBvz46neTCAAOTeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D7pI2T9a;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4A606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D4A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D7pI2T9a
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so7313675e9.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794484295; x=1795089095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L+9OvAGkA5co8PTaVpf/WHREVpFJgAvJ9utwws7KxK0=;
        b=D7pI2T9aUlHUPB3rv6sO+Ov1nRrCVtdz1sKmcQ207kMrfnwO5xoLhaLFuNbGbc5clW
         clwEAKnGyjMJ2LLwb2wh1aM4aMxl+rixQrXW3MY1icYmfNkt/ZzMeI9ao7dxVIxRO4He
         8jZnfMnsZIvSeGrZPU9MRqkyZB+W65uY7ohwyGDLOVxP6CDhoUpMjEs3F082Pgy/GG9j
         FHtKk3iaMvmV18s+orFsSOOfahlQcJ1lss+O8QKnEJ3P+4mJsi0GrbznkXGj7jy1KX4c
         uDCuazl+Hz/TkjbQH4xBiEveaqiAKiFvr3OELpZjTq1APfpIx9l2vrbyPXv4LFYobk1b
         do0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484295; x=1795089095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+9OvAGkA5co8PTaVpf/WHREVpFJgAvJ9utwws7KxK0=;
        b=iPQwJDIfq0pwPNV0JVeG83mGAUdZm+eHZXZub7mvT8ElYyma6cqwhW4Z+6qgRAlGe0
         Jr4YaZbfN34iarsdg6ypwy1jLNmcONyiJ1bayxigAtESZXaWHfN7dNwNwN4sqQGzLQyQ
         S3aYEc7eSq5f0oQlvyK79pz/uMnpBZrhL0CaKoGExHVDS4GeNZgJqroaboC1imeh6MXn
         hIH69ulQahPjhkEENTDgJuYJC1lbT3kb/zFGi62Kk8Fs9L/mgw1Gp8pJTZ4zORuXPNqK
         iq3YmPCibXfi1u5GOVNcIkmMh2hFzfnk9kn9CmJFB0VbRmjcesgQsefxD+c8wZVFSqiS
         BN3g==
X-Forwarded-Encrypted: i=1; AL+hErFMmGabFkUVQ/rZMxSl8WVyD9ULRW5Ax7ZzbcmSzWX5B0cySJpXeI/kiYbQ463VAUIvNUdFmj8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zjsgg2/2ru8D0sdSeA7IZGivsxiKSvKF/E+b10OJv5ycUyfHf
	008wihGJAtkAnemqw0vVqBZYFbwbvz1T20bWW1p8TVbA9IVA7o8SkzThpQ2sCdbORA==
X-Gm-Gg: AYBFou3DMa77mJZYU9lZwi7FKcoNOsXXVtP55UK5hbwYnMdzC2CgPNggCQ19nA/TUgn
	kkVMXDKpPrCYU3cdHPLy4RwMtlqRmNpcPZqSYt272ZH1hG/SHj4zgZSjK1hYkQewFs9d7gjnySj
	vGbRoIjFxeRNqS8/9L/IKBCHwiJK9oNzUfkad2OCxntaQkrPcedvKrnAUmgI08EOXPvpPHL3Ju5
	HknXpAGIzHjgy5WgrA2+9TReEATKY/SLfWfMDhGb9VHeaQeuM5mGwPQIxIjH6X/4PJ/AcD/daMG
	GSCfB/OYkKQsEJRYBaf3pODvnnP8vviyzHQ/T9dq1MLtYaRqirItikvmdy091N8gv6bVgu8vrgS
	Z1KuHKRTIqu48LEiXHGyNkR44wHHIa0bG4fj2Hhy5XvAhBvzin7149NEiYV33uF3s29wwyLm48H
	Bdn2wzebPVQPQ9xnvmAkGjEsYckXeABC0hZxa4Qg2YawscnZF30uDctDDn1bFexJWifnxEGnweO
	IaNa9u0cLBHZc7ehN1/g66XH1DfLWovtRFoTKVhIOLqF5+UFqoCyKhsOqHeMF8N7zzc1419TjRn
	mThmuNbCfcvOielFPwR3LzI6jFiI0xRGSUjUA6Fz5AehOPyvC0b0M2GYgpAXtj/pUQ==
X-Received: by 2002:a05:600c:a31c:b0:4bb:53e4:a7c5 with SMTP id 5b1f17b1804b1-4bb53e4a861mr3753135e9.14.1794484294459;
        Thu, 12 Nov 2026 03:51:34 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251c26sm63991125e9.1.2026.11.12.03.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:51:31 -0800 (PST)
Date: Thu, 12 Nov 2026 11:51:28 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <avWoQGaDrrY9z9Cr@google.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
 <20261105155729.0f9c7e4d@gandalf.local.home>
 <avGQnBjyUMwunknT@google.com>
 <20261110025202.78c8c03a@fedora>
 <avRuXVxVrp-Kjiqj@google.com>
 <20261112061423.59e02261@fedora>
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
In-Reply-To: <20261112061423.59e02261@fedora>

On Thu, Nov 12, 2026 at 06:14:23AM -0500, Steven Rostedt wrote:
> On Wed, 11 Nov 2026 13:32:13 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Yes, now I spent more time on it, I believe it makes sense. I looked at what we
> > could do and I'm trying to use a temporary RB_PAGE_HEAD | RB_PAGE_UPDATE. This
> > link flag is then only converted to RB_PAGE_HEAD by the outer writer. I believe
> > this would fix the race entirely... However that means the reader spins as long
> > as the buffer writing is interrupted, which I admit is far from ideal.
> 
> But it is only interrupted by interrupts ;-) which should be fast.
> 
> No different than waiting for a spin lock whose owner got interrupted
> by an interrupt.
> 
> -- Steve

Yes hopefully it shouldn't be too terrible. But, as we disable interrupts on the
CPU doing the read, it's sort of propagating the latency from one CPU to the
other, which I believe wasn't the case so far, since an interrupt could
"release" the reader by setting HEAD.

Perhaps I could propagate a -EAGAIN back to ring_buffer_consume to temporarily
release rb_reader_lock() and try again there? But that would be a bit intrusive
as most of the functions are returning a ring_buffer_event * and not an int.

The attempt is here [1]. Sashiko had something to say but I haven't processed
yet how bad it is.

[1] https://lore.kernel.org/all/20261111160624.1294946-1-vdonnefort@google.com/

-- 
Vincent
