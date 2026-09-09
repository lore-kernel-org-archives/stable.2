Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C50472538
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954240; cv=none; b=E4Eq97m3aROgwNfIiTRdWKElyv8nuKrYc8jv50cDnu7xsnRPDRi8RsbEoiO7aME/aGx0PJcqGpD54FQUXfl9LejUzLE3K0Eyx3isbkhrU6enssejNpH5C8p9PiTzoPD1QDffvb/qQqabs3VcnbvImfVg9p8lLCFZXIwDYm07axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954240; c=relaxed/simple;
	bh=hNRpbq1BZfgnxImSUxtDgbNgDNTLfxALD0+d888i54c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kd1Ey5suVC3GfoeCjr8NvrT4Kef9yx+1cfsmPZ1I+oFjIctfU9OcUrtqlnhXSd3OKuI8GA7HXPxgPboEOQYXkRA6AiLtgboHOqg6VuhRnFwAA/dbm/Cu8udg7VJ1j2JBTdNVRwoH4r8KG0zp1MWexWkgUc8SfT/qNt4eBobIJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M1tCkezl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M1tCkezl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E68D1F00A3D;
	Wed,  9 Sep 2026 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954239;
	bh=MLqac32nUqUEqbWaTMuppJK2052yoNVx2WdKjDjfrug=;
	h=Subject:To:Cc:From:Date;
	b=M1tCkezlnrkqtANsFQKtp6/KVTBXPlgPFMHT3AxXA7ePxU7GOieFR+fbBQeoCZYMq
	 +HlyRkr/4mbXEQulDjGVXQaeP74d6Cx2PBrnE7Q/w6lhOOHDI9pdcYHijd3P+3Pr/c
	 HIdzJsDU5kKt+r/WgVz7uA2bfWP364MDFK2pK52A=
Subject: FAILED: patch "[PATCH] f2fs: fix dentry folio leak in find_in_level" failed to apply to 6.1-stable tree
To: 3497809730@qq.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:15 +0200
Message-ID: <2026090915-cargo-unclothed-b04d@gregkh>
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
git cherry-pick -x cca7d3e30bf30333314e31bc70b9a739f1342167
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090915-cargo-unclothed-b04d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cca7d3e30bf30333314e31bc70b9a739f1342167 Mon Sep 17 00:00:00 2001
From: Guanghui Yang <3497809730@qq.com>
Date: Sun, 19 Jul 2026 16:45:14 +0800
Subject: [PATCH] f2fs: fix dentry folio leak in find_in_level

find_in_level() gets a dentry folio with f2fs_find_data_folio() before
calling find_in_block().  If find_in_block() returns an error, the
function stores the error in res_folio and breaks out of the loop without
dropping the dentry folio.

This leaks the folio reference on the find_in_block() error path.  Drop
the dentry folio before returning the error to the caller.

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Guanghui Yang <3497809730@qq.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a9563f7fcd88..0562ad211351 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -320,6 +320,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_folio_put(dentry_folio, false);
 			*res_folio = ERR_CAST(de);
 			de = NULL;
 			break;

