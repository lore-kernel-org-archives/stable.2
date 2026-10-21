Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596342;
	b=j//4b8cUkqHQki+aaUhpxVOQzTTY/e6p3zSShLvcdzQbgy6HEuoN4mnfaXkdlklfac8Q
	 hmApE+/BLObvbVNh+ieuSTnDy3vniwwOzdU2612htc9WWukliiJPhM/bTR+L+FfNTUyOg
	 tVHc56nbC0W5O3q1BAroI2W4uq6fCJkUmA8e1l3ezwVzXHALZ1ofSsKSGwXuV14mNCIG4
	 2hzJJ70Y5hJpzT04qvcafzFATXJmze4+n9dyVU/1dVFyth6fAO7gaHDMvTtfqMpAHpLQY
	 KZXaoFK3UPROKZdmi+vWjQB1yqWxDdfdlqN6BDRY7CnZUqFcYTDLJx4zsVtYhUAo1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596342;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=m7G3t+0twhzwcxbrBBvWEnkEAKgpilMXDhMbgtxEqL8=;
	b=bx7dZgG2hfyT7DSr+2ZHd9fDCJ1+59edBLz6sK6zFlQizN1BeeYTG1XcQ5gf5d4oSzHN
	 MLPQwpbLsEMkwmr0UjEVa3fX57jqx516AKdvfKU5XuE9ZzQ9WVOpY506vRQheAXzEF+l6
	 VE7vHnw0B51fWx0Uqgv+QYu2jwwFykUNLBRjH++/Ow9upNVepIkEUDPagIOyhbs9lv4ua
	 kq5hvOZAGD8R+9rj9cdUV8pqSAjdY9DbDYSyHgCXt0PvgJH5BL8/rKgBi1avuCYiB432b
	 4gkLZ4j10N4/ehnKZXNargWaXkSB7Lsmu3VrAJDcYa4RQw6ZLAlwFAcO4cQ/6E14Phw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ztTEx3yV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rXncpbw+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ztTEx3yV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rXncpbw+;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDA60A3822;
	Wed, 21 Oct 2026 15:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FBDA60A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ztTEx3yV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rXncpbw+;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ztTEx3yV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rXncpbw+
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B5711FB2A;
	Wed, 21 Oct 2026 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792596334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7G3t+0twhzwcxbrBBvWEnkEAKgpilMXDhMbgtxEqL8=;
	b=ztTEx3yVw0NQySRnicT0gWazUDORFKee0iLmtPZwq9+yp1cSkouP7dXFayqFYw59pQTqrB
	h2tq6bDhtdCDLFW6iffPsTlKLY+602gbWR4D3h4jNME4N5Od8Q6E/iuHcoLpFJD6wE0HN/
	A+ZoAmWAWPCStVsbFf30DqtStOWh4hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792596334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7G3t+0twhzwcxbrBBvWEnkEAKgpilMXDhMbgtxEqL8=;
	b=rXncpbw+tAOXohKHUvjcRXJU81bt0cbpD0OROGUSusvH4vOmaliQwcdGtq2Ptsx2yjXfRS
	FuFxB0lyBWSGf1Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ztTEx3yV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rXncpbw+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792596334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7G3t+0twhzwcxbrBBvWEnkEAKgpilMXDhMbgtxEqL8=;
	b=ztTEx3yVw0NQySRnicT0gWazUDORFKee0iLmtPZwq9+yp1cSkouP7dXFayqFYw59pQTqrB
	h2tq6bDhtdCDLFW6iffPsTlKLY+602gbWR4D3h4jNME4N5Od8Q6E/iuHcoLpFJD6wE0HN/
	A+ZoAmWAWPCStVsbFf30DqtStOWh4hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792596334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7G3t+0twhzwcxbrBBvWEnkEAKgpilMXDhMbgtxEqL8=;
	b=rXncpbw+tAOXohKHUvjcRXJU81bt0cbpD0OROGUSusvH4vOmaliQwcdGtq2Ptsx2yjXfRS
	FuFxB0lyBWSGf1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4994134A5;
	Wed, 21 Oct 2026 15:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id exIjLG3Z2GoUEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:25:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 623ACA1418; Wed, 21 Oct 2026 17:25:33 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:25:33 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 3/6] listmount: don't wrap around with a U64_MAX cursor
