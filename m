Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED336E495
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641226; cv=none; b=pWZI4bQx+4kRrTP6GsybiLDrhTAHu1eZtdcKY5VlYb5Gn2Do5ZzuSF+LFlNqnVqr2hSK9M0E/yfLRSdDOfdJ4+8GLfZfwFrxdRfxPPoxbZK9m//1HkEnOGrtp6QmDi8pEWqmYKDCK/A9Edhkg9OSPONHcqBbiGGxORjaRTl7pzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641226; c=relaxed/simple;
	bh=Hm96/DXpJkXjSNGuUzX/OuEFvS8gRRl0SWjmUCj1iBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1zK2w/D/M7rk+CwHymvA0mf88JHIHFDYHI1yhBBhuiRoZa9JUQns+CVAYZjqHRujQ5zydhuAivqdvbZYh172Qer6eN0SBbYqCSvKXVxBLXF7+ra5eXXFE0UvT/HTYEa0UKyE6qCVb8zXiRdA+AGNPQFC/h/TYVLOrp0EjmQCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDmBmQ58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDmBmQ58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472031F00AC4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641225;
	bh=CdJj5nKqEObBB1xkwyRi/zaKZ4Wn7rvGnIYm7xgOmmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IDmBmQ58clmBlLaJI3oGiupJG7807RCv0Je6/sewvX5+psSowjwboZS7z0twCZO7y
	 svGL0LYfACfLTT7pbbWO1c6HzBRo8hhJmUXhNeqEUrilfG4Jt+2AmjoQTjjrsNAFS4
	 7SRFo7TdQrSsiE4kJdW4fhfMK2v5ku4MHMCyFrT6Z6a+5iIPw6FVrodFboa0i8JdRA
	 +3q4KmNksBFzvKyt4Oc+w6op4eBruO+049kmcTZRgfL0YTHeH25nsZHagI0+9vwZkj
	 DSks8iCyezNZA+qchJwRYM1RWkwN7W8N/Iu1bKwP3k14Q5WGNm3sn5jl04U0T3RMrw
	 3uqt0nv0D5Jhg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so17690522a12.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:40:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZO66AgtKFc5WjCXpfNcOPBRFOXwAm/imCh2K2so0uGuMhlq+jXIxMn91KzCZOSGJ3bx2AZ60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGkdjmrJqaRtrA7/KTRSvxNFCubf0mVuD5oFrlmSOdzZ4rXHF
	2ZGX2lTxatJRs0q837u0q6m1lCMKJluJGGIRFCvlqgpc2jlCB4BBSenYGkxU5ZmhBsIqgKCMG4A
	OvSa/0lnQhcVYW2sDT8jSlTc0VGJE834=
X-Received: by 2002:a17:907:72cd:b0:c16:3187:997e with SMTP id
 a640c23a62f3a-c16b46ade61mr722490666b.7.1784641223892; Tue, 21 Jul 2026
 06:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4EAAF864-52A2-429F-A7F1-46228DDE6884@nozominetworks.com>
In-Reply-To: <4EAAF864-52A2-429F-A7F1-46228DDE6884@nozominetworks.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Jul 2026 22:40:11 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8UG2iEWppy=LWH=1x3iTybqKg6XRjQLv7tyaagDOYnQA@mail.gmail.com>
X-Gm-Features: AUfX_mw7kg5Yh_oMLiKw7uaHvjgvVHhpl6vGb6wp8elarrcqQEFVCWkj8T_U6us
Message-ID: <CAKYAXd8UG2iEWppy=LWH=1x3iTybqKg6XRjQLv7tyaagDOYnQA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()
To: =?UTF-8?Q?Alexandro_Cal=C3=B2?= <alexandro.calo@nozominetworks.com>
Cc: "hyc.lee@gmail.com" <hyc.lee@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 7:52=E2=80=AFPM Alexandro Cal=C3=B2
<alexandro.calo@nozominetworks.com> wrote:
>
> From: Alexandro Calo <alexandro.calo@nozominetworks.com>
> Date: Fri, 17 Jul 2026 12:14:51 +0200
> Subject: [PATCH v2] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_=
ib()
>
> ntfs_ir_to_ib copies all entries from index_root into a freshly allocated
> index_block_size-byte buffer without verifying that the entries fit in th=
e
> available space. The entries in index_root may be larger than the usable
> entry space in the index block.
>
> This can cause OOB writes past the end of the allocation.
>
> The validator ntfs_index_root_inconsistent() checks that entries are
> self-consistent within the IR value, but never cross-checks them against
> index_block_size. There is no bounds check in ntfs_ir_to_ib() before the
> memcpy.
>
> Fixing this at the sink in ntfs_ir_to_ib() since
> ntfs_index_root_inconsistent() validates the logical consistency of
> index_root as a structure and a root with large entries is a structurally
> valid root. The bug is a size conflict of ntfs_ir_to_ib().
> Also, the validator is called once per inode load in
> ntfs_read_locked_inode() while ntfs_ir_to_ib() is only called during a
> reparent, a check there adds no overhead to the common path.
> Moreover, even a future call path that bypasses the validator would still
> be protected.
>
> With NULL as first parameter of ntfs_error(), the volume error flag is
> never set by this call, so the device name will be absent from the error
> message. In any case, that the caller, ntfs_ir_reparent(), prints an erro=
r
> message that includes the device name on NULL returns.
> I think this is the best solution available without adding
> 'struct super_block *sb' as a parameter to ntfs_ir_to_ib().
>
> This heap out-of-bounds write is triggered by a crafted filesystem image,
> which is not in the kernel threat model, anyway, fixing memory errors wou=
ld
> be nice to keep  things secure.
>
> Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
Applied it to #ntfs-next.
Thanks!
