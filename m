Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429390;
	b=iwKU2S+Rkhm0q8xSZLa32qbPp+JF7T8cJlHdwkDacXgpFlMZ4o7WWx3C6ebaL2Pw5N88
	 vYxct5FEEoX1rR/MZPGh6nJGvMyxm7hhD02fxYgZy5wuzJ7VomqBY9qLP53q38L+v0+5p
	 cULR02TTnIdsOUfushM8l2hJry5Z2dEIuqcU9VWwcUdLXsxMwAxNn8qddv0S67dG/TNp+
	 /U5QUNDKEE/Y4RNK9NjDi+5G/MhnegF33jUTLfiEyaff4RUdKRed57GvLSwGhofjjx/hS
	 nKrSdmiwU+OMR5ThUUU8wG+drHUXCE9bOG3keVWm4NBIrUoUelFok15HU5hZcvQkugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NNGE6UrmGIoih3+sbT7xMKwGPGzkwVpsddz65pffQVE=;
	b=AAhNP9Gv7O0biNEDFsjtc7vJ1VlrdEBG4vgKTNdlJd7V5oZLEzcp630gZFWCW2Z/r3eQ
	 7opZYqQraNlK9UaTvFvYfQAD9EWUVdE0xbHIVMnHSJg7EWxmmqs0dnfHmkl//0bp1pdiP
	 hjPPnQgEwE4hL8JjokmW6rxFw6/sk/gt6uqBhVSkXcyZ4dzWSnqXW0+60j1DUCwR0TKWo
	 CXa8FemMiH6gHroLFjaZiVaksr8qeKkI4P0m9V9UCsvFTaTuGNufCw5PRAkLtA+2fBjVE
	 qprf5YolPVC1DxZcRtoB9fPJafSc0m9uIctvVdm5blGZpkGgCzATbIR1U1OFp9HtNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=ZVLF+vIn;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39008606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39008606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=ZVLF+vIn
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so42207165e9.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794429388; x=1795034188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NNGE6UrmGIoih3+sbT7xMKwGPGzkwVpsddz65pffQVE=;
        b=ZVLF+vIn3YWx2xaDmvc4ASv3P9waWwcCVU3SNR2EwPknjDiIZ0Jza+Xvgr3YBC0Cgj
         3LfwimsG8o+30npPVueJUpJopy8NgZo9x06PHOpgTfwTH4+V1m6DlG7eC4Y14rvC/KCz
         yu/+eMbK2BILgpIfzjyOeaR+LmTzbuoX2BAcvkNW/Hc1WMSnC9a1MseEp5BPHHifG5oG
         pvvUWM2EGZCA13ilunkCs65OLsASUAPYKwV/ysKdDj1YS2PAvKMzx7bvoSwPLPXyVgLF
         88IXM+BMVRhCvw1foZSljOGbFi8dglkxfieGRuuxJ+3Eu8jwkKLjIm64HEKbZdbM+OHS
         1aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429388; x=1795034188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNGE6UrmGIoih3+sbT7xMKwGPGzkwVpsddz65pffQVE=;
        b=M9bcWQrVZryczeisg7l2xkt8HoXxts9H+KtUMjLiw1v3DK88iFzlzeXcxAgo2XXYON
         hFeEJNsFWPaxZB9+2vNawKCN3uGrADGIuBrlZMGVWmNiR7YXHldTWQpCxlPjD5KdmqeD
         8aTwS7ysKmSgrqOV4P6bhqGsayH+K1vYA9G44YeX3hva5KvpqcvMy1btDuguaFdM+6Qi
         tV68OHrN+tI/Roh5NISFWdAX8XI/FVktzX3kNswer0VAikpBUyb2O57+Vd5eW8GSJ6iY
         JBbFm1BrrgIZ/PPLhYnM34WYwpbENA9460+yHKWtmKJ31B30UyIR09vnPw1QLGcND1Up
         Oiqw==
X-Forwarded-Encrypted: i=1; AL+hErHmuN3gUL13ASdzSsY4Sa6KqWDWG44wWX8to37t0XONLXcpN0g6FpfimPEOKDq0xWA3oq20AsE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eY7y/b4l3OpiZv1nVOQ+ZDmfccIMbvZXq9NtuAIXILR6A5oPA
	hWwqVP0CGpjzjZd3kEukvyq/lpzoBa3wpFeaB67kjlHuXl8OC5we7jN2/ow9t+ohCexe1D9aU+V
	8gz/EKwQmLw==
