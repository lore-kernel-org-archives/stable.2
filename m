Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163822874F5
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823751; cv=none; b=E73Nj4l4NvCYpT9T+g8BfDN4Dw3sdgTRmFBoKOgptQ2DDkOtT6DWS/I3l4N4nnmiHmolu+ad6Z0kjf+K6vfuBDdG6EHcnNk+v6D1hkwS5LFTv4pvfpFdR37WVB/nRuwxHyhAY890bVXYDxpqPxjNcFIpj77KqxHVoyrw6rXQNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823751; c=relaxed/simple;
	bh=82W1jolxQXWCFZM2JCRJXessZ9IBLu9YUb9lv+2DmGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEWEMxNl1J8Uc+xJL8c9lA9IEAGKjoLsRHR6ld7XZknv+bX84TsMuIf8C7L7TKCcYsKG1ut9DAIZ24GwXU/66J12iE24xkCIK6qXDKAjESjiJzzqfF2qySdO72Gay3wPQemn1I8FS4r54Ah5wpbZwgT8IbdPvSY+EkF+4TK/ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=DE9UlXdH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="DE9UlXdH"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e7c6ec9dbso196732785a.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785823749; x=1786428549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tre2t3DqAwsbqOY53Q7DgQbI8TFT+tAJpRwqGOsH2Sg=;
        b=DE9UlXdHd5X3OGM81+ZByuOzOGlNOvoEp0wX+xgD6sY2OkPSr/JnBDVH/O4N0gcro8
         McwRvxdpMONl5vfwGA8tpSbgkQJBiz97H6rF51yl3zo6QfYYKbuBeP5xcvpf0gl1D2JM
         4kr1Waxgki7PfYzklmcK4V6nrm8DGedILZ9KUcbgHfXyEeyiiyVWpIIFjqNEqCVmMUlW
         vKrA0BYumt9Y1s0AQMgHXv+YLFfC1/aSix/2s9KxdZlJSWLkj5nqTrFtA2W8Zfh936jQ
         lIFqhAgdPTfI2GtBqklBlclpUvDMAnyUOC5tO0Z54hdKLzcXcfAmLnij3Y6KRDCmFqwB
         woYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823749; x=1786428549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tre2t3DqAwsbqOY53Q7DgQbI8TFT+tAJpRwqGOsH2Sg=;
        b=qIkzgdiPjqsOlId8UtMZK4bLwAyPovcnYg+6fNn3SkD4LrYQV26EIkXH+LFY6Shlcv
         GyPsEMGlGmStg8yhCJoY/KLdAsMAirqmK8NCXbXu+UEgFBNtPQfy9nRYJQUyKd4dsUB+
         aJMIB+VT4YPVQyd5WS4QM/pGVdd38Zak9MwrSYVQvAha15CAxv7s3PUHroIHfECJg8D6
         NfPloTjFe5+/ijk38q1siu1xvAehwYv1YtjEYJ+k+VET0MBQR7889SYZT8a05eCmBl1d
         HGD8O7CrC/urZ6iOaR7561V2uGsSfuOOweSAWKQ4IsJevfoHh30d0x9fsjHzXYFcEkZw
         kNPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpuYsrvpl1qRIQNSnXMWe8R7keslnXMZ3wI1RZsECZ9gEhBUBA4/1eclzC/QN94o0VWvQbjndk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8l2jS+z0tzZNlVvxf0QYga5Kd0XTvxKwZpkHRxqm3bkvlXfU
	H0GcKcLdBIQGhV8+5LUo/uu9UQPEoJ1rD6lKXYdT04Tq9C6ccP2Nklk1h6fj2zY+G0w6Qp1rMX+
	hQrmd
X-Gm-Gg: AR+sD10OdimOJx/kgPXgUkJZWkPsaABX7eD+AuGoUlH2ERjZ7+JI3yLp21w8Bf27Jcb
	Y6QptZ/hPI9/C6pagPlhcxQq04NbBATZzDsyj/7orwfg4/XsUDRdZMVoGtsIZUVdF2u49SMqHX1
	80OWpbQAkWeXRG/MxBEZppubquybBmoyb6EUWe53F7vcibeXObw9EYDLVY6W5eTTwQbMrsaAWUX
	Cx7DrFW7xMJbmb+t7k95Q3AnKu+gsDCjtgnJjJ04N8EaZvmmYjN/fvrX1mxMmiO3fiFwQRzWsgY
	MHLacaQOU3ewJ9z3xDt3LTG22BJmr/wZngi6ZisHRf37NAzs8PWq0/73pVfcdKKOMWet78mvOLE
	m87pZzpAPSIhEewLA2uOIEpvWHn+q8HEk4VsLIwFb2F1DcnYxEHB3uviMV4U0KP8D0LYoGHTNk4
	wRPdH1IMV0biHI0mt4yN4JC2DYSKV1jU5urRp4drp3mEGaCj5LMkkFC0ujef9le7t+OQ==
X-Received: by 2002:a05:620a:935a:b0:92e:76a1:96cd with SMTP id af79cd13be357-934a0786047mr1718187385a.13.1785823749092;
        Mon, 03 Aug 2026 23:09:09 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-93641748985sm5080285a.16.2026.08.03.23.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:09:08 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: miklos@szeredi.hu
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH v2] fuse: wait for sync init request after abort
Date: Tue,  4 Aug 2026 06:09:07 +0000
Message-ID: <20260804060908.711279-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

After a fatal signal interrupts synchronous FUSE_INIT,
request_wait_answer() aborts the channel and returns immediately.  If the
request is in an FR_LOCKED reply-copy interval, fuse_chan_abort() leaves
it for the writer to finish.  The synchronous caller can then free the
fuse_init_args that owns the reply destination while the writer is still
copying into it.

Wait for fuse_request_end() after aborting the channel.  This keeps the
synchronous caller's reply storage alive until any locked copy has
finished, while preserving the fatal-signal abort behavior.

Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/all/20260731120353.558833-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 fs/fuse/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3..deee1585d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -725,6 +725,8 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_chan_abort(fch, false);
+			wait_event(req->waitq,
+				   test_bit(FR_FINISHED, &req->flags));
 			return;
 		}
 
-- 
2.53.0
