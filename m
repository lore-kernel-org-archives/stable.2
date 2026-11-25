Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605983;
	b=OY08OsJdTjOf6d+sPblFcCCLNJIOSmx/St18/edHCpiWdDzHPXMDKlkDu6Odv4jrA+tL
	 LXjWBC1sIV+UvNKnghiy6NbK8EZD7ZK4sdoYZSFqBWluyF2ZgpUtKd9HtSa/klHWjv072
	 XJtttI8CTILemIzeVmUwt10sO2d9j4QnnK1/7Xa6JBQR4f9VGI+Ry8SXAYbmYv5BwRbfj
	 KRhhJinPwtSr1StTrdnWOjgWeaHKFXpx+xjj2ZiAYHZKtFybVX4Ta5YWvt/qbSwF6dzkj
	 0erisDJN5QChxccjF7PIyKhksC7sJ6xlWYlPFujLtfE6K8I+DIKUazWxeug7wyCZxsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605983;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A5pYwoVgS0oebvt9X+pVAuqJToiAlf5cU1HmMr6PVbg=;
	b=r7r1BQONanrHQhXdZTNjep1s1jgyAqVQE9yzKImRoGE44nR9zsW10Jr7nlNbbqdXOMXy
	 vzoGzzmFIG1sqMskEJTen5K0iPF/NaMlwXjV9SD6jUvyH4F7HQ5m7m5i4y/QGW2Jv54j9
	 AgXLvTtxPO+pLD5JH1r2L23/vQdRr3vEkv9H4JpXgcKSjKCRN+ArK7rDHsOFsXgK1T1aN
	 CNLOK/zD7+draSvmAqqMj8HQHJTRH67pztjPqA+M8zVd49nNgeK66AqIZLRZ30TvplDIS
	 jSZ4jES45INSH/o1ZA1928hp9WobtASqzQ/NlZe3Y/lm+rpRUJAvJsKB84HO+Za9r8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XFLjTPcB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E76606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XFLjTPcB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FD91F000D4;
	Wed, 25 Nov 2026 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795605982;
	bh=A5pYwoVgS0oebvt9X+pVAuqJToiAlf5cU1HmMr6PVbg=;
	h=Subject:To:Cc:From:Date;
	b=XFLjTPcBQRnRU3aeGD64pmohjaCf/lu6CBcepM6bMD6Kc/mSdfCJlILjv2vBdNMVd
	 pjj9OiO+LWzLfOuva3knXm3/jUwcEFbQGGxrF35qASay+0du6jw62Z3Q2bPliJ39GU
	 d6QyQHmTis1oZcRQDQ3+nKrjX8pnkUVLZUoFk8OQ=
Subject: FAILED: patch "[PATCH] smb: client: compare owner and group SIDs using their encoded" failed to apply to 5.15-stable tree
To: pkfxxxing@gmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:10:22 +0100
Message-ID: <2026112522-onscreen-fondly-ad73@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a2dabe73ea05ad3b3f8e1cc08fb2e7c2ddc5564b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112522-onscreen-fondly-ad73@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2dabe73ea05ad3b3f8e1cc08fb2e7c2ddc5564b Mon Sep 17 00:00:00 2001
From: liuyong <pkfxxxing@gmail.com>
Date: Fri, 6 Nov 2026 18:48:36 +0800
Subject: [PATCH] smb: client: compare owner and group SIDs using their encoded
 lengths

populate_new_aces() compares owner and group SIDs over sizeof(struct
smb_sid), including storage for all 15 possible subauthorities. Received
SIDs contain only their encoded subauthorities. The comparison can read
past the security descriptor, as shown by the supplied KASAN report for
a 44-byte descriptor during chmod.

The input SIDs have already been checked by sid_from_sd(). Require equal
subauthority counts, then compare only the fixed SID header and the
encoded subauthorities with memcmp(). The count check ensures that both
validated SIDs contain the number of bytes being compared.

These issues were discovered and fixed by Qihoo 360's Tulongfeng
multi-agent system.

Fixes: 0f22053e811c ("cifs: Fix unix perm bits to cifsacl conversion for "other" bits.")
Cc: stable@vger.kernel.org
Signed-off-by: liuyong <pkfxxxing@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index f9f61c758a75..e420943bd3d4 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1134,7 +1134,10 @@ static void populate_new_aces(char *nacl_base,
 	 * updated in the inode.
 	 */
 
-	if (!memcmp(pownersid, pgrpsid, sizeof(struct smb_sid))) {
+	if (pownersid->num_subauth == pgrpsid->num_subauth &&
+	    !memcmp(pownersid, pgrpsid,
+		    CIFS_SID_BASE_SIZE +
+		    pownersid->num_subauth * sizeof(__le32))) {
 		/*
 		 * Case when owner and group SIDs are the same.
 		 * Set the more restrictive of the two modes.

