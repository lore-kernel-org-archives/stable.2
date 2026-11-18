Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004845;
	b=fbTo1UdVx7j3l2D7HbQTTCsiWYiQwQrdOoBsTFM5EbsRxNiIWOH2yYRUE/ZghJE/wfKI
	 n24IeZGuV6hyvO167ZwnsXb+zZQloOxXyjj1NmVImpKmCJ3IgAG3xJLH+yngeRsLa7Zzt
	 mC0oyg/sHRp8AtqpKTdaGVeRyCWzGOpErpJMOlhVA29rR4BQWzwhbr6nc4acUUyg4/coy
	 /kkUGQBftpaC+rWQus5jj7dt7C4PqoEgLRXXLMRgRix6y8lfHA6D3qu0vR2a+fDLXP9Ny
	 tQny5sFAY6D/YPGvLWuSI4f6s88ljvlXQFvtBYZ7df+NCwnxSrMPyd4fnO/0Z15AE7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xz2Bk4myv4eiO5R8ei+E2wIg7nTAaAYUNv7l92Ae3Cs=;
	b=iGWwr0WzII5yHXUQT+fr6gMe0CrPCmi80rKdYW8CTptvE4fUzzL1O1uI/mDx0ef/KNwQ
	 smRVZtibLzC24zYVxbIpCFa4mB3xahR6BdM8iSJIPeOLkVwYYxHsK/cWy8cRerUbquYSL
	 7vIwHYeSSZC4twp6bvb4/6svqamP70woK7IUzlb58apDFgYk+tPp7AWvtDpfl61fIpRhs
	 F/It1lzKR/a91OwbPng7YTfuR6PfQ7XP6IYIA08TLjBNwGXidEDTbK4yeMa19ZD05QCZ3
	 XSPorhB65ODE0a8OrrisAfaZtjlbUr7mOjwkoezEP30f0PXPd9KnmpuxX8HY0gju72w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ywd4nucm;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5B606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C5B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ywd4nucm
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso6277625e9.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795004843; x=1795609643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xz2Bk4myv4eiO5R8ei+E2wIg7nTAaAYUNv7l92Ae3Cs=;
        b=Ywd4nucmEYLm0ATf0Lw1ZckaxEs0EzvRGYnkn/XOiMmiBstiWvmgQHqN64PEnM0tWX
         +TfO+Inb/WfN8XdC17/40AWe51QJW68L4/jKNnFE6XY2JI/pMpkqnPZOMCD+wYbGCRXK
         Tn8Q/Ap/GNVbC3IrqYJW3ZRrvqv7ChIn1W2VWyE5CxxRaWm+QQzXJ5GQEp+ZhN+NujWW
         8q4HwHi6LGkl9tEKMtyNIXgyUYqIF7BFkl3SLWHUbichUEgJ7RwAPaOLKPNv7zsEM/S6
         O2hn9kriQaukT7CMwu8pX12gl95KBr5bLklbZtB5DcWG3p867P91Y1DiNleztWSEfRb4
         uHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004843; x=1795609643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xz2Bk4myv4eiO5R8ei+E2wIg7nTAaAYUNv7l92Ae3Cs=;
        b=boTvFCBjyDtPn+9XLlNNMwpIA2sl95Fgs6T87YguWL/Hxl/NAY2y/8d3mmDIfMSjlv
         XifVtyj7j17kasBCl7yYTaNRvh4Ksllb/L6kYUYJj5A5wFDRGTngcI40qcBHneJ15nTb
         LCP9tRupUqU9xeMQbNvFK92osVAVWUBIkPiIR4XeGjBOApw7QXTB7oPtvB8hDVUCKGgO
         0VlW5pVq83VKVe/YU062JEA6x1Cyr4x+9FHlYesPTnlbjnoKvV/WbWCx7vZ9GruJ+5Gs
         +cmypzrlRHszSPBubOCWGo7C3GEoWVNI9Dk5Gl1DbWnleFxzVRt05rTGktMu+3Cefs3T
         aWwQ==
X-Forwarded-Encrypted: i=1; AL+hErH+knNg51uaWHWS2oZfZQ6obz24GbA4b7wTbSrCr5T8yqGwRVqWh6hitW92Pv5886ZW5eLeUIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HtzU/gfdKvjEviBfk+bMINbrKyb/5JE/IbeMOzkhdbfPSaLAD
	cipYmtXfJpNQJ0YD4p2nG5lzL0EYqjuvn5WHOA1+Vac8yzuwcV8od424
