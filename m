Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB8392C3A;
	Sun,  2 Aug 2026 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670946; cv=pass; b=YqYsV8SuiES9CiDPLRQx0w6gvvzARyWUTA0KJvA4RW7qMtcnO56xu/xfDo2NJ3kWz83LnJ1OVacyzg6btVKszksWSQMSVC4IbZsCvAHcuryuFuEvhOXK5Fisf2iWwS2lXTCot0Rq1Ff+AvwaFoyS0WVueByeJRYCw/fDdgFVyOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670946; c=relaxed/simple;
	bh=SbNN7+8V8oduizTPbH+2Zhp5comn2606siWArj09Nbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4BpS89/4zwPNMABK+TuG5iKH0WxdKcxuwix3HsfWaAksiCMJ6/PszJzQLaYTou9Pl8w34zvQv4IhlHLrPxuNY9XGu+IpjoElWM0kgzdqSxwFd3LwMYkE+a+eNEbnTJV3LC5tHoJlA/YN6kzaCMaBWdkcEpyEVacqM1MsZuyRrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=hetj2xXf; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="hetj2xXf"
ARC-Seal: i=1; a=rsa-sha256; t=1785670905; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VrwzWeCCPB+mzQ+g+MzxjHoNUQXU1BlEPq1htTzg0Ar4o3Z1RkuiU+LiIc654nBSEEZgx+OBKp06APtEQBNDPeJZGEDsTFEW41ABabdGZRGvM0j9tlruQ7ar6IOQCrlf0mcjwS4mPqlgbGabYpho6p/aXJkyZacUBEqRHg1ZKjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785670905; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YNHP4YfeV0dVTpVA69OWDDuQFOPaEnTRio6h0wDegAs=; 
	b=iEK946/NBlOZgOqzj9Kumbx1RMmoAeeMqFFSNH87pm7cGn54E2nrM6l9EHVC7tAh5BQx5M8ZsDjt227VoBkqFbXVwrLhRv+BIksdHi3dR/1QjcwM6yzDNfmrn11laVprZMduJwxQwUv8uGgHJZC0uFGsIqGAQee9cKBsTf6foBY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785670905;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YNHP4YfeV0dVTpVA69OWDDuQFOPaEnTRio6h0wDegAs=;
	b=hetj2xXfwhFzTHsZlRAI74Ow6ed7muYGLTfyGyRWT9bfMmxLAhcPQ6aLfQ3gpNmX
	Y+dGUeAtzl57GT2F+BckAtiWr1bBeXf/gSyH4k3Yv0VNEv6OEbUfEF0kc2c/xQw48Ov
	yXRCobrw4Fw4gYKgciX1cSg9PIrixIGFTnpcRP04=
Received: by mx.zoho.eu with SMTPS id 1785670902061752.3213777965705;
	Sun, 2 Aug 2026 13:41:42 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ufs: free the buffer head container in ubh_bforget
Date: Sun,  2 Aug 2026 11:41:30 +0000
Message-ID: <20260802114130.6261-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <875x1syipu.fsf@orpheu.olymp>
References: <875x1syipu.fsf@orpheu.olymp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ubh_bforget() forgets the buffer heads referenced by a struct
ufs_buffer_head but never frees the container itself, unlike its sibling
ubh_brelse() which calls kfree() on the way out. The only caller,
free_full_branch(), allocates the container through ubh_bread() while
releasing an indirect block during truncate, so every fully removed
indirect block leaks one ufs_buffer_head. Truncating or unlinking a
large file then leaks one allocation per indirect block, which kmemleak
reports with a free_full_branch, ufs_truncate_blocks, ufs_evict_inode
backtrace.

Free the container after forgetting its buffers, mirroring ubh_brelse().
Drop the NULL test in the loop as well, which Luis already noted is
redundant because bforget() ignores a NULL buffer head; ubh_brelse() has
no such test either, so the two now match.

Luis Henriques posted this fix in 2018. It never got a single reply and
was never applied, while fs/ufs had no active maintainer, and the leak is
still present.

Link: https://lore.kernel.org/all/20180705150415.25070-1-lhenriques@suse.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
v2: drop the NULL test in the loop, as Luis pointed out. That makes this
    the same change as his 2018 patch; if you would rather it went in
    under his authorship I am happy to resend it that way, his call.
    Whitespace on the touched lines modernised to keep checkpatch quiet.

v1: https://lore.kernel.org/all/20260801024119.12667-1-ali@iusegentoo.com/

 fs/ufs/util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index dff6f74618de..603d80b93066 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -117,8 +117,9 @@ void ubh_bforget (struct ufs_buffer_head * ubh)
 	unsigned i;
 	if (!ubh) 
 		return;
-	for ( i = 0; i < ubh->count; i++ ) if ( ubh->bh[i] ) 
-		bforget (ubh->bh[i]);
+	for (i = 0; i < ubh->count; i++)
+		bforget(ubh->bh[i]);
+	kfree(ubh);
 }
  
 int ubh_buffer_dirty (struct ufs_buffer_head * ubh)

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.55.0

