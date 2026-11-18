Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012020;
	b=frzQv8WfEN7L4ee1OHSZHrwMEVyCnxXl+M7KSF5oKN1wkkLEtXPMVIHWTAK1UK60IKTe
	 Fh0ITZKYyVzDzCmJb9YkODVlV9BbXUuSW+oy855pyh8ZRJCebLCgT4HLF4dOc+oaTQyCD
	 cJykBGdUldMUaN8x6kQb1eZcFnPVCbArcsNECfuP6Wi+a/8QW2vDAzYrJJALg+nf31v0y
	 I5CEUv2HcqxR5Ll9YLxI8BlzZQoub0y/R+4wqBkWAyUsRxiResiL6YCuymzNfjjwASUmG
	 YRazllTcVeo81p4G4pHYYbHgEx0rvfivlqVLWp4RPp4Ye4VaaSbx8NWdsFrbM3xpu1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y7AldnFPFwd28q9Fb7JfwOQSIJZmwrcTj9ZEfGyxga8=;
	b=ytANQ0sVUR41GbiE6sbZTTa/hszxeOoVuUkmPPk1hVbKS1HuG4RFHJeuysY4ifrnsP96
	 nPV5zSUjK2nwRfyWER9rd/t1bH5BLaRWLG17+pulZO0nspm22rLfac7Z50y2GETamPYny
	 4tVM6Mv7fsYoybQO1RCIQ/2/MHpPdu0SLwIdF9gmSqWE7315uz6k4JDEtoAYF9dVYXLaK
	 UgmT9+WpoEwDz1Q1T8olx8H26ePg1k0Zwe/tuaNuXSlKUbe2GYVy/hvkYIJ6RSOxvtM5B
	 pBSelLliOg9nQA2Hm4f9jQtiVw3bnBxB8m/XbEerr1cnnUUaeVify8ISMvZDGbWk5YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0STMB6LJ;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7160A2600
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B7160A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0STMB6LJ
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-483a66818edso591900fac.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012018; x=1795616818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7AldnFPFwd28q9Fb7JfwOQSIJZmwrcTj9ZEfGyxga8=;
        b=0STMB6LJinF6MkDTzbvwqB+W3FJpKiki0kxpinxHUSf/5iAM9Bfa3syLvlxqyRqQhy
         BVUwooiEm+P90TZ3GB2qoAj6owdVwi9GT3zgzP/H5lT3q6KI32GGcpZufXjMiMrxNLmM
         4lr7xaZBf1QpYjxcylmO0zzW5ZQOBUoKfMLLzD9ik8HH5CeStlgL/BQ917X/1+4T/j5u
         s1MCIMYksILaHpAeWbp+SAG7lIGyZZC/O7bestAyuqgrIqItQehRl8N2K90I9vG02WzI
         bQXZyh8v8mOIWRWUVZ+yR6uiCe5SHpvqkPiL7agvO9gnCAnD0K44XSQCRjy+i5joLkQD
         rwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012018; x=1795616818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7AldnFPFwd28q9Fb7JfwOQSIJZmwrcTj9ZEfGyxga8=;
        b=xnFap/MfwQt1NiVF/lugVndOEiWiUIth+P8n4bkcoZ2OHRuOtbAdE0+dzHOUmRcLkC
         Cyi+Qcv1Fgj0Md+jUNNrVLewrs5TPS3TIrsi8sxXbBWkuk2JWj/cqpCV4mXH8w3Hh86j
         Y6vj+/XYqi0CrELLhk5w5srOE7kt07YyzDvZ1EZ6IvwuevfRPF3HdS2OR/ugy7goKjv2
         XxFUmsUe8xEUX+asqt8aoWJHKV402LY0qhDLbrYYItXLXd7VAO9eRYHx88RBrZk21iep
         XKKK9QXB27WOUFbvGh4qlLqVrnZw9Ub47FBJMIWbnJlSPhiBuC3wOvv1taKmusgKd7sz
         lq+g==
X-Forwarded-Encrypted: i=1; AL+hErFKZ3sl6kC8EcI4zIWqQljMbID3gGzRVhRtklg/tVWa+EQH4/6ekqeXs7IGFdOq9V9dPdYqCG4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s0ZMTF7wleu5iLFHCS9kLbKwh2d3++WJ91NdLjOyYQGzTMrnW
	QHXYcnvJ9lewpS2qHVPLwNGO1w4BV0iEiidWGqyoR5g5dlDSoZirsC3E
