Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595947;
	b=lkQS6GqQM78nla6k9mgwSUrKoydxCzr3s1MMOv4fBUQ/HGufB7DOjkLAD21y3QzvW2zH
	 /jPBHPP0tqopOwW3d5LFUDOtQzRFJubWpjp4OlFQrrp10sLl5iS8LtfudE5aZvNKpp8uS
	 rcRcFBpr07K4NYAFaDnDXsjjQ+2wf3um0uT+JtDlBFluA4Lr8rSFaKYz8FcNFZntSVqSg
	 V9bfYF4J8VIQDL0grilRoAipFaUGqiO6Rnu0/B4/PzG0vCrFyhCns5R+dRVdTSQcI/ETw
	 D9gO4Cn19DSzEdmskeN83Ky/p4/MPY42oaxINocZiYYodSgNU936llcRSmQ4eN8nHdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595947;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=9FTJM5vluRne/unuHEM3+piJu0iq8i8avOCAH0AQg5A=;
	b=Vc7/bAHOWgGUWc+45RSArWOYVe/a6IwZGWOByiCpb43HBsXRaBqtD1eEB1ADvef1i0Nc
	 XAgwx+9vYED5JwWVe0KgIyROO0F4I1uUh/Sg2emkAGc8ChxNc/THle7pQAjjXdIf+k2/z
	 YAb2IgWzt+2hjIMJsUfXUH4lzqZzgmSidtFuLOVRVoD9zF5TyQQdaaGRbYEIWh74RYXnR
	 OMGBys27ut+Qp884KLty25hnY2NklR+MgNZ4wAC5FBzcwVsJX36PzLd9NQHTvc1A2DIHW
	 ckwnBuhXUilZZ0bumJ584Ehq7ai21FvgZI/MwYNzAfBQqprvxj6saPr0aq8L45qEsGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dmygoBO3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DC5Sx7tG;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dmygoBO3;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DC5Sx7tG;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3E606A31D;
	Wed, 21 Oct 2026 15:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FD3E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dmygoBO3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DC5Sx7tG;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dmygoBO3;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DC5Sx7tG
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 685DD1FAD0;
	Wed, 21 Oct 2026 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792595939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FTJM5vluRne/unuHEM3+piJu0iq8i8avOCAH0AQg5A=;
	b=dmygoBO3h+/Wf2cj+qO7YmZvJdG57nL+TmebYMgSYnrtyLK2U76Bl6NLZ9hMQuALV2m10M
	SF8VptRPQ3Xez9ApyWW4GsOmLqFFD8iU9Mt1DIkypzfuAo5Pcd/z230fDStWOhIUSPqI+t
	pwIvedofqKYJsnTvsQSPGrYI9EtvvBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792595939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FTJM5vluRne/unuHEM3+piJu0iq8i8avOCAH0AQg5A=;
	b=DC5Sx7tG3gDa9sCga181ubRhYucPCP49NPuitqbWiK9vUQbXOgWRFDpwCTSGC7vtXLCIxc
	aFxbGk2pbTkviGAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dmygoBO3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DC5Sx7tG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792595939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FTJM5vluRne/unuHEM3+piJu0iq8i8avOCAH0AQg5A=;
	b=dmygoBO3h+/Wf2cj+qO7YmZvJdG57nL+TmebYMgSYnrtyLK2U76Bl6NLZ9hMQuALV2m10M
	SF8VptRPQ3Xez9ApyWW4GsOmLqFFD8iU9Mt1DIkypzfuAo5Pcd/z230fDStWOhIUSPqI+t
	pwIvedofqKYJsnTvsQSPGrYI9EtvvBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792595939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FTJM5vluRne/unuHEM3+piJu0iq8i8avOCAH0AQg5A=;
	b=DC5Sx7tG3gDa9sCga181ubRhYucPCP49NPuitqbWiK9vUQbXOgWRFDpwCTSGC7vtXLCIxc
	aFxbGk2pbTkviGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D09B134A5;
	Wed, 21 Oct 2026 15:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bgAEBuPX2GqoCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:18:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF984A13C6; Wed, 21 Oct 2026 17:18:43 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:18:43 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] statmount: don't copy the reserved empty string past
 the buffer
Message-ID: <42ugqrzknknogdi3mperavps3t2xywzgqm3zz3ubyfe5t3s33p@2fuk2npm5em7>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
 <20261021-work-mount-statmount_listns_fixes-v1-1-8917a4c1bd14@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-1-8917a4c1bd14@kernel.org>
