Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021079;
	b=HkiNgt1yVFNLUTO8FguFKv1LY6XdwkeEnHYtXapoFwywPVdPZbajYnqVPSsUYLgYKvYR
	 jIpV41ImtO0LEa7QUtF+9FCWXqZidWK+z5j6QuO4HOHuX/Lj6Zlvm5URUGlhTbGgi2sxr
	 gCcqHc5TAx0eyM+WXjEc1nxseHIoJXvXUy1eBPyuNv/FW4IWxOvpilp4qlXzBd8uv3kbu
	 p5nHn3QEBj8YtNAXjZ5bk34Cq7mC1XLkDlw35nPdiegsSIVuzgJng3jfZleCjXacRU8go
	 T9v7p8wPG07camEOyrDRAcmLQ4A1uV1p3i+NK6JC4K6HGEPAQUB2VQL6Lou2KMzMgIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1akx8mxhc3uRZxvnnRf5cLwnJZH5AVzhLNQJJ8zSIso=;
	b=mSyrouM48CQ3VrEsSiIM+xpdGAj2aoZxoN2pumy01MYgSHlihuZerc+nAN0+2DuHQb7n
	 zK4zKi9zh8WFKbnCt+fuwh0f70dOQA2ZrUB/czUzZQPldC+veNm7LxjfJ/3cVkSLf6s8y
	 kpRzqOPg40h1Ma5+Ey/XHmhHsI0vWe899+upnkhhV46zaZbh5yMZDQpXcyp1mwtCUy5VV
	 5KBPhxk2z79lkBlYmdATj2Zh9B1orMdZqjzE9OqptUL9QAC0OYHs+PiG3IRtUw96b2ZHy
	 lIkiifLPOGsSkKx1capR8uihwmV6liHWrm5DiV8dUjcrWFqzRAOptF8ESBChuYuyCtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ev8YhY/T";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DC606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 354DC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ev8YhY/T
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso3906445a12.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793021077; cv=none;
        d=google.com; s=arc-20260327;
        b=H9CqPbV0Gu06GHt4gWwS1S1jVdSsIpLZBYN6Ck1jCMObOiuaZcLLHgfImhckgB2/KC
         ajRBkojs9cejag9nIVX5IqOPHL4WWmjcYDhdPj6dF2v6N0TtRiuLHhMF5bcGkIo9o/8n
         Bvi40fV5wdQ5TUUmuz+2CHWAMZcPW0ZOEkS9KBD2nPLGGIubhkImp5mqtxFu5muT0hGf
         pV3saDJYVLGFOuoq4zZk07hf/3QZaoGkyys3DbU8FPnHx0a4EcPosVBKXmKIheLuPO5G
         crVhwQ3baUqXx4aetPs8q8lEBwbNKnHHFe3ai61SQqvOtEhEuJ4EeSYX0tH7GdHHi3lH
         14Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1akx8mxhc3uRZxvnnRf5cLwnJZH5AVzhLNQJJ8zSIso=;
        fh=J/YQqCkPoMmJ1HGRA/6jGMh11gWXktvGdiNgbV6kuk4=;
        b=Giab69ySkPFplhXC5lLCvcLqPFkRTXKVUKPrMI5Rug5YUXqiu1yXUduG0IxPdJ/chE
         gWVUC7EybkyIgl06T99xkm3YHdVLBrMIEeOWu2CjRUJyP+ZL7Uj6aPQ2zITm0PBD+AqS
         29M/v0J+Q2nPt55bZQ7Mz6to3+sYKO4wb7eOZPxKDsp9DqgtxtnI3u47fpUbuK+Jz6Bv
         XYl5TpHYYy7JzWADq9kmPktYbBJ+xTOTXMPedwJv4b510f0oQoHokSZPI3YBax0iLAv+
         3XmcCW2zwGUFM/3iV2BQyYqX40UFmePZ/K1UXgHFXGQO313IgVfVwTHXqIGrcViDYb1X
         aNkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021077; x=1793625877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1akx8mxhc3uRZxvnnRf5cLwnJZH5AVzhLNQJJ8zSIso=;
        b=ev8YhY/T7Dlotkv6Muhfu6/Yvd6Gc0QOlpwg1/DLQHPioU3vGXLeUcaaoEibk3kKug
         R4NTJPIVcwxHZ7cYv5QSN2VoaF0SsfBAnPj/yF1CGXFKmD/Sg7R8NxaHjBAfmvaI+Oir
         QT5fH6Ldwd1c1zvoJtde7ipTAVx4sugNBfexBNG9+YcPdHyV8uL3evJG1CEHUiEGPrvQ
         6W58fPs4cgPTsqPBYuyfqB7Ow/73mr2weD2IHlB4bebxRBO9JzoSfvGGSWck8ZlfRu60
         l/RYlhy1N2Rtm57HTJnFVIgHeW74DlpIcO6Gk0sz70nx8Fa3zQrIUicSPsfvWJgoW/cS
         GwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021077; x=1793625877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1akx8mxhc3uRZxvnnRf5cLwnJZH5AVzhLNQJJ8zSIso=;
        b=Zj3wTclwlHRFij6OMkkIOr+RdhUc+bq24PAm6GEGEaWnhJIyvVrhxAolS/zJtkJlos
         Z/E2SeNVCXq4zpA2Q7hJRI2XDJgpwrg8gV4ciKOYNcDS/E9apGs+md4RfDLm7FdKI7I0
         3MiSlm6qDRjoHxH85UM3vrpuLIZwnuifpTmfqnSaIGdKEsDVe/Vea75C6BJAUpTfUHJx
         Ixm7+VEL9rQMERqtTzTCMNOBwoXNiVICIJob5DN7TfBvq5k1+3vhRp2J+4sGM+sAiw7w
         EYWT1XvyblHvK6oHskOLiLp8P2TLNqonQmRufbv86feSSMsytXlbRBX6/xTWQRaqF5mE
         aOog==
