Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308018;
	b=DxJxU+QBHs6bbwHKRv1bI9nWXYGgbY8RJ3s/2PJeAaWfSIbIxfutujoeX08g+EIO2O6M
	 vgoo5uuVFysg7iwX6vWaCk4dkivnNOz2ZljO93lpj5hfC1Pa4fgrJGHWGz6Ol24w1weqx
	 hBdppazw3Iyoyol6/NM1kJMltjcNhJSmobufR8pKgHK5PRX9DM12aXjsc+/2lPnLwPY1F
	 Zc1/DXaD1jDNW1CByGZXEG4FKfewtYS96jWlB6epCyC6CvAU0dKZAIpHE+IgUfNo7aV3R
	 +f8w4W/l/XqCBZUDCy40OC1wDR4C7OjA6AJj1MJWtUNQZl5/F2GPA4aLhILA39lEhhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fb8kDJR3/eqMuwVk4mGcY8ktqHU/PCk1HgPlmWV1nBs=;
	b=hiTRYFC/dKCK442UeOW5mcCf2a62IlRRQ4gliU6R04/hZ6Qui5cFJjL39SeRBWoqw7wE
	 beOqsMqNLlOnfACdO1hye80Gd6oDIGh9kVnrFw9l78j6ys+1TW53kx+5YM7zQM4ueoWUK
	 xLPorxGlm6/7fdbGe9fW3h9HR66XrBwRaJyL+V26XdV8nqvav6/YddD+h8JuCoYJeUDhu
	 pQVGkFdVzQOW67tvQXxmMZrkrjyot6E7ARCtMRX/b52YTVrlWR6c5SSHwy8h0mh3Rhls+
	 RO1I1Z4cBxh5hFBgN+mT6tVIIhrbYt8S5RPtnRIpTOkPCl2wDLrrL9IEt85beH214zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVnsFrct;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF6606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60EF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVnsFrct
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e00eee27dso33502f8f.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793308017; cv=none;
        d=google.com; s=arc-20260327;
        b=K9PzuB8xWIQOb0ZQXWBMR78PXl1W2pvTJAF1RJBF3378iGukTLQ3OVX2bDxm315MxC
         uFF3QQuNB8TYwaALHPea76aP9viWUCm1Eo/IkHt7NM1S5ULcFn/mriMj+6FzqEd6trLB
         d8/Zx9N2jJngHUvmvdeWD/jSBoz1FL8V5OWHxxX2FRd18gMghOfkApIhT+t5zhgPbk0S
         vT/mlYCpZxMlEKM4diC1EYZujfluCBdROWxMCycu3CS4jN21B7IHOXzeMyiH1uTPqiAk
         LkNUSBce98NOnuph+bi3D18rgUAWERqGNWsMojEPqiA0mm17CSBVz3vaSrhVfkKRgV2i
         AzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fb8kDJR3/eqMuwVk4mGcY8ktqHU/PCk1HgPlmWV1nBs=;
        fh=GyjPX95ROExekuhE9gcGMmHKufl5kQrcjF3pgOl5jTs=;
        b=GjQCDSOjO7V/rofKcpXYalGJVIQHU+ZPCv8zqb9zbfbHfK9dKsZeZSrafsG1k6S9F/
         0PadMDoXeELUYhLhN/hi53cMFQAGyG5wJDkv8qBL64+dBGx8jsArAqXsUv0BUEeQww5G
         oeylVij03/PHn9c3uzN4oikHdhfEmKM2JBckDu8hVOEwKcnM207S4cBfNlezF4dL/z2B
         xuNbXoq60S+EOLiOaJHRLc0cDrthJmVgUgTmBXnM/5WkI2D6bQU3s9X5hd2iOT+e+dqb
         +YOhtTbekOiKetJekOkwnUfnHhOAagUFrplrIUnWehJdIKyknwxFHQ6WReuGsaO237t9
         m+xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793308017; x=1793912817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fb8kDJR3/eqMuwVk4mGcY8ktqHU/PCk1HgPlmWV1nBs=;
        b=gVnsFrct4ag32Tfd0wM6BzECVlaMPUl7QlKyvnZFQLzgLo2y+RIKRdlB6hHI/B21lh
         FWKGmAsmQIdiep13arb6kjNrtTtU9TqmXsw62d2qtaIaKt5deOFZ8bZBJ6Tz7utT4PB+
         ajnp7e6INqXwKe3MDpMZUlV40KK482LSDVhpShkMhWiHdp1XLLuBdqEc/e+TyQ7WXLlg
         W6/q85L0HxAeNTjHsbYUn7xKPS/9PDxF7/bUsOcAXqlaXONqboLv6v/RsG1smha9ZSI/
         97rK0sXDrQcEFDzZp10lpiJKtaApjAce+ozMcxooujHHAIg16obCz4sWaS7i3rTCJs3r
         GC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308017; x=1793912817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fb8kDJR3/eqMuwVk4mGcY8ktqHU/PCk1HgPlmWV1nBs=;
        b=06enIPyv8WN/UsRRwm0NZqoRyK1a+yWq+BQ5S6CE8H1cqJpTwEMYf27ULbJQ4xjgSY
         +ZGTwySLKT80NVDKdO/E+powl+QH6SQVhCRmwOLKKpJv8NDZ8si6BBpocMMIABOKn84a
         Nv7biaqh4o4eTye0CcOIMp6tHAdAIWOkhtZzKYb1wo0zkwd98VsOqgw/Cx+/mUU7/SUx
         hO2llbrWirN0J33NmdBL9T6LdP0pDom2aEnAj3jNr+cd5hs+oIXNtLEFtM6bnwLQXy9S
         EnTJcBQ/oQwVz6v0dhMxwCaoKQ3LTS3Sp5YPcPpMDDWtXzJTUz9yzroAerLlMwRm7uhT
         PL9w==
