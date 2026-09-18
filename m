Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF423C8700
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715721; cv=none; b=qGtAz3U0P+fXWatmGAj540AmL/LxKn7KYE+FON0BCZ5eA0gl5VwCvH89/1LGCWnwPScnTYJXdq/13uBFb/FoCMuEOdGshVUMncXTWEr62k9GYd0k2W5+u6Y/4mFqXe89ZoElnkL7jposiZWP9nFonw6Ne8499prCWk9OlGHAMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715721; c=relaxed/simple;
	bh=3TnaohRSjA7u9kb0fvpr5atPg05ZZyGnSCboe6EyYNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/T2lDUP2ZLDu0pQHEfXdhDSw34RarhikVKHbDW5zn0ajKcvWrYswXvPCDla9HO/kH0b9DPMZ44ThX6PNEvhP8A5NVKcv2xx5KnY5cDAiurfbeNdeVuLJ8uUhKgy7zEWJbMrQAuBsaBGvS4NJ6D9cDE2WQr8YDmzvHiDFhcLHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTLKQ2IC; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTLKQ2IC"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so409250a91.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789715712; x=1790320512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Bkp/RFC9ZZAGi4GjN9yJHrX67uXW3aJJkkSzqSHpAE=;
        b=HTLKQ2IC1KMJpdMOAPV1TwnIIgH2e6utCS/VXMoNg/mhELjZIIuMrusdi0Wvz6h8ya
         8dKTd/jca5YY1LbGrIVxNrELE/sxIlxaOFD2uWaPqsbN3HklVDVhkoE01F9aBJhsCRXt
         EMeAJIPrZKSYu/ZDl8AR0SvSsWlArt9ZEHPHsozg4PfOnBG1Ca0sHBKNMg5SYtvd/XJw
         m34BOSLkBaXEDHOeLrLS4+UWNWv8KSwDF4tUBC7+kIJ3Onl5Le28IHRrugm6f+t4qXRp
         IF4Ky4pq/4FG/bH5107fHt51vEK4X1vskFUpE6ZNOiApyZuTH38pmhiJalCslf96RMG2
         tzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789715712; x=1790320512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Bkp/RFC9ZZAGi4GjN9yJHrX67uXW3aJJkkSzqSHpAE=;
        b=cDtfRm65ghl6QapOto3K3WzbPQrtNlXXT9Nl3fFENQeybmGGNLXNAxansOdVUd8+Ry
         RJiHXtxs6phgowgk+UNe5OimA1WGo0abANhwiHV8d7NpaXJjnm09UAfuWqGcr76XeX+n
         79bU79fZtQLBaVGxpvhvQYLxjSZF4MQt8VppWrMYmQ9iHlRK7m1MnMa4Ydr43xuh+MAs
         2FdpaVLKoCVtKtXUFce52hKFsyXvyNXw9czZroO2JSE1T/Gh6oVZQvlvQq/9gTpJTlli
         mL0R/U7wtk4dc+qpnRMnksWstCgxhBr6xtF1Kgg3fg41oDc6HgEWhWNGL5LdnPl1qYN0
         WT6A==
X-Forwarded-Encrypted: i=1; AKwUvBy2A/drxHtuiTrQDYIZVk3e7USAShKR+KxkjqI5uUk85VnHS8zXV9uQPuFAG68cl2XKjFKYtbI=@vger.kernel.org
X-Gm-Message-State: AFuF++nOho+3Jyp2RkC15nv3+uGHCUdghfJXlyosBqpD8W8s8l8/DtFm
	DTJmwwmybiTAWl+XNkNOLY04fOwTgdqU5HBY/t47kWEuiBC2rtOtAbk1BA3mcQe/pw==
X-Gm-Gg: AYBFou3sX/k8kJz4rTKoxiSaOTKqsgoBgjhd5jNgcOnECbORPstku23JsU+1guoFmhw
	KM2CBjkBmCcPQ5WAo4HjzPU+sYjZZGX7p6kuFjZBbL0Ocdr9G3d59JrLmAxtTJT8fQe3/2mO3jh
	8o8zjusIBONsw05Ri0rdef87paF60etMoQXjVEjxkTYII75COACD/FNsbVPRqRpDe5HGKaHiNlJ
	gZMwlbit06f6HreZleA++G77byxhXQd/uEPUN3kXSDTh/C5t1iz8RXhHBvrZuvvE2T4daiA9a5Z
	eiN6Mg9ZRfS61I0Xme1BNmwYkjcl98jpl+OWxsEKv38VRfhsFQYa76VZqe1V6hWnf5118opjakk
	P4yGshq9RJVpYS5r/9h1kyOr7w+cRDca8pkzd2mHUFBeSVG/ahd1ORGk9JOFD+t1BcV86DEY6ph
	wOvRDKYeyiAL/9mnp59kv6TUi71hKmn5UiXfQ+GD2KITmZeLSeHo03bfRPQyqUO5WR+ubSnUn8n
	CWFtfGg7UKu5bOpDs7NmV87ty4=