X-Forwarded-Encrypted: i=1; AKwUvBwLYmDpZmindbBfskOhlMvZQtgRavfKF2fGq5OdNYvNZYwmmghjW9vOz/7NNJFOUr5RzC7aOkg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvsmv1WRZptwMCeOjlAY/gIim774kFsJJlcEcOSUfM/FuLO1hj
	5lInORwtCFxuT+bqOGSddMuAcMP1o5uDJrBIQJRzcvTh/9Q8ysIHbj/kbOeX9UPGmiMkbnEE14h
	ne3T1wXBn7xmnv7Tz78byK3tNW6bE8DE=
X-Gm-Gg: AYBFou2e7+Ij52k7dWlcYYIgXm9Q4qGVDQjPRnksU7NpBFC+OjW92tM5c8GJ3maleNS
	QswhYz/K0eiredk3hkiP6DRXGXCqALTZfxMXZzN3b6t7lruBFJBgwV6zMVmKpiOu8FSov8V/WVS
	myOHU/2MBlXWQheLfD0tqA8gATNDctxbiUrdFFeDfw++kvqc60P1eEAwg6acC1b79ZJ8FB+aeZV
	ldpnz4Z7szobJQkwK/84fYjuuaVuKnldjh4+OLZ3J5GpbP3Ptm9BHb4+9SxlMYjmueAAAD01CrL
	P78dF3NezKJCmVzTFJ2G/XN8zQdSvZ05Dmt5pINj9neq4ADA02xbfZ09+rcmoIz/9XHrsKMdJJP
	p06e3iVJWde/qnIWK/QjgnEi01OTLUh7hh0694jPaArJcWakc6KoGeT/l2JdOXQHVzx42Xw==
