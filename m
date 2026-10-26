Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793039545;
	b=G9ka8LWBoiS6lHJ8hNa1FqAX9MsRrwLkeAKBcmZ0ZGsFP8ZDa91Ke1U/04mqf69a7jc/
	 1/nAUhLSe12EHXNtWolpMaoII2+2ysIM2yLuCtJfezSOIC4VafDZ3g86SI/fCJnIMskMi
	 zMPbmnE8jf9duohY89SdOJl+mfowEnrf2tKZOwodKvTX7a55OILL6rRl0pgWDsEb6Yu66
	 juw/ULd9ljJfPT8BLx7ZWElEMWI5kIiPCDBZzA427RONCuHh2OsnnbXnh+iOTKpkxf8m+
	 Z2fsHZqNUa/YFfSkVnDSTTN5SexG/p221ZjsJxx9xG8oXXGdZPgPCMC9R23b5D+I4Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WEX9+sqg9KeVky/NcPkirTK8PMNoKH+/ZsoFca1T+0s=;
	b=1lshlI27ov7qTAzeEyhrHpNcBppQ68qc7FgnqRmuvFUjAbgQUR7P8CTQUhfy+WK6DxzY
	 mbKkifWfcl0r9Q/QXG5obJs8VsWxYnKVTAXl1m7R0+ys2NkhKwqMu3LLrDP/tDyOxWGis
	 qS3DNB9mbLHXCjkQsYsnyHWWyMg/AmMqD1yCUgD949sMtmhYmDwFwY+C5za++8iYUHIx3
	 ZAOzwDUskYJqSMkyBkfE+aBwYcou1j8BtVdjXJfPj4k9eSdWMOKvIH+LqjBQfD60Y9xFd
	 m3pdXxC3r0DXBcl4jgdqmGzAPsFaCMWsxFESZCFbAABqc6jPpTrhLOPR63hfVqFDKiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nFlKpNNN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E9606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F27E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nFlKpNNN
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so28613525e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793039543; cv=none;
        d=google.com; s=arc-20260327;
        b=VSrag62G0rFUqMKm+SbhUj4FFm63YhfmizyLRE6t78f2m4k0+nmcpAokRQlK9MdKXi
         s+qqQIzow5JP5ZUSmypAuCLljXPuPhO4J01IkRoXw6KlMz+z0ZlSGu1DlkKiL1cUeUhj
         BnUstcmK1GdDYXKvrQa2OEv1nDiVecdhzE20jxw5vpPjTaloZXlktQuw08rF69n+ZGqw
         PrYVbyct/yIkLeOPTmDbnSFUCYH2saAehGeT78LPCaDatQIg16GdZ9IgRjU7UK43sLGZ
         QXyrf1YEL52WBz2hY+Ark7BttHo6Km5oZ09QCMCca4miMSBX0iiCm6kqOsgaQXsQcypB
         e0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WEX9+sqg9KeVky/NcPkirTK8PMNoKH+/ZsoFca1T+0s=;
        fh=b9QNQ7iLvPmYvjdklHnu8xbxKiyMhZ4jOiy6JSY+0/w=;
        b=hO1iFrXRfbYr97A12ztzr4Io0YkSU6iMbuDUgLRGKfFAoZAq4XCPFDg+U2bTKOGIBs
         e8d2wucMs+xN/G8KSfyERTwmMB3FR0WBl3d5YPGpEdpZ3jYiiAuG54POqS5o7Fp25DKf
         fXzCA6joeDB1dt1bJgk39N1qnVvspIimq/rrWOKXpgECRJOU3Bt+LWti2Z1c9tVtSEmR
         oUqSKAe1UXiel+rFAJO7JyKd3GgrjdUI/RlhtTTXcmhfZVy/GT309yXuPxObQym3g6Mx
         EuSpBcj1cZcbUZH3HZ0uvgT2Q/4VypPNazFU31A14lXZ0inGcgD8DLfPgaPQ1dfIcfhc
         LlhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793039543; x=1793644343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEX9+sqg9KeVky/NcPkirTK8PMNoKH+/ZsoFca1T+0s=;
        b=nFlKpNNNs+M8NXXCCZiaK2V85D/zRSjrKNbX5mRXExdk8mMy3jEhTxV/DbvE3kHVld
         GUT1wSx+EC2Xb3ParLzCQnoNRNnX8eimPBgMA4dwJHn9RnAAPHcJOiUZlnUQ3F/cctf6
         MZJ/rnaPQrEyElT+jNkareOG8NoEbM1Gr8Lskgquk889E4SNNiIIZDO6YIL+c8m/bThT
         tNcQOv5/777NeBm8yoB4bFmjc3xr2VRMtx8gXmc9vymM1PvIj+yp5ENSDLtqYpw9Yxu8
         9foFP2ylI/caEC3OtC9+8P1jYygicqc7O/PfKfI55FKs10kMQs05m+f8KNGLmzyzTRc7
         GSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039543; x=1793644343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEX9+sqg9KeVky/NcPkirTK8PMNoKH+/ZsoFca1T+0s=;
        b=GzyzlE8nC3pJQr4oXR14ShtimL5XSYCtaQ0puYBf2mc07q6Cx/azZCIciT9ajEOJwu
         MSLu1exQw5JCbQmfug8iiV0sGXTmWNUoPcG4PAGQbmF7t9+BkTBWZQftJIOsSHpvEIGJ
         gOcEtob+4GGpIFqtfvXOfUHKLV3ch/9wZvgADDhZx1D30tdYU/mHU/kA/zZ2cerFeJvb
         mCnYN/qjsq8ukrxkd7WQ092hDzsvbO5S1oLMJIyTvcNfmmgjygX/Ya97/IrJulew2tMk
         A9bIKmfOC9yPUFHcE3Mgj7rTuSY5DmuSmT6qcXuU5PBpJi8/evz76b6AvnXOQjbs9iLi
         yXsQ==
