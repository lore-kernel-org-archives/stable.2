Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC440EBAE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235179; cv=none; b=QNYou38tXUsgoXw2R3Rp5Bt/uxdkqVQLkspe5aFTDoMRN+qRXPpEn7wc5zRhPwGyVrxZZHiq59CZBaAIGFbw3CiyPi7WEzI/dig/cYHPKYaUZH1kdUM5qqQZdEw3suNEjtf0v6oLJ5pAwXo2UTa4wRh6nkv9GH4I5ujUrMqXWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235179; c=relaxed/simple;
	bh=qpSpYBhIpJtMXaX73sqUbb/dClW7iZn/LKMcEnuzdf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ7ejkZZWOzI6FpPSpxmYm6mqa15+4ToJ/1I6wM9xEos3TApRZXEbzNO+9tEBpvxH85yLDGZGXmtoshDdQU/cgjwGk1r0INUK1CDIK4LWzRUpqr28Uj+hJNajyttRzCN1Fdv7ZvR8B8XH479aIkxsvm750FACjPIGxBy9znvAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=vxiw03eF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="vxiw03eF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954aff6088so32327555e9.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1785235176; x=1785839976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hh9GGg57kuY2hD4zZm36wFzr1EZULMRj8TJL33H+8H4=;
        b=vxiw03eFtILF+s2UA+7KBEoxGjJN0LQk7pqq+NYOJl82o/1bQP9NtOM9v4EE3GqyZ6
         GjhURE4JmrA6p8oKk7lW/4udmtMcCTgFCBiFftpfVvx++lR7nd7QTiF9LQodSsOnUHwg
         Rs54acEcdf1s6YXcvsyP0tZ9qkjscoRlEycODA6GuYc3mBWKEHq0FZ01qRFcKvXLbzmq
         mKlM5Hlw1/dGoR01dphWanPmL+EhrvGZE2pnsl9qRiJ9FmTLq6YkyK2LnmRWG162ym7H
         xpUwkXH8KRgT+uHUwnTvS1lJzAraiXdEjJiPViIwxnBSZNItGjHGKrhLtKBg9pBr4BOY
         dM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235176; x=1785839976;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hh9GGg57kuY2hD4zZm36wFzr1EZULMRj8TJL33H+8H4=;
        b=ZXUkcupvpXPfWvh7zL77/2QtSiDw6gFDSwBtEqjWSKY816VEoDEHcWlC17+5n4bRKW
         Wk4nT2fwXk6bdnHxOFXCJl5QW/bDSDvNNVYJjF+ePprIdzL/0vXzI/ffi0HN6GnnPBO3
         oUSihCYexlfpvjB6X3brE5SFV06+qDW87UpeSHWK4TQKlB0zz4Tc5HNCVG+u4zcSe43z
         QiKRLmP1pBoygrahaC7SLAsRcGefNJIs4UM5sz30dWh4/l9dxaFSnkJE24H/S6ePcNfq
         1kVDSIf+3klGwBJza4e5MgBypXGyw0JNmaYrpTvvCEsuH8F4NI++z5dji3kHeiWd2u2A
         akMw==
X-Forwarded-Encrypted: i=1; AHgh+RqypX1P+Ztjy+G+crhYvI6b8XoHIveWLbW13tdbivXZLdlrBuV7Z2ZRWnX31f1OrckKKqt4D6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKok6sUphsAQDnr1AXdoSCawQJrvrYARmKj3oUKxsjwpUcUK0
	98xG+qQZzxDBULICD4UKP+KYuz36K5nBNd8AkM06/4KKwEW44Jwbsn+FGTnm+ZCzjeg=
X-Gm-Gg: AR+sD10pin6K5R/Pn3/DMnRVUvmoEdK09NF+iUzhUMlnTFedjGuBhcJUjb9rEMOgzM8
	nlN6qIpEeVZSayeivM/Eet38WwR7bF4hWk0QqhPf6C+2ZtdAfctF4nHI3MSqAXcTmVSyW4QZOC5
	WZdEDClMuLejTA5NS37B9ZifanrBgdqrFTKd8gBls+TkLb5Wv6qnTyQ/H6yynScW7Kfs4u2K4Uu
	GAW5/lD4CvhN3Lx8VDi9SNO5EO2OlUBLOFzHUiq9wQVJeDUy8aDsgoxA2sIhEzqytnrWDp4qK6R
	zu9MdO2Q04d7Pour3U0n0hl3q9VRM/4GMrxGeRXZnhv/dyJEnWifFLhOn+5p7oOsYEQpwfzrNeJ
	e6RXUTc+vukXjrgxfO5jJ2le2qTvnlWbqtJ4KnPfaBj5aqbMxhWqzfZ1KwGXq4+KSg+mc7MGwTw
	==
X-Received: by 2002:a05:600c:8b74:b0:495:4b42:8677 with SMTP id 5b1f17b1804b1-496c657651cmr19071605e9.18.1785235175708;
        Tue, 28 Jul 2026 03:39:35 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26a0::3d9:b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfd1a60sm293299405e9.2.2026.07.28.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:39:34 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:39:33 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <amiGJWJ-tzUMYizu@matt-Precision-5490>
References: <20260713101245.3207634-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713101245.3207634-1-matt@readmodwrite.com>

On Mon, Jul 13, 2026 at 11:12:45AM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> call_rcu_tasks_generic() can be invoked with IRQs disabled, and on
> older kernels this exposed an ABBA deadlock against the scheduler
> runqueue lock via sched_ext's task-storage teardown path:
> 
>         CPU 0                           CPU 1
>         -----                           -----
> sched_ext_free()
>   task_rq_lock()
>     raw_spin_lock(rq->lock)
>                                       rcu_tasks_one_gp()
>                                         raw_spin_lock(cbs_gbl_lock)
>   scx_exit_task()
>     bpf_task_storage_delete()
>       call_rcu_tasks_generic()
>         raw_spin_lock(cbs_gbl_lock)
>           <blocks>
>                                         _printk()
>                                           console_unlock()
>                                             try_to_wake_up()
>                                               raw_spin_lock(rq->lock)
>                                                 <blocks>

Hey Paul, it looks like this didn't get picked up and now won't apply
cleanly to your tree. Should I submit a v2?

Thanks,
Matt