X-Received: by 2002:a17:907:3e07:b0:c27:420b:7c79 with SMTP id
 a640c23a62f3a-c46bdec7fa6mr869390566b.48.1793021077106; Mon, 26 Oct 2026
 06:24:37 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 26 Oct 2026 21:23:59 +0800
X-Gm-Features: AclHuK_NnGMoCvEgkVlwGinh-S4Fg9jmm7mGH3lQNtt4b6ijBwpE8tzVis4U-Rg
Message-ID: <CAMgjq7B19MT6t3-BisvQ_V8xoxkZyQXHXNH457UT98kwzVMGKg@mail.gmail.com>
Subject: Re: [PATCH 00/16] mm/shmem: various (urgent?) fixes
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Hugh Dickins <hughd@google.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Stevens <stevensd@chromium.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:44=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> Hi,
>
> the fixing fun continues.
>
> This is a handful of fixes for shmem/tmpfs. I sneaked in a related
> hugetlb fix that stalled upstream.
>
> Some of the stuff is more urgent (patch #1, F_SEAL_EXEC, truncation
> hangs), others are less urgent but still rather unpleasant.
>
> The majority are fixes from Anthropic that I cleaned up or reworked.
> While doing that, I found a bunch of other issues and tried to fix them
> somewhat cleanly.
>
> In general, shmem + swap handling is a nightmare. shmem_undo_range() is
> such utter garbage it makes me want to cry. I mean, really, WTF did we
> end up creating there. Does any expert here have time to clean that up an=
d
> make it *actually* maintainable.

I had a nightmare understanding what is going on there when I was
trying to fix a few swap related bug... :P, and hesitated to clean it
up... I think we will have a cleaner codebase on this part soon as
Baolin is working on this.

> The following things are still broken in shmem_undo_range():
>
> (1) Truncate/punch of a single page of a large swap-error marker
>
> We don't split. Consequently, read access afterwards will still fail
> instead of returning 0s.
>
> I have a fix to try to split (which can fail), but I don't consider it
> that urgent, really. So I'm not including it. Might send it later
> separately.
>
> Truncate/punch of a partial page can obviously never do the right thing,
> as we cannot poison parts of pages ...
>
> (2) Truncate/punch whole pages within part of a large swap entry
>
> We try to read the entry, but if we are out of memory that might fail.
> Consequently, we will not free up swap space and a re-read will not give
> us 0s but the previous content.
>
> AI proposed a nasty NOFAIL patch which has too many nasty side effects
> IMHO (allowing users to force-read pages and retain them afterwards even
> though memory.max would disallow it). This needs a proper thought. Likely=
,
> support for splitting large swap entries (and large folios in the
> swapcache, which I recall is under development  by Kairui). But splitting
> can fail ...

Right, will post something on that swap cache splitting part soon,
what I found tricky afterward is lazy reclaim of swap cache so I think
a bit further clean up of THP splitting is needed first for better
swap cache splitting.

For shmem side, we don't have to swap in at all when truncating
page-sized holes for large swap entry. There is nothing complex from
swap side, just lock the cluster, then put/free these sub-entries, and
everything is good. It has to do a swapin for shmem right now just to
make the shmem part easier to reuse the folio entry split code and
better synchronize, IIUC. Nothing is blocking this except that we
better cleanup for the large shmem entry splitting code too?

> (3) Truncate/punch of a part of a base-page swap entry
>
> We obviously have to read the page in, in order to 0-out the parts to
> discard. That might obviously fail.
>
> Maybe we should install swapin-error markers if swapping during
> truncate/punchhole fails, to at least tell user space on later access
> that something went wrong? We might affect unrelated data, outside the
> requested range, though. Anyhow, these are long standing issues and
> I don't consider them urgent.
>
> They need a proper solution.

This part is tricky though... perhaps swap side needs to provide some
helpers to trim sub-page sized content on the backend (not sure). If
that's too complex maybe limiting the trim window to just 1 page a
time won't be too ugly?
