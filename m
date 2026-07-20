Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EE27380A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560751; cv=none; b=aq4wiooboXuZ+HP28p3PYvdmMYUfZ7TBIkJomN4H2ni3W8GMH7sZ3kAnCKEYln+bG78rz1CjDCzf2uD8q2OriINwltcmz9DV2nHOVKTQW4S/IsejPAKokreg2lPVnphI3lgDJBNSGqHh+/bcp0BnEs6Df69BNhBg+BpStG3kXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560751; c=relaxed/simple;
	bh=b13X1wcQQpMTE+G8bi/iTpQTzVnaO2r6afZmtOpzXDg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L5GTPlTqqmihwaRqa9kJ8S6q0D76AIfubDobKu9w8uoXP3ovoEMytm5XDJ8wqxo1aF42OwkbQxxwxBYtxfSp3l+nctCs1s8iEPFpA+fCxf/9AarwesQFkDfxyzu3e5os4fZ5s41ofv5MJPx0vcejkRfxsjgXLVkw0T7J/8uvMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5Ir+IfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5Ir+IfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828F81F000E9;
	Mon, 20 Jul 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560750;
	bh=HmYbj1XeLTQbODOb3v9ziRFvE4xRyWZF6GTcmzacwNM=;
	h=Subject:To:Cc:From:Date;
	b=F5Ir+IfZ2G+4OEhM6R5+R4S7LaAIe/glk+7zuPVSfZl4EFruE/JHmskfyQze34VqP
	 fgX5U0/IUh9+Ho4OCv5zIvDcuDZ2V7iI1QwD0zM2ZuMBVXNl6O979tyye3JIr4hklI
	 iguTuKV8/XwvUTovg1T/6VfimuKliuHfjg2wK4Fs=
Subject: FAILED: patch "[PATCH] dm-integrity: don't increment hash_offset twice" failed to apply to 5.10-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:18:50 +0200
Message-ID: <2026072050-unless-decompose-8395@gregkh>
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
git cherry-pick -x edf025f083854f80032b73a1aad69a3c90db236f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072050-unless-decompose-8395@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edf025f083854f80032b73a1aad69a3c90db236f Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 9 Jul 2026 21:24:09 +0200
Subject: [PATCH] dm-integrity: don't increment hash_offset twice

hash_offset is already incremented in the loop "for (i = 0; i < to_copy;
i++, ts--)". Do not increment it again.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4.6
Fixes: 84597a44a9d8 ("dm-integrity: dm integrity: add optional discard support")
Cc: stable@vger.kernel.org

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 02b2805ed33a..f5508b1bca11 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1480,9 +1480,6 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 			*metadata_offset = 0;
 		}
 
-		if (unlikely(!is_power_of_2(ic->tag_size)))
-			hash_offset = (hash_offset + to_copy) % ic->tag_size;
-
 		total_size -= to_copy;
 	} while (unlikely(total_size));
 

