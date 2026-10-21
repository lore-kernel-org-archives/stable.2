Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583748;
	b=fQnIGQ/NwvQ+x9WS9omO0qxBv5lCvYHzB56zyLCsMNZtYLK4ikc5ddzhNAqDkReEwH0L
	 PuyNUphXYQmrw8q9q1Zt30TsTmVNygxu0Vm1wglH3J3+3MkKwv+PaThCDKGqkklMhaIu3
	 Z1G0wyR19Ch4hO63qdQzVCJkJcIiVmgihYc5u183grgtWNHiGs/lIKxnxcbGYylNeoNHn
	 rUTiARZCTjugpC8Phssa70fceTBd7v4KUemclSNncx39rfG2A/LY/oqKkQufexW5ee6ha
	 GnzRnEJoXn58nlJuhGWjljJbraOUyTcyNy7X8LCZfWfSblLvlJHuoUCDEsHhGEgoxgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583748;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=mwwp0gQt9PZ43YZnAx+gKuC2Zifd3eUojBewsisQdYE=;
	b=QZStNfdMwvMvThr3xilkGoj6kSCCLn17dt64d7I9RB2yNl3O5IPFma8Zfo7lVc/M2K+n
	 IJhlEw4YlEB8idQDMoAcVobB5bw21eqk6d23pJ/gvDouNL2YbmJC/2a4qClLTdPaZKdOP
	 OIY5y3Q7WyYD/eDUKCn3ifeiLj6h3KDrcsf7Y17PfXRxQGpp6rrGITOBiWZBuCSaSlsPC
	 EZfBAlsURvPCLD8uIngaRcGoFZnpGbmoonOQJisOTwukFG+x43d9qTzIpN0KpxTgqQKcb
	 Bpb8ybaJ+BfI/u6jzhGtyaTZf3OhadQFnxqVnanzeoVZ3YV9s0jsjvS/DgXzuk0opDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOLUgLMb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2D606A31D;
	Wed, 21 Oct 2026 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOLUgLMb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0371F000CA;
	Wed, 21 Oct 2026 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583748;
	bh=mwwp0gQt9PZ43YZnAx+gKuC2Zifd3eUojBewsisQdYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IOLUgLMbtyDZGJ+OhWHxvruNcUJC2KLHNeKC9RQ/7WJKQ5rgtawKij+f6jRxH2AJn
	 YQvO4FfrGioGuOoHFlovKtzDjMlMwV2gGD2o7Uu9J6CJOXx5bVZercxu4lTj+E+wz2
	 2kExSteo/iztBuUewK0BLe2nyoOVQymsQWcvnsQT1SXfWs/yM0bX71MdP0XbIbwBNx
	 RsKhC0U4eVEj+6iQw0m+ATf1JU1lVBc0CXpEMZYel73M6enFCKv4zP8JkspcEwyUGf
	 ke/J+WkdAtqWcDnoXXhJx0vvMwefZmT0t291RMuY9CeE2vjCNXjLwdLQ1KVl8gAFnw
	 zo8ZQ/exvUtSw==
