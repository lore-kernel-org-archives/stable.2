Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8539150B
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335921; cv=none; b=N+l+V24em3FY0N4Cb9NoSQCw3tLAFyhIqnWhFHlzRu405Z+pu+s5PYG4VqrefaeVCX4eblrU7Pp3EK0XvUrihE/eW1V/vTodjQUWskgKWNAxYDUBHn/uT0AxciUjWqd9ZLNap90v3KDghxPIoQZQlKw2MmJqdMucYC022Bh8uDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335921; c=relaxed/simple;
	bh=wk6vygH8NJfDOcKXAaJfgbMl5gGSxrJpO6cdJSZ6zZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ8Eaum2PA/nW7+hDqEUxKa+9ufMDjwpopWq5RMO7VbBkr5VUH91wf9O+J9/V9GNgrtopfuRdqVXesMYGoe1ht9bNOHzDhDgwWxfQddCJYwzetYMQOTm3PS+yYh7mus6WQfHhT7q79bUriCMNfrDLfY2AckEtZPZ1YweIZbkf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HH7OrD65; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Piidv2NT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH7OrD65";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Piidv2NT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9V0qAlXWmLruJLZFHIdq+0l21ICiVDZYVMxBS+fFubs=;
	b=HH7OrD65/hEY68J/hFOzGb14k/p9qISy29kVt09ELW/SLM/dNcirtmGJFO+xhTmpoKRtN1
	kY/wEpRpUIfByIHwhGNkTGIFriMYDJJuT8MRKNXjAggVDP+FOEyWo/kkgsYyBXox3H/bSm
	2Enw+aBDEcynumUOjUg85sYuLqweCKE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205--RUkg1BuPPi-SZOhWD97Jg-1; Sun, 13 Sep 2026 17:45:16 -0400
X-MC-Unique: -RUkg1BuPPi-SZOhWD97Jg-1
X-Mimecast-MFC-AGG-ID: -RUkg1BuPPi-SZOhWD97Jg_1789335916
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e8dd8be81so34568166d6.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335915; x=1789940715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9V0qAlXWmLruJLZFHIdq+0l21ICiVDZYVMxBS+fFubs=;
        b=Piidv2NTNGSVotANO0/eqlV+YR3aHeaFXAz2p2NE0DjvFVZGFgbjdRkCrFiSBuizjQ
         B0Y2QeyMUU8aGhawvKRk4Bo64izedYay6HMaSupivRFKubZnnPwMBLPu+Nqeb+A0PZ4v
         cdFLh5Nracb9Xx0yBZs2I8zUNK9vVk+7Fg7RFIci43v60d08BxiasKypTsbyN9g/mgm9
         xj632A9pUK4FG7HsDcWIIRCCi658T9XtVfb0cCJ8pnJ4HroGTnNNPHpG9pjGZJrrZiRX
         Kg2FRRQq2QSXovp289Frh/Mv9aiN9Xly/8GbNq5SsGbyFENz49yaUxwoB6hCS/VurayA
         aGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335915; x=1789940715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9V0qAlXWmLruJLZFHIdq+0l21ICiVDZYVMxBS+fFubs=;
        b=tWpaXry5tHA2jp+k0mJNouk49inWIMxFKC6SuEd81Mw3fccKHiEoVJgPe3c5Fu7l6N
         q4Ri8DY1rOerXkACMuynKDeAsGnJt71OSuNYXBPViUGxe9vB9OffeqfccOfHEBbyWlyd
         yzEqFBJ9gEf6oeA3FYZHporABJkxN4v24LhmNBzCVm2Njz/EMfpIODA4ZqsOiOp+z7S0
         oJERk10F/giKJWMjDJC05u90F2ew6Jzrzmjzp01bKQRMD6nTikbSizzw1iGE/nlBaBte
         Wr7E9NjdwqT0tIgKu6R4nmCMteWnWASVYgn4f24imF6dKNApPWk9qXx6iOCaFK5hxgOS
         fGYQ==
