Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443566;
	b=ZEUADOr/GBcvTPKqoWxvXcLOzJDzgtT/dAiMFe/wTtLC88JLnlRJqpjz/BaGoo9Hr5tM
	 8KKIwd+btn1HIhNXz69vmQnBu5lWEp73RfUYQdN9R0cQWGeV2OOcIvmABta2wlV9omrX0
	 ZxOASB8EYvLfiOIPR+kW00TPDFNCqYRpJM7dlYJyVqbTYJyDUaG/vAVakcJGn1vU/3owL
	 dr889Ycgk5RK/O53+1SbbEGXrosRnL7q+EqC4b+AY2mggQ0RAWNVAhwngcykMLogY6SSG
	 rsEqNz0vlk7d93P+Nr4qcL4va4LewrMK2ADear3atnPXGLrd4iTBNIKGeDrwuwfaQsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GYUmmEAb22LnKFiDajxYM3OVr0FaSmECDdgEbAZ9rAE=;
	b=pBL+3TnbvwWQClfsDyjkaK3hFeWl9noga+XQUgCeNlvDGQruaGkttDnf1GuIGEOEG3Wx
	 yrCGJ5PBxtAA8n4N/NQAoh9pU6bQHlTlaWpDPX8Mcj4qpSACCdXQ8Ls6CT5/HhNOhqj+8
	 0eTa2W4kc9JqfCCQEufii9t28DmqCeH9998I6K9Qc4NMTjdxIImUGSPOElJIkfykP9/0V
	 RbfOq3vanoL5jCIIN7Cj4T21ng7q/UxcUFS6U9pQjv74auma7EMWx7VHQ9D7Mzh5XUxbl
	 7P1MYzMf2eoJRjJBp3ZK0y9PMB3n+vfNlvTYzxDEzxTPmphmWq4oq8F+3xp2r7XFrww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaLVXHtb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F0606A330;
	Mon, 23 Nov 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaLVXHtb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB2B1F00A01;
	Mon, 23 Nov 2026 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795443565;
	bh=GYUmmEAb22LnKFiDajxYM3OVr0FaSmECDdgEbAZ9rAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AaLVXHtbhSoF5Kp0N7n7e1/qzwNIKpxRTRfbxy4X/KCRSq5u0Dm7EjcZ2MeLid9BO
	 YD4Ii1u0BRqi+IHBl35rj2kTDey1hEBSDKuESK941QQS5xjXXjV1eq7sVsb0MYTmL4
	 q5ciDi+Dllfw2U2vISzGBs9dXwNgEmsibenM7OqW4ZcSpIqcM0k2C28rztNb/qIE/E
	 T/+Px2OaLLuQ7KDeo6/bDFQkvIqDwM12oFhqvDXSj1wfhjpWbQ/Gg9NirHzS7hRsPG
	 By/Rm52+U9rZkwyhJQzJjgl8y7rlGW+tS3jvIbiJ+6RVmBu1fL4RmPTXAC9XGWHP0Z
	 UvlsaiSK88xog==
From: "Harry Yoo (Meta)" <harry@kernel.org>
To: vbabka@kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: kernel-team@meta.com,
	urezki@gmail.com,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	akpm@linux-foundation.org,
	hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
Date: Mon, 23 Nov 2026 14:19:18 +0000
Message-ID: <179544354578.3575060.11576418215536505542.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
References: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 20 Nov 2026 16:37:06 +0800, Zhan Xusheng wrote:
> The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
> MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
> rcu_delay_page_cache_fill_msec became slab_common.* and the documented
> rcutree.* names are silently ignored.  Restore the prefix; the
> slab_common.* names, never documented, stop working.
> 
> 
> [...]

Applied to mm/slab.git slab/for-next-fixes, thanks!

[1/2] mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
      commit: 2197ea27ed0ff25cb294a3e6656ae6e0a23c8efd
[2/2] mm/slab: don't queue the page cache work under krcp->lock
      commit: 0983f88e2d6d734dc35cd9ba4f4c3b4082555024

-- 
Cheers,
Harry / Hyeonggon

