Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1048CD40
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594467; cv=none; b=SythSbdYgm+6SZm28vpiOHV2XKXQdqesbMOW6V0VlmBGuRPXliQ97w/N8aQOrcg9KcRGSliXBznOjajUKgnylU7SlbTNRlQ77gYqXlsd375Np8vlzhV4Hg5hwIxq/xpAZBgNzZ042in4x/VJr083BAebAuPxb3IBosczSouMOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594467; c=relaxed/simple;
	bh=wk6vygH8NJfDOcKXAaJfgbMl5gGSxrJpO6cdJSZ6zZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf1UNmIrrwuhILpI1zWlBwaR+9RQ11/EDHhQALKrwSq+zhkoBRUHw4hn+d+T4zkO4tvOnSlXZbo0jz2BO+raZC+SebUzMg6sHdxdZmMWGawcX25ysl4MuUHQ3a2xAj0IK+At/Gq7apiYgxsq63nV+h1fPb8GyIkSp2RbF3jMxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuFW4RmL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmQaRpBv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuFW4RmL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmQaRpBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9V0qAlXWmLruJLZFHIdq+0l21ICiVDZYVMxBS+fFubs=;
	b=IuFW4RmL0RS4awu+8sG1cnFkZUzBrmnbHG/15wxs19qPNfvWxEamKWElFvpFxHkKGjsbA1
	6vyRQ+HasgYnsHOInYOi5XULtUcIDPrGYZs5eQpdrmo9F4RTc3OWATwqXr+a1VwAwF4Wd0
	0CCWE/juTs9ohw8LlxQtiWdM/EAfrhE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-p02hmJiiP9C-kvoIgiWlIg-1; Wed, 16 Sep 2026 17:34:11 -0400
X-MC-Unique: p02hmJiiP9C-kvoIgiWlIg-1
X-Mimecast-MFC-AGG-ID: p02hmJiiP9C-kvoIgiWlIg_1789594451
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53000c06184so3700251cf.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594451; x=1790199251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9V0qAlXWmLruJLZFHIdq+0l21ICiVDZYVMxBS+fFubs=;
        b=hmQaRpBvj3r2+m8F+KVoHfJAfVaDCbzFQB1YrnZXcsGI2uE/15rOq3rafwIUaDA7E/
         eIDQtHf1O5cGXrWrLFHXiLzaiEb1Rz/LI5BB/y6PGBwfiyGOm6xBkEGuw2Phpimwi+ck
         WsOCgWmi7eObEhMgHwOgSCMlKm6ga1Gr4AFW9DpfhgltmTcglJvutLAKCKw+tA8iY3k/
         OLVjIpnMfzFEXApHSjo3LiN4p9Fk7gNBVv32/2SdWWY2FcyeSFjHJLoMl5LDa03980dz
         b99M2DSPDoCwxdKA72RzFbv8oMVrCpn15L8u+gooKqiNl8LmweU8mt/SVWP1gtBuSv4z
         soAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594451; x=1790199251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9V0qAlXWmLruJLZFHIdq+0l21ICiVDZYVMxBS+fFubs=;
        b=0IRrO7hgBS+B7Pw01gVpbXuEiXNCbZr7gAmNNXTwj0IBR4pKVJoR8nL8gYrvPH00IT
         CHtTqmAiYJuEVdt2FAE8X1rnh5ZDQxBQuj9NdezgsoddXsyrvAsMuSJJlyPM1CkxJKk6
         CG/6ICgFk0+olLPnXgv6H3I8AmMbOJ3Uj4U1VWQn1D0oZ2ogCqOT3Vtg0VOrTkcfYhwn
         9kX5XbIwWKruviV9He3DwFMcOjkLXLtw0RI4wbqiAwLME0MsfFYKsN6099cULsYUIjqY
         rQkuYk2mRGq07A1BS0JPMNX12MxTtSdCuv27Gv1Z6ODj3pNwH9lKF3XzhcYzu3MvJwz0
         DG+w==
X-Forwarded-Encrypted: i=1; AKwUvBytacJuSbAd3k1Dj1Kf9LUi71EF/0ZddMJPXPiztzozF4N+T7uHMsz7G6bHLGhjAMT/+z84Dls=@vger.kernel.org
X-Gm-Message-State: AFuF++kcUAavazGOtLM6wSYsDKRNpZ7bdnSgc3sbE/yWRbzEtBgylb0C
	Cp0SRIr0FEwxwKFhUs4ka+YGEZBO2/TPySh1u0gtAh4AL3zxYNfPHFZS0KpmAxEnIekABfV8vOV
	OjRDQGgUjh+qaaBDZTimwIGWZ2PjxeMztEmpqthgVLDZgLPSE5SC7XTkkbQ==
X-Gm-Gg: AYBFou0frvEaBKdrIr437G9e8LAeJ9DX7bvqDhw6vGI9CQbhzEVcaCIfYEt21NtUgXQ
	WYtWqytCcuELfurdJonL9SZxZFzz77Sdg5sbynECJGlK+skZXfS2mZcqvz9rR4AyUMphXXvgrJU
	c4/QH3f0bW6CWlH/Ptpm65+urJf9AY9O4ypxpNOKdj+NcC2byQagZ7itOuesYy/1ptzNBlM/dNU
	hCLRJJTxRHkuxavpgTDWYP2UjCYAecxhn3LEGCKNi1hxNHTeqZ8noHr7G7PLuaXGFLLU2c7RAdf
	uEvvbdwGJ7xmSYrkgB36oix/6CAFYHuEjGkrCdqweAEly0pIYdSCGJqS5JylbvHhnArGgJ08kKA
	hthDSSMsVqy9iWnErAViJPdE5HA3KO89sDxWHXMXJwJUSwIdpQRj/pCHv28yY/iwXVw==
X-Received: by 2002:ac8:5a11:0:b0:531:17a2:4e4a with SMTP id d75a77b69052e-5327eedc606mr72964261cf.47.1789594451055;
        Wed, 16 Sep 2026 14:34:11 -0700 (PDT)
X-Received: by 2002:ac8:5a11:0:b0:531:17a2:4e4a with SMTP id d75a77b69052e-5327eedc606mr72963851cf.47.1789594450635;
        Wed, 16 Sep 2026 14:34:10 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:09 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 1/9] smb: client: fix next_buffer UAF and NextCommand bounds in compound PDUs
Date: Wed, 16 Sep 2026 16:33:52 -0500
Message-ID: <20260916213406.1496960-2-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213406.1496960-1-sorenson@redhat.com>
References: <20260916213406.1496960-1-sorenson@redhat.com>
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

