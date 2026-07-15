Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C093BCD16
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148279; cv=pass; b=oPtzF+7Kba14FmrdAjtqNY/dcHCy8U1msN+P7sQo1AHPRwMv0LTr8Wu6+qtdHATF88yqONHbrp2aQ44R+84j43gaui1yr/nkwQt2Ci/WU0VLtcJnj+iXTZ3AHl6CexKiqeN9vRCt486OCRQNJaCIielGMYKVK4t3GHAQ07+Ef5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148279; c=relaxed/simple;
	bh=uKutVTY39p0tACln7T4vMquumVH2p1fzakEzXi9+UDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kr4tCuCCjou6MdNPczgopP8CXSj3m4+jlBJe2eNOjmJ++CdR2YEOD4rQLqHogFbHMMOcT51ZqX1mW0UHDqGWFsTFQDsVgyzq9XkwpTJm17LLKRHj18HK2dV5AhkHinhCNuJ2Wfz+/K19yytJJcWLTWdGJfZY1IB7kJpz48As3nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMQbO8si; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMQbO8si"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so19625e9.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 13:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784148275; cv=none;
        d=google.com; s=arc-20260327;
        b=Dslic+ovMZHa2Gik9KiPkHVmyNUk8BqTxRFCNc0/peumwdaov4LGQghxbJHlfZhe53
         pGA04iFmVXyeHAfRd7nZFqtdAZRBStmtK+mpS/9rz8eWjGtgHzVwF6eDuypa5qt1BIDU
         mB+bMIRLdNp7OAgg1qeL1DZUR+HlOVCPgovy8Jveg1EhzmKib6fWViWjAJzJ6+h0kKKa
         juRQbLYGcl+u1ifuLNBsy6qgul9bQFZ0+qilkDJCkj7Plc9YpbYBP7t3WcLSgw6iY2F2
         a1pAkFbYp0GhQ3ntfz4yCONSuhxuBrK+IN32diMGb0JNdCDgnTcL8kh7STDLZP5Qy7Fi
         rnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hz66rWG1l8090hWA3QPVjjyCjLvMjXWnoSa5qVyf/ME=;
        fh=/2WKNtqjTu8dGugTFDu0rLfvFnHurQ43eXnWOgcD14o=;
        b=qUDN6z2+rIGMtHQRUp1+o+9kO/fq0PGMUFHX93SssZYBODQYenVdB9X/0w7GvRQ5lH
         8wOA8nF7M3C9WEJ51FwYQZ5a4+spmUDtiVkABJSt7pgaTja48ZMYVjC/UIeu4vtaPFCG
         9fv8c/DeE/ejX6VzbY5Ey+3bzFfmE67AywEv/AKwBmPrireHq7P267NAP7PLKJk7ytcv
         oeJGsCEKF/dwY27S2FcMrvSA+niE7JFrqMPp4hdCQp60pwmtWd0iJmOAfztvlAQN2Krd
         QZaUwQvwpvuw/Usb83XZyoVx7nm8/mF68WtvgN7Mso4SAT711w8zB2MQNCc5PH4oYDxg
         UybQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784148275; x=1784753075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hz66rWG1l8090hWA3QPVjjyCjLvMjXWnoSa5qVyf/ME=;
        b=vMQbO8siYryrHz9uC+cIXn12CxECZJgEZWjnlJuaTeu6Tr18uliyzfh60ItZ+q2J4d
         4Gdi4Hd1DTaT6RxOZP81okPwrKohv8TjP0u+Z+5b/9l6ea7bEkZMseugK20DfjMuAx1R
         U5Wyr//dI1kCzzWchMp+dI5n7lbW4EOGG8GcsKblO85JCCwvGoX3a16d8SlfccNB3+Xq
         QXkSDfaM5IQ4+ikCsBWPiP1B7B+U+nJxrE03i3+zrvJE9j8Ug+Pqh+RYF5PENBaJqIsz
         CzblFn8eIy45YVSFOx9sDM84x3wKQcKVesPsEIDi0e+c/vGNde8Nlu7Lgt9EeH2aiAyK
         O5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784148275; x=1784753075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz66rWG1l8090hWA3QPVjjyCjLvMjXWnoSa5qVyf/ME=;
        b=Oi3gMVvL0gYx+bck6mEe1RJHthK7v22RFh8ZwXjDRxC0eOQEFwEr8O258UvwQrXpfT
         8aOJZOqDhMXg54IkX/RHk9hKOUF+DmQvxdG5T3gThIWwjLaz3UudDUPZvRbA5q8zjQNw
         fGAecpBMZ/cnWqKPr2mSZ+P8VgIplIDS0/tLfVw2ioXJkgxZN9xrMizTknF/RA8nL9wS
         x8a+FNnxzNWxkrhdP81c6cQZDGN0Q8DXxX4KqzWSbEPbgE+eTeElrpa4PIkSS94VcsZr
         g3/zit0UzNfssfOY2/5ukFrjrXPejCzMvYjpzy8qSno6AYZ/Hp2uvQOsdqAqKeAOT0qR
         Y+2A==
