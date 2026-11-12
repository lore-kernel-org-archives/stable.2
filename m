Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514990;
	b=U9alZy3xJoXsCbZSwv7+u065xC9eP9NfO3coz3OaSLzPJMw0/VNBkcv/BBPsnTijix8J
	 nI0p+Z3RtY2BW9NQUqBtkdbryBPAna4IrFsGhpJWBJ8hAd4BXuEtdhVVN6q0dJ+4FYGF2
	 QXoEV6Qh7g1LhvvrY0bkXToI1O+1FDthQYbm+ZP+HtRz/bMFwYUdS67qx2lZF98YBHfYH
	 9JXerey4JcvFpCfd3VY65rvrAVzmLwtMk02LivURe3JFhDo7jk+RhURAQB/uQti1hunbW
	 2lD3HwafBvvyZoU68zmnclJ7ad9O5aqdNuiPOFHHyxncZ0eanjtjvOpupWAeUgmk2WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oDkF+EHNknttvr/pyjYehgB7V21ORBFZrQ57TwACNvA=;
	b=Sx2k047qbRYzMLhmK+hB0QKRJ8pvLwn0AafrFLje0yrQBSz++YLz7to9BGRogkiM1a59
	 aJyN2rMVt1CeGm/E9gTEKSUX3YA0e+zORtUABG7P4+zIcRc2ewjA8dazjbrozyFq8C5Oe
	 1uzWJTxBhJzCnDz/vQJFeufu/zMLnMWWjkR0RA5b/qe8LOxmcXOsU0ksRpubr5mYZxN1K
	 xa26tP+GV4zRJAb1clc9Xv8n+tHvN2JUfinGMBYSD26UpwFJbsye17JAIpdwa/rZDQuKf
	 bc1yq1nOnWMPJ1AXMqKgmdEvSxryVYtzN1KM19BkTk7uibJX44j8r/9f6GLLsvU8YGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VxOYMEa7;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A75606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79A75606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VxOYMEa7
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so25215ad.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794514989; x=1795119789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oDkF+EHNknttvr/pyjYehgB7V21ORBFZrQ57TwACNvA=;
        b=VxOYMEa7WN5hU3s2AL0gTAK4CGvO8PTwMETyXLtJjhfb1RoqrwwSsIreAjmEhNNqHp
         mpHOwQsZ3SnU+oqT2m2FizVk/fAFNAsBVCXr3c1X4oL51td54ly5w5hv1/mfk6ZUhtlk
         3UHK97m66K71g61Mw8fYqxMI5ekb3IXKdjZwzbXdTI4FgqEocNXlVk2WAy4Rb478ZXX6
         GPqKBs5apfaDV5AyW+X5GEn9eztVMp1jdyrz8OZyYqiuSFB0b/Ti4RuhZsaKqg1LbR+H
         Gvt1Crpc5zalvK0/B6N8w5Jkr6CMkjWRuqtMxUyy571iVEhEEUkJ8u02iAzP21OyGiYm
         91dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794514989; x=1795119789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDkF+EHNknttvr/pyjYehgB7V21ORBFZrQ57TwACNvA=;
        b=As+nnzaiawGIQ2XSh4v1InvX30fe6WzMPJxq3SFCyHFSeIZQWW19NF9R3SNxPewrXv
         4R8UyAm6Zt32JRLTArd8Ldy3o2DwupKJYEQVnxNIXL+ZLuDlEmoS9oOqQ21pW2LfH1Pc
         XtXlEr+NpxfQhUD2ObqMB0ga/+IMNN5BcYvv+1Xwy+PsxhJUajdZkyaXXp+F35xMPVGJ
         V9t8wpcQn8CkmUSHgYrz5AqjSJlp5pclADjPtxlJIypZNefEUI6tdx/NzKOPeSRG6WmF
         RqPMNm6BEtu3JplEFU1M6qfI4HQ6WmNxqNq+BoP0pt3RGakAQEmr9pnpuibs8kgJ2Gvf
         vskw==
X-Forwarded-Encrypted: i=1; AL+hErEQh7yL/uUYhObq0qMt6yYgILRq6oGQaZ8PY3tQngn7Ar0NZ7nFYxbja6RGIDMXq3pCa9UqeoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CAz1GjsqsjZ6Dop0QbDjR5x/AgcgnXQi9Qak/mxHYqFCT3o5u
	Xc6ZMPifZFWywYN12OOVlzNrY5RVPpgEa/KC9Z1wHvG1ZCyRgEZFdnIdemtpPfpAby004IiGTf9
	3eIun/Q==
