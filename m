Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739734;
	b=qqMQ3eH9ogml3XXI9TQDG9Y+PhX0OfyY44yNmBC/ReKlGlc5eX+D/EFcz2vsg2yKSdbi
	 2709Eu0B93pfH2xs2xGAnKnlIohI2ze6VxRYI4BC4hcp3MD8A6OxhaH++mxQRPzE2HjZl
	 sy9ZbT6JfGOu0lU2FzzWGyuRWiEog8e+Hhf5rLibiv+4CbQZ9pWxiEmftVG7FpbtR+oET
	 So6D0SUhsFisODLyIVCo2eg4TVkdmkMbhv0YTIpogo+ddWntS5EQgJ7SLF80f+eYbGLZo
	 UI5Xe132Wl8IHLqHiL3td2lJaHh8MIhvQ96tR8KdjqM3YnT/4n77Su1VHbo7k6+z1qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eLnVO73afvgaERjHXGPf5E6SbhMPv9R55TpDCQCEqgQ=;
	b=3jZ8V6TNq2VtZNqPi093u+Ywq+E18TtzwgJB4xro2YoNd7nH/3P8+jiONvH52S+Dx5UL
	 YG8aXpX0vlMCQNrwa06suNKoNUIKkcwwFuU471bIrc8Vi+k0tnIrLBWNTV9bzYIEG3hvG
	 AiaaN62O9wh9HE7Hj05hRXL4qa4KJ76JdtIOlu77gPVqFiBei5GIKaFlMpFZzBTqYlcnL
	 Txz46JMtsRxjusyWzXBXqXOMieHnIvx2t56I6J2JWxMB4jaCcthR8Zb5VUBZMz009dt7I
	 LYER2ULS+uu55cOQLqABzD1Z1Hb2d4rh8odVj1vpKDmdggf8fuINFqfu+o6ck81hSFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4AnOV2W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1DE606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1DE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4AnOV2W
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48bbb06e746so9261f8f.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 13:02:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739732; cv=none;
        d=google.com; s=arc-20260327;
        b=HRc+l33g1fb87tbZ/Q+o/Im9c+Dh47QfxGsldo5bsyrz9FoElcu327rM0KA7PEakgR
         +3HdpMc385D/ItEsepS0NidvcJh6mOszt0g5J4v2KNODhFFnyKXTcZhUXRZrdXxig7pb
         DqNFOfYJLwvnbdZxBrfTeS5qlkD7SoYdxTT9G9aCJGIUCEVZbAi3508lbLlRcCUJmY/o
         tF6UqCRoypyQSFgk13sDKJGInwtChTTuvDpckGmSisiKha48d375rVS2h58zIMg/f1LK
         8fe9GvfXD5HuDk9eTQY906SnU7to7bvZkx52P7pFyHPUn9ojadel01+QFVXg0Pv9xGs+
         q+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eLnVO73afvgaERjHXGPf5E6SbhMPv9R55TpDCQCEqgQ=;
        fh=tLYL9RUZuXcpRH7dG1qm+aT891hGcrjdrfQlmsj4kQI=;
        b=hIf42LVoFR7c0Og/SbQBLtihnANWwU9L/m6OOOCDORY7aafaLKJ2BitssBhtB/1jzg
         RV4Rd/ZEI9eVr66mOSIOpdjXvPJrLshUpLB84OP13tov51Q9oPxaoIepSAxjqvXsF2SU
         TFGU/Wguum3OSnIwqCAYm1mU8AVekAxueMD9/ziZdbnHFNpqffnV8kGHRNq0sBB2X4Z/
         YKb3n+rbbhKi4NqRIfgnvCKiZm84AwWzedr5VUIvn8obYE6jff2EaKUIkBygjOLUP+IM
         /Avw6rhbcrSi+SFZvok1MNy4Cpkm0tCEUWmpL+CojCLtwQTFHDu/M24dJhT+cAuCIzrc
         lt3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793739732; x=1794344532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eLnVO73afvgaERjHXGPf5E6SbhMPv9R55TpDCQCEqgQ=;
        b=n4AnOV2WwjJmlHVoT7mQkMmlllj/9Zg73CaYGeNHoYuI/301YzNlEoiIrZrz8D+r+H
         ZoC01zubBN4x0NFq3MyXwSBhvWCg//iL3Kfqb2MDwbYl5P3ZfXQ+Ykt3Im2DzF+f6+0D
         1dyt0NUDhINHAdmIjUDcPX7yntfDJuiYs9AFB2vX3gPQKasHR3Fcdr9Y5sQ64qnUnfvB
         CqLr1+GywYFlea+8mowMJHft08d/3UTFrg8tz43QArT4eARDxta5jnPU9UWf2lWgMV/j
         DFEoPf+yQQFas1fL2citqJk+pyfQ6QyFX7jhMaOaeVZ6Hlnb41xWWNLFRCA8XdHWpjAe
         n13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739732; x=1794344532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLnVO73afvgaERjHXGPf5E6SbhMPv9R55TpDCQCEqgQ=;
        b=lwBgs4IfZsJ6bH+cR11PrHGS26D8GpPaUEZFA5e68Suze8LCAPOojgiGj4pcd5chSr
         LXn2MAg1SzF312WVbfcVZLR1Xy0Djbep2ErGSUR+YbcnGVenAjiC/7hlVbwJ0v+92gw9
         Bvxgwnc32LLfsMKqOdUAxsiWTQEkSR6/5UEOq8NCVV94DurlrTqmeVU3Y9wvOqp/i6na
         j87U3YlXglwHoELQDE2GeQblsM1JGlpeU576LKENC6lB5RvMc76ZGk3D00Q47PWbHQdC
         mpPN2Fdmo8rNfFacIrGPypTftHtCXM0Pq4nrttrBxBsFr7849pV4JPKkNc1R3GdLfMxK
         F67w==