X-Forwarded-Encrypted: i=1; AKwUvByLIXt80403hWgmeStIOroF62zNTH0eFCotuWe+AB6TOPdvPJms2QgSJggvHgv9J7Qt+DSLxDg=@vger.kernel.org
X-Gm-Message-State: AFuF++nfEBLXVKyFikL8nUGS3+NW0ViIKhCLavLOFT4y4fxGcj9KgY93
	W+YjArUvPI0ssMsxqO7DPhN972S0z/2HlVS6RosQr2nL305279qZc5NkQl6p9bQd/51k7i8pRvL
	jjxazZ7A6S4HZisICUNqifw4mAQoq1ehhCe2YUzEc+976Rujc298YplB1ow==
X-Gm-Gg: AYBFou3Q5PEj7rX3cLZr9qMIhDuMDoor3m/GKuMbrm3TQ3CcUPs0jpD5YgrH7fGeihs
	CBm57gSKgp3rFRH5fJ+0/4olvA0Zb6Sp7rpJqOyt6md0HvDFmsdjdxnx11he0Kfhit7R/ZuiboM
	PEcSCC+/deFJuf/du8ZsNYeIfH+EsWZC//vZDuk4oe/c/O4vCYeIpzLRm/m/Ev8P2DX6dGJN4lO
	MP4iJHr8cxkqWPcTAqKDNEdjE2U+aGBcq4BK0Xci+Yz7QuWRYSpOJcpPSv322HjUytJIl4Dt9Yg
	643z3DgKPQRTeVMF/mbxZ6I+FYTD0YvcKD5kYaQPTbIEljcOfnXdpCklyc8TuMenMkuG42iPviY
	usbfAUx+qKJfKBTVySaZehzRvCvo0EbbHiBEaNVRzFDxw9os3f5vsW+jNhBVDeid9bg==
X-Received: by 2002:ad4:4ea8:0:b0:910:6aa0:5cdf with SMTP id 6a1803df08f44-9122e4cc793mr129036d6.2.1789335915487;
        Sun, 13 Sep 2026 14:45:15 -0700 (PDT)
X-Received: by 2002:ad4:4ea8:0:b0:910:6aa0:5cdf with SMTP id 6a1803df08f44-9122e4cc793mr128596d6.2.1789335915017;
        Sun, 13 Sep 2026 14:45:15 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:14 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 01/10] smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
Date: Sun, 13 Sep 2026 16:44:59 -0500
Message-ID: <20260913214510.3071370-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913214510.3071370-1-sorenson@redhat.com>
References: <20260913214510.3071370-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several related bounds checking and pointer lifecycle issues in
receive_encrypted_standard()'s handling of compound encrypted frames:

- Clear next_buffer after assigning it to server->bigbuf. A stale
  next_buffer pointer can lead to a use-after-free on subsequent
  error paths.
- Update pdu_length to the decrypted plaintext size (buf_size). Using
  the pre-decryption length allows NextCommand to point into stale
  ciphertext residue.
- Reject next_cmd values smaller than MID_HEADER_SIZE(server).
- Fix an integer overflow in the upper bound check by verifying
  pdu_length - next_cmd < MID_HEADER_SIZE(server), ensuring the
  trailing slice is large enough for a header.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index cb4fd09f996e..fcf7033889c7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5365,6 +5365,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	length = decrypt_raw_data(server, buf, buf_size, NULL, false);
 	if (length)
 		return length;
+	pdu_length = buf_size;
 
 	next_is_large = server->large_buf;
 one_more:
@@ -5377,8 +5378,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	if (next_cmd) {
-		if (WARN_ON_ONCE(next_cmd > pdu_length))
+		if (next_cmd < MID_HEADER_SIZE(server) ||
+		    next_cmd > pdu_length ||
+		    pdu_length - next_cmd < MID_HEADER_SIZE(server)) {
+			unsigned int max_next = pdu_length > (unsigned int)MID_HEADER_SIZE(server) ?
+					pdu_length - (unsigned int)MID_HEADER_SIZE(server) : 0;
+			cifs_server_dbg(VFS, "invalid NextCommand offset %u out of range [%zu, %u]\n",
+					next_cmd, MID_HEADER_SIZE(server), max_next);
 			return -1;
+		}
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
@@ -5414,6 +5422,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			server->bigbuf = buf = next_buffer;
 		else
 			server->smallbuf = buf = next_buffer;
+		next_buffer = NULL;
 		goto one_more;
 	} else if (ret != 0) {
 		/*
-- 
2.55.0

