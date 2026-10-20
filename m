Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520686;
	b=gA3DD1pYrm6cfxLLBjrq/gQp70hSwrblUKlcV207e2ULc20W5mmQ/1TdVwbFv18NCe0+
	 XeEuQpdHNu5QcGEyuomoDHhuAiEkk4FNT3gbPGD/ZVQySScD7IMbw8zh/lgnPpU8X7aTx
	 H+4VP7cyphc/Hmq5XsIr/S7pXI9UTDJmzFa6MM6jev4/jmHeShITpRZsmtd5ibKnolEKU
	 YiRCsTU/TAHST7+CiorA0pYygJka7TUSwmhPT+Lk4gLjBFiwCUAuVIXZwMpul6dgMgfHn
	 n9lHDwGxUvj4ZPo3M1dSBMN6tuyyK9IRSgqaYJ1Q2P03thXx/BZluD+zOsBQ6ZURCXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
	b=VG9tQsOH0J8FokkUeq6rRrvbN1wJyFxSQSYbtQ2IxGWWxV6sXy4yT1Yf8QuVg4ZIHvik
	 i1LatfyTVHHkUvhjMAzjiGDXBxOV9sMb8YDU61XwffyoyWXmNEf3yIiTanqWqsPT9m0Ld
	 33aTRQSjmoJU+U/yxKuTJjW9k3u0zJvrHCGr8fvaJ4ciVYEyML0kTanzpft4tSQ74WvtW
	 ZwhwEgMyhFRKQfAhtvVgh1goiDSiRK5X9S0yM9VycSnORXwZIkoSfMG4wL/SIK/Ny6ueG
	 roci2hUzn1+HAE9M6E0p9ohNUnzEQSkdsS++u4apfxeKeLxpIMA75XjGhiFT6JprKPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGtd62Oe;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC1606A328
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2BC1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGtd62Oe
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso2228745a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520685; x=1793125485; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
        b=BGtd62OeWPju/vsAngLNxXqcgxNfyL6+oltPcIxN2sjko2c+R/Pjdl+lU60njYYNTn
         /RvenEldENHkj5P3LwKPrWJxxODoN2CF7ex4BbnlUAKayCIOifgNe6CIjrtTlVGoYw9p
         xRpxpKK1ZBGaHWqi1bhPWGtcrGYihNoL31M3s8YoHE65ncWM98dsuaiv9VPOVbYsuBSy
         78VFlK2gPYjHtVUozr899M0VDZXb/2WX8yMzec9LPoshvwVyKDLHbs+5gSovm7Yl0K8B
         p6QvYWvfPiynA3JnJpAtcz+NRJTTDSvuRFvkCQoQ8I5mKGPa8XLBgeJjx4pk+vWA4Zm/
         YMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520685; x=1793125485;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Qfir4WwcKrqoeimy2iPxwJM24Gz/gXh2B2PKiKQams=;
        b=xx9yzsdJN7hw3ayKhl7EDeRqkAMCeJ45kMk7w9degy0zOJ42BSUjNg5pT5kkYdAgYm
         s8rAzyT2dt1MaY3hBs2Ypz1lQgff2YksppjGTaVWy61uNnF0rOCWRqzKk1cXU8H9Dw+7
         RxbnV1JyJ3fGpMbY3yyqRkrDVy99z9v1mHcflhSgpzMcruWsCX7ygjefYH+IjXVLDtRB
         zXl9wnnh1wASVWx3VuxYgSTmAc5za5zPpjxoR7Lmm9dI9EeK5bC/eH5Kj+JtmDejnpHw
         B7zoGiZB05q8wM6YKW+cfMbPiMCQeBdWL09y3x/m2pV4cmgWWbvasxtI4oqM7EllXguR
         m13A==
