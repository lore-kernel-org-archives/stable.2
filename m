Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5794503B
	for <stable@vger.kernel.org>; Sat, 30 May 2026 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100565; cv=none; b=U/BpTwnlVgUUw+NT5R6ieoRMwumBw64BmpOvYk1ZlyDsK2LR9jJb1mjo3o70plvsxBVs5dwj0bh0dYOMVuz+VYXvNAG+meeKlW0DkT9HoBogE3+fW8yvutgd6tEDIDWIVRBOLCglQ/cieIfd4apnkuCIjTZPeOsSTkBX835t8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100565; c=relaxed/simple;
	bh=8UyBXunVORwyFAeCGNEosx4B5o1VMPzUiKqBUSRgptM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2wbrFQ3UocWV9OX6R849n6+rFc2wNTXMeZR07d1i6vnFWlk52PaDiVQLQt6WmD6s+8ThlU0xIDg0qW/+uo9t+8npb5Q7Y3eke8hULYYezPtZ9WY3P5dStfu6lXO1FkNf9XcIvLVZjaaJ0kBJzlmbVQA4/GdknpttIx3xtQ8xd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICMuddAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICMuddAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124721F00898
	for <stable@vger.kernel.org>; Sat, 30 May 2026 00:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100564;
	bh=qTvlcYmXUnPPdFg13OSmYZVLRKsK9qVPME5WNKCdi9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ICMuddAAK8pmUMu0C9RJAjOlTupWRS7o0lbih7wdaiWkOXZo45/4/5GPZ8z2fbTj5
	 ++r79zIWc06I4g1ajRCILvx+SPQC1afoeZlPXM1qxKr3IZIqqMktUX+aZmrPO5Npv8
	 3K5Q39ubtGO+UpJFXafy/k9Ye+xh76+worCjQTUyE52XT+wecIq4BpuTI35pKh10jI
	 3zyWp/5Kgfk3bFriZSq1FlpAzUN5AZuzNc24pSwLTKzoYr/M+n7cUUtE28c/vALI6x
	 y6wjixDcp1dgqDYSsQdNmmuN2HQSfVXgIaqSlcx9r1/IGafXQloZPQwPVtGsXnbViY
	 6aKqX2FYZM78Q==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so2609074466b.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 17:22:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+nUXoc9Iwp3EgvUUm7BuCJveiC4lqpWeT3yUUXNpkxHJxzXiDjN1qH+qg3SrCDmmC8m+JNQXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dU1kTUUshOqGbuRzyU7sJzj9q/DKBEPkZuy+R1Z+EWJ903V3
	FnNU78Pgb6K1+5aGIXydwUcQulpfaDVHKXIRf8rmPu3alZkS3UF+a1GJ+G5SaoZMvpBLcb+tPLw
	Z8B3V5eCQgIEwVRTWfdbi1Fj9zvImVIA=
X-Received: by 2002:a17:907:960e:b0:be5:57ff:cd4 with SMTP id
 a640c23a62f3a-beab0cd2aeemr102470266b.1.1780100562822; Fri, 29 May 2026
 17:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB63162D8FEE0B2F486C14888E810B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <20260528142137.49121-1-rochan.avlur@gmail.com>
In-Reply-To: <20260528142137.49121-1-rochan.avlur@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 30 May 2026 09:22:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8k4QOpsxAU7gGjuwFHJeGUCR4rYPm7xUMeL35ki0cCUg@mail.gmail.com>
X-Gm-Features: AVHnY4L1Mp4-8_exfY9rMPgRGXSIalvJ4B5oIxzTPAV3NKjmeJ-gbk9bBuZwrTg
Message-ID: <CAKYAXd8k4QOpsxAU7gGjuwFHJeGUCR4rYPm7xUMeL35ki0cCUg@mail.gmail.com>
Subject: Re: [PATCH v5] exfat: preserve benign secondary entries during rename
 and move
To: Rochan Avlur <rochan.avlur@gmail.com>
Cc: yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org, 
	rochan.avlur@skydio.com, sj1557.seo@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:22=E2=80=AFPM Rochan Avlur <rochan.avlur@gmail.c=
om> wrote:
>
> Commit 8258ef28001a ("exfat: handle unreconized benign secondary
> entries") added cluster freeing for benign secondary entries inside
> exfat_remove_entries().  However, exfat_remove_entries() is also called
> from the rename and move paths (exfat_rename_file and exfat_move_file),
> where the old entry set is being relocated rather than deleted.  This
> causes benign secondary entries such as vendor extension entries to be
> silently destroyed on rename or cross-directory move, violating the
> exFAT spec requirement (section 8.2) that implementations preserve
> unrecognized benign secondary entries.
>
> Fix this by adding a free_benign parameter to exfat_remove_entries()
> so callers can suppress cluster freeing during relocation, and
> extending exfat_init_ext_entry() to copy trailing benign secondary
> entries from the old entry set into the new one internally.  Also
> clean up the error paths to delete newly allocated entries on failure.
>
> Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries"=
)
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR9=
2dufS=3Dem9DW5Kzsrpu3iQg@mail.gmail.com/
> Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!
