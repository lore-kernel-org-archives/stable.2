Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA25187D3
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682706; cv=none; b=Rhevc3+Nddz/67hTVXWWCqnkNa8b3CnUqmaXht9Oi7j/OvjuVF5wy4Ad0Zi9pBjIaXBKkuJTtgNhDGdGfZ5V+Kz65Z8+5TqNMlNaNv/KkqeCHKPk7y0bvLHvArg2hsWobMFICaqA0OUC7m2b2ipqeo4nDAj373ZZqfu6jHHrhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682706; c=relaxed/simple;
	bh=B0fQAYRTTNANlV+0Zr4HBRZLVFE292i4YCrH7F/A+6g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p7wUj2eLulRnRs7ZNkbeLg9Oqr+Ro4lpI++mRieFSeCA10Q23+tOubx062wmA+BsMDfua8h0gbecRYvnbc3cPTUfw1IwBbvb422uvR68/Op99qxwpCaTa/AdLjZrMvOCgleuGK1b0g1JeSRPxVMlpA7nvqK7z/OGP64WEoAC+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luLUyLoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luLUyLoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB601F000FF;
	Tue, 29 Sep 2026 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682705;
	bh=waqV9e+fJYFthLDLjvfWSZmsT3FSNKJ4ynWPsaWEh9I=;
	h=Subject:To:Cc:From:Date;
	b=luLUyLoIy9WCB/569bI/tTIWFWye/6C+E5gyQljYnlL6+fDGrYA3RgCpPKpFeCHjO
	 liBC1dA1GBkWTW9wKtreaTDTrr1hbLL3A4gx43Vn+oHfLS1DvgiWeZ7cnlnCUgy1yO
	 flP3EX5v0Qx5qoEyOPSIvNvl74OMH5qPsLh9UraI=
Subject: FAILED: patch "[PATCH] smb: client: validate POSIX create context length" failed to apply to 5.10-stable tree
To: zihanx@nebusec.ai,pc@manguebit.org,root@tr0jan.top,sorenson@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:51:35 +0200
Message-ID: <2026092935-playhouse-remedial-7443@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fa2e9900dd2a3f5a1e7ef5a8c5e8d435feedbfcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092935-playhouse-remedial-7443@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa2e9900dd2a3f5a1e7ef5a8c5e8d435feedbfcc Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Wed, 16 Sep 2026 15:29:25 +0000
Subject: [PATCH] smb: client: validate POSIX create context length

parse_posix_ctxt() reads the fixed nlink, reparse_tag, and mode fields
before checking that the POSIX create context contains them.  A short
context can pass the generic checks and still make these fixed-width
reads run past its declared data.

The current in-tree smb2_open_file() path passes a NULL posix pointer,
so this handler is not reached on the ordinary open path.  Still require
the POSIX data to cover all three fields before reading them because the
helper performs those unguarded reads.  Keep the existing soft-failure
behavior so malformed optional metadata does not fail the open.

Fixes: 69dda3059e7a ("cifs: add SMB2_open() arg to return POSIX data")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4046500dbe93..538d708b0404 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2396,12 +2396,15 @@ static void
 parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 struct create_posix_rsp *posix)
 {
-	int sid_len;
 	u8 *beg = (u8 *)cc + le16_to_cpu(cc->DataOffset);
-	u8 *end = beg + le32_to_cpu(cc->DataLength);
+	u32 dlen = le32_to_cpu(cc->DataLength);
+	u8 *end = beg + dlen;
+	int sid_len;
 	u8 *sid;
 
 	memset(posix, 0, sizeof(*posix));
+	if (dlen < 3 * sizeof(__le32))
+		return;
 
 	posix->nlink = get_unaligned_le32(beg);
 	posix->reparse_tag = get_unaligned_le32(beg + 4);

