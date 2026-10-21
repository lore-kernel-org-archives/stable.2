Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596607;
	b=GIgtrnXRJEUiWVB2j6T15UV6rEXGZ6CVrZwWWvLoOcnEQFrZ0JxNvbdbdKeQs6PvtB3V
	 +FHszeBTKvIw/Q1wf7g5OzwY1nm7++7e+gAwzZkODktJpg+a+KqFrMMKJG4QAr6mE5mOQ
	 4t2fXW2MLf5RzbYxugqgMAPf4S9uak7q5FoLO1RygalOCrJxvkqQXpAayvnrOZMXv7rph
	 j4uPrBG307uPFQMk/iuFy/EFqFJL2t3iYjFtkpcXmmWk6K0vN3uupBVuYe+L0vTaM0G0y
	 25CKwPyd1QM/T+it9XhOPh+pNuwCtihSUduBtxzWPtwgt3ErKaINeNAguv9fOrov+kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596607;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=HaSw9CI+ZF+Vt07rKhd2TFzurUYhiAv7ZJ2gF8vcgyo=;
	b=P6ZhE3cbdkX+3SGreolWTdLTCnWCrWLY8GG3c33iZbEScsAR4TzMQKYbdz5IcJKAHA1x
	 eEYkQxU2Y5UGmrXXyls9SxRhyhz9avgQIWk9pBM+mkEghS2mlU+sIDcFAZTmSr9T4Y7Vk
	 IUGePbuCy2C+b4xgENQYgL1R+tabg/wGwS9iEFV6TMF9V3I9Mf/y2hjRaUOUFjsysiWBQ
	 02lXsJ46rnkJvYjyMdB1Kflhg/v2h94ntDEICR95cz1AmxpXi/j2XMb8H+bSoCeNTFo1w
	 SessXkM5h4Y0AqR+e7n1DuUhDWdVJ/kjKmbNp0liJkYmTF5bu1UDjWRhJNx+Lx+BS9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JUz+9Pzj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="re/OyTLv";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=f279zzle;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=niU1uIJq;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E6606A31B;
	Wed, 21 Oct 2026 15:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JUz+9Pzj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=re/OyTLv;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=f279zzle;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=niU1uIJq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D70E222019;
	Wed, 21 Oct 2026 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792596605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaSw9CI+ZF+Vt07rKhd2TFzurUYhiAv7ZJ2gF8vcgyo=;
	b=JUz+9PzjFFvT68FU8KbVKnG9ONPa90Jx1jDJjXCpX1ap3DuKTdLsMyqj/clMsUJ8ON4w4p
	wLf5XGQl0b4RHWITx5eE9YjHWBAn5i+eTvtBwnV1WXjV0Wa1Nx/y7dLizZ43PBtASZzUWo
	SZJSdK/b/ygQDeqUSo9McPrB2hyyL6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792596605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaSw9CI+ZF+Vt07rKhd2TFzurUYhiAv7ZJ2gF8vcgyo=;
	b=re/OyTLvyhxvPBv31y3qG45QYv69fN91b+v856lgqv2vQIdrGMx5g+cRSgf81p7FnaRSbz
	1NsqT92yn5MchNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792596604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaSw9CI+ZF+Vt07rKhd2TFzurUYhiAv7ZJ2gF8vcgyo=;
	b=f279zzleEbbQn+5QK4zJCFpw82PKJ3T99LUEwIjcfY8H45YQWvMYuCLGvVsEm/vWPDZlh7
	b8kC4TyIc9JOB9ID9quFLa/1fdFddOIb55NyihyU6xqDIQRgiWYs6CT/lmAHmSz2RinUbi
	/pLQrFgsEIwRAgm4S1LZMJhiQViVcwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792596604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaSw9CI+ZF+Vt07rKhd2TFzurUYhiAv7ZJ2gF8vcgyo=;
	b=niU1uIJqowBJeRdaiquQw54mbqjXEIup3RWdChZ+madKbfWqR31SagOEFJfBCwCSZ2RnVK
	Vez1AXPIIWH2M5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B72AC134A5;
	Wed, 21 Oct 2026 15:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HlWtJXza2GrqFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E115A1418; Wed, 21 Oct 2026 17:29:56 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:29:56 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5/6] listns: don't wrap around with a U64_MAX cursor
