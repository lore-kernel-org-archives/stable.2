Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795317847;
	b=TpxKmsOLwV1w4aQ1s4XkAC+kuqscp3hhlb5H9/zgq/bMbe+GVZ7gCUfvWO+c66uCyKHy
	 FDbOEuEOoNY/7LR0tjHatbwsE2B8lU7NA3V+fB/qazoblWRb68Z1EGJpsO7N6uwMkwbGU
	 Ha5vjpiDHPVzwFUc5vwKaGIPfWX4mvk3L0ZS0CnTLg4srz2wU3u8w+NTUh1oL6DPhhUkX
	 B5KSgFKCIZRD0BbMmquVqwfSArfs/Oc+V3RtWyMPXZaDSYw8dLGNM6TPQWiQbMXaRule4
	 YjwJ83vX0/54EWz4P7gjYnpHR7R+kktsokhamMeEkfRitPyaSQQF7Q5Y98U92u80cpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FGKxFPn5xySqoyCRzT5dIDYsGVRKkWI39lN3gH5sSKw=;
	b=mKsQjU8ZvhK9jIpnAzOkjzQSobN4K4eOnZZLfiLalvBviuuI3OPJglOMnKDxdejF2MlK
	 lhPzgonfjeAjjkL4Tqj3mVZckxHSAh2U7mQgUaU6epRpoX/41hpOYsNaR7uzQudaA52gk
	 Vt4MnxbHP6ufAFuHPNobzarM4/va7k3Pgg5CkBvWY/El/qZJ8cBbWSkj6TnkFhTloT0Wn
	 r2yqd2J0k7QuToB6NpNnKfsQIma8oe8dgWTCIgXvfJRNvvR7+hHwLTcqnS5CxnjOe54Q/
	 XdHAfXHZwsvPfjQquf9qbo+83Oo3lW+jsUNg7+54ybGOhhJ46EnNRKZdFonr5HVxBIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=etFwDD1P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAA606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BAAA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=etFwDD1P
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533202fe429so206501cf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 19:24:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795317846; cv=none;
        d=google.com; s=arc-20260327;
        b=NniLY3m5upJ3zQu4eVjbEAUNCZshfNTU+J7L5oh6Y0HlJiMvoAVhyAUkBE6KcFWvdj
         BZE5W5XUrxzGlC51FQf7prwxXv0eGyG9/mqqPMMuJR7UF6y8Lwf1cu211TMKH71Q6HaE
         pfBtIyRrEP79jd+swKN2Y4a1CRXV/TbXl4VFmwSm4vPzw2uAIeOshmi8qEGMdm0S/GAy
         Oblgjq93lv27o3loIXa4MpEZtEHopukmuYDSuwtoYi3MySnUnaxXQ3Wv+5C5fE6Maapr
         MKQozoZQXqRPV5D20ENOCL3a79rdQfy2yT6a/3InWJyVHTqqSqCsycsI9bCpcaaCnOmu
         EWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FGKxFPn5xySqoyCRzT5dIDYsGVRKkWI39lN3gH5sSKw=;
        fh=MxxUl2mcWXArGL5ktTlFQaKExxvn/wBDDwnUDkEEABY=;
        b=XcXGAWDhuTnkWjm89IUkvRzoUOLsHAMZTwK28faVbZoSiHgMMTN1IE+K///RMyDKTS
         QQ+LyKXWEOpjIXxldvsIOiD2uBXzniNBej0CUrHP5NTkclbIiQQWuC1kAqEY8n4AzgyK
         Sx720CfFoO5t28fNPt4lyzuEcsZnmvLMdniNOsRNU98g06iIS4dNI44LcY6Zvuzotg1m
         //IWow4T7bBxW1kscIHnaauVO04UcF30ZEzsnzD8lgj1pWI/Ukob0bXx7SISlZ7m6IVI
         4euT9ivZXHzGi6AEFRGwFFH50di8qVw0RiNIyavAV+goTTYjJcRu/xY1ypayjqG8imTw
         CESg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795317846; x=1795922646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FGKxFPn5xySqoyCRzT5dIDYsGVRKkWI39lN3gH5sSKw=;
        b=etFwDD1PKEeeYU3bo/q+ERuCHCOxo0UKQLdn+bUe44h7MqafCxkAgXIPc1Xa/N83hc
         NiFAeiuxQKyOEo6n3kRh1cMz6xlKQHkCX7oC9B10SPmCFRiHoNE+YzNNP+jOSI70KUGO
         V+lWKXPU5L3pOAPvpIwgtziTtco8jbQuetjx9dZUbhQRufRJhhwPhwpB23RfAnvCKRKf
         GsAoLYJjbYW8o/C3lQcyCU/7RZGm2W2DEMVIULOBXMuUjyWwzVLXzFs6nkvKyNAFLvwE
         9Jjmw7z9uUhprBNq1IkMumXAQ8ZWcd78bEt9kilkbVZT0O2b6Fz0YtZ3Wfq0lpRZ2eF6
         eQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795317846; x=1795922646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGKxFPn5xySqoyCRzT5dIDYsGVRKkWI39lN3gH5sSKw=;
        b=AvTFyNHhUHKuUFwz8JGZvuP4Opg91vwGcQG7xJlfkhvVunJGCqc+x9xABI6e/Wd7Eh
         Xe9n0l/2MnyfEN5CU6d6jasToloL/BriowjKJg8Bh7ax25QgFKPatmR8fWm/iR5ntz90
         6vqb1WKRDsQ6HBtFNWue9a75hHLs/H0hkJFYJDwtl9eZDL95LQeh5dlW+uTJZr108qml
         1OB9TsIgxt1ZQUjTlUm4QvN3dC6ZlwI0yLp2syNesXR3G7NPzgqNiwoO1Zzkt7UGrMwj
         UoEUJRcgyUp5TTO5e/I1umACsJV5OvRY8Bj9BVajT9S/VZUIuUo4jKKjUS+rm29804Xj
         Rakg==
