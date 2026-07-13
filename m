Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267F381E8B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924533; cv=none; b=iGcsBWM8V9gg0WqTMOFm9jZvAT25bMFkGAxB1OC1pLEv5ezHT9Q2lxZyf9HVteLbPQQ/hxhO9OjNUUG6/pET6MvcYhJUh9CJunwDlsqatnT+802iZT4vDue91Px6218A5sspokFtE3D1YzUXhs7Tke2rXxT2XR8W2foCasBtHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924533; c=relaxed/simple;
	bh=BEORnXxM6ZYhnHtAqG/+pG3egOgrrwmAumn/RU0cg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaSzhaRlYL9xJuKfmlnRvT1hXAAE3dBYXRz9Jb88ysg1CNwGSITZwfwt0/FrQjIGtMRRe2/xp3BmEIdGWOqWc3WPgERLA3FcLn1mBbb20VTm3ZC00ENQK9L6tbE20oZJGAmlddWB9aR8U3rADVrmviQDQoKA501peRfEL0FxP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e6V3KcTt; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e6V3KcTt"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c15e57b7128so180127266b.0
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783924529; x=1784529329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h7vE7Szm3XNqCxlRDi2ZCo5mo4ITxmNYPLIe9N/Lh5s=;
        b=e6V3KcTtU1nidHXUy0FCya7HuXMYKPCqDSrA6ShZ5fHZe6NelMvR9aHnFV4Nh1hUC9
         HNIyOK6D+1Qf7JeQfL0FF1WoqhMo5sOEw7+kOgjsNyyrj2ziBVujWWBPK1UpgQ2sNQn5
         tGolzTOesew44igiCUX0Sd1SzXDKiCAZ3trRlUCV7YS+/pQMIzKNptJDzqDVvn4Fcngg
         vBj+vwEPzIyXm4ms+x98Ntw6iOaLQfB24t/isu0CUHd+YKcuSHelJX3Oqq8GTZxEGvxz
         WMKuIPW+TDNBSHQUvD2fcobuamztg0OcvTHN+jyjXwY7J2CxbIuqxPs3Fial7aeqsIjS
         3Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783924529; x=1784529329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7vE7Szm3XNqCxlRDi2ZCo5mo4ITxmNYPLIe9N/Lh5s=;
        b=fq9U8JS8+2vS2oVMqqUh46v7e828Ulq0T8Rs8hviM+YAU7J0FDgCWwMSVLdjFUk3sh
         4mpTHnUy5/dgUMRxh2tZOohhWPb/023iE9u+6MNQ0wU23+Zc6BhtgCSN3FbOmexR2kna
         oVEF+7MBG0JDyWAKcyPa+VKJkSjmkmf/MghhVxfgoZ7jWMfmTB7vy1fIf6hK6g5TefnD
         K0l8B+awEFGt0OT8oNUMvnP3rLwBWDTQyd+ExySQYC/U/vu5vOXtkzJK8MEfWJe44F2f
         fYHJ9xQQmPKq8MGOEYKCpeojThdAxiqI7b9NU40nP2HcLotwbtegZV0vyC/GVfXr4htk
         bbKA==
X-Forwarded-Encrypted: i=1; AHgh+RqZnVLkNscxzQaCXAd9EceI/o6LNIf3GESsBBEzFEVaNiDmlanH9gIg11+Dqm/Tq//Hs9MMX/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2U2JFJ3OTBaWSK9OTw9OXgRVXl5mBDFAGQMfxLrwmTcZDUIB
	T2nXABAGUQig6C31xzcXBfQ7om1zJETPyPTJEPpt/P7GHI+DWhRsjQgzZBBCLe+uI2U=
X-Gm-Gg: AfdE7cmGqdpnhp3RltMry7pkp7Y6kL58imjq9KtPrC4uuZWCH+dkeL7PqkBnwScBell
	LBK1yDuFYRIg6G+7ftg9Ya7zYNzGUZfqFyI3XR3zCQ66S6JCqAQNiLoZ8i+OOe74mvC0f6hhK6s
	4TEVUehHHiqNA+2Z/JJnlQwAWk9Q1WqPznLBZqk8EwGYq4qVICKhnxQrA7Eb5Q3Q1OSXe/PKfhC
	pYFdm5trV6jjOSHSLlOjHAZkeW5rD0+DmOkNitDahiuAzuV04hcbPQWHmAOKmh0cu4WC1lw9iEq
	3VvoM8od9uQShkkUwtNoc+H7qkKDxFOJGDULSCBWuWQ/hyPBz31kFcBq+rdG/BlyKrWTAPMaXE1
	DgfI8U0MHPczuEZEtvifER164sVrgm3CxZckBPGdsTXCiRDX6oPZYkWshxdeqwnMrTZwOdxREYL
	7QRQ4SZykvTEqtMbibTNFsQsAHshHJJskUppuS
X-Received: by 2002:a17:907:e1d3:20b0:c15:c81c:d6fc with SMTP id a640c23a62f3a-c161e9416a9mr199248766b.9.1783924529478;
        Sun, 12 Jul 2026 23:35:29 -0700 (PDT)
Received: from localhost (27-51-9-144.adsl.fetnet.net. [27.51.9.144])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a42ae81f1esm5074320b6e.11.2026.07.12.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 23:35:27 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
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
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sun jian <sun.jian.kdev@gmail.com>,
	Matt Mullins <mmullins@mmlx.us>,
	stable@vger.kernel.org
Subject: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for raw_tp_writable_reject_nbd_invalid
Date: Mon, 13 Jul 2026 14:35:11 +0800
Message-ID: <20260713063513.215781-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The raw_tp_writable_reject_nbd_invalid test relies on availability of the
nbd_send_request tracepoint, which is only present if the selftest kernel is
built with CONFIG_BLK_DEV_NBD=y and the kernel built from current BPF selftests
config lacks.

Without it, the bpf_raw_tracepoint_open() call always returns with -2, leaving
raw_tp_writable_reject_nbd_invalid test always passing without exercising the
checks bpf_probe_register().

Cc: <stable@vger.kernel.org> # 5.2.0
Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Not sure if fixes tag is the right thing to use here, so use the cc
stable tag instead to get this config change propogated to other stable
branches to make stable BPF CI's job easier.
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index adb25146e88c..e1797bd87904 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -1,4 +1,5 @@
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BPF=y
-- 
2.54.0

