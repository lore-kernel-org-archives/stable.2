Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2201A7264
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896204; cv=none; b=mR/RdRMcU9xaTAuSZtQWuwq+bmsiFf5CxcY0n6uIlOfBPcHgAf6sXigps5zDjM+5/JF9B7X6TgYnyDIhO5oNJl/9j75V2arTfXi7+55iZvXx8nx3mJRYbz13s0hPZpXXjtUcWXVYA+oteEX2y/Sm8ytXoHSD49d07fA5bQNvbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896204; c=relaxed/simple;
	bh=zMYTyrf3I15Js8ygcd8tyjsEvwoH+054x9RksQFizRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QADbxpYouQq7UgQvaFD84k6x4pLKnpAc0gwf0bpHFFGgV3moP3j3Q8dhXrlf168/EYg3dv1L0Z9uHi3K3RaMzljqvEr0oHrko+ViHOOH21wiOOszyOFwjogAEBlVI7SL8TOHiSeqjNG6i9FEHultLEjNlt+y+udH5gDErSF8Ie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsl0g0qk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsl0g0qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54121F00899
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791896203;
	bh=+j2J0y/28lU7ye3epBMxr5hc7VlERZW/96Am70/hEbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Lsl0g0qkhifHY4hcobeDlfkAJUDfavHEJ7gPbi4+tDk5EQ0Ca7JiMYrJzKTTgIO/I
	 PacIinj90q68JEqrV0aRWbFZBgm9I4uv+4Qp+sp0kKDnQ89xIBMZsI5tYN83TJblEZ
	 nIdmhnmH9E2q3b5ci8FN4uDJ9jL37YdQCmxWJAMlbL/pRtF5g8lSB3bJv3RtmswBcC
	 aMowhkxpyX9hUzEC6N4+5g+cpAcq1wM9kYvysW0Z2qkzXLnec8u2FGXJ2H/VKSJI4k
	 rbNEd2kbQ7z9tNFeXi6161B/B4jIsx8D7omKt9IQmk208sS7ij1oCHnJyJqYNmzazt
	 6noLAGrcycqIQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e6df2742cso444871866b.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:56:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzYa5Yv+52Ba1vOKoBsSLC2R50ruZUxAY3Fg/Sf9+NfCsnuggs5/qAWHDoYObWOU7rQJq4KrKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKExT4Koc4QzSENDikeGZMAV0DUFXZIHNzHsQVk3hBRulPrBpdA
	GFVU+nIu/hwpxNOErxi80WRJzMAjkcA17zlEW+Bxy6vzEeaZ2OHGBlOwWAt+hP2aWbh4ETUUAmX
	6kpunZA14gjfqywfVOFFxNEmfsi+zlCE=
X-Received: by 2002:a17:907:7ba3:b0:c29:f5d5:5aa1 with SMTP id
 a640c23a62f3a-c31aa097acdmr1256017766b.43.1791896202356; Tue, 13 Oct 2026
 05:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012094046.2592731-1-hengyul@cs.unc.edu>
In-Reply-To: <20261012094046.2592731-1-hengyul@cs.unc.edu>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 13 Oct 2026 21:56:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9V3oL8J+D3a9N0g-aTeOOVH+K56PDatCfPqgjkiMRMNA@mail.gmail.com>
X-Gm-Features: AclHuK_YGwXl2gvJJzwsbFHh9MWmEy7xISbD5IppmTPVkWDT6pcKFrpr8MeVnCw
Message-ID: <CAKYAXd9V3oL8J+D3a9N0g-aTeOOVH+K56PDatCfPqgjkiMRMNA@mail.gmail.com>
Subject: Re: [PATCH] exfat: free clusters beyond EOF when a write fails or is short
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, exfat@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:41=E2=80=AFPM Hengyu Liang <hengyul@cs.unc.edu> w=
rote:
>
> Commit 82a81a7352bc ("exfat: add iomap buffered I/O support") and commit
> 867b9c96dc83 ("exfat: add iomap direct I/O support") made a write
> allocate the clusters for its whole range in one step. They also dropped
> exfat_write_failed(), which freed the clusters beyond the end of the
> file after a failed or short write.
>
> However, a write can stop early, for example when the process is killed
> or when a part of the buffer cannot be read. As of now, the clusters for
> the part that was not written stay allocated beyond the end of the file.
> exfat_cont_expand() does not expect them, so a later write or truncate
> that extends the file fails with ENOSPC. The directory entry records
> only the size of the file, so the space can be lost for good once the
> volume is unmounted.
>
> The issue can be reproduced on a 64M volume made by mkfs.exfat and
> mounted on /mnt, with a write of 1M from a buffer that has only its
> first 4K mapped:
>
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <sys/mman.h>
>     #include <sys/stat.h>
>     #include <unistd.h>
>
>     int main(void)
>     {
>             char *p =3D mmap(NULL, 8192, PROT_READ | PROT_WRITE,
>                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>             int fd =3D open("/mnt/f", O_CREAT | O_WRONLY, 0644);
>             struct stat st;
>
>             munmap(p + 4096, 4096);
>             printf("write: %zd\n", write(fd, p, 1 << 20));
>             fstat(fd, &st);
>             printf("blocks: %ld\n", (long)st.st_blocks);
>             printf("ftruncate: %d\n", ftruncate(fd, 1 << 16));
>             return 0;
>     }
>
> Before commit 82a81a7352bc ("exfat: add iomap buffered I/O support"),
> the result is:
>
>     write: 4096
>     blocks: 8
>     ftruncate: 0
>
> After that commit, the result is:
>
>     write: 4096
>     blocks: 2048
>     ftruncate: -1
>
> This patch will bring back exfat_write_failed() and call it when a write
> ends before the end of its range, so that the clusters beyond the end of
> the file are freed again. It waits for direct I/O in flight first, as
> exfat_setattr() does before it frees clusters.
>
> Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
> Fixes: 867b9c96dc83 ("exfat: add iomap direct I/O support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
Applied it to #exfat-next.
Thanks!