X-Forwarded-Encrypted: i=1; AKwUvBzjhbWehJjudH5aqWk1MfW1bdrkovVjUra4R2087WjgHHQ/5BZIkvaM8gVXcAwPKxVaObyc44Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJaNkprqwLMsYR2/9jZFYhC4Kdym+6LeW+CxEXl2UfLYysqGBt
	6thV67YTmuB1+P2vCYPaCKAcruEw/LCeJ5DJ9nOo8SyiOV87h7UK7Ctz
X-Gm-Gg: AYBFou3LDrEvgpSAZY8S0kD4SKPasBXw8lMD8iYa9sbKIPMCq1uTcojuGg0BMrrZ+gX
	CM4l7oE8DzHY7WNK83bdhTYJedv6U4fYdXL/VmEGSLHvuFWvAOHtL3R41uvKF+xuHR6qo4Qe0O6
	DJJZhtHKopcxni+TfrYKxxdnOd040nexMgmRF7FpT8mZ/Q5UUUlU5KEmaX1679rT+sWAaB7hH45
	xdMQZLUmTotMRnSNp2wV7MaQVQ4ebHgq2PyAXYMGt+xMV1hlCVJfj8g0exuZ2U9oUStkgaB+YDw
	g5nQbcv1EfEQnqFJXudYJxzAll7T0g1Emdf4ki/9FoN96i/kwrimUol5Kh98+hLtQOFx+A7J/VE
	bhSdF35zYQdAFbvZL5rKqPmj3buZgwjmCzwxU1XVahGjKCxlvV0qh6tzSsWJk+eZVBX4pGOdrHT
	sjKekLDMJwRe9exjMCUvlP+jOnJRia0m7GNAavd/fIWoSw3wHRVl34Y8NpDa8bYUG8ZNubEdoqy
	6/Gd1gpTniX4KygtJ7sY2/V/JNkkH/El68ETxWxhrj2Rg3PHG4uvOrCz+vwg1Rv0DlkXjQ3RyOl
	z23I
X-Received: by 2002:a17:90b:1d4d:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3acef5f0687mr8948009a91.64.1792520684886;
        Tue, 20 Oct 2026 11:24:44 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad835fada1sm173708a91.1.2026.10.20.11.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 11:24:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 18:24:42 +0000
Message-Id: <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Matt Bobrowski" <matt@bobrowski.net>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 <linux-fsdevel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261020105014.97985-2-matt@bobrowski.net>
References: <20261020105014.97985-1-matt@bobrowski.net> <20261020105014.97985-2-matt@bobrowski.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> cannot race with that.

The crash is gone, but so is the path. file_release progs will get
-EINVAL for every file that a task still has open when it exits.

It also breaks what works today. The d_dname branch in d_path() returns
before it looks at current->fs, so at task exit a pipe or a socket
resolves to "pipe:[123]" now and to -EINVAL with this patch.

And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
that current->fs == NULL in do_exit() breaks d_path() called from ext4
open.

can we fix it in d_path() instead ?
With an empty root prepend_path() goes up to the global root, the same
way d_absolute_path() does. Then the check in bpf_path_d_path() is not
needed and the selftest can expect the path. A chrooted task gets the
path from the global root, but it doesn't have a root anymore.

Something like this (compile tested only):

diff --git a/fs/d_path.c b/fs/d_path.c
index c253090..ea49d33 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 char *d_path(const struct path *path, char *buf, int buflen)
 {
 	DECLARE_BUFFER(b, buf, buflen);
-	struct path root;
+	struct path root = {};

 	/*
 	 * We have various synthetic filesystems that never get mounted.  On
@@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
 		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);

 	rcu_read_lock();
-	get_fs_root_rcu(current->fs, &root);
+	/* Past exit_fs() there is no root to stop at, go up to the global one. */
+	if (current->fs)
+		get_fs_root_rcu(current->fs, &root);
 	if (unlikely(d_unlinked(path->dentry)))
 		prepend(&b, " (deleted)", 11);
 	else

pw-bot: cr
