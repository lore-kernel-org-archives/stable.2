Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583227;
	b=KRD8N3iDe7hbhyuBibP/hzdjOv9a0uhSyw9SQzR8qEZ5rel5GalcLwjcPXcDk5xKWv0a
	 F+C88b4E9RJP5OkInSIFIQJVqDQ4ZCpoI5VPCI13YousLsxs8TmU5nQ0MZ5Ihe1OOdUkA
	 T4CFcEWWM8Nhe1/Vs1i8FBRxi4DHEEUt5u4Xnw/6PCFsUjg2PsdubVU5gbrw1zLqSuZAO
	 nfaxgezWJ5wNMnws3uIIji1b77u3DRR94qM8feyBW5LUj+KSTlXrggrmIP7YG9ntyasN8
	 4Ol/E46i85CztjNFx/+65wARyFFsSsGzcs0BkghUcLpShGg2E7NtizBmm0Xgy4u0gPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583227;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=41Sz2ACg6iRei1NKXbN6VfJjDTLu6Oiy8mmaBWF22dQ=;
	b=3lDFLSeJDHOhxkvkxU3GhsqeK4SU6T44jyUh5Quxzxp27wvYuXJmTD3ne9Eioud7QiR/
	 gKPiaIAjqthHBwpxn1xTpxy2yugKfQKX8m6zmnMuaLxkJ7vAykU7viKT75gC/+1XgOA80
	 5HszQMvI/C0sGwUV4M+nOqPVTabQ8iQC6IPHGH5cG9ECes0V2LPwLJxViacVsxbNawTds
	 TImB9Wmb7ayYMuFCJH08NfOrd0gqalKgf03NcBOEtFlrgOIYgBqqwb41icLsfkH8t2B/Q
	 0Xnv/lr4dUB8hPyrWg8/WaxOyrT9GqduNN+ucn+ds2YtlBVkBM0cOZ2tv4tl/gXoJNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTkSyIon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3C606A336;
	Wed, 21 Oct 2026 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTkSyIon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D401F000C4;
	Wed, 21 Oct 2026 11:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583227;
	bh=41Sz2ACg6iRei1NKXbN6VfJjDTLu6Oiy8mmaBWF22dQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GTkSyIonGXM9RGg6BbcFRihGpjKkrI6J/WT6JB7MpAghCm5xznYutNy7wZKuKByoP
	 Cc2wo1jGVuhxQdO/9+7Las1lm1Kqm3lNro5ut9q5PWcyuugIw5rlOhAmDuf38iQv9K
	 iVhVukLoKjCwcoBGTvkUsj40uSGmtHvEXhEVjtLkhdvizD4I5UCLF23uPsZ4YCoC+l
	 QscR3bkUNwBeTFCrP0YpK37Ju4lKKjs+lS8hPv5PIrDTCPi8DFGQVbeWaJoUdvQqhQ
	 +xsJkpjznUXQupqChDSQlpY5GHBiS/t7PVzzzdDXncbUXSIhw2XSktEGzXkqJ8ACC7
	 Cs1zMDl+1V1kQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Oct 2026 13:46:54 +0200
Subject: [PATCH 1/6] statmount: don't copy the reserved empty string past
 the buffer
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-work-mount-statmount_listns_fixes-v1-1-8917a4c1bd14@kernel.org>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5000; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AHQAFfLWnKTl7ZT8W/RhRdf0RxeTfvtVkb+ZuwU2MNo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWGY8Z/tHOedft8vnsxq1mrxcevpNZEfK43KBI5PjY
 gN3Ktg1dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk01FGhuNsinFRa1leKu05
 W7023ep/cKWv/XVdtrDUn9t4t6dIxDP84ek6yXD3Q/XhZ3bPf63L0ryWcLVF51TNMfkVu/ck/lz
 zjxUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

statmount_string() reserves an empty string at the start of the seq
buffer before it calls the handler for the requested string. That's
what the offsets of unset strings point to since commit e52e97f09fb6
("statmount: let unset strings be empty").

If the handler emits nothing the early return from commit 75ead69a7173
("fs: don't let statmount return empty strings") skips the size check
against the caller's buffer. Back then an empty emission meant an empty
seq buffer and there was nothing to copy. Now the reserved NUL byte is
there and copy_statmount_to_user() copies it to buf + sizeof(struct
statmount) no matter how small bufsize is.

