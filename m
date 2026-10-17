Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD643BB115
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205688; cv=pass; b=iNKFno01l2dgOoYMhIzhtyJVa0Rbr7wT07lAB0TFopOI47JUTvcOODb0A4sCFjNJAMwsxPe5pRRkgt/Z8Om26n+Fs9A0NQW1+N03vrsJeilCbTB945Ik8XTmk8yERQ473kKJxXZvxyXWvS7yjTQ4E0JKAZappMV+LznvXFqh3Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205688; c=relaxed/simple;
	bh=2uiIxEIBsEEs1GxvTDbYzaqwXFqrGRoYUmVr/Ubqges=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTrbGz67PrM1n7Nz3Sj2wqR5ulA3biqH7nuXYy2jRx938LdBbVMdis5wYDTfakMMZ1CUCeCe3VdUls1vF7cnuJ6fLlw3dD+kt8FgxJzylreS2BhCrJdsCD8I3TLqivRYH/XjfqGcONCzHluyQlY2WzMpZAzCRaL9vlkRXOh527I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml8A85dx; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml8A85dx"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67990a45e02so503274d50.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 19:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792205678; cv=none;
        d=google.com; s=arc-20260327;
        b=KAcRcTpDgV2sC3pQ/Y1b2p97FufwwxSSnTE7lNOiriwFm1ZvmB0UALUvwSC65tbX9D
         wijiXk4G5iw9PwCKJUGJMTEiJ5dxEl4aF+GR0XfoJXCkmHidx2wSgy8wy71lOTfWpAad
         AXawu7Wb76hhcL+e7wV2HImPoWU1j2kT2hfkE28zY6+D/2iNS72spYy2Y5rgestg7vIg
         PxY/56wY1MOZVqycs5MbOSwPuzqpXxwtKXfS/M9SEY35acas32UxIYU8gU6ImjJf4YvE
         sCyQ/1R/2ZqG9U4GMzXh8IWPqBA/VC41eFxspBA8jGldYqKcLpJgFY04aK2/eP16WqcU
         m+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfkSXPo0dNMIKT2KF2ALOes0/DMCq2j0ggg+m5sbD2Y=;
        fh=K8VuEHXIwzFn44Y0fCw3g3g9IiD92OO2KI+2PaSJ4hs=;
        b=o27aNNQHs15GILDFZ9C8pEmNWe2ZYUPzXnLeVKyLjh4C6ui5tf6fwXGUU8DgZWL5lw
         0jYXaORafo9UFQyHQMJwQccsggsetmOm+TDzhdyq6dnxppAMxdRNsQbEj2jwW0dDSd19
         +XaWFamA/oyJfreuttGzlK3QfUwwxod1XsbYHProFfXZsPU155bVRdcI2SuDK+ySU/iZ
         IyxCZ8gbDiwBI5AQt8swfEburK3AYEaKO2hzvMXrcpaVYoVDhJqMTnhnoIsC+DEISISo
         taHFyhoI3vpXjqfOcUSEAv0QrcLVN4SPYXWyCyRHcbZD+q2X5oCUQ6P0FBFadLZX1l/t
         Kf1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792205678; x=1792810478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wfkSXPo0dNMIKT2KF2ALOes0/DMCq2j0ggg+m5sbD2Y=;
        b=Ml8A85dxb+tL4GD/645SwzIN066h2Sp8+GLgMumfciGD8C83NCzzOP+PVeHsr3myPZ
         UrPw5njT+wqXCtlWvVNDt8epkyrHyerjDsIRaw6T5y4uj7fJGzxVGNqyH4hganeThxbs
         QFvm1Pw2cRimx/H4ISWVRhTQW7JEJKWeHYgOcc+A36u1CVlLCxG5DGH1dMPbpiqK+NYi
         D4rsd3cO21H2lO+sSTVmw35XFXtML45907GbZOyLyGT4aaJmolc7poE9FT9tMDKWbUwB
         fABm8dzWoO+GBpStpwVbBc1yFHEuY9DtVuLlGJyF02Dsy+JcEz7tqKMH4ih32CYqhg34
         KWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792205678; x=1792810478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfkSXPo0dNMIKT2KF2ALOes0/DMCq2j0ggg+m5sbD2Y=;
        b=V/rEqkWmPKczhh+BMsnJkqynFOXcS0WHxEExNT6JTkCfWnPffYI1+SBiO5VTmBlkJQ
         GKGzrs0cMMPaXmzrajmbWbTJQ6G7YV685GbDzftXOqXvpG+d7hmQxZuKalsav1M3Yb4k
         1nHL2ajBlfiXPfcP4VM7yRNuFMPHUXbuTQFtTjuPE3ZvW/FquoB4y+/SNcbYeDbtKant
         o8zxbU+DQ9fxsvSFRrlL+VMuzkjgOiSPVndvg2W4kXDe1FLHnLijYORtFDVP5A669RaE
         zPA2t58gYIEPooRNiEGID76hnyIGkrq3PeqlmwLj3cvkDzyoFdqH50DwrRW1NoEDxfyX
         IopA==
