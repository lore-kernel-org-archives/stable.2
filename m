Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65035E549
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335929; cv=none; b=CnzUKGUSzBZU+SWRM/XAvYwXLbwaIPvIDdeCbRWLKsqHp97lfCWCCstVpjVFNqqZL3dVjvT6ctkBj0tgwXreTHQEpnCRkWQkX/aVLhJozoMDaHL9/L9eVRdXzymWBy70De+O9qk8iKc/Xb0Mrt63v+lE39volzHLs1o9qBhh2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335929; c=relaxed/simple;
	bh=OFmUR5n12qboMmyBDS8aJ5gQxbHGee425Wkk4EjiRoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwa9w9q8+uD4XhgLZUL98I99Y0VzS7azrFI5yrbC0hL7Eswle5cGo0zYmywAnk6MQ1dsfPKaOrFXTuuz/yt+aT8/9MG1N4flQk2gWKxVVScGvFsgtZVfUhteN7KcfwE4PrplbrXJLvP87RLVuX2qprEFUQfkrJoegG1fHujUCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckPba9Sx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxV+27v/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckPba9Sx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxV+27v/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OnhzbABUYbzzJKN8af0lhPKwu8S8OBp+evSnROGSRk=;
	b=ckPba9SxhcDfQRSDRKDWEQDj3N8shekZD646UX+pQN+IuoY6Gte0sEUoOZHpJA6MvsrFpQ
	6P9+UALUtQ8EgESlaX/9nkGxpDSLWWRO8Yqhd4rjf3DLW/loF1l8XhKFytn4atsI5Xm3vv
	+V4R5Ll9VB5/llNMFGGU9MkbyQqbx4E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Gy9vz77WM6eRsDLqdjaOcA-1; Sun, 13 Sep 2026 17:45:24 -0400
X-MC-Unique: Gy9vz77WM6eRsDLqdjaOcA-1
X-Mimecast-MFC-AGG-ID: Gy9vz77WM6eRsDLqdjaOcA_1789335924
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91055aae7f4so68548996d6.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335924; x=1789940724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OnhzbABUYbzzJKN8af0lhPKwu8S8OBp+evSnROGSRk=;
        b=MxV+27v/EUnswzVAZG903qygAgW93OpvmlGD6zJP1uXjXa9vsernjQOi8nt6zzTRoe
         9wyKQHwyGA1bio0yF5RLx2jmSIJTe+EGoY6gfr7Ypl8+EDCr/om8SQ91ZFL6zO91cakV
         oy8lrTe0XGP4AimqJIA4z8S7ga0gEhmda/gI6YPj7EsWjRvF34wFDWMUqkX7lqPFD9C2
         gi+PwvD2ypVWnNDIs1+Ii6Ih2rrvYqbAMLqUW92zV2T+4cCmmh6CduOBsrRLpnWIX+CP
         38ptcPSyB0sIQDX+3b9KoGBXmlGCrcEH/Yd5KrYkIiobnpoBaUDoLB4OSI1drF81O5vb
         shnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335924; x=1789940724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OnhzbABUYbzzJKN8af0lhPKwu8S8OBp+evSnROGSRk=;
        b=Wv25kXFZI3j3rnmPWuovqjggsDvrfd5HczMnwT4NAKJ2XT6nBTXIiH7orrIGQ0yXfp
         m5WuYwJM2O+3dIxyirWr7R4v45iOR5zpR3vy3GsSoE7GhMSC5u+OiloTRMjL2Y+2sk05
         mr58aBb6eVXCxv5Mcrg0RWiWRo1Q5at4BtgwLZSfKWHmpmQHnnY+wUftUochWe55b2N0
         FB7AUBQivODgBkXrDs3cR0WPBXjJMDJW3D8MaDqd4otyLKMMftl2SN2KefOKgeu4f4dD
         VppeMdVdoScTp06Ch9fMfz36phx1xmtirZJausLSg0hCMKkdawh0AmcspAU8IJKX72sL
         DJqA==
X-Forwarded-Encrypted: i=1; AKwUvBw/olykE3HW9wxECtIBbZtxkDWdVKX42lhxYa9TpNvNKD4V5R204GlhAosDhhUwMNZZcP5hM98=@vger.kernel.org
X-Gm-Message-State: AFuF++kesexv4szRbr0dZCqX1qmGyjyxBU0EIjtJM2Z7HDVe4V7qOuV5
	9dhA7bpDLMTF8AXvFPLe6lxh7NUNpQsFkWEc+IxN5XT5otkxoq9vQ8OOnpnIORKo1nYnxxKi8dF
	/YdsYw5kjBgesyQqqdC5OTwJIWE5AAtyfa5VdVjZG/RWQVqtOzNtiaOkvtA==
X-Gm-Gg: AYBFou0og4GRsXAdKuhx0QmEDukA4h0ntGEla9rcvMo3ZKQ+h6gciya/t0anM7XpWH/
	+ePEMQ69hZTzuuIQHn68mKFYGSc5zQgQKKQoX86f44ybuf6AX8s1OLgsUF7FnIFvrj3AOsoQQnL
	NoHZRvS8FHV6GPZY03DPxrtSwk0e3tMSYHY5k4ykrvvozAZbi6/Gfq6IBAYnXuPF6J2i/+/4MVt
	8VK0rWny4s8mnWB3lKrhnW1N3sYie0YTiZQF7WFQfS38ByAuXbucIAdcS2U6CEgvYmwhDNaOzXd
	L8V6Z9nGXlhFeMlMeSpDK20pSjaZ0LwmD2ivIri45LGz6OBN+UjyabEGKsn7cXl1TTiioePguKP
	TQz+SbogMIEHqxo2hirOK0ndlXNJSSoCVbDYaxyRhfIy9kmI3ORql/FWDTUY+SKy/Cw==
X-Received: by 2002:a05:622a:281:b0:52e:125b:9444 with SMTP id d75a77b69052e-530fb4983f7mr43674791cf.17.1789335924057;
        Sun, 13 Sep 2026 14:45:24 -0700 (PDT)
X-Received: by 2002:a05:622a:281:b0:52e:125b:9444 with SMTP id d75a77b69052e-530fb4983f7mr43674601cf.17.1789335923622;
        Sun, 13 Sep 2026 14:45:23 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:22 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 05/10] smb: client: reject short Next offsets in parse_server_interfaces()
Date: Sun, 13 Sep 2026 16:45:03 -0500
Message-ID: <20260913214510.3071370-6-sorenson@redhat.com>
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

In parse_server_interfaces(), the server-supplied Next offset is
validated against bytes_left, but not against the size of the interface
structure itself.

A small, non-zero Next value can pass the bounds check but advance the
pointer by less than sizeof(*p). This causes the next iteration of the
loop to read misaligned, overlapping structure fields.

Fix this by ensuring the Next offset is at least sizeof(*p).

Fixes: 7d34ec36abb8 ("smb3: fix for slab out of bounds on mount to ksmbd")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7f2177f6fc01..bda940cb3784 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -785,9 +785,9 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			break;
 		}
 		/* Validate that Next doesn't point beyond the buffer */
-		if (next > bytes_left) {
-			cifs_dbg(VFS, "%s: invalid Next pointer %zu > %zd\n",
-				 __func__, next, bytes_left);
+		if (next < sizeof(*p) || next > bytes_left) {
+			cifs_dbg(VFS, "%s: invalid Next pointer %zu out of range [%zu, %zd]\n",
+				 __func__, next, sizeof(*p), bytes_left);
 			rc = -EINVAL;
 			goto out;
 		}
-- 
2.55.0

