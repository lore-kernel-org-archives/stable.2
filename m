Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697247;
	b=KOj34vHFA/5W4RqEYsHaC/UJwK3yBZGOeqYuWlq+EdUBFKNtro+ja1zkWRT2pIVxrvYn
	 d34+0XAgcuIr+UyizbDtMaC7zzNuuj/f1hgex/HiCjAJz2wZt/PKVmsR9aVQhL8+dBQz8
	 4M1Xk4rYvOz+c+QGB6+6z43jke5W9l/wS2z7Nw+YMUbTqxXmIVQfLaCAfpkcxDtNBUWTO
	 sz0PT0+OQNATeZCXBDRsumy+mwB8m4boxvjg36wJugo0JFYkM7Vfe6tas1xBBeaTxIWOj
	 fFtZf7h/56zRX6CNCZyKac9EoVojjiZHrNLUQ6ZSNwlyi0ucMIXgX7r4aSrMW48ELow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=taqeEkoChLKRVLeCCZ2XrmdjaiB0Z7JNn5IEBfomN9A=;
	b=T9Phzp9qHG6ieQrQAG1/EBDraeh2y9ehVWrhZyPQgNMPYp9L1+pQejs/PBNMtPaVi8hB
	 EtXW9K5lYUt2w6lit436Mp5lxqsxLMCFReh5kzxwOWAsnOVdLwSqGuL933NJUW1xcJGGZ
	 gU1c1wBnGk5IHrAyZt8X+KDHRABn1jB0gh6irLb1Q4Wl4gShSZOmHDBSFBZZs+3IgsheF
	 hd8omt9m6DrkY06fFcJX8aK25DiCBazEAcjaTSdx6lKlwrzc1wmNRVVA6Aicaw/Gmfr+h
	 Jte/UYvlv3XF1wCRzMy2uU4zCLuHuf7woqf3o3Zx/45AFGlROJXBcwmOs/5AjcDt+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/XNaOzT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FB606A327
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/XNaOzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CB61F031E2;
	Thu, 22 Oct 2026 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792697246;
	bh=taqeEkoChLKRVLeCCZ2XrmdjaiB0Z7JNn5IEBfomN9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/XNaOzTpnwkPcn5AA+1VQO9lpQs1yWBfpZx2cHPLw7lxHi9y9ToLBIALfoIVdT5i
	 5qY7T2g19xQEZ85+PaMFjdr66eqVUaZyt4nhLlfqIXCQjc1UZon+ER+IAUuDCaF2q3
	 PgiYbA2eRIk/XMbWnjjJk53oobrIy6xhdKvDrIBGXvAKbIoSCOPCzZixtuBkCsP6dY
	 x3Wo+bfwEw3bKXf1N5ie5i7o9PYixRUkt+Ir+XBBfiva4lVUnwqfH1niebRZk4zG0p
	 BbOL/dxthxe0ibDf1I7Tzkklw6gMH0F4yR4hjJfLX5WGCvN1HZ+HJ+5M1Wz5RyM9jK
	 qsBOnicx+E6Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aleksandr Khromov <haa@amicon.ru>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION
Date: Thu, 22 Oct 2026 15:27:24 -0400
Message-ID: <20261022192707.1982621-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102245-boned-daylong-f86a@gregkh>
References: <2026102245-boned-daylong-f86a@gregkh>
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

[ Upstream commit db2267b27c054a6c2151ff7fbb67927e784f31d6 ]

smb2_get_info_filesystem() reports 56 bytes for FS_POSIX_INFORMATION,
that is the whole of FILE_SYSTEM_POSIX_INFO, but never assigns
FileSysIdentifier.  Those eight bytes go to the client as they are found
in the response buffer.

The buffer is zeroed on allocation, so a standalone request leaks
nothing.  A compound request can leak: the offset of the next response
is advanced by the length pinned for the previous one, so a reply that
was written into the buffer and then dropped in favour of the short
error response of smb2_set_err_rsp() stays there, and the next reply is
laid over it with only the header cleared.

Report the file system id statfs() returned, which is what the field is
for.  FileSysIdentifier is __le64 and f_fsid is a pair of ints, so
assemble the value first, val[0] as the low half, and convert it on the
way out.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index de03750a2b0c9..27653cef96c85 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5268,6 +5268,9 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 			info->UserBlocksAvail = cpu_to_le64(stfs.f_bavail);
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
+			info->FileSysIdentifier =
+				cpu_to_le64((u64)(u32)stfs.f_fsid.val[1] << 32 |
+					    (u32)stfs.f_fsid.val[0]);
 			rsp->OutputBufferLength = cpu_to_le32(56);
 		}
 		break;
-- 
2.53.0

