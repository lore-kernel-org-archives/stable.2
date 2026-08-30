Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C321CC5C
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082320; cv=none; b=n9nl1EIvUVS/XdcAngjAyQQkYVKpvDgJSWxnGJaPLu+FigrwjUvw0Uc2aQwyF1YpyUuuHIV7xQUt3+6N74fx/iDJ6e2sdjjoGpREo7rn/S5wG8q9AhENW8ypDlTLkhSe7zh8SMoh+JaBNb0a4yQWoDlceJre/VN+wSV649BeJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082320; c=relaxed/simple;
	bh=IJcwjYHj17joDlAXtYdSP6DsUc3ZUsKn5ItYemxd9U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYidVrh+vjHSRpKQJVcmnpFgdyTdUGkb+c2gePvnIV5udqF5/Y6eyHIcdytJ2Dr/iTePXy7dyqzqESdyPvHgnhP6N17tdCn/PiKgxVCiQMutSZprzAHZzE0BAyOW4TVyfkvuLGtY5TSt2gExevxiWMVtpcZ4ekYK3AoYsaw9F58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCCv+HHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCCv+HHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4401F00A3F
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788082319;
	bh=nvYs9KqQQiDFu9j18mNGTYlbSQTfBbCYWUQ8jg0y0r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fCCv+HHWayBekTpcF1F3IRCa/NlTMeI0SHFmDk3sJXRVzb5NYiI4k+PAr1AcvyU6Q
	 3YAt1YQIi1PVpovVNd5xSEfN6Hs3lLmAnILDBFG5GfLK7l/7AH5vEjydVEs9gN3H31
	 inOHTmiBDKTyLT3qhRXAt5kJNuny/gM6XkeiTagk8BjJdhm9tnLLBxD113isvnQKnr
	 lJmAWlzKCyuw2jt93bpkuOqmOV3rk3qfIzegw6Vc6J3/XmJ4m856w8qfFeuCWX5a7i
	 M1gX0nk57QVgeyHMTgrl45j5cgRXvMxYPyGVxp9DNHb+JnWzBuBHppIvWBNsfYGxFa
	 BNw2amaBlp1yg==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9371bcf1f8fso159900885a.1
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 02:31:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqwnhCmR96PJdG/ECnKSQfJY4SVzyCtkCf/TmuaxT/JV1/I0LgAqQiVjPp4nN94cB15RL6jJ90=@vger.kernel.org
X-Gm-Message-State: AFuF++lTzqG4/hmRNlKDLT4kb4gdTDyDphcsOqvfI0tCcAe+1wPzt6ij
	fAMekTW2UlRiNJnPmMGUVDTigVQNFXzIpi3LobDekOkfMF0FFiHO7VJfRmC+snzvwXQ8U6TFIaL
	lxe0lfgr2s63O7crE5sJ7XSfUiXyViJ4=
X-Received: by 2002:a05:620a:f04:b0:92e:6a33:7118 with SMTP id
 af79cd13be357-939138df202mr1911249285a.30.1788082318676; Sun, 30 Aug 2026
 02:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
 <CAGsJ_4wpUBOXKd8aGNz76U+87bwDUXZZFSW2UhNcq4qpjVvggQ@mail.gmail.com> <20260830165401.1788080041-1-qwjhust@gmail.com>
In-Reply-To: <20260830165401.1788080041-1-qwjhust@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 30 Aug 2026 17:31:46 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zGN9rqqxoFU66G_PbXqTiDaeV_tUiyr8vbfxFWEJg62Q@mail.gmail.com>
X-Gm-Features: AcwNN1XZPfiog3RD9yg8B0eXNaoAai7OPxYRVCjEpqabBekjMlLKWknwxqjTMg0
Message-ID: <CAGsJ_4zGN9rqqxoFU66G_PbXqTiDaeV_tUiyr8vbfxFWEJg62Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Wenjie Qi <qwjhust@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, axboe@kernel.dk, 
	trond.myklebust@hammerspace.com, tz2294@columbia.edu, jaegeuk@kernel.org, 
	chao@kernel.org, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:13=E2=80=AFPM Wenjie Qi <qwjhust@gmail.com> wrote=
:
>
> Yes.  The current path removes the folio from the page cache, so a later
> mmap access can incur both another fault and I/O.  I should have stated
> that explicitly.
>
> For fault-around neighbors, folio_mapped() cannot distinguish the faultin=
g
> page from a speculative neighbor.  This patch takes the conservative poli=
cy
> that an installed PTE represents a competing cache user and wins over the
> writer's RWF_DONTCACHE hint.  It can therefore retain a speculative neigh=
bor
> which is never accessed.  Distinguishing those cases seems to require
> fault-around to preserve the faulting folio while not mapping, or later
> dropping, dropbehind neighbors.  I think that should be considered as a
> separate follow-up.

Yes. Maybe we can skip mapping neighbors with the dropbehind flag in
fault-around.

>
> For folio_launder(), filemap_end_dropbehind() holds the folio lock and re=
turns
> if the folio is dirty or under writeback before calling
> folio_unmap_invalidate().  folio_launder() also immediately returns for a
> clean folio.  I do not see how nfs_launder_folio() is reached from this
> completion path unless the locked, unmapped folio can become dirty betwee=
n
> those checks.  Is there a path I am missing?

You are probably right. I was referring to the bit wait in
nfs_launder_folio(), though I'm not quite sure whether this can
actually happen:
folio_wait_private_2(folio); /* [DEPRECATED] */

I assume we won't wait for `private_2` while the folio is clean. If so,
it should be fine.
