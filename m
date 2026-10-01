Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DA4A5C29;
	Thu,  1 Oct 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847116; cv=none; b=lA+UWquqM428MFmlOoUR5Sq3M6XqdegOSOQ8+khUvcQr+Kv6hY2bBip+WCF4mlehkLMOkDknWJTbhhkoh0RTZIhcH/4tX75sPen+rBivgWKScmCy4xkT+GaQ10vrHgLL2CDdt4Rj71Rt472Kc9NVoQXp1En8Ef8qnQsV8wJRX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847116; c=relaxed/simple;
	bh=zvuuf3+Es7XE7dpvvhP5gQmaUqKFy+Vi/F88hCbAbvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+tpSepG+Gfre/pfthDNYi0ys1HsGrxkmUtuJgk8Ij/nC2LOgxojG6O/I/QRt8aO8JlucNzLapLPtrob/JiEJawiFBrJnPbuVtK22C+GqVi29EkyqAzSmC9C3sT1Z/7Y9sSwqsJ8bodS50ZQIoYHonKbShVhg4iTvKyTWK8vMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg9bkoOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg9bkoOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0361F000FF;
	Thu,  1 Oct 2026 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847115;
	bh=6+fEKpcnK3thwDx3NvseaKYrWkmXiPjWuXabRbm0cB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jg9bkoOwsb/192LSQEyIjaDTeO7dGJH50BXnWngXBHMAxXJlgbEMYb0yDOA5/Ycz5
	 AbyqRefUrcfWjUKSxpiaBvNjMtBkIZ6fJtDLojYKQJvuA8njvPKzAwntHJ4HkjL6cO
	 lQBVtKAE504AyAc+NhKN47KKv/Bq7HCqXom+fQcnGbiconU5FcHFmgBY+gipR9UYb0
	 c+Ka3MoCoyf9gdNfJ+aIHGMfDS3NFqRZhQrI6X02UJ1Sh09uOr8TLHzuU9XeviAilp
	 cCQKZWRFvFB5OxF7z3izAd7wgw7uJyEmJpl9xOby2Qkc/FofmrQ8pkwmwfbm2gb884
	 ZazoiarFIhqmg==
Date: Thu, 1 Oct 2026 11:31:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
Message-ID: <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>

On Wed, Sep 30, 2026 at 03:32:06PM +0200, Christian Brauner wrote:
> fsnotify_destroy_marks() removes every mark of an object that goes away.
> It walks the mark list of the connector and has to drop the connector
> lock around fsnotify_destroy_mark() since that sleeps. Afterwards it
> continues from the mark it just destroyed. That mark stays on the list
> because the function holds a reference to it. But while the lock is
> dropped fsnotify_add_mark_list() can add a mark to the very same
> connector and put it in front of the current one when group priority
> dictates. fsnotify_grab_connector() hands out the connector until it is
> detached and it only gets detached after the walk.
> 
> So the walk never sees that mark. The connector is detached from the
> object with the new mark still attached to it. It never receives an
> event nor IN_IGNORED. For inotify that's a watch descriptor that never
> reports anything and doesn't show up in fdinfo either:
> 
>   wd1 = inotify_add_watch(/proc/self/fd/6) = 2
>   events after the unlink:
>     wd 1 mask 0x400 IN_DELETE_SELF
>     wd 1 mask 0x8000 IN_IGNORED
>   events after write() to the file:
>     (none)
> 
> Detach the connector from the object before the marks are destroyed.
> fsnotify_grab_connector() refuses a detached connector so a mark added
> from then on gets a connector of its own. Nothing during the destruction
> needs the connector. The inode reference of the connector is dropped
> after the marks are gone as before.
> 
> Fixes: 6b3f05d24d35 ("fsnotify: Detach mark from object list when last reference is dropped")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/notify/mark.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index b2640d836a71..f6891d39e42f 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -1112,6 +1112,16 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
>  	conn = fsnotify_grab_connector(connp);
>  	if (!conn)
>  		return;
> +	/*
> +	 * Detach the connector from the object first. Once conn->lock is
> +	 * dropped a mark could be added in front of the one we're at and the
> +	 * walk would miss it. fsnotify_grab_connector() refuses a detached
> +	 * connector so any mark added from now on gets a connector of its
> +	 * own. This also stops pinning the inode until all mark references
> +	 * get dropped. It would lead to strange results such as delaying
> +	 * inode deletion or blocking unmount.
> +	 */
> +	objp = fsnotify_detach_connector_from_object(conn, &type);

Folded as a fixup. We just restart the walk after the drop.

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index f6891d39e42f..e41774b19e00 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -1113,23 +1113,15 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
        if (!conn)
                return;
        /*
-        * Detach the connector from the object first. Once conn->lock is
-        * dropped a mark could be added in front of the one we're at and the
-        * walk would miss it. fsnotify_grab_connector() refuses a detached
-        * connector so any mark added from now on gets a connector of its
-        * own. This also stops pinning the inode until all mark references
-        * get dropped. It would lead to strange results such as delaying
-        * inode deletion or blocking unmount.
-        */
-       objp = fsnotify_detach_connector_from_object(conn, &type);
-       /*
-        * We have to be careful since we can race with e.g.
-        * fsnotify_clear_marks_by_group() and once we drop the conn->lock, the
-        * list can get modified. However we are holding mark reference and
-        * thus our mark cannot be removed from obj_list so we can continue
-        * iteration after regaining conn->lock.
+        * A mark leaves the list with its last reference so the one we hold
+        * keeps the connector alive. Another mark can be added in front of it
+        * while conn->lock is dropped, so start over after every mark and skip
+        * the ones that are already detached.
         */
+restart:
        hlist_for_each_entry(mark, &conn->list, obj_list) {
+               if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
+                       continue;
                fsnotify_get_mark(mark);
                spin_unlock(&conn->lock);
                if (old_mark)
@@ -1137,7 +1129,14 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
                old_mark = mark;
                fsnotify_destroy_mark(mark, mark->group);
                spin_lock(&conn->lock);
+               goto restart;
        }
+       /*
+        * Detach list from object now so that we don't pin inode until all
+        * mark references get dropped. It would lead to strange results such
+        * as delaying inode deletion or blocking unmount.
+        */
+       objp = fsnotify_detach_connector_from_object(conn, &type);
        spin_unlock(&conn->lock);
        if (old_mark)
                fsnotify_put_mark(old_mark);
