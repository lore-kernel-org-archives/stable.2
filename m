Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7B25332E
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186002; cv=none; b=dx5z/Ay2bqnQ31VBno3o/u+/SQB7Ok8R+pnakSWqcviIefG9e74x6erCPP92LdTrdCpNVoFykZshMXHEIeqGEvIIUTMa6hNN+hguWOHfllynrDnUmcHamnrayGK3lTixCUAUciHMmd5IVH7wkuuNIyMr4X+ImJpSveNxWYtamNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186002; c=relaxed/simple;
	bh=NCz039vHs/fl30ezvjW64zEgeIm2ff9iZ+ZGvhfzZqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgJNbE+6R8OnTIquuonL1yIV8fZau1W0ksWE28GDpAO8SCbMSC1iPZsE0VBY5tNizmLHJw7htbCoj1g75VNlw8JKusJ0dOp9zDmfoTDDT8rT4305uCdk69ywErbShqQGVZ8G//eoOsWhAS2bc5YFZo1ZyJCtfRmxKej51YXhU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfA7S50y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfA7S50y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCF41F000E9;
	Mon, 27 Jul 2026 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186000;
	bh=cWxS4jUmG6bG97/23XJHII6atE34B919fhQf4XAyrYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LfA7S50y/EBN0HyzBNxp/8cD3zIQjI8UoSuhgc0cQJDQNLhYU27GIw2MtKmWwTXru
	 LSvYaeyvaHF3E3YmMdPLWUuwkEoeXEBaheUSAD4jjmw70hm1WQN9NimZMRRbHMK1DP
	 81JBWSeAqsXHNLiaHAYVOmWbc7kse1Nqo+lJ56L9rDlSfgf/b9HRX2veDRnhFNvWtl
	 oIoBxhdRJqefQoadyZk1wHSDLH7IS/OFPRNfBy3uRByYiSDFWmu6G+01KdEitB7yHh
	 qNRKF3qhF4+IaxGmFyCWUuuOBuLYLKGMumz50SL3R3bpZEYrE5naptHPH1pBWVYWKX
	 96Z4jUzsnZBFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] cred: add kernel_cred() helper
Date: Mon, 27 Jul 2026 16:59:56 -0400
Message-ID: <20260727205958.1929027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072016-oppressed-overstuff-75e8@gregkh>
References: <2026072016-oppressed-overstuff-75e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 4c7ceeb62d3330b6fb2b549ae833a92c0f481f3e ]

Access kernel creds based off of init_task. This will let us avoid any
direct access to init_cred.

Link: https://patch.msgid.link/20251103-work-creds-init_cred-v1-2-cb3ec8711a6a@kernel.org
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 981ccd97f715 ("dm: avoid leaking the caller's thread keyring via the table device file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cred.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 89ae50ad2acea9..8ab3718184adf8 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -20,6 +20,8 @@
 struct cred;
 struct inode;
 
+extern struct task_struct init_task;
+
 /*
  * COW Supplementary groups list
  */
@@ -156,6 +158,11 @@ extern struct cred *prepare_exec_creds(void);
 extern int commit_creds(struct cred *);
 extern void abort_creds(struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
+static inline const struct cred *kernel_cred(void)
+{
+	/* shut up sparse */
+	return rcu_dereference_raw(init_task.cred);
+}
 extern int set_security_override(struct cred *, u32);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
-- 
2.53.0

