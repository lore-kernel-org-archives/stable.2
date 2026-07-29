Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6322FC00D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332829; cv=none; b=b6fJplO3EZfDqOoiGEAT8N2iw7WFAWfFeupyq1Lrl0wVpqU3lKjIVC1b7fWcncwdUMo4cDkF2BGm+rsmXRpb6MH/f20O2mqwF0kmEilt1Hsc8DqLr26q9V+LbauhtKS9KpBmBaE6W37ZCRHAM+gmSlCfryqyKl4ebRavIVtufgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332829; c=relaxed/simple;
	bh=pWi/vmUf/yLXVoXJBoZ9BpUQIrWYQG4u6t8cNWfTWms=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=luFCxa0zVTKqBojHXrItHYCfB3fYUbvtpwHsiyBc30gzm8uD1morTsvafU94TJhxSUfPIBuA4uDQL/e7volDDRkwU/+dqSSBK6VJ7BhNJmQjPlcTNX4vIs9mNYLedQvSJkHp5APCfdFi/mgJPZfmLBxcA4HKeOyArO48+qjjGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jFHjcNpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jFHjcNpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E805E1F000E9;
	Wed, 29 Jul 2026 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332828;
	bh=4PHzLg3UjA0JrS7jz1qFyKJjTxxF6O+SmRBJ8oGAa2Q=;
	h=Subject:To:Cc:From:Date;
	b=jFHjcNpoh7D+nr9dUedL7/FNGdgZG1Ch3yAoJumh79dCcyS2Lu0FSH/ljpgf97lK6
	 hMDoC7BE9VGTsVH7A6INnWHb1lD99LdYmUdbYSPFVCu3FzKUjThq+cCtaiG3yG/EMN
	 2/qIPhIuJfLi0p0+Fmsa8h/UHrz2AH6lZWV65c3Q=
Subject: FAILED: patch "[PATCH] ceph: fix writeback_count leak in write_folio_nounlock()" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,Slava.Dubeyko@ibm.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:46:47 +0200
Message-ID: <2026072947-gulp-passivism-4b27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cbf59617cd715219e84c50d106a3d0e1e8ba054e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072947-gulp-passivism-4b27@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cbf59617cd715219e84c50d106a3d0e1e8ba054e Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 4 Jun 2026 02:19:51 +0000
Subject: [PATCH] ceph: fix writeback_count leak in write_folio_nounlock()

write_folio_nounlock() increments fsc->writeback_count to track
in-flight writeback operations. On several error paths where the
function returns early (folio lookup failure, snapshot context
allocation failure, and writepages submission failure), the function
returns without calling atomic_long_dec_return() to decrement the
counter.

Each leaked increment keeps the counter above zero, which can prevent
the filesystem from cleanly unmounting or suspending writes.

Add atomic_long_dec_return() calls on all error paths that currently
return without decrementing the counter.

Cc: stable@vger.kernel.org
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 61bd6d92ff25..ecf33b66610c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -790,6 +790,9 @@ static int write_folio_nounlock(struct folio *folio,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
 		folio_redirty_for_writepage(wbc, folio);
+		if (atomic_long_dec_return(&fsc->writeback_count) <
+				CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+			fsc->write_congested = false;
 		return PTR_ERR(req);
 	}
 
@@ -809,6 +812,9 @@ static int write_folio_nounlock(struct folio *folio,
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 			return PTR_ERR(bounce_page);
 		}
 	}
@@ -847,6 +853,9 @@ static int write_folio_nounlock(struct folio *folio,
 			      ceph_vinop(inode), folio);
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 			return err;
 		}
 		if (err == -EBLOCKLISTED)