Message-ID: <4kwugonfxrc44htf7ar7xtrkun4h4ekpbap22c74fuhcgr337q@ylguygvysipm>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
 <20261021-work-mount-statmount_listns_fixes-v1-3-8917a4c1bd14@kernel.org>
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
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-3-8917a4c1bd14@kernel.org>
X-Rspamd-Queue-Id: 0B5711FB2A
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -13.01

On Wed 21-10-26 13:46:56, Christian Brauner wrote:
> do_listmount() takes the last mount id the caller saw and looks up the
> first mount after it by searching for last_mnt_id + 1. With U64_MAX
> that wraps around to zero and the search finds the first mount in the
> namespace. So a cursor at the largest possible id restarts the listing
> from the beginning instead of ending it. A cursor of U64_MAX - 1
> correctly returns nothing.
> 
> No mount will ever have that id. Mount ids come from a counter that
> starts at MNT_UNIQUE_ID_OFFSET + 1 and a caller that only feeds back
> ids it got from us can't hit this. It's still wrong. Nothing can come
> after the largest possible id so return no entries for it, just like
> for any other cursor past the last mount.
> 
> The reverse direction isn't affected. A cursor of zero is special-cased
> and anything else is larger than MNT_UNIQUE_ID_OFFSET so last_mnt_id - 1
> can't underflow.
> 
> Reproducer, unprivileged:
> 
>     #define _GNU_SOURCE
>     #include <errno.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <sys/syscall.h>
>     #include <unistd.h>
>     #define LSMT_ROOT 0xffffffffffffffffULL
>     struct mnt_id_req {
>     	uint32_t size, mnt_ns_fd;
>     	uint64_t mnt_id, param, mnt_ns_id;
>     };
>     static void list(uint64_t cursor)
>     {
>     	struct mnt_id_req req = {
>     		.size = sizeof(req), .mnt_id = LSMT_ROOT, .param = cursor,
>     	};
>     	uint64_t ids[8];
>     	long ret;
>     	errno = 0;
>     	ret = syscall(__NR_listmount, &req, ids, 8, 0);
>     	printf("cursor %llu: ret %ld errno %d", (unsigned long long)cursor,
>     	       ret, errno);
>     	for (long i = 0; i < ret && i < 1; i++)
>     		printf("%s%llu", i ? "," : " ids ", (unsigned long long)ids[i]);
>     	printf("%s\n", ret > 1 ? ",..." : "");
>     }
>     int main(void)
>     {
>     	list(0);
>     	list(UINT64_MAX - 1);
>     	list(UINT64_MAX);
>     	return 0;
>     }
> 
> Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM:
> 
>     cursor 0: ret 5 errno 0 ids 2147483651,...
>     cursor 18446744073709551614: ret 0 errno 0
>     cursor 18446744073709551615: ret 5 errno 0 ids 2147483651,...
> 
> After:
> 
>     cursor 0: ret 5 errno 0 ids 2147483651,...
>     cursor 18446744073709551614: ret 0 errno 0
>     cursor 18446744073709551615: ret 0 errno 0
> 
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/r/20261020110732.959552-1-shawnq1@163.com
> Fixes: b4c2bea8ceaa ("add listmount(2) syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6c9c0cdbe890..dd60123a0cb0 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6253,6 +6253,8 @@ static ssize_t do_listmount(struct klistmount *kls, bool reverse)
>  	} else {
>  		if (reverse)
>  			first = mnt_find_id_at_reverse(ns, last_mnt_id - 1);
> +		else if (last_mnt_id == U64_MAX)
> +			first = NULL; /* nothing comes after the largest id */
>  		else
>  			first = mnt_find_id_at(ns, last_mnt_id + 1);
>  	}
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
