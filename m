Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F537CD45
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132042; cv=none; b=lDFki8SYRBTqDlADGk8HZTaeehOMTGsbYa7ik28/nmQOt+7Qq85NxUX4+mk0qM3STR0zgHi6ZkO+X33JTEBXCLDw56nAFuhFsj6WVXy7T4Q4Kgb+UmKLhzB9iaBMe6F1YepIb/694XvYBTY7Kf3fmCmn3f+v3/vmT87+9onObts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132042; c=relaxed/simple;
	bh=nMW59yym3IgqRgbFA+MQBGYob6zkxVBDFHp0FrbWD2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEzd2lVYqVtu2mcwQPCe2ZncJICG/LAWkNNrxPQAbH5IvUDGLwRRfrb917E//yQ77lst3hk1BdVzLifjAlmw928y8C3KFXeial48Z2k3iQPt1PJxfLU/nu5swz1+8oIPOi2DphRQs9YDo77vh+CQ7EsgAdIk5o3sgEPzYjBRKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9OjIazF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9OjIazF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC461F00A3F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132040;
	bh=nMW59yym3IgqRgbFA+MQBGYob6zkxVBDFHp0FrbWD2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n9OjIazFhrhRL/RFERBiFsvc2Cok9Yme3Bn/nR7SLnjSbnJCVG4m53krcpDDrZbzb
	 Ne3aSdMCbqMq7oisYqyS72SaruXZNKkE17+RZ2JlZDHhLVDXZbqGYj8iYFuvQjdXYR
	 XBBnzee3dLbTGXNERDGRin4JAIbwgedb7KnpiklHjzwExbHUsCz0SPye4TE/uKl7iV
	 NUrWYlbLRjqn9q8Ugg902aydWRJ8kVdOVRRlwkyEZML8BdBd0LDx8A2AN+4G9OzdSp
	 FLVAi3AZKU1uqftQ4m+WmdQPrRwRp6IIvI4Wvl4pb0T5eZEFQeD9KDqOHwf7/yp/yb
	 N+uNevs5gJrXg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15b1da6b82so79623766b.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 02:34:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrPpNXtk/17SHeqGW8XrROLsgdDvL/AYRkDt2ZKihI56OdHlufS5KPuiF/w9uSKCiw6bIigg1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70v96JutJ8adRzEVWrBJarke4n3KXMfa5UOrYeVHske0eRHCz
	0fYht+R/wWYOiVkdUL3IZHzqOIhQXXsitP0ubb/XhTcl5b4khbHiknRQaEbqvEtNL5SoxlBJUlS
	tEULRC96YxMYk5uKoLmBEnPZ7Te1HBvw=
X-Received: by 2002:a17:907:84b:b0:c20:1c9d:8d4b with SMTP id
 a640c23a62f3a-c23f929e232mr173617566b.2.1787132039434; Wed, 19 Aug 2026
 02:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819-fix-negative-mft-lcn-v2-1-ed9e0d3ee814@gmail.com>
In-Reply-To: <20260819-fix-negative-mft-lcn-v2-1-ed9e0d3ee814@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 19 Aug 2026 18:33:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9vGE3pLjEfamqjr0unkxfyHzySC7nMwRb+xheMOjV7Pw@mail.gmail.com>
X-Gm-Features: AcwNN1XqxfJAxLhq1Q7Z7uXO3O_iVFOxCTsCX-z25CqoMDVMDOUO5YTKSONL8Ag
Message-ID: <CAKYAXd9vGE3pLjEfamqjr0unkxfyHzySC7nMwRb+xheMOjV7Pw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: reject invalid MFT LCNs from boot sector
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, rtm@csail.mit.edu, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:19=E2=80=AFPM Hyunchul Lee <hyc.lee@gmail.com> wr=
ote:
>
> The NTFS boot sector stores the MFT and MFTMirr locations as unsigned
> 64-bit LCNs, but parse_ntfs_boot_sector() decoded them into an s64.
> A crafted high-bit value could therefore become negative and pass
> the existing upper-bound check. The invalid value then propagated into
> the MFT zone allocator and could result in an out-of-bounds access to
> lcn_empty_bits_per_page.
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/all/57514.1787000602@localhost
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
