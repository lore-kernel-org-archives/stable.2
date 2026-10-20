Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493438;
	b=l0Rwk4ZaFx5ZFcBFtlgyQ/UutqYRA60yXmInlaYUpgBcU+5MiCsyuTbgYdgdlZ0fwBLc
	 f0xnVAKC8XxQGV8Rem7T8oBMjf0FT7FQguJ8BnOEuYl5qK0je9IdqfGqunrUV4s8cZ4Sv
	 BjC9TF5/hHD8zAUVF0eQxUcYmRReU6J8AlJF3RrvcYIBWyHHFQjByexIpzc+Qsq4/06G/
	 1mgy2ar8j/qGul7u21iK4tbYA47rXpXFn1eqvTb2I3g7P6yE+og2KQRRnYA/RgWW9lC3J
	 Fb35YXsZNop/6l4L364qzfFLtfZM1wdmgCEZ7rzHiJRg9wOMWMXcEmP7/RFxNsLsziA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MhMu5FEtXkntHOOeoX3WjHhxNQ8l3+u41N1zcltWVZs=;
	b=UQg17SUr4zcpbxez6KNjYVYpGULesyO4CE5WCqPMk2Jtklg4gfMmheA3RFhXRrJymThR
	 CqqGVBc/ipw0Xi3LPgSMFijBU2rjZVY6FK5g3bKpp/1HTioBuD4ergF7wr21RI5K2ElaI
	 vzp75cnyOp8USe3W/kbfxtUTlHGfSjB1A160ZY1LAOlAwMm73Bf1LmYrIpOVl6ibE9Im3
	 XFGGfiFHHFBEUMmeFYPzrNwXCrqJouZZXdN8BpaxaStjqJSScVIuL/Sj1kFKea/xeUA9/
	 2jNk1eCAFDFmWuyvwRJu6EG8wb/DrHSXBevIIIkoGY/j8XwM5b1TBjhme+35DHsMhdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=n+VfWZJI;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726D60A262E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A726D60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=n+VfWZJI
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so2273274a91.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792493437; x=1793098237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhMu5FEtXkntHOOeoX3WjHhxNQ8l3+u41N1zcltWVZs=;
        b=n+VfWZJIKH/eHZfmEe72UdQhnBP9Je9qNV4IRjnamQjgVdBQhPN9njTJVunf0jOrP6
         oYbRpWsnOoeTevf0f/rjBxqKCdsWFINxEEZI79dSqk3R4Yyudue2Ks6o+EbPdSnADKWN
         vDd9NZskb8KiLYgFUu10H3DsdkBofXbMl8JgNtb0j4e0ms70854zd8g0gCy+5zqLOb0T
         3o4yrg0G4k+pJSzQiZ8Buupx7mDS8oRYfi1TEBlMDZ26NshhM4qoX6RaO0MUIlmYZtcI
         uLZ8P/FtRFJOJ3EqY+p2tI1qJnPZgP5tXs2fu1vLAYm4iD3Mv69nNPVojREEGl2EgQEa
         kkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493437; x=1793098237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhMu5FEtXkntHOOeoX3WjHhxNQ8l3+u41N1zcltWVZs=;
        b=xblR48RQmT9Qnye2INXo0qVggm6qeTFXLmrlkTs0cCCvEz90yW1k1DL9zUVkwOQCRk
         LKVPFKsIT0fLhCe1QzxTH2ArcVLjGxn+XczcfWhGWaLh9CDcQKGjj7h06yRfwhJEgcGd
         PLT53P9sUyauAqLbnGB1Azcecu3C+B+Vu74g0Sfj/VS0R+/xaRMPSCInoeLbTG2rZV0D
         kQCL+SQhXHpB3IckcQzeiqqnJlrHjUsilqrTeycj/vhcbV/NCg0equbzN83z5H2EApYd
         Yz1RLNG1P6xw1gAWComhUoNKc+ogoGU+oG0DB/ESwwSBwXgNj5SUsnXq1KX14ucMdMu1
         /2yQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5NxlfCpHhuiBkcaz9rUeRAg5wbqyqeU+D0GObwd+Vc66VAVxyyVKkeedARTtBJK7Z0Vc4r6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXIFcet/c2o9zK+w9zdyMgVtH1u9FZL0sEkvUh2bOjiHTc0g7d
	2HD9S9ap/bC9LTR20xm1c+efj+johDdJFi3uphkFT4UCwGbx/gDVxa0KfpxrsQRDkUKj
