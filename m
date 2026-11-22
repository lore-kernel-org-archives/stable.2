Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323528;
	b=XCrNRDhozjED28azYCWUWOW4fW4Bsw2/7OfA6cLbGMM1sN1XuTm9W8iFLzQ5t4qsk+ec
	 SC9/kKVL/diXtBArqGquFMJ/XsYkT8ZIh3zP7EofcoJTaKXnuOJYPs2Bubo366LKnfZox
	 kvfB0t2COczvDPFDyh68XPIjjiVf3ikipp8uq7592/03f+SS5ZTFss6ryRYf0v+awtF0z
	 Bx3KT3hxlAYOnaMC/p3V54hMpJVYCVwWT41wtM5YRT+9zlT6gNPqVpt2dyQGYDdNTtRIn
	 gZ/srGbintz+PFUrk8Vn52Icz6K2o0blcZwRpwADFwu5HT6hv0Ucgig4lY7VzK9k32w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F3QLio3AscsLh+2pvh7N6KImPKdVE87TLT/zX5+h2pQ=;
	b=DYKct+Y2HznJFYz+qyJ/wYtpcHNEBdQo+WpQpwGX+RArn8xKkQRKgz+gaSkK9XkPq7do
	 k7aX3oI9LrSkdZVNNfJWpdCVZumUq5jcpozijhUS8ysf5xUKnEzfnATGnMgglVr5OY2YH
	 RsHdVps0AWCB+acJy21uIhKHZa914GD4wfAqq/OZuXnRU+3l8TIrGTEP25MBX4UBDKU43
	 lrHjBdKHIKtjO4b/QzEZhFZGIA7GvgvX5PZZEjtuGh6h+hkl/3x1iwz6RgL+PCZo9w86e
	 /1S9gJ9U6SyLBBmWGa6loMWMm0aaLADHska5wxrVG1Y0lDpSVkx0S+wJtrGuq6JHdrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iynhWeN4;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F78606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 04:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F78606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iynhWeN4
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38587f3de36so2704344eec.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 20:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795323527; x=1795928327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3QLio3AscsLh+2pvh7N6KImPKdVE87TLT/zX5+h2pQ=;
        b=iynhWeN4gpV9WpcFJKJKQzv0Npt/bxr3E+iEa25Y2BjgaoxbpHvQdMsIBpsXUqerDj
         hedLrg/AhtkD8omOXtvSx7eH54EXEEu12XQ176IdCTDFkwdup6Ugwtlpx8L5Ds8O8N29
         rDnXCcVlQVR/yFB5Q7X06MJj/jRhFN7wjwzhNd8Mne7eo9zwXwMaTj+Ah6I+6voLT0By
         2wy/oBR6HE+fgXhNtfQl3qPammeOevGEP9NTMhkKDpOh0pOr3uipEG+CLTOK85gQGfcb
         7lDGq5aiVc1Z5IG9fkwyPybbcCKKC35L6dgifD9POJBeyFs1l7e8TxpwHNdoSuFejvKp
         2FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323527; x=1795928327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3QLio3AscsLh+2pvh7N6KImPKdVE87TLT/zX5+h2pQ=;
        b=uoG8qbNtJiIjlUvWvlgXi8GPgSLVR7VmwFNx5mTr6E2N46JZCZnWOyX0cJtOO4KISn
         uhIKzStUdWzsntTE5xHGLMfccW6auqjMD7YMpEhuhyDMMaJvrMaSBZ63QbIBS3u2hgXi
         9hrQU8qbX+Z1upiUOo5MmMReZdf5v5ckq5WzOxOp1VNODNqMdeVLB8yegA6T3IpwAqtQ
         2jU3pbgXcy0KYFzV1uwwdyYH1pmWE1mIaW38bb9QRXU8ef7TRXHkdHIV6LeTi4fccrXm
         x/2aE4ZAU9pqAnHhHR+O+yOhmr8A3QCONRG4BVPlYPz6lhO+6laxI0QzCH7VxHaavsx3
         uPrg==
X-Forwarded-Encrypted: i=1; AL+hErHD2OlWp/PIYlzkyTrgPafZB81uY7Yg8MUo2oXw5Sx5RAY60KMBKyKU+80fcVW9GSaO3sfID0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B8ttUPqoPjhgkRfCbfaP29wR2+3yN3ctc3VoJ/+ZyxWtEc220
	oIbKtOJTqiHxFqfk47Hs6c/TBMFD/swiIp36WgoZBckaA1kka+j1b/5e