Message-ID: <mlpsaezfk3apjsk3jl6nksrxp7fmmpsahxwljs2ilornsovgyu@ohmycilav6el>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
 <20261021-work-mount-statmount_listns_fixes-v1-5-8917a4c1bd14@kernel.org>
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
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-5-8917a4c1bd14@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,redhat.com,kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 21-10-26 13:46:58, Christian Brauner wrote:
> do_listns() and do_listns_userns() take the last namespace id the caller
> saw and look up the first namespace after it by searching the rbtree for
> last_ns_id + 1. With U64_MAX that wraps around to zero and the search
> returns the namespace with the smallest id. So a cursor at the largest
> possible id restarts the listing from the beginning instead of failing
> with ENOENT like a cursor of U64_MAX - 1 does. That's the case for the
> unified tree, the type-specific trees and the owner tree alike.
> 
> No namespace will ever have that id. They come from a counter and a
> caller that only feeds back ids it got from us can't hit this. It's
> still wrong.
> 
> Instead of adding one to the cursor and searching for the smallest id
> that's greater or equal make the lookup helpers search for the smallest
> id that's strictly greater than the cursor. That's what both callers
> want anyway and there's nothing left to overflow.
> 
> Reproducer, unprivileged:
> 
>     #define _GNU_SOURCE
>     #include <errno.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <sys/syscall.h>
>     #include <unistd.h>
>     #ifndef __NR_listns
>     #define __NR_listns 470
>     #endif
>     #define CLONE_NEWUSER		0x10000000U
>     #define LISTNS_CURRENT_USER	0xffffffffffffffffULL
>     struct ns_id_req {
>     	uint32_t size, spare;
>     	uint64_t ns_id;
>     	uint32_t ns_type, spare2;
>     	uint64_t user_ns_id;
>     };
>     static void list(const char *tree, uint32_t type, uint64_t owner,
>     		 uint64_t cursor)
>     {
>     	struct ns_id_req req = {
>     		.size = sizeof(req), .ns_id = cursor, .ns_type = type,
>     		.user_ns_id = owner,
>     	};
>     	uint64_t ids[8];
>     	long ret;
>     	errno = 0;
>     	ret = syscall(__NR_listns, &req, ids, 8, 0);
>     	printf("%s cursor %llu: ret %ld errno %d", tree,
>     	       (unsigned long long)cursor, ret, errno);
>     	for (long i = 0; i < ret && i < 3; i++)
>     		printf("%s%llu", i ? "," : " ids ", (unsigned long long)ids[i]);
>     	printf("%s\n", ret > 3 ? ",..." : "");
>     }
>     int main(void)
>     {
>     	static const uint64_t cursors[] = { 0, UINT64_MAX - 1, UINT64_MAX };
>     	for (int i = 0; i < 3; i++)
>     		list("unified", 0, 0, cursors[i]);
>     	for (int i = 0; i < 3; i++)
>     		list("userns", CLONE_NEWUSER, 0, cursors[i]);
>     	for (int i = 0; i < 3; i++)
>     		list("owner", 0, LISTNS_CURRENT_USER, cursors[i]);
>     	return 0;
>     }
> 
> Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM:
> 
>     unified cursor 0: ret 8 errno 0 ids 1,2,3,...
>     unified cursor 18446744073709551614: ret -1 errno 2
>     unified cursor 18446744073709551615: ret 8 errno 0 ids 1,2,3,...
>     userns cursor 0: ret 1 errno 0 ids 3
>     userns cursor 18446744073709551614: ret -1 errno 2
>     userns cursor 18446744073709551615: ret 1 errno 0 ids 3
>     owner cursor 0: ret 8 errno 0 ids 1,2,4,...
>     owner cursor 18446744073709551614: ret -1 errno 2
>     owner cursor 18446744073709551615: ret 8 errno 0 ids 1,2,4,...
> 
> After:
> 
>     unified cursor 0: ret 8 errno 0 ids 1,2,3,...
>     unified cursor 18446744073709551614: ret -1 errno 2
>     unified cursor 18446744073709551615: ret -1 errno 2
>     userns cursor 0: ret 1 errno 0 ids 3
>     userns cursor 18446744073709551614: ret -1 errno 2
>     userns cursor 18446744073709551615: ret -1 errno 2
>     owner cursor 0: ret 8 errno 0 ids 1,2,4,...
>     owner cursor 18446744073709551614: ret -1 errno 2
>     owner cursor 18446744073709551615: ret -1 errno 2
> 
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/r/20261020110732.959552-1-shawnq1@163.com
> Fixes: 76b6f5dfb3fd ("nstree: add listns()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/nstree.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/nstree.c b/kernel/nstree.c
> index 831f279d174a..58b2b55fa8d2 100644
> --- a/kernel/nstree.c
> +++ b/kernel/nstree.c
> @@ -459,10 +459,10 @@ static inline int prepare_klistns(struct klistns *kls, struct ns_id_req *kreq,
>  }
>  
>  /*
> - * Lookup a namespace owned by owner with id >= ns_id.
> - * Returns the namespace with the smallest id that is >= ns_id.
> + * Lookup a namespace owned by owner with id > ns_id.
> + * Returns the namespace with the smallest id that is > ns_id.
>   */
> -static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
> +static struct ns_common *lookup_ns_owner_after(u64 ns_id, struct ns_common *owner)
>  {
>  	struct ns_common *ret = NULL;
>  	struct rb_node *node;
> @@ -476,10 +476,8 @@ static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
>  		struct ns_common *ns;
>  
>  		ns = node_to_ns_owner(node);
> -		if (ns_id <= ns->ns_id) {
> +		if (ns_id < ns->ns_id) {
>  			ret = ns;
> -			if (ns_id == ns->ns_id)
> -				break;
>  			node = node->rb_left;
>  		} else {
>  			node = node->rb_right;
> @@ -565,7 +563,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
>  	 * then use it's list entry to iterate from there.
>  	 */
>  	if (kls->last_ns_id) {
> -		kls->first_ns = lookup_ns_owner_at(kls->last_ns_id + 1, ns);
> +		kls->first_ns = lookup_ns_owner_after(kls->last_ns_id, ns);
>  		if (!kls->first_ns)
>  			return -ENOENT;
>  		first_ns = kls->first_ns;
> @@ -613,10 +611,10 @@ static ssize_t do_listns_userns(struct klistns *kls)
>  }
>  
>  /*
> - * Lookup a namespace with id >= ns_id in either the unified tree or a type-specific tree.
> - * Returns the namespace with the smallest id that is >= ns_id.
> + * Lookup a namespace with id > ns_id in either the unified tree or a type-specific tree.
> + * Returns the namespace with the smallest id that is > ns_id.
>   */
> -static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
> +static struct ns_common *lookup_ns_id_after(u64 ns_id, int ns_type)
>  {
>  	struct ns_common *ret = NULL;
>  	struct ns_tree_root *ns_tree = NULL;
> @@ -643,13 +641,8 @@ static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
>  		else
>  			ns = node_to_ns_unified(node);
>  
> -		if (ns_id <= ns->ns_id) {
> -			if (ns_type)
> -				ret = node_to_ns(node);
> -			else
> -				ret = node_to_ns_unified(node);
> -			if (ns_id == ns->ns_id)
> -				break;
> +		if (ns_id < ns->ns_id) {
> +			ret = ns;
>  			node = node->rb_left;
>  		} else {
>  			node = node->rb_right;
> @@ -708,7 +701,7 @@ static ssize_t do_listns(struct klistns *kls)
>  	}
>  
>  	if (kls->last_ns_id) {
> -		kls->first_ns = lookup_ns_id_at(kls->last_ns_id + 1, ns_type);
> +		kls->first_ns = lookup_ns_id_after(kls->last_ns_id, ns_type);
>  		if (!kls->first_ns)
>  			return -ENOENT;
>  		first_ns = kls->first_ns;
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