X-Gm-Gg: AYBFou10duXj/3A+JUkFO/2z0msEFJbpQO3KDi1LfcSfXbBDp3bsH7d8J5B4/7ltV9c
	fjxuwY9Q/aIALZ+Sv7fulpb+MYMWbefu4KBJCl/2kuUf5JLV+OLHi9F+Ub68FcfEVTPtrXoekq0
	SI/2nlgnGjNiq3BjyHhnhB5Lbxc33KOmvx/YBH45UhsFmoAyx36cQS10fI/MwVwHrvTYVynjSeF
	ye4bWxXNuCtFklwB3CLAVSbUGejDzdyF6ftY9m7aQ0ZkWktWvbLlqBZP9PnI+Mi4B6G2ATqSScN
	a4CIAp7ak/JDv47htecK9WhmzzdLld3bKWrVbkmULeal4+jQDpj4s+GGTwly9DVmvsy9lQIq3gk
	vobhFH1p2vaCdYkDFeotpYVCBx/8A5396yo0s8Gg8OrqUzFVpqxhvlR2PldSeTahn8KbR/CzWX8
	yAA6lKfFJFoKjwMLd4rRvtOCOWWzGnCGper5rnTYrLIE0zwOG7G/cmKqSthQzqp6gZE1p27haNL
	KK0aZ4tk7aaGANkvZiotTLQcJqS2q+ZOcdxHkJOP8U2bwMMxwbgNjLDeuLwqqrDoZxfYq2EfmZf
	7bJFhxLJb9jfqufYdg4Hw0kymkN+eyAL0QTH74M=
X-Received: by 2002:a05:600c:81c5:b0:4a1:dade:f049 with SMTP id 5b1f17b1804b1-4ba09376130mr58077175e9.15.1794429388649;
        Wed, 11 Nov 2026 12:36:28 -0800 (PST)
Received: from winnie.home.arpa ([62.4.45.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e258e8dsm21071525e9.4.2026.11.11.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:36:27 -0800 (PST)
From: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
To: bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Sergei Nizovtsev <snizovtsev@cloudlinux.com>,
	stable@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Serge Hallyn <serge@hallyn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, lsm: Mark backing_file_alloc/free LSM hooks as untrusted
Date: Wed, 11 Nov 2026 21:35:52 +0100
Message-ID: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>
X-Mailer: git-send-email 2.56.1
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

The backing_file_alloc and backing_file_free LSM hooks get the backing
file as "struct file *backing_file", but its f_path is not populated
while they run:

 - security_backing_file_alloc() is called from init_backing_file() in
   alloc_empty_backing_file(), before vfs_open() sets f_path, so
   backing_file->f_path.dentry is NULL;
 - security_backing_file_free() can run for a backing file whose open
   failed and whose f_path was already cleared.

Neither hook is listed in untrusted_lsm_hooks, so bpf_lsm_is_trusted()
lets BPF LSM programs use the argument as a trusted pointer.  A program
attached to lsm/backing_file_alloc can pass &backing_file->f_path to the
trusted-args kfunc bpf_path_d_path(), and d_path() dereferences the NULL
dentry on the first open of a file on overlayfs:

  extern int bpf_path_d_path(const struct path *path, char *buf,
                             size_t sz) __ksym;
  char buf[256];

  SEC("lsm/backing_file_alloc")
  int BPF_PROG(poc, struct file *backing_file,
               const struct file *user_file)
  {
          bpf_path_d_path(&backing_file->f_path, buf, sizeof(buf));
          return 0;
  }

  # bpftool prog load poc.bpf.o /sys/fs/bpf/poc autoattach
  # cat <any file on an overlayfs mount>

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
  RIP: 0010:d_path+0xb4/0x810
  Call Trace:
   bpf_path_d_path+0x26/0x70
   bpf_prog_f8f2e241d4ff7217_poc+0x33/0x37
   bpf_trampoline_6442521065+0x61/0xf9
   security_backing_file_alloc+0x78/0xe0
   alloc_empty_backing_file+0xf0/0x170
   backing_file_open+0xfd/0x290
   ovl_open_realfile+0x1ed/0x270
   ovl_open+0x1a9/0x2f0
   do_dentry_open+0x404/0x1280
   vfs_open_consume+0xba/0x4b0
   path_openat+0xc4f/0x1f60

Add both hooks to untrusted_lsm_hooks, next to file_alloc_security and
file_free_security, which are listed there for the same reason.  The
program above is then rejected at load time with "R1 must be referenced
or trusted".

Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
---
Tested on bpf.git master (475a0cfd02f1) under virtme-ng with KASAN: the
reproducer oopses without the patch and fails to load with it. Only the
backing_file_alloc case was reproduced; backing_file_free is from code
reading.

 kernel/bpf/bpf_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f58dce888ff4a..f39a3766f2245 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -411,6 +411,8 @@ BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
+BTF_ID(func, bpf_lsm_backing_file_alloc)
+BTF_ID(func, bpf_lsm_backing_file_free)
 #ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
-- 
2.56.0

