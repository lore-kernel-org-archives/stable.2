Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997075;
	b=FKCqPMcbD27J0m1giUmvZCOsFrXKbAjR/Cnp9GW4kGjPzRjAsbf0LszMIaFuxz0ZXuaH
	 YvAHdirXuo3c1zTtRLLE+hBlOpV7VrowOybPJq6KarkQHbfjZPmbgLguMdXr4o8rNFQrv
	 dZKPggPuUr+o3JxU3Z1nNcV4/0LRus+LjeKlwFdC602M2y5UvK3u7ZTxTH71SH9iccZyO
	 RaHDsAGos93LEKq+qj29bpcVRIUwJD8FLveZZVW5kzB619mI04XNIlgK4q6Q839wROVeC
	 78sdQV49XaRMj4JPdrBtX8+fdg42LEPJY6MfBkjMyPdYrjaBfYGR5Hth/HrhRGzS10Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6CmmjYNrH/gQYOfYcMptODL/q5N0/pdgH0i5rjLY/oE=;
	b=xcD/PmFU1oywvvlMJCSm16xntvv/RtBHqlTCpUP6CpWTT6UFSU9lD9mK9rfhQnXfJBPo
	 CM0KCJqRmXE0iZR1RWIpMasCrwnflOgqzA/nHF2lLUq4op/xuNiWCblPn9BEF2qZ5Zbo6
	 oEj/Zp9iNoGoAqwSsJRdPKr+NPM9RpmwNcEadus/dDDI39vOqvrjScgr2sXlUajKooTcQ
	 ppxEB2B8tbMYN2uIHxa2aKW/npnQF7cta8r/1PwFSss2r7NGFHw2p7PwvS4jcWZ48J2bd
	 8o4tV9KSuCKYBQv/2goMZ40eyyUS0TeneiGtbWN/iryV0daUohY67JOa8iiokp2SvXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VihkZXcb;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62E606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C62E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VihkZXcb
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4b8587b395aso130945fac.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997074; x=1795601874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CmmjYNrH/gQYOfYcMptODL/q5N0/pdgH0i5rjLY/oE=;
        b=VihkZXcbxi7XZOqP8F5krstDnEqCdHxwcH+Iwfa4KMARwEcxEISu8v4dhe+G29HoxL
         1Uamjr7Qd7lMK+8xNg7lsNg1Qe4+2c7LAYstMUjIfzeDJHz8iWe+BJ59tXs6tD271WvZ
         pfZ55mdijjWLhWIpvDk8VFIRckBsyjEXfpK/RBb+dcbmjTQtEhP7xgVReqgZDjN4UTYD
         SW8dbkZNZ/YEWBfnui1FHF2P2QuvQIb6VVnsZ58GTZz77ssTcSMBWZU1Y371sxWvsO09
         pRzCZY0DaDOSvZRohyFELwE6yHACt0Nb7lUK2kQUgHRThpjPwizmR6D2sG7uov+xvfIM
         QG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997074; x=1795601874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CmmjYNrH/gQYOfYcMptODL/q5N0/pdgH0i5rjLY/oE=;
        b=Cig5RNpJKaQ8wWUovNL0G/6+4YzqNPMP/FZHjQqkeG0Tfc9qe898WqhZ8DyfYShLbr
         KwsuTa+4b/Pu6s6O6J/lHDUQYAIroaXDOPxIe6pVpXKReokLf31bXQVJzqhydX+noKzs
         LWQBdpiugGTyvSK/dlNjX276L22Fjx6Rq/0BOnsCR5KxojW1dCf76iz5ihTjcJ0do73e
         dlvna7ojaVuixrXQ8lqETlPEoK/NEJ0Z5FWp/B8siCBaTb21K9liYHrdd77qy8WCYZao
         wnVK/4ZfplHGidkefZ8AiC5LwF49PNIn++PkxnEXA4iOAfHLVUVD8nFBSCMG5XQt3mRX
         3dcw==
X-Gm-Message-State: APuU4Z9P+QnXdRSdEUtlql+BNoHFwCnmqL1fi4OlcyaER0MauaBx0hcu
	CFUNDjkJsDaBHIEky9iO4JswCxsYeYzSEBi8/gwtrW8aDY4KUKQfKJtbz9XKMg4RcLA=
X-Gm-Gg: AYBFou3+Qvm4J89e5HiF2ygtQxRv7tjkXgY9WrVepXblREtVnwWnVdZHiKsbV97L6Om
	YW8tvTE1qy1v6Fy71LB2JrvWVoJg2a/79Y1Av0G91Rh5jy8kAd0HnuVeeY//ec6ap7rfI2XGqao
	H1DT654rKjFoCkWxF837PgmKY7MVacNfo5tKjUQVk2NZEPpHaalUtPMxx0sfqHQGO10EgpmME3s
	ZKOPIkwOLSXnLVWViEvkfoXMVOkMp7vMTJsS0+dalNk83gXgsdUtvJOM7P17eV60BfEeTpx8u+m
	gHG1NH/4ROlfcMdeFp28MrD4TdGBC1zK2J6kPSTPnivasUoIiMe3q1ezbGu1xjAmgaeI/ln/bfP
	4eKkzqesa2d6IP3n6Wb9a0gCD4Cy1mb4JU13Z7zaqDBthxtCshieSIhgz5y4dIkrbZnqeaTmVI6
	uVs7oUxAWgxz5vdD4XIQLzxGBQL/cPBWTAZM9bIiTOitIM6fzPydbu4s5JuqYtj+MVHCIowS7vi
	pW7LAsxpjGrlS34jLsPK4hO05P06c9qW+815IJZRrACcR0RPHY58uiWra6bx3EeK2DPb0aNOMFy
	jrq5njovsKPfLdSrAguBVx+YQhXlx+o4Nv374yAa6uxFF1iAgJOOGu2iVtO19TY=
