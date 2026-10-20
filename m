Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491938;
	b=QFUk3+ueJcwHKZ1jxs3sPKTn26qaHTh+V5Jr8QpJ0UOoIPtslM52pkZvL/mDwLOwAjVz
	 qnSutyV2nK/VjixEhDqPbhLpqgEpK6JDXTIrGjGwBWvl0MshjhBMPg6MFl8TKrTB5WRf4
	 UDtKHScX9lBpw1lOewK1siSnLGZiLia1y7tdnlnkJbaNtYgXqcjigpzKX1e/nbaQ3Z+XH
	 NukTnH7MUE3RjHeSR8fXl/snVRgMsRa8z6S7vqIgVWqVwd7atnpaEw52mZ+rSquU2jTuO
	 hJcf0Aew2PTD56Iq1hzQRWyLrc90B6+6bwAVEPvvXbA53wgWxSRow4ib1LQ/QjEQkGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cHpYZ52UlepWCCzp3epNsk2Lp6gJWZ9lC0T9fNQNApo=;
	b=dKhzDAcsiLdVg9stSQyfvoNg4b6Qo6TKVUvSlkvP0ONJrTWAoaD/9rp34Qkik81BgnKi
	 TT76i583FQt21L6DNHdfV1Ei/iiR7cQ6oXwCiY0WShbeTpU4n6AmQ/i04tKw/Ae91giZ6
	 ovyw6pPmxRc2WoIiz4cxbLMdcTwNpfeGDDePgUYSwWy9CSUPTIr5wApmkheqqOFgxnTQf
	 qH7983M5dvprmyNwnuGgI+hirOboC1Vg0NK+2gblWDM77zQBXGQebZqv5DiIooXQ+s8dT
	 K0TKplwBZfFl8RFZs15lqNmVJRwne/3ephE/KWhdjSHajlFzVBRCgvjOqnFepNdnJ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=QhS9xQXG;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B187606A325
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B187606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=QhS9xQXG
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a07025cce4so1070018b3a.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792491936; x=1793096736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHpYZ52UlepWCCzp3epNsk2Lp6gJWZ9lC0T9fNQNApo=;
        b=QhS9xQXGcURWB8O1hsAFYwP7r8XTFjs+7lvY4tJ9nF7kIgNZulxzbGNNBnBWwdpPXm
         7cnNdIxde6Tb1ymESnWc6T3gbqkZPMp8U0SLSRZpS5jI0ORmhan1shml24RDdm5Ql4dI
         C/B42JwzdUez40vOZiZ8gY1U6aogOBToJ6CaKFwDfcBUOUbcHmQWFJlu7o2KUTItjTE2
         YOFApG+WGPcMsg700cwYfZrZAMh7tGo0QzUex/Ytp7cN+/TYGWRaFK0biJ5NXHRq7Yvb
         me9EGl4P+DSpgH6jRUOPkqRXRaVJbHWIECbejhW68/TXh5NudvUFd0Hmdti8HH+/P6FZ
         aqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491936; x=1793096736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHpYZ52UlepWCCzp3epNsk2Lp6gJWZ9lC0T9fNQNApo=;
        b=Dn9EsT4Cbggcf7U5jF7/6ogcTqeTKM2IN6r3++d/A43kUt/cWlLFm1MTtSqjCafVUK
         yQDpxGz27JuUN+FvSY3xJ/ZzH2cj8gzlJMT/9D+uareP6MNqL+yasO4ohY3yGVBRKyrp
         sM9M9QAB3V2HcJ1c5rnVessw6gJdd3ZPpuR4w8JGECv4+3R+plgF02UUVy2exA/1HqfJ
         AO6RmSe1xbhtWjY5rItVlMjLDwkobNRUM4eB9XRIxNZ14qvkD440qm2esC0hIq5vjhUK
         Ycsk3XlZVaq8rxRbpiGoDssJlfYPfWjD9zIpLLDSU2YfWekzJTpdVseE/0hT3ejrInI6
         My/A==
X-Forwarded-Encrypted: i=1; AKwUvBy28JIAQ48yKA80c+s9JMDXPJYG/yFEjgTEXQI5vjxkM5/bL5TsWiM8UhlGtZtOlJhm6OfQLLE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSMHK1hj8ZO0VckyDPn9bXpAP9/csiCg4tvjk03q1p3H73zfl6
	bwtdeYrzdwS5JDRUgxnW0JK2qSajTDS8WD/VXEPsHSC2ZRsWc2CFpZRt5OKMRcfvPoOl
X-Gm-Gg: AYBFou1MOzszObXMXZm+ICBORRVcopiKB27rlbGhKFQtO6fzQv/jYyiFwWdmIBpRr6I
	Iqd5wdB+4mhTtn9eleJcVCUnApdg62Z/v0ppkrw0+cxI3IlzHVZB6FMTN1KL11Z4PZ6hBpZkzzm
	4rox9A6MuqD0zM2A2+5XWLKg42UZEirkY+e9bEp06hekTe3ri5TTyR/+Mf6A0DLLT8GW7CaJjFY
	LtcZFBOlCKsOp8q72EQfMo4LEFiXNZOLidp0/HLXvjdyiGtJbx8mh+4bGMG015PexZQ2LR38vON
	tLanjoFHjvgKa9g6Q5wyrfm0D1JrUaa3MqnAURAobOVsw3gO0j4s8peK5vOZzHfu27SNOOMELRE
	aEBh2qORSPkQF5QJBBTAqKKd8OW0WvHSS5IA5G9FwXI0cEBmcBf8jMvF6Ou5HSUv52bey83xVfb
	9cU9egx7FYrnWbitsxuMVnGL+CLfoXMsrQx8ejSwx5Tr2ET779KGReA4qOzx1Sh2lpAaLoPPKg2
	4207MJzNRTUt944PrPS6NjRRFhllPC/lBWlaapVE5KYvtX4nKa95OzrcVbc7GfEPl7dXjXaL01w
	QJ84snKv3aqiod+M9xHZMsJNQkL9
X-Received: by 2002:a05:6a21:3284:b0:3e2:6f90:b54b with SMTP id adf61e73a8af0-3e26f90b718mr1762156637.35.1792491936486;
        Tue, 20 Oct 2026 03:25:36 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57452b16sm4574976b3a.29.2026.10.20.03.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:36 -0700 (PDT)
From: Matt Bobrowski <matt@bobrowski.net>
To: mbobrowski@mbobrowski.org
Cc: Matt Bobrowski <matt@bobrowski.net>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for exiting tasks
Date: Tue, 20 Oct 2026 21:25:09 +1100
Message-ID: <20261020102510.96685-2-matt@bobrowski.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020102510.96685-1-matt@bobrowski.net>
References: <20261020102510.96685-1-matt@bobrowski.net>
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
__fput() deferred to that task work. So a BPF LSM program attached to
file_release, which may pass file->f_path to bpf_path_d_path() as a
trusted argument, dereferences a NULL fs whenever a task exits with a
file still open:

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

