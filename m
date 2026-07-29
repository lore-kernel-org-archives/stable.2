Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CF4949F1
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332905; cv=none; b=n0Rqa0r22elI7EGLWuwfW9CUi6hk/vvj+fwtr04eZtYlzHgBxvYy7xr/acK8nWwWF5wG4Gbtq2BeM/h/DvHImAfo0oQr3VAi8MTYArsYqVv0c/2rrkQHplcot2MvofOWRAyyer9eCSIia/jYBiELsl5BMK0nzrcU6W3KBBhFzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332905; c=relaxed/simple;
	bh=H2LUPE/aGvWMVUSurlQ8s1FrWezAUB5FFW+Z2/3GDg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ar1HzkgKsK0X7pcSwRjjFlSiPCVQITHMwMniHWMcO6ie5Q2XkVHdTPbFVE3E5Hq0P+P9wFy8E6AIJeJxgddfCcxC1KW2K71R/6d6tS3jevKRPgBY0AhMF7I8L9u+fWbIQpCVmYskxoL43XOcK8SKn6bl3nvLTYM1qy3isSodIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/7FyUtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/7FyUtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CA81F000E9;
	Wed, 29 Jul 2026 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332900;
	bh=3E2ZCMUfC6kO8B5fsD+KM7/BqWOZ8tsg3rdzEuAa9HA=;
	h=Subject:To:Cc:From:Date;
	b=R/7FyUtdQc3BDUizwZ2I6az6bFViYR001KOapeIE7FfXEIYbxlTA0I1Y3+N1+eyaa
	 6hRITDgtGkTVGLC+nPIzJm2y8ANogbrBHUubJq+zDBBqbX9O3sXTQYGmG+oiWM7Skn
	 vNUtBTlxUmBZlmEBpFP7qv7uI6O4PDGFQMjjApzQ=
Subject: FAILED: patch "[PATCH] libceph: fix two unsafe bare decodes in decode_lockers()" failed to apply to 6.1-stable tree
To: jhapavitra98@gmail.com,Slava.Dubeyko@ibm.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:47:48 +0200
Message-ID: <2026072948-wrongdoer-gift-5733@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a109a556115271ca7896dcda7b4b7e45e156c227
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072948-wrongdoer-gift-5733@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a109a556115271ca7896dcda7b4b7e45e156c227 Mon Sep 17 00:00:00 2001
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Tue, 2 Jun 2026 00:17:35 -0400
Subject: [PATCH] libceph: fix two unsafe bare decodes in decode_lockers()

decode_lockers() in cls_lock_client.c contains two bare decode operations
that allow a malicious or compromised OSD to trigger slab-out-of-bounds
reads:

1. ceph_decode_32(p) at the num_lockers field has no preceding bounds
   check. ceph_start_decoding() accepts struct_len=0 as valid -- the
   internal ceph_decode_need(p, end, 0, bad) always passes -- so when an
   OSD sends struct_len=0, ceph_start_decoding() returns success with
   p == end. The immediately following bare ceph_decode_32(p) then reads
   4 bytes past the validated buffer boundary. The garbage value is
   passed directly to kzalloc_objs() as the locker count.

   The sibling function decode_watchers() in osd_client.c already uses
   ceph_decode_32_safe() after its own ceph_start_decoding() call.
   decode_lockers() was the only site using the bare variant.

2. ceph_decode_8(p) after the decode_locker() loop has no preceding
   bounds check. If an OSD crafts num_lockers such that the loop
   advances p exactly to end, the subsequent bare ceph_decode_8(p) reads
   one byte past the validated buffer boundary. The result is passed
   directly into *type, which is used as a lock type discriminator by
   callers, giving an OSD-controlled one-byte OOB read with direct
   influence over the lock type field.

Fix both by replacing bare operations with their safe variants:
  ceph_decode_32(p) -> ceph_decode_32_safe(p, end, *num_lockers,
                                           err_inval)
  ceph_decode_8(p)  -> ceph_decode_8_safe(p, end, *type,
                                          err_free_lockers)

The goto targets differ intentionally:
  err_inval: is a new label returning -EINVAL directly. It is used for
  the pre-allocation failure path where *lockers is not yet allocated
  and must not be passed to ceph_free_lockers().

  err_free_lockers: is the existing label. It is used for the
  post-allocation failure path where *lockers is allocated and must
  be freed.

ret is set to -EINVAL before ceph_decode_8_safe() so that
err_free_lockers returns the correct error code on bounds violation.
Without this, err_free_lockers would return a stale ret value (0 from
the successful decode_locker() loop), silently swallowing the error.

-EINVAL is correct for both failure paths. The data received from the
OSD is structurally malformed. -ENOMEM would misrepresent the failure
class to callers and to stable@ backporters triaging error paths.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition).

[ idryomov: trim changelog, formatting ]

Cc: stable@vger.kernel.org
Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index c6956f1df333..377336982f7d 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -299,7 +299,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	if (ret)
 		return ret;
 
-	*num_lockers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_lockers, err_inval);
 	*lockers = kzalloc_objs(**lockers, *num_lockers, GFP_NOIO);
 	if (!*lockers)
 		return -ENOMEM;
@@ -310,7 +310,8 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 			goto err_free_lockers;
 	}
 
-	*type = ceph_decode_8(p);
+	ret = -EINVAL;
+	ceph_decode_8_safe(p, end, *type, err_free_lockers);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s)) {
 		ret = PTR_ERR(s);
@@ -320,6 +321,9 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	*tag = s;
 	return 0;
 
+err_inval:
+	return -EINVAL;
+
 err_free_lockers:
 	ceph_free_lockers(*lockers, *num_lockers);
 	return ret;

