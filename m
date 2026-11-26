Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668450;
	b=nTdwFxGDIwWGg8KaZ6AlLn5e9jpRfcKQDM099KIT/KPff1qaLKfYafKIz77g3/OHufEE
	 c68GqwxdTjdn8HUuROv2jJFCKWKji3gwZ1jFMVQ6bkAS3ws4NEQAh/83KNmCJ5E8ObKUy
	 MA2t3RjlrYHaXR7Tfh9mJBDQ8q2/5LVDM3cUs5lQQievoJlBWeeTsgqbZ8ydurvqCZ23a
	 Bypz8Lm5waCYk7fDVwOhYd4arUlCc8HDASjrXzlVcBbQjRo99CfeWt2zVmn5yYdIdLISk
	 mmfQyj2U+KiEYEaAghk82g3WJexcfVev/HNK/qtPTx2GsV/G5UYMtR0WtMRTS/myp2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mw+Xvche89l5zuWmQXrMJQo6nOfDgyLIJFp/vCeFCog=;
	b=3uBZL5KQN5xbpPFXDkaa3I879Bgrqq/waekZBwiMWOAm2kyNN0YcDpUYbHHo++EMq3p4
	 UPWNoHUBGf0G7m54Y9cWJr32sRZjH8LIA1e9bFoouzf+tBBHC2+YAaVPeH6A9lkp2RISO
	 IMDkWuHZ13Vv98pySRln3wnBNtbKl2TsEsF1/GABPgdPMf3UVAv+oagyg4L8WeUvINIse
	 9o4M1uCqp6PBhOqwxT5O7WbnxbxCmHosBmNcmwfyg08ascWinRDtcGZZJpN2y12MngsmT
	 tA2P7RxH2xx/bOrOLU6PkP7uEIguL1pkjkpJhl3qI60Cr8hRThG0Z8/Py6Dyy5qUXGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVoXBh0L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7962606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVoXBh0L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7469C1F000C4;
	Thu, 26 Nov 2026 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668449;
	bh=mw+Xvche89l5zuWmQXrMJQo6nOfDgyLIJFp/vCeFCog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVoXBh0LhUH+8iZUogRx0nIjFx7bjEZczVOGJzgy50UN5nNxT6S8aildPHyUYvmeU
	 uPKplBUPw9rFq4UOHsisElfnQjq4nY6U+0T52MVv3qWmomJOv4YWPq2OgFPFQ8O+Kn
	 GVULqINLf75jW19ljApNEnddDGky8vfNE4FZHltYDLfu25Wyc+TxEqvR1Z1XZlp0hW
	 UX9yyxanHmoxNwdZmIy9hGZmw4G4bxEPkAkHWe0LosGRsSEqxrBYqO3mYbU1b3I5eq
	 4K2ptja6rGSrGUocCUkcDS/hEQGM0Fl4FuZ/NuOfMKm0rF/EFpAtqTGw6XGwNeTnPF
	 w/C5PCoEbfYCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/4] smb: client: remove commented-out cancel_*_requests() calls
Date: Wed, 25 Nov 2026 23:47:23 -0500
Message-ID: <20261126044614.1999811-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-creasing-upcountry-1465@gregkh>
References: <2026112543-creasing-upcountry-1465@gregkh>
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

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit a40b17cc9ecaaa85c3615963ec21cfed1c734340 ]

Drop these leftover commented-out calls.

Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Stable-dep-of: f8ea398448ce ("smb: client: let umount -f stop waiting for reconnects on hard mounts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 5a22796f2e957..5518a62549806 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -869,8 +869,6 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
-	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
 		cifs_dbg(FYI, "wake up tasks now - umount begin not complete\n");
 		wake_up_all(&tcon->ses->server->request_q);
-- 
2.53.0

