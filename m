Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EB3B6C18
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756333; cv=none; b=Qbh7CbOOpq0XpWTCQhwg3BEYhHkvIok2dcPU5io+PTXKSDjOoJmUiIwREtGvIgr4mJ8xCHdwPG8Q8kTYZj5Zij7Fj8TzrsTkAgQSBnmTS+XDLcGRjxytNv6UD4dsHn22TX+n+7Z9vKlJDhtxawH4L6ZO9dyBtBfOEbhit53P0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756333; c=relaxed/simple;
	bh=Y9AIsjPbIPGueDse8hHLQDqbfy+XindtGyBeUBP/rvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0lrnPoOSNV2cgmsFm09UhmeF0Qf31BWnmR+YW0ViMoBsCnKq6lcNejribua/4SLOZTXK7Vxoon0jpHXR+PdesmIxDWbYq9lhgWu2UX6JDR62t3QU0SpL4SrEAvnkr1cKw9b1nHsVAJw5ddIOf3X8SDvJdCxoce6Q3bpQtHtDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7Ewn73U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Ewn73U"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceb096e675so37465585ad.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756332; x=1786361132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5tDp607U3XC+GO+sC+Kbg0SxU3/bHhXF0A90r92Gwc=;
        b=S7Ewn73UrqgDwTQJGK1LAqjznD8pKBeh0BS7XZMFPS474diUB1PCzn8kakXEqN5x9y
         iEXvYo3mhJJWC/cmHQ4hO5dlg5cZKucC4g7r0SmmzA7od9l4cAmbEP4Yc6lgWyt2rz2x
         MlbNko9QoRf2vC0BpG56ReCP2wuk6wfx9Bp4WYmP0oQXcyUpCfxZ7d1aehAhU7YpJI7T
         ipHHOg1MtWxDbILdaVWXCVXLkwXtOFRaE9iyZsu6PMqtBHLmyY3Ki6V3dr9uYnrzMt8c
         xC7zHwAcoRp9G9tZbSCcYlCfdM50EtckpzS07hA6r3zyYJsFhqfU3mbACKqJTZAE0sU8
         zQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756332; x=1786361132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k5tDp607U3XC+GO+sC+Kbg0SxU3/bHhXF0A90r92Gwc=;
        b=BISJW9Lw5xD8E151++hS1Nc9lPndO3zrIZSe7ddTv/hssDJUMvlOXdrriTmud1g4jz
         qESOWXVQFTdtezSg50EkUCSDW10zmAeyGYAZ/XHFuSg9ZmH7ulGakRtweesUKtE95k0j
         GsiLTAXlYHRPniHIggj/w44YMetjCUpSbOnWtBgOZ2Bul/tHKh3DBGQztDnqG4idBfSu
         Ri8Z4mXBIuck4DlKkAudJ7mWOdewjeZkP1daY2dcdbr4vxS5yzRnWoj7o6QTOnQ22zeU
         bvjxdjBxBpJgCUF6Px//MZ/ao/rlCsq/FQQq1XndU9m3l31xX3ZuPzD3eYmj0SEUFAOJ
         Jn5w==
X-Forwarded-Encrypted: i=1; AHgh+RpjWPJVs1XF4fzgCpgPMnlhrQnRPTYS5qWQ83gvzqDmz2pZk1muL+4iY5HfZxedf/+r16pb8kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWnYcIPJdDgJw+5+V95hkjwS8H1SKGpRbPcN0M9/is2TmEHQs
	8p56c0cm5vSzNE/Wlqwo/s5WV9KHkUZgMCy94o1lw0mrmlduH0QcfPrg
X-Gm-Gg: AR+sD12hPueW8DnN14ux+N/FhJb0QXMItEdk0Eq4R42bvISl4C9y9lBa+E9RQ/EFNV7
	KgTSZn++Rk1LANF9sjWfTZq/59ak4u0u13WZM9zDvfWmsU8pbQZMKdu/Ao9ZdqUgfu8lI/7AswT
	PxNdzsM4cCegLmNUVsv5AVYm5F9GuT+dAYvnGrOXAWjoJzZmz9uBEkPk7GL0tBHi1WMwAwPtuLl
	Wn39GVILRe7UsY49gAXHJYwXS5CKo2uOhxWf9wpE8D43WItxKxV0NvTB6Or6YFrteXd5jcwAV+W
	6q0CY0jTq0GN5s58iccXki4OQaFEHONyuYtq2HNMnsEGRotjctMP22RC5mEowHJKQn3yGGJ3oNM
	fUtpisR0hXyHnkEjMPkJEEFgjx7EmJWPJZnVCxoNiCdIsdAtTrf9thdDmTqgIZi9tDrUlywjxE2
	S33xLiL7bWNAKzr7AsM734A97fQvCrHOBiiLe8mF039p5kkwHhG/CBtWUSZm7MkIPoZVag5FRx7
	y+xleynm2NaHxWM
X-Received: by 2002:a17:903:1a06:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2d0521b6908mr100228275ad.11.1785756331838;
        Mon, 03 Aug 2026 04:25:31 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm36190685ad.21.2026.08.03.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:25:31 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	Ning Ding <dingning04@gmail.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 1/4] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
Date: Mon,  3 Aug 2026 04:22:08 -0700
Message-ID: <20260803112218.3361213-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803112218.3361213-1-dingning04@gmail.com>
References: <20260803112218.3361213-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier can mistake an RCU-loaded map kptr for an owned reference and
assume bpf_refcount_acquire() cannot return NULL. The kfunc uses
refcount_inc_not_zero(), so it can return NULL after the last reference is
dropped. Passing that unchecked result to bpf_obj_drop() can crash the
kernel.

Only treat the argument as owned when the verifier tracks an acquired
reference for it. Borrowed pointers remain nullable, while owned pointers
keep the existing behavior.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Assisted-by: ChatGPT:GPT-5.6-Thinking
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdc5fbb1f78ca..c47328be2505e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12419,7 +12419,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!type_is_non_owning_ref(reg->type))
+			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
 				meta->arg_owning_ref = true;
 
 			rec = reg_btf_record(reg);
-- 
2.43.0