X-Forwarded-Encrypted: i=1; AKwUvBwqLHLVKCn7Jy8xDxpsIoHSzeKfuwbqvD0p6ntpEE7K6wIVowxBsg6CBgKIzvmRz91eorO3OYM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/4PBoj2TLQybNet67BtqdXqY8aNvm7YGaf2eZb8u0l8Cn1OuR
	tFw0XEAIhhEkwkWhQyALt1EtiOKcPk/Nmalr4ytvAXp3r0SD3Vx3ivsaFNy+T6DXTq7O/5FN95g
	DGPlWQTID+1+u8i7pO63/OO9rm0HVplc=
X-Gm-Gg: AYBFou2ddL22hgwWXz31aEhfRqYSBI69DhncoTnA8FSrVr0PUCNZzVGM6/pVZwhGe/5
	hiTqMQPFO/j8r0Z6N2cg1XiJGborS5+r6evJyXb8T4ARkTHs/AEsllFC2eOH1mOJwEfG1oeQ8dX
	QZ6+tLxl+/h+vfaMVY4knvYO2m6RPr3TgDK2XTmkJgyVH1ISK34fiMLGW9kRmSQdfkXE5iFOdHP
	U9soYkSCVw1ploMyyvGXZUNAELAPXWkHfMPemz/hb9sMhqOU8+Ohqx3jnLe2rUCcTkDat4kOZFl
	0HMxoNLrMaHJ4Xko8PM7BUJXddDZApS5lUA3ZakMkVdio/GgjugWNLj7BCp4bdzWb0Mfj/kFpPu
	a5qwZL9+Byg==
X-Received: by 2002:a05:690e:13cb:b0:677:c075:a57a with SMTP id
 956f58d0204a3-679ca9222aamr399271d50.108.1792205678498; Fri, 16 Oct 2026
 19:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-topic-attr-list-lock-v6-v7-0-2f35e0a38bfb@gmail.com>
In-Reply-To: <20260812-topic-attr-list-lock-v6-v7-0-2f35e0a38bfb@gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 17 Oct 2026 10:54:27 +0800
X-Gm-Features: AclHuK8omokjBD3xPayNXNpHAYjQNY3Btile2rC-o-ompk6JR7nrDrlOQ3WYVQM
Message-ID: <CAFRLqsX+4mzD5t1-1OgWg5K3nQPAY_T24uJHpH853mChUpOkYw@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] ntfs: serialize attribute-list access
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev, 
	Copilot <223556219+Copilot@users.noreply.github.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunchul,

