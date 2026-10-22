Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697006;
	b=gH2H/S9JZfZcec9Kjy7l8xyP0NfYc9TILUlhCbAY0CQhLcZB/9xuTCBYsF0f0yrsn9CO
	 C1GZtE5hFRO+dkpbZrMs+cGl60P1ztfZ+B0QPOYcvO6l2BMLPQul3za7tBpQUhuBezIZf
	 GbI5msz/1aWzciCGzvdhLb8Jkm2ajL7fO/+KzyJRsLgpwIR/Mmz4Ucjdj1jLi0WlMFZ/4
	 7KJOHhMLx/g8F9dM3p1Iyz1WRGEJrkjxutrqO82fXPx7gjcA3/eGX7OH0sjAv3kIyftEM
	 AY7RMfz/FvYOp932iN142Ap5AVQcpKK5IOq9vOFv/g9JTmdSZvpItQfR9y7010O8VZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y/dsaxnKF3aeqTegstncGquAbZW8+HofhMVq8+s3R5M=;
	b=Etjtpn7OMZpBMwkYooJvw5E9s0EZDdzqAKdwUf3A5bdphrivumHUcyslemE4qbGbqGS4
	 Ey15cy2p+zJt8X8HHww2enAyrGJrfMbrBZxLtvtqEfuUaKPFbb0II6lSdSHngtVe4kRom
	 bFIxg0yzlRnZugVx9IpYWJ9k8Lq1K3GG0dMLUUVHrX2DX0YolaSZAHTAM0ckYWhdsiR/f
	 GXbfj9zhOdieD6sMe29vsztG43cRz1KtSqPVTAOG9ji6Zrx26E8MT3Kk46n01wCq8rDTj
	 ma/HdnwZgGM1Rrbn3TcX6jCm5714+uLlVW19i1NBZNBqUr0K8XCtIhURRD7hrqHJKxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZIIhS/CA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FE606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIIhS/CA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A991F01825;
	Thu, 22 Oct 2026 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792697005;
	bh=Y/dsaxnKF3aeqTegstncGquAbZW8+HofhMVq8+s3R5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZIIhS/CAuRiRmqPlsWFOYiUyD7fuOw/lU2ZHG3wiA76OYcF0UKRX46dCY60Pw1L/w
	 bxdBUF0JTy7b1D25xRasKlBHskhmrcHHDSL6k5HRxzTwesM1YdEXny8QcdwZ2u/EeZ
	 zco3bFMPxQ87nVyKY+lA6DTQLrcQ/x4n4R79p/Mo7OnrcMuciBiT4wTVbLGa2ll0k+
	 eawdgUokBh21j4ArVD4BFmwKQv1uAebnnksF0uQ5YT4Dkl3+akqny5UGjNoQjEKnWf
	 9cHqCrJf/jPiGNAYs5BtQ4ahBTN6A5qArQi45N72egtglsgeCX0UAMhSD/58rUvUnM
	 c/KXwt6c06cxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksandr Khromov <haa@amicon.ru>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: initialize FileSystemControlFlags in FS_CONTROL_INFORMATION
Date: Thu, 22 Oct 2026 15:23:23 -0400
Message-ID: <20261022192310.1962646-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102259-drizzle-twentieth-49c2@gregkh>
References: <2026102259-drizzle-twentieth-49c2@gregkh>
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

From: Aleksandr Khromov <haa@amicon.ru>

[ Upstream commit c0cd3fc6824122014da2b3b0cb7ddeaa2946ec8e ]

smb2_get_info_filesystem() reports 48 bytes for FS_CONTROL_INFORMATION,
that is the whole of struct smb2_fs_control_info, but never assigns
FileSystemControlFlags.  Those four bytes go to the client as they are
found in the response buffer.

The buffer is zeroed on allocation, so a standalone request leaks
nothing.  A compound request can leak: the offset of the next response
is advanced by the length pinned for the previous one, so a reply that
was written into the buffer and then dropped in favour of the short
error response of smb2_set_err_rsp() stays there, and the next reply is
laid over it with only the header cleared.

ksmbd does not implement quota tracking, so report no control flags.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index de03750a2b0c9..6e3acd0a5687a 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5247,6 +5247,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FreeSpaceStopFiltering = 0;
 		info->DefaultQuotaThreshold = cpu_to_le64(SMB2_NO_FID);
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
+		info->FileSystemControlFlags = 0;
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
 		break;
-- 
2.53.0

