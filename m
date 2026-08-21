Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72219470EA1
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306401; cv=none; b=s4pbAPZh2i54ht24GXn66eOygBTt6t7xyWSq0zCcrwzXNrtU/idV7d9p4R3/IjdHiGztSOJtsDly5xKYbr3JwA0oTvFZXTgeM/g6O9x8c0mDdG0YnNDLJophPS1xL23wUbQY+wrReEPGDBV83/mGwMbrURjGmgmnD2K1irrxkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306401; c=relaxed/simple;
	bh=SiMn3BqPiCpQOzGd3YbNwjGLW1tzFnVrSniAKmS5pmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LHaNY3DziCGaYx3LIBbzD05ePzTQ4MB80MMe3kbv+2bptHqN/rliCyvjRm9vo6Zo3yYBHL4qYgTqw0Fe/uQfrZbn3hASOfadDygJhQVlZO4foaglHZ4ZjVWF2dfWLUTfV0GQB0y44ckVsKPKu/I4urvUTDAMuLpxB8lMIeowa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMEs2PwF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMEs2PwF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-395bbae578fso619771a91.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787306381; x=1787911181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MASfaprH7+tFgg5DHxo9bD5T6H4OeE/g5W/L8IgkjoY=;
        b=mMEs2PwFOJEfTPjCJ4cYFn4+7tUs3pmd3X9kObQcZQ6PqdTGq9o/+EWK3h6uuvtm4S
         8bll6DQXwoaTt52+HqC20OsUbIzQQ/56N9bW1tYCcGq2a87DuXK6yAm/FVwqGFihdaXd
         1CVWEQwddkkRKnDMMkIjEP9QUoOQqEwX1XYxL57s/1VkB4nAO2He5muUwxh+qiCMSpNd
         FVuJ36SXVKTum6ZDjvnyJ6UHSzk1ySUuVTpzsU5p+Yr2iDP0a8GFCJ67BiRqoZjcyQwq
         Bgv6ugemKVlWlhncJ9EaJCTc2i+Gkz5IUPPTAQxiijZQ0CDpdrv6SRwmY0sgLIPw72Ab
         hHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306381; x=1787911181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MASfaprH7+tFgg5DHxo9bD5T6H4OeE/g5W/L8IgkjoY=;
        b=ZBL8iDUM+F1ItalWFrInoKIFtS0aRyK+dOVqUTepkP6q539zmSaC1W14A7h2XF8utN
         6w0Em+xr1ep5ADEZf+c6igW0IK5XtOGmv6HrFup5iUsV7Ajncu6oocMty/CZWN3VYwM3
         CgckjH0D+OeSE5zM3LtNQVEacUWrZPppQtXJMUhoo1nBfMhRujrDlXgmghXVzPC1EExc
         8L22qAgKTUr5SjRQbt6GqSG43a7jWr4yvy5Sav4pG5E0M5PlLW0o4AZlOsvOQPL4fzRl
         +5m8fOFKt+CWe9A+jjaK5hZMtB67pVHVFZvdkpzap2kIn+WBmlWtQ9UsR/fTfAhRjLNB
         meqw==
X-Forwarded-Encrypted: i=1; AHgh+RrgbHIaLton77e+QejTAXSoYXW1Ecf7tRYOczfNwVbKOmAvQ++SBq6aeEidSBf2pp4pai6LbKQ=@vger.kernel.org
X-Gm-Message-State: AFuF++la/tLxY+etd93f/qS84g6pmMlqM24+/7hjQ4Ix3aZWQjuMr+HY
	Oik0Y4fwhz0Lqn5IDdjxGju73RpqTPEtUpDFgWWONCBQOqkvHYQlOzOA
X-Gm-Gg: AR+sD11r/3LHmXM6zwAo7j/YUhHL98aUgmqIHhIfwmuI65szUUGNEqkI1g1ZtFSHP+E
	Macj87IK8g1tfjv6qBqCbl6Vgpi3pT1JwPMACOKZNdAALESBVT+de7VlJLvqlP6Isxxa9WfwUG5
	CQ3M/VMw2uiXz+D/l81hJM9kAtz4a2VKqj1Hbd3QzfX2Uxe9Vs7NOpXShnJ6YUjLwyg4pu9HJ8i
	LpNMAM0xD60Yev/uRx52R371Tde4xejHETvw4dwOdnV3MJlWjjCOc/h/uc6QnBEy7+cGQ9Xdk7o
	64d/1EkrVS427aSTO8JL6Q0ksg35E8K0Q/Bp5PLpYMmjCwDl9G3m8z7ldzYPFC5SQ06IL9EZyiz
	2u1bZDF6I5X2DWZ5EyFOFGXIvNCiv9x3Tf20OZNoiRpQfFbrwmFtpept5O1tucH2GGbr6twVXtb
	619TK9jWiR+IFAeAeIBtSioeTdntBa/rs16w3mJhdn4r8ywx39MTWraGPtogKMuMIAAmKmD7TGr
	q+tN9ewBgFw6o2Wci2Dt19c