X-Forwarded-Encrypted: i=1; AL+hErF/EKA0lk+A+i0jh4GpJUtmqCTktpY3CeQ8TeF7WuGyLbmzEavEQnshtCn0QeadhMeqxGENBm8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8R6WFBges2Oyo0VzCZnphkfL8BvYVhdRtz/MsMXWax4ZVcmYl
	+MgtWgt91QU0M1mF3OoerMBW1ngjIuwgDqhk64clL5ypo/YvK3WXkVaAttcK4/KBsVJPrQEXHX4
	YE+hwgiIRnmlv6h+SDSEDNJCG4HPwRphuiXjuDzql
X-Gm-Gg: AZFdTZcYF1BLMt3zq9+6lVMxID/J7j/m6goIHh5nwDEmkbMokcFNZz6KnlDU85qf1Kv
	AI5WRVwRv0cLjqCQpGQEhjSK/DoULD/44CeQQGflobVRRT5WMo8K/Z/Nhn/iMbeYoxnID9gX49p
	EEltAPoiswHEVrepyBzO8Qcd2ny70WMjXdWONVnqrU0monvoAcwW/6had+lN5Vh1IKNoEtDT02F
	ZTwuGWVPuys9vK7KyijYpVrzymMjTsr4i31dUleFGgln0tH9oLeIPRrAxjb4dhLth26P94dKbrD
	YnKZ38zYyH4opaR23jKDsz9LDHIGsC/Xkkpd1NXJF1K8pJ8sEMf+iiRkY8jkYHJgupguZUodJOn
	A2KOCV7vAy+HXhOzehD66CDhQr4bX/rypjZB8hyWZ/rGK6ShimnIFODmyTd/ytjFHFxxJVqw=
X-Received: by 2002:a05:622a:2598:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-55d890363c8mr16483081cf.10.1795317845380; Sat, 21 Nov 2026
 19:24:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org> <20261121-some-more-ai-fixes-v1-2-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-2-236e925d9b64@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 19:23:54 -0800
X-Gm-Features: Aa3M54oyWvj3bs4F65WF6fcW7Mb0TWr88KUK43PO30yLTmdl38G6gNGWPlfj7T8
Message-ID: <CAJuCfpF4fxuAkuqrhkT_Rp3qaUo7+oiC_CrkYMGJcReeJzo1rg@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm/vma: lock VMAs before taking mm_all_locks_mutex
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ollie Wild <aaw@google.com>, 
	Adrian Bunk <bunk@stusta.de>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 8:03=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> If an mmu notifier is registered for an mm while one of its page faults
