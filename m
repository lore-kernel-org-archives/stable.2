Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583543;
	b=goX9R6h1clD9ApRiNA9lEJzh07MwoTcRPChJIkKfl04yLcdk/Oft9pqmVkjaBvpPyx9F
	 gqECmprLNiee66eV+6QoaFOG+DdvwvLONZuCyQ8mAo/r6h5slYYeq1iRRz7lnD2HktrVQ
	 ystOrDOnbb1Sg8wAbGzYfF6yeikg/ccSYcr31uzxQDDedx+uGTs1svOFsaiBEi+aCWsF7
	 Rq59cmsOEvUQcPpJIABxvUy05JOB24358QHq0acJ3TkeLyzB4mUNcekSaSc8tJPXK9ZS+
	 AgzM3tYvgL8ZSuxGUJIBvh2/Zy74EXXSjL3EX4UAFL3MXC7QQ+rVrX7XMvpjnp2rAYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583543;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=IHSZbV5TczZFeFQCvfZv7YXKOzc+c62w1zySB/Eo4/w=;
	b=ZrULyIEHm4smoPGKFvBD4D/RNHqbbLiKl7rLrAGdr4qA2DvNgLC+YX6n7pAHhk9g/bYu
	 34ZCov0hckgKN6SFDjq/QdnzI0+QP4291GKj6mFjKTniMwaaz72xoMlqak2M4W1iuzoWC
	 SB+AGlvXK7KxqpcmFSlaqnyEpY1I3pi5rR0+ty8WoWGj+8HmyAhO1D0mOeoddfnqnsI+S
	 KdfDi2nyNBZdgtgzPuoM2pLJULW9714x0ECKhiK2wh2cFPrJnn/UwAPCPinqE6IkqJDaB
	 +0HgtrmAPJdyadhW6wzbBORwy1nXiYrsq1Zg6KWd4YwJhoJUwzynYBXPSIkriBRtRBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vsw7UmzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547A606A319;
	Wed, 21 Oct 2026 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vsw7UmzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446CE1F000C4;
	Wed, 21 Oct 2026 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583542;
	bh=IHSZbV5TczZFeFQCvfZv7YXKOzc+c62w1zySB/Eo4/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vsw7UmzMynG64z7oivvLQHL35z+zjmfkxTrRacwPNkDuXo4ottYyEXch1vuEKK0HQ
	 fflEeNEad3F/koeaQSBrNN4Z6dsWpTO6NZDf5548tPvNz05xWY2Sy0CQ8+y2e678Al
	 /88FRc9MfCw3FD477G5ZV10Azcbw1LSgILy7W69+BTv6Ii0HEV9780Y924s6NdgN6Q
	 Pa3jt9YQwA6aAGX7FjCKc5TCliAxMvgTvKEstzYQwILCCbyUmps7ahoKAjvmd6zstc
	 TDn4JGFb4ZA3/w3MR2R9xbj9YHVcZpRA1eisDHaKrUWqNJu5JNpkDqLpDks1uaVwrv
	 W9dIXGIb1es3w==
Message-ID: <d75565c427f8d4d1a77897fbafa0abea77d0fced.camel@kernel.org>
Subject: Re: [PATCH 1/6] statmount: don't copy the reserved empty string
 past the buffer
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, shaos <shawnq1@163.com>,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Wed, 21 Oct 2026 07:52:20 -0400
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-1-8917a4c1bd14@kernel.org>
References: 
	<20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
	 <20261021-work-mount-statmount_listns_fixes-v1-1-8917a4c1bd14@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 13:46 +0200, Christian Brauner wrote:
