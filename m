Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640440;
	b=Z7NMg4kb9eSowuKMpltwtVgFiAlL+PSaZBj8Yb3oaEUtYM1HR5qGKd3NzhQ29xOnoEe4
	 fpWqgABqFF/bAFhFdYC+HyZKIrfoB5naSqgQHOkj4lkj6Jgwzzw7YLZ+qVYWRMqWJyw+7
	 kw76joVsC23EwaEnhV2QqL8tzBXFfHdbHQbOVrnmnulcMV2EWN9T7zdllDLE69FUeAp2c
	 zO1OvTphZWAHBtUdQczmq+IypIAS7BSez67zW3t1r/Z6aOcGgMqSdEpJicSyHtAI9hdSA
	 UEK8GQ8v+SiU+lN7Pvz2fqTbwQnpDHBRfZ12SzRv/+xqz+Y31cPW6nrK04l6DEFk26A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=63egZoYTiZRkcU8bAbviisltXbcArGRBXHQbY8br8Ik=;
	b=o87URt7u/9pvmmPOD2hMoV0F6prwiKuxX5UIiB/+f33Ut6edWebm0UGJhihsq3b8uJhI
	 sSeKG7n/x78VJvxlOkM3sN7T81jl2GN9KumS5usEVeKKfK2FcGnsLFq2Zws85Qt1pnT1A
	 7Wnjcd08vIQASP8fbc/gMjToXX+Z0bCu/IvKlJ/evDho+sQJVnDWn3fIQIjRHZ2C6Ckgk
	 1MvAI3iWkhHb/bNCgvgkswp41gdHNYR2sedK3V0wNjF3maKwb+K2+DLAG99h2Da53esD3
	 Q5U18fRDETgK31x8DxoAQjen7kX39b/4NKCfkaSdY+qrSHqIgF+RObNZccl8Ay1MZ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kCI2RQA8;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AF606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B42AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kCI2RQA8
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386a0f79047so6610063eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795640439; x=1796245239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=63egZoYTiZRkcU8bAbviisltXbcArGRBXHQbY8br8Ik=;
        b=kCI2RQA8GQqKy1qyCiMB/N+IG2c1aw3bZgpD0md7Lzyo/gLoQZ4ol2vr6h1qUGLVti
         uTv88Nz25wrmN2c6dk4tn/FSbQIO0nDhUDXvzjCtPJRcnK2K4bgKsbKPxW+vGAMGgnKD
         fSrYcPmZNPq+kwQTNg1KWKjOGlPJEE3Q5hGhlwNelemBBoq1x2mJwQg1IAhdfwB6+jTW
         Y27m9pzxsPXKfwC5gJ9GYQ5TeqDAF2CML+FhEAcHmpinYN7mPWZyqHKy3Mz0C8GL+3uq
         B5Q1ibK8kJy8LJQ06q1WZWertzDhpubm31CeRiowmCXzS9Ry+CGBJkXMrrozM9GkbyF1
         qHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640439; x=1796245239;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63egZoYTiZRkcU8bAbviisltXbcArGRBXHQbY8br8Ik=;
        b=t4Qonxw+9vZNRtkNJAj0tqR3PpDzDR4ugDdweyEHLMPrHtN+SsBfQRW0YEpTrBbslQ
         oLMXwnCNhPykAlA+pkM7w8qnm9/8YKznXxJ7EevWvKro+rf7I6yeKPYWNZTsIfg49MyI
         bD2dUwxsqY0TUNfIOEYmKoL/61tRvXXtPevmyOzqgC89DpOuV9rGtk0JPwo794Rw539N
         lnpS63wv4BMSfSSS0R9lrcq0cu/d7ywWJngOdyaHaLbmHVVkQTyBYE/IuR/EGlOUC4vb
         DZ2Q4HSfcBfjD2z7yIkC/O+rxDbZpZR+O8JvwljwEEQpQeiGLP3vS0JPNQ7uvK01OSYj
         3KdA==
X-Forwarded-Encrypted: i=1; AL+hErEIcU+MQrYfN9IRHzfI2jtcXQLytN+dGRbbMySgsDv0ZPpjsTYaJYmcojUezcw6WKk2/zW8aXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Mf5sKwzeZp5Z9AiMHsSZE2sycvMge5cPr8wyzN2GC4i7lMSRq
	5X5aH+TSYWeBgi4b2ic/CHYLgr37WfZ318IBmiAwlGe3V4oJMXvsa4CsDkZDBPDI7ZS2SXNnCh7
	qXg==
X-Received: from dycnh14.prod.google.com ([2002:a05:7300:ce8e:b0:36a:17c6:6824])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4143:10b0:36a:1f4f:3e9
 with SMTP id 5a478bee46e88-386b1067bf5mr11917557eec.20.1795640438289; Wed, 25
 Nov 2026 13:00:38 -0800 (PST)
Date: Wed, 25 Nov 2026 21:00:25 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125210025.1277771-1-elkin@google.com>
Subject: [PATCH] smb: client: unlock reconnect_mutex before putting session on terminate
From: Elkin Cruz <elkin@google.com>
To: Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In smb2_reconnect_server(), when server->terminate is set, the early
exit path calls cifs_put_tcp_session(server, true) while still holding
pserver->reconnect_mutex and unlocks pserver->reconnect_mutex
afterwards. Dropping the last session reference can free server (which
equals pserver for primary channels), causing mutex_unlock() to touch
freed memory; the normal done: label at the end of the same function
explicitly unlocks reconnect_mutex before calling cifs_put_tcp_session().

Unlock pserver->reconnect_mutex before calling cifs_put_tcp_session() in
the server->terminate branch as well.

Fixes: ee1d21794e55 ("cifs: handle when server stops supporting multichannel")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 fs/smb/client/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 7b7d25364e20..2fc212593fa9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4390,8 +4390,8 @@ void smb2_reconnect_server(struct work_struct *work)
 
 	/* if the server is marked for termination, drop the ref count here */
 	if (server->terminate) {
-		cifs_put_tcp_session(server, true);
 		mutex_unlock(&pserver->reconnect_mutex);
+		cifs_put_tcp_session(server, true);
 		return;
 	}
 
-- 
2.56.1.839.g22a8290db9-goog

