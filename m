Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C638F929
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324920; cv=none; b=UUZOPcu8u49f7ED8DQk9naGxalDdm1+Vxdu/MRiCcv+5zHd5vC4qRHtdlgwzxPXrfp51ayG2Nf+jU43I0tYyl4kaYX0+SOlRxSOyiFJUrckafkw4Jme0Fy2evFpqBmWlJ9lTxtizoO+9ne5G878/QtO/wVXzWFKpw6Lb2lZxpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324920; c=relaxed/simple;
	bh=ghQ/9xt8DgBORrjhLrSEA9dJjEGaqnSP7BZJgTBYASA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vr/LBuJX2naiXANloUFlqCTFraSJ1XwniBO7G+HevaGBoNJV3F9hA93owrz1v/0NqizwELpmT3YLI9ZvhkLsdLUnBepXBQLGqqtX7naI4DNMd6Kci5vSU9ec9Vyqq0XmPkRzYiQKJDpLfMaRtMoCWHYwpbQX0oGOyefyGoO+LsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EVYTsYy+; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EVYTsYy+"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6d00d120b28so681534eaf.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791324915; x=1791929715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3b6Jf8//LXq1nt0lrU3uzCZiYGb3bLhSCGzIPeVAOUA=;
        b=EVYTsYy+IV6MkpLIcZQ/qfzqJgIrzF6XDRBpFNlaX5Yo7wWcvJZ3r1EpY/2bO6J/Ih
         zczCuNOmAnzJj/OoFT7CAMa0lDZe9VwLhoPLEd9uxcwN8kYiHPRgAEsyG+z57o5Ctrsj
         /TnRnSbaCqgwAbBRzFgRWA8s3h/4Ao1JYqyoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324915; x=1791929715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3b6Jf8//LXq1nt0lrU3uzCZiYGb3bLhSCGzIPeVAOUA=;
        b=psMeLaYQdUg+n1fstk35hmxU+YWosIkqQ+DTUZ5XjupqwXSGNJxWevQLhKra2WmXGq
         N49SyAtpRYqYODSQtUc8fIogKVQh6rso5N1vEYBdSuKHtsDwxOFCNvTs0+prwDyM2AYr
         nT13N5vWS68sPZb4W958YaZ6iA3uzTSaElm6N0y4NXbAC6B/dZ416f6ian7stx9o+bQx
         jEEYEEGVvzmey5hlgeokgVeDKfLCRic/V98J6HZlD2cvw5S2CX4wka5i0SZ1g+wvy+sY
         MC2boGC3J+XdwBLwCdjskzx3d/L5cjs9Y16hhMWfF/tKy4a+ciyMKAQGV6mq9I0QW7iS
         nNtA==
X-Forwarded-Encrypted: i=1; AKwUvBzMaSJkMN7b9tqpwO/sgGAkXKjBlVsS3g/0lCUiJv/lLVzS3ZC598AZ5WsCNXnQKQDq+qlRUS4=@vger.kernel.org
X-Gm-Message-State: AFuF++mxbbfH72Q/fVXhWlWUs27+JEnKiP2bURH6pqxT0RtXVmrnDh8a
	KS/09NBg0I+mPEqBiCV68Fn8+SXYTCjD7XJVUPWsXETrymJFEJ8neDXh5DN5qqrPYyg=
X-Gm-Gg: AYBFou3yud5JD98gDziIF4Ttb8LetJyu6iKcvVvQVtWEWb3KpYUsLaOX33N0xR+/tID
	rpg46F5gCsDxx0CCF6jwYAVSrDNwm4yEKXWAOCiz1qWRpkjqA9UPmPj2aNMjZWgH06k82B/Jl7v
	n484rzFcnv5mjhEivSQ1y48kR4FUZ7NAGBQK1cA1niM9lND/frkEEHzMzYO8pYyfyRDukHxXHM9
	eelGlnmchoOVegM23EyGhr72KwZjkGZ1ygn5uD9KAp7M44lwI+TVa1bPtqQo+W83BI11/zTNU8K
	Kd1g8J66pQ/oGyJkJsllPw3cSWnoaBMnpn8/ssNH3p16lmX7QlKXJ+6is2ZFswrs6FQSnqDPg1A
	+uOWZz/Adu3GBAwEyN/buSt3Ox2WCAM7vuqskIjshAvCo/9avckbBH7upQY4X93juEeJWCDTk0W
	gEyEnbOBGQHwrG5Y4MKlEaioSZ6STdkw67HSMYeDVZehWM344QsqzL12vr+t7UUG3XaoV3fhq3h
	Da5ySr5Q1cDIl+Kzao0KkwwMy9l/45lbJhdeYLIcNFc8f16Z4aAwXS3RtPf7cAAtJJnekwZIVQb
	t1zzi2ywIg==
X-Received: by 2002:a05:6820:7090:10b0:6d9:8fed:b732 with SMTP id 006d021491bc7-6e7a8bb924dmr455388eaf.56.1791324915076;
        Tue, 06 Oct 2026 15:15:15 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2571cab91sm565412fac.11.2026.10.06.15.15.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:15:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] exec: snapshot the dentry name before setting task comm
Date: Tue,  6 Oct 2026 15:15:11 -0700
Message-ID: <20261006221511.35798-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an empty execveat() pathname, begin_new_exec() passes a live dentry
name to __set_task_comm(). RCU keeps the name allocation alive, but does
not prevent a concurrent rename from changing an inline name.

__set_task_comm() measures the source before copying it. If a rename
replaces a long inline name with a shorter one in between, the copy can
include stale slab bytes after the new NUL. The subsequent padding starts
at the old length, leaving those bytes in task->comm. An unprivileged
task can observe the suffix through a count-only syscall tracepoint
filter such as COMM ~ "*pattern*".

Take a dentry name snapshot before setting comm and release it afterwards.
The snapshot retries concurrent renames and either copies the inline name
or holds a reference to an immutable external name. This gives both the
tracepoint and the length/copy sequence a stable source while preserving
the selected executable and the existing comm truncation and padding.

Fixes: 543841d18060 ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/exec.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 819643408e6d..34cf557a17f7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1279,19 +1279,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	if (bprm->comm_from_dentry) {
 		struct file *comm_file = bprm_identity_file(bprm);
+		struct name_snapshot name;
 
 		/*
-		 * Hold RCU lock to keep the name from being freed behind our back.
-		 * Use acquire semantics to make sure the terminating NUL from
-		 * __d_alloc() is seen.
-		 *
-		 * Note, we're deliberately sloppy here. We don't need to care about
-		 * detecting a concurrent rename and just want a terminated name.
+		 * __set_task_comm() measures the name before copying it. Keep
+		 * a rename from shortening the name and exposing stale bytes
+		 * in the inline name buffer.
 		 */
-		rcu_read_lock();
-		__set_task_comm(me, smp_load_acquire(&comm_file->f_path.dentry->d_name.name),
-				true);
-		rcu_read_unlock();
+		take_dentry_name_snapshot(&name, comm_file->f_path.dentry);
+		__set_task_comm(me, name.name.name, true);
+		release_dentry_name_snapshot(&name);
 	} else {
 		__set_task_comm(me, kbasename(bprm->filename), true);
 	}

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.53.0