X-Received: by 2002:a17:90b:538d:b0:39d:ef3e:9035 with SMTP id 98e67ed59e1d1-39e54e3c190mr6935740a91.10.1789715712538;
        Fri, 18 Sep 2026 00:15:12 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:d047:17af:bfc7:1a9a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36170735sm8842180a91.8.2026.09.18.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:15:12 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1] ring-buffer: Fix the sub-buffer array base in rb_meta_subbuf_idx()
Date: Fri, 18 Sep 2026 16:15:07 +0900
Message-ID: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a persistent ring buffer, rb_meta_subbuf_idx() can return an index one
sub-buffer too high.  rb_setup_ids_meta_page() then fills subbuf_ids[]
shifted by one and leaves subbuf_ids[0] NULL, which __rb_map_vma()
dereferences when userspace maps trace_pipe_raw.  rb_update_meta_reader()
writes two such indices into meta->buffers[], which rb_cpu_meta_valid()
would reject on the next boot, discarding the previous boot's trace.

A CPU's sub-buffer array starts after its meta header and the nr_subbufs
integers that follow, aligned up to a sub-buffer.  rb_meta_subbuf_idx()
inverts that calculation but skips only the integers, not the header, so
its base is one sub-buffer low whenever the omitted header size crosses
the alignment boundary.

Invert the calculation with rb_subbufs_from_meta() rather than repeating
it.  rb_range_buffer() maps an index back to an address through the same
helper, so the two directions can no longer disagree.

Cc: <stable@vger.kernel.org>
Fixes: b14d032973d4 ("ring-buffer: Add ring_buffer_meta data")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
x86_64_defconfig plus KASAN, FTRACE, TRACING and TRACER_SNAPSHOT, on
5dd1818b15d9, booted with reserve_mem=<size>:0x1000:trace
trace_instance=boot_mapped@trace.  head_buffer is from
instances/boot_mapped/per_cpu/cpuN/buffer_meta, the map of that CPU's
trace_pipe_raw.

nr_cpus=1, 24 reserved sizes 4096 bytes apart:

  nr_subbufs      head_buffer  map      head_buffer  map
                  unpatched             patched
  997 .. 1004     1            ok       1            ok
  1005 .. 1012    2            oops     1            ok
  1013 .. 1019    1            ok       1            ok

nr_cpus=4, nr_subbufs 1017, one boot:

  cpu 0           1            ok       1            ok
  cpu 1, 2, 3     2            oops     1            ok

cpu 0's meta sits after the buffer-wide header and the scratch area and is not
sub-buffer aligned; every other cpu's is, so the affected nr_subbufs differ
between them.

Unpatched oops:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
  RIP: 0010:__rb_map_vma+0x418/0xa20

With no reserved range at all, both kernels map the global buffer.  On both
arms, tools/testing/selftests/ring-buffer passes 6/6 with no skips and
CONFIG_RING_BUFFER_STARTUP_TEST reports "Ring buffer PASSED!".  ftracetest
gives identical per-test verdicts on the two arms -- 153 pass, 6 fail, 6
unresolved, 10 unsupported, 2 xfail.  The six failures are the same on both
arms and their cause was not established; the unresolved and unsupported ones
need pahole, a hypervisor trace remote, or userspace this initramfs does not
have.

The discarded-trace path is not measured: a fresh QEMU boot gets fresh guest
memory, so this harness cannot carry a persistent buffer across a reboot.

 kernel/trace/ring_buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..fa2e2ce683aa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3627,10 +3627,8 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 /* Return the index into the sub-buffers for a given sub-buffer */
 static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf)
 {
-	void *subbuf_array;
+	void *subbuf_array = rb_subbufs_from_meta(meta);
 
-	subbuf_array = (void *)meta + sizeof(int) * meta->nr_subbufs;
-	subbuf_array = (void *)ALIGN((unsigned long)subbuf_array, meta->subbuf_size);
 	return (subbuf - subbuf_array) / meta->subbuf_size;
 }
 

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.53.0

