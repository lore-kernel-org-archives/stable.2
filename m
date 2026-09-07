Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF8438470
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823222; cv=none; b=RUUjRkV1xvrtrCIysO0/BnMwcTYVrxuDmYS+UPRq6xg7p+arl5dwGfAb1Mp9bWd4AmlSwFWCuYWUTwOeseuqRE3MP1eVMCslp1mM8XxzCKmhIYsddNIjIZMtuUaVFH0F/v8T5oHc73Em2Ev1MDytjODCMPhEY6634caw2YKpn2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823222; c=relaxed/simple;
	bh=7EMtxVlPrX654ufoXgnts2QXwVFMX9zEEn0ObtNKHfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngv6l2ZAsR+orSRdYdG+oUDtKjCxjXPgYTrRgG9KxC13CIGMvTe7fUZIb3P7MGarCbG/LBVO1dpL0OwUjy12JvuESrUDSfUZPvEVP+6NwVpSseterKP668ReI3khYKk21bZ1Rr30sshEmU+zRfj8miJqs3rzcZsFgdW5JBWMUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VykIeT8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VykIeT8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8231F00A3F;
	Mon,  7 Sep 2026 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788823221;
	bh=hcgA9Rak2iwJchehA6ivGafJs3vDD/b5Sp9HhOnnzlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VykIeT8L8pa6BmwEp4wHDJYQrxEndABWLVh2TEfOJv3GNj4K+CDeil3u1ti2d3jRK
	 8rZk9OIL43zGPZ2kpZCFhtnnHOOtq5FHYhvGHoGPVPOz132K32s+6RLzAUcOc9EpZ7
	 o7VMLe/N7C+/qbn6CLX++Qd+SMdxJ5z0bwgZqDo/q++Tg6+yimhLTUSPqbASViYzkQ
	 b5slEU26nSKOWT0gRE/NivTa5H5nL5d+9+dKzxhCFG6rh2GXHkJ7KK62Ksqc76YJz2
	 r8cnKm5epzNhqdAByrj3nznaEtUXun6OwvuqfPDIsTx3ESgwAy0UT7UgnoM38vBvPb
	 43lsyxfM7TaQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] smb: client: reject a tree connect response whose byte count is too small
Date: Mon,  7 Sep 2026 19:20:16 -0400
Message-ID: <20260907232016.765564-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907232016.765564-1-sashal@kernel.org>
References: <2026090336-expend-runaround-0e93@gregkh>
 <20260907232016.765564-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 65deb18359341141d37dc86fc7853511be3c87a7 ]

CIFSTCon() bounds its strnlen() over the byte area with the server's
ByteCount minus two, which for ByteCount 0 or 1 goes negative as an int
and converts to a huge size_t.  The later subtraction wraps the __u16
bytes_left, and that is what bounds cifs_strndup_from_utf16(): a bound of
up to 65535 against a ~16 KB cifs_req_poolp object runs off the end of the
slab object, and the bytes reach userspace through tcon->nativeFileSystem
in /proc/fs/cifs/DebugData.

Reject a byte area too small for what the parser consumes.  Two bytes is
the least it can consume, and no conformant response carries fewer.  The
new trace point is the 129th smb_eio_trace entry, which __mode(byte)
cannot represent, so the attribute goes with it.

Fixes: cc20c031bb06 ("cifs: convert CIFSTCon to use new unicode helper functions")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ replaced unavailable smb_EIO2() trace helper with -EIO ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f0a7dd1656910..b817ecfd18967 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -578,6 +578,10 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 		tcon->tid = smb_buffer_response->Tid;
 		bcc_ptr = pByteArea(smb_buffer_response);
 		bytes_left = get_bcc(smb_buffer_response);
+		if (bytes_left < 2) {
+			rc = -EIO;
+			goto out;
+		}
 		length = strnlen(bcc_ptr, bytes_left - 2);
 		if (smb_buffer->Flags2 & SMBFLG2_UNICODE)
 			is_unicode = true;
@@ -633,6 +637,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 			reset_cifs_unix_caps(xid, tcon, NULL, NULL);
 		}
 	}
+out:
 	cifs_buf_release(smb_buffer);
 	return rc;
 }
-- 
2.53.0

