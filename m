Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704055;
	b=v6yaIUcy5PExusS3iQnUE8+KrHI5LmJrVfXJh4zz2OQ63sKUs3e4Wmjc8xJm3g0uMv/b
	 91JvDGzSn1C7nklEUt2Hlcs6v0U1kcY7Oq4t0aSEIG/b9M/QbOF2IDmKW2DwXm51mBMHD
	 bTHyVOf/Ck2sYVKtp0tsZmF90Yn3QWmUXSo7fFuaeTsXPOr63mK6piwpuZSWvYYx3DaOP
	 X+WBKKJKTWwB1GoBWNzbStuIedTxSLc6mk16OTR/leqmIPl9PCFDMRQ9BRgpjLpH2Busl
	 KcxADhXwRi8v9GPUhwglEyJgCeuMJI96k+HQzzsJyuLfGcVj9xLaguYy/8h383a7KZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UVbEycL2aVDX1kKVTF2J2/su01Bc/OvhpBqtwAQKSdE=;
	b=LDEykLXDvgs22HZNYeJquCFvcZmSdECch+4OTEfkGElgFbtjHq+qt3ucVNN9qSsqzPbP
	 dPfmzDpjdLa4ZxUkYzxl1HAcXf9TyDjqEZbG3oEaKtBxyXJC3Dm8Q7rYnCrIvcrJfiHgU
	 /bPx3UTwu1eu6v6taKXacOPYoAqnVwrngWgKnV6XTzqpGulQYYDN0//2rgWK9xqB8AbZV
	 w6Wb6FWBrddnLJQaWTSybvlCti3kp5yy7da0mjSs/0futCXPJmkEQM7fGEyzOv1v7x9X9
	 qzjVZRn62pX8sQALVmoR+PIqI3/NvdY7Yivci5f15Ckv9z3wtbVLeDa2FnSPwOopKfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDvO3zQN;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15A606C5D4
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C15A606C5D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDvO3zQN
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c46bd7a7345so111870566b.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793704054; x=1794308854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVbEycL2aVDX1kKVTF2J2/su01Bc/OvhpBqtwAQKSdE=;
        b=HDvO3zQNCtxDElZny+Rx4A3ZcecX7z+b5s72+sPjp1ej+2snyldKiyD5l0psnXmFCH
         VK15EIYfoc+O20b3Lc4PWeGyNhz6ECy2oYfPHv1g9TMmahUqGHpuvxH0esbGdcsLI+MY
         KuXVQI6LJrhOCCFlJo0rBfO9IO8ihpVdFjh5ZUle8hBIlsll6vZbpFdFpj+QGPDSg4lO
         45VNPJkXgAOPI2tjWj8xTVYZIXsiYQAjXuprjTN0ZFBL3N+5mb65Izmh7+jqtDUtfyZj
         qPyL/ZFIPLn9RpQ7E7nS4zJN+xBYZPPaJq2/Vzm9ez4R04rMXm2NycPrr0LPwi6hUt1M
         pyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704054; x=1794308854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVbEycL2aVDX1kKVTF2J2/su01Bc/OvhpBqtwAQKSdE=;
        b=S5TWCm3AhsocUES3dKw5sfMqjrg3y0n2airL+XnLydPOBYnDKZoPCPssquPT33IRzf
         UhPc//ptF8xGobJhcO4OIONuLe10ECDjsC7bVQ/AOPzEWD5RbwXIBNN7LVDix0n9ZOKF
         JXNwfdvwPvNnkAGEeUZkuLHeECzJLVtQooYwGEGmEMx9qJifMnh0hiT6lH57j39QIKaP
         7DVpPHJTcUx6YFcxMkbfFqqqMgwBa/qg1+RQ3SzozOGtrMUTORJLN2SoPzLRI4KvUG3+
         0Bus6yLSLkBwLWTHWrNIb4PdhXgtfX++j1wkBtiMfRa4IsYdSMy4A6L9UzViDM69fIfX
         cdUg==
X-Gm-Message-State: APuU4Z+0oLA4otOjnPP28LS/QiruWHAt2WfjFS3xQ9TIcSi77pUjHwhR
	MRoq3pQABn3q7/2QdfVpWA/F16w4Usvy/qWCpsndg1vDAWG0tWlJMjuRxIv56nv+B30=
X-Gm-Gg: AYBFou1KrLBJuM20TKbf6HMLsZbyXf6j1rufd1N10uVOs0MWtPkcpdqnZRZ0TQGFEud
	lnH+BtTgcXo3tQQDr2/E6kJYejln0q6UBcKY7JQhbinh2dxeiyR0wrzbdcUIHnQqNteOkOK5MpX
	e8daTzPiVUUEbDJbjs3EYrvevnX4FNyOjHCyzOGXywiTjx3OH+dnv88Na9PIJpanYCKgmLe71mW
	1oRCxrm9P5Obgy5WqxaNgwNgJ29nviLkI31jDlZpFuIpO4JB74H9mv24u0WY1HJeNp/tL9wjCnf
	fVSQX8MHAQg4Y0KsJAMdojNV2pxYlPQkuN7H59sRk0PcXDl1+9agB0ARTm/eCHoleXNNLAmAfDx
	GwDyQpfFa9O3gYjCrJSj1tmFXEWIR+XVjo8LfouwJrruuYL1JWuRooC4kL/DvkUHFKvffxUTKah
	KFu+lw7e2q7JMsjIr7/uXUd+ovG3FLd8ClCUuIsp4VZA1DS5rW1RDS/b2uQCVPBqoCtFH6yNIgB
	r6jmPFy7vaI2fyffitrXdmYQtTE+1adPKz2u262nUgrnvo4l2IdXfyDUzu7vr/KC/Q7ZxlIdLxa
	8PHCAJWPUfDgb0mmG1+OEtzHnOhTZayvP34YTu0wEzL0ZjDPUqAC7TObp9r1VjYqggZF7zjv+8g
	dWcAmAh2GW5+HyU7dBqbDa/yJOF4KP7rxtZn3puOP