X-Rspamd-Queue-Id: 685DD1FAD0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,redhat.com,kernel.org,163.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -13.01

On Wed 21-10-26 13:46:54, Christian Brauner wrote:
> statmount_string() reserves an empty string at the start of the seq
> buffer before it calls the handler for the requested string. That's
> what the offsets of unset strings point to since commit e52e97f09fb6
> ("statmount: let unset strings be empty").
> 
> If the handler emits nothing the early return from commit 75ead69a7173
> ("fs: don't let statmount return empty strings") skips the size check
> against the caller's buffer. Back then an empty emission meant an empty
> seq buffer and there was nothing to copy. Now the reserved NUL byte is
> there and copy_statmount_to_user() copies it to buf + sizeof(struct
> statmount) no matter how small bufsize is.
> 
> So request a string that may turn out empty with a buffer that's
> smaller than struct statmount and the kernel writes one zero byte past
> the caller's buffer and reports a size that's larger than the buffer.
> STATMOUNT_MNT_UIDMAP or STATMOUNT_MNT_GIDMAP on a mount that isn't
> idmapped will do, so will STATMOUNT_FS_SUBTYPE on anything but fuse or
> STATMOUNT_OPT_ARRAY on a filesystem without ->show_options(). None of
> this needs privileges. The byte only lands in the caller's own address
> space but that's still not ok.
> 
> prepare_kstatmount() already refuses a buffer of exactly sizeof(struct
> statmount) for string requests. A smaller buffer can't hold a string
> either and it can't even hold the reserved empty string. So refuse any
> buffer that isn't larger than the fixed part. That's also what the uapi
> header says: string requests need space after the fixed part of the
> structure.
> 
> Reproducer, unprivileged, on any mount that isn't idmapped:
> 
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
>     	struct mnt_id_req req = {
>     		.size = sizeof(req), .mnt_id = mnt_id, .param = mask,
>     	};
>     	long page = sysconf(_SC_PAGESIZE);
>     	unsigned char *map, *buf;
>     	uint32_t size;
>     	long ret;
>     	map = mmap(NULL, 2 * page, PROT_READ | PROT_WRITE,
>     		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>     	memset(map, 0xaa, 2 * page);
>     	/* 100 byte buffer ending right at the page boundary */
>     	buf = map + page - 100;
>     	if (guard)
>     		mprotect(map + page, page, PROT_NONE);
>     	errno = 0;
>     	ret = syscall(__NR_statmount, &req, buf, 100, 0);
>     	printf("mask 0x%04llx%s: ret %ld errno %d", (unsigned long long)mask,
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
>     	uint64_t id = root_mnt_id();
>     	probe(id, STATMOUNT_MNT_UIDMAP, 0);
>     	probe(id, STATMOUNT_FS_SUBTYPE, 0);
>     	probe(id, STATMOUNT_MNT_UIDMAP, 1);
>     	return 0;
>     }
> 
> Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM, the
> same on a distro 7.1.13:
> 
>     mask 0x2000: ret 0 errno 0, size 0x65, byte[512] 0x00
>     mask 0x0100: ret 0 errno 0, size 0x65, byte[512] 0x00
>     mask 0x2000 guard page: ret -1 errno 14
> 
> After:
> 
>     mask 0x2000: ret -1 errno 75, size 0xaaaaaaaa, byte[512] 0xaa
>     mask 0x0100: ret -1 errno 75, size 0xaaaaaaaa, byte[512] 0xaa
>     mask 0x2000 guard page: ret -1 errno 75
> 
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/r/20261020110747.959829-1-shawnq1@163.com
> Fixes: e52e97f09fb6 ("statmount: let unset strings be empty")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good but FWIW I've already reviewed the same fix here:

https://lore.kernel.org/all/e6ysb6lyld5remaojkqqbaffvlsxwhr4tmurifp7mhbqrj7l54@6yqqwu3d7e3y

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c30f063742f4..6c9c0cdbe890 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6058,7 +6058,8 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>  	ks->bufsize = bufsize;
>  
>  	if (ks->mask & STATMOUNT_STRING_REQ) {
> -		if (bufsize == sizeof(ks->sm))
> +		/* Even the reserved empty string needs room past the fixed part. */
> +		if (bufsize <= sizeof(ks->sm))
>  			return -EOVERFLOW;
>  
>  		ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