X-Forwarded-Encrypted: i=1; AKwUvBy7PEOA05AFYsKNGQgBE5c6YggzKskFa+DdoNFzgiluQ69OYFHlu4Fefk8xTiRiqRyELI1EtGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C1V5hV81DzxIRqD93I1uzCpp4tF7c+V+ACOab/OlhH625aj8u
	VBQBa/98KGg1JdFWcxDVdhWIeT5EEOrHlEfRY+jtjSngayG8ncyc3+TAz51xHkeiZITFmWKdQf6
	IcMNf+jBooQnV7yDyQGHUqExsM4ReUBw=
X-Gm-Gg: AYBFou04MOxV+oiYAIjfg+aeCZW+alfbR856f220+BT+EHKSh5lHQO4D98xCx4U4bqo
	iVmSk5ujBx90vTG64LxWI7qii2WBQj2+5guXIMLY6NDO770Q/WNOEa3GqdIgGXredWXjY607wy8
	SqAU9t3v5BL4D0VLKiePenTse8QkrfhFgIp/WbyWTDVHNbS3nVpVlA8lLQF6UqQ6Br70678QIPy
	BmXfbmPiVTDBPHDHXXfqD2jaH6SLxIjfc7sa+6XaBInQdJcegfJ4hkFPfowm5K2jbiOHQc40UUj
	LVtgnn4A6T9Rg10DgAXFrRM6mo4NIi/zCvDPYB4CgdJLdOk4sDuaFFMp5H9mldnuO9yrAkKNfYP
	OtlHWix/crauGLj8CPvVaJGLLhsYvswvbiHCGCspPbNsevXIu4Ks05fLLXMpIVGWCdXVUcreISG
	zuC+qaC0SXgt/kyWevx06r+rxuBQ3E6UgcUpOanxGliofK/0Ai3+YZ9g==
X-Received: by 2002:a05:6000:2dc7:b0:48f:88ad:7b75 with SMTP id
 ffacd0b85a97d-48f88ad7ed9mr6170165f8f.15.1793739731970; Tue, 03 Nov 2026
 13:02:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-swapin-large-unmapped-v2-1-87c70e597250@columbia.edu>
In-Reply-To: <20261103-swapin-large-unmapped-v2-1-87c70e597250@columbia.edu>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 3 Nov 2026 14:02:00 -0700
X-Gm-Features: AclHuK-dU-jDbeAA-AyxlAsBt3J5xyfKTDwVAoojWWH0SE7Uz8Xv3jSOSRyptrE
Message-ID: <CAKEwX=Ow38Y9OK69Y+Eps7k_sdKdkLKuO=Lxn0xisVkuHVePLw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swapfile: drop a large unmapped swap-in folio in unuse_pte()
To: mt4022@columbia.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 1:12=E2=80=AFPM Mani Tofigh via B4 Relay
<devnull+mt4022.columbia.edu@kernel.org> wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
> for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range into
> one large folio in the swap cache.  The folio only becomes anon once
> do_swap_page() maps all of it, so if the faulting PTE changes in the
> meantime the folio stays in the swap cache while not being mapped or
> anon:
>
>   Task A (fault)                       Task B
>   do_swap_page()
>     /* swaps in large folio F */
>                                        madvise(MADV_DONTNEED)
>                                          /* zaps the faulting PTE */
>     /* PTE changed (F not mapped) */
>
> swapoff then maps it, which marks all of its pages as mapped and
> exclusive, and the next fault on one of the other PTEs crashes in
> do_swap_page():
>
>   [    6.424485] kernel BUG at mm/memory.c:5195!
>   [    6.424503] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   [    6.427654] CPU: 0 UID: 0 PID: 67 Comm: swapmthp Tainted: G        W=
            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>   [    6.432665] RIP: 0010:do_swap_page+0x24eb/0x2fa0
>   [    6.451035] Call Trace:
>   [    6.451567]  <TASK>
>   [    6.453841]  __handle_mm_fault+0x13b5/0x3b40
>   [    6.458525]  handle_mm_fault+0x16f/0x480
>   [    6.461143]  do_user_addr_fault+0x312/0xa30
>   [    6.462044]  exc_page_fault+0x66/0xc0
>   [    6.462846]  asm_exc_page_fault+0x26/0x30
>   [    6.476708]  </TASK>
>
> do_swap_page() already drops such a folio from the swap cache when it
> can't map all of it.  We move that check into a helper and use it in
> unuse_pte() too, so swapoff drops the folio and swaps the entries in
> again as small folios.
>
> Such a folio was never mapped, so it shouldn't be dirty.  If it is, the
> helper warns and the folio stays in the swap cache.  unuse_pte() then
> returns -EBUSY so swapoff fails instead of retrying forever.  With the
> fix, the next fault doesn't crash anymore.
>
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 1s.
>
> Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_=
SYNCHRONOUS_IO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