Message-ID: <33ec91ed2a10afecee87c08b623f3d6f6949a4f7.camel@kernel.org>
Subject: Re: [PATCH 5/6] listns: don't wrap around with a U64_MAX cursor
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, shaos <shawnq1@163.com>,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Wed, 21 Oct 2026 07:55:45 -0400
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-5-8917a4c1bd14@kernel.org>
References: 
	<20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
	 <20261021-work-mount-statmount_listns_fixes-v1-5-8917a4c1bd14@kernel.org>
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
> do_listns() and do_listns_userns() take the last namespace id the caller
> saw and look up the first namespace after it by searching the rbtree for
> last_ns_id + 1. With U64_MAX that wraps around to zero and the search
> returns the namespace with the smallest id. So a cursor at the largest
> possible id restarts the listing from the beginning instead of failing
> with ENOENT like a cursor of U64_MAX - 1 does. That's the case for the
> unified tree, the type-specific trees and the owner tree alike.
>=20
> No namespace will ever have that id. They come from a counter and a
> caller that only feeds back ids it got from us can't hit this. It's
> still wrong.
>=20
> Instead of adding one to the cursor and searching for the smallest id
> that's greater or equal make the lookup helpers search for the smallest
> id that's strictly greater than the cursor. That's what both callers
> want anyway and there's nothing left to overflow.
>=20
> Reproducer, unprivileged:
>=20
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
>     	struct ns_id_req req =3D {
>     		.size =3D sizeof(req), .ns_id =3D cursor, .ns_type =3D type,
>     		.user_ns_id =3D owner,
>     	};
>     	uint64_t ids[8];
>     	long ret;
>     	errno =3D 0;
>     	ret =3D syscall(__NR_listns, &req, ids, 8, 0);
>     	printf("%s cursor %llu: ret %ld errno %d", tree,
>     	       (unsigned long long)cursor, ret, errno);
>     	for (long i =3D 0; i < ret && i < 3; i++)
>     		printf("%s%llu", i ? "," : " ids ", (unsigned long long)ids[i]);
>     	printf("%s\n", ret > 3 ? ",..." : "");
>     }
>     int main(void)
>     {
>     	static const uint64_t cursors[] =3D { 0, UINT64_MAX - 1, UINT64_MAX =
};
>     	for (int i =3D 0; i < 3; i++)
>     		list("unified", 0, 0, cursors[i]);
>     	for (int i =3D 0; i < 3; i++)
>     		list("userns", CLONE_NEWUSER, 0, cursors[i]);
>     	for (int i =3D 0; i < 3; i++)
>     		list("owner", 0, LISTNS_CURRENT_USER, cursors[i]);
>     	return 0;
>     }
>=20
> Before, on 7.3.0-rc7-00252-g4e3259b08c54 (vfs.fixes) in a VM:
>=20
>     unified cursor 0: ret 8 errno 0 ids 1,2,3,...
>     unified cursor 18446744073709551614: ret -1 errno 2
>     unified cursor 18446744073709551615: ret 8 errno 0 ids 1,2,3,...
>     userns cursor 0: ret 1 errno 0 ids 3
>     userns cursor 18446744073709551614: ret -1 errno 2
>     userns cursor 18446744073709551615: ret 1 errno 0 ids 3
>     owner cursor 0: ret 8 errno 0 ids 1,2,4,...
>     owner cursor 18446744073709551614: ret -1 errno 2
>     owner cursor 18446744073709551615: ret 8 errno 0 ids 1,2,4,...
>=20
> After:
>=20
>     unified cursor 0: ret 8 errno 0 ids 1,2,3,...
>     unified cursor 18446744073709551614: ret -1 errno 2
>     unified cursor 18446744073709551615: ret -1 errno 2
>     userns cursor 0: ret 1 errno 0 ids 3
>     userns cursor 18446744073709551614: ret -1 errno 2
>     userns cursor 18446744073709551615: ret -1 errno 2
>     owner cursor 0: ret 8 errno 0 ids 1,2,4,...
>     owner cursor 18446744073709551614: ret -1 errno 2
>     owner cursor 18446744073709551615: ret -1 errno 2
>=20
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/r/20261020110732.959552-1-shawnq1@163.com
> Fixes: 76b6f5dfb3fd ("nstree: add listns()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/nstree.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
>=20
> diff --git a/kernel/nstree.c b/kernel/nstree.c
> index 831f279d174a..58b2b55fa8d2 100644
> --- a/kernel/nstree.c
> +++ b/kernel/nstree.c
> @@ -459,10 +459,10 @@ static inline int prepare_klistns(struct klistns *k=
ls, struct ns_id_req *kreq,
>  }
> =20
>  /*
> - * Lookup a namespace owned by owner with id >=3D ns_id.
> - * Returns the namespace with the smallest id that is >=3D ns_id.
> + * Lookup a namespace owned by owner with id > ns_id.
> + * Returns the namespace with the smallest id that is > ns_id.
>   */
> -static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common =
*owner)
> +static struct ns_common *lookup_ns_owner_after(u64 ns_id, struct ns_comm=
on *owner)
>  {
>  	struct ns_common *ret =3D NULL;
>  	struct rb_node *node;
> @@ -476,10 +476,8 @@ static struct ns_common *lookup_ns_owner_at(u64 ns_i=
d, struct ns_common *owner)
>  		struct ns_common *ns;
> =20
>  		ns =3D node_to_ns_owner(node);
> -		if (ns_id <=3D ns->ns_id) {
> +		if (ns_id < ns->ns_id) {
>  			ret =3D ns;
> -			if (ns_id =3D=3D ns->ns_id)
> -				break;
>  			node =3D node->rb_left;
>  		} else {
>  			node =3D node->rb_right;
> @@ -565,7 +563,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
>  	 * then use it's list entry to iterate from there.
>  	 */
>  	if (kls->last_ns_id) {
> -		kls->first_ns =3D lookup_ns_owner_at(kls->last_ns_id + 1, ns);
> +		kls->first_ns =3D lookup_ns_owner_after(kls->last_ns_id, ns);
>  		if (!kls->first_ns)
>  			return -ENOENT;
>  		first_ns =3D kls->first_ns;
> @@ -613,10 +611,10 @@ static ssize_t do_listns_userns(struct klistns *kls=
)
>  }
> =20
>  /*
> - * Lookup a namespace with id >=3D ns_id in either the unified tree or a=
 type-specific tree.
> - * Returns the namespace with the smallest id that is >=3D ns_id.
> + * Lookup a namespace with id > ns_id in either the unified tree or a ty=
pe-specific tree.
> + * Returns the namespace with the smallest id that is > ns_id.
>   */
> -static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
> +static struct ns_common *lookup_ns_id_after(u64 ns_id, int ns_type)
>  {
>  	struct ns_common *ret =3D NULL;
>  	struct ns_tree_root *ns_tree =3D NULL;
> @@ -643,13 +641,8 @@ static struct ns_common *lookup_ns_id_at(u64 ns_id, =
int ns_type)
>  		else
>  			ns =3D node_to_ns_unified(node);
> =20
> -		if (ns_id <=3D ns->ns_id) {
> -			if (ns_type)
> -				ret =3D node_to_ns(node);
> -			else
> -				ret =3D node_to_ns_unified(node);
> -			if (ns_id =3D=3D ns->ns_id)
> -				break;
> +		if (ns_id < ns->ns_id) {
> +			ret =3D ns;
>  			node =3D node->rb_left;
>  		} else {
>  			node =3D node->rb_right;
> @@ -708,7 +701,7 @@ static ssize_t do_listns(struct klistns *kls)
>  	}
> =20
>  	if (kls->last_ns_id) {
> -		kls->first_ns =3D lookup_ns_id_at(kls->last_ns_id + 1, ns_type);
> +		kls->first_ns =3D lookup_ns_id_after(kls->last_ns_id, ns_type);
>  		if (!kls->first_ns)
>  			return -ENOENT;
>  		first_ns =3D kls->first_ns;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
