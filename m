Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96C4ABBB9
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659620; cv=none; b=gTPKUxq8DimqfmgfNUwHVKFtZuuQqr7WCRtJF5anDIeIK908UxdN2aKyiy1FH91DYe5s6P2PedV1IpFNppmiNpggPU38QmXDJG/QSVqVgL+fjqMCiZehZeOJaZCMkxN75gXJI0jULKA5N70qg7wiu5e61YbHl9KaM8kmcMMXiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659620; c=relaxed/simple;
	bh=up4hQX1CGXEjGgfR8R9VDeNf41rFGOHJKf3fKrqNVso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENvVHdiUjzP9Ao5wE04/X0kvBIUJRv2DCRCFNcFSbgCZiUcQBS9E5Acr7OHdTp9Inbevn0+1bhqgvLCJM9S7yfsmEROYNpM5JOPkUDcjQM3sAV+leDr8eTzrfCC+SnaEpjXPqPQ+DqtN2VxR3a5tq7rBPjjBZZoi2YSl/Gb8zUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UNMoZX0B; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UNMoZX0B"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm0Lp0l99zbyZ;
	Thu, 17 Sep 2026 17:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789659601;
	bh=yLNDYvVhc6TmaIPtraEcjWKjxwHl5rTgD+ZX4Kt74o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNMoZX0Bpm8J91+7mGvVRLXwcfK+Y/5NgXxKBN0AGwP/PE6+5+SQYOQRkmMdLEIF2
	 ZPVBoG5McFJrLeLcFY2X3PehL7hN02Ff+lzY5TEI5vSqMr1LrwVNgdR0DW8oIrvYiJ
	 CsTZpbdGBXEPNV29tPlX0mx2NrAxDMo/85TNvXRk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm0Lm643JzCG5;
	Thu, 17 Sep 2026 17:40:00 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Greg KH <greg@kroah.com>,
	Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
	gregkh@linuxfoundation.org,
	kernel test robot <oliver.sang@intel.com>,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Maximilian Heyne <mheyne@amazon.de>
Subject: [PATCH 6.18.y v2 1/3] selftests/landlock: Fix socket file descriptor leaks in audit helpers
Date: Thu, 17 Sep 2026 17:39:55 +0200
Message-ID: <eef8034f2f40b9a452bf27b3f9809067bfb7c5b1.1789655724.git.mic@digikod.net>
In-Reply-To: <2026050420-overfed-obstacle-83f2@gregkh>
References: <2026050420-overfed-obstacle-83f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

[ Upstream commit 9143d790337a0d066c2d632c802f69b981e6c23a ]

audit_init() opens a netlink socket and configures it, but leaks the
file descriptor if audit_set_status() or setsockopt() fails.  Fix this
by jumping to an error path that closes the socket before returning.

Apply the same fix to audit_init_with_exe_filter(), which leaks the file
descriptor from audit_init() if audit_init_filter_exe() or
audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260402192608.1458252-3-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20260502130541.590744-1-sashal@kernel.org
- Refresh the backport against 6.18.y after the previous retry failed to
  apply.
- Include the related audit helper fixes in the same series because they
  need this change's context.
---
 tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index d6d6f5116dc9..f6d7b9ad6016 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -443,17 +443,19 @@ static int audit_init(void)
 
 	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
 	if (err)
-		return err;
+		goto err_close;
 
 	/* Sets a timeout for negative tests. */
 	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
 			 sizeof(audit_tv_default));
-	if (err)
-		return -errno;
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
 
 	/*
 	 * Drains stale audit records that accumulated in the kernel backlog
@@ -466,6 +468,10 @@ static int audit_init(void)
 		;
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
 
 static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
@@ -515,8 +521,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 
 		filter = &new_filter;
 		err = audit_init_filter_exe(filter, NULL);
-		if (err)
+		if (err) {
+			close(audit_fd);
 			return err;
+		}
 	}
 
 	/* Filters might not be in place. */
@@ -542,11 +550,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
 
 	err = audit_init_filter_exe(filter, NULL);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
 	if (err)
-		return err;
+		goto err_close;
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