X-Gm-Gg: AZFdTZe9tp1N8mJU4Wdu1QezTK89EA2Sf9YbIXjyurGajgvLBjVTzYpSSlmg3yVIwnA
	GuwnzHXbdMcCDTqV8r8p9ypTdrfnU0VZOLLn0onqh2gQBZFgn4blhccNoyW01gA2i2miCerCcEl
	7vjntn+TzCfwX1QcLiHslnalrE2ukd2BFTwN2M49PlmmPPgO8esLWdHHzAK5HHlKcU7ecmSD9eS
	LWsnRS/Y3ImNm9+a09OmIObW9PpAtVsb+xs3CpXXN4kjk7e0gC3ukVOmGKCs2m4YWpiKQFn46a9
	KfNQ6US4aPKAP/Agw14polCKCI00TpCZzIvthBBjPEO6tIhQx71Tz1YSOvgydwhBFjwhuVVM22Z
	Zrm2p4Ru01emQ++EHh6c9ItQQB5Q/bBmfguhpwMoPVKs8rXKBcZoXkypMFzDUiq9OIrFTSNV8UV
	GpydHdIn6UzQ5vkKBUfg7fnAE7GFzyRu2elvgZYo+iSbqizfYE7N0iGeaCKuxToJsQm9FmytWsQ
	NEGzYoQXH/7FWPhgBT0GMxQRayG5K62LNzEtfixgNiloP6xaRXp1jo37I0r1n7BsMScM24uOV5y
	5kC3YxHsH8KBgr8QlmhmqK0MxV2mPshJHwAWnDECuIoKEcUOzYr0
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id 5a478bee46e88-38570b34fecmr8521946eec.41.1795323526357;
        Sat, 21 Nov 2026 20:58:46 -0800 (PST)
Received: from fred-server.tail1cd3ef.ts.net ([2600:381:4c20:1067::7ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm38865118eec.3.2026.11.21.20.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 20:58:45 -0800 (PST)
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Cc: ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Tom Talpey <tom@talpey.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fredric Cover <fredric.cover.lkernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: convert DFS target node name from cache charset on mount
Date: Sun, 22 Nov 2026 04:58:40 +0000
Message-ID: <20261122045841.99012-1-fredric.cover.lkernel@gmail.com>
X-Mailer: git-send-email 2.53.0
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

parse_dfs_target() converts @path_consumed to the mount charset using
dfs_consumed_to_local(), but @ref->node_name from the DFS referral cache
is still encoded in UTF-8 (cache_cp).

In dfs_parse_target_referral(), passing @ref->node_name directly to
cifs_build_devname() and smb3_parse_devname() copies UTF-8 bytes into
ctx->UNC and ctx->prepath (and mixes encodings when @prepath from
@full_path is also non-empty). On mounts using a non-UTF-8 iocharset
such as iso8859-1, subsequent path checks re-encode these strings to
UTF-16LE using local_nls, corrupting non-ASCII characters on the wire
and causing initial mount to fail with -ENOENT.

Convert @ref->node_name from cache_cp to ctx->local_nls with
dfs_cache_local_path() before building the device name so ctx->UNC and
ctx->prepath stay in the mount charset.

Tested against Samba with iocharset=iso8859-1 and iocharset=utf8 for
both DFS link referrals with a non-ASCII target subpath and mounts with
an additional non-ASCII prepath, including reconnects.

Fixes: c870a8e70e68 ("cifs: handle different charsets in dfs cache")
Cc: stable@vger.kernel.org # depends on: smb: client: convert DFS prefix from cache charset on reconnect
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
---
Note: Applies on top of "smb: client: convert DFS prefix from cache charset on reconnect".
---
 fs/smb/client/dfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index efef00c33321..6b212e49cf92 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -25,6 +25,7 @@ int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_para
 {
 	int rc;
 	const char *prepath = NULL;
+	char *node_name = NULL;
 	char *path;
 
 	if (!full_path || !*full_path || !ref || !ctx)
@@ -40,7 +41,12 @@ int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_para
 			prepath++;
 	}
 
-	path = cifs_build_devname(ref->node_name, prepath);
+	node_name = dfs_cache_local_path(ref->node_name, ctx->local_nls);
+	if (IS_ERR(node_name))
+		return PTR_ERR(node_name);
+
+	path = cifs_build_devname(node_name, prepath);
+	kfree(node_name);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 
-- 
2.53.0