X-Forwarded-Encrypted: i=1; AKwUvByVOAfp1NqUlJpdYMEHmXKI5aHibkXg2gx+qpdHjJhFA2X7+mSYgOO2nv1QAcWqM/uedNKJrLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCkwgodzPa24UTZ0G4VXITAMRab/O5Narqf+ZpbIOvdPOkDhGJ
	t0Y+ZYSSMxcQxxJj86ZSXwmoEjDuPdR8YK+l34C07squB9y99JBkKtlAx6kideIhZt0ZKSz0zrE
	613aBkt1txsvbJ+kQ/8UBRnAYzVVzLDg=
X-Gm-Gg: AYBFou28C1r8n5WD6XjMQuA0gjx0IQ6mVmcskdOPg/eapsMsBQEs2dHve2lW+wbonAu
	V1evFxQJrEL1GtCt5+IAWRVazowR3F8MZMtGjVxI1qKYsARVLH57q626WQOr3zrIeq4l9T+WMaL
	30qF5Qk3Uwqi4T0EOnhAOGBlV3NHl8yLwu3PHHvJojGfrk4+hJtW8NWjZsITXmh5GcIt09kI8VM
	H5k/vOmc2QDDtbz16iSzniSrheXp84luOhEofDIjuIMKr4dvhoOLnAVBaV7c2+I77nBZuejeHfY
	k8YhAwTRofBca77khZjOLNQJTTm1u2n/QT8LHjLPv5dvcq9p1n2U3ez1xD5kNnjACIGwN2U5HIE
	SZLPtNnjqEYuS4PIPs41q0eDzYEsC+FTczSuOxWd2btw5Zm7AU1VIFmgXsrBrrOOjujBD2YHNiz
	uZJ1N4B39VvY+N/+vIvUm6IDfHsfrUHEkvgib0kDT4hZ6E9SUzw5cS
X-Received: by 2002:a05:600c:4e87:b0:4a1:a2c0:7b73 with SMTP id
 5b1f17b1804b1-4a35acaa6c3mr145207195e9.30.1793039543135; Mon, 26 Oct 2026
 11:32:23 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org> <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 26 Oct 2026 11:32:10 -0700
X-Gm-Features: AclHuK_E_LaW5XNIuZY1k1mQOjBZJvvQ1cVrvsfMHmbvxMe_yR0Z_CAYp1s13eU
Message-ID: <CAKEwX=NJfyZMgC1trXKnr3G_PMau+j5wqMxBty6QtHCyMdmYrg@mail.gmail.com>
Subject: Re: [PATCH 06/16] mm/shmem: hold off eviction in shmem_writeout()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Gregory Price <gourry@gourry.net>, 
	Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Stevens <stevensd@chromium.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:41=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> Once shmem_writeout() has moved the folio from the page cache to the
> swap cache, the folio lock no longer keeps the inode alive: truncation
> and eviction find a swap entry, free it and do not wait for anybody.
> That did not matter as long as swap_writeout() was the last thing the
> function did.  But since it puts the folio back when swap_writeout()
> returns AOP_WRITEPAGE_ACTIVATE, it uses the mapping and the inode
> afterwards:
>
>   reclaim                               last close of an unlinked file
>   shmem_writeout()
>     shmem_delete_from_page_cache()
>     swap_writeout()
>       zswap_store() fails               shmem_evict_inode()
>       writeback is disabled               shmem_truncate_range()
>       return AOP_WRITEPAGE_ACTIVATE         shmem_free_swap()
>                                         destroy_inode()
>                                         ... RCU grace period, freed
>     shmem_add_to_page_cache(mapping)
>       xas_lock_irq()            <- use after free

Yikes on a bike yeah I think this race is definitely possible. Good catch.

>
> swap_writeout() behaves that way if zswap is enabled, cannot take the
> folio and the memcg or one of its ancestors has memory.zswap.writeback
> set to 0.

Acked. It just takes some incompressible pages to trigger this with
memory.zswap.writeback=3D0.

>
> shmem_unuse() already added infrastructure to deal with that.
> Reuse info->stop_eviction to protect the inode during writeout. Increment
> it before removing the folio from the page cache, and decrement it after
> swap_writeout() and any attempted reinsertion and inode accounting.
> In shmem_evict_inode(), wait for the counter to reach zero even if
> swapoff has already removed the inode from the swap list. Add some helper=
s
> to make the code easier to digest.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: 6344a6d9ce13 ("mm/shmem: writeout free swap if swap_writeout() rea=
ctivates")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: code cleanups; improve description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM from (z)swap perspective.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
