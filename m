Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2935F17D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988427; cv=none; b=acnRbwLk5HJ75q0sVlSuHlL/m5WD2RXG7EDVALeFT4wMP744Qt1RlcTEiPQc+UmVD5AjRET4yhtfLtgbqvYB2HwC4nohoGN5eQI9h1gBJ8qJWwMdYpT62+urBSLxmZfS3vAOq9HVHnDbnGdC1FlgBfZ3NLC+sjLnQpf36+4pqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988427; c=relaxed/simple;
	bh=dU/JhXcw9C+3bxVyhCk433RwAWlu/+DSj3wRiplg67w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGNZRUbOoF63NOIgKBw6lOZ8I2R8FmNVZcOiyze5reD4gCWlASbaBH9k7paMkfUM5Y6liPAamPVh1qMbu+/dcwIIiP4WgqA7TCXl1egbOK32DKiHk7GaT5vuy1mrKh3s+WFyseSpaaVAst9iS6QrokuZyqHA828mYb/E15KcJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlnyGN6g; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlnyGN6g"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c126de56711so179907366b.2
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988424; x=1783593224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSBXWVP6cFuS41+bLzi/68MzajKJS5Rgon/65yIMPQ4=;
        b=DlnyGN6g9tvWkuWfVDZzKtjbR/v7hFljcRPYucvfsFeS/1S1Zb5obZF5Xb5+oDWTwl
         C397p2jqUlXd/Mef+brDL/Psj8y/SVLrXOBuEDb0hg09TbCJZ2MKv049uKx/miy/3V3s
         2ArJzxPRicgaPH9jU2B0xN+JYZEHPUzu/9EtGkkSqxB6AvGpAiTHUJR39BGpJSiIn8Xu
         smM/UK3gk5wQQ0h/j61wgZqkoEu2JYwn8dodsHae+LitBGqF5kmQWYh+NQC+mV5G9tJJ
         zsG5rKoiA7+1dBg1eJ0Zuv6Ol3RhIYE4Sfonz1uRrFSvhDywrVW3oYMwUcDH8yPhWuUN
         QKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988424; x=1783593224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSBXWVP6cFuS41+bLzi/68MzajKJS5Rgon/65yIMPQ4=;
        b=gqXq+CkwXw17L+FToEaiqEcYmqVL8wZPzhfubYTY4VhXr3BhmAVJVnC8AqMxkImq9i
         eqGhM2D14k4BMLH1Oy7LpAhG0L6xfiB16ieSMmXw1TL0InGdOBoJYJWo3P7GVjEhognN
         rDpA3AbuBqOZu/NOdOsInKckvF/KXtRqSkTGBGKXtGy7F81rJgosNoZyU/s1D5pXXh4w
         qxCXqC9F7ub1l8cZ2i7jOwLmJKhUwzOVFw2ruUtFD74YwgOd22C292BaiY6/UclhSP9d
         qUVd9pvzOB+DHEBXSPcpd0w8g9Vd9oYbLA26HAtjDgiTCSGyNQL8dtJQtcvisovvYHhL
         szYg==
X-Forwarded-Encrypted: i=1; AHgh+RrrALUy43sex+ptw04szuxa3VmrCnWx1hdZsS61KBRSQc83+sQMJJZbvreEooRH+9RQlILt350=@vger.kernel.org
X-Gm-Message-State: AOJu0YwleAHZN4KvAPl0JD5lsFJIebbIln40C5bRTIcwhhPEYoaljbba
	VZkw9CfJD3dpjA/1cst5oBY/cHYSmZZrADda62kpYjsZtel9xcO4mrkKYqE/nmVVO3ZRd1dAmK8
	RMJ8hKJdFys5KOkPI4g==
X-Received: from ejsc14.prod.google.com ([2002:a17:906:694e:b0:c12:4bb6:ec57])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f85:b0:c12:add7:b97b with SMTP id a640c23a62f3a-c12add7bc23mr240698066b.29.1782988423378;
 Thu, 02 Jul 2026 03:33:43 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:33:42 +0000
In-Reply-To: <20260628174451.2275679-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260628174451.2275679-1-dakr@kernel.org>
Message-ID: <akY-hn0upJuaeS8i@google.com>
Subject: Re: [PATCH] rust: devres: fix race between concurrent revokers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, tmgross@umich.edu, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, lyude@redhat.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Sun, Jun 28, 2026 at 07:44:38PM +0200, Danilo Krummrich wrote:
> There is a potential race condition when two paths try to revoke a
> Devres concurrently.
> 
> The driver core's devres_release_all() calls Revocable::revoke() via the
> release callback, while Devres::drop() calls revoke_nosync() on another
> CPU.
> 
> The revoker that does not claim the is_available swap returns
> immediately, but the revoker that did may still be executing
> drop_in_place() on the inner data. This can cause a use-after-free when
> the other revoker's caller proceeds to drop adjacent resources that
> drop_in_place() still references (e.g., Devres<DmaMappedSgt> racing with
> SGTable freeing the backing sg_table and pages).
> 
> Fix this by adding a Completion. The release callback signals the
> Completion after revoke() finishes, and Devres::drop() waits for it when
> it loses the is_available swap. This ensures the wrapped object is fully
> torn down before Devres::drop() returns.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260612202841.2577C1F000E9@smtp.kernel.org/
> Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