X-Forwarded-Encrypted: i=1; AHgh+Rr59cD4Wtg5/nyfwS/JS8PJkQ0O7Q5HUDdn8qaDtC74wWN+fOcxDkReIpI2tRZe/yz4+U+jzTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9Q239wYcD3OgLpsBhf1rpP7Cc28Kgnr0sNMbYjSpsMRdz9qz
	7S66WXiKyfghLBxsMxF8wC45SwX46yGBH4jfpDvjX2ux/n0K09fUyX5Nnk7PNMinLuGJVuJm3Ur
	GUqR6VnIPqeKExm3HV6wzWjTZeQVNFMMABU+ERE5F
X-Gm-Gg: AfdE7cn+G0fYud0sD4zYwOKOe5HQP5i0qWZrxj07+5QUVp0lRB1lUFhvhQfVHM+Ky5u
	MjyXF+Tu5E2LpKQrVKKtx/7pgjAZv5HQCIk8Ji6RkJUBth7aFkEsU6z6gdGWb7JlH7CHMcf1EFc
	fLvoAMAWyuQXs+Lvb9W1msEEQ1s5R5ySE9a1LITSCnvJnRCrEGl2Vi26+8aFnJhI6ZfFVe4oNSB
	uXEb9hBBpcURmVQdOcsvr3bYHo5aCmIbzsutKEwBOq6Miim4OhNh0xxyWX91G3k0XiL3SSU7VRl
	RJLtA+P1Uvj+y/5Z3xMcSdAtgJZuXE0HNlxOxp7QEenTd7Y8fZYo1HVgLBI=
X-Received: by 2002:a05:600d:8494:20b0:493:aca0:32e2 with SMTP id
 5b1f17b1804b1-49541e54d4amr246495e9.4.1784148274578; Wed, 15 Jul 2026
 13:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com> <20260714114654.3885457-3-shoubaineng@gmail.com>
In-Reply-To: <20260714114654.3885457-3-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 15 Jul 2026 13:44:20 -0700
X-Gm-Features: AUfX_myDNkkGbyCVobnhwftgr4bKDJQunXmKkyEYSc1ZZ6YoWywnkOQfYn032aQ
Message-ID: <CABdmKX2Uqw5nr3-nrSAVHGt7Nij23Mt503DBhbhKT9suN_vm+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] misc: fastrpc: don't publish fd before
 copy_to_user() succeeds
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
	"Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:47=E2=80=AFAM Baineng Shou <shoubaineng@gmail.com=
> wrote:
>
> fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
> into the caller's fd table before copy_to_user() copies the fd number
> back to userspace.  If copy_to_user() fails, the fd is already visible
> to other threads in the same process but the ioctl returns -EFAULT.
> The existing comment in the code even acknowledges the problem:
>
>   "The usercopy failed, but we can't do much about it, as dma_buf_fd()
>    already called fd_install()..."
>
> Now that dma_buf_fd_install() is available (introduced to fix the same
> issue in dma-heap), apply the same pattern here: reserve the fd with
> get_unused_fd_flags(), attempt copy_to_user(), and only on success call
> dma_buf_fd_install() to publish it atomically with the tracepoint.  On
> copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
> unwind without any user-visible side effects.
>
> Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
