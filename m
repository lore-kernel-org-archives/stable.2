Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159B549371
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112234; cv=none; b=oE6B6v3QEVLiadPuOYW/s1C1CWfjOjWqF+6RLSJd/huCCfrR5yDR6oR3hCvjuzRkcsVYaLP8aU6kj/pumeJSkQSo5AyzQjuwFigi/tS/sTA35ja/kLxJji+bIk/Zjeo6BKI1U780oXNw1++v9tRqCUCZn1j8gYDSn7rGTMYSLeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112234; c=relaxed/simple;
	bh=4eKRTrgjnzvzoSbrimFenM6LlUSreSL5YjFZgCC/SO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGGWX9qAAVUBpyFGVStWFTJ0afiIzabDrv6IEPxNFpMFqBLTVmYnxNYPcYaGTYUPnfMj9Ce07j2MTlSlVqVfEMUgv3XFepn/aHC6FljXtMbD/wjKhvtdi22kBIlwHJSyH9HcynsskUhN2SUYKNisUS95cit5/Spfcm4RO55KYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkqAN57E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkqAN57E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2711F00899;
	Tue, 22 Sep 2026 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112220;
	bh=Um/fZTHFRFGqfRYccwrIZz16akyiLOT7ozcno8muGUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NkqAN57EELZNdgvRPI5Q2zNgVj4gJRw9HbZglKNJiZe/pm4SOX1WevEUr0OvSwxas
	 yaX3qg2+zfh+paqVSQabbNsH8tIRN0z94N3ul56AH6F4kb492SN/Ni3IwZpAqVtj5/
	 Q1tthJSKESLKCVs8yYfbjpOi1AoLb4uHs8NmUFBt34SNGCHqIBj/QZvjot8qMfytAi
	 KjBeZaNEY8igw8Fsq4Cutke4wdzw64t310zYu4jyPWpTxavCNpuYj/NP66f0MGcejA
	 QkPbMsQmUUHROhndRupQd9Vjq9qqISNJik9sDpyrE3EffCkJAU+nLyqH32UUvnKoNA
	 5f8E7UJGr7YlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix server->total_read for compound encrypted PDUs
Date: Tue, 22 Sep 2026 17:23:37 -0400
Message-ID: <20260922212337.754682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092213-aflutter-survive-4ebf@gregkh>
References: <2026092213-aflutter-survive-4ebf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit f73726b83e4756fdaa099e1bc1143293bd57ad79 ]

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
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8ba..ddf864851eb5a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5227,6 +5227,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+	server->total_read = next_cmd ? next_cmd : pdu_length;
 
 	if (*num_mids >= MAX_COMPOUND) {
 		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-- 
2.53.0

