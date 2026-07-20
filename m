Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799A279DCA
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560740; cv=none; b=b0PqyBEi1JnZcSkIR5caw/9X8wMhBdbFlcWQUCYqwgYOTxtFD+W4Z6F6ELHYtv2Bb0JF2JQC4e9YCzTInqj+7uLInQovngla3dmc4u0dxPIQm1QiiQ/gLl06snqDokiGAnvV706sEtJFwZQx7CwZ3uq+YlJNbz36nEzs0AMjOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560740; c=relaxed/simple;
	bh=+ZOPWE4mloOpmIQhOErLLL42cMEIMpU4KzcjD/XVYkU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V1ctcodq2r+7lDEkIHqvhe9PjGS5YesgkHlRdK4+MvcoXGVJ3r+GTAtDTfs8936p6t2gIspYjdyDkVfPT4PfJr49gvMp5nnaajxRT5zJDPvdo/+iF2dlbk64CxgzUioWRBEueDsaFDfOeLHYvOpJ6/GA2XskJsj7FK/TRjTB9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lcb3miHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lcb3miHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF2A1F000E9;
	Mon, 20 Jul 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560739;
	bh=CMiXAew2UcfQWM5FLX13txeU0NqHpE0QeWCsxjSsK7I=;
	h=Subject:To:Cc:From:Date;
	b=lcb3miHDW6YIPvfYJk3t+2J58s0zauddtqMSzcqBhyNKr+0pt1xWkp1UBUgpKBxjp
	 oedY3eWFUfo4DMddvNxYfn43rY1OvYEk59692UFlrA3WlQjvGV8KyQsbb1zoIRp6DB
	 2n41NfvmVtl/CIKkosksqMppxHqTzNzIee5NITgE=
Subject: FAILED: patch "[PATCH] dm-integrity: don't increment hash_offset twice" failed to apply to 6.1-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:18:50 +0200
Message-ID: <2026072050-armless-fidelity-4a3f@gregkh>
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
git cherry-pick -x edf025f083854f80032b73a1aad69a3c90db236f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072050-armless-fidelity-4a3f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