Hyunchul Lee <hyc.lee@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=89 09:18=E5=86=99=E9=81=93=EF=BC=9A
>
> ntfs_external_attr_find() walks base_ni->attr_list using raw
> attr_list_entry pointers stored in ctx->al_entry. Because other paths
> can replace base_ni->attr_list and free the old buffer while a lookup
> still holds one of those cursors, a concurrent attribute-list mutation
> can turn a saved cursor into a stale or freed pointer.
>
> Reported in:
>   https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.co=
m/
>
> This series fixes that hazard by replacing the raw ctx->al_entry
> pointer with restartable, generation-checked locators, and by adding
> locks that serialize attribute-list buffer replacement and on-disk
> persistence so concurrent mutations cannot corrupt state or double-free
> memory.
>
> The four patches are:
>
>   1. ntfs: replace raw ctx->al_entry with restartable attr-list locators
>   2. ntfs: protect attribute-list buffer replacement with
>      attr_list_persist_lock
>   3. ntfs: protect attribute-list creation/teardown with
>      attr_list_persist_lock
>   4. ntfs: protect mapping-pairs attr-list updates with
>      attr_list_persist_lock
>
> What changes
> ------------
>
> Instead of a raw struct attr_list_entry *, the search context now
> carries three value-only locators:
>
>   - al_cursor  -- where ntfs_external_attr_find() resumes enumeration;
>                   invalidated on generation mismatch.
>   - al_insert  -- insertion point captured on -ENOENT lookups.
>   - al_exact   -- immutable identity snapshot (type, lowest_vcn,
>                   mft_reference, instance, name length) used by writers
>                   to re-locate the same ALE after a buffer replacement.
>
> The inode gains attr_list_lock, an rwsem that protects the live buffer,
> its size and generation, and in-place ALE changes. Readers hold it
> only while dereferencing the buffer; writers hold it while replacing the
> buffer or changing an ALE, then increment the generation. Pointers into
> the buffer never survive an unlock, and the rwsem is dropped before
> persistence or an operation that can take runlist.lock or extent_lock.
>
> attr_list_persist_lock is a non-recursive mutex that serializes a
> mutation through persistence and rollback, including list creation and
> teardown. ntfs_attrlist_update_locked() writes the live buffer without
> attr_list_lock, so the caller holds this mutex from mutation through the
> write. It also stabilizes the buffer while attaching extents. When both
> locks are needed, take attr_list_persist_lock first. Creation owns the
> mutex itself, so callers must create first and then restart; re-entrant
> teardown uses persist_locked instead of recursively acquiring it.
>
> ---
> * Changes in v7:
>   * Patch 3: serialize non-$ATTRIBUTE_LIST removal with concurrent
>     attribute-list creation.
>   * Patch 3: initialize successful removal results and release
>     attr_list_persist_lock on every early creation error.
> * Changes in v6:
>   * Patch 2: initialize new_al before an early error path can reach its
>     cleanup, fixing an x86_64 allmodconfig Clang build warning.
> * Changes in v5:
>   * Patch 3: keep each in-place ALE update and its persist in one
>     transaction. This fixes the Patch 2 review: a record move could
>     update an ALE while persistence copied the same buffer.
>   * Patch 3: serialize attribute-list creation, teardown, and extent
>     attachment.
>   * Patch 4: acquire the mutex unconditionally for mapping-pairs updates =
to
>     close the attribute-list creation TOCTOU; drop it before creating a
>     missing list and restart afterward to avoid self-deadlock.
> * Changes in v4:
>   * Patch 1: fix attr-list lock/unlock and uninitialized locator on
>     the AT_END path
>   * Patch 2: hold attr_list_persist_lock around all
>     ntfs_attrlist_update() callers and recheck the attribute-list
>     state after locking
>   * Patch 4: avoid self-deadlock rebuilding $ATTRIBUTE_LIST's own
>     mapping pairs
> * Changes in v3:
>   * Patch 1: fix $ATTRIBUTE_LIST extent double-delivery during
>     mapping-pairs rebuild (xfstests generic/040)
>   * Patch 3: fix self-deadlock on attr_list_persist_lock during
>     attr-list rebuild (xfstests generic/040)
> * Changes in v2:
>   * add Fixes tags
>   * add Reported-by and Tested-by tags
>
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
>
> ---
> Hyunchul Lee (4):
>       ntfs: replace raw ctx->al_entry with restartable attr-list locators
>       ntfs: protect attribute-list buffer replacement with attr_list_pers=
ist_lock
>       ntfs: protect attribute-list creation/teardown with attr_list_persi=
st_lock
>       ntfs: protect mapping-pairs attr-list updates with attr_list_persis=
t_lock
>
>  fs/ntfs/attrib.c   | 568 ++++++++++++++++++++++++++++++++++++++++++++---=
------
>  fs/ntfs/attrib.h   |  48 ++++-
>  fs/ntfs/attrlist.c | 181 +++++++++++++----
>  fs/ntfs/attrlist.h |   3 +-
>  fs/ntfs/index.c    |  26 ++-
>  fs/ntfs/inode.c    | 116 ++++++++---
>  fs/ntfs/inode.h    |  10 +
>  fs/ntfs/namei.c    |   2 +-
>  fs/ntfs/super.c    |   2 +-
>  9 files changed, 795 insertions(+), 161 deletions(-)
> ---
> base-commit: 5c244a0e9ca95468f4c2087b2c9269825429a13f
> change-id: 20260727-topic-attr-list-lock-v6-f1a909e3c859
>
> Best regards,
> --
> Thanks,
> Hyunchul
>

Just checking if there is any update on the v7 series, or if the issue has
been resolved otherwise.

Thanks again.

Best regards,
Cen Zhang
