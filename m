Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9F3FFAC3
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570294; cv=none; b=dZoeenM6ijfZcBTjOJ+eNo8pk6IxDtZQ9UnND0LGzyj8k+czihsHki3/q0khefFk0E4WlIBT1769kC7w+3EnE8Mfsx+WRzuVV+nUse6Wx1sWrSemdugIf905TCCt7+eg4y84mnwshQPbosa8jyi9lwg6xXM3EZGGwQmSfiISCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570294; c=relaxed/simple;
	bh=eiAdnY9uyHvwwRccJiE84KcM5Abkourdof8GwKi9sxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzW7yjHajEeKj+dzfjH+UiM/7UOY0C48ppO+HZ8Xyp2IoxkjMGTnxLFbW+TEy/IWF4DNbcpwm69d66OBNNeZ7ayF3AoRUFE7OwsYjEpi5nvA/j0vg7XrktBWNqg4AFYAdU9mH9zo8riePj+KtkG/yMjreT7MlpcaPxrSmE8+3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzZqQ7Lc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzZqQ7Lc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacef7d299so12595ad.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570292; x=1787175092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=adU9pSYSvOZv0vGMn9GbsdCEmXxJG3xNFehX0PTMJFA=;
        b=SzZqQ7Lcw4fMJW2UCXaSmvSofj899LPVqWuz+Itv8Gl7uIOrsT0IHTNYt4uFN3ZuuS
         sGZtC+qPpzPbjtVczjieKr/csl6w02rCJln515/Jg+yuqy3SJ6YFNvvDp9Vdgi0DE0eT
         ExboNDKC7IlfRNQodUUri5yQQILNngFtFHwEt1HxjwZ3ARvH99eCjLe9rHat3y55r/Or
         9POwD8XnH47bdMOnYqAdIDjPnJuvNF2HVbKm3zCTFcK+5qQN1BbokvTklP54K7e8Vv7g
         SCRVwjJPRN+lIrpAH14qmEQXyrNzDJxrx+w4QHAETej2qjOgDagWzidlaXqqngckMU+x
         LdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570292; x=1787175092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adU9pSYSvOZv0vGMn9GbsdCEmXxJG3xNFehX0PTMJFA=;
        b=V+HjSUWp2+WjyBIGEM2zfd0h+Kn3LDkMSJ4fuzvltnKEGI/fBLP4cBVBxVPyNIeT1o
         Isf7WrU3SLArIMH0qIpm5jq+0SaVcDX0V+qIIZJpRd4E7c28qmvrlmjyK95RiqfbrIab
         FyEpJ0zpuGKI+KzcDArgncpKpcXVkerz/ZocLeWkUUqH8OW0QDDXvL87NXuoUbRiM0+y
         W58Nyj2zP+ofOXaE/gDsRtufCXXEIrQUOA/+LsAQthJSH0a8XGffW1YFluBxRnQ3Ca1h
         4Xlx56BA02n93su9uznmpkf4w4OgFe0h8GV3lZn77XwisVrsuTtrHZUHLAh68ncpA5hA
         YzGQ==
X-Forwarded-Encrypted: i=1; AHgh+RozA/S9XjO7QQA6OUMAZwYIgqakHz02Py5fb1dxI1T1pbDh6da1ytycu52oILuwX2Y2ssHpdQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0RAZRoBg2QlUue6vb5R6uIF8PXgjtFc6oEkkvuPeOt9WWr3n
	wOKVLYsMNXRFjUuexk+Sq83TOI6wUDhr5n4LIsY0G+H08xfcMi53RkPxnAEAoDhOSQ==
X-Gm-Gg: AR+sD101aFHooadCcDWpUf/qAtmXmdeN8r3QluBZ6TR66a6E7NmzaQVVrhqNsPXc64h
	tKhGQs3zpacuVA3QuuWHAh4ClABWF4VgZmO44M+xuIZa9DnVsiQeun/UayNqLg9rknWRlCpOuMV
	UOaE72ziN9Kni+RMqDHgPMAGUdvQgBF+GZWZeCeg5l15tp1JEcYiM5kcbgzM2ipDuvV60wuFuxL
	7+nkdjIEPs65khZZ9JdoAOlLG8GY5jJH1I4IhiPovNXlp0l/uzA7Y5Sw+Avh4r5Vpol+T+ZOyuN
	JjFp8rrnOU+W3bCD/IyxrW2N6hU3joPe75Z3sHZwpCQUf3wQGHBSqvTdvQUcDOAFWttVRT/FE70
	dJrRwFle587L6zf7fK5rb+Uf+XqVx6W/8//2mOzr9oP6euFdBF85hsIUAT+mS4fY14ueGHdDds1
	Wlvzu6lMfxwsDbk+mnzlnziRbRcwCAORbMTPX2/BXjf8QmsdnrT9W00EtpfzQ1WBsFFKBC7Lczi
	HQX+Kzxsvt554tPEg82Fkwe23XBRslBe0i3Z04pEXwuYCzYcyVSqbJwoJ270Qqh4c858u4zfFEu
	/kv5euBG
X-Received: by 2002:a17:902:cec7:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2d384c9bf27mr433665ad.11.1786570291443;
        Wed, 12 Aug 2026 14:31:31 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4781978sm142558b3a.20.2026.08.12.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:31:29 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:31:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tomer Pomeranc <tomerpo@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, brauner@kernel.org,
	aliceryhl@google.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] binder: fix is_failure flag for superseded
 transaction cleanup
Message-ID: <anzmLD9snZS3Ul66@google.com>
References: <20260812195316.259136-1-tomerpo@gmail.com>
 <20260812195316.259136-3-tomerpo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812195316.259136-3-tomerpo@gmail.com>

On Wed, Aug 12, 2026 at 10:53:16PM +0300, Tomer Pomeranc wrote:
> When a TF_UPDATE_TXN transaction supersedes a pending async transaction,
> binder_release_entire_buffer() is called with is_failure=false. Since the
> superseded transaction was never delivered, binder_apply_fd_fixups() was
> never called and no fds were installed in the target process.
> 
> With is_failure=false, the BINDER_TYPE_FDA cleanup handler interprets
> stale buffer contents as installed fd numbers and passes them to
> binder_deferred_fd_close(), closing unrelated file descriptors.
> 
> Pass is_failure=true since the transaction was never delivered to the
> target, matching the semantics of all other undelivered-transaction
> cleanup paths.
> 
> Fixes: 9864bb480133 ("binder: add TF_UPDATE_TXN to replace outdated txn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tomer Pomeranc <tomerpo@gmail.com>
> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f70aeb63a..bc8bc9ee4 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2930,7 +2930,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  		t_outdated->buffer = NULL;
>  		buffer->transaction = NULL;
>  		trace_binder_transaction_update_buffer_release(buffer);
> -		binder_release_entire_buffer(proc, NULL, buffer, false);
> +		binder_release_entire_buffer(proc, NULL, buffer, true);
>  		binder_alloc_free_buf(&proc->alloc, buffer);
>  		binder_free_txn_fixups(t_outdated);
>  		kfree(t_outdated);
> -- 
> 2.34.1
> 

Thanks,
Acked-by: Carlos Llamas <cmllamas@google.com>