X-Received: by 2002:a17:907:3e06:b0:c2e:7fe7:2898 with SMTP id a640c23a62f3a-c4ca7a6aa23mr1140197066b.12.1793704053402;
        Tue, 03 Nov 2026 03:07:33 -0800 (PST)
Received: from wlan-199066.nbw.tue.nl (wlan-199066.nbw.tue.nl. [131.155.199.66])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebebfabasm75321666b.28.2026.11.03.03.07.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 03:07:33 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: stable@vger.kernel.org
Cc: Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: accept share config responses from ksmbd-tools before 3.5.3
Date: Tue,  3 Nov 2026 12:07:29 +0100
Message-ID: <20261103110729.83771-1-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026110300-underwent-entrench-2c0e@gregkh>
References: <2026110300-underwent-entrench-2c0e@gregkh>
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

ksmbd-tools releases before 3.5.2 do not have the payload_sz field in
struct ksmbd_share_config_response; the field occupies the last word of
their reserved[] area, so the kernel always sees payload_sz == 0 from
them.  ipc_validate_msg() and share_config_request() used to treat
payload_sz == 0 as "legacy userspace" and skip the payload size checks.

That case was removed by
commit f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config
responses").
With payload_sz == 0:

 - the IPC$ (pipe) response fails the final message size comparison:
   these tools always send a one-byte payload, so msg_sz is
   sizeof(*resp) + 1, but the expected size is now computed as
   sizeof(*resp) + 0;
 - every other share fails "payload_sz <= veto_list_sz".

In addition, ksmbd-tools before 3.5.3 copy a global "veto files" setting
into the IPC$ response, so with such a configuration IPC$ also fails the
now unconditional "veto_list_sz > payload_sz" check, even though pipe
shares never use a veto list.

ksmbd_ipc_share_config_request() then returns NULL and every tree
connect fails with STATUS_BAD_NETWORK_NAME, so ksmbd cannot serve any
share when used with these ksmbd-tools releases, for example the 3.5.1
package shipped by Ubuntu 24.04.  Login still works, which makes the
failure look like a configuration problem:

  CIFS: VFS: BAD_NETWORK_NAME: \\127.0.0.1\IPC$
  CIFS: VFS: \\127.0.0.1 failed to connect to IPC (rc=-2)

When payload_sz is zero, derive it from the size of the message actually
received and store it back in the response, so that the checks in
ipc_validate_msg() and the path and veto list parsing in
share_config_request() all use the same bound.  The response is the
kernel's own copy made by handle_response(), and msg_sz has already been
checked to be at least sizeof(*resp), so this cannot underflow.  All
checks added by that commit then apply unchanged, bounded by the bytes
that really arrived, and newer ksmbd-tools that fill in payload_sz are
unaffected.  Also skip the veto list size check for pipe shares:
share_config_request() reads neither the path nor the veto list for
them.

Tested in QEMU with ksmbd-tools 3.5.1 and 3.5.7 and the in-kernel SMB
client over loopback, with and without a global "veto files" setting.

Fixes: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
(cherry picked from commit 4f1ce9ffb996a524acf864316479a7806ae500c6)
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
The only difference from the upstream commit is the file path:
fs/ksmbd/transport_ipc.c here instead of fs/smb/server/transport_ipc.c.
The code change is identical; git cherry-pick -x applies it cleanly
with rename detection.

5.15.222 and later contain the backport of f25e93768fcc, so with
ksmbd-tools before 3.5.3 ksmbd in 5.15.y cannot serve any share.

Tested on 5.15.224 under UML with ksmbd-tools 3.5.1 and smbtorture
4.19 (smb2.connect), with and without a global "veto files" setting:
the share connect fails without this patch and passes with it.

I used an AI coding assistant to help with this backport and its
testing.

 fs/ksmbd/transport_ipc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 9d7b21257bc..500735ddaa2 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -478,11 +478,25 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 		if (entry->msg_sz < sizeof(struct ksmbd_share_config_response))
 			return -EINVAL;
 
+		/*
+		 * ksmbd-tools releases before 3.5.2 leave payload_sz zero.
+		 * Derive it from the size of the message actually received so
+		 * the checks below bound the payload for those releases too.
+		 */
+		if (!resp->payload_sz)
+			resp->payload_sz = entry->msg_sz -
+				sizeof(struct ksmbd_share_config_response);
+
 		if (strnlen(resp->share_name, sizeof(resp->share_name)) ==
 		    sizeof(resp->share_name))
 			return -EINVAL;
 
-		if (resp->veto_list_sz > resp->payload_sz)
+		/*
+		 * Pipe shares carry no veto list, but ksmbd-tools before 3.5.3
+		 * copy a global "veto files" setting into the IPC$ response.
+		 */
+		if (!(resp->flags & KSMBD_SHARE_FLAG_PIPE) &&
+		    resp->veto_list_sz > resp->payload_sz)
 			return -EINVAL;
 
 		if (resp->flags != KSMBD_SHARE_FLAG_INVALID &&
-- 
2.43.0