X-Received: by 2002:a05:6870:26e:b0:4a2:809d:8fcd with SMTP id 586e51a60fabf-4b75e828bdfmr1538265fac.35.1794997073633;
        Wed, 18 Nov 2026 02:17:53 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74372cb6bsm1772612fac.4.2026.11.18.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:17:51 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	vadim.fedorenko@linux.dev,
	Yi Liu <asatsuyu.liu@gmail.com>
Subject: [RFC PATCH 6.18.y 0/1] bpf: reject NULL arguments to four kfuncs
Date: Wed, 18 Nov 2026 10:17:47 +0000
Message-Id: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yi Liu <asatsuyu.liu@gmail.com>

Hi,

6.18.64 still accepts NULL and PTR_MAYBE_NULL arguments for four kfuncs
whose implementations dereference them.  Mainline fixed this class in
v7.0 with

  1a5c01d2508a ("bpf: Make KF_TRUSTED_ARGS the default for all kfuncs")

but that commit is a broad verifier behavior change, it was not
tagged for stable, and it is not in 6.18.y or 6.19.y.  6.18.64 is the
current 6.18.y tip; 6.19.14 is the current 6.19.y tip.

The four deterministic reproducers on 6.18.64 are:

  1. bpf_copy_from_user_str(dst=NULL, dst__sz=8, src=NULL,
                            BPF_F_PAD_ZEROS)
     -> memset(NULL, 0, 8) in bpf_copy_from_user_str
        RIP: memset_orig+0x72, call trace bpf_copy_from_user_str+0x69

  2. bpf_copy_from_user_task_str(dst=NULL, dst__sz=16, src=NULL,
                                 tsk=current, BPF_F_PAD_ZEROS)
     -> copy_remote_vm_str() writes to dst
        RIP: copy_remote_vm_str+0x45,
        call trace bpf_copy_from_user_task_str+0x2f

  3. bpf_crypto_ctx_create(params, params__sz=0, err=NULL)
     -> *err = -EINVAL
        RIP: bpf_crypto_ctx_create+0x1f8
        faulting insn: c7 45 00 ea ff ff ff  (movl $-22, 0(%rbp))

  4. bpf_rbtree_remove(root, node=bpf_rbtree_first(root))
     with an empty tree; first() returns NULL and remove() reads
     node_internal->owner
        RIP: bpf_rbtree_remove+0xb, address 0x18
        faulting insn: 48 8b 46 18  (mov 0x18(%rsi), %rax, RSI=0)

All four are LOAD_OK on 6.18.64; the four safe controls (non-NULL
dst/err, valid add+remove) load and run.

The 6.18.64 kernel is built from commit fd7cfd39c885 and the QEMU
tests use oops=panic panic=1.

This is a local DoS from a context that can load the relevant
program type.  It requires CAP_BPF/CAP_SYS_ADMIN (the tc/rbtree
reproducer also needs CAP_NET_ADMIN), so it is not a privilege
escalation and I have not demonstrated an unprivileged path.  With
panic_on_oops it turns into a kernel panic.

The following patch adds KF_TRUSTED_ARGS to the four kfuncs and
teaches the pre-v7.0 NULL guard to skip __ign arguments.  The latter is
needed because bpf_copy_from_user_str/task_str intentionally allow
unsafe_ptr__ign == NULL with BPF_F_PAD_ZEROS; without the skip, the
legitimate safe controls fail to load.  The diffstat is:

  kernel/bpf/crypto.c   | 2 +-
  kernel/bpf/helpers.c  | 6 +++---
  kernel/bpf/verifier.c | 1 +

Tested on a patched 6.18.64 kernel:

  test                           unpatched 6.18.64       patched
  ---------------------------------------------------------------------
  copy_str_null_dst              LOAD_OK + oops          LOAD_FAIL -EACCES (arg0)
  copy_task_str_null_dst         LOAD_OK + oops          LOAD_FAIL -EACCES (arg0)
  crypto_null_err                LOAD_OK + oops          LOAD_FAIL -EACCES (arg2)
  rbtree_null_first              LOAD_OK + oops          LOAD_FAIL -EACCES (arg1)
  copy_str_safe (NULL src)       LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  copy_task_str_safe (NULL src)  LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  crypto_safe                    LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  rbtree_valid_remove            LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  rbtree_safe                    LOAD_OK, RUN_DONE       LOAD_OK, RUN_DONE
  copy_str_zero_null             LOAD_OK, RUN_DONE       LOAD_FAIL -EACCES

One behavior change: dst == NULL with dst__sz == 0 is now rejected.
I confirmed that mainline 7.4.0-rc3+ rejects this too; its
copy_str_safe/copy_task_str_safe/rbtree_valid_remove controls still load
and run.  If 6.18.y must preserve that case, the
copy helpers can instead get an implementation-side

  if (!dst)
      return -EINVAL;

after the existing dst__sz == 0 early return.  That preserves the
zero-length semantics but leaves the verifier accepting NULL; it only
prevents the oops at runtime.

Fixes tags for a split submission:

  Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
  Fixes: f0f8a5b58f78 ("bpf: Add bpf_copy_from_user_task_str() kfunc")
  Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
  Fixes: bd1279ae8a69 ("bpf: Add bpf_rbtree_{add,remove,first} kfuncs")

Thanks,
Yi Liu


Yi Liu (1):
  bpf: Reject NULL arguments to four kfuncs

 kernel/bpf/crypto.c   | 2 +-
 kernel/bpf/helpers.c  | 6 +++---
 kernel/bpf/verifier.c | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.34.1