X-Gm-Gg: AYBFou0X334/sIk6vZavdCLIViRqUMXfICH88fvvpE21DArt626bhPflF0QQNcIcFDT
	+vC4FaAZ417AXC/bgpe0HRmxzNEAQSbg5ZN2eGcqkLq4FQNwIpl79L/qXI5FAKjVt35L/Q9LVS3
	TrYVcSjRgJQ5h8yBTxFuIpDbS+v2XAXJ+mLcIWD3DvI6huN7SrFNvGfTZHcmXgvtWwXNfBm1ame
	cl5u8NdFY6mfeW2v3mx8m9nPrbhuvGNc8z4jQY/wQLZnz9RplY8zq9u4+qsW7GxqV5XG7Mk/fru
	6pWpfoyh4CU1/5qRDrF6+HZaF8O26BqIWIH6z3D85eRefhK2drxwuEMiICxiQTQM0orcHPuxD9N
	MeiisPiR3VrSeOG0rc9LHFGbpOBGrMQ5gTpIphZ57jHYfict3XrsxIp3CC1SJ8Q+coZgTjC5j/b
	7N7AiPW6kfiRbur6ZLvASY+aQbFAACooQ+ImeYGSx8znZsLq9ZCPt16zLZDEX5BzKsNHxzgNtjy
	havokTnGUrmSy4BzsaPaCfvtlLZlFPZX6ViwT/TYrawpBDYitn3GWS5
X-Received: by 2002:a17:90b:5109:b0:3a7:ef4:164b with SMTP id 98e67ed59e1d1-3acee2958cdmr7889908a91.2.1792493437009;
        Tue, 20 Oct 2026 03:50:37 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f36a5asm3487902a91.9.2026.10.20.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:50:36 -0700 (PDT)
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Matt Bobrowski <matt@bobrowski.net>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for exiting tasks
Date: Tue, 20 Oct 2026 21:50:13 +1100
Message-ID: <20261020105014.97985-2-matt@bobrowski.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020105014.97985-1-matt@bobrowski.net>
References: <20261020105014.97985-1-matt@bobrowski.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_path_d_path() passes its path to d_path(), which resolves it
against current->fs through get_fs_root_rcu() without checking that
the calling task still has one. An exiting task does not. do_exit()
calls exit_fs(), which clears tsk->fs, before exit_task_work(), and a
file whose last reference the task drops in exit_files() has its final
__fput() deferred to that task work.

A BPF LSM program attached to security_file_release, which may pass
file->f_path to bpf_path_d_path() as a trusted argument, dereferences a
NULL fs whenever a task exits with a file still open:

  Call trace:
   lock_acquire+0x8c/0x218
   d_path+0x270/0x378
   bpf_path_d_path+0x28/0x80
   bpf_prog_9801cf2b982f05b2_file_release+0x1d0/0xc60
   bpf_trampoline_6442515074+0x7c/0x100
   bpf_lsm_file_release+0x8/0x20
   security_file_release+0x58/0x90
   __fput+0xcc/0x320
   ____fput+0x1c/0x30
   task_work_run+0x88/0x100
   do_exit+0x210/0x3e8
   do_group_exit+0x3c/0xa0
   __arm64_sys_exit_group+0x20/0x30

With lockdep enabled the fault is taken in lock_acquire(), from the
seqcount read in get_fs_root_rcu(); without it, on the read of
fs->seq itself.

Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
is NULL. Only the task itself clears its fs, in exit_fs(), so the check
cannot race with that.

Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Bobrowski <matt@bobrowski.net>
---
 fs/bpf_fs_kfuncs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08f0847c4970..6665a78218e1 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -87,6 +87,14 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	if (!buf__sz)
 		return -EINVAL;
 
+	/*
+	 * An exiting task releases its last files from exit_task_work(), after
+	 * exit_fs() has already dropped its ->fs, which d_path() uses to
+	 * resolve against.
+	 */
+	if (!current->fs)
+		return -EINVAL;
+
 	ret = d_path(path, buf, buf__sz);
 	if (IS_ERR(ret))
 		return PTR_ERR(ret);
-- 
2.47.3

