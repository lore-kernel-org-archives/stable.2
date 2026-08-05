Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230440A93A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923902; cv=none; b=s0aFpwPoR0DWN4T19mGnDQ80N3N7ljFfbpklKwnMgGYTy7Ml7XJxmFPuSijyImIpCJH6jZNnlz2qYsvftwykTzTbfdOy8v8FNpSUhILqbTPT1uIvLSbpjkCe7fFf3j9fxOxeqx+5ptRxSz9TGp7+vcJswcmI6GYmBk8cdPyOnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923902; c=relaxed/simple;
	bh=U5k6ncM0bwjVWiy/heHXw/QVAwPFXdo6X5H7Z19F8pM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UsxknCsMhx8qtiHnOAfmh0BjEHH/VbIvMqIbrcbWHJ46LeCogdUe+V5euNwitgxFmDOMkSUrjFxhHdcIj2Catt2xCil6mjg04Sdqa4HoWMSBqGTLByBJ7uOwvpAIgkckYH5BFds+rf5LZmqQnsA9SuMaiexEWSWLucKtuOgbiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWn1nxmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWn1nxmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB851F000E9;
	Wed,  5 Aug 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923901;
	bh=4jVjAPZHhrus0L4EpAfkbd2MbQHk8f0WDnlhD/RzG1A=;
	h=Subject:To:Cc:From:Date;
	b=WWn1nxmv/DtdwT5tOEUxsN9gP0T3p2+PkniHgBytlv3FaEHfKrJI2qzngfLUzTyOK
	 Ixsx2Rtc/z/SL2uzueAZESDnQY5Aqc0z/6szWUXeGxauyAb9/YaSbK2gSUV83bQTiA
	 YtsyzlWwv5Eq7ciUHkP/B7Igmt/W3MyfaGQM0pR0=
Subject: FAILED: patch "[PATCH] binfmt_misc: restore write access when removing an entry" failed to apply to 5.10-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:54:13 +0200
Message-ID: <2026080513-stubbed-clear-8ac9@gregkh>
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
git cherry-pick -x db1856ea9196cf6e015d12199a34c0b9313c7bfa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080513-stubbed-clear-8ac9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db1856ea9196cf6e015d12199a34c0b9313c7bfa Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:02 +0200
Subject: [PATCH] binfmt_misc: restore write access when removing an entry

Registering an entry with the MISC_FMT_OPEN_FILE flag opens the
interpreter via open_exec() which denies write access to it for as
long as the entry exists. Removing the entry closes the interpreter
file via filp_close() but never restores write access, leaving the
inode's i_writecount permanently negative. Opening the interpreter
for writing keeps failing with ETXTBSY long after the entry is gone
until the inode is evicted from the inode cache.

Commit 90f601b497d7 ("binfmt_misc: restore write access before
closing files opened by open_exec()") fixed the same imbalance in the
error path of bm_register_write() but the actual removal path has
been leaking the write denial since the introduction of the flag.

Restore write access in put_binfmt_handler() before closing the
interpreter file.

Link: https://patch.msgid.link/20260710-work-binfmt_misc-locking-v3-1-a162f7cb58d6@kernel.org
Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 47aeb2b68d3e..adab06d18550 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -162,8 +162,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
 static void put_binfmt_handler(Node *e)
 {
 	if (refcount_dec_and_test(&e->users)) {
-		if (e->flags & MISC_FMT_OPEN_FILE)
+		if (e->flags & MISC_FMT_OPEN_FILE) {
+			exe_file_allow_write_access(e->interp_file);
 			filp_close(e->interp_file, NULL);
+		}
 		kfree(e);
 	}
 }

