Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936737;
	b=DobhRHLk+IUxiDFZ1elifJi7NKaBXf9gsbZMZdNaFkXR8ypjiMRDGUWTQ+/v6lFK9b8d
	 EJ6qmes9woVwvTFROKveBi/aIzBkKs+hmrOaQNbEMp3nVjH8W5NBXKXZEJfONMiGqPqdT
	 7uOTvwbe4LKlNpuZIHnSvPmJ14eQmGm+ZzYSmDjdbqJlh3iGY8kZhN/EuLnfNPCuuvDsy
	 Ufp74GU9hE0uYG9z1yDwDs4si4fJJQvysRnlkCqhVZ42VoIxUQx3OCcqahgRCp8sej5dY
	 B6U+I0hPHSV++Rjk5QUuC0FDh5ByLLo0kPXGfA1Q0TGzFaZz6ZHUnogujtCbptqx9Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+7MG30dg71q8VjUv3Kl6iLWy30FheOHfbrKiXTkP1qY=;
	b=p4ZmvwakoQvxdzOuK3yHy3h5i+8FXzeQv/JGXyN7LKBMY4oyCSU6ZJuWmlmzycEzn/5y
	 U4fU4/coN9QmWX4GiYwSNWzoPlytyl4kBtKbmq4lLvhvuLMFE3R+f72CgyNXekpQz1JMH
	 UqAGRAWJqLjwX/CAAhZ3T6xY9rr/ejLDgIAotFf1NRncA6a33Sp4sMv5aBPpyTEaEWSfx
	 Ncv+TWJdvW3ejoeQh/NzL8Q+h8FUp45l33cxNkw6TAqGaq5b0AVqWKghh4/ZUKZAysXYM
	 jvSjsZFFenTlLObbCL4Iwa03UCmZpqgkZP3BRzE099jD7Snol5171WIf6/gsSpNMrWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mea6go55;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D62606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D62606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mea6go55
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so108785c88.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936736; x=1795541536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7MG30dg71q8VjUv3Kl6iLWy30FheOHfbrKiXTkP1qY=;
        b=mea6go55qgVjJ4eBOgpALSv3QZZhASjhLiPb8NRnQbuz/Jof777TDpqogzz6/0KIY1
         dF/sv5bg5M75uu1yySzdVUS0XfHmM+2gSa9pA/VHCFCCBpEWMCjf0XhfsLAjSrWhQiU+
         9Zav9QO3zjIAq1gUrCIjjyauSCtD0bl8Rn7R3NqzCq9N1hBv+G5sLLImnf3y9a2KgQ2F
         Xc1pVOZN67PR2Jatn5nyUiMtQi3fl/xYepS1aO+upry7L5THNhR6vo0cJbdUhzu7YZCe
         pCGcKN/czQUnanXAtIPR4xu0Rz+uWHeJkp+PK+UTGNXhwtvmafxl0kXd6+/8XcJ3NrK8
         CXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936736; x=1795541536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7MG30dg71q8VjUv3Kl6iLWy30FheOHfbrKiXTkP1qY=;
        b=NZrfE2OWC0lHDLb/2fXg9J2hAlw3dUTpwdA0TuRc/jSr3rg+GdD3Cej3KC3P0TI2ky
         rNtJMDdpT1ryVfpvjqTUtXJdl/j/OPxvJQ4aehGcJI0DACcOA9grWAUKCt89Z/L5oLIr
         IjMKFJdezakPiw9fxCIDr8byKLf7XjbQxzC2u+DOPy4VS4fqiZF/WjV8FaZiLb7V69gz
         kd3/5Nlkc+nGgKBxo8Ylz8NDfn2yzeUYwZgsuezScMRI2/fv2jpJ19uJ6R9podnFNozN
         U6fq56mKnOXU1/IoKfpFTiWGzQNB988yEcsb96qHDsv3FGqlqMC0vx/Q849iWnPC2Wxv
         UvIg==
X-Forwarded-Encrypted: i=1; AL+hErFbF/kVeuw3Eh3+ynU89te/z8PkA0KWZoUvFtb54J6nb5HcDvfKNXG9FRKdALpOjEg/bIbPfAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YcvM1qPAQ+nvxn3XanbRnEZ7TwQR6mZxfFPHXu257KXP9NF4F
	+Rh3rGmTs/zngiiQXkNXy1/MDSOvG0ZNUptYfgOsJBfQOAD0vWs886gC
