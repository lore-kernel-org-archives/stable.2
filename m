Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456427;
	b=SajHg047Bj1N9IG27OHbScZgJ6YXBz9Z9EkK8y96RpjxIrhL87d/PGZ+Cj6578rSckKn
	 Ezp47kfDu9Mc9Rei+1DDEZL7abiNV9OIJy0U8XUO8vS+gWm4C1UnqP4LF8dYjgM5533WN
	 tZwRmDlmLNh4DNnqongQ0JZJwOMpNTxxiCA+KWX+X2T9gwTbi2CCLCfUI61NpXqnZkTHU
	 m9etAypk8Cs4M7H8FWBiUw0QEnZLZJHex9J0DSCZJtOIoI4+GWNLGgiDTaBB9cUgj3N3W
	 cmf/O9xh3mRVkQhrijxkXdES/5Wyl3swz6czloH0mycDR5TVJNFUi9R2e5YsrURqB6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
	b=3DA+NVua1ehAZfIMK9a3fn5r+m1zPs23eJOc+wWT60MvuYiEoPycv7lTIGBnjW1+xYZM
	 r/xF1h2Vs8ukWozjddNuk2MNp/AIIPyCiiIZhCJtgRS2DL8LD6AeyIrp7/SixRyHNJIce
	 rJc4J3LTGgN4YT5/vYcY8WXjSKHNCKvnuXsoVWrw261Wo81L2vpTKAZBe9GQpR5niff/q
	 t7xx1WFYvD/mcC6WyTbNwOG0NPaZEqBBnqZsae9YjV9JgZYtNrZvwtvEuY41HymPMtqo3
	 BNTmWdAQb6nZY18lK8tJ7EMKYmFabdS8yNRSAOmfNtRTYqoIXw4R08zcAfh7FqPDh0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kyECElfV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE735606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE735606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kyECElfV
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb845433b8so77665e9.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:53:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795456425; cv=none;
        d=google.com; s=arc-20260327;
        b=UlrDAH0BFbTPMPao6PfNCXg33F/uhQnkWzizIq2i90asF6boDJR2PuvVKT6YgR9gEm
         odMHc7MIdVvIGzcBMWfdEzuGJ1tEVurKK/JNYfDQnvz/78UU7z3oQeE7hza4psSG8d4K
         PN++oi11avkFRfUL0oi0VqkDM0vydzQfogrN0oBCpmGAlO1RahYEb29+ocGdvS7qo6k0
         Ycq/rrV/ryBIjtPOavhiBoiKIQSb04BlU7G9cpId4Gvwqh7Wc7VMVa9YnyrU95+MifK0
         6z1b3DNWkdv/udEkA9CdfGlA2r9QHtqmboayj11Ul5fKnm295ZIaDNNIh9SXBpDrAhRH
         NH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
        fh=hbrnHn1Ski4YrCbaxLfDHW2IA424ST0iq0aNI9PFmSE=;
        b=BjTceP4Z4jJKgmIQ68m+hLSN0Vqn56wezI7VT+jpYinS5l0r2retvjmb9INzaE/EG2
         XUyb250oTPCpmgaZHW89+4qDbdECEz9fTdWlls9cx5Ru2ZzrFbPTUX7qohXRq8Mp0hqq
         7A3IwIReoZfjrJtOgouj0g1R4IfYvEjjs5CLe6OhVGrz6mX4mk1idefKGBq5zLJuoYOp
         9kzstYMVsuhzrtidZfzeaEJzA3uPzBS+4CDebEyH2ePxCJtgPG3KP6mi8qNMObnp9Z3I
         xFUS3ILO5bJxo2WbcfqY8ToLqxz6+/os57OZv4wB6IObBzlK7C37u2VdqSkFOnkzRWEl
         rNJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795456425; x=1796061225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
        b=kyECElfVhqU/U8ppj4LZCw+7b4+EnGazFVt7ghjggT1FnikRfjNerZWMu0lyS6gb1G
         YXHvcPMLMNdkDwdmhd/wUekaBA+hVJY6zfkbb7VFKN2GAY/hYZvP44ZKuJFbBfGaJxI1
         kkfrqLNe+sutCnQM6Gy1gNbxARZ4xTO+nKXLP5CfNtBRWwMnWpWgmt0GMBU2YsE80Fuq
         CtVlS7I47Y3MIf80OYc60ycPQgR9+Il0FG8vq1sg/6rjCv/jJxaIU7I/sSafAcTJwSG7
         HLR0fExZ9V77SZiB4lJ+l9fS20ZvCbmWOgQ+rhM9CVMyBQfbX+0HcytuIrIM+/W7NDRv
         +oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456425; x=1796061225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRZcWU4JooS1Xssmhmit/2z3n2umybpGN0QWpPuhuY4=;
        b=bj899vMJ7at5S3J3ALSWh9x6wob0fKXWqm168uxKKeDFZ7yMVglb/IORPdJ+BDP4HF
         F4ULxW+RDhvRLQp/USC2nov0CxTQnR12yiTT7UgM6zoouWK2paFqjx53xQoKSDoiExBE
         IB+sDPYBeIyR9gqlOpNQKATCXVkRw+y6YbpGgVFdAF7/SeEj8CsU7sFiC40RPmC82IXK
         QzOZtKPkN7DizllETqTSwtSvUxbxYvoq+m8hhjJ92kP8Z3n1oImEGBriNNej4m21O6yG
         BUsbhey6lkxi4TZYur6SuJnlxD6H5fsudhsYQnw3ilMK0DuwzkP1QnDndU4CKDVoLsjp
         g++w==
