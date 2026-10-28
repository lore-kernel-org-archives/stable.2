Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207686;
	b=WupvkiiJGLi473+SXC7t5Uh2wbgZr323jY1Qaf6s5x+1JFQaUXucraeFU+D8NrTtJAYm
	 PV5kZ7/TrRgSk/vLmfmBoz6YMFze9HRLZH2IATXG3alqxXUe2Q0DqBq5Bf/+ICWs6tHJY
	 aGJdQgNEFJu16ELJpvsW5Ra27LjldGguxziLOXE7iw7sREp/zpixXZ9FAokCOhxhFZjKp
	 CzGGoj0DXfGRowwVpNRwcfbHtapXczZy/TwlnOu/UlqADa62gkrB0jIGrdnWRkIRDHsQs
	 1xGWNG4I4tlRw5Z1FK89BnnIQrBow+Fyd80HHlOExI8T8X5BEUz4IysGJqA3S13GyPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bpvH8Kp7pKhcNKeWguQojqXnpg5TBg/XvZmMs15zNuc=;
	b=Xp4qBRaJbqp9MUVubftU+d4F8Pr2Y2Ax72FriLQuPkhVB8ZmmIBcQd4/2pBmexc2tBW2
	 CDNA9syZ11D/6ddoUuzp+G9GErgsiy9GeAUFVRVhSuHZYmzSoqoJ5dcXx9k4PIkNGdXWw
	 XSqfgrpqk67JW+YLNgBabhIQuaT7CTQlIPa6XbiRgFKOaCv4fy0eZ3ZYTeMpf36Rw3Q0E
	 VtFKVQ16aTNKPre0+c54Fy541/NsvfTnvzgKenIYKWHJC/tQYQpT2irbQkgL4JMq8UAEo
	 Z9+S3yWkiWQbA6OwtLCH5psWPY6ZWBy42aHuWZv+4z+mV5lNTmTNWpgzmoSRzFl94Og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKONlaE7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F3606A326
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007F3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKONlaE7
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so15474065e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207684; cv=none;
        d=google.com; s=arc-20260327;
        b=i+TXrb7BKLyI4Yuu3XoQbzbl09uMIkT2DM6k37fXdy+Nxnd/v02SO7clJvlYn2U7cs
         +fc/V6I1pHtmEVu9jSGxPdd9hyyAI5HA6P0n4EPdc8I49rCoLW2pFNWCS44F0eP3cCcG
         BuNrflKBkI0VewHZnkC4SR+D/aLz3G8CwgK4kpHyXlug+7/wrA+Cou4DAk+lTGTw3kyV
         A6bVGaXqcZi+3/W1YW/6iL7Wn9b3TyfP0d6zBTDO6KTF/LUsO0+O722pw/40Fg3th1Rp
         bq+K6Mpjd+xQCDtd3mHMpBE6DznG1k3s0DVY28DxLWzsivez21d5xW+kgMe83N9tgkjk
         ohSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bpvH8Kp7pKhcNKeWguQojqXnpg5TBg/XvZmMs15zNuc=;
        fh=vcqRLfGIHw2bW6oOyWI87ngLc1wFfgJhQbWJRDX8es4=;
        b=Zrd9Yd5VxTxp9F2hmdjG/KmRSGVo4TTMV9lDGKiHj44pavMy7GUwXseHFP/pIU0geO
         LbQsa5SSut4riHlnj+TKV5Ek+eOJtGx/Ke7wUHpwNTFLW0/7RusmnlXGg65/NEcm+k/O
         DME0GcWWaJ0T2SP3asHQCLnkuLcpcAsvqXp/7Dep8OAA2gIOydhGw0s6Di2+m476Pr0n
         X+VoSZkL3hfBhrsRm/TMin8Vg9jyDTqEIAcEELyBTFtIUSBqwrpsVvYmERNeICaEKsTe
         E21VoNwBMyo/56brVcPCPLQ9PMrC3EVuUQA11noSzgnQ2aI6QBZfDCvwfsx/NeAQWF9T
         IfDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207684; x=1793812484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bpvH8Kp7pKhcNKeWguQojqXnpg5TBg/XvZmMs15zNuc=;
        b=LKONlaE7wu/J1BUerHw9BiCNiFSpIs9zwdF5AwTU/rsMl5yW4qKHn2tcU9qqyh4RYS
         jzfpU3xM633m40P1YhleWHC0A1PSxmcmQAugbUhUJh0/RCqItljlS6hRMClg3wYH/LeW
         oyn7D7SD9/QlZWffio+hNy/BAu6+I1WKCLfIqM5UowHoMBelZMUQSKMgQ1crNFGo3Kge
         AFUAJ01By1ihkgKfPpFmQ0gTBAyHldBNb6dN+d6jzRH90vyRDmolD5O3BtlxThPpeNQw
         vg22IW1ZcJakoF4yt7ctsEY1bgkTI6NE1/SKUm50QvOHyDcHIN7Gn/zvmGbrLfOxQ8rz
         8w3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207684; x=1793812484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpvH8Kp7pKhcNKeWguQojqXnpg5TBg/XvZmMs15zNuc=;
        b=mhsjcY3/MZ61WBZp3DSM3dvlOmXAaYrXLz2ubOp9Xf7h0KWlRYMnRr31xsJskSRC+j
         gKRNt2S06vWsaGATJPYEWvkUaI08NjG4WjLgOINaRhp1GXhS3ap2Wwak9p2di3JIGrK8
         WMWgy3ia9bspsC9iZibixh526yop2dw3Uu0uHvrr006tVf5KQSbTBkwH/ROAG73JMsiX
         BrYLAa7fyeXvcW+sM77porAuYEfwTq4wzCWzwiti6RF7/r5dBT/20CZda7SjWGJSE1dI
         HL9gEzpcGMHU4FmnnEpjlP6Ln9FFglUNXmU5vZCnI+XRS9JUgynkg0VjZSJaNrHS6UhT
         SdZg==
