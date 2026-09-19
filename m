Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A846336897
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789790040; cv=none; b=JaVux8ZrnF6UIDnir9UcKFWf+axhuNZFaHSpffqBOFUGiGDUHzd8e5UTTjIhAGi1myXQsupuqKIGvhGlYgkEbdS8ZkgZ2AQpEPubiY7ej3zcmUXJbzaTQH9JSxat9V+ffbQK2gCtHV2Nmp/bYSNFkq4i/Ajs5e4bnYIrS2zuPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789790040; c=relaxed/simple;
	bh=ar2zcNlv7+c1OyTtkaddUuGasqJNqHnuUoJCpv2NdIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1JpiS/vNyWHSR/M5gMVwQ8P8zQamUNeIQQ25gQzsqbU3tEoFFTBPCqspsvyAcKgjomk0UVhQNehjvBMOVVv1CvqDSt9upiBXxFfJLRn+H7SHN5nWJRZ+Qb/6tT9902NRQK++Pb5KFMaUh4P9SDy+Ut6lhUzFQR8+keVlgjcvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMW7Rq2U; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMW7Rq2U"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so1192200a91.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 20:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789790038; x=1790394838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vINPVP5099LZ8ihUeZp3zwJQXFHBAyqFeLchbfWgNgA=;
        b=GMW7Rq2U6iBEIU5Camq06FyvBFRmvxCvNmgq7F55xS7rqCbz4sS8Owb2vP2W7ajGIa
         MYkQy50pfCiBGWsrmUe8h/AWPZ4jWnRnC7c9cLzLMwIo34gOt/Gwni9UN1Z1rKkR3+zR
         idiiBgG2nertauxD/eheJ4OtL5UdNclmwa0spVlFpcojo+OvZQLY9vuBAxFRwsKkFb0K
         QpPuksMAUJ9x/55YN3M6a8VJPwJ4+r+cJD6O9twIz+/qb6CIWcaWLjd3algWN93NwZS/
         GTJjXXVQ5sDe07BsHukcjMcmun+K8n0tlutL9pbgtEGvH8WDxCoXHv6U1KPZcktJqdKT
         tcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789790038; x=1790394838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vINPVP5099LZ8ihUeZp3zwJQXFHBAyqFeLchbfWgNgA=;
        b=wf3ilw2hSP6CcwteECFiIi0mhagNvoa2Y4fhvEPYXwz3sioCZg2yczKNFUfH5NRYux
         D6du5wKwgkGi2olU23jfOaqMdRl6E3C/tNTrgN5aQrVtuqetS0hGjyKugiM47FUr0db4
         JuSbLHS5yhhF6Egs9OGEkuJczpiS+qvqGm9+hh+6eHZsyYYlMxfrV4a1A3ujIOXosApY
         CsHzWObtNbdv64H+jjEuBG2X137u5JnM9lqk24+KiYKNztCIx6sFG7xvEOU1maccMRGJ
         aGwO0wtT60W1H0uV86P9Svbqp6wJQwDfb0eFRcZFnD1ArgYd+wStwigaoprYa5SBCi22
         Yl8g==
X-Forwarded-Encrypted: i=1; AKwUvBy34lU4gCzdcNLJNZeHE3HJsFFqMME8yzmLkcLya6+vgoKf4Dr00Gw50pLuXIIUwSgUXuWXpu0=@vger.kernel.org
X-Gm-Message-State: AFuF++nrKqyqlycrXGlZpbVVzj0rCZf4JG3QoomLDm1dDR4QjyR4u2UC
	XAJ+ACFd3Clq8Y4UKMxF9uSAEXQiKeDHi2fXxb9hNQkIXoK1KpwhUtuO
X-Gm-Gg: AYBFou0H9jJN07f8xSY00gyWe8dhk7/ZIloLjQ87GUuDCLAHekXjFpgF3J3XqaR76V9
	78A2bJVPgiRqrmVFSmF3pWM6+bhX+y8bKv8dXxO5qUTmqOWLQicewaRGJdlAX5tfcyN5Pm4hzrd
	WgD6f+VY2z2jEWS7d2XgemZpzStI9OMpQjzhh7ya4p7UE15keu6dAuNXGA5aXDNbweih3/adjtr
	mIMJkwxLnQyaTBpiX2tAn0KHO9gXNe9QsdFmGM7mz/VpYiu0iGU4LSNLaSrpLpHULnXqi2E20yy
	DEukj99Rrf7mksQkXFOUZWIovUZ8D4i6kK1IHLrbArypuyzaoGcYim1SC4EUc1kpy3fzapaUUN0
	iNSyvAL2NSa4Ig/1pZoX8NK5W6sIDqFPJLuQ1GFX5xwHs6VlFvVIE+ZSQ0nDFhKn/yXWV/vnJxM
	z8YXDz1095AgdyQwMztenZMC8JzaeRh+3+uhin+kSuzc6xTPOxUMApbLKvFeleNVTaZX4SCoUvx
	1jxqqswlU/slMPe
X-Received: by 2002:a17:90a:e7c9:b0:39e:6c69:7771 with SMTP id 98e67ed59e1d1-39e6c69794bmr2720506a91.26.1789790038175;
        Fri, 18 Sep 2026 20:53:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:814e:e9d3:767e:9a2a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3607csm2287560a91.16.2026.09.18.20.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 20:53:57 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Rafal Krypa <r.krypa@samsung.com>,
	Zbigniew Jasinski <z.jasinski@samsung.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+fa63184795283ac3f842@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] smack: reject relabel-self writes from io_uring workers
Date: Sat, 19 Sep 2026 10:53:51 +0700
Message-ID: <20260919035351.88453-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smk_write_relabel_self() calls commit_creds() on current. When the write
is issued through io_uring it runs on an io-wq worker, and io_uring
override_creds()es the submitter's creds when they differ from the
worker's. commit_creds() then trips BUG_ON(task->cred != task->real_cred):

  kernel BUG at kernel/cred.c:376!
  commit_creds
  smk_write_relabel_self
  loop_rw_iter
  io_write
  io_wq_submit_work
  io_worker_handle_work
  io_wq_worker

Even without the override, committing creds on a worker would relabel
the worker rather than the submitting task. Refuse the write from
PF_IO_WORKER context.

Fixes: 38416e53936e ("Smack: limited capability for changing process label")
Reported-by: syzbot+fa63184795283ac3f842@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa63184795283ac3f842
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Reproduced under QEMU (x86, v7.3-rc3 + 00834fcb20d0) with a small io_uring
program: async IORING_OP_WRITE to /sys/fs/smackfs/relabel-self to spawn
the worker, a direct write() to change the submitter's creds, then a
second async write. Before: BUG at kernel/cred.c:376. After: the write
fails with -EOPNOTSUPP and the program completes.

 security/smack/smackfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index a72bc7fabea9..0061220e2d00 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2678,6 +2678,10 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
+	/* commit_creds() must act on the caller, not an io_uring worker. */
+	if (current->flags & PF_IO_WORKER)
+		return -EOPNOTSUPP;
+
 	/*
 	 * No partial write.
 	 * Enough data must be present.
-- 
2.43.0