X-Received: by 2002:a17:90b:5646:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-395c33367ebmr10081913a91.1.1787306381365;
        Fri, 21 Aug 2026 02:59:41 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45530absm2509528a91.4.2026.08.21.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:59:40 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	James.Bottomley@HansenPartnership.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] keys: translate request_key_auth pid for the reading procfs instance
Date: Fri, 21 Aug 2026 17:59:35 +0800
Message-Id: <20260821095935.1864998-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_key_auth_describe() prints rka->pid into /proc/keys as a raw
pid_t in the initial pid namespace. A reader can open /proc/keys through
a mount in another pid namespace. That reader sees a number with no
meaning there. The number can even name an unrelated task. The line
needs VIEW on the key. So the reader either shares the key owner's uid
or possesses the key.

The fix keeps a struct pid. Commit 4f82f45730c6 ("net ip6 flowlabel:
Make owner a union of struct pid * and kuid_t") gave
/proc/net/ip6_flowlabel the same storage. The print goes through
pid_nr_ns(). It renders against the pid namespace of the procfs instance
the line is read through. Commit ad08978ab41c ("ipv6/flowlabel: simplify
pid namespace lookup") moved that print to the same anchor. Output
through an initial namespace /proc does not change. The line shows 0 for
a requestor with no number in that namespace.

Translating at read time was the alternative. find_pid_ns() can resolve
a recycled number. The line would then name a live task with no
connection to the key. A stored struct pid gives 0 instead when the
requestor has no number there.

Link: https://lore.kernel.org/keyrings/20260809110202.2180410-1-maoyixie.tju@gmail.com/
Fixes: 78b7280cce23 ("KEYS: Improve /proc/keys")
Cc: stable@vger.kernel.org # v5.10+
Assisted-by: Claude:claude-opus-5 codeql
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---

 include/keys/request_key_auth-type.h |  2 +-
 security/keys/request_key_auth.c     | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
index 01e42ee5f4099..464636278c4f8 100644
--- a/include/keys/request_key_auth-type.h
+++ b/include/keys/request_key_auth-type.h
@@ -22,7 +22,7 @@ struct request_key_auth {
 	const struct cred	*cred;
 	void			*callout_info;
 	size_t			callout_len;
-	pid_t			pid;
+	struct pid		*pid;
 	char			op[8];
 } __randomize_layout;
 
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 282e09d8fa46c..ed6f55b9cdd93 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -9,6 +9,8 @@
 
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/pid.h>
+#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -73,7 +75,10 @@ static void request_key_auth_describe(const struct key *key,
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
 	if (key_is_positive(key))
-		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
+		seq_printf(m, " pid:%d ci:%zu",
+			   pid_nr_ns(rka->pid,
+				     proc_pid_ns(file_inode(m->file)->i_sb)),
+			   rka->callout_len);
 }
 
 /*
@@ -113,6 +118,7 @@ static void free_request_key_auth(struct request_key_auth *rka)
 	if (rka->cred)
 		put_cred(rka->cred);
 	kfree(rka->callout_info);
+	put_pid(rka->pid);
 	kfree(rka);
 }
 
@@ -226,14 +232,14 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 
 		irka = cred->request_key_auth->payload.data[0];
 		rka->cred = get_cred(irka->cred);
-		rka->pid = irka->pid;
+		rka->pid = get_pid(irka->pid);
 
 		up_read(&cred->request_key_auth->sem);
 	}
 	else {
 		/* it isn't - use this process as the context */
 		rka->cred = get_cred(cred);
-		rka->pid = current->pid;
+		rka->pid = get_pid(task_pid(current));
 	}
 
 	rka->target_key = key_get(target);
-- 
2.34.1

