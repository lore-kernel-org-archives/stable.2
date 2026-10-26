Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038103;
	b=0Zax94HahtG+K8+MKrgrpXWNb/IFiLKbOXhANwh52sjK38Gu1H6sEjeVyKpvmgfarz5k
	 UB7LN/Rz9D+rcIsoA/mSqUJ7FzHR+hKtX3iOfT1tcOzMYwK3a1JTmAmVChQDsZ5t+Tdv0
	 bviZqGUsm/8eKbj8HreCLKQplHJR1xSuArjHGDVs+tBcAVXDCQtHrU3+ShRjB2PivCzFG
	 33q6kxsJ7bxRyKuGC68dIn4SXYcT6V/S3T0Lf84bDVyGx0qGxEh9lE0Pm3bW2Z/loCgaU
	 ys8JDy7o5HM5etruXT/WsNWcReB8/CRyeaRSEvmRDSMn0OPZLleDFMzqjyOLjwZLOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038103;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CbeFSzF3bNiOlS77Sh4fKaW/stqFLxPnX7geGN3Z7iU=;
	b=oJBXWMCpo+iK+DX14DBnqIWT3ZjhzP3jqk5/lWcG8tc0REez9gV3T/L52PicWjupv9pC
	 FJPqwOupz5NMfpEw0mOeNeiapuRyWcCjsw+HznBF88IGxgRtI1NRUDz74DI4QS4q6rwTm
	 7KHOGHYXMTWS1+kz6C92xhT5Zv0M25oaRhx74uYEsuqT3qRxfhps5lwsvouagxuSmnxsb
	 r/sC9oA2wCTsc6I9B2PKm4l5B95/SiCTBV6XashFMlU7WKnwVIpZ4iwVXQpI/vdCZnpLw
	 4VUXtA2soNc6FagBUjhgcn/xS0KsjqV3gaPgezlzbFqBK36/dwfYPt7nuA2gfUpbQeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RRmRNgku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA35606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RRmRNgku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A831F01825;
	Mon, 26 Oct 2026 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793038102;
	bh=CbeFSzF3bNiOlS77Sh4fKaW/stqFLxPnX7geGN3Z7iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RRmRNgkuNZN+6S8JBoPAsG/NxIEtUN2GXvlbill86DxSw3Gr071cnxmfUAYIBtxoF
	 Kkac7UGn8THylVvYSHzwdl826dSE5lxB34w/OqBQ1dzufjdK5hZLgheyyp69/75QEB
	 naC+mRjitYUuANp5yYOx+p0mYbUj0W+IvqYdGjtk=
Date: Mon, 26 Oct 2026 19:08:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Leno Hou <lenohou@gmail.com>
Cc: stable@vger.kernel.org, Wei Xu <weixugc@google.com>,
	Zeng Jingxiang <linuszeng@tencent.com>,
	Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>,
	"T.J. Mercier" <tjmercier@google.com>, Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH 6.12 0/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
Message-ID: <2026102643-untried-devotion-b7f7@gregkh>
References: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
 <CAGQVrL85gG09Uo_+PgGxNOrh+a71eLhsnZn4e93aubpMvXGK5w@mail.gmail.com>
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
In-Reply-To: <CAGQVrL85gG09Uo_+PgGxNOrh+a71eLhsnZn4e93aubpMvXGK5w@mail.gmail.com>

On Mon, Oct 26, 2026 at 11:50:47PM +0800, Leno Hou wrote:
> Sorry, please skip 6.12 branch and just use 6.1 & 6.6 branch

We can't do that, you have to have all patches in all relevant branches
(i.e. you can not just have fixes in older branches, otherwise users
will have regressions when they upgrade.)

thanks,

greg k-h