X-Gm-Gg: AYBFou332V/Ylx0bJkTlP8Mj2syq401hQA74Apx4nSjlFWtxkFeCi5YVrc7Oc85aAYK
	4L7h6l5R2yQJrWl008cXoN3OSCsceucWkMDQ4PVyZtXQR3ozXwy2vtHLLM8vYR0H1lAfjnB7ntp
	wV0bxd3aH7nea/pO0KZMFm+3iTEqEc87zFhC8q5LOMwx7oxL+hAwRorK9xtLx5ctggJwr4Idb3Z
	1wcM9615Uk4CyFiZqXeZvwV6MigDj7yYFs6wDyB0nbJkGUlU7WupvgWLlzlHbKeLMMYxzSRF3vs
	5yoBvKRLggPxqs9eIf+5gB8LuVvXn+FxKWmxuqzMkj3nYMPnRfHUVNnyylrgAS2Nuqc4ZmaPssn
	/C9OhJvM9OQb/c9ZpdO4/EvuTMBGyNMBx9SKZd7d8S2dMk8WQCf9xwLZAnsl2J7afU04/RqmU2w
	zbhP1/3fJyxuAPByxuKnzMHItStpEZY1puUE5JypIEgTlS93M+YQb8KoT8+uxfPrN6nWnHO8AE1
	MqRZxS63dsHthDBPsjXBA8SBN59wbmK7efvqBt/VNj8UMxoR7fiN1KuGL4KXB8evDQjnawKgY7y
	hL+0gh3fH8e5WGleMDWH4E8XUQfL55wqljeZH6ji8TU01Fd0FGiWDrS0+temaCCHJgA0fSIxjA+
	7I5+j
X-Received: by 2002:a05:600d:82c5:b0:4bb:693e:4c8e with SMTP id 5b1f17b1804b1-4bb7da270bamr55401635e9.21.1795004842666;
        Wed, 18 Nov 2026 04:27:22 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm150071565e9.12.2026.11.18.04.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:27:22 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Steve French <smfrench@gmail.com>
Cc: linux-cifs@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: reject oversized SET_INFO data
Date: Wed, 18 Nov 2026 15:27:17 +0300
Message-ID: <20261118122718.17236-1-suruurism@gmail.com>
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

SMB2_set_info_init() copies the variable-length set-info data into the
SMB2 request object without checking that it fits.  The object is
CIFSMaxBufSize + MAX_SMB2_HDR_SIZE bytes and the data starts at
sizeof(struct smb2_set_info_req), leaving 16492 bytes with the default
CIFSMaxBufSize.  A malicious server can return a nearly maximum-size
security descriptor; id_mode_to_cifs_acl() retains its ACEs and adds up
to five new ones, producing a rewritten ACL around 16.8 KB.  A chmod()
or chown() on a cifsacl mount then makes the memcpy() write up to 336
bytes past the cifs_request object, and the overrun is also read back
and sent to the server.

The worst case is much larger: if the server returns a security
descriptor whose owner and group SIDs map to 15 subauths, the rewritten
ACL keeps the original ACEs and replaces both SIDs.  With 817 ACEs the
resulting SET_INFO data is 62256 bytes; KASAN reports a slab-out-of-bounds
write of 45764 bytes past the 16588-byte cifs_request object on v7.4-rc2
(where the earlier undersized-allocation issue is already fixed):

  BUG: KASAN: slab-out-of-bounds in SMB2_set_info_init+0x47c/0x6d0 [cifs]
  Write of size 62256 at addr ffff88800ee28060 by task python3/86
  The buggy address is located 96 bytes inside of
  allocated 16588-byte region

Reject data that cannot fit before the copy.  This covers SMB2_set_acl(),
SMB2_set_ea() and the other SMB2_SET_INFO callers.

The vulnerable copy predates the ACE-retention rework, but the rework
makes the overflow reachable with an ordinary chmod on a cifsacl mount.

Fixes: 35143eb5c2e3 ("CIFS: Add SMB2 support for rename operation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
 fs/smb/client/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index f85595136ef8a..beb3abf9724dd 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5894,6 +5894,17 @@ SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	req->AdditionalInformation = cpu_to_le32(additional_info);
 
 	req->BufferOffset = cpu_to_le16(sizeof(struct smb2_set_info_req));
+
+	/*
+	 * The request object is CIFSMaxBufSize + MAX_SMB2_HDR_SIZE bytes
+	 * and Buffer starts at sizeof(struct smb2_set_info_req).
+	 */
+	if (*size > CIFSMaxBufSize + MAX_SMB2_HDR_SIZE -
+		    sizeof(struct smb2_set_info_req)) {
+		cifs_buf_release(req);
+		return -EINVAL;
+	}
+
 	req->BufferLength = cpu_to_le32(*size);
 
 	memcpy(req->Buffer, *data, *size);