X-Gm-Gg: AYBFou0Zu4QJjkYW4lmNUtCv0EFkZ4/2NFfAX65WusvGstWvgKsU+Tgwe6yY5c92qwX
	zxMu9XVc8xmdaW3QLMXFqHcnRmIjqqP8Bc+G/rLqQifEYvPyAXP1uQhw17DId/alm9FdsoPDKta
	zDOgGSmP9J6QXGY5u/RiXFuT5pBde0zmySPrMjOYZtl3Qsn5FQKClW8Z/6oySfLbX9IdXB5wSBj
	Rq3mfx4PwrVpT071QoHMHT9+NhPhZwsghAFbs/xOtc2aSEe6bPb3/ykLqM18XMF3uVhkU1AEUBQ
	gZFJQgraIrh+QTUdWcW8RjP1YjuU0EAMbjC2XKxLEZ3cnrEnTA+4b5BxJN8wNnJd94sSBxVn8bM
	DkJuvzaYaely5kRpTJ90I4uMeGGY8CqBtm0IVBE9KW3Wi05wwTK28i29YT29kOreV+iakTZoaWg
	+XqK+DmLB3zHI9rxWgqcr6f0pyFxsA/L60ZIoHYirB0Bh3sxJS4TBYKVhJfOeOtUpW57U+mYzOU
	jbxyEXUZ1raqTJGtTiv+/3Dc4yFwipH32hw41YLMDmA4pVCKT8dpUJynsz7+g/MLpNoGCye5qVJ
	PdYkpmBDkkU9r2Bnzw8vfS1MyeNqcNCuA4GF8ecWSRBDafjZ5Pr7FgccglEik7ow+BfcRdLSm6i
	DdgoKkrLy
X-Received: by 2002:a05:6808:f04:b0:568:3866:d1b5 with SMTP id 5614622812f47-5773fb4cbf9mr2975057b6e.46.1795012018160;
        Wed, 18 Nov 2026 06:26:58 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74372cb6bsm2197869fac.4.2026.11.18.06.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:26:56 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: gregkh@linuxfoundation.org
Cc: asatsuyu.liu@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH 6.18.y 0/2] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
Date: Wed, 18 Nov 2026 14:26:52 +0000
Message-Id: <20261118142654.3098395-1-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026111850-shiftless-popcorn-a566@gregkh>
References: <2026111850-shiftless-popcorn-a566@gregkh>
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

Hi Greg,

Thanks for the guidance.  Here is a direct backport of upstream commit
1a5c01d2508a ("bpf: Make KF_TRUSTED_ARGS the default for all kfuncs")
to v6.18.64.

The series has two direct cherry-picks:

  1. 1a5c01d2508a  bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
  2. cf503eb2c6c3  selftests: bpf: Fix test_bpf_nf for trusted args
                   becoming default

Both apply cleanly to v6.18.64. Patch 2 is the immediate upstream selftest
fix for the behavior change: 6.18's test_bpf_nf still passed a NULL tuple
to the conntrack lookup kfunc to test a runtime error, and after patch 1
that program is rejected at verification time.

I tested the code backport in QEMU with the same reproducers:

  test                           unpatched 6.18.64       backport
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

No oops with the backport.  As documented in the upstream commit, this
is a verifier behavior change: kfuncs that previously accepted NULL
without KF_TRUSTED_ARGS now reject it.

The commit message specifically mentions the netfilter kfuncs affected
by this, so I ran the targeted selftests in the BPF CI container:

  bpf_nf: 14/14 PASSED, including lookup_null_bpf_tuple/opts and
  xdp_lookup_null_bpf_tuple/opts.


Thanks,
Yi Liu


Puranjay Mohan (2):
  bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
  selftests: bpf: Fix test_bpf_nf for trusted args becoming default

 Documentation/bpf/kfuncs.rst                  | 184 +++++++++---------
 fs/bpf_fs_kfuncs.c                            |  10 +-
 kernel/bpf/verifier.c                         |  14 +-
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   5 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |   7 -
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |  57 ++++++
 6 files changed, 158 insertions(+), 119 deletions(-)

-- 
2.34.1

