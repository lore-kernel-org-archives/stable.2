Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8AC3C1090
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594475; cv=none; b=HsQ4YXXrZ6eGMTCidZh4jHsJYLq8zMnfVtSb9SLMkEmjHBBv5Q1ma2/5H+jmRR944C2St1mt1h5noCNfMTb3CApchDvPj0LQpN4g+BfPp/xKaB+uQecCB9IWomSKJnkwpJSDqBxICuOTq60FRcmsTTPquI5J6yQ/ddRk2vHkI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594475; c=relaxed/simple;
	bh=qqqqhAcoTazT3zDcG36T/OFmfZ0W7gsqaDYv/oilvnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB8+aNU/pBYByOBWE/OmTytZDkJixfhTgPVoemaV5OT/r++EbHChVy6NVUm2XzNeEAhMe2gJSxVUgvLpkBHsRjMBJHiCbJONN1FycgOvO+ZvsLhsM5N6AaPRlJHDlWNrox4UrpDEXqtTCZg6AT36aF9OcaiF4sQciKIaVvrx2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tn/aYxZy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lv9Wy7SH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn/aYxZy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lv9Wy7SH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789594456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDQ6J6doFiv43Hl1XC1fv6A2Y0AiG/CVhsbe9ThB2Cs=;
	b=Tn/aYxZySW9ZcuY4XqYGiT7Xjq3kTI7jBkfNMD4+S4Kf09YPVzdG+66cPi9XNjR6mLieUj
	DTaCnbA7vIlQCHRx0TgNyg0CDyHxp5LTPmFd6nIIRbx8R7EYJuqvnuMtkdpFuvD478LQfB
	FAltFEw1B+VFwgxDLDwszOi99trO92A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-qjZ0pNFtN3WOdcutSV3Uvw-1; Wed, 16 Sep 2026 17:34:14 -0400
X-MC-Unique: qjZ0pNFtN3WOdcutSV3Uvw-1
X-Mimecast-MFC-AGG-ID: qjZ0pNFtN3WOdcutSV3Uvw_1789594454
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52fc0097865so1862011cf.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789594454; x=1790199254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jDQ6J6doFiv43Hl1XC1fv6A2Y0AiG/CVhsbe9ThB2Cs=;
        b=lv9Wy7SHZYWBr6XOH5gDlLsvIxVDC9a7lbqsN1/8ryBzfarUrbRJXTeaaiOoI0851S
         5FUUjqLAZxK9ISNOtrz0WZuIiIbSae5eNvW47kAhmmCJ/uvN/sxttgWjiCNTMoGznYnm
         7vALCFwzD7iFLQYyWpf2X1/7/8PlrP5P5E+KbJw7N86pCQGJ+z+tb/2YULQ6cA3c7mno
         XF6PeZKyyiIoyN6Vcl7e13NuEWdwdVPYfRSygx2MsTYVmBt1cPC7vwl++ZND8f6wp1m7
         /KBMyzwLgSnhNd6fCZk493JCWrYqajQynzNv+JPJWZCbwxB0jJxrWbOuEofL/irwA5Mj
         T5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594454; x=1790199254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jDQ6J6doFiv43Hl1XC1fv6A2Y0AiG/CVhsbe9ThB2Cs=;
        b=EpeMN0pO0uJCWvuKL5caf6DndFpql0r0z/2KG2xjn2Aq57UZ/4F4e0r84lLLXS8sNY
         SVwnR4TZmhtMOAuhkiJh56R00vTxsJD5Rliaqxtao+qdeMmbu/+gwFPFqkdBQRaiQClL
         LSoRovWS2vGr3l5odJol5kEEVLIDHKCL/ELd14MhqHOZWc3rj1kM0Rqsdh2U9pFnV722
         uEuJpX4HvJyGAB+MJ6awETuQVEbtJr2RgjzTfp9iQTydOdTJdM2HBoJyq1mBd/ih0Psc
         JUk/zxSPiGrED7lpEPS6bWopHYCmKPmd364X0QpeB98EXo8pGC3kiBGXJZ952MdK5dyQ
         kniw==
X-Forwarded-Encrypted: i=1; AKwUvBzoBFnYIY/kWqzA157mdKHShxDkp8Zh/8/NFAhDqLjzbdBPUcPclp83x5xbL3SUtYn4a/zjAOk=@vger.kernel.org
X-Gm-Message-State: AFuF++m0SRuDYs29h31mLB9/q2d6X0Lc4obCagljLtpILNPyDUZLkU/F
	4UUQzziPwws8CMbPixALddZq5vdub+cSPvdrEGzU96AEGHzK9M6SQw6HQirXcGdofrt9rCM0IL1
	zxTfUIzf8HN4Xh0lK4UWsepbwySeb90zmLaRH71lKnnzOccGITZoHUVWYJA==
X-Gm-Gg: AYBFou2NHFryT6AWneFXWybsU+hfvfBENAbYVX8UUw3eM5EXqnptFfmcKeKNEqqh16a
	LtNjnVUZNW0DC8z1ZgCcy2WdheG2+LNAy7pb8YgQhpgA2/S4D6ee4iIGQJPTpMnJ0IkE1OE6tj8
	YV66xm3QQnjsUbPvHzQPLCLxJJHo2UNNbAPbW67knAWWgDu8II5E+MnrM79X6mJJvdHnr8BkRS8
	EJ9dRqpi77vgbXPPa8LBFdkoOk8ECKpVPs17pqWL53IIw9/sv2pcx5GMbVW3/DqGnHZiOyq7pSr
	7/Gmzsjhw61MhVlfosw5Xal/oXL5JKqPDsm4M0dh9xt8V82hCa/aaQAKGCiU5jNsNemdUNhkGZT
	Tt2pc4J8TDewREgSIUQHuUd7F+RdTjD2HSYDKO1ZTOT8TwrcjFnN/5f4gmPllirQ0QA==
X-Received: by 2002:ac8:7f04:0:b0:530:d1d6:792d with SMTP id d75a77b69052e-5327f232ea6mr71105981cf.15.1789594454033;
        Wed, 16 Sep 2026 14:34:14 -0700 (PDT)
X-Received: by 2002:ac8:7f04:0:b0:530:d1d6:792d with SMTP id d75a77b69052e-5327f232ea6mr71105551cf.15.1789594453652;
        Wed, 16 Sep 2026 14:34:13 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620d4cbbsm32447431cf.28.2026.09.16.14.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:34:12 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v5 3/9] smb: client: fix server->total_read for compound encrypted PDUs
Date: Wed, 16 Sep 2026 16:33:54 -0500
Message-ID: <20260916213406.1496960-4-sorenson@redhat.com>
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

In receive_encrypted_standard(), server->total_read is left at the
full decrypted frame size when walking sub-PDUs of a compound encrypted
frame. As a result, cifs_handle_standard() passes this full size
to smb2_check_message(), causing the PDU length guards to incorrectly
validate the entire compound frame instead of the current sub-PDU.

This allows truncated non-last sub-PDUs to bypass length validation,
leading to out-of-bounds reads in smb2_get_data_area_len().

Fix this by setting server->total_read to the true length of the
current sub-PDU: next_cmd for non-last sub-PDUs, and the remaining
pdu_length for the last one.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index fcf7033889c7..7f2177f6fc01 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5371,6 +5371,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+	server->total_read = next_cmd ? next_cmd : pdu_length;
 
 	if (*num_mids >= MAX_COMPOUND) {
 		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-- 
2.55.0

