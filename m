Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225333FE0A
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789247078; cv=none; b=NdbLvb70phrSjMlYM0cxJtsKH85cUYt4jPwPmz0g4TlcoImDgkRa/yYtJpc5WtNSo+mwiuSdcekW1pbOBgMezti2xshv41EIgvzkcUzp9d4W/31hMtHW4b6/xMoORoxPLGX/USQvmW0ZL7Ho/yM0ouCq1sUxxPgTKhZodtDfuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789247078; c=relaxed/simple;
	bh=r3W2+k7wr+2GxTIrKbn6q7pIjadoIxXaIEWcl+FclBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+4cY1XWuUejTPGS52p4GvigvKJN3mjgybTKBfQ3ZDOOqnQyFGT9+XF/2X+ZKsKLvjAuPmRN835AS/gC3Lf0q0EKN1faqSTFmcZsCmzfh1zYONvmQwHFwn7jBPxZTde3mhX+7iSs8xAaVo7kdWMX79SApM1HDAn1PdILs5vkjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urj+bpnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urj+bpnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98551F00899;
	Sat, 12 Sep 2026 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789247077;
	bh=Hi2mKdDSl2qs4npPMOoZehTW6A36TEPWSJfJTPcuj+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Urj+bpnnGdXduupA0T9vWkrF0NQtNM54mAGuZsrqJm47wR8d6jIWrBcPtbhnwGtpA
	 yswbCFpBX+LA6N624dajVeOKNt2jQVZYa0zYxxHTqYV3yEBrW7iNWLgULFn4WVfzct
	 WfJm2JbIBXk43BiyxmnQCpT8oaAo3ln7VF0J2znG2jRcP7164M79hrSl232tAOJlPV
	 WQuB0lxBQmcdtC9ToFJcBRldKlcovRNH9fxWcCQU7/6VgqmCG2zbrRlQjZ1hDVIf22
	 vV60+SiuZTUSTbAJLfSlHRMRGdCH0zIn7IE9w3BhI2KadmbWD+rMROMVXYmLfEVnqy
	 mQ1qWgfxZouhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Cheryl Babcock <cheryl@renat.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ksmbd: zero pipe read compound padding
Date: Sat, 12 Sep 2026 17:04:34 -0400
Message-ID: <20260912210434.3939319-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912210434.3939319-1-sashal@kernel.org>
References: <2026091125-profusely-shortcut-0dad@gregkh>
 <20260912210434.3939319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 73f860489e3be2245598d1819226304fc5b87291 ]

Compound response handling extends the last response iov to an eight-byte
boundary.

smb2_read_pipe() allocates only the payload size, so the alignment padding
can expose up to seven bytes of uninitialized kernel heap memory.

Allocate the aligned size and clear the unused tail before pinning the
response buffer.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: Cheryl Babcock <cheryl@renat.io>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d0beae673222e..cdace3c370f6c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6234,13 +6234,18 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, KSMBD_DEFAULT_GFP);
+			kvmalloc(ALIGN(rpc_resp->payload_sz, 8),
+				 KSMBD_DEFAULT_GFP);
 		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
 		}
 
 		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
+		if (rpc_resp->payload_sz & 7)
+			memset(aux_payload_buf + rpc_resp->payload_sz, 0,
+			       ALIGN(rpc_resp->payload_sz, 8) -
+			       rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
-- 
2.53.0