X-Forwarded-Encrypted: i=1; AL+hErEpKwBWJ6Yu7z8/2IAu39NA6xN7URRMmRgd0iXlfv09bwk/y7bL9qi0GWa4NAkYoTtrOpn02uY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/w9lPBB7SY+k3GSK07QaQvtj90JaHbvi4RZj3UAs76trjoi8TD
	YR0TAlWaY0q/li1JMjqYBmYGd0OE07KmnLLyQEDquRtwfN4i7ioET6ZT0KHLfhwOO/1LGwbRlmc
	ltJa7/8+d5bVAmghpNXtUQ9J9lGKZ33uJfrzs5Wcp
X-Gm-Gg: AZFdTZeRZXDpGEjjHvkSov5ArwTArtsP3/hJqShkDankKKqGnXe1Qrvzk0LplDvShpL
	vPWL1v3t7iCMH7hCu6ndPF6iEIzIHkktyr1sibHgXtz4Xma/iPi5H2kUNUIr5+Kt8mSv/2J/R5Z
	493Pwbt9LPedldApV1BWQvursHPwKjqlel0xTH2R98H7GvifxiznXqoIX6Z0NjVV4fC6Mx5JR7h
	Wakpyfeb5VFV+C1B3TaXs3+CYbFr37qnginbVIB5voVtm5CiOed8erhlLoHeC9QQoymFooa2WGo
	/F2b69KcnLdGWhIBli8SU7bW2tyanzDkIsNL3CvRWbGSij5yboTQ/G76ZpmNQuSQRTvpp0pj5rr
	Z6hcTLdwT3DiiOcW4+41jPnFBEUgliPn5UO3eoMJ6rXWvUY/5SvYIRHmHnA0htZEfYyRbQnWelq
	kX/nBcGFzOlvbMkJDi/gRVzQrj
X-Received: by 2002:a05:600d:6512:10b0:4bb:7ae3:3517 with SMTP id
 5b1f17b1804b1-4bb90bc3163mr1231475e9.4.1795456424900; Mon, 23 Nov 2026
 09:53:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>
In-Reply-To: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 23 Nov 2026 09:53:32 -0800
X-Gm-Features: Aa3M54ob7XYovyBMvNusAZSyIh_lIUnU-OICma0eFsVui65MkMhLZKbHyrFxGng
Message-ID: <CABdmKX0gJbjX89B7Cxerh7AUjP+dJSOm09TmY+Q_AYTge5Ukww@mail.gmail.com>
Subject: Re: [PATCH] kernfs: clear i_nlink before deactivating removed nodes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, driver-core@lists.linux.dev, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Ian Kent <raven@themaw.net>, Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 1:00=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> __kernfs_remove() deactivates the whole subtree first and only clears
> i_nlink on a node's inodes later, once it unlinks the node from its
> parent. In between kernfs_dop_revalidate() already fails for the node,
> so a lookup that runs into one of its cached dentries kills the dentry
> while i_nlink is still 1. For a file of a cgroup that is being removed:
>
>   rmdir("cg")                          stat("cg/cgroup.events")
>   css_clear_dir()
>     __kernfs_remove(cgroup.events)
>       deactivate the node
>                                        kernfs_dop_revalidate() =3D=3D 0
>                                        d_invalidate()
>                                        dput()
>                                          dentry_unlink_inode()
>                                            i_nlink =3D=3D 1, no IN_DELETE=
_SELF
>       kernfs_unlink_sibling()
>       kernfs_clear_inode_nlink()
>         i_nlink =3D=3D 0, but the inode has no dentry left
>
> The inotify watch keeps the inode alive, so nothing ever sends
> IN_DELETE_SELF for it and the watch only goes away once the watcher
> closes the inotify fd.
>
> The window covers everything between the two loops in
> __kernfs_remove(). kernfs_drain() drops kernfs_rwsem and waits for the
> active references and open files of the node, and the clear itself
> waits for kernfs_iattr_rwsem behind every concurrent permission check
> and stat(). In a VM with a few threads stat()ing a cgroup and one of
> its files while the cgroup is removed, IN_DELETE_SELF for the watched
> file got lost in 16 to 33 out of 150 rmdirs, and it didn't show up even
> after dropping the dcache.
>
> So clear i_nlink in the loop that marks the subtree as being removed,
> before a node turns inactive. kernfs_rwsem is held for writing there, so
> no new inode can show up for these nodes while the loop runs, and once
> a node is inactive kernfs_get_inode_locked() refuses to attach one. Two
> overlapping removals may clear the same inode twice, which is fine.
>
> Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
