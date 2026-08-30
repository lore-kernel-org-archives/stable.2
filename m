Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BE386C0D
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078932; cv=none; b=BQT/bQNQ26TNGHUUEzvpsqjeR3xC0r5066RW/aHpre6JZVUaiojpJCmYCQetzm7VI8KMvmykps2pRkSZlR/YF4ZRzCWdlHKF1jenHhJWXN1iQTp3aTs4ESJ/1iys3xevu0IlGTw9lt0WWsMDQZjiYKw5tFyzx6GkAf0zPncz80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078932; c=relaxed/simple;
	bh=IwKC9arFrlo3osqzy7dK3GG/SZuNnbG9cEDyBvv53bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbplPGX8WZXApIDt6F5AaZRy8BEHzQsJyOig7lr6AteChn1zwNzZMXfPcOlAqAsCi9DAToJ32orLmny+IGQejVIGkrG8inFW1KH5mEM4PVqvmuTH8nxHe8iYr5TVHUbbHZg26yxZBGcyV5USM/4m0/Yir1ojzGoh312Llz0sSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8fTlafw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8fTlafw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C641F00A3E
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788078930;
	bh=B/BZcM1Q1yyTiL+u2PtZ1N/UUsr6bDlHImpT2ZOZlfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b8fTlafwH6UFDyGONtyr6rUiXpbbUs62Tm16Rs0gt+kRY7v3OA9AGiyfZnTd+xXwa
	 KYt8tuSu3Icc6epTbfaWFqWfSD98F2MKVe1P47wRi2daLxQd54NMxTsoQYXtO/PKCP
	 aK38K/JkKZOnRUvOELHQt+JlxgSayPDc16QZ/vYz1+2X8EocqN64ewOt+FwLF44haX
	 ydIfae8uixrpGQfOOE6eJg2yT3Rih0K4Lxd7ifB9J0SNy8sJUa5KlhsY7XnyX+vC0z
	 8nZnKmmVxiD/hXAgkEIwn5PJ8y8HAGM3rhNj5NeTlWFw6BD9JsEV4ktJnftU43/PKD
	 3ymWwIbIAbOjw==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930f618435cso179577085a.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 01:35:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rom3PaMsEt0Fxoy9aPUHR56lXNdjy3bnIM5oZYLsDf8ebCV0I4ZTXCkRdnpZ0YTYzXO5rjAHY0=@vger.kernel.org
X-Gm-Message-State: AFuF++kvRRwm2zhgI8LMDpyHr+nwtshdD/WimFjY0Dju8RdAWbcoQgFe
	6ANb3L1UAW9KZaptK+OkdJcSNRuWslWYdVX080ksaT5AAgguPvGh8Al7MyvFoQAtFK+H8cWO8mz
	ae5KYbgF5bPAznnzyn93ZyS4oPv48xa4=
X-Received: by 2002:a05:620a:40cb:b0:936:cda7:554d with SMTP id
 af79cd13be357-93913798773mr2019122985a.14.1788078930311; Sun, 30 Aug 2026
 01:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org> <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
In-Reply-To: <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 30 Aug 2026 16:35:19 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wpUBOXKd8aGNz76U+87bwDUXZZFSW2UhNcq4qpjVvggQ@mail.gmail.com>
X-Gm-Features: AcwNN1XKAv-WpIMNo6BgbyKwLX6-0pyA1HhQGvJzilWFR4BrtIbEJ34mKKdkwmc
Message-ID: <CAGsJ_4wpUBOXKd8aGNz76U+87bwDUXZZFSW2UhNcq4qpjVvggQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Wenjie Qi <qwjhust@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, axboe@kernel.dk, 
	trond.myklebust@hammerspace.com, tz2294@columbia.edu, jaegeuk@kernel.org, 
	chao@kernel.org, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 11:25=E2=80=AFAM Wenjie Qi <qwjhust@gmail.com> wrot=
e:
>
> From: Wenjie Qi <qiwenjie@xiaomi.com>
>
> Fault-around can map ready dropbehind folios without going through the
> normal page-cache lookup that clears dropbehind. A mapping represents a
> competing cached user, but writeback completion can currently unmap that
> folio. A later mmap access must then fault it back in.

Andrew is asking for a visible user-facing impact. I think the current
mainline code might result in an extra fault-in and extra I/O. Maybe we
should highlight this?
On the other hand, my gut feeling is that this patch might only be
50% right, rather than 100% right.
Fault-around might just end up mapping data that will never be accessed
at all (fault-around mappings aren't really fault-mapped), while the user
has explicitly requested "dropbehind", which seems like a strong hint
that they don't need it :-)

>
> Retain mapped folios instead. For a mapped folio,
> folio_unmap_invalidate() can call unmap_mapping_folio(), which takes
> i_mmap_rwsem and may sleep. Retaining the folio also avoids this path whe=
n
> folio_end_dropbehind() runs in non-preemptible task context.
>

I'm not quite sure this can be entirely avoided. Somehow,
`folio_launder(mapping, folio)` could also be nasty. For example, NFS
can still be problematic today:

static int nfs_launder_folio(struct folio *folio)
{
        struct inode *inode =3D folio->mapping->host;
        int ret;

        dfprintk(PAGECACHE, "NFS: launder_folio(%llu, %llu)\n",
                inode->i_ino, folio_pos(folio));

        folio_wait_private_2(folio); /* [DEPRECATED] */
        ret =3D nfs_wb_folio(inode, folio);
        trace_nfs_launder_folio_done(inode, folio_pos(folio),
                        folio_size(folio), ret);
        return ret;
}

Best Regards
Barry