X-Forwarded-Encrypted: i=1; AKwUvBzi46++6y7ghS3NOE1QkjfHoRbq0ixdAnw0/kl7fG/IvQzwM6xRYrHRrHLivZNvklfmtQJuJ3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZQSelA2RmPL1WKF+KMD5RGFCsrbDhuak3LHWBSf4EY9YTL5qV
	ZZGsPvDhUX57FP1kwuzjhEc1sW+UWz0BBmBvMHRgljtQc40ebgjsPQ2xcUHxywS+eMvgN0ft7Kp
	McEIsPzlnLHZfTbA7D2OhH7tUfjUJolw=
X-Gm-Gg: AYBFou0EzQq0LB8oK8nh8xfC5Q/toEJ4Jg2I4o6CjX+zqqTDP/mhM+KiSW/OfB+R9IS
	Z7eqdqw9EgrqpNF71hzw2lxjO8S27xewtnGbVHCHFmya0LvX4B/R/mBkOO7jOHvWtRxjdXvHOzX
	KonuHAntqQ3XeNMvEAH1YbNXhrZMVjnvc9AaPZtS2y5HEYWlIlSamW0DtZAOmD2Voaxx7cUf+m1
	5hMScWXjJreBfKrHqHhQV2im6NbvkWKRp6/x8YNAt0+vWglsaNJdx/FZEF7I1g5/xuNxXJ1rdwC
	RGxwv1wvsu5BuvGKpcqZ8qQawxwhHx6jOFnTpBydMbyHH00WFO2qJPPKfz977TajyutdL+aBxgQ
	kA2bYjxHpgU8YqmZV8N+cL75mPKUZniqPBZMDeMr8BEaTSLyYfl2H+Zo3H9W9/x+CyCE+Mk7mco
	dvJVDmMdSkYBPuKF4nwd314ua3einLK0rL0/sVpfat4upF8EB73XAG
X-Received: by 2002:a05:6000:4b18:b0:48e:6092:deb9 with SMTP id
 ffacd0b85a97d-48e6e2fa4e1mr1121429f8f.14.1793308016538; Thu, 29 Oct 2026
 14:06:56 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com> <20261030-swap-fixes-v1-1-73f73a59f2fc@tencent.com>
In-Reply-To: <20261030-swap-fixes-v1-1-73f73a59f2fc@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Oct 2026 14:06:43 -0700
X-Gm-Features: AclHuK92wLeJ9w3J3At4Pw7sJv5ao2rkIqVVn5ak-RXKnx5xxdpjvkaqxTwN9aw
Message-ID: <CAKEwX=O+j5d874gW=ENZc7s4y2CGVKheQSK8VrfD1_eVK=6U=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/zswap: drop the stale zswap entry of a zero folio
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Yosry Ahmed <yosry@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Usama Arif <usamaarif642@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Mani Tofigh <mt4022@columbia.edu>, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:32=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> A folio can stay in the swap cache after zswap_store() has stored it,
> when a swapin fault gets a reference on it before reclaim can remove it.
> do_swap_page() maps an exclusive folio writable and, for a read fault,
> keeps it in the swap cache, so it can be modified and swapped out again
> to the same slot. zswap_store() handles this, it replaces the old entry,
> or drops it if the store fails or zswap got disabled, "otherwise,
> writeback could overwrite the new data in the swapfile".
>
> swap_writeout() does not get as far as zswap_store() if the folio is
> zero-filled now. It only sets the zero flag of the slot, and the zswap
> entry with the previous contents stays in the tree and on the LRU:
>
>   reclaim            fault              zswap shrinker
>   zswap_store(D1)
>                      swap cache hit,
>                      map, write zeroes
>   swap_writeout()
>     zero flag set
>   folio reclaimed
>                                         zswap_writeback_entry()
>                                           swap_cache_alloc_folio()
>                                           decompress D1, uptodate
>                      swap cache hit:
>                      maps D1
>
> Swapin looks at the zero flag first, but only when it has to read the
> folio. The folio that zswap writeback leaves in the swap cache is up to
> date as far as anybody can tell, so the process gets its old data back
> instead of the zeroes it has written, until that folio is reclaimed.
>
> Invalidate the zswap entries in the zero-filled case as well. The folio
> is locked and in the swap cache, which keeps zswap writeback away.
>
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap"=
)
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> [kasong@tencent.com: fix zswap_invalidate() arguments]
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
