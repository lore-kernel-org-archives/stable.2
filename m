Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C228315D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136941; cv=none; b=p6GLRJe5RWbgaFfgbc5+nsnZDFE+rKIOdZUERnM7FDnaA1b+B13BJNG//ChLM+1x364V8NV9eOia+2R1JoQzCXvanBcCzUVJDj730WBOaBdWQUZmACl+72xvEYlTmu3TweC/mHXfQy+ATOzACivSAsb4RT5diXx+OZ2C5KsZwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136941; c=relaxed/simple;
	bh=3Qw2fs21wkrwzl7ChAiP2vCNWpZweRNdpO1p4tzob7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPqyGwew1LmklTuxkCghnRJDpcC/ZAbxCGN37mcI8XmDhFI3otJxzxqooheiaDVm+GHXDGU5N3dvXjEmxG0qqrzpW2CaFOkyF6JhY8m2XW80gRKqHnkuHxQ63py6KMzjeQ0sHwIMXdqLSM5MzqLdf1av0txQhTD7GF7jtksp/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3UdL8Ff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3UdL8Ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F6D1F00A3F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 00:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788136939;
	bh=cwLD5MPaM5wEPEiG4IYB203rR0WWLqJ94Gf1v2xping=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n3UdL8Ff7vYSPKFZghKggZzq0vJRXALq9Dd7AhjCvJ24p9VsMoZN6WO98qE2SqwEI
	 cbYsrjB8hEDBqyNkU/raMT/hw5YKlTYaF88j7Rwhr059KJHGVW9FDDJXWhvFAQyJcX
	 1ZJDQt2tfOuwPMwY7wyo+/ni/Ny9htNVxr7/XUS0sVytyIU7uHIiJiR+FVHZNg8t1N
	 D4CUZhHQV12XBlNPaP/z5x/rfPK6ziWTHHxSCYYD4vgB/V8N9PwqNgeObkCn9KNpFk
	 MrInbiRlLnOU814Fpx8gF7v4Rz3KUuvkVncKfunzus1KXaiWwGYygJTDf2cF/ZsqPt
	 kKKxRk/JQZzdw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so1136256a12.2
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 17:42:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzkZMcF3mVbfUc9HNdzqjmkU1nswBXVfmYTfzFvR6ct1JQB2GN6X+w85kDP2f6lVoQd/IGcUus=@vger.kernel.org
X-Gm-Message-State: AFuF++nPmk9N3W0ryBj4uU55oMJFoszGhb0xEzzRK2afKlo+7Vw9JrIf
	465QFlT24IEfqA30wTZdMcUzH5jhmQNWoKxm6RPeRrn6Hm9R9bofIF5WwhRK7NGMbEnVxFtO8mE
	QD01YAn35K+b2PcA69kejNKY0uSse4us=
X-Received: by 2002:a05:6402:5055:b0:6a6:32fa:cac with SMTP id
 4fb4d7f45d1cf-6a632fa0d07mr6252464a12.17.1788136938260; Sun, 30 Aug 2026
 17:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828231211.252093-1-pc@manguebit.org> <CAKYAXd_cR_WAd-3iRW_KJRmSBKxNiSuGvjNXXk33pG3Z_2dBvA@mail.gmail.com>
 <ff527b2379048e28e0b2e66abdeb1aba@manguebit.org>
In-Reply-To: <ff527b2379048e28e0b2e66abdeb1aba@manguebit.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 31 Aug 2026 09:42:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9V-WCNVzs3gOrQ8cPjAvpLUv65t4tub8jQuOqo9diZJA@mail.gmail.com>
X-Gm-Features: AcwNN1X_X_OiN_At6RLiKHEGZ7PMCZKvvLGQTPCi4abYeLmXEsP_wL_myo1NJ7g
Message-ID: <CAKYAXd9V-WCNVzs3gOrQ8cPjAvpLUv65t4tub8jQuOqo9diZJA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix data corruption with concurrent writes
 and O_TRUNC
To: Paulo Alcantara <pc@manguebit.org>
Cc: linux-cifs@vger.kernel.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 1:43=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> Namjae Jeon <linkinjeon@kernel.org> writes:
>
> > Should we also take filemap_invalidate_lock_shared() in the
> > page_mkwrite path to serialize mmap writes with this truncate path?
>
> I don't think so.  It's serialised by the folio lock that
> netfs_page_mkwrite() and truncate_inode_pages() take.  Also, if a new
> writable page was added between the first unmap and
> truncate_inode_pages(), or if a new page is about to be become writable,
> both paths should go through filemap_fault(), which takes
> invalidate_lock shared, so they will both serialise with invalidate_lock
> exclusive in cifs_do_truncate().
Agreed.
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