So request a string that may turn out empty with a buffer that's
smaller than struct statmount and the kernel writes one zero byte past
the caller's buffer and reports a size that's larger than the buffer.
STATMOUNT_MNT_UIDMAP or STATMOUNT_MNT_GIDMAP on a mount that isn't
idmapped will do, so will STATMOUNT_FS_SUBTYPE on anything but fuse or
STATMOUNT_OPT_ARRAY on a filesystem without ->show_options(). None of
this needs privileges. The byte only lands in the caller's own address
space but that's still not ok.

prepare_kstatmount() already refuses a buffer of exactly sizeof(struct
statmount) for string requests. A smaller buffer can't hold a string
either and it can't even hold the reserved empty string. So refuse any
buffer that isn't larger than the fixed part. That's also what the uapi
header says: string requests need space after the fixed part of the
structure.

Reproducer, unprivileged, on any mount that isn't idmapped:

    #define _GNU_SOURCE
    #include <errno.h>
    #include <fcntl.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <string.h>
    #include <sys/mman.h>
    #include <sys/syscall.h>
    #include <unistd.h>
    #define STATMOUNT_FS_SUBTYPE	0x00000100U
    #define STATMOUNT_MNT_UIDMAP	0x00002000U
    #define STATX_MNT_ID_UNIQUE	0x00004000U
    #define SM_SIZE			512 /* sizeof(struct statmount) */
    struct mnt_id_req {
    	uint32_t size, mnt_ns_fd;
    	uint64_t mnt_id, param, mnt_ns_id;
    };
    static uint64_t root_mnt_id(void)
    {
    	unsigned char stx[256]; /* struct statx, stx_mnt_id at offset 144 */
    	uint64_t id;
    	if (syscall(__NR_statx, AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, stx))
    		_exit(1);
    	memcpy(&id, stx + 144, sizeof(id));
    	return id;
    }
    static void probe(uint64_t mnt_id, uint64_t mask, int guard)
    {
    	struct mnt_id_req req = {
    		.size = sizeof(req), .mnt_id = mnt_id, .param = mask,
    	};
    	long page = sysconf(_SC_PAGESIZE);
    	unsigned char *map, *buf;
    	uint32_t size;
    	long ret;
    	map = mmap(NULL, 2 * page, PROT_READ | PROT_WRITE,
    		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    	memset(map, 0xaa, 2 * page);
    	/* 100 byte buffer ending right at the page boundary */
    	buf = map + page - 100;
    	if (guard)
    		mprotect(map + page, page, PROT_NONE);
    	errno = 0;
    	ret = syscall(__NR_statmount, &req, buf, 100, 0);
    	printf("mask 0x%04llx%s: ret %ld errno %d", (unsigned long long)mask,
    	       guard ? " guard page" : "", ret, errno);
    	if (!guard) {
    		memcpy(&size, buf, sizeof(size));
    		printf(", size 0x%x, byte[%d] 0x%02x", size, SM_SIZE,
    		       buf[SM_SIZE]);
    	}
    	printf("\n");
    	munmap(map, 2 * page);
    }
    int main(void)
    {
    	uint64_t id = root_mnt_id();
    	probe(id, STATMOUNT_MNT_UIDMAP, 0);
    	probe(id, STATMOUNT_FS_SUBTYPE, 0);
    	probe(id, STATMOUNT_MNT_UIDMAP, 1);
    	return 0;
    }

Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM, the
same on a distro 7.1.13:

    mask 0x2000: ret 0 errno 0, size 0x65, byte[512] 0x00
    mask 0x0100: ret 0 errno 0, size 0x65, byte[512] 0x00
    mask 0x2000 guard page: ret -1 errno 14

After:

    mask 0x2000: ret -1 errno 75, size 0xaaaaaaaa, byte[512] 0xaa
    mask 0x0100: ret -1 errno 75, size 0xaaaaaaaa, byte[512] 0xaa
    mask 0x2000 guard page: ret -1 errno 75

Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/r/20261020110747.959829-1-shawnq1@163.com
Fixes: e52e97f09fb6 ("statmount: let unset strings be empty")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c30f063742f4..6c9c0cdbe890 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6058,7 +6058,8 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 	ks->bufsize = bufsize;
 
 	if (ks->mask & STATMOUNT_STRING_REQ) {
-		if (bufsize == sizeof(ks->sm))
+		/* Even the reserved empty string needs room past the fixed part. */
+		if (bufsize <= sizeof(ks->sm))
 			return -EOVERFLOW;
 
 		ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);

-- 
2.53.0