X-Gm-Gg: AYBFou3DVCbCZBVYTlEWYoZh0yTPUWfXqP/wcOLvvWRyxtzXr7YHmWRQnJ3DsX/128j
	zumNvyN3E7Nc4pehdwadgpqJ2OrBuf9rPafDc2Jg3GrjO3f4NTfLzD3odJprjsXVeUy4gYON8PF
	+ZXmDrfZoQBKrmesk4vFPbJdgSAFFujLsIw6ws/Iv8s51DVJY37j+FJOqLYVNs5S+Du+CrgPXOw
	2lC8ZXTRHPyU9fla2wQGIqUu0Fmi2QlRRBel8Fe6sdGL5Zh0HXlndlGRVj9BrjH+MpH81GapY9U
	1AEA0oKnhlUgNG2RR28AXPAmaGg76sX5q7khNXVcN0n4Fp+ZNtYOPUp6NugisT9hTkx0NBYr13U
	npMGqSF3ESfmRDSIWeGew5DIY+OrOT47fyDhuBD7/VQsD0ky37QgoWCdAl6+k/mMJ2GZy1/r7zA
	R6HGk4PEMKrLU73IsOIBWF716DeDbddulZiOAEhgQsDZWky8RiqZsKg2MiJb8PJ0nNGgx13/18d
	laG86ljrLyfABtS3YhWOgUMIwBH8LDef5n02jjmzMrEsyEiO+LalmSDK9urF231wY3XhbBHRlm7
	kcsp3AKc+gADavLBfPeD1CNKENnq7VnnVclcQ+v2oE2M
X-Received: by 2002:a05:7022:ea8a:b0:168:3243:c937 with SMTP id a92af1059eb24-1b543bb56f2mr276351c88.16.1794936719280;
        Tue, 17 Nov 2026 09:31:59 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm43450247c88.11.2026.11.17.09.31.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 09:31:58 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlemoal@kernel.org,
	naohiro.aota@wdc.com,
	jth@kernel.org,
	Ding Feng <dingf3ng@gmail.com>,
	Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in generic_write_check_limits()
Date: Wed, 18 Nov 2026 01:31:28 +0800
Message-ID: <20261117173129.61028-2-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117173129.61028-1-dingf3ng@gmail.com>
References: <20261117173129.61028-1-dingf3ng@gmail.com>
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

generic_write_check_limits() stores rlimit(RLIMIT_FSIZE), an unsigned
long, in a loff_t. A soft limit between 2^63 and RLIM_INFINITY becomes
negative there, so "pos >= limit" holds for every position: each write
through generic_write_checks() or copy_file_range() fails with -EFBIG
and raises SIGXFSZ, although no file position can reach such a limit.

Reproducer (bash counts ulimit -f in 1024-byte blocks, so 2^53 blocks
is 2^63 bytes):

  $ bash -c 'ulimit -f 9007199254740991; echo hi > /tmp/f'; echo $?
  0
  $ bash -c 'ulimit -f 9007199254740992; echo hi > /tmp/f'; echo $?
  File size limit exceeded
  153

Before commit 9fd91a90cb98 ("vfs: strengthen checking of file range
inputs to generic_remap_checks") the limit was an unsigned long in
generic_write_checks(), and such limits had no effect.

Keep the limit unsigned and apply it only when it is at most LLONG_MAX.
Smaller limits keep the existing loff_t arithmetic, so their behaviour,
including for negative positions, is unchanged.

Fixes: 9fd91a90cb98 ("vfs: strengthen checking of file range inputs to generic_remap_checks")
Reported-by: Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>
Closes: https://lore.kernel.org/linux-fsdevel/8F9EB913-3AC3-4D89-9DA3-427029F6D211@kba.biglobe.ne.jp/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
    Tested on v6.12 (arm64 tinyconfig, QEMU virt, initramfs on ramfs) with
    a static test program that sets the soft RLIMIT_FSIZE, writes 2 bytes
    and copies 10 bytes with copy_file_range():
    
      soft limit            unpatched           patched
      1024, 2^63-1          ok                  ok
      2^63, 2^63+4096,
      2^64-2                EFBIG (both)        ok (both)
      1                     short write, then EFBIG (both kernels)
    
    Also reproduced on 6.10.14 (arm64) with write(), pwrite() and
    copy_file_range() on tmpfs and overlayfs. Compile-tested for x86_64
    defconfig with clang; not run on x86_64.

 fs/read_write.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b15522c..18a217d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1693,14 +1693,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 {
 	struct inode *inode = file->f_mapping->host;
 	loff_t max_size = inode->i_sb->s_maxbytes;
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	unsigned long limit = rlimit(RLIMIT_FSIZE);
 
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
+	/* No file position reaches a limit above LLONG_MAX. */
+	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
+		if (pos >= (loff_t)limit) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		*count = min(*count, limit - pos);
+		*count = min(*count, (loff_t)limit - pos);
 	}
 
 	if (!(file->f_flags & O_LARGEFILE))
-- 
2.55.0

