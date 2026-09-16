Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72B495AE5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577234; cv=none; b=MdWI+0MDJbWfzmuC/HG7GwYK01/DCDtokm+X6TOOCa7KDNKA8TA5XpvHywsmuaqXcHeLWoGkc+5AsBDPRo9SbJeQHMY2/leYLtueo4A/gGaFEwCQW5TlaYwAKrG4KBrN/KXHODvmHlJFHdteiOh+jA0ryIIzbzxKMqKjVdzatGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577234; c=relaxed/simple;
	bh=tq88OL8wS/td8+pIXiKAYoOHI+Tr/0W3fBz5IZy4GZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mNTHEQKxGkyVx1HEgepm5oeICaYlsbx7syNAfThyTv8ZYUuW88AzlPKa0NfLn28XqN/JD3tnOaa73MBg9JNBwOMvVF8yfMYxLeQEL394oho8MtXmj7zBEIzsDCIZ4MUkzkPXgmNF4D4Sp9BvZxn2mv258AQGNeWJBam8UeBT3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cc7iC8HW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cc7iC8HW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D711F000FF;
	Wed, 16 Sep 2026 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577219;
	bh=ZTTZp/Mrpye/BJ4t2TgkgvvfnuYWnY391VhPUJqAQVQ=;
	h=Subject:To:Cc:From:Date;
	b=Cc7iC8HWVoK5ZvSpRzeB+8L90VBxpH70uXfRomtSFr603yVgHvHW/HKS+rsLGkCW/
	 cb7Y/6Txvvtjp7hQ2beYwzss3GzsqKoyGXrMFUx3BmMl3fNwKT17Z6tdBc2c4D0cbU
	 IpsIYwNnEkgwHhyN/SfMJO5eatJaCGBXW6LFKhLA=
Subject: FAILED: patch "[PATCH] smb: client: reject userspace cifs.idmap descriptions" failed to apply to 5.10-stable tree
To: henrymei@tencent.com,corvus@tencent.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:39:52 +0100
Message-ID: <2026091652-dreamy-pentagram-586f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d9d7eeb0cea5b55b82888f443622fd8d4ee064f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091652-dreamy-pentagram-586f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d9d7eeb0cea5b55b82888f443622fd8d4ee064f3 Mon Sep 17 00:00:00 2001
From: Aohan Mei <henrymei@tencent.com>
Date: Wed, 2 Sep 2026 20:52:13 +0800
Subject: [PATCH] smb: client: reject userspace cifs.idmap descriptions

cifs.idmap key descriptions carry authority-bearing fields (owner and
group SIDs and uid/gid values in "os:"/"gs:"/"oi:"/"gi:" form) that the
cifs.idmap upcall helper treats as kernel-originating inputs.  Unlike
its sibling cifs.spnego, the cifs.idmap key type has no vet_description
hook, so userspace can create keys of this type through
request_key(2)/add_key(2) and supply those fields without CIFS origin.
A request_key(2) call with a non-NULL callout then drives a root
usermodehelper upcall (/sbin/request-key -> cifs.idmap) that consumes
the unvetted description in root context.

Only accept cifs.idmap descriptions while CIFS is using its private
root_cred to request the key.  id_to_sid()/sid_to_id() already run
under override_creds(root_cred), so the kernel-originated path is
unaffected.

This mirrors commit 3da1fdf4efbc ("smb: client: reject userspace
cifs.spnego descriptions"), which applied the same restriction to
cifs.spnego.

Fixes: 4d79dba0e007 ("cifs: Add idmap key and related data structures and functions (try #17 repost)")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 12005f46307d..213a421bf8e9 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -100,8 +100,23 @@ cifs_idmap_key_destroy(struct key *key)
 		kfree(key->payload.data[0]);
 }
 
+static int
+cifs_idmap_key_vet_description(const char *description)
+{
+	/*
+	 * cifs.idmap descriptions are authority-bearing inputs to the
+	 * cifs.idmap upcall helper.  Only allow the kernel to create this
+	 * type of key using the private root_cred installed in
+	 * init_cifs_idmap; reject userspace request_key(2)/add_key(2).
+	 */
+	if (current_cred() != root_cred)
+		return -EPERM;
+	return 0;
+}
+
 static struct key_type cifs_idmap_key_type = {
 	.name        = "cifs.idmap",
+	.vet_description = cifs_idmap_key_vet_description,
 	.instantiate = cifs_idmap_key_instantiate,
 	.destroy     = cifs_idmap_key_destroy,
 	.describe    = user_describe,