> statmount_string() reserves an empty string at the start of the seq
> buffer before it calls the handler for the requested string. That's
> what the offsets of unset strings point to since commit e52e97f09fb6
> ("statmount: let unset strings be empty").
>=20
> If the handler emits nothing the early return from commit 75ead69a7173
> ("fs: don't let statmount return empty strings") skips the size check
> against the caller's buffer. Back then an empty emission meant an empty
> seq buffer and there was nothing to copy. Now the reserved NUL byte is
> there and copy_statmount_to_user() copies it to buf + sizeof(struct
> statmount) no matter how small bufsize is.
>=20
> So request a string that may turn out empty with a buffer that's
> smaller than struct statmount and the kernel writes one zero byte past
> the caller's buffer and reports a size that's larger than the buffer.
> STATMOUNT_MNT_UIDMAP or STATMOUNT_MNT_GIDMAP on a mount that isn't
> idmapped will do, so will STATMOUNT_FS_SUBTYPE on anything but fuse or
> STATMOUNT_OPT_ARRAY on a filesystem without ->show_options(). None of
> this needs privileges. The byte only lands in the caller's own address
> space but that's still not ok.
>=20
> prepare_kstatmount() already refuses a buffer of exactly sizeof(struct
> statmount) for string requests. A smaller buffer can't hold a string
> either and it can't even hold the reserved empty string. So refuse any
> buffer that isn't larger than the fixed part. That's also what the uapi
> header says: string requests need space after the fixed part of the
> structure.
>=20
> Reproducer, unprivileged, on any mount that isn't idmapped:
>=20
>     #define _GNU_SOURCE
>     #include <errno.h>
>     #include <fcntl.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <string.h>
>     #include <sys/mman.h>
>     #include <sys/syscall.h>
>     #include <unistd.h>
>     #define STATMOUNT_FS_SUBTYPE	0x00000100U
>     #define STATMOUNT_MNT_UIDMAP	0x00002000U
>     #define STATX_MNT_ID_UNIQUE	0x00004000U
>     #define SM_SIZE			512 /* sizeof(struct statmount) */
>     struct mnt_id_req {
>     	uint32_t size, mnt_ns_fd;
>     	uint64_t mnt_id, param, mnt_ns_id;
>     };
>     static uint64_t root_mnt_id(void)
>     {
>     	unsigned char stx[256]; /* struct statx, stx_mnt_id at offset 144 */
>     	uint64_t id;
>     	if (syscall(__NR_statx, AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, stx))
>     		_exit(1);
>     	memcpy(&id, stx + 144, sizeof(id));
>     	return id;
>     }
>     static void probe(uint64_t mnt_id, uint64_t mask, int guard)
>     {
>     	struct mnt_id_req req =3D {
>     		.size =3D sizeof(req), .mnt_id =3D mnt_id, .param =3D mask,
>     	};
>     	long page =3D sysconf(_SC_PAGESIZE);
>     	unsigned char *map, *buf;
>     	uint32_t size;
>     	long ret;
>     	map =3D mmap(NULL, 2 * page, PROT_READ | PROT_WRITE,
>     		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>     	memset(map, 0xaa, 2 * page);
>     	/* 100 byte buffer ending right at the page boundary */
>     	buf =3D map + page - 100;
>     	if (guard)
>     		mprotect(map + page, page, PROT_NONE);
>     	errno =3D 0;
>     	ret =3D syscall(__NR_statmount, &req, buf, 100, 0);
>     	printf("mask 0x%04llx%s: ret %ld errno %d", (unsigned long long)mask=
,
>     	       guard ? " guard page" : "", ret, errno);
>     	if (!guard) {
>     		memcpy(&size, buf, sizeof(size));
>     		printf(", size 0x%x, byte[%d] 0x%02x", size, SM_SIZE,
>     		       buf[SM_SIZE]);
>     	}
>     	printf("\n");
>     	munmap(map, 2 * page);
>     }
>     int main(void)
>     {
>     	uint64_t id =3D root_mnt_id();
>     	probe(id, STATMOUNT_MNT_UIDMAP, 0);
>     	probe(id, STATMOUNT_FS_SUBTYPE, 0);
>     	probe(id, STATMOUNT_MNT_UIDMAP, 1);
>     	return 0;
>     }
>=20
> Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM, the
> same on a distro 7.1.13:
>=20
>     mask 0x2000: ret 0 errno 0, size 0x65, byte[512] 0x00
>     mask 0x0100: ret 0 errno 0, size 0x65, byte[512] 0x00
>     mask 0x2000 guard page: ret -1 errno 14
>=20
> After:
>=20
>     mask 0x2000: ret -1 errno 75, size 0xaaaaaaaa, byte[512] 0xaa
>     mask 0x0100: ret -1 errno 75, size 0xaaaaaaaa, byte[512] 0xaa
>     mask 0x2000 guard page: ret -1 errno 75
>=20
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/r/20261020110747.959829-1-shawnq1@163.com
> Fixes: e52e97f09fb6 ("statmount: let unset strings be empty")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c30f063742f4..6c9c0cdbe890 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6058,7 +6058,8 @@ static int prepare_kstatmount(struct kstatmount *ks=
, struct mnt_id_req *kreq,
>  	ks->bufsize =3D bufsize;
> =20
>  	if (ks->mask & STATMOUNT_STRING_REQ) {
> -		if (bufsize =3D=3D sizeof(ks->sm))
> +		/* Even the reserved empty string needs room past the fixed part. */
> +		if (bufsize <=3D sizeof(ks->sm))
>  			return -EOVERFLOW;
> =20
>  		ks->seq.buf =3D kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