> sleeps indefinitely under the VMA lock, the registration of mmu
> notifiers for every other mm can hang un-killably.
>
> mm_all_locks_mutex is shared by all mms, so its holder must not wait for
> something that has no bound.
>
> However, mm_take_all_locks() calls vma_start_write() on each VMA with the
> mutex held, and thus waits for the readers of the VMA.
>
> Since commit 4ed4379881aa ("mm: handle shared faults under the VMA lock")=
,
> such a reader can sleep in ->page_mkwrite().
>
> Consider fuse_page_mkwrite(), which sleeps until the FUSE server replies =
to
> a write request:
>
>     mm A, thread 1          mm A, thread 2         mm B
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D
>     lock_vma_under_rcu()
>     fuse_page_mkwrite()
>       folio_wait_writeback()
>                             mm_take_all_locks()
>                               mutex_lock()
>                               vma_start_write()
>                                                    mm_take_all_locks()
>                                                      mutex_lock()
>
> Fix the issue by locking the VMAs before the mutex is taken.
>
> Additionally, make the VMA write lock killable so a fatal signal returns =
as
> quickly as possible.
>
> Finally, update the comments to reflect the change, dropping the lock
> ordering list which begs for bitrot.
>
> Note that the lock order at the top of mm/rmap.c doesn't appear to be rig=
ht
> - the hugetlb locks are taken after the VMA write locks. However, this wa=
s
> already the case, and can be addressed in a follow-up in any case.
>
> Target commit 4ed4379881aa ("mm: handle shared faults under the VMA lock"=
)
> as this is where it became possible for VMA lock readers to sleep in
> ->page_mkwrite().
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 4ed4379881aa ("mm: handle shared faults under the VMA lock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 09bbcdb4971b..f8cf319ff9cf 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2375,15 +2375,10 @@ static void vm_lock_mapping(struct mm_struct *mm,=
 struct address_space *mapping)
>   * mapping->flags avoid to take the same lock twice, if more than one
>   * vma in this mm is backed by the same anon rmap or address_space.
>   *
> - * We take locks in following order, accordingly to comment at beginning
> - * of mm/rmap.c:
> - *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem f=
or
> - *     hugetlb mapping);
> - *   - all vmas marked locked
> - *   - all i_mmap_rwsem locks;
> - *   - all anon_vma->rwseml
> - *
> - * We can take all locks within these types randomly because the VM code
> + * Mark all vmas locked, before taking mm_all_locks_mutex. Then take rem=
aining
> + * locks in the order mandated by the comment at the top of mm/rmap.c.
> + *
> + * We can take locks of the same type in arbitrary order because the VM =
code
>   * doesn't nest them and we protected from parallel mm_take_all_locks() =
by
>   * mm_all_locks_mutex.
>   *
> @@ -2400,20 +2395,24 @@ int mm_take_all_locks(struct mm_struct *mm)
>
>         mmap_assert_write_locked(mm);
>
> -       mutex_lock(&mm_all_locks_mutex);
> -
>         /*
> -        * vma_start_write() does not have a complement in mm_drop_all_lo=
cks()
> -        * because vma_start_write() is always asymmetrical; it marks a V=
MA as
> +        * VMA write locks do not have a complement in mm_drop_all_locks(=
),
> +        * because VMA write locking is always asymmetrical; it marks a V=
MA as
>          * being written to until mmap_write_unlock() or mmap_write_downg=
rade()
>          * is reached.
>          */
>         for_each_vma(vmi, vma) {
> +               int err;
> +
>                 if (signal_pending(current))
> -                       goto out_unlock;
> -               vma_start_write(vma);
> +                       return -EINTR;
> +               err =3D vma_start_write_killable(vma);
> +               if (err)
> +                       return err;
>         }
>
> +       mutex_lock(&mm_all_locks_mutex);
> +
>         vma_iter_init(&vmi, mm, 0);
>         for_each_vma(vmi, vma) {
>                 if (signal_pending(current))
>
> --
> 2.56.0
>