X-Forwarded-Encrypted: i=1; AKwUvByi20Yw24rdolYGwQjkyhlnxRS3Oj2IeYUoWlcwCsLqYByvlI7XAleYAaZF3/ASNPRwf75zOV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvryiZk58F4r9PYsH7YTZvmuNXRp/vbKJIMrbar7135vokAXza
	djBcGXoWPra1VEFK/u4IXgqwI7moWY/HNu7U/ueAX0s+t74nqsqsyhNFvdUZlzXz+Wr2MySemYj
	3z5dMkg6mYWlqTWpGphtcTosFIfhAV+c=
X-Gm-Gg: AYBFou332M/OvY6PWaEaKGnoEAnIi0bZqoobmRjSK5bTeLPHjd2upn3VwNtn6DNrhPd
	qo9L3Glm/ywBSlvGR0VkgpiXzdW5dlg8Y0/7OCEyAjWuqeR0iZA/aMSGJxlmg+hco+Iz7vmRPhF
	LR45/6weKwioH/6UuoNTBpUAFhMVpJkiTNOeNPj5MHUBNOZ04XHbBchENynt1dRaTd6vRDP9Zj/
	vHu5dvBdqMgigk6Ou434AF/hJNdmI88ItnLvpNsDSBqXtN1+ZKUmhY0x9V/jlJ12nnYczEPa9oK
	9DDbPjVpe16hbbMBkS2UPGA6TjPkCbXTDJKcutEZWpmGl+glS8IPwjyHWJl6e4yRkB7pqoiqtWP
	aXO9UKHI5WxYKWOK3KsS0/SvobhdTyHErtDYv/xNpI4DGnnmL8aLgBqU4j6adW1NeFMUOpdWsBS
	Ja8hhq2ePx4B3dS+CzFEjyNW6XYuDlAGACdkr7wN65bTfrPAowRjqguAYa8gRDStfxZNgk9neKY
	g==
X-Received: by 2002:a05:6000:1842:b0:48d:f02e:f7cc with SMTP id
 ffacd0b85a97d-48e5d599647mr7878806f8f.24.1793207684168; Wed, 28 Oct 2026
 10:14:44 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org> <20261028-fixes_shmem-v3-13-4ce3baf2db4b@kernel.org>
In-Reply-To: <20261028-fixes_shmem-v3-13-4ce3baf2db4b@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 28 Oct 2026 10:14:32 -0700
X-Gm-Features: AclHuK8uGLMeF-yLDH-Azm2VUTE0jqvp7VNoB49he4XaLFESCOLaEk0KKrGGynE
Message-ID: <CAKEwX=OPADynOVEwpn3cui4U2GsP5T9phZQMaJo5xF==Nq_Tow@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] mm/shmem: fix truncate loop after boundary
 swapin failure
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
	stable@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:57=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> If swapping in a large entry at the new EOF fails, shmem_undo_range()
> leaves the entry in place. Its final scan skips the entry, then restarts
> from the same start index and finds it again. Truncation can loop forever
> while holding i_rwsem.
>
> Advance start past the skipped entry so that a restarted scan can finish,
> as we already do for folios that cannot be split.
>
> Note that this does not fix the missing zeroing when boundary swapin fail=
s,
> it merely prevents the endless loop.
>
> Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry=
 split")
> Cc: stable@vger.kernel.org
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