X-Gm-Gg: AYBFou0jHgXb0UrqCvFr48aDtdXXQY45Nf5qqYh3A8wr2lASSDOF29ZYyb0Fv/Ipd1O
	anYi9zE6Yx8j1QlE9371E3R/jzlFMZT0RvO7td5ehjO0gf5RjM5FNCoCN7SHiRFooXMEvy96oKv
	EVJ/rE6S4MPuYT2PJrLHJ/gJHL8Sb+Yqq3l+t1/rqJMQg7jwRx1iKUTGdnsgJRp8UYFqInmBVLs
	jVRlSBn/yATp8ektEr7GqTZiZBTUXOP4HVmP7MH3HBiGJbfbhJUxwbWGchp9jsU8VXuQhaJsz8q
	nEdo4js6/GFrxOsuwPiNy82+NeEKAmtQHktXaW6xdam2PjUedVE8onQsWPfr0zs77SrRP8Hxcm8
	G2ElY6IFuOe44rKx13zQkas7V9xQMWGoRGlRTAf2k47t7P9U/112lLZDARNuIHtruvhNSONYe4w
	Ep/xciZ5qOkC3m11JLPPsgApRbCHSVPviQBcLB3mpmr9w36gaTGlqV8txF/6s/4oqPnb7YhSOkG
	QO54XVY2uPR4bSZJz473DNw0IFNyjkdwDG1itw6RvCokRMXc9w1YlKaWJ7mj2jdhuPuxUhf8Vcv
	IeP7tYCvQwM/TcmyPX+6DqQI4YjP5sE7LxUMnZ1VtWpAeLnns9ZiH5qL0LaL62kvqjoIJfhd91Z
	d44e9k0SwN735x7P2MpTYSUHO7aedxc/+q01IJPe7Ni7Ar6mPNQJpk2k0MfMk+0iRHydQCfFoRF
	kTtpYYazfmDc5hVGp6qw+RqAG69W8DwiCVLlMsvt/ieBGSCOxaNxy3p4jfOdtD294PQ2rI
X-Received: by 2002:a17:902:ce02:b0:2df:42af:2f9f with SMTP id d9443c01a7336-2ee0f0e1667mr1068475ad.1.1794514988112;
        Thu, 12 Nov 2026 12:23:08 -0800 (PST)
Received: from google.com (130.155.125.34.bc.googleusercontent.com. [34.125.155.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm874147a91.3.2026.11.12.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:23:07 -0800 (PST)
Date: Thu, 12 Nov 2026 20:23:03 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Chris Wiseman <chriswiseman@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust_binder: account for deferred work size in
 Thread::read()
Message-ID: <avYgJ8wIbY9-gFi-@google.com>
References: <>
 <18e70d7cbc2831c0.3137322e32332e3235332e313736.1920de.0000sendgmr@google.com>
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
In-Reply-To: <18e70d7cbc2831c0.3137322e32332e3235332e313736.1920de.0000sendgmr@google.com>

On Wed, Nov 11, 2026 at 05:23:24PM +0000, Chris Wiseman wrote:
> When a looper thread replies with TF_DEFER_COMPLETE, its 4-byte
> BR_TRANSACTION_COMPLETE work item is queued via push_work_deferred() in
> inner.work_list without setting inner.process_work_list. On the next
> blocking BINDER_WRITE_READ ioctl, inner.should_use_process_work_queue()
> returns true and Thread::read() checks only whether the remaining output
> buffer can fit a single transaction (4-byte command code plus
> size_of::<uapi::binder_transaction_data_secctx>()).
> 
> If userspace provides a read buffer with 76 bytes remaining after the
> initial 4-byte BR_NOOP placeholder (read_size = 80), Thread::read()
> calls Self::get_work(), sleeps in Process.ready_threads, and receives an
> incoming synchronous transaction queued behind the deferred
> BR_TRANSACTION_COMPLETE in inner.work_list. Iteration 1 of the loop
> writes the 4-byte BR_TRANSACTION_COMPLETE, reducing writer.len() to 72
> bytes, and iteration 2 exits the loop without delivering the incoming
> transaction, leaving it stranded in the thread-local work_list.
> 
> Add a size(&self) -> usize method to DeliverToRead returning the maximum
> number of bytes that do_work() may write to the user read buffer, and
> add InnerThread::pop_deferred_work() and Thread::pop_deferred_work() to
> drain deferred items from inner.work_list before entering the main work
> loop in Thread::read() when the remaining buffer is at least 76 bytes
> but cannot fit both the queued deferred items and an incoming
> transaction. If any deferred item writes bytes to the buffer, skip the
> main work loop and return the drained deferred items immediately without
> mutating inner.process_work_list or waiting for new work.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>
> ---

Aside from the "patch threading" issue, this LGTM. Thanks!

Acked-by: Carlos Llamas <cmllamas@google.com>
