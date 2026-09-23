Received: from garuda.barc.gov.in (garuda.barc.gov.in [59.185.236.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FE3B6C1E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.185.236.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136608; cv=none; b=oE/WV2rp71fg3VF9FI7E/0sGFGxq5Yh/eyIADz22osEW/RJ20SSyD868HxolWW6z8IL+WmSuTDTP4Vv+etcr4Or7G99dBkOLeIFk7z3TH1ssHyODvtYFLxP0wBBgN99D5QfPe0Rrd9ewCuzjNzUgfE3WXJcAL+NiiXKqIkVQ46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136608; c=relaxed/simple;
	bh=VFkRoVgzQxm0wy32IHoejXrq1NgVwPRBe9clRBLGrL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpkIYE+7yFYoyjODEgcFbnf1KOrXh8j1DXA3huw/m1YF2k37kmyfO0rSMtkL5bbvEjSx4P9CbiGbxM5/yN3R2UHWV+f3IAxcM0H88a+jdlC/2ZI/wPVqE5+xsAkOusIf9FYClBZHoQxGDczxeDsXfsvqohoSHKQ6s/wq84XgXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barc.gov.in; spf=pass smtp.mailfrom=barc.gov.in; dkim=pass (2048-bit key) header.d=barc.gov.in header.i=@barc.gov.in header.b=iYozbQFt; arc=none smtp.client-ip=59.185.236.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barc.gov.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barc.gov.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barc.gov.in header.i=@barc.gov.in header.b="iYozbQFt"
Received: by garuda.barc.gov.in (Postfix, from userid 1002)
	id 1BCACEAE0B; Wed, 23 Sep 2026 09:33:21 +0530 (IST)
X-SenderInBARCdomain: spam
From: Subham Pal <subhampal@barc.gov.in>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barc.gov.in;
	s=barct062026; t=1790136201;
	bh=aJ3QBkDc8ObTMrcVimEpWl3cLGjtOWOqrHIZLPwWDA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iYozbQFtL73+lpa0TAcQJ02O8/4XfYn+ZPUjNHZnOv7FHwy45zfceMH8ntqOICyzb
	 SPNcT42/iahJNP4KfC8B1RBpBSMCxUIBjnsFTlzbw4tK1Bx3HkB3qrd4qFOGoEh3+w
	 E18KQhfhkz2/dobMpdGySGbkvtixAL5rB2sFobcaB4Xrj2IG+EGFGeLYR+MKBxwfPO
	 CavTgXRGvOMO3JTmzYYUzWEDiVnkDRdyT96nJ2lsJsPg/gMzeZSnDmCen31EmO/HWI
	 RlVe6ohMJIPnZmLjL1iIUQIdsW4x+Kgd+t6w/Rs53XOG42bYCKUL3cHbzTl06BPmhW
	 0XZ/lI5lk8FNw==
To: subhampal@barc.gov.in
Cc: Subham Pal <subhampal789@gmail.com>, stable@vger.kernel.org
Subject: [PATCH net 2/2] netfilter: nf_conntrack_h323: check extension bitmap before decoding components
Date: Wed, 23 Sep 2026 09:33:13 +0530
Message-ID: <20260923040313.5921-3-subhampal@barc.gov.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923040313.5921-1-subhampal@barc.gov.in>
References: <20260923040313.5921-1-subhampal@barc.gov.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79
X-BARC-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 68N43F3u017364
X-BARC-MailScanner: Found to be clean
X-BARC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-99.01, required 6, BODY_RULE_1 1.00,
	USER_IN_WELCOMELIST -0.01, USER_IN_WHITELIST -100.00)
X-BARC-MailScanner-From: subhampal@barc.gov.in

From: Subham Pal <subhampal789@gmail.com>

In decode_seq(), the extension components loop iterates through bmp2_len
bits. However, it evaluates whether the component index exceeds the known
upper bound (`i >= f->ub`) and whether it contains a STOP attribute before
checking if the field is actually present in `bmp2`:

    if (i >= f->ub) {
        ...
        len = get_len(bs);
        ...
    }
    if (son->attr & STOP)
        return H323_ERROR_STOP;

    if (!((0x80000000 >> opt) & bmp2))
        continue;

If an unknown extension is marked absent in the bitmap (`bit == 0`), the
parser erroneously attempts to read a non-existent open type length from
the bitstream and advances `bs->cur` by garbage bytes. Furthermore, if a
known field has the STOP attribute but is absent from the transmission,
decoding aborts prematurely.

Move the presence bitmap check to the beginning of the loop body so absent
extensions are skipped immediately before attempting to decode or inspect
attributes. Also append a 'U' suffix to 0x80000000 to prevent signed shift
overflow.

Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
Cc: stable@vger.kernel.org
Signed-off-by: Subham Pal <subhampal789@gmail.com>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 6830c9da3507..57317a28212b 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -596,6 +596,9 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 
 	/* Decode the extension components */
 	for (opt = 0; opt < bmp2_len; opt++, i++, son++) {
+		if (!((0x80000000U >> opt) & bmp2))	/* Not present */
+			continue;
+
 		/* Check Range */
 		if (i >= f->ub) {	/* Newer Version? */
 			if (nf_h323_error_boundary(bs, 2, 0))
@@ -613,9 +616,6 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 			return H323_ERROR_STOP;
 		}
 
-		if (!((0x80000000 >> opt) & bmp2))	/* Not present */
-			continue;
-
 		if (nf_h323_error_boundary(bs, 2, 0))
 			return H323_ERROR_BOUND;
 		len = get_len(bs);
-- 
2.43.0

