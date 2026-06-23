Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DB396B73
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199106; cv=none; b=hSX4syEs05zB99sqx1+BzH8BSNO+YIMIYnvllrFmtjijf2uyRpKDKwya24vBl8cHBhXAbKhraPA0ZtcC2MWVAet3XpCpltzniCInmrG7QHthOIerE5hTMpGCJRtOOAsDD+bA3IeeneOTdMQkgpCYItRdGlE4eOoA8zBTZ+Zj870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199106; c=relaxed/simple;
	bh=hqE78zs9IRTrD6cZJabx1OyLprOkgznQThC+LS3PnLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sls/fcbCFit/5Gtpe963SXLfxnGMg26cGQ5PPFKT2ZKDC0HXc+6zqdECuF95hnkObnnapsE7BvFkZWxqiNZZt53UnbU+B2Zueawq28bJqrUppRK/skjoaoZAQH6GWmnK7mxfyyLDXEofpGXVvmfwrbuCcwzP+LK1ESSDPUS1Gg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbeYw4yj; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbeYw4yj"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-462c4593a33so3521626f8f.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782199104; x=1782803904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9/fLZkP9Srk0NC3L4Jzfv0T43DYYXN2q8SSyx7gNW8=;
        b=wbeYw4yju2cXTRw6yAjyQQMvkv1NRo+A5Oa0vLgsTvGfjlWj5D5kplKLJNqQ2JTqO8
         oV0aPmD0WRl/S6sI4HdsVN/cGv0sBYA4XTXQ8DEkoMKHP7+pElXo0aD+e0KEzeE/3An7
         abIzBIwXKKdLqm72dWvpIPOST4LnIZR9Wy36QRN2eBKIA3h6+5FLvmPpLlzGLyq51O+J
         7R9D75Po2x3YHaYIgnGZogUhtn6CIBo4hQ58UUhHsagSGkiF72GtWloRKPOABZPx1bP0
         o82iBKtC1P/tp3NZmEtnhD8/7g37y42GCV0zd0fqntDA+ug7pEyjn9lA1Ujme9N4DxYm
         GOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782199104; x=1782803904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9/fLZkP9Srk0NC3L4Jzfv0T43DYYXN2q8SSyx7gNW8=;
        b=AJF6RD8PdcalF+gWs0dS6E1OBzr5ioMalcFhGFPbHXypOP/EYjHG/vtu1rKOS1H4Fz
         rv1y/oFvoVQDk9KHwvQETMgPG5UWCiGzaON8BaxK8Al95g+Xgub6UVZVZTUuNMDGEOKJ
         gQ7Bj3U6Kk0DTKJiAX5eka5Uk10Ht8kzU6iWJiLocRxixMWO4xOe9/sTF7QnScBTy3Ke
         +1eXep6QJoRZDJTdHC/E0VVp0YozCqrPDeV9m9QK+mJfeBy1faHA0FXmovkTICy3guLX
         K/o5VO1I4AMJbY2JRBSpyLeKxj7buxEhf2GMKx9Dg9WqEz0LnEl0xjnGqGJWlj4DBcki
         8MNA==
X-Forwarded-Encrypted: i=1; AFNElJ9ysk2S3amzcmBHUJia1JFgD3WytcEhaRVYz8P4+X/w55ejjlgzyx3iFjaR/zUkvFZUBW79uC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOv1/Xy7MPbjTS4D2A9pxcj8Xc/2Y8D77Rhkj0qA238nZx95g
	sqtNDN3HwrpbrlyKm+HWNpRBf4Xv48MmpgTf6/MZNK+r+0wmyWSINaKyRcdHebpY8FdRWcq6J/k
	oQGq75LKjd5+f6Dj/JA==
X-Received: from wmbjr26.prod.google.com ([2002:a05:600c:561a:b0:490:af44:67a5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f85:b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-4925b380308mr19335035e9.28.1782199096405;
 Tue, 23 Jun 2026 00:18:16 -0700 (PDT)
Date: Tue, 23 Jun 2026 07:18:14 +0000
In-Reply-To: <20260619220141.3193697-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619220141.3193697-1-tristmd@gmail.com>
Message-ID: <ajozNgxXzj1vJpPa@google.com>
Subject: Re: [PATCH] binder: free fd fixups on superseded transaction teardown
From: Alice Ryhl <aliceryhl@google.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Todd Kjos <tkjos@android.com>, "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Li Li <dualli@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="utf-8"

On Fri, Jun 19, 2026 at 10:01:41PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> When a TF_UPDATE_TXN oneway transaction supersedes an outdated pending
> transaction, the outdated transaction is freed with kfree() but its
> fd_fixups list is not cleaned up first.  Each binder_txn_fd_fixup on
> the list holds a reference to a struct file (from fget in the sender
> path) that is never released.
> 
> All other transaction teardown paths (binder_free_transaction and the
> error paths in binder_transaction) correctly call
> binder_free_txn_fixups() before freeing.  Apply the same cleanup to
> the t_outdated teardown path.
> 
> Fixes: 9864bb480133 ("Binder: add TF_UPDATE_TXN to replace outdated txn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Seems reasonable to me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
